Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D09C433ED
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC716115C
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 09:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhDIJna (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 05:43:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15653 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDIJn3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Apr 2021 05:43:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGtR01tRMzpWtY;
        Fri,  9 Apr 2021 17:40:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:43:10 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>, <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] block: use DEFINE_MUTEX() for mutex lock
Date:   Fri, 9 Apr 2021 17:51:35 +0800
Message-ID: <20210409095135.2293700-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/block/pktcdvd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index fc4b0f1aa86d..699ed8bbdbdf 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -96,7 +96,7 @@ static struct proc_dir_entry *pkt_proc;
 static int pktdev_major;
 static int write_congestion_on  = PKT_WRITE_CONGESTION_ON;
 static int write_congestion_off = PKT_WRITE_CONGESTION_OFF;
-static struct mutex ctl_mutex;	/* Serialize open/close/setup/teardown */
+static DEFINE_MUTEX(ctl_mutex);	/* Serialize open/close/setup/teardown */
 static mempool_t psd_pool;
 static struct bio_set pkt_bio_set;
 
@@ -2858,8 +2858,6 @@ static int __init pkt_init(void)
 {
 	int ret;
 
-	mutex_init(&ctl_mutex);
-
 	ret = mempool_init_kmalloc_pool(&psd_pool, PSD_POOL_SIZE,
 				    sizeof(struct packet_stacked_data));
 	if (ret)

