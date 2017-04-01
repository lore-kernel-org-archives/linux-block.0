Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31796 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbdDAXaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Apr 2017 19:30:05 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] blk-mq: add random early detection I/O scheduler
Date: Sat, 1 Apr 2017 23:29:55 +0000
Message-ID: <1491089381.9734.2.camel@sandisk.com>
References: <e9c15e2066177c3efdfe6d134cf9c80b5e8f8d1b.1491076459.git.osandov@fb.com>
         <cea23aca-e7b2-f35d-f064-d5e44a479977@fb.com>
In-Reply-To: <cea23aca-e7b2-f35d-f064-d5e44a479977@fb.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA0LTAxIGF0IDE2OjA3IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biAwNC8wMS8yMDE3IDAxOjU1IFBNLCBPbWFyIFNhbmRvdmFsIHdyb3RlOg0KPiA+IEZyb206IE9t
YXIgU2FuZG92YWwgPG9zYW5kb3ZAZmIuY29tPg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggaW50cm9k
dWNlcyBhIG5ldyBJL08gc2NoZWR1bGVyIGJhc2VkIG9uIHRoZSBjbGFzc2ljIHJhbmRvbQ0KPiA+
IGVhcmx5IGRldGVjdGlvbiBhY3RpdmUgcXVldWUgbWFuYWdlbWVudCBhbGdvcml0aG0gWzFdLiBS
YW5kb20gZWFybHkNCj4gPiBkZXRlY3Rpb24gaXMgb25lIG9mIHRoZSBzaW1wbGVzdCBhbmQgbW9z
dCBzdHVkaWVkIEFRTSBhbGdvcml0aG1zIGZvcg0KPiA+IG5ldHdvcmtpbmcsIGJ1dCB1bnRpbCBu
b3csIGl0IGhhc24ndCBiZWVuIGFwcGxpZWQgdG8gZGlzayBJL08NCj4gPiBzY2hlZHVsaW5nLg0K
PiA+IA0KPiA+IFdoZW4gYXBwbGllZCB0byBuZXR3b3JrIHJvdXRlcnMsIFJFRCBwcm9iYWJpbGlz
dGljYWxseSBlaXRoZXIgbWFya3MNCj4gPiBwYWNrZXRzIHdpdGggRUNOIG9yIGRyb3BzIHRoZW0s
IGRlcGVuZGluZyBvbiB0aGUgY29uZmlndXJhdGlvbi4gV2hlbg0KPiA+IGRlYWxpbmcgd2l0aCBk
aXNrIEkvTywgUE9TSVggZG9lcyBub3QgaGF2ZSBhbnkgbWVjaGFuaXNtIHdpdGggd2hpY2ggdG8N
Cj4gPiBub3RpZnkgdGhlIGNhbGxlciB0aGF0IHRoZSBkaXNrIGlzIGNvbmdlc3RlZCwgc28gd2Ug
aW5zdGVhZCBvbmx5IHByb3ZpZGUNCj4gPiB0aGUgbGF0dGVyIHN0cmF0ZWd5LiBJbmNsdWRlZCBp
biB0aGlzIHBhdGNoIGlzIGEgbWlub3IgY2hhbmdlIHRvIHRoZQ0KPiA+IGJsay1tcSB0byBzdXBw
b3J0IHRoaXMuDQo+IA0KPiBUaGlzIGlzIGdyZWF0IHdvcmsuIElmIHdlIGNvbWJpbmUgdGhpcyB3
aXRoIGEgdGhpbiBwcm92aXNpb25pbmcgdGFyZ2V0LA0KPiB3ZSBjYW4gZXZlbiB1c2UgdGhpcyB0
byBzYXZlIHNwYWNlIG9uIHRoZSBiYWNrZW5kLiBCZXR0ZXIgbGF0ZW5jaWVzLA0KPiBBTkQgbG93
ZXIgZGlzayB1dGlsaXphdGlvbi4NCj4gDQo+IEknbSB0ZW1wdGVkIHRvIGp1c3QgcXVldWUgdGhp
cyB1cCBmb3IgdGhpcyBjeWNsZSBhbmQgbWFrZSBpdCB0aGUgZGVmYXVsdC4NCg0KSGVsbG8gSmVu
cywNCg0KRGlkIHlvdSBtZWFuIG1ha2luZyB0aGlzIHRoZSBkZWZhdWx0IHNjaGVkdWxlciBmb3Ig
U1NEcyBvbmx5IG9yIGZvciBhbGwgdHlwZXMNCm9mIGJsb2NrIGRldmljZXM/IE91ciAoV2VzdGVy
biBEaWdpdGFsKSBleHBlcmllbmNlIGlzIHRoYXQgYW55IEkvTyBzY2hlZHVsZXINCnRoYXQgbGlt
aXRzIHRoZSBxdWV1ZSBkZXB0aCByZWR1Y2VzIHRocm91Z2hwdXQgZm9yIGF0IGxlYXN0IGRhdGEt
Y2VudGVyIHN0eWxlDQp3b3JrbG9hZHMgd2hlbiB1c2luZyBoYXJkIGRpc2tzLiBUaGlzIGlzIHdo
eSBBZGFtIGlzIHdvcmtpbmcgb24gaW1wcm92aW5nIEkvTw0KcHJpb3JpdHkgc3VwcG9ydCBmb3Ig
dGhlIExpbnV4IGJsb2NrIGxheWVyLiBUaGF0IGFwcHJvYWNoIG5hbWVseSBhbGxvd3MgdG8NCnJl
ZHVjZSBsYXRlbmN5IG9mIGNlcnRhaW4gcmVxdWVzdHMgd2l0aG91dCBzaWduaWZpY2FudGx5IGlt
cGFjdGluZyBhdmVyYWdlDQpsYXRlbmN5IGFuZCB0aHJvdWdocHV0Lg0KDQpCYXJ0Lg==
