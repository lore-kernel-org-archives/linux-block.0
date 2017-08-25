Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3350 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755288AbdHYVhN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 17:37:13 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 02/20] sbitmap: introduce __sbitmap_for_each_set()
Date: Fri, 25 Aug 2017 21:36:26 +0000
Message-ID: <1503696985.2680.33.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-3-ming.lei@redhat.com>
         <1503426533.2508.6.camel@wdc.com> <20170824035743.GA12966@ming.t460p>
In-Reply-To: <20170824035743.GA12966@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE3LTA4LTI0IGF0IDExOjU3ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
VHVlLCBBdWcgMjIsIDIwMTcgYXQgMDY6Mjg6NTRQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+ICogV2hldGhlciBvciBub3QgaW5kZXggPj0gc2ItPm1hcF9uci4gSSBwcm9wb3Nl
IHRvIHN0YXJ0IGl0ZXJhdGluZyBmcm9tIHRoZQ0KPiA+ICAgc3RhcnQgb2YgQHNiIGluIHRoaXMg
Y2FzZS4NCj4gDQo+IEl0IGhhcyBiZWVuIGNoZWNrZWQgYXQgdGhlIGVuZCBvZiB0aGUgbG9vcC4N
Cg0KVGhhdCdzIG5vdCBzdWZmaWNpZW50IHRvIGF2b2lkIGFuIG91dC1vZi1ib3VuZHMgYWNjZXNz
IGlmIHRoZSBzdGFydCBpbmRleCBpcw0KbGFyZ2UuIElmIF9fc2JpdG1hcF9mb3JfZWFjaF9zZXQo
KSB3b3VsZCBhY2NlcHQgdmFsdWVzIGZvciB0aGUgc3RhcnQgaW5kZXgNCmFyZ3VtZW50IHRoYXQg
cmVzdWx0IGluIGluZGV4ID49IHNiLT5tYXBfbnIgdGhlbiB0aGF0IHdpbGwgc2ltcGxpZnkgY29k
ZSB0aGF0DQphY2Nlc3NlcyBhbiBzYml0bWFwIGluIGEgcm91bmQtcm9iaW4gZmFzaGlvbi4NCg0K
PiA+IAl9DQo+ID4gDQo+ID4gCXdoaWxlICh0cnVlKSB7DQo+ID4gCQlzdHJ1Y3Qgc2JpdG1hcF93
b3JkICp3b3JkID0gJnNiLT5tYXBbaV07DQo+ID4gCQl1bnNpZ25lZCBpbnQgb2ZmOw0KPiANCj4g
TG9va3MgeW91IHJlbW92ZWQgdGhlIGNoZWNrIG9uICd3b3JkLT53b3JkJy4NCg0KWWVzLCBhbmQg
SSBkaWQgdGhhdCBvbiBwdXJwb3NlLiBJZiB0aGUgc3RhcnQgaW5kZXggcmVmZXJzIHRvIGEgd29y
ZCB0aGF0IGlzDQp6ZXJvIHRoZW4gdGhlICJpZiAod29yZC0+d29yZCkgY29udGludWU7IiBjb2Rl
IHdpbGwgY2F1c2UgdGhlIGVuZC1vZi1sb29wDQpjaGVjayB0byBiZSBza2lwcGVkIGFuZCBoZW5j
ZSB3aWxsIGNhdXNlIGFuIGluZmluaXRlIGxvb3AuDQoNCkJhcnQu
