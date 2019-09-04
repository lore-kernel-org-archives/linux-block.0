Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B09C3A5A8
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 09:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5997522CF7
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 09:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfIDJn2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:43:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33656 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727768AbfIDJn1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 05:43:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-2-idzu5r6TOlu_emqmv_fYOA-1;
 Wed, 04 Sep 2019 10:43:24 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 4 Sep 2019 10:43:23 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 4 Sep 2019 10:43:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: RE: [PATCH] sched: make struct task_struct::state 32-bit
Thread-Topic: [PATCH] sched: make struct task_struct::state 32-bit
Thread-Index: AQHVYoQgiajii1HT8kenaFCmXyiHJqcbRQQA
Date:   Wed, 4 Sep 2019 09:43:23 +0000
Message-ID: <651c419e45e043e9be8d0877b5a5406d@AcuMS.aculab.com>
References: <20190902210558.GA23013@avx2>
 <d8ad0be1-4ed7-df74-d415-2b1c9a44bac7@arm.com> <20190903181920.GA22358@avx2>
In-Reply-To: <20190903181920.GA22358@avx2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: idzu5r6TOlu_emqmv_fYOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDAzIFNlcHRlbWJlciAyMDE5IDE5OjE5DQou
Li4NCj4gPiBIb3cgZGlkIHlvdSBjb21lIHVwIHdpdGggdGhpcyBjaGFuZ2VzZXQsIGRpZCB5b3Ug
cGlja2F4ZSBmb3Igc29tZSByZWdleHA/DQo+IA0KPiBObywgbWFudWFsbHksIGJhY2t0cmFja2lu
ZyB1cCB0byB0aGUgY2FsbCBjaGFpbi4NCj4gTWF5YmUgSSBtaXNzZWQgYSBmZXcgcGxhY2VzLg0K
DQpSZW5hbWluZyB0aGUgc3RydWN0dXJlIGZpZWxkIGFuZCBnZXR0aW5nIHRoZSBjb21waWxlciB0
byBmaW5kIGFsbCB0aGUgdXNlcyBjYW4gaGVscC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

