Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABE8C4363D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF302076D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 13:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgIXN3g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 09:29:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3559 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728000AbgIXN3f (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 09:29:35 -0400
X-Greylist: delayed 1018 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 09:29:34 EDT
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id DBA906317A7DAA0464D0;
        Thu, 24 Sep 2020 21:13:33 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 24 Sep 2020 21:13:33 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Thu, 24 Sep 2020 21:13:33 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Use helper function blk_mq_hctx_stopped() in
 blk_mq_run_work_fn()
Thread-Topic: [PATCH] block: Use helper function blk_mq_hctx_stopped() in
 blk_mq_run_work_fn()
Thread-Index: AdaSdHQrw4II3QTYQUKEHs7qdsawLg==
Date:   Thu, 24 Sep 2020 13:13:33 +0000
Message-ID: <0edc09a4487b4145829e262f479cbcd6@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Friend ping :)

> Use helper function blk_mq_hctx_stopped() to check if hardware queue stopped in blk_mq_run_work_fn().
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
