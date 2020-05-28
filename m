Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB688C433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 15:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E27C2089D
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590680088;
	bh=i7fvGYYm+p8Uu0snT6GzRGMWwy+eqeQaF+Vpm53E7yc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LtW/gEtAtq+PFDeWihp5JDlyb5bKstdNssQR8cyQfGIQN4Grcxi1zY2GqoPwRMBJA
	 /rTkhvibPuNlL8DTCEcth9Hc5ZjFjkSs12oHflaaPjU2ZnQjC5C/bfCmwNZD8UTRYf
	 caEGvaWwUxa7WSg524P69dnX5VhOogJ+5ZDBzDwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404470AbgE1Per (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 11:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404400AbgE1Per (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 11:34:47 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880D5207D3;
        Thu, 28 May 2020 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590680087;
        bh=i7fvGYYm+p8Uu0snT6GzRGMWwy+eqeQaF+Vpm53E7yc=;
        h=From:To:Cc:Subject:Date:From;
        b=RZH7gw49iCYi4QyvVVkp+gKQsT3HWK23Mfu3mZvLXoImQH+7JH8JIT1Be0BGRH83f
         AzAZJ2ttznLtyVhxCxgMvh7c7Dd9dUrzcGB9t8nC977xwRjfuumugazLqYAcNoRNjK
         4a1dmM+FxVpBa/gtuKui45MQyXDSJ6URXvlDV+mM=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/2] blk-mq: export __blk_mq_complete_request
Date:   Thu, 28 May 2020 08:34:40 -0700
Message-Id: <20200528153441.3501777-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For when drivers have a need to bypass error injection.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3: Use _GPL export

 block/blk-mq.c         | 3 ++-
 include/linux/blk-mq.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cac11945f602..e62559ac7c45 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -556,7 +556,7 @@ static void __blk_mq_complete_request_remote(void *data)
 	q->mq_ops->complete(rq);
 }
 
-static void __blk_mq_complete_request(struct request *rq)
+void __blk_mq_complete_request(struct request *rq)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct request_queue *q = rq->q;
@@ -602,6 +602,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	}
 	put_cpu();
 }
+EXPORT_SYMBOL_GPL(__blk_mq_complete_request);
 
 static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
 	__releases(hctx->srcu)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d7307795439a..cfe7eac3764e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -494,6 +494,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
+void __blk_mq_complete_request(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.24.1

