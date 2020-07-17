Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F72C433DF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 09:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3496520684
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 09:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgGQJuK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:50:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgGQJuK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 05:50:10 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6A5E988651E6CA061386;
        Fri, 17 Jul 2020 17:50:07 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 17:50:01 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Jens Axboe <axboe@kernel.dk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-block@vger.kernel.org>
Subject: [PATCH -next] block: make blk_timeout_init() static
Date:   Fri, 17 Jul 2020 18:00:02 +0800
Message-ID: <20200717100002.51739-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The sparse tool complains as follows:

block/blk-timeout.c:93:12: warning:
 symbol 'blk_timeout_init' was not declared. Should it be static?

Function blk_timeout_init() is not used outside ofblk-timeout.c, so
marks it static.

Fixes: 9054650fac24 ("block: relax jiffies rounding for timeouts")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 block/blk-timeout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 8ab8a82825cd..4c1fc3417460 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -90,7 +90,7 @@ EXPORT_SYMBOL_GPL(blk_abort_request);
 
 static unsigned long blk_timeout_mask __read_mostly;
 
-int __init blk_timeout_init(void)
+static int __init blk_timeout_init(void)
 {
 	blk_timeout_mask = roundup_pow_of_two(HZ) - 1;
 	return 0;

