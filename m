Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0648DC4361B
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 10:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27EC22AED
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 10:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405334AbgLNKaO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Dec 2020 05:30:14 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:33862 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729043AbgLNKaK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Dec 2020 05:30:10 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-55-50EQHyNGNHiW9NdgJgIL1Q-1; Mon, 14 Dec 2020 10:28:24 +0000
X-MC-Unique: 50EQHyNGNHiW9NdgJgIL1Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 14 Dec 2020 10:28:25 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 14 Dec 2020 10:28:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Begunkov' <asml.silence@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iov_iter: optimise iter type checking
Thread-Topic: [PATCH 2/2] iov_iter: optimise iter type checking
Thread-Index: AQHW0aC/wcpmi7SVjkSsjWABD6g0gan2YYKw
Date:   Mon, 14 Dec 2020 10:28:24 +0000
Message-ID: <b0e01a4dc3fc4afeb95b7be826ff2375@AcuMS.aculab.com>
References: <cover.1605799583.git.asml.silence@gmail.com>
 <9bc27cb3ef6ab49b6b2ccee3db6613838aee17af.1605799583.git.asml.silence@gmail.com>
 <20201119170340.GA6179@infradead.org>
 <ce79f47e-2ec0-ba29-a991-c537a8990dee@gmail.com>
 <20201211020100.GB107834@ZenIV.linux.org.uk>
 <857a3161-fbd5-5ff8-d733-ca57923302b5@gmail.com>
In-Reply-To: <857a3161-fbd5-5ff8-d733-ca57923302b5@gmail.com>
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

