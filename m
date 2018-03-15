Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24611 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeCOQwS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 12:52:18 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "colyli@suse.de" <colyli@suse.de>,
        "mlyle@lyle.org" <mlyle@lyle.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 12/16] bcache: Make it easier for static analyzers to
 analyze bch_allocator_thread()
Date: Thu, 15 Mar 2018 16:52:15 +0000
Message-ID: <1521132734.2834.8.camel@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
         <20180315150814.9412-13-bart.vanassche@wdc.com>
         <bed0d218-75f8-2f6a-04f6-3e0c19563ef8@suse.de>
In-Reply-To: <bed0d218-75f8-2f6a-04f6-3e0c19563ef8@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE4LTAzLTE2IGF0IDAwOjI5ICswODAwLCBDb2x5IExpIHdyb3RlOg0KPiBPbiAx
NS8wMy8yMDE4IDExOjA4IFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gVGhpcyBwYXRj
aCBkb2VzIG5vdCBjaGFuZ2UgYW55IGZ1bmN0aW9uYWxpdHkgYnV0IGF2b2lkcyB0aGF0IHNtYXRj
aA0KPiA+IHJlcG9ydHMgdGhlIGZvbGxvd2luZzoNCj4gPiANCj4gPiBkcml2ZXJzL21kL2JjYWNo
ZS9hbGxvYy5jOjMzNDogYmNoX2FsbG9jYXRvcl90aHJlYWQoKSBlcnJvcjogdW5pbml0aWFsaXpl
ZCBzeW1ib2wgJ2J1Y2tldCcuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQmFydCBWYW4gQXNz
Y2hlIDxiYXJ0LnZhbmFzc2NoZUB3ZGMuY29tPg0KPiANCj4gSGkgQmFydCwNCj4gDQo+IFlvdXIg
Y2hhbmdlIGlzIE9LIHRvIG1lLCBidXQgdGhlIG9yaWdpbmFsIGNvZGUgc2VlbXMgT0sgdG9vLiBD
YW4gSSBzYXkNCj4gdGhpcyBpcyBhIGJ1ZyBzaG91bGQgYmUgZml4ZWQgZnJvbSBzbWF0Y2ggPw0K
DQpIZWxsbyBDb2x5LA0KDQpJdCB3b3VsZCBiZSBncmVhdCBpZiBzbWF0Y2ggd291bGQgYmUgbW9k
aWZpZWQgc3VjaCB0aGF0IGl0IGRvZXMgbm90IGNvbXBsYWluDQphYm91dCB0aGlzIGNvZGUuIEJ1
dCBJIHRoaW5rIHRoYXQgdGhpcyBwYXRjaCBkb2VzIG5vdCBvbmx5IG1ha2UgdGhlIGNvZGUNCmVh
c2llciB0byBhbmFseXplIGZvciBzdGF0aWMgYW5hbHl6ZXJzIGJ1dCBhbHNvIGZvciBodW1hbnMu
IFNvIHBsZWFzZSBldmFsdWF0ZQ0KdGhpcyBwYXRjaCBmcm9tIHRoYXQgcGVyc3BlY3RpdmUuDQoN
ClRoYW5rcywNCg0KQmFydC4NCg0KDQo=
