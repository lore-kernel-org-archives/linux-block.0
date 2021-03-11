Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFACBC433DB
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 13:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6708964F98
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 13:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhCKNnp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 08:43:45 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:45511 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233733AbhCKNnZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 08:43:25 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-160-0OoTqTl0OueELvA3YO31BA-1; Thu, 11 Mar 2021 13:42:18 +0000
X-MC-Unique: 0OoTqTl0OueELvA3YO31BA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 11 Mar 2021 13:42:16 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 11 Mar 2021 13:42:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jens Axboe' <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: -Walign-mismatch in block/blk-mq.c
Thread-Topic: -Walign-mismatch in block/blk-mq.c
Thread-Index: AQHXFe27ca/ZROQGTEKd9Li70YywSKp+zBWQ
Date:   Thu, 11 Mar 2021 13:42:16 +0000
Message-ID: <15284544c46b4cff8422abd027eb0f8a@AcuMS.aculab.com>
References: <20210310182307.zzcbi5w5jrmveld4@archlinux-ax161>
 <99cf90ea-81c0-e110-4815-dd1f7df36cb4@kernel.dk>
 <20210310203323.35w2q7tlnxe23ukg@Ryzen-9-3900X.localdomain>
 <e43dba61-8c74-757d-862d-99d23559cf50@kernel.dk>
