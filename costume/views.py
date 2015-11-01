import arrow
from django.shortcuts import render, redirect, get_object_or_404, Http404
from django.http import JsonResponse
from models import *


def home(request):
    mine = Card.objects.filter()
    if False and request.method == 'POST':
        text = request.POST.get('text').strip()
        if Card.objects.filter(text=text).count() == 0:
            Card.objects.create(text=text, session_id=request.session.session_key)
        return redirect("/")
    return render(request, "home.html", locals())


def reset(request):
    if request.user.is_superuser:
        for card in Card.objects.all():
            card.used = None
            card.order = None
            card.save()
    return redirect('/')


def delete(request, id):
    card = get_object_or_404(Card, id=id)
    try:
        if request.user.is_superuser or card.session.id == request.session.session_key:
            card.delete()
            return redirect('/')
    except:
        pass
    raise Http404


def cards(request):
    cards = list( Card.objects.exclude(used__isnull=True) )
    
    if not cards or arrow.get(cards[-1].used) < arrow.now().replace(minutes=-5) or request.GET.get('force', '').lower() in ('yes', 'true', 'on'):
        try:
            new_card = Card.objects.filter(used__isnull=True).order_by('?')[0]
        except IndexError:
            pass
        else:
            new_card.used = arrow.now().datetime
            new_card.order = len(cards)
            new_card.save()
            cards.append(new_card)

    return JsonResponse({
        'cards': [c.text for c in cards]
    })