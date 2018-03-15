Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46058 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCOQuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 12:50:24 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "colyli@suse.de" <colyli@suse.de>,
        "mlyle@lyle.org" <mlyle@lyle.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 06/16] bcache: Suppress more warnings about
 set-but-not-used variables
Date: Thu, 15 Mar 2018 16:50:18 +0000
Message-ID: <1521132616.2834.6.camel@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
         <20180315150814.9412-7-bart.vanassche@wdc.com>
         <53cbda05-917f-cce3-91ff-73e363448773@suse.de>
In-Reply-To: <53cbda05-917f-cce3-91ff-73e363448773@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE4LTAzLTE2IGF0IDAwOjIwICswODAwLCBDb2x5IExpIHdyb3RlOg0KPiBPbiAx
NS8wMy8yMDE4IDExOjA4IFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gVGhpcyBwYXRj
aCBkb2VzIG5vdCBjaGFuZ2UgYW55IGZ1bmN0aW9uYWxpdHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogQmFydCBWYW4gQXNzY2hlIDxiYXJ0LnZhbmFzc2NoZUB3ZGMuY29tPg0KPiANCj4gSGkg
QmFydCwNCj4gDQo+IFRoaXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4gQSBxdWVzdGlvbiBpcywg
ZG9lcyBHQ0MgbGF0ZXIgdGhhbiA0LjMNCj4gc3VwcG9ydHMgc3VjaCBhbm5vdGF0aW9uIGxpa2Ug
J19fbWF5YmVfdW51c2VkJyA/DQoNCkhlbGxvIENvbHksDQoNCllvdSBtYXkgd2FudCB0byBoYXZl
IGEgbG9vayBhdCB0aGUgZm9sbG93aW5nIGNvbW1pdDoNCg0KY29tbWl0IDBkN2ViYmJjNmVhYTU1
MzlmNzhhYjIwZWQ2ZmYxNzI1YTRlMzMyZWYNCkF1dGhvcjogRGF2aWQgUmllbnRqZXMgPHJpZW50
amVzQGdvb2dsZS5jb20+DQpEYXRlOiAgIFdlZCBNYXkgOSAwMjozNToyNyAyMDA3IC0wNzAwDQoN
CiAgICBjb21waWxlcjogaW50cm9kdWNlIF9fdXNlZCBhbmQgX19tYXliZV91bnVzZWQNCg0KICAg
IF9fdXNlZCBpcyBkZWZpbmVkIHRvIGJlIF9fYXR0cmlidXRlX18oKHVudXNlZCkpIGZvciBhbGwg
cHJlLTMuMyBnY2MNCiAgICBjb21waWxlcnMgdG8gc3VwcHJlc3Mgd2FybmluZ3MgZm9yIHVudXNl
ZCBmdW5jdGlvbnMgYmVjYXVzZSBwZXJoYXBzIHRoZXkNCiAgICBhcmUgcmVmZXJlbmNlZCBvbmx5
IGluIGlubGluZSBhc3NlbWJseS4gIEl0IGlzIGRlZmluZWQgdG8gYmUNCiAgICBfX2F0dHJpYnV0
ZV9fKCh1c2VkKSkgZm9yIGdjYyAzLjMgYW5kIGxhdGVyIHNvIHRoYXQgdGhlIGNvZGUgaXMgc3Rp
bGwNCiAgICBlbWl0dGVkIGZvciBzdWNoIGZ1bmN0aW9ucy4NCg0KDQoNClRoYW5rcywNCg0KQmFy
dC4NCg0KDQo=
