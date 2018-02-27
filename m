Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:6020
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751004AbeB0QKB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 11:10:01 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <jg@lightnvm.io>
CC: "mb@lightnvm.io" <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: simplify geometry structure.
Date: Tue, 27 Feb 2018 16:09:59 +0000
Message-ID: <A1101358-5262-4AE5-B486-83344B99A7AD@cnexlabs.com>
References: <1519747032-25704-1-git-send-email-javier@cnexlabs.com>,<1519747032-25704-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519747032-25704-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

DQo+IE9uIDI3IEZlYiAyMDE4LCBhdCAxNi41NywgSmF2aWVyIEdvbnrDoWxleiA8amdAbGlnaHRu
dm0uaW8+IHdyb3RlOg0KPiANCj4gQ3VycmVudGx5LCB0aGUgZGV2aWNlIGdlb21ldHJ5IGlzIHN0
b3JlZCByZWR1bmRhbnRseSBpbiB0aGUgbnZtX2lkIGFuZA0KPiBudm1fZ2VvIHN0cnVjdHVyZXMg
YXQgYSBkZXZpY2UgbGV2ZWwuIE1vcmVvdmVyLCB3aGVuIGluc3RhbnRpYXRpbmcNCj4gdGFyZ2V0
cyBvbiBhIHNwZWNpZmljIG51bWJlciBvZiBMVU5zLCB0aGVzZSBzdHJ1Y3R1cmVzIGFyZSByZXBs
aWNhdGVkDQo+IGFuZCBtYW51YWxseSBtb2RpZmllZCB0byBmaXQgdGhlIGluc3RhbmNlIGNoYW5u
ZWwgYW5kIExVTiBwYXJ0aXRpb25pbmcuDQo+IA0KPiBJbnN0ZWFkLCBjcmVhdGUgYSBnZW5lcmlj
IGdlb21ldHJ5IGFyb3VuZCBudm1fZ2VvLCB3aGljaCBjYW4gYmUgdXNlZCBieQ0KPiAoaSkgdGhl
IHVuZGVybHlpbmcgZGV2aWNlIHRvIGRlc2NyaWJlIHRoZSBnZW9tZXRyeSBvZiB0aGUgd2hvbGUg
ZGV2aWNlLA0KPiBhbmQgKGlpKSBpbnN0YW5jZXMgdG8gZGVzY3JpYmUgdGhlaXIgZ2VvbWV0cnkg
aW5kZXBlbmRlbnRseS4NCj4gDQo+IFNpbmNlIHRoZXNlIHNoYXJlIGEgYmlnIHBhcnQgb2YgdGhl
IGdlb21ldHJ5LCBjcmVhdGUgYSBudm1fY29tbW9uX2dlbw0KPiBzdHJ1Y3R1cmUgdGhhdCBrZWVw
cyB0aGUgc3RhdGljIGdlb29tZXRyeSB2YWx1ZXMgdGhhdCBhcmUgc2hhcmVkIGFjcm9zcw0KPiBp
bnN0YW5jZXMuDQo+IA0KPiBBcyB3ZSBpbnRyb2R1Y2Ugc3VwcG9ydCBmb3IgMi4wLCB0aGVzZSBz
dHJ1Y3R1cmVzIGFsbG93IHRvIGFic3RyYWN0DQo+IHNwZWMuIHNwZWNpZmljIHZhbHVlcyBhbmQg
cHJlc2VudCBhIGNvbW1vbiBnZW9tZXRyeSB0byB0YXJnZXRzLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyQGNuZXhsYWJzLmNvbT4NCj4gLS0tDQo+IA0KDQpQ
bGVhc2UgaWdub3JlIHRoaXMgY29tbWl0IG1lc3NhZ2UgZm9yIG5vdy4gSXTigJlzIG5vdCB1cGRh
dGVkLi4uDQoNCkphdmllcg==
