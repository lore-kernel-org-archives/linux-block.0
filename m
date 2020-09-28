Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDC7C2D0A8
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 14:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB1421974
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 14:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgI1O5B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Sep 2020 10:57:01 -0400
Received: from smtp.h3c.com ([60.191.123.56]:48240 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgI1O5B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 10:57:01 -0400
Received: from DAG2EX04-BASE.srv.huawei-3com.com ([10.8.0.67])
        by h3cspam01-ex.h3c.com with ESMTPS id 08SEuEWX062756
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 22:56:14 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX04-BASE.srv.huawei-3com.com (10.8.0.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Sep 2020 22:56:19 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Mon, 28 Sep 2020 22:56:19 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [v3] blk-mq: add cond_resched() in
 __blk_mq_alloc_rq_maps()
Thread-Topic: [PATCH] [v3] blk-mq: add cond_resched() in
 __blk_mq_alloc_rq_maps()
Thread-Index: AQHWk69Ncz7gIsgJYE+39egApuiJR6l5x5YAgAReZ6A=
Date:   Mon, 28 Sep 2020 14:56:18 +0000
Message-ID: <ea21af15c4234608b630b5b679826227@h3c.com>
References: <20200926023947.1891-1-tian.xianting@h3c.com>
 <b884d4af-ef49-f294-4099-e35778f2a783@acm.org>
In-Reply-To: <b884d4af-ef49-f294-4099-e35778f2a783@acm.org>
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
X-MAIL: h3cspam01-ex.h3c.com 08SEuEWX062756
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhhbmsgeW91IEJhcnQgVmFuDQpIaSBKZW5zLA0KV2hldGhlciB0aGlzIHZlcnNpb24gcGF0Y2gg
aXMgb2sgZm9yIHlvdT8NCkxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIGZ1cnRoZXIgY29tbWVudHMg
OikNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEJhcnQgVmFuIEFzc2NoZSBb
bWFpbHRvOmJ2YW5hc3NjaGVAYWNtLm9yZ10gDQpTZW50OiBTYXR1cmRheSwgU2VwdGVtYmVyIDI2
LCAyMDIwIDEyOjA3IFBNDQpUbzogdGlhbnhpYW50aW5nIChSRCkgPHRpYW4ueGlhbnRpbmdAaDNj
LmNvbT47IGF4Ym9lQGtlcm5lbC5kaw0KQ2M6IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gW3YzXSBi
bGstbXE6IGFkZCBjb25kX3Jlc2NoZWQoKSBpbiBfX2Jsa19tcV9hbGxvY19ycV9tYXBzKCkNCg0K
T24gMjAyMC0wOS0yNSAxOTozOSwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4gZGlmZiAtLWdpdCBh
L2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMgaW5kZXggDQo+IGIzZDI3ODVlZS4uNjJk
MTUyZDAzIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibGstbXEuYw0KPiArKysgYi9ibG9jay9ibGst
bXEuYw0KPiBAQCAtMzI1Niw5ICszMjU2LDExIEBAIHN0YXRpYyBpbnQgX19ibGtfbXFfYWxsb2Nf
cnFfbWFwcyhzdHJ1Y3QgDQo+IGJsa19tcV90YWdfc2V0ICpzZXQpICB7DQo+ICAJaW50IGk7DQo+
ICANCj4gLQlmb3IgKGkgPSAwOyBpIDwgc2V0LT5ucl9od19xdWV1ZXM7IGkrKykNCj4gKwlmb3Ig
KGkgPSAwOyBpIDwgc2V0LT5ucl9od19xdWV1ZXM7IGkrKykgew0KPiAgCQlpZiAoIV9fYmxrX21x
X2FsbG9jX21hcF9hbmRfcmVxdWVzdChzZXQsIGkpKQ0KPiAgCQkJZ290byBvdXRfdW53aW5kOw0K
PiArCQljb25kX3Jlc2NoZWQoKTsNCj4gKwl9DQo+ICANCj4gIAlyZXR1cm4gMDsNCg0KUmV2aWV3
ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPg0K
