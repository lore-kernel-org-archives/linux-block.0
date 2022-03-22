Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD16C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 16:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiCVQOR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 12:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbiCVQOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 12:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FD4C3E5D2
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647965568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EV5MoeoG91KZsc0uHqdOpqCHp+2VunX+WjaZpR1x+rQ=;
        b=OyS8wYi5dF+2LdDP1b+fhTcdIJo9kwPHVAqdZDOrFImrrrdd/1EfpbcoX4jWdsC3sdGEA7
        RYp5x1MgN9puQ8dsg5+tOKskkVNt7e/BLakUwtRZqnCaxq05RLy0xfBlasOa/ivI3hfAM2
        pgwLSzydAIrWYE7KWOTlkbM9necZiFk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-s64Jr41oOKiZFmL0k0m_xQ-1; Tue, 22 Mar 2022 12:12:46 -0400
X-MC-Unique: s64Jr41oOKiZFmL0k0m_xQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 224802805508;
        Tue, 22 Mar 2022 16:12:46 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 584D5465174;
        Tue, 22 Mar 2022 16:12:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: avoid to call blkg_free() in atomic context
Date:   Wed, 23 Mar 2022 00:12:38 +0800
Message-Id: <20220322161238.2006448-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkg_free() may be called in atomic context, either spin lock is held,
or run in rcu callback. Meantime either request queue's release handler
or ->pd_free_fn can sleep.

Fix the issue by scheduling work function for freeing blkcg_gq instance.

Cc: Tejun Heo <tj@kernel.org>
Fixes: 0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt")
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c         | 14 +++++++++++++-
 include/linux/blk-cgroup.h |  5 ++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d53b0d69dd73..89a976d3ab74 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -71,8 +71,10 @@ static bool blkcg_policy_enabled(struct request_queue *q,
  *
  * Free @blkg which may be partially allocated.
  */
-static void blkg_free(struct blkcg_gq *blkg)
+static void blkg_free_workfn(struct work_struct *work)
 {
+	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
+					     free_work);
 	int i;
 
 	if (!blkg)
@@ -89,6 +91,16 @@ static void blkg_free(struct blkcg_gq *blkg)
 	kfree(blkg);
 }
 
+static void blkg_free(struct blkcg_gq *blkg)
+{
+	/*
+	 * Both ->pd_free_fn() and request queue's release handler may
+	 * sleep, so free us by scheduling one work func
+	 */
+	INIT_WORK(&blkg->free_work, blkg_free_workfn);
+	schedule_work(&blkg->free_work);
+}
+
 static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index f2ad8ed8f777..652cd05b0924 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -95,7 +95,10 @@ struct blkcg_gq {
 
 	spinlock_t			async_bio_lock;
 	struct bio_list			async_bios;
-	struct work_struct		async_bio_work;
+	union {
+		struct work_struct	async_bio_work;
+		struct work_struct	free_work;
+	};
 
 	atomic_t			use_delay;
 	atomic64_t			delay_nsec;
-- 
2.31.1

