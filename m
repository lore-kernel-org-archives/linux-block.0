Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6846 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdCRPaS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2017 11:30:18 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "lsf@lists.linux-foundation.org" <lsf@lists.linux-foundation.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [Lsf] [RFC PATCH 0/4] blk-mq: multiqueue I/O scheduler
Date: Sat, 18 Mar 2017 15:30:09 +0000
Message-ID: <1489850994.2339.5.camel@sandisk.com>
References: <cover.1489787289.git.osandov@fb.com>
         <46f16799-86d9-7bf5-6346-be08801dd48e@suse.de>
In-Reply-To: <46f16799-86d9-7bf5-6346-be08801dd48e@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTAzLTE4IGF0IDEyOjE0ICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6
DQo+IE9uIDAzLzE3LzIwMTcgMTE6MDMgUE0sIE9tYXIgU2FuZG92YWwgd3JvdGU6DQo+ID4gRnJv
bTogT21hciBTYW5kb3ZhbCA8b3NhbmRvdkBmYi5jb20+DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBz
ZXJpZXMgaW1wbGVtZW50cyBhbiBJL08gc2NoZWR1bGVyIGZvciBtdWx0aXF1ZXVlIGRldmljZXMN
Cj4gPiBjb21iaW5pbmcgc2V2ZXJhbCB0ZWNobmlxdWVzOiB0aGUgc2NhbGFibGUgYml0bWFwIGxp
YnJhcnksIHRoZSBuZXcNCj4gPiBibGstc3RhdHMgQVBJLCBhbmQgcXVldWUgZGVwdGggdGhyb3R0
bGluZyBzaW1pbGFyIHRvIGJsay13YnQuDQo+ID4gDQo+ID4gVGhlc2UgcGF0Y2hlcyBhcmUgb24g
dG9wIG9mIG15IGVhcmxpZXIgYmxrLXN0YXRzIHNlcmllcyBbMV0uIFRoZXkgYWxzbw0KPiA+IG5l
ZWQgYSBmaXggaW4gSmVucycgZm9yLWxpbnVzIGJyYW5jaCBpbiBvcmRlciB0byB3b3JrIHByb3Bl
cmx5IFsyXS4NCj4gPiANCj4gPiBQYXRjaGVzIDEgYW5kIDIgaW1wbGVtZW50IGEgbmV3IHNiaXRt
YXAgb3BlcmF0aW9uIGFuZCBwYXRjaCAzIGV4cG9ydHMgYQ0KPiA+IHJlcXVpcmVkIGZ1bmN0aW9u
LiBQYXRjaCA0IGltcGxlbWVudHMgdGhlIG5ldyBzY2hlZHVsZXIsIG5hbWVkIEt5YmVyLg0KPiA+
IA0KPiA+IFRoZSBjb21taXQgbWVzc2FnZSBpbiBwYXRjaCA0IGRlc2NyaWJlcyBLeWJlciBpbiBk
ZXRhaWwuIFRoZSBzY2hlZHVsZXINCj4gPiBlbXBsb3lzIHNvbWUgaGV1cmlzdGljcyB0aGF0IEkn
dmUgZXhwZXJpbWVudGVkIHdpdGgsIGJ1dCB0aGF0J3MgcHJvYmFibHkNCj4gPiB0aGUgYXJlYSB0
aGF0IG5lZWRzIHRoZSBtb3N0IHdvcmsuIEknbGwgYmUgYXQgTFNGL01NIG5leHQgd2VlaywgYW5k
DQo+ID4gdGhlcmUncyBjdXJyZW50bHkgYSBsaWdodG5pbmcgdGFsayBvbiB0aGUgc2NoZWR1bGUg
dG8gZGlzY3Vzcw0KPiA+IGltcHJvdmVtZW50cyBhbmQgZXh0ZW5zaW9ucy4NCj4gPiANCj4gDQo+
IFsgLi4gXQ0KPiANCj4gQSBzaWxlbnQgcm91bmQgb2YgYXBwbGF1c2UgZm9yIHlvdS4NCj4gVmVy
eSBtdWNoIGFwcHJlY2lhdGVkLg0KPiANCj4gQW5kIGFjdHVhbGx5LCBJIGhhdmUgYmVlbiBsb29r
aW5nIGF0IHByb3Blcmx5IHN1cHBvcnRpbmcgaG9zdC13aWRlIHRhZw0KPiBtYXBzLCBzbyB0aGUg
Y29uY2VwdCBvZiAnc2hhbGxvdycgcXVldWUgZGVwdGggbWlnaHQgYmUgdGhlIHdheSB0byBnbyBo
ZXJlLg0KPiANCj4gQW5kIGFzIEkgaGF2ZSBzb21lIG90aGVyIHF1ZXN0aW9ucywgdG9vIChhc3Np
Z25pbmcgYSBuZXcgdGFnIG9uDQo+IHJlcXVldWU/KSBpdCBtaWdodCBiZSBhbiBpZGVhIHRvIHNw
cmVhZCB0aGlzIG91dCBpbnRvIGEgZm9ybWFsIHNlc3Npb24NCj4gYXQgTFNGLiBJZiB0aGVyZSBh
cmUgc29tZSBzbG90cyBsZWZ0LCB0aGF0IGlzLg0KDQpJZiBubyBzbG90IGNhbiBiZSBmb3VuZCwg
aG93IGFib3V0IG9yZ2FuaXppbmcgYW4gZXZlbmluZyBzZXNzaW9uIGFib3V0IHRoaXMNCm5ldyBz
Y2hlZHVsZXI/DQoNCkJhcnQu