RnJvbTogUGF2ZWwgQmVndW5rb3YNCj4gU2VudDogMTMgRGVjZW1iZXIgMjAyMCAyMjozMw0KPiAN
Cj4gT24gMTEvMTIvMjAyMCAwMjowMSwgQWwgVmlybyB3cm90ZToNCj4gPiBPbiBUaHUsIE5vdiAx
OSwgMjAyMCBhdCAwNToxMjo0NFBNICswMDAwLCBQYXZlbCBCZWd1bmtvdiB3cm90ZToNCj4gPj4g
T24gMTkvMTEvMjAyMCAxNzowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+ID4+PiBPbiBU
aHUsIE5vdiAxOSwgMjAyMCBhdCAwMzoyOTo0M1BNICswMDAwLCBQYXZlbCBCZWd1bmtvdiB3cm90
ZToNCj4gPj4+PiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgaW92X2l0ZXJfaXNfKigpIGhlbHBl
cnMgY2hlY2sgdHlwZXMgZm9yDQo+ID4+Pj4gZXF1YWxpdHksIGJ1dCBhbGwgaXRlcmF0ZV8qIGhl
bHBlcnMgZG8gYml0d2lzZSBhbmRzLiBUaGlzIGNvbmZ1c2VzDQo+ID4+Pj4gYSBjb21waWxlciwg
c28gZXZlbiBpZiBzb21lIGNhc2VzIHdlcmUgaGFuZGxlZCBzZXBhcmF0ZWx5IHdpdGgNCj4gPj4+
PiBpb3ZfaXRlcl9pc18qKCksIGl0IGNhbid0IGVsaW1pbmF0ZSBhbmQgc2tpcCB1bnJlYWNoYWJs
ZSBicmFuY2hlcyBpbg0KPiA+Pj4+IGZvbGxvd2luZyBpdGVyYXRlKigpLg0KPiA+Pj4NCj4gPj4+
IEkgdGhpbmsgd2UgbmVlZCB0byBraWxsIHRoZSBpb3ZfaXRlcl9pc18qIGhlbHBlcnMsIHJlbnVt
YmVyIHRvIG5vdCBkbw0KPiA+Pj4gdGhlIHBvaW50bGVzcyBiaXRtYXNrIGFuZCBqdXN0IGNoZWNr
IGZvciBlcXVhbGl0eSAobWlnaHQgdHVybiBpbnRvIGENCj4gPj4+IGJ1bmNoIG9mIG5pY2Ugc3dp
dGNoIHN0YXRlbWVudHMgYWN0dWFsbHkpLg0KPiA+Pg0KPiA+PiBUaGVyZSBhcmUgdXNlcyBsaWtl
IGJlbG93IHRob3VnaCwgYW5kIHRoYXQgd291bGQgYWxzbyBhZGQgc29tZSBvdmVyaGVhZA0KPiA+
PiBvbiBpb3ZfaXRlcl90eXBlKCksIHNvIGl0J3Mgbm90IGFwcGFyZW50IHRvIG1lIHdoaWNoIHZl
cnNpb24gd291bGQgYmUNCj4gPj4gY2xlYW5lci9mYXN0ZXIgaW4gdGhlIGVuZC4gQnV0IHllYWgs
IHdlIGNhbiBleHBlcmltZW50IGFmdGVyIGxhbmRpbmcNCj4gPj4gdGhpcyBwYXRjaC4NCj4gPj4N
Cj4gPj4gaWYgKHR5cGUgJiAoSVRFUl9CVkVDfElURVJfS1ZFQykpDQo+ID4NCj4gPiBUaGVyZSBh
cmUgZXhhY3RseSAzIHN1Y2ggcGxhY2VzLCBhbmQgYWxsIG9mIHRoZW0gd291bGQndmUgYmVlbiBq
dXN0IGFzIHdlbGwNCj4gPiB3aXRoIGNhc2UgSVRFUl9CVkVDOiBjYXNlIElURVJfS1ZFQzogLi4u
IGluIGEgc3dpdGNoLg0KPiA+DQo+ID4gSG1tLi4uICBJIHdvbmRlciB3aGljaCB3b3VsZCB3b3Jr
IGJldHRlcjoNCj4gPg0KPiA+IGVudW0gaXRlcl90eXBlIHsNCj4gPiAgICAgICAgIElURVJfSU9W
RUMgPSAwLA0KPiA+ICAgICAgICAgSVRFUl9LVkVDID0gMiwNCj4gPiAgICAgICAgIElURVJfQlZF
QyA9IDQsDQo+ID4gICAgICAgICBJVEVSX1BJUEUgPSA2LA0KPiA+ICAgICAgICAgSVRFUl9ESVND
QVJEID0gOCwNCj4gPiB9Ow0KPiA+IGlvdl9pdGVyX3R5cGUoaXRlcikJKCgoaXRlciktPnR5cGUp
ICYgfjEpDQo+ID4gaW92X2l0ZXJfcncoaXRlcikJKCgoaXRlciktPnR5cGUpICYgMSkNCj4gPg0K
PiA+IG9yDQo+ID4NCj4gPiBlbnVtIGl0ZXJfdHlwZSB7DQo+ID4gICAgICAgICBJVEVSX0lPVkVD
LA0KPiA+ICAgICAgICAgSVRFUl9LVkVDLA0KPiA+ICAgICAgICAgSVRFUl9CVkVDLA0KPiA+ICAg
ICAgICAgSVRFUl9QSVBFLA0KPiA+ICAgICAgICAgSVRFUl9ESVNDQVJELA0KPiA+IH07DQo+ID4g
aW92X2l0ZXJfdHlwZShpdGVyKQkoKChpdGVyKS0+dHlwZSkgJiAofjBVPj4xKSkNCj4gPiAvLyBj
YWxsZXJzIG9mIGlvdl9pdGVyX3J3KCkgYXJlIGFsbW9zdCBhbGwgY29tcGFyaW5nIHdpdGggZXhw
bGljaXQgUkVBRCBvciBXUklURQ0KPiA+IGlvdl9pdGVyX3J3KGl0ZXIpCSgoKGl0ZXIpLT50eXBl
KSAmIH4ofjBVPj4xKSA/IFdSSVRFIDogUkVBRCkNCj4gPiB3aXRoIHBsYWNlcyBsaWtlIGlvdl9p
dGVyX2t2ZWMoKSBkb2luZw0KPiA+IAlpLT50eXBlID0gSVRFUl9LVkVDIHwgKChkaXJlY3Rpb24g
PT0gV1JJVEUpID8gQklUKDMxKSA6IDApOw0KPiA+DQo+ID4gUHJlZmVyZW5jZXM/DQo+IA0KPiBG
b3IgdGhlIGJpdG1hc2sgdmVyc2lvbiAod2l0aCB0aGlzIHBhdGNoKSB3ZSBoYXZlIG1vc3Qgb2YN
Cj4gaW92X2l0ZXJfdHlwZSgpIGNvbXBsZXRlbHkgb3B0aW1pc2VkIG91dC4gRS5nLiBpZGVudGlj
YWwNCj4gDQo+IGlvdl9pdGVyX3R5cGUoaSkgJiBJVEVSX0lPVkVDIDw9PiBpdGVyLT50eXBlICYg
SVRFUl9JT1ZFQw0KPiANCj4gSXQncyBhbHNvIG5pY2UgdG8gaGF2ZSBpb3ZfaXRlcl9ydygpIHRv
IGJlIGp1c3QNCj4gKHR5cGUgJiAxKSwgb3BlcmF0aW9ucyB3aXRoIHdoaWNoIGNhbiBiZSBvcHRp
bWlzZWQgaW4gYSBoYW5kZnVsIG9mIHdheXMuDQo+IA0KPiBVbmxlc3MgdGhlIGNvbXBpbGVyIHdv
dWxkIGJlIGFibGUgdG8gaGVhdmlseSBvcHRpbWlzZSBzd2l0Y2hlcywNCj4gZS5nLiB0byBvdXQt
b2YtbWVtb3J5L2NhbGN1bGF0aW9uLWJhc2VkIGp1bXAgdGFibGVzLCB0aGF0IEkgZG91YnQsDQo+
IEknZCBwZXJzb25hbGx5IGxlYXZlIGl0IGJlLiBUaG91Z2gsIG5vdCBsaWtlIGl0IHNob3VsZCBt
YXR0ZXIgbXVjaC4NCg0KVGhlIGFkdmFudGFnZSBvZiB0aGUgYml0LW1hc2tzIGlzIHRoYXQgdGhl
ICd1c3VhbCcgb3B0aW9ucyBjYW4NCmJlIHRlc3RlZCBmb3IgdG9nZXRoZXIuIFNvIHRoZSBjb2Rl
IGNhbiBiZSAoZm9yIGV4YW1wbGUpOg0KCWlmIChsaWtlbHkoaXRlci0+dHlwZSAmIChJVEVSX0lP
VkVDIHwgSVRFUl9QSVBFKSB7DQoJCWlmIChsaWtlbHkoKGl0ZXItPnR5cGUgJiBJVEVSX0lPVkVD
KSkgew0KCQkJLi4uIGNvZGUgZm9yIGlvdmVjDQoJCX0gZWxzZSBbDQoJCQkuLi4gY29kZSBmb3Ig
cGlwZQ0KCQl9DQoJfSBlbHNlIGlmIChpdGVyLT50eXBlICYgSVRFUl9CVkVDKSB7DQoJCS4uLiBj
b2RlIGZvciBidmVjDQoJfSBlbHNlIGlmIChpdGVyLT50eXBlICYgSVRFUl9LVkVDKSB7DQoJCS4u
IGNvZGUgZm9yIGt2ZWMNCgl9IGVsc2Ugew0KCQkuLiBtdXN0IGJlIGRpc2NhcmQNCgl9DQoNCkkn
bSBub3Qgc3VyZSBvZiB0aGUgYmVzdCBvcmRlciB0aG91Z2guDQpZb3UgbWlnaHQgd2FudCAzIGJp
dHMgaW4gdGhlIGZpcnN0IHRlc3QuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

