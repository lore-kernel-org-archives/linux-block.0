Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22478 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeCPPAe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Mar 2018 11:00:34 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "colyli@suse.de" <colyli@suse.de>,
        "mlyle@lyle.org" <mlyle@lyle.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 15/16] bcache: Fix an endianness bug
Date: Fri, 16 Mar 2018 15:00:32 +0000
Message-ID: <1521212430.5384.1.camel@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
         <20180315150814.9412-16-bart.vanassche@wdc.com>
         <6b2b29bb-f26b-2df9-3609-26100cc1c9a5@suse.de>
In-Reply-To: <6b2b29bb-f26b-2df9-3609-26100cc1c9a5@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE4LTAzLTE2IGF0IDEyOjQ3ICswODAwLCBDb2x5IExpIHdyb3RlOg0KPiBUaGUg
Y29kZSBzdGlsbCBkb2VzIG5vdCB3b3JrIHdpdGggeW91ciBwYXRjaCBvbiBiaWcgZW5kaWFuIG1h
Y2hpbmUgKGUuZy4NCj4gczM5MHgpLiBXaGVuIEkgZml4IHRoZSBiY2FjaGUgczM5MHggYnVnLCBJ
IGRpZCBzb21ldGhpbmcgbGlrZSB0aGlzIHBhdGNoDQo+IGluIG15IGZpcnN0IHRyeS4gSXQgdHVy
bnMgb3V0IG1vcmUgdGhpbmdzIG5lZWQgdG8gYmUgZml4ZWQsDQo+IDEsIHNvbWUgY2FjaGVfc2Ig
bWVtYmVycyBvbmx5IHN3YXBwZWQgdG8gY3B1IGVuZGlhbm5lc3Mgd2hlbiByZWFkIGluLA0KPiBu
b3Qgc3dhcHBlZCB0byBsaXR0bGUgZW5kaWFuIHdoZW4gd3JpdGUgb3V0LiBGb3IgZXhhbXBsZSBk
YXRhX29mZnNldCwNCj4gbmJ1Y2tldHMsIG5yX2luX3NldCwgbnJfdGhpc19kZXYgLi4uDQo+IDIs
IGNoZWNrc3VtIGlzIGNhbGN1bGF0ZWQgaW4gY3B1IGVuZGlhbm5uZXNzLCBub3QgZXhwbGljaXRs
eSBpbiBsaXR0bGUNCj4gZW5kaWFuLg0KPiANCj4gQWxzbyB1c2VyIHNwYWNlIHRvb2xzIG5lZWQg
dG8gdXBkYXRlIHRvIHN1cHBvcnQgdGhlIGVuZGlhbm5lc3MgaXNzdWUuDQo+IA0KPiBIb3cgYWJv
dXQgbGVhdmUgdGhlIGVuZGlhbm5lc3MgcHJvYmxlbSB0byBtZT8gSSB3aWxsIHBpY2sgY29kZSBw
aWVjZQ0KPiBmcm9tIHlvdXIgcGF0Y2ggYW5kIHNldCAnRnJvbTogQmFydCBWYW4gQXNzY2hlIDxi
YXJ0LnZhbmFzc2NoZUB3ZGMuY29tPicNCj4gb24gdGhlIHBhdGNoKHMpLCBhbmQgY29udGludWUg
bXkgZml4IGZvciBiY2FjaGUgb24gczM5MHguDQoNCkhlbGxvIENvbHksDQoNClRoYXQgc291bmRz
IGZpbmUgdG8gbWUuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugd291bGQgbGlrZSBtZSB0byBy
ZXBvc3QNCnRoaXMgc2VyaWVzIGFuZC9vciBhZGRyZXNzIHRoZSBmZWVkYmFjayB0aGF0IEkgcmVj
ZWl2ZWQgZm9yIHRoaXMgcGF0Y2ggc2VyaWVzLg0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0K
