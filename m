Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26388 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdHXPE7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 11:04:59 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report] skd: Avoid that module unloading triggers a
 use-after-free
Date: Thu, 24 Aug 2017 15:04:12 +0000
Message-ID: <1503587051.2702.1.camel@wdc.com>
References: <20170824110412.uh27qkhutnrid7ji@mwanda>
In-Reply-To: <20170824110412.uh27qkhutnrid7ji@mwanda>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE3LTA4LTI0IGF0IDE0OjA0ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBIZWxsbyBCYXJ0IFZhbiBBc3NjaGUsDQo+IA0KPiBUaGlzIGlzIGEgc2VtaS1hdXRvbWF0aWMg
ZW1haWwgYWJvdXQgbmV3IHN0YXRpYyBjaGVja2VyIHdhcm5pbmdzLg0KPiANCj4gVGhlIHBhdGNo
IDcyNzdjYzY3YjM5MTogInNrZDogQXZvaWQgdGhhdCBtb2R1bGUgdW5sb2FkaW5nIHRyaWdnZXJz
IGEgDQo+IHVzZS1hZnRlci1mcmVlIiBmcm9tIEF1ZyAxNywgMjAxNywgbGVhZHMgdG8gdGhlIGZv
bGxvd2luZyBTbWF0Y2ggDQo+IGNvbXBsYWludDoNCj4gDQo+IGRyaXZlcnMvYmxvY2svc2tkX21h
aW4uYzozMDgwIHNrZF9mcmVlX2Rpc2soKQ0KPiAJIGVycm9yOiB3ZSBwcmV2aW91c2x5IGFzc3Vt
ZWQgJ2Rpc2snIGNvdWxkIGJlIG51bGwgKHNlZSBsaW5lIDMwNzQpDQo+IA0KPiBkcml2ZXJzL2Js
b2NrL3NrZF9tYWluLmMNCj4gICAzMDczCQ0KPiAgIDMwNzQJCWlmIChkaXNrICYmIChkaXNrLT5m
bGFncyAmIEdFTkhEX0ZMX1VQKSkNCj4gICAgICAgICAgICAgICAgICAgICBeXl5eDQo+IEV4aXN0
aW5nIGNvZGUgY2hlY2tlZCBmb3IgTlVMTC4gIFRoZSBuZXcgY29kZSBzaHVmZmxlcyB0aGluZ3Mg
YXJvdW5kLg0KPiANCj4gICAzMDc1CQkJZGVsX2dlbmRpc2soZGlzayk7DQo+ICAgMzA3NgkNCj4g
ICAzMDc3CQlpZiAoc2tkZXYtPnF1ZXVlKSB7DQo+ICAgMzA3OAkJCWJsa19jbGVhbnVwX3F1ZXVl
KHNrZGV2LT5xdWV1ZSk7DQo+ICAgMzA3OQkJCXNrZGV2LT5xdWV1ZSA9IE5VTEw7DQo+ICAgMzA4
MAkJCWRpc2stPnF1ZXVlID0gTlVMTDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl5e
Xl5eXl4NCj4gTm93IHdlIGRvbid0IGNoZWNrIGhlcmUuDQo+IA0KPiAgIDMwODEJCX0NCj4gICAz
MDgyCQ0KPiANCj4gcmVnYXJkcywNCj4gZGFuIGNhcnBlbnRlcg0KDQpIZWxsbyBEYW4sDQoNCklm
IHlvdSBoYXZlIGEgbG9vayBhdCBza2RfY29uc19kaXNrKCkgeW91IHdpbGwgc2VlIHRoYXQgc2tk
ZXYtPnF1ZXVlICE9IE5VTEwNCmltcGxpZXMgdGhhdCBza2Rldi0+ZGlzayAhPSBOVUxMLiBTbyBJ
IHRoaW5rIHRoZSBhYm92ZSByZXBvcnQgaXMgYSBmYWxzZQ0KcG9zaXRpdmUuDQoNCkJhcnQu
