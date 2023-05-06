Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB8FC77B75
	for <linux-block@archiver.kernel.org>; Sat,  6 May 2023 15:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjEFPqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 May 2023 11:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjEFPqE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 May 2023 11:46:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FF022F55
        for <linux-block@vger.kernel.org>; Sat,  6 May 2023 08:45:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-171-X7vGXre8OyyMNo80uHBv3A-1; Sat, 06 May 2023 16:45:56 +0100
X-MC-Unique: X7vGXre8OyyMNo80uHBv3A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 6 May
 2023 16:45:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 6 May 2023 16:45:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro
 parameter use
Thread-Topic: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro
 parameter use
Thread-Index: AQHZf4t9cLtoLLvx6keJPHYbi8Xxca9NYqJw
Date:   Sat, 6 May 2023 15:45:54 +0000
Message-ID: <71d4279ca9524b2382059cd2f723e20e@AcuMS.aculab.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-13-mathieu.desnoyers@efficios.com>
 <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com>
 <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
 <3cc72a67-d648-0040-6f60-37663797e360@efficios.com>
 <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDUgTWF5IDIwMjMgMjA6NTUNCi4uLi4NCj4g
PiBUaGUgb3RoZXIgZXhjZXB0aW9uIEkgd291bGQgYWRkIGlzIHdoZW4gYSBwYXJhbWV0ZXIgaXMg
dXNlZCBhcyBhbg0KPiA+IGx2YWx1ZSwgYXM6DQo+ID4NCj4gPiAjZGVmaW5lIG0oeCkgZG8geyB4
ID0gMjsgfSB3aGlsZSAoMCkNCj4gDQo+IEkgcmVhbGx5IGRvbid0IHVuZGVyc3RhbmQgd2h5IHlv
dSB0aGluayAnPScgaXMgc28gc3BlY2lhbC4gSXQncyB2ZXJ5DQo+IG11Y2ggbm90IHNwZWNpYWwu
DQo+IA0KPiBJdCBoYXBwZW5zIHRvIGhhdmUgdGhlIGxvd2VzdCBwcmVjZWRlbmNlLCBzdXJlLCBi
dXQgdGhlIGtleXdvcmQgaXMgImhhcHBlbnMiLg0KDQpBbmQgY29uc2lkZXIgd2hhdCBoYXBwZW5z
IGlmIHlvdSB0cnk6DQoJbShhID8gYiA6IGMpDQoNClBlcnNvbmFsbHkgSSdkIGF2b2lkIHVzaW5n
IHBhcmFtZXRlcnMgYXMgbHZhbHVlcyBpZiBhdCBhbGwgcG9zc2libGUuDQpJdCBpcyBtdWNoIGJl
dHRlciB0byBoYXZlOg0KCSNkZWZpbmUgbSh4KSBkbyB7ICooeCkgPSAyOyB9IHdoaWxlICgwKQ0K
YW5kIHJlcXVpcmUgdGhlIGNhbGxlciBkbyBtKCZmb28pIHRvIG1ha2UgaXQgb2J2aW91cyB0aGUg
dmFsdWUgaXMgY2hhbmdlZC4NCihBcGFydCBmcm9tIGxvb3AgZGVmaW5pdGlvbnMuLi4pDQoNClRo
aW5ncyBsaWtlIHRoZSBDKysgJ2ludCAmYXJnJyBtYWtlIGl0IGhhcmQgdG8gc2NhbiByZWFkL3Nl
YXJjaA0KY29kZSBmb3IgcGxhY2VzIHdoZXJlIHZhcmlhYmxlcyBnZXQgY2hhbmdlZC4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

