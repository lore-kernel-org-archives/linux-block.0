Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27961 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdE0Vta (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 May 2017 17:49:30 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH v2 6/8] blk-mq: don't stop queue for quiescing
Date: Sat, 27 May 2017 21:49:27 +0000
Message-ID: <1495921766.13651.4.camel@sandisk.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
         <20170527142126.26079-7-ming.lei@redhat.com>
In-Reply-To: <20170527142126.26079-7-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA1LTI3IGF0IDIyOjIxICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gZGlm
ZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMNCj4gaW5kZXggMDMyMDQ1
ODQxODU2Li44NGNjZTY3Y2FlZTMgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2Jsay1tcS5jDQo+ICsr
KyBiL2Jsb2NrL2Jsay1tcS5jDQo+IEBAIC0xNjgsOCArMTY4LDYgQEAgdm9pZCBibGtfbXFfcXVp
ZXNjZV9xdWV1ZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkNCj4gIAl1bnNpZ25lZCBpbnQgaTsN
Cj4gIAlib29sIHJjdSA9IGZhbHNlOw0KPiAgDQo+IC0JX19ibGtfbXFfc3RvcF9od19xdWV1ZXMo
cSwgdHJ1ZSk7DQo+IC0NCj4gIAlzcGluX2xvY2tfaXJxKHEtPnF1ZXVlX2xvY2spOw0KPiAgCXF1
ZXVlX2ZsYWdfc2V0KFFVRVVFX0ZMQUdfUVVJRVNDRUQsIHEpOw0KPiAgCXNwaW5fdW5sb2NrX2ly
cShxLT5xdWV1ZV9sb2NrKTsNCj4gQEAgLTE5OCw3ICsxOTYsMTIgQEAgdm9pZCBibGtfbXFfdW5x
dWllc2NlX3F1ZXVlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQ0KPiAgCXF1ZXVlX2ZsYWdfY2xl
YXIoUVVFVUVfRkxBR19RVUlFU0NFRCwgcSk7DQo+ICAJc3Bpbl91bmxvY2tfaXJxKHEtPnF1ZXVl
X2xvY2spOw0KPiAgDQo+IC0JYmxrX21xX3N0YXJ0X3N0b3BwZWRfaHdfcXVldWVzKHEsIHRydWUp
Ow0KPiArCS8qDQo+ICsJICogRHVyaW5nIHF1aWVzY2luZywgcmVxdWVzdHMgY2FuIGJlIGluc2Vy
dGVkDQo+ICsJICogdG8gc2NoZWR1bGVyJ3MgcXVldWUgb3Igc3cgcXVldWUsIHNvIHdlIHJ1bg0K
PiArCSAqIHF1ZXVlcyBmb3IgZGlzcGF0Y2hpbmcgdGhlc2UgcmVxdWVzdHMuDQo+ICsJICovDQo+
ICsJYmxrX21xX3N0YXJ0X2h3X3F1ZXVlcyhxKTsNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BM
KGJsa19tcV91bnF1aWVzY2VfcXVldWUpOw0KDQpIZWxsbyBNaW5nLA0KDQpUaGlzIGxvb2tzIHJl
YWxseSB3ZWlyZCB0byBtZS4gSWYgYmxrX21xX3F1aWVzY2VfcXVldWUoKSBkb2Vzbid0IHN0b3Ag
YW55DQpoYXJkd2FyZSBxdWV1ZXMsIHdoeSBzaG91bGQgYmxrX21xX3VucXVpZXNjZV9xdWV1ZSgp
IHN0YXJ0IGFueSBoYXJkd2FyZQ0KcXVldWVzPw0KDQpCYXJ0Lg==
