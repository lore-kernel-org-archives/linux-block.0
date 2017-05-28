Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25016 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdE1QBx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 May 2017 12:01:53 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 0/8] blk-mq: fix & improve queue quiescing
Date: Sun, 28 May 2017 16:01:13 +0000
Message-ID: <1495987272.2849.1.camel@sandisk.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
         <1495920721.13651.0.camel@sandisk.com> <20170528111105.GD6488@ming.t460p>
In-Reply-To: <20170528111105.GD6488@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE3LTA1LTI4IGF0IDE5OjExICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
U2F0LCBNYXkgMjcsIDIwMTcgYXQgMDk6MzI6MDJQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIFNhdCwgMjAxNy0wNS0yNyBhdCAyMjoyMSArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBUaGVyZSBhcmUgc29tZSBpc3N1ZXMgaW4gY3VycmVudCBibGtfbXFfcXVpZXNj
ZV9xdWV1ZSgpOg0KPiA+ID4gDQo+ID4gPiAgICAgLSBpbiBjYXNlIG9mIGRpcmVjdCBpc3N1ZSBv
ciBCTEtfTVFfU19TVEFSVF9PTl9SVU4sIGRpc3BhdGNoIHdvbid0DQo+ID4gPiAgICAgYmUgcHJl
dmVudGVkIGFmdGVyIGJsa19tcV9xdWllc2NlX3F1ZXVlKCkgaXMgcmV0dXJuZWQuDQo+ID4gPiAg
ICAgLSBpbiB0aGVvcnksIG5ldyBSQ1UgcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb25zIG1heSBi
ZWdpbiB3aGlsZQ0KPiA+ID4gICAgIHN5bmNocm9uaXplX3JjdSgpIHdhcyB3YWl0aW5nLCBhbmQg
ZW5kIGFmdGVyIHJldHVybmluZyBmcm9tIA0KPiA+ID4gICAgIHN5bmNocm9uaXplX3JjdSgpLCB0
aGVuIGRpc3BhdGNoIHN0aWxsIG1heSBiZSBydW4gYWZ0ZXINCj4gPiA+ICAgICBzeW5jaHJvbml6
ZV9yY3UoKSByZXR1cm5zDQo+ID4gDQo+ID4gSSBkaXNhZ3JlZSB3aXRoIHRoZSBzZWNvbmQgcGFy
dCBvZiB5b3VyIHN0YXRlbWVudC4gYmxrX21xX3F1aWVzY2VfcXVldWUoKQ0KPiANCj4gWW91IGNh
biBmaW5kIHRoZSBzaW1pbGFyIGRlc2NyaXB0aW9uIGZyb20gbGluZSAxNTggdG8gbGluZSAxODAu
DQo+IG9mIERvY3VtZW50YXRpb24vUkNVL3doYXRpc1JDVS50eHQuDQo+IA0KPiBGb3IgZXhhbXBs
ZSwgdGhlcmUgbWF5IGJlIHNjaGVkdWxlIHByZWVtcHQgb3IgaXJxIGhhbmRsaW5nIGJldHdlZW4N
Cj4gY2hlY2tpbmcgc3RvcHBlZCBmbGFnKGZhbHNlKSBhbmQgdGhlIFJDVSByZWFkLXNpZGUgY3Jp
dGljYWwgc2VjdGlvbnMsIGFuZA0KPiBzeW5jaHJvbml6ZV8qcmN1KCkgbWF5IHJldHVybiBiZWZv
cmUgcnVubmluZyB0aGlzIFJDVSByZWFkLXNpZGUgY3JpdGljYWwNCj4gc2VjdGlvbnMuIFRoYXQg
aXMgd2h5IHdlIGhhdmUgdG8gbW92ZSB0aGUgY2hlY2sgaW50byBSQ1UgcmVhZC1zaWRlDQo+IGNy
aXRpY2FsIHNlY3Rpb25zLg0KDQpIZWxsbyBNaW5nLA0KDQpIYXZlIHlvdSBub3RpY2VkIHRoYXQg
aW4gdGhlIGN1cnJlbnQgYmxrLW1xIGNvZGUgdGhlIHRlc3Qgb2YgdGhlIGhjdHgNCnN0b3BwZWQg
ZmxhZyBhbHJlYWR5IG9jY3VycyAqaW5zaWRlKiBhbiBSQ1UgcmVhZC1zaWRlIGNyaXRpY2FsIHNl
Y3Rpb24/DQpfX2Jsa19tcV9ydW5faHdfcXVldWUoKSBncmFicyBhbiBSQ1UgcmVhZCBsb2NrIGJl
Zm9yZQ0KYmxrX21xX3NjaGVkX2Rpc3BhdGNoX3JlcXVlc3RzKCkgY2FsbHMgYmxrX21xX2hjdHhf
c3RvcHBlZCgpLg0KDQpCYXJ0Lg==
