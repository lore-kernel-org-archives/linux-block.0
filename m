Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-cys01nam02on0079.outbound.protection.outlook.com ([104.47.37.79]:16642
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756378AbcJ1QG6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2016 12:06:58 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@fb.com" <axboe@fb.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Block layer state diagrams
Date: Fri, 28 Oct 2016 16:06:55 +0000
Message-ID: <1477670813.4062.1.camel@sandisk.com>
References: <0213e715-5d87-1110-45d5-ed48f8837842@sandisk.com>
         <865bd65b-b26e-d8e0-1b0e-ad715ea4d8d2@suse.de>
         <702a719e-d979-8a38-c434-55f607c21f40@sandisk.com>
         <aa53ddef-e359-e085-79a1-cce9ef74994a@fb.com>
In-Reply-To: <aa53ddef-e359-e085-79a1-cce9ef74994a@fb.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE2LTEwLTI4IGF0IDA5OjQ1IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biAxMC8yNy8yMDE2IDA0OjM3IFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gT24gMTAv
MjYvMjAxNiAxMDo0NSBQTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiA+ID4gT24gMTAvMjYv
MjAxNiAxMDoyMSBQTSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiA+ID4gPiBTb21lIHRpbWUg
YWdvIEkgY3JlYXRlZCB0aGUgYXR0YWNoZWQgc3RhdGUgZGlhZ3JhbXMgZm9yIG15c2VsZg0KPiA+
ID4gPiB0byBhdm9pZA0KPiA+ID4gPiB0aGF0IEkgd291bGQgaGF2ZSB0byByZXJlYWQgdGhlIGVu
dGlyZSBibG9jayBsYXllciBjb3JlIHNvdXJjZQ0KPiA+ID4gPiBjb2RlIGlmDQo+ID4gPiA+IGl0
IGhhcyBiZWVuIGEgd2hpbGUgc2luY2UgSSBoYWQgYSBsb29rIGF0IGl0LiBEbyB5b3UgdGhpbmsg
aXQNCj4gPiA+ID4gd291bGQgYmUNCj4gPiA+ID4gdXNlZnVsIHRvIGFkZCB0aGVzZSBkaWFncmFt
cyBzb21ld2hlcmUgaW4gdGhlIERvY3VtZW50YXRpb24NCj4gPiA+ID4gZGlyZWN0b3J5Pw0KPiA+
ID4gPiANCj4gPiA+IA0KPiA+ID4gQ2FuIHlvdSBhZGQgYSBzdGVwIGZvciB0aGUgbWFwcGluZyBi
ZXR3ZWVuIHNvZnR3YXJlIGFuZA0KPiA+ID4gaGFyZHdhcmUgcXVldWVzPw0KPiA+ID4gQWxzbyB0
aGUgYWN0dWFsIHN1Ym1pc3Npb24gdG8gdGhlIExMREQgKGluIHN0ZXAgJ2V4ZWN1dGluZycpDQo+
ID4gPiBjb3VsZCBkbw0KPiA+ID4gd2l0aCBhIGJpdCBtb3JlIGVtcGhhc2lzLg0KPiA+ID4gQW5k
IG1heWJlIHRoZSBmb250c2l6ZSBjb3VsZCBiZSBhIHRhZCBzbWFsbGVyOyBjdXJyZW50bHkgaXQn
cw0KPiA+ID4gaGFyZCB0bw0KPiA+ID4gZmlndXJlIG91dCB3aGljaCBsYWJlbCBnb2VzIHdoZXJl
LCBleHBlY2lhbGx5IGluIHRoZSBib3R0b20gaGFsZi4NCj4gPiANCj4gPiBUaGFua3MgSGFubmVz
IGZvciB0aGUgcmV2aWV3LiBIb3cgYWJvdXQgdGhlIGF0dGFjaGVkIHNlY29uZCB2ZXJzaW9uDQo+
ID4gb2YNCj4gPiB0aGVzZSBkaWFncmFtcz8NCj4gDQo+IEkgdGhpbmsgdGhleSBhcmUgYSBsaXR0
bGUgY29uZnVzaW5nLiBTb21lIG9mIGl0IGlzIHNwZWNpZmljIHRvIG5vbi1mcw0KPiByZXF1ZXN0
cywgeWV0IHlvdSBoYXZlIHRoZSBwbHVnZ2luZyBwYXRoIGluIHRoZXJlIGFzIHdlbGwuIFdhcyB0
aGUNCj4gaW50ZW50IHRvIGp1c3Qgc2hvdyB0aGUgUEMgcGF0aD8NCg0KSGVsbG8gSmVucywNCg0K
QXMgZmFyIGFzIEkga25vdyB0aGVyZSBpcyBubyBkb2N1bWVudGF0aW9uIHlldCBpbiB0aGUga2Vy
bmVsIHRyZWUNCihvdGhlciB0aGFuIHRoZSBibG9jayBsYXllciBzb3VyY2UgY29kZSkgb2YgaG93
IHRoZSBkaWZmZXJlbnQgYmxvY2sNCmxheWVyIGZ1bmN0aW9ucyBhZmZlY3QgdGhlIHJlcXVlc3Qg
c3RhdGUuIFNldmVyYWwga2VybmVsIGRldmVsb3BlcnMNCnNlZW0gbm90IHRvIGJlIGF3YXJlIG9m
IHdoZW4gaXQgaXMgYWxsb3dlZCB0byBjYWxsIHdoaWNoIGJsb2NrIGxheWVyDQpmdW5jdGlvbi4g
U2VlIGUuZy4gIlJlOiBbUEFUQ0ggdjIgMS8yXSBzY3NpOiBIYW5kbGUgVW5pdCBBdHRlbnRpb24g
d2hlbg0KaXNzdWluZyBTQ1NJIGNvbW1hbmQiIChodHRwOi8vd3d3LnNwaW5pY3MubmV0L2xpc3Rz
L2xpbnV4LXNjc2kvbXNnMTAwNzMNCjcuaHRtbCkgZm9yIGFuIGV4YW1wbGUuIFRoZXNlIGRpYWdy
YW1zIG1ha2UgZS5nLiBjbGVhciB3aGVuIGl0IGlzDQphbGxvd2VkIHRvIGNhbGwgYmxrX3N0YXJ0
X3JlcXVlc3QoKSBhbmQgd2hlbiB0aGF0IGl0IGlzIG5vdCBhbGxvd2VkLg0KDQpUaGFua3MsDQoN
CkJhcnQu
