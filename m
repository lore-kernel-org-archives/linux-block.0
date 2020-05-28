Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10FEC433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 09:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF18F2075F
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 09:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgE1J3Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 05:29:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:47780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbgE1J3P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 05:29:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2225AF3B;
        Thu, 28 May 2020 09:29:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C02221E1283; Thu, 28 May 2020 11:29:13 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] blktrace: Avoid sparse warnings when assigning q->blk_trace
Date:   Thu, 28 May 2020 11:29:10 +0200
Message-Id: <20200528092910.11118-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mostly for historical reasons, q->blk_trace is assigned through xchg()
and cmpxchg() atomic operations. Although this is correct, sparse
complains about this because it violates rcu annotations. Furthermore
there's no real need for atomic operations anymore since all changes to
q->blk_trace happen under q->blk_trace_mutex. So let's just replace
xchg() with rcu_replace_pointer() and cmpxchg() with explicit check and
rcu_assign_pointer(). This makes the code more efficient and sparse
happy.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 kernel/trace/blktrace.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ca39dc3230cb..e4a9ba85b76f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -344,7 +344,8 @@ static int __blk_trace_remove(struct request_queue *q)
 {
 	struct blk_trace *bt;
 
-	bt = xchg(&q->blk_trace, NULL);
+	bt = rcu_replace_pointer(q->blk_trace, NULL,
+				 lockdep_is_held(&q->blk_trace_mutex));
 	if (!bt)
 		return -EINVAL;
 
@@ -485,6 +486,10 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!blk_debugfs_root)
 		return -ENOENT;
 
+	if (rcu_dereference_protected(q->blk_trace,
+				      lockdep_is_held(&q->blk_trace_mutex)))
+		return -EBUSY;
+
 	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
 	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
 
@@ -543,10 +548,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	bt->pid = buts->pid;
 	bt->trace_state = Blktrace_setup;
 
-	ret = -EBUSY;
-	if (cmpxchg(&q->blk_trace, NULL, bt))
-		goto err;
-
+	rcu_assign_pointer(q->blk_trace, bt);
 	get_probe_ref();
 
 	ret = 0;
@@ -1637,7 +1639,8 @@ static int blk_trace_remove_queue(struct request_queue *q)
 {
 	struct blk_trace *bt;
 
-	bt = xchg(&q->blk_trace, NULL);
+	bt = rcu_replace_pointer(q->blk_trace, NULL,
+				 lockdep_is_held(&q->blk_trace_mutex));
 	if (bt == NULL)
 		return -EINVAL;
 
@@ -1669,10 +1672,7 @@ static int blk_trace_setup_queue(struct request_queue *q,
 
 	blk_trace_setup_lba(bt, bdev);
 
-	ret = -EBUSY;
-	if (cmpxchg(&q->blk_trace, NULL, bt))
-		goto free_bt;
-
+	rcu_assign_pointer(q->blk_trace, bt);
 	get_probe_ref();
 	return 0;
 
-- 
2.16.4

