Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A1C5519F
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0FB2078B
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 22:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKVWq4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Nov 2020 17:46:56 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55833 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbgKVWq4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Nov 2020 17:46:56 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-184-OPkHHBZnNUaqutYdUM3CBw-1; Sun, 22 Nov 2020 22:46:52 +0000
X-MC-Unique: OPkHHBZnNUaqutYdUM3CBw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 22 Nov 2020 22:46:51 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 22 Nov 2020 22:46:51 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 01/29] iov_iter: Switch to using a table of operations
Thread-Topic: [PATCH 01/29] iov_iter: Switch to using a table of operations
Thread-Index: AQHWwBDGoGn3nOhJ3USQ5xOUKK1Ae6nUv7SQ
Date:   Sun, 22 Nov 2020 22:46:51 +0000
Message-ID: <4cf03398b2bb47e28d13fae4b62185f5@AcuMS.aculab.com>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
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

RnJvbTogRGF2aWQgSG93ZWxscw0KPiBTZW50OiAyMSBOb3ZlbWJlciAyMDIwIDE0OjE0DQo+IA0K
PiBTd2l0Y2ggdG8gdXNpbmcgYSB0YWJsZSBvZiBvcGVyYXRpb25zLiAgSW4gYSBmdXR1cmUgcGF0
Y2ggdGhlIGluZGl2aWR1YWwNCj4gbWV0aG9kcyB3aWxsIGJlIHNwbGl0IHVwIGJ5IHR5cGUuICBG
b3IgdGhlIG1vbWVudCwgaG93ZXZlciwgdGhlIG9wcyB0YWJsZXMNCj4ganVzdCBqdW1wIGRpcmVj
dGx5IHRvIHRoZSBvbGQgZnVuY3Rpb25zIC0gd2hpY2ggYXJlIG5vdyBzdGF0aWMuICBJbmxpbmUN
Cj4gd3JhcHBlcnMgYXJlIHByb3ZpZGVkIHRvIGp1bXAgdGhyb3VnaCB0aGUgaG9va3MuDQoNCkkg
d2FzIHdvbmRlcmluZyBpZiB5b3UgY291bGQgdXNlIGEgYml0IG9mICdjcHAgbWFnaWMnDQpzbyB0
aGUgdG8gY2FsbCBzaXRlcyB3b3VsZCBiZToNCglJVEVSX0NBTEwoaXRlciwgYWN0aW9uKShhcmdf
bGlzdCk7DQoNCndoaWNoIG1pZ2h0IGV4cGFuZCB0bzoNCglpdGVyLT5hY3Rpb24oYXJnX2xpc3Qp
Ow0KaW4gdGhlIGZ1bmN0aW9uLXRhYmxlIGNhc2UuDQpCdXQgY291bGQgYWxzbyBiZSBhbiBpZi1j
aGFpbjoNCglpZiAoaXRlci0+dHlwZSAmIGZvbykNCgkJZm9vX2FjdGlvbihhcmdzKTsNCgllbHNl
IC4uLg0Kd2l0aCBmb29fYWN0aW9uKCkgYmVpbmcgaW5saW5lZC4NCg0KSWYgdGhlcmUgaXMgZW5v
dWdoIHN5bW1ldHJ5IGl0IG1pZ2h0IG1ha2UgdGhlIGNvZGUgZWFzaWVyIHRvIHJlYWQuDQpBbHRo
b3VnaCBJJ20gbm90IHN1cmUgd2hhdCBoYXBwZW5zIHRvICdpdGVyYXRlX2FsbF9raW5kcycuDQpP
VE9IIHRoYXQgaXMgYWxyZWFkeSB1bnJlYWRhYmxlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

