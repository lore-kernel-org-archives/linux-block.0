Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8F0C55199
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 12:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271D820575
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 12:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgD0MnE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:43:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33436 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbgD0MnE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 08:43:04 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7E3BDCF084310AEA3F0F;
        Mon, 27 Apr 2020 20:43:01 +0800 (CST)
Received: from huawei.com (10.175.113.49) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Apr 2020
 20:43:00 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH 1/1] blk-mq: remove the pointless call of list_entry_rq() in hctx_show_busy_rq()
Date:   Mon, 27 Apr 2020 21:12:50 +0800
Message-ID: <20200427131250.13725-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

And use rq directly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/blk-mq-debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..7a79db81a63f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -400,8 +400,7 @@ static bool hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
 	const struct show_busy_params *params = data;
 
 	if (rq->mq_hctx == params->hctx)
-		__blk_mq_debugfs_rq_show(params->m,
-					 list_entry_rq(&rq->queuelist));
+		__blk_mq_debugfs_rq_show(params->m, rq);
 
 	return true;
 }
-- 
2.21.1

