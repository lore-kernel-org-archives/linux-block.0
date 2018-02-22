Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:18089 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeBVXXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 18:23:01 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: v4.16-rc2: I/O hang with dm-rq + Kyber
Date: Thu, 22 Feb 2018 23:22:58 +0000
Message-ID: <1519341777.2861.35.camel@wdc.com>
References: <1519333819.2861.17.camel@wdc.com>
         <20180222224208.GA20710@vader.DHCP.thefacebook.com>
In-Reply-To: <20180222224208.GA20710@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVGh1LCAyMDE4LTAyLTIyIGF0IDE0OjQyIC0wODAwLCBPbWFyIFNhbmRvdmFsIHdyb3RlOg0K
PiBPbiBUaHUsIEZlYiAyMiwgMjAxOCBhdCAwOToxMDoyM1BNICswMDAwLCBCYXJ0IFZhbiBBc3Nj
aGUgd3JvdGU6DQo+ID4gSS9PIGhhbmdzIGlmIEkgcnVuIHRoZSBmb2xsb3dpbmcgY29tbWFuZCBv
biB0b3Agb2Yga2VybmVsIHY0LjE2LXJjMiArIHRoZQ0KPiA+IGliX3NycHQgcGF0Y2ggdGhhdCBh
ZGRzIFJETUEvQ00gc3VwcG9ydDoNCj4gPiANCj4gPiBzcnAtdGVzdC9ydW5fdGVzdHMgLWMgLWQg
LXIgMTAgLXQgMDItbXEgLWUga3liZXINCj4gPiANCj4gPiBUaGlzIGRvZXMgbm90IGhhcHBlbiB3
aXRoIHRoZSBkZWFkbGluZSBzY2hlZHVsZXIgbm9yIHdpdGhvdXQgYSBzY2hlZHVsZXIuDQo+ID4g
VGhpcyB0ZXN0IHBhc3NlZCBhIGZldyBtb250aHMgYWdvLiBJIGhhdmUgYXR0YWNoZWQgdGhlIG91
dHB1dCBvZiB0aGUgZm9sbG93aW5nDQo+ID4gY29tbWFuZCB0byB0aGlzIGUtbWFpbDoNCj4gPiAN
Cj4gPiAoY2QgL3N5cy9rZXJuZWwvZGVidWcvYmxvY2sgJiYgZ3JlcCAtciAuKSB8IGdyZXAgLXYg
L3BvbGxfc3RhdA0KPiA+IA0KPiA+IENhbiB5b3UgaGF2ZSBhIGxvb2s/DQo+IA0KPiBIZXksIEJh
cnQsIHRoYW5rcyBmb3IgdGhlIHJlcG9ydC4gQ2FuIHlvdSBjbGFyaWZ5IHdoYXQgdGhlIGRldmlj
ZQ0KPiB0b3BvbG9neSBpcyB3LnIudC4gdGhlIGRtIGRldmljZXM/DQoNCkhlbGxvIE9tYXIsDQoN
ClRoZSB0b3BvbG9neSB3YXMgbm90aGluZyBmYW5jeTogZG0tcnEgaW4gYmxrLW1xIG1vZGUgd2Fz
IGNvbmZpZ3VyZWQgdG8gdXNlDQpvbmUgc2NzaS1tcSBTUlAtb3Zlci1Sb0NFIHBhdGguIFRoZSBt
dWx0aXBhdGggb3V0cHV0IGlzIGFzIGZvbGxvd3M6DQoNCiMgbXVsdGlwYXRoIC1sbA0KbXBhdGhi
ICgzNjAwMTQwNTcyNjE2ZDY0Njk3MzZiMzEwMDAwMDAwMDApIGRtLTAgTElPLU9SRyxJQkxPQ0sN
CnNpemU9MzJNIGZlYXR1cmVzPSczIHF1ZXVlX2lmX25vX3BhdGggcXVldWVfbW9kZSBtcScgaHdo
YW5kbGVyPScwJyB3cD1ydw0KYC0rLSBwb2xpY3k9J3NlcnZpY2UtdGltZSAwJyBwcmlvPTUwIHN0
YXR1cz1hY3RpdmUNCiAgYC0gNDowOjA6MCBzZGMgODozMiBhY3RpdmUgcmVhZHkgcnVubmluZw0K
DQojIGZvciBkIGluIC9zeXMvYmxvY2sve2RtLTAsc2RjfTsgZG8gZWNobyAkKGJhc2VuYW1lICRk
KTogJCg8JGQvcXVldWUvc2NoZWR1bGVyKTsgZG9uZQ0KZG0tMDogYmZxIFtreWJlcl0gbXEtZGVh
ZGxpbmUgbm9uZQ0Kc2RjOiBiZnEgW2t5YmVyXSBtcS1kZWFkbGluZSBub25lDQoNCkJhcnQu
