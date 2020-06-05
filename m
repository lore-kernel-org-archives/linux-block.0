Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67898C433E1
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4348D2065C
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 14:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgFEO6p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:58:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgFEO6p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 10:58:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DD2A8B485;
        Fri,  5 Jun 2020 14:58:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B743A1E1282; Fri,  5 Jun 2020 16:58:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] blktrace: Avoid sparse warnings when assigning q->blk_trace
Date:   Fri,  5 Jun 2020 16:58:37 +0200
Message-Id: <20200605145840.1145-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200605145349.18454-1-jack@suse.cz>
References: <20200605145349.18454-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mostly for historical reasons, q->blk_trace is assigned through xchg()
and cmpxchg() atomic operations. Although this is correct, sparse
complains about this because it violates rcu annotations since commit
c780e86dd48e ("blktrace: Protect q->blk_trace with RCU") which started
to use rcu for accessing q->blk_trace. Furthermore there's no real need
for atomic operations anymore since all changes to q->blk_trace happen
under q->blk_trace_mutex and since it also makes more sense to check if
q->blk_trace is set with the mutex held earlier.

So let's just replace xchg() with rcu_replace_pointer() and cmpxchg()
with explicit check and rcu_assign_pointer(). This makes the code more
efficient and sparse happy.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 kernel/trace/blktrace.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1a1943d39802..1b8e2eaf23f7 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -347,7 +347,8 @@ static int __blk_trace_remove(struct request_queue *q)
 {
 	struct blk_trace *bt;
 
-	bt = xchg(&q->blk_trace, NULL);
+	bt = rcu_replace_pointer(q->blk_trace, NULL,
+				 lockdep_is_held(&q->blk_trace_mutex));
 	if (!bt)
 		return -EINVAL;
 
@@ -501,7 +502,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 * bdev can be NULL, as with scsi-generic, this is a helpful as
 	 * we can be.
 	 */
-	if (q->blk_trace) {
+	if (rcu_dereference_protected(q->blk_trace,
+				      lockdep_is_held(&q->blk_trace_mutex))) {
 		pr_warn("Concurrent blktraces are not allowed on %s\n",
 			buts->name);
 		return -EBUSY;
@@ -556,10 +558,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	bt->pid = buts->pid;
 	bt->trace_state = Blktrace_setup;
 
-	ret = -EBUSY;
-	if (cmpxchg(&q->blk_trace, NULL, bt))
-		goto err;
-
+	rcu_assign_pointer(q->blk_trace, bt);
 	get_probe_ref();
 
 	ret = 0;
@@ -1650,7 +1649,8 @@ static int blk_trace_remove_queue(struct request_queue *q)
 {
 	struct blk_trace *bt;
 
-	bt = xchg(&q->blk_trace, NULL);
+	bt = rcu_replace_pointer(q->blk_trace, NULL,
+				 lockdep_is_held(&q->blk_trace_mutex));
 	if (bt == NULL)
 		return -EINVAL;
 
@@ -1682,10 +1682,7 @@ static int blk_trace_setup_queue(struct request_queue *q,
 
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

