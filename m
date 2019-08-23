Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9374AC3A5A3
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694EB23406
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FQnInb4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfHWAPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:15:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30872 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbfHWAPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 20:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566519331; x=1598055331;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=2VOOI9y5LEc9gNFG0XBbhG4PU+RZhuVcJ68XilDuZH8=;
  b=FQnInb4UethKEcKqW6fFEhQ2cHbNvCWR6muWlDsWD1jV2ZRQfKVUTBaz
   NWzpYvQGUOIiNXVFIgfKp4NM/CAslH4EVln0Xrq+lVEvJLOtBduREhSza
   lDigH0zLIkjWvCcE5ysqmOx71FLMcmXYIzdqw4mlMJJ7+X25JEKg+kLK7
   EpFkYdnIWsbUtw9Le9ekWjZEcH/6KMUBMtwQYedNfvrSulgxl2le02m77
   Cr+fMNgsa/2Rt6wL+y5dq8LzXiF5LAD1VQvVcvcQIo2oAIsk9D3cGyRjd
   gv2sOepPlV2C26jGkBVMl9n/cNzUYyLQQiYFD8kN+F/mF2pHlw0rbBKcx
   g==;
IronPort-SDR: +H+DicjrgZCso2ZMERZTQL8mz3LDTqLwsf7GMRkuZb12sDfkngumVWeP20rYOQGIjq6xvu+0iD
 myErxpPqbcE1CeEw4mffAUQxyLboXUZpBFV5aXssHQHtPjfj3OFxpg5Y2mzYhTFQ7JCT2qpS4y
 4JYwcvXeizSh/d9jfdj1AyKATxumGXZykSay4XJneT+wwi6lGEU/FSWEEtfP4idGsh4RQqZgLh
 kTvU+AHcWMIJeI1NFqIHfFBHFT7uDpwSMeyw/kUemRv2dugT4IMILOFr++GFcChPwK7aHvlAhS
 j74=
X-IronPort-AV: E=Sophos;i="5.64,419,1559491200"; 
   d="scan'208";a="121063665"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 08:15:31 +0800
IronPort-SDR: VlikhWZdbDpAr0pgUMS8vg8wRYsdwVMfWhMgARRcSjsIHTPTk8aSaS4Oy+t4PXTpYLnLlTUZRe
 7+okyaLiCrXPXEdwHjHBVMv/YUuIl5SZfgv7LU4F10Iv0U2aW+E/CcjAM2J58i83RBi+S5Joci
 G4c5CZmjnT/wg52kjaxYB4MWRohtK7xMR3/z8TbqhZhjma5UpmsyiIfdXRRHEq1Na76QkdRWWe
 zokquc8zHakrbvzJUuWbRHpaVmTVch6WZgCpzmNwVdq295TFhYq65QDBsEQ/FGkH+DO2rftg3t
 dp30bmdc3+zMIvZK60QxzrXl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 17:12:50 -0700
IronPort-SDR: sBfg77FSBLsBaM3Xbw4KVf8zevcSNSrk9oFl/xiNScJuxvGHVNRJQYFjVEc2pv7JNCzpUekViu
 Ft2B80ktff0qYj4u0yKM5xzPsMg9hHcWALxypRwpY5IIzky2fJll63EZoUCxE7RHa3Q4wbzG4U
 9vxw6Kb8bGf122VJ86Nu1IsYapeIGdfwOCE/EuNx/otNGLQ+LBvH9y9UHSFY45rOnPxahb4beL
 MlgNmmIrJrZTVNTIFQ7FpqKK9OUArheToRG5h1fL3PnUimbHqpXJo31eKTzJmzTE5Scjk8orpJ
 ioA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2019 17:15:31 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/7] block: Change elevator_init_mq() to always succeed
Date:   Fri, 23 Aug 2019 09:15:23 +0900
Message-Id: <20190823001528.5673-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823001528.5673-1-damien.lemoal@wdc.com>
References: <20190823001528.5673-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the default elevator chosen is mq-deadline, elevator_init_mq() may
return an error if the mq-deadline initialization fails, leading to
blk_mq_init_allocated_queue() returning an error, which in turn will
cause the block device initialization to fail.

Instead of taking such extreme measure, handle mq-deadline
initialization failures in the same manner as if mq-deadline being not
available (no module to load), that is, default to the "none" scheduler.
With this change, elevator_init_mq() return type can be changed to void.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-mq.c   |  8 +-------
 block/blk.h      |  2 +-
 block/elevator.c | 17 ++++++++++-------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 556c774a0f0d..274e168c8535 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2846,8 +2846,6 @@ static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
-	int ret = -ENOMEM;
-
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
@@ -2908,14 +2906,10 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
 
-	ret = elevator_init_mq(q);
-	if (ret)
-		goto err_tag_set;
+	elevator_init_mq(q);
 
 	return q;
 
-err_tag_set:
-	blk_mq_del_queue_tag_set(q);
 err_hctxs:
 	kfree(q->queue_hw_ctx);
 	q->nr_hw_queues = 0;
diff --git a/block/blk.h b/block/blk.h
index de6b2e146d6e..ddb292bb6caf 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -184,7 +184,7 @@ void blk_account_io_done(struct request *req, u64 now);
 
 void blk_insert_flush(struct request *rq);
 
-int elevator_init_mq(struct request_queue *q);
+void elevator_init_mq(struct request_queue *q);
 int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e);
 void __elevator_exit(struct request_queue *, struct elevator_queue *);
diff --git a/block/elevator.c b/block/elevator.c
index 1ed2710f1950..7fff06751633 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -603,19 +603,19 @@ static inline bool elv_support_iosched(struct request_queue *q)
 
 /*
  * For blk-mq devices supporting IO scheduling, we default to using mq-deadline,
- * if available, for single queue devices. If deadline isn't available OR we
- * have multiple queues, default to "none".
+ * if available, for single queue devices. If deadline isn't available OR
+ * deadline initialization fails OR we have multiple queues, default to "none".
  */
-int elevator_init_mq(struct request_queue *q)
+void elevator_init_mq(struct request_queue *q)
 {
 	struct elevator_type *e;
 	int err = 0;
 
 	if (!elv_support_iosched(q))
-		return 0;
+		return;
 
 	if (q->nr_hw_queues != 1)
-		return 0;
+		return;
 
 	/*
 	 * q->sysfs_lock must be held to provide mutual exclusion between
@@ -630,11 +630,14 @@ int elevator_init_mq(struct request_queue *q)
 		goto out_unlock;
 
 	err = blk_mq_init_sched(q, e);
-	if (err)
+	if (err) {
+		pr_warn("\"%s\" elevator initialization failed, "
+			"falling back to \"none\"\n", e->elevator_name);
 		elevator_put(e);
+	}
+
 out_unlock:
 	mutex_unlock(&q->sysfs_lock);
-	return err;
 }
 
 
-- 
2.21.0

