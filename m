Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB8C433DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 07:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D4A206B5
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 07:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgHXHIA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:08:00 -0400
Received: from smtp.h3c.com ([60.191.123.56]:6894 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgHXHIA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 03:08:00 -0400
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 07O6IkIB006890
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 14:18:46 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([10.8.0.70])
        by h3cspam01-ex.h3c.com with ESMTPS id 07O6IVg6006414
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 14:18:31 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Aug 2020 14:18:33 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Mon, 24 Aug 2020 14:18:33 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Jens Axboe <axboe@kernel.dk>, "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>, "andriin@fb.com" <andriin@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@chromium.org" <kpsingh@chromium.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] blk-mq: use BLK_MQ_NO_TAG for no tag
Thread-Topic: [PATCH] blk-mq: use BLK_MQ_NO_TAG for no tag
Thread-Index: AQHWeWVPz3S1M1hkw0a6Ze6ZxO8+NalFp1wAgADlO5A=
Date:   Mon, 24 Aug 2020 06:18:33 +0000
Message-ID: <19b0d8969dde4e20b1e6a076e48ba716@h3c.com>
References: <20200823154459.40731-1-tian.xianting@h3c.com>
 <1b85d18e-b0ae-a925-bb84-0a1eb8942099@kernel.dk>
In-Reply-To: <1b85d18e-b0ae-a925-bb84-0a1eb8942099@kernel.dk>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 07O6IVg6006414
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgSmVucw0KU29ycnkgdG8gdHJvdWJsZSB5b3UsIEkgYW0gdmVyeSBzb3JyeSBmb3IgdGFraW5n
IGl0IGZvciBncmFudGVkIGZvciB0aGUgcGF0Y2ggY29tcGlsZS4NCg0KSSBjaGVja2VkLCBjb21w
aWxlIGZvciB0aGUgdHdvIGNoYW5nZWQgZmlsZXMgYXJlIE9LOg0KYmxvY2svYmxrLWNvcmUuYw0K
YmxvY2svYmxrLW1xLXNjaGVkLmMNCg0KQ29tcGlsZSBmYWlsZWQgZm9yIHRoZSBmdW5jdGlvbiBp
biBiZWxvdyBoZWFkZXIgZmlsZToNCmluY2x1ZGUvbGludXgvYmxrLW1xLmg6IHJlcXVlc3RfdG9f
cWNfdCgpDQotICAgICAgIGlmIChycS0+dGFnICE9IC0xKQ0KKyAgICAgICBpZiAocnEtPnRhZyAh
PSBCTEtfTVFfTk9fVEFHKQ0KDQpCTEtfTVFfTk9fVEFHIGlzIGRlZmluZWQgaW4gJ2Jsb2NrL2Js
ay1tcS10YWcuaCcsICBpZiBJIGluY2x1ZGUgdGhpcyBoZWFkZXIgZmlsZSBpbiAnaW5jbHVkZS9s
aW51eC9ibGstbXEuaCcgdmlhICcjaW5jbHVkZSAiLi4vLi4vYmxvY2svYmxrLW1xLXRhZy5oIics
IA0KTWFueSBvdGhlciBzaW1pbGFyIGNvbXBpbGUgZmFpbGVkIGhhcHBlbiwgZm9yIGV4YW1wbGU6
DQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9pbmNsdWRlL2xpbnV4Ly4uLy4uL2Jsb2NrL2Jsay1t
cS10YWcuaDo1OjAsDQogICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2Jsay1t
cS5oOjgsDQogICAgICAgICAgICAgICAgIGZyb20gYmxvY2svYmxrLmg6NiwNCiAgICAgICAgICAg
ICAgICAgZnJvbSBibG9jay9iaW8uYzoyNDoNCi4vaW5jbHVkZS9saW51eC8uLi8uLi9ibG9jay9i
bGstbXEuaDoyMToyOTogZXJyb3I6IOKAmEhDVFhfTUFYX1RZUEVT4oCZIHVuZGVjbGFyZWQgaGVy
ZSAobm90IGluIGEgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYS09CSl9OU19UWVBFU+KAmT8N
CiAgIHN0cnVjdCBsaXN0X2hlYWQgcnFfbGlzdHNbSENUWF9NQVhfVFlQRVNdOw0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fg0KSWYgSSBtb3ZlZCBiZWxvdyBCTEtf
TVFfTk9fVEFHIGRlZmluaXRpb24gdG8gJ2luY2x1ZGUvbGludXgvYmxrLW1xLmgnLCBhbGwga2Vy
bmVsIGNvbXBpbGVzIGFyZSBvayB3aXRoIHRoZSBwYXRjaC4NCmVudW0gew0KICAgICAgICBCTEtf
TVFfTk9fVEFHICAgICAgICAgICA9IC0xVSwNCiAgICAgICAgQkxLX01RX1RBR19NSU4gICAgICAg
ICAgPSAxLA0KICAgICAgICBCTEtfTVFfVEFHX01BWCAgICAgICAgICA9IEJMS19NUV9OT19UQUcg
LSAxLA0KfTsNCldpbGwgeW91IGFjY2VwdCBhYm92ZSBtb3Zpbmcgb2YgQkxLX01RX05PX1RBRyB0
byAnaW5jbHVkZS9saW51eC9ibGstbXEuaCc/ICAgDQpUaGFua3MNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEplbnMgQXhib2UgW21haWx0bzpheGJvZUBrZXJuZWwuZGtdIA0K
U2VudDogTW9uZGF5LCBBdWd1c3QgMjQsIDIwMjAgNDo1OCBBTQ0KVG86IHRpYW54aWFudGluZyAo
UkQpIDx0aWFuLnhpYW50aW5nQGgzYy5jb20+OyBhc3RAa2VybmVsLm9yZzsgZGFuaWVsQGlvZ2Vh
cmJveC5uZXQ7IGthZmFpQGZiLmNvbTsgc29uZ2xpdWJyYXZpbmdAZmIuY29tOyB5aHNAZmIuY29t
OyBhbmRyaWluQGZiLmNvbTsgam9obi5mYXN0YWJlbmRAZ21haWwuY29tOyBrcHNpbmdoQGNocm9t
aXVtLm9yZw0KQ2M6IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gYmxrLW1xOiB1c2UgQkxLX01RX05P
X1RBRyBmb3Igbm8gdGFnDQoNCk9uIDgvMjMvMjAgOTo0NCBBTSwgWGlhbnRpbmcgVGlhbiB3cm90
ZToNCj4gUmVwbGFjZSB2YXJpb3VzIG1hZ2ljIC0xIGNvbnN0YW50cyBmb3IgdGFncyB3aXRoIEJM
S19NUV9OT19UQUcuDQoNCkRvZXNuJ3QgbG9vayBsaWtlIHRoaXMgcGF0Y2ggd2FzIGV2ZW4gY29t
cGlsZWQuLi4NCg0KLS0gDQpKZW5zIEF4Ym9lDQoNCg==
