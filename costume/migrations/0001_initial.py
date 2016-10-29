# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('sessions', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Card',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('text', models.CharField(max_length=255)),
                ('used', models.DateTimeField(null=True, blank=True)),
                ('order', models.PositiveIntegerField(null=True, blank=True)),
                ('session', models.ForeignKey(blank=True, to='sessions.Session', null=True)),
            ],
        ),
    ]
