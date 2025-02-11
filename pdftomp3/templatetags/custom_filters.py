from django import template

register = template.Library()

@register.filter
def truncate_words(value, arg=8):
    if len(value) > 1:
        return value[:arg] + "..."
    return value
