Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B51C282CE
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 04:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7389521473
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 04:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="N0xC+rg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfDIEkX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 00:40:23 -0400
Received: from m15-48.126.com ([220.181.15.48]:2184 "EHLO m15-48.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfDIEkX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Apr 2019 00:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=/ZRXb
        lN5uaE5Y0eiXqfznYPBjYjfDUhKGgulaTCQQY0=; b=N0xC+rg/4HwQ4QohiWEzr
        /sd32chXMZotUHeiT7hCyfpGmPnPrbKfe7027JvUeBglYl27wJdl0ZOYMMxY/6DZ
        0jj2NQrVxWLZu7tOj1RK3YOHiu+N9bI7FDq2i+Ao1G/fr917ke7ICtVFc7gNPEpL
        eHTJ5Cru/a0Y0T4fnWxnOI=
Received: from xianting_tian$126.com ( [61.129.7.254] ) by
 ajax-webmail-wmsvr48 (Coremail) ; Tue, 9 Apr 2019 12:39:21 +0800 (CST)
X-Originating-IP: [61.129.7.254]
Date:   Tue, 9 Apr 2019 12:39:21 +0800 (CST)
From:   xianting_tian <xianting_tian@126.com>
To:     "Jens Axboe" <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re:Re: [PATCH] block: convert kmalloc_node to kzalloc_node
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20180927(cd7136b6) Copyright (c) 2002-2019 www.mailtech.cn 126com
In-Reply-To: <407cb34e-c26a-b343-6433-5602ed4e666c@kernel.dk>
References: <1554734902-8295-1-git-send-email-xianting_tian@126.com>
 <407cb34e-c26a-b343-6433-5602ed4e666c@kernel.dk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=gbk
MIME-Version: 1.0
Message-ID: <716de00e.31e2.16a0064b789.Coremail.xianting_tian@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MMqowADn79f6IaxcyLAMAA--.41217W
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi7QyRpFpD68qQAwABs+
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

CmhpIGF4Ym9lLAp0aGFua3MgYSBsb3QgZm9yIHlvdXIgcmVwbHksIHRoZSBwYXRjaCBpcyBiYXNl
ZCBvbiBsaW51eCBzdGFibGUgYnJhbmNoIDQuMjAuMTcsIGkgc2F3IGl0IHdhcyB0YWdnZWQgd2l0
aCAiRU9MIiBhdCAyMDE5LTAzLTE5LiBzbyBpdCB3b24ndCBiZSBtYWludGFpbmVkIGFueSBtb3Jl
PyAKCgoKLS0Kt6LX1M7StcTN+NLX08rP5MrWu/rWx8TcsOYKCgrU2iAyMDE5LTA0LTA4IDIzOjAy
OjA5o6wiSmVucyBBeGJvZSIgPGF4Ym9lQGtlcm5lbC5kaz4g0LS1wKO6Cj5PbiA0LzgvMTkgODo0
OCBBTSwgVGlhbiBYaWFudGluZyB3cm90ZToKPj4gVXNlIGt6YWxsb2Nfbm9kZSB0byB6ZXJvIGFs
bG9jYXRlZCBidWZmZXIsIGFzIGRlYWRsaW5lIGFuZCBjZnEgSS9PCj4+IHNjaGVkdWxlciBpbml0
aWFsaXphdGlvbiBmdW5jdGlvbiAoZGVhZGxpbmVfaW5pdF9xdWV1ZSwgY2ZxX2luaXRfcXVldWUp
Cj4+IGRpZC4KPgo+bm9vcCBkb2Vzbid0IGV4aXN0IGluIGN1cnJlbnQga2VybmVscy4KPgo+LS0g
Cj5KZW5zIEF4Ym9lCg==
