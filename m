Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0053.outbound.protection.outlook.com ([104.47.33.53]:56028
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727554AbeH2XLh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 19:11:37 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] lightnvm: pblk: collection of small fixes
Date: Wed, 29 Aug 2018 19:13:15 +0000
Message-ID: <6E7A547D-842F-4842-84FB-05180AA50D79@cnexlabs.com>
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
 <5b8881cd-019a-a1d8-86ed-0131ef3b71af@lightnvm.io>
 <3F0AC430-4499-4D2D-B989-45B5635307A4@cnexlabs.com>,<115fa3ea-c53b-557f-9465-5f61a02efa49@lightnvm.io>
In-Reply-To: <115fa3ea-c53b-557f-9465-5f61a02efa49@lightnvm.io>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

DQo+IE9uIDI5IEF1ZyAyMDE4LCBhdCAyMC4xMSwgTWF0aWFzIEJqw7hybGluZyA8bWJAbGlnaHRu
dm0uaW8+IHdyb3RlOg0KPiANCj4gT24gMDgvMjkvMjAxOCAwMzoyNyBQTSwgSmF2aWVyIEdvbnph
bGV6IHdyb3RlOg0KPj4+IE9uIDI5IEF1ZyAyMDE4LCBhdCAxNS4xNCwgTWF0aWFzIEJqw7hybGlu
ZyA8bWJAbGlnaHRudm0uaW8+IHdyb3RlOg0KPj4+IA0KPj4+PiBPbiAwOC8yOS8yMDE4IDExOjAx
IEFNLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOg0KPj4+PiBDb2xsZWN0aW9uIG9mIHNtYWxsIGhl
bHBlciBmdW5jdGlvbiBmaXhlcywgcmVtb3ZhbCBvZiB1bnVzZWQgdmFyaWFibGVzDQo+Pj4+IGFu
ZCBjb21tZW50IHR5cG9zLg0KPj4+PiBKYXZpZXIgR29uesOhbGV6ICg0KToNCj4+Pj4gICBsaWdo
dG52bTogcGJsazogY2FsY3VsYXRlIGxpbmUgcGFkIGRpc3RhbmNlIGluIGhlbHBlcg0KPj4+PiAg
IGxpZ2h0bnZtOiBwYmxrOiBmaXggY29tbWVudCB0eXBvDQo+Pj4+ICAgbGlnaHRudm06IHBibGs6
IHJlbW92ZSB1bnVzZWQgdmFyaWFibGUuDQo+Pj4+ICAgbGlnaHRudm06IHBibGs6IGd1YXJhbnRl
ZSBlbWV0YSBvbiBsaW5lIGNsb3NlDQo+Pj4+ICBkcml2ZXJzL2xpZ2h0bnZtL3BibGstY29yZS5j
ICAgICB8IDEzICsrKysrKysrKysrLS0NCj4+Pj4gIGRyaXZlcnMvbGlnaHRudm0vcGJsay1yZWNv
dmVyeS5jIHwgIDIgLS0NCj4+Pj4gIGRyaXZlcnMvbGlnaHRudm0vcGJsay13cml0ZS5jICAgIHwg
IDIgKy0NCj4+Pj4gIGRyaXZlcnMvbGlnaHRudm0vcGJsay5oICAgICAgICAgIHwgIDYgKysrLS0t
DQo+Pj4+ICA0IGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0p
DQo+Pj4gDQo+Pj4gVGhhbmtzLiBBcHBsaWVkIDItNC4gVGhlIHBhZCBkaXN0YW5jZSBkb2VzIG5v
dCBjb21waWxlIGR1ZSB0byBtaXNzaW5nDQo+Pj4gdXBkYXRlIHRvIHBibGtfcGFkX2Rpc3RhbmNl
IGNhbGwgZnJvbSBwYmxrLXJlY292ZXJ5LmMuDQo+Pj4gDQo+Pj4gQWxzbywgaXQgbG9va3MgbGlr
ZSBwYmxrLXJlY292ZXJ5LmMgaXMgdGhlIG9ubHkgdXNlci4gUGxlYXNlIGNvbnNpZGVyDQo+Pj4g
bW92aW5nIGl0IHRoZSBmdW5jdGlvbiBmcm9tIHBibGsuaCB0byBwYmxrLXJlY292ZXJ5LmMNCj4+
IEkgcmVvcmRlcmVkIHRvIHNlbmQgdGhlIGhlbHBlcnMsIGJ1dCB5b3UgY2FuIHNlZSB0aGF0IGFs
bCB0aGVzZSBhcmUgbWFkZQ0KPj4gdG8gc3VwcG9ydC4NCj4+ICAgbGlnaHRudm06IHBibGs6IHJl
Y292ZXIgb3BlbiBsaW5lcyBvbiAyLjAgZGV2aWNlcw0KPj4gQ2FuIHlvdSBmaXggdGhpcyBkaXJl
Y3RseSBhbmQgYXBwbHkgMSB0b28/IEknbSBmaW5lIHdpdGggbW92aW5nIGl0IHRvDQo+PiBwYmxr
LXJlY292ZXJ5LmMuIFRoZSBwYXRjaCBhYm92ZSB3aWxsIHVzZSBpdC4NCj4gDQo+IFllcy4gSSd2
ZSBmaXhlZCBpdCB1cCBpbiBwYmxrLXJlY292ZXJ5LmMsIGFuZCBhbHNvIG1vdmVkIHRoZSBmdW5j
dGlvbiB0byBwYmxrLXJlY292ZXJ5LmMuIEFwcGxpZWQgZm9yIDQuMjAuDQoNClRoYW5rcyENCg==
