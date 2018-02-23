Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59230 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeBWQDc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Feb 2018 11:03:32 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jaco@uls.co.za" <jaco@uls.co.za>
CC: "pieterk@uls.co.za" <pieterk@uls.co.za>
Subject: Re: disk-io lockup in 4.14.13 kernel
Date: Fri, 23 Feb 2018 16:03:30 +0000
Message-ID: <1519401809.2904.4.camel@wdc.com>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
         <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
         <1071d2e4-f56f-ad5b-289c-c7fada6a166e@uls.co.za>
In-Reply-To: <1071d2e4-f56f-ad5b-289c-c7fada6a166e@uls.co.za>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE4LTAyLTIzIGF0IDExOjU4ICswMjAwLCBKYWNvIEtyb29uIHdyb3RlOg0KPiBP
biAyMi8wMi8yMDE4IDE4OjQ2LCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gKGNkIC9zeXMv
a2VybmVsL2RlYnVnL2Jsb2NrICYmIGZpbmQgLiAtdHlwZSBmIC1leGVjIGdyZXAgLWFIIC4ge30g
XDspDQo+IA0KPiBJIGRvbid0IGhhdmUgYSAvc3lzL2tlcm5lbC9kZWJ1ZyBmb2xkZXIgLSBJJ3Zl
IGVuYWJsZWQgQ09ORklHX0RFQlVHX0ZTDQo+IGFuZCBCTEtfREVCVUdfRlMsIHdpbGwgcmVib290
IGF0IHRoZSBmaXJzdCBvcHBvcnR1bml0eS4gIEFzIGEgZ2VuZXJhbA0KPiBydWxlIC0gaXMgdGhl
cmUgYWRkaXRpb25hbCBvdmVyaGVhZCB0byBoYXZpbmcgZGVidWdmcyBlbmFibGVkPyAgQW55DQo+
IG90aGVyIHJpc2tzIHRoYXQgSSBzaG91bGQgYmUgYXdhcmUgb2Y/ICBJbiBlc3NlbmNlLCBhcmUg
dGhlcmUgYW55DQo+IGRpc2FkdmFudGFnZXMgdG8ganVzdCBlbmFibGluZyBERUJVR19GUyBhcyBh
IGdlbmVyYWwgcnVsZT8gIEkgZGlkIG5vdGUNCj4gdGhhdCBhIGZldyBleHRyYSBERUJVRyBvcHRp
b25zIHBvcCB1cCBmb3Igb3RoZXIgbW9kdWxlcyAuLi4gc28gbXkgZ3V0IGlzDQo+IHRvd2FyZHMg
bGVhdmluZyB0aGlzIGRpc2FibGVkIGFzIGEgZ2VuZXJhbCBydWxlIGFuZCBlbmFibGluZyB3aGVu
IG5lZWRlZC4NCg0KSGVsbG8gSmFjbywNCg0KVGhlIG9ubHkgZGlzYWR2YW50YWdlcyBvZiBlbmFi
bGluZyBkZWJ1Z2ZzIHRoYXQgSSBrbm93IG9mIGFyZToNCi0gVGhlIGFkZGl0aW9uYWwgbWVtb3J5
IHJlcXVpcmVkIGJ5IGRlYnVnZnMgKHByb2JhYmx5IG5vdCB0aGF0IG11Y2gpLg0KLSBBIHNlY3Vy
aXR5IHJpc2sgaWYgbm90IGFsbCB1c2VycyB3aG8gaGF2ZSBhbiBhY2NvdW50IG9uIHRoZSBzeXN0
ZW0gYXJlIGZ1bGx5DQogIHRydXN0ZWQuIFNlZSBlLmcuIGh0dHBzOi8vYnVncy5kZWJpYW4ub3Jn
L2NnaS1iaW4vYnVncmVwb3J0LmNnaT9idWc9NjgxNDE4Lg0KDQpFbmFibGluZyBkZWJ1Z2ZzIGRv
ZXNuJ3QgY2F1c2UgYW55IHJ1bnRpbWUgb3ZlcmhlYWQgaW4gdGhlIGhvdCBwYXRoIG9mIHRoZQ0K
YmxvY2sgbGF5ZXIgaWYgbm8gc29mdHdhcmUgYWNjZXNzZXMgdGhlIGRlYnVnZnMgYXR0cmlidXRl
cy4NCg0KQmFydC4=
