# Generated by Django 5.0.6 on 2024-08-12 13:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("items", "0004_items_locality"),
    ]

    operations = [
        migrations.AlterField(
            model_name="items",
            name="quantity",
            field=models.PositiveIntegerField(verbose_name="Quantidades de Unidades"),
        ),
    ]
