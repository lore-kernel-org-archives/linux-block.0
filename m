Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA07C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 06:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 295A361184
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 06:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbhHYGVx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 02:21:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18036 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbhHYGVx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 02:21:53 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GvbNr2Kh4zbj4k;
        Wed, 25 Aug 2021 14:17:16 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 14:21:01 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 14:21:01 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-block@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block, bfq: cleanup the repeated declaration
Date:   Wed, 25 Aug 2021 14:19:51 +0800
Message-ID: <1629872391-46399-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Function 'bfq_entity_to_bfqq' is declared twice, so remove the
repeated declaration and blank line.

Cc: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 block/bfq-iosched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 385e28a843d1..a73488eec8a4 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -955,8 +955,6 @@ struct bfq_group {
 };
 #endif
 
-struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
-
 /* --------------- main algorithm interface ----------------- */
 
 #define BFQ_SERVICE_TREE_INIT	((struct bfq_service_tree)		\
-- 
2.7.4

