Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB37C43460
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A10361393
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 10:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbhDEKA6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 06:00:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14690 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhDEKA5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 06:00:57 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FDR1B2qw3znYjW;
        Mon,  5 Apr 2021 17:58:06 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 5 Apr 2021 18:00:40 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <zhengyongjun3@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        "Johannes Thumshirn" <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hou Pu <houpu@bytedance.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        John Garry <john.garry@huawei.com>
CC:     <linux-block@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] block: use DEFINE_MUTEX() for mutex lock
Date:   Mon, 5 Apr 2021 18:14:50 +0800
Message-ID: <20210405101450.15043-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/block/null_blk/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6c821d48090..b15df944cde2 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -67,7 +67,7 @@ struct nullb_page {
 #define NULLB_PAGE_FREE (MAP_SZ - 2)
 
 static LIST_HEAD(nullb_list);
-static struct mutex lock;
+static DEFINE_MUTEX(lock);
 static int null_major;
 static DEFINE_IDA(nullb_indexes);
 static struct blk_mq_tag_set tag_set;
@@ -1961,8 +1961,6 @@ static int __init null_init(void)
 	if (ret)
 		goto err_tagset;
 
-	mutex_init(&lock);
-
 	null_major = register_blkdev(0, "nullb");
 	if (null_major < 0) {
 		ret = null_major;