In-Reply-To: <e43dba61-8c74-757d-862d-99d23559cf50@kernel.dk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RnJvbTogSmVucyBBeGJvZQ0KPiBTZW50OiAxMCBNYXJjaCAyMDIxIDIwOjQwDQo+IA0KPiBPbiAz
LzEwLzIxIDE6MzMgUE0sIE5hdGhhbiBDaGFuY2VsbG9yIHdyb3RlOg0KPiA+IE9uIFdlZCwgTWFy
IDEwLCAyMDIxIGF0IDAxOjIxOjUyUE0gLTA3MDAsIEplbnMgQXhib2Ugd3JvdGU6DQo+ID4+IE9u
IDMvMTAvMjEgMTE6MjMgQU0sIE5hdGhhbiBDaGFuY2VsbG9yIHdyb3RlOg0KPiA+Pj4gSGkgSmVu
cywNCj4gPj4+DQo+ID4+PiBUaGVyZSBpcyBhIG5ldyBjbGFuZyB3YXJuaW5nIGFkZGVkIGluIHRo
ZSBkZXZlbG9wbWVudCBicmFuY2gsDQo+ID4+PiAtV2FsaWduLW1pc21hdGNoLCB3aGljaCBzaG93
cyBhbiBpbnN0YW5jZSBpbiBibG9jay9ibGstbXEuYzoNCj4gPj4+DQo+ID4+PiBibG9jay9ibGst
bXEuYzo2MzA6Mzk6IHdhcm5pbmc6IHBhc3NpbmcgOC1ieXRlIGFsaWduZWQgYXJndW1lbnQgdG8N
Cj4gPj4+IDMyLWJ5dGUgYWxpZ25lZCBwYXJhbWV0ZXIgMiBvZiAnc21wX2NhbGxfZnVuY3Rpb25f
c2luZ2xlX2FzeW5jJyBtYXkNCj4gPj4+IHJlc3VsdCBpbiBhbiB1bmFsaWduZWQgcG9pbnRlciBh
Y2Nlc3MgWy1XYWxpZ24tbWlzbWF0Y2hdDQo+ID4+PiAgICAgICAgICAgICAgICAgc21wX2NhbGxf
ZnVuY3Rpb25fc2luZ2xlX2FzeW5jKGNwdSwgJnJxLT5jc2QpOw0KPiA+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gPj4+IDEgd2Fybmlu
ZyBnZW5lcmF0ZWQuDQo+ID4+Pg0KPiA+Pj4gVGhlcmUgYXBwZWFycyB0byBiZSBzb21lIGhpc3Rv
cnkgaGVyZSBhcyBJIGNhbiBzZWUgdGhhdCB0aGlzIG1lbWJlciB3YXMNCj4gPj4+IHB1cnBvc2Vm
dWxseSB1bmFsaWduZWQgaW4gY29tbWl0IDRjY2FmZTAzMjAwNSAoImJsb2NrOiB1bmFsaWduDQo+
ID4+PiBjYWxsX3NpbmdsZV9kYXRhIGluIHN0cnVjdCByZXF1ZXN0IikuIEhvd2V2ZXIsIEkgbGF0
ZXIgc2VlIGEgY2hhbmdlIGluDQo+ID4+PiBjb21taXQgN2MzZmI3MGYwMzQxICgiYmxvY2s6IHJl
YXJyYW5nZSBhIGZldyByZXF1ZXN0IGZpZWxkcyBmb3IgYmV0dGVyDQo+ID4+PiBjYWNoZSBsYXlv
dXQiKSB0aGF0IHNlZW1zIHNvbWV3aGF0IHJlbGF0ZWQuIElzIGl0IHBvc3NpYmxlIHRvIGdldCBi
YWNrDQo+ID4+PiB0aGUgYWxpZ25tZW50IGJ5IHJlYXJyYW5naW5nIHRoZSBzdHJ1Y3R1cmUgYWdh
aW4/IFRoaXMgc2VlbXMgdG8gYmUgdGhlDQo+ID4+PiBvbmx5IHNvbHV0aW9uIGZvciB0aGUgd2Fy
bmluZyBhc2lkZSBmcm9tIGp1c3Qgb3V0cmlnaHQgZGlzYWJsaW5nIGl0LA0KPiA+Pj4gd2hpY2gg
d291bGQgYmUgYSBzaGFtZSBzaW5jZSBpdCBzZWVtcyBsaWtlIGl0IGNvdWxkIGJlIHVzZWZ1bCBm
b3INCj4gPj4+IGFyY2hpdGVjdHVyZXMgdGhhdCBjYW5ub3QgaGFuZGxlIHVuYWxpZ25lZCBhY2Nl
c3NlcyB3ZWxsLCB1bmxlc3MgSSBhbQ0KPiA+Pj4gbWlzc2luZyBzb21ldGhpbmcgb2J2aW91cyA6
KQ0KPiA+Pg0KPiA+PiBJdCBzaG91bGQgbm90IGJlIGhhcmQgdG8gZW5zdXJlIHRoYXQgYWxpZ25t
ZW50IHdpdGhvdXQgcmUtaW50cm9kdWNpbmcNCj4gPj4gdGhlIGJsb2F0LiBJcyB0aGVyZSBzb21l
IGJhY2tncm91bmQgb24gd2h5IDMyLWJ5dGUgYWxpZ25tZW50IGlzDQo+ID4+IHJlcXVpcmVkPw0K
PiA+Pg0KPiA+DQo+ID4gVGhpcyBhbGlnbm1lbnQgcmVxdWlyZW1lbnQgd2FzIGludHJvZHVjZWQg
aW4gY29tbWl0IDk2NmE5NjcxMTZlNiAoInNtcDoNCj4gPiBBdm9pZCB1c2luZyB0d28gY2FjaGUg
bGluZXMgZm9yIHN0cnVjdCBjYWxsX3NpbmdsZV9kYXRhIikgYW5kIGl0IGxvb2tzDQo+ID4gbGlr
ZSB0aGVyZSB3YXMgYSB0aHJlYWQgYmV0d2VlbiB5b3UgYW5kIFBldGVyIFppamxzdHJhIHRoYXQg
aGFzIHNvbWUNCj4gPiBtb3JlIGluZm9ybWF0aW9uIG9uIHRoaXM6DQo+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci9hOWJlYjQ1Mi03MzQ0LTllMmQtZmM4MC0wOTRkOGY1YTAzOTRAa2VybmVs
LmRrLw0KPiANCj4gQWggbm93IEkgcmVtZW1iZXIgLSBzbyBpdCdzIG5vdCB0aGF0IGl0IF9uZWVk
c18gdG8gYmUgMzItYnl0ZSBhbGlnbmVkLA0KPiBpdCdzIGp1c3QgYSBoYW5keSB3YXkgdG8gZW5z
dXJlIHRoYXQgaXQgZG9lc24ndCBzdHJhZGRsZSB0d28gY2FjaGVsaW5lcy4NCj4gSW4gZmFjdCwg
dGhlcmUncyBubyByZWFsIGFsaWdubWVudCBjb25jZXJuLCBvdXRzaWRlIG9mIHBlcmZvcm1hbmNl
DQo+IHJlYXNvbnMgd2UgZG9uJ3Qgd2FudCBpdCB0b3VjaGluZyB0d28gY2FjaGVsaW5lcy4NCj4g
DQo+IFNvLi4uIHdoYXQgZXhhY3RseSBpcyB5b3VyIGNvbmNlcm4/IEp1c3Qgc2lsZW5jaW5nIHRo
YXQgd2FybmluZz8gQmVjYXVzZQ0KPiB0aGVyZSBkb2Vzbid0IHNlZW0gdG8gYmUgYW4gaXNzdWUg
d2l0aCBqdXN0IGhhdmluZyBpdCB3aGVyZXZlciBpbiBzdHJ1Y3QNCj4gcmVxdWVzdC4NCg0KQ2Fu
IHlvdSBzaWxlbmNlIGl0IGJ5IGFkZGluZyBhbiBleHRyYSBsYXllciBvZiAnc3RydWN0Jz8NClNv
bWV0aGluZyBsaWtlOg0KDQpzdHJ1Y3QgWw0KCS4uLi4NCglzdHJ1Y3Qgew0KCQlycV9yeXBlIHJx
Og0KCX0gX19hbGlnbmVkKDgpOw0KCS4uLg0KfTsNCg0KU28gdGhhdCAncnEnIHdpbGwgYmUgYWxp
Z25lZCwgYnV0IGl0c2VsZiBkb2Vzbid0IGhhdmUNCnRoZSBhbGlnbm1lbnQgY29uc3RyYWludD8N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

