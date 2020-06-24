Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A01C433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 13:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869F120786
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 13:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403812AbgFXNCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:02:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390580AbgFXNCm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 09:02:42 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1FA9744D476307A5D851;
        Wed, 24 Jun 2020 21:02:40 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 24 Jun 2020
 21:02:32 +0800
From:   Guo Xuenan <guoxuenan@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <guoxuenan@huawei.com>, <fangwei1@huawei.com>,
        <wangli74@huawei.com>
Subject: [PATCH] blk-rq-qos: remove redundant finish_wait to rq_qos_wait.
Date:   Wed, 24 Jun 2020 09:04:00 -0400
Message-ID: <20200624130400.2902189-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is no need do finish_wait twice after acquiring inflight.

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 block/blk-rq-qos.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 656460636ad3..00a08e53dc24 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -270,8 +270,10 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	has_sleeper = !wq_has_single_sleeper(&rqw->wait);
 	do {
 		/* The memory barrier in set_task_state saves us here. */
-		if (data.got_token)
-			break;
+		if (data.got_token) {
+			finish_wait(&rqw->wait, &data.wq);
+			return;
+		}
 		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
 			finish_wait(&rqw->wait, &data.wq);
 
@@ -289,7 +291,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		has_sleeper = true;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 	} while (1);
-	finish_wait(&rqw->wait, &data.wq);
 }
 
 void rq_qos_exit(struct request_queue *q)
-- 
2.25.4

