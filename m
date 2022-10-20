Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A97C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 06:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJTGsm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 02:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJTGsl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 02:48:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E15772B40
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 23:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Wlo8fRYqW6+xZx083HZygOgmGyvn6Jzt9QsmvkGFJ9U=; b=KYuW+xg8BZ7WXr07Xp2IhUcUmx
        0rIGTnUIyc1c9G3lQU98QPI+z8PXba0SqKKjxLFxlioVJOcFCcR1tlVPmV/kk1sFVthsT5VsCvahn
        ILwmUNbQGPNwSCXpEpyLGBmbSKE/P9cSHoI1Vx7Eg1y/80/dhk0jcysG+nhuwiIJ+Cfgd0mUIOW63
        /PlzTsS+DRNUsz9ueh7o4OUrQADbPRs/GUJTj0B92aerUiQ5+hQctliJj8gsa0MHVz7crKf0uGMD0
        qAooy7vkD0ViYY9Se02K4FyGMra/61jQqlSEOMNHlBnXxTQI1NCLOZ30oj1MbFjkHiBQC9JDLs9vQ
        /DRlBQ/g==;
Received: from [88.128.92.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olPM3-00BJfN-3n; Thu, 20 Oct 2022 06:48:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinlong Chen <nickyc975@zju.edu.cn>, linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: fix up elevator_type refcounting
Date:   Thu, 20 Oct 2022 08:48:19 +0200
Message-Id: <20221020064819.1469928-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020064819.1469928-1-hch@lst.de>
References: <20221020064819.1469928-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jinlong Chen <nickyc975@zju.edu.cn>

The current reference management logic of io scheduler modules contains
refcnt problems. For example, blk_mq_init_sched may fail before or after
the calling of e->ops.init_sched. If it fails before the calling, it does
nothing to the reference to the io scheduler module. But if it fails after
the calling, it releases the reference by calling kobject_put(&eq->kobj).

As the callers of blk_mq_init_sched can't know exactly where the failure
happens, they can't handle the reference to the io scheduler module
properly: releasing the reference on failure results in double-release if
blk_mq_init_sched has released it, and not releasing the reference results
in ghost reference if blk_mq_init_sched did not release it either.

The same problem also exists in io schedulers' init_sched implementations.

We can address the problem by adding releasing statements to the error
handling procedures of blk_mq_init_sched and init_sched implementations.
But that is counterintuitive and requires modifications to existing io
schedulers.

Instead, We make elevator_alloc get the io scheduler module references
that will be released by elevator_release. And then, we match each
elevator_get with an elevator_put. Therefore, each reference to an io
scheduler module explicitly has its own getter and releaser, and we no
longer need to worry about the refcnt problems.

The bugs and the patch can be validated with tools here:
https://github.com/nickyc975/linux_elv_refcnt_bug.git

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
[hch: split out a few bits into separate patches, use a non-try
      module_get in elevator_alloc]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.c |  1 +
 block/blk-mq.c       |  2 ++
 block/elevator.c     | 10 +++++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a4f7c101b53b2..68227240fdea3 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -555,6 +555,7 @@ static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
 	return 0;
 }
 
+/* caller must have a reference to @e, will grab another one if successful */
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 {
 	unsigned int flags = q->tag_set->flags;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9db8814cdd02b..098432d3caf1c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4591,6 +4591,8 @@ static void blk_mq_elv_switch_back(struct list_head *head,
 
 	mutex_lock(&q->sysfs_lock);
 	elevator_switch(q, t);
+	/* drop the reference acquired in blk_mq_elv_switch_none */
+	elevator_put(t);
 	mutex_unlock(&q->sysfs_lock);
 }
 
diff --git a/block/elevator.c b/block/elevator.c
index 887becfe6a8d4..e36d132b47e1e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -165,6 +165,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 	if (unlikely(!eq))
 		return NULL;
 
+	__elevator_get(e);
 	eq->type = e;
 	kobject_init(&eq->kobj, &elv_ktype);
 	mutex_init(&eq->sysfs_lock);
@@ -708,8 +709,9 @@ void elevator_init_mq(struct request_queue *q)
 	if (err) {
 		pr_warn("\"%s\" elevator initialization failed, "
 			"falling back to \"none\"\n", e->elevator_name);
-		elevator_put(e);
 	}
+
+	elevator_put(e);
 }
 
 /*
@@ -741,6 +743,7 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 static int elevator_change(struct request_queue *q, const char *elevator_name)
 {
 	struct elevator_type *e;
+	int ret;
 
 	/* Make sure queue is not in the middle of being removed */
 	if (!blk_queue_registered(q))
@@ -761,8 +764,9 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	e = elevator_get(q, elevator_name, true);
 	if (!e)
 		return -EINVAL;
-
-	return elevator_switch(q, e);
+	ret = elevator_switch(q, e);
+	elevator_put(e);
+	return ret;
 }
 
 ssize_t elv_iosched_store(struct request_queue *q, const char *buf,
-- 
2.30.2

