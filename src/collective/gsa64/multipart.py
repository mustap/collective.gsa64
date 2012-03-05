import mimetypes


def post_multipart(h, selector, fields, files):
    content_type, body = encode_multipart_formdata(fields, files)
    h.putrequest('POST', selector)
    h.putheader('content-type', content_type)
    h.putheader('content-length', str(len(body)))
    h.endheaders()
    h.send(body.encode('utf-8'))
    errcode, errmsg, headers = h.getreply()
    if errcode != -1:
        return h.file.read()

def encode_multipart_formdata(fields, files):
    """
    Create data in multipart/form-data encoding
    """
    BOUNDARY = u'----------boundary_of_feed_data$'
    CRLF = u'\r\n'
    L = []
    for (key, value) in fields:
        L.append(u'--' + BOUNDARY)
        L.append(u'Content-Disposition: form-data; name="%s"' % key)
        L.append(u'')
        L.append(value)
    for (key, filename, value) in files:
        L.append(u'--' + BOUNDARY)
        L.append(u'Content-Disposition: form-data; name="%s"; filename="%s"' % (key, filename))
        L.append(u'Content-Type: text/xml')
        L.append(u'')
        L.append(value)
    L.append(u'--' + BOUNDARY + u'--')
    L.append(u'')
    body = CRLF.join(L)
    content_type = u'multipart/form-data; boundary=%s' % BOUNDARY
    return content_type, body
