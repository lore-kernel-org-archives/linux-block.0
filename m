Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52387 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdLAQIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Dec 2017 11:08:51 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "mauricfo@linux.vnet.ibm.com" <mauricfo@linux.vnet.ibm.com>,
        "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>,
        "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH V2 0/2] block: fix queue freeze and cleanup
Date: Fri, 1 Dec 2017 16:08:49 +0000
Message-ID: <1512144528.2520.2.camel@sandisk.com>
References: <20171123044800.25251-1-ming.lei@redhat.com>
         <20171127124147.GA16095@ming.t460p>
         <fb185d60-9489-d841-c86d-07de5e5f561d@hisilicon.com>
         <fcc89b28-41f9-ecdc-438b-b593f09866c9@linux.vnet.ibm.com>
In-Reply-To: <fcc89b28-41f9-ecdc-438b-b593f09866c9@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE3LTEyLTAxIGF0IDEzOjM2IC0wMjAwLCBNYXVyaWNpbyBGYXJpYSBkZSBPbGl2
ZWlyYSB3cm90ZToNCj4gT24gMTEvMjkvMjAxNyAxMjo1NyBBTSwgY2hlbnhpYW5nIChNKSB3cm90
ZToNCj4gPiBJIGFwcGxpZWQgdGhpcyB2MiBwYXRjaHNldCB0byBrZXJuZWwgNC4xNS1yYzEsIHJ1
bm5pbmcgZmlvIG9uIGEgU0FUQSANCj4gPiBkaXNrLCB0aGVuIGRpc2FibGUgdGhlIGRpc2sgd2l0
aCBzeXNmcyBpbnRlcmZhY2UNCj4gPiAoZWNobyAwID4gL3N5cy9jbGFzcy9zYXNfcGh5L3BoeS0x
OjA6MS9lbmFibGUpLCBhbmQgZmluZCBzeXN0ZW0gaXMgaHVuZy4gDQo+ID4gQnV0IHdpdGggdjEg
cGF0Y2gsIGl0IGRvZXNuJ3QNCj4gPiBoYXMgdGhpcyBpc3N1ZS4gUGxlYXNlIGhhdmUgYSBjaGVj
ay4NCj4gDQo+IEluZGVlZCwgd2l0aCB0aGlzIHBhcnRpY3VsYXIgdGVzdC1jYXNlICh0aGFua3Ms
IGNoZW54aWFuZykgdGhlIHByb2JsZW0NCj4gY2FuIGJlIHJlY3JlYXRlZCB3aXRoIFBBVENIIHYy
IGJ1dCBfbm90XyB3aXRoIHYxLg0KPiANCj4gRm9yIHJlZmVyZW5jZSwgSSdtIGluY2x1ZGluZyB0
aGUgdGVzdHMgd2l0aCB2MiBpbiB0aGlzIGUtbWFpbC4NCj4gVGhlIHNhbWUgdGVzdHMgaGF2ZSB0
b28gYmVlbiBwZXJmb3JtZWQgd2l0aCB2MSwgd2l0aG91dCBibG9ja2VkIHRhc2tzLg0KPiANCj4g
SW50ZXJlc3RpbmdseSwgcGh5c2ljYWwgZGlzayBwdWxscyBkaWQgbm90IGhpdCB0aGUgcHJvYmxl
bSBlaXRoZXINCj4gb24gdjEgb3IgdjIgKGJ1dCBpdCBkb2VzIG5vdCBtYXR0ZXIgYW55bW9yZSkg
LS0gc28gdjEgaXMgdGhlIG9uZS4NCg0KVGhlIHRlc3QgY2hlbnhpYW5nIHJhbiBkb2VzIG5vdCBw
cm92ZSB0aGF0IHRoZXJlIGlzIGFueXRoaW5nIHdyb25nIHdpdGggdjIuDQpNYXliZSBjaGVueGlh
bmcgaGl0IHRoZSBpc3N1ZSBkZXNjcmliZWQgaW4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTcv
OS81LzM4MT8NCg0KQmFydC4=
