Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC154C433FF
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 08:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C901B2063F
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 08:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfHMIxY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:53:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbfHMIxY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 04:53:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A9E4A22E9447C600DCBF;
        Tue, 13 Aug 2019 16:53:21 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 13 Aug 2019
 16:53:15 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <tim@cyberelk.net>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] paride/pf: need to set queue to NULL before put_disk
Date:   Tue, 13 Aug 2019 16:59:44 +0800
Message-ID: <1565686784-50375-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565686784-50375-1-git-send-email-zhengbin13@huawei.com>
References: <1565686784-50375-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In pf_init_units, if blk_mq_init_sq_queue fails, need to set queue to
NULL before put_disk, otherwise null-ptr-deref Read will occur.

put_disk
  kobject_put
    disk_release
      blk_put_queue(disk->queue)

Fixes: 77218ddf46d8 ("paride: convert pf to blk-mq")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/block/paride/pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index 1e9c50a..6b7d4ca 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -300,8 +300,8 @@ static void __init pf_init_units(void)
 		disk->queue = blk_mq_init_sq_queue(&pf->tag_set, &pf_mq_ops,
 							1, BLK_MQ_F_SHOULD_MERGE);
 		if (IS_ERR(disk->queue)) {
-			put_disk(disk);
 			disk->queue = NULL;
+			put_disk(disk);
 			continue;
 		}

--
2.7.4

