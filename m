Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22993 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753477AbeB0O52 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 09:57:28 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [bug report] Don't enter SCSI error handler on kernel 4.16-rc1
Date: Tue, 27 Feb 2018 14:57:24 +0000
Message-ID: <1519743443.21815.2.camel@wdc.com>
References: <e8bba22c-a02b-f449-c67a-d4a7ae8482df@hisilicon.com>
         <1519658706.3975.2.camel@wdc.com>
         <75f77913-41a7-98fd-f4a1-0301ff4d6e2b@hisilicon.com>
In-Reply-To: <75f77913-41a7-98fd-f4a1-0301ff4d6e2b@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE4LTAyLTI3IGF0IDE1OjA5ICswODAwLCBjaGVueGlhbmcgKE0pIHdyb3RlOg0K
PiDlnKggMjAxOC8yLzI2IDIzOjI1LCBCYXJ0IFZhbiBBc3NjaGUg5YaZ6YGTOg0KPiA+IE9uIE1v
biwgMjAxOC0wMi0yNiBhdCAxNzozNyArMDgwMCwgY2hlbnhpYW5nIChNKSB3cm90ZToNCj4gPiA+
IFdoZW4gaSBoYXZlIGEgdGVzdCBvbiBrZXJuZWwgNC4xNi1yYzEsIGZpbmQgYSBpc3N1ZTogcnVu
bmluZyBJTyBvbiBTQVRBIGRpc2ssIHRoZW4gZGlzYWJsZSB0aGUgZGlzayB0aHJvdWdoDQo+ID4g
PiBzeXNmcyBpbnRlcmZhY2UoZWNobyAwID4gL3N5cy9jbGFzcy9zYXNfcGh5L3BoeS0xOjA6MC9l
bmFibGUpLCBJTyB3aWxsIGhhbmcgYW5kIG5ldmVyIGVudGVyIFNDU0kgRUguIFRoZSBpc3N1ZQ0K
PiA+ID4gYXBwZWFycyBldmVyeSB0aW1lLg0KPiA+ID4gDQo+ID4gPiBJIGFkZCBzb21lIHByaW50
cyBvbiBjb2RlIGFuZCBmaW5kIHRoYXQgIHRob3NlIElPcyB3aWxsIGJlIHRpbWVvdXQgYWZ0ZXIg
MzBzLCBhbmQgdGhleSBhbGwgZW50ZXINCj4gPiA+IGZ1bmN0aW9uIHNjc2lfZWhfc2NtZF9hZGQs
IGJ1dCBvbmx5IHNvbWUgb2YgdGhlbSBjYW4gZW50ZXIgZnVuY3Rpb24gc2NzaV9laF9pbmNfaG9z
dF9mYWlsZWQuIFNvIGl0IHdpbGwgbmV2ZXINCj4gPiA+IGVudGVyIFNDU0kgRUguICBJIHN1c3Bl
Y3QgaXQgaXMgcmVsYXRlZCB0byB0aGUgcGF0Y2ggKCJjb21taXQgM2JkNmY0M2Y1Y2IzNzEiIHNj
c2k6IGNvcmU6IEVuc3VyZSB0aGF0IHRoZQ0KPiA+ID4gU0NTSSBlcnJvciBoYW5kbGVyIGdldHMg
d29rZW4gdXAgKS4gUGxlYXNlIGhhdmUgYSBjaGVjay4NCj4gPiANCj4gPiBIZWxsbyBjaGVueGlh
bmcsDQo+ID4gDQo+ID4gSGFkIHlvdSBhbHJlYWR5IG5vdGljZWQgcGF0Y2ggIltQQVRDSCB2Ml0g
QXZvaWQgdGhhdCBBVEEgZXJyb3IgaGFuZGxpbmcgY2FuDQo+ID4gdHJpZ2dlciBhIGtlcm5lbCBo
YW5nIG9yIG9vcHMiPyBJZiBub3QsIGNhbiB5b3UgYXBwbHkgdGhhdCBwYXRjaCB0byB5b3VyDQo+
ID4ga2VybmVsIGFuZCB2ZXJpZnkgd2hldGhlciBpdCBmaXhlcyB0aGlzIGJlaGF2aW9yPyBTZWUg
YWxzbw0KPiA+IGh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vbGludXgtc2NzaUB2Z2VyLmtl
cm5lbC5vcmcvbXNnNzExODkuaHRtbCBvcg0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcGF0Y2gvMTAyMzYyMTMvLg0KPiANCj4gQWZ0ZXIgYXBwbGllZCB5b3VyIHBhdGNoLCB0aGUg
aXNzdWUgaSByZXBvcnRlZCBzZWVtcyBiZSBzb2x2ZWQuDQoNClRoYW5rcyBmb3IgaGF2aW5nIHRl
c3RpbmcgdGhhdCBwYXRjaCENCg0KPiBCdXQgd2hlbiBpIGhhdmUgbG9uZyB0aW1lIHRlc3QoZGlz
YWJsZS9lbmFibGUgZGlzayB3aGVuIHJ1bm5pbmcgSU8pIG9uIA0KPiB0aGUgdGVzdGNhc2UsIE51
bGwgcG9pbnRlciBvY2N1cnMuDQo+IEl0IHNlZW1zIG5vdCByZWxhdGVkIHRvIGN1cnJlbnQgaXNz
dWUgYnV0IGkgYW0gbm90IHN1cmUuDQo+IEkgcmFuIHRoZSB0ZXN0Y2FzZSBmb3IgbG9uZyB0aW1l
IGJlZm9yZSBpbiBrZXJuZWwgNC4xNS1yYzUsIGFuZCBpdCB3YXMgb2theS4NCj4gDQo+IFBhcnQg
b2YgbG9nIGlzIGFzIGZvbGxvd3MsIGFuZCBpIGFkZCBhdHRhY2htZW50IG9mIGxvZyBpbiB0aGUg
ZW1haWwgOg0KPiANCj4gWyAgNDg1LjcxNjU3OF0gcGMgOiBibGtfYWJvcnRfcmVxdWVzdCsweDE0
LzB4NjgNCg0KKCtUZWp1bikNCg0KSGVsbG8gY2hlbnhpYW5nLA0KDQpQbGVhc2UgY2hlY2sgd2hl
dGhlciB0aGUgZm9sbG93aW5nIHBhdGNoIGZpeGVzIHRoZSBrZXJuZWwgY3Jhc2ggeW91IHJhbiBp
bnRvOg0KDQpodHRwczovL21hcmMuaW5mby8/bD1saW51eC1ibG9jayZtPTE1MTg5NTk1MTIwNzAx
NA0KDQpUaGFua3MsDQoNCkJhcnQu
