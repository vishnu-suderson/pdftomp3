from django import template

register = template.Library()

@register.filter
def truncate_words(value, arg=2):
    words = value.split()
    if len(words) > 1:
        return ' '.join(words[:arg]) + "..."
    return value
