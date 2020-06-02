Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD80C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 07:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644C320772
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 07:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgFBHMO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:12:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgFBHMO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 03:12:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2C3B0AC2D;
        Tue,  2 Jun 2020 07:12:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 492481E1282; Tue,  2 Jun 2020 09:12:12 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, bvanassche@acm.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] blktrace: Avoid sparse warnings when assigning q->blk_trace
Date:   Tue,  2 Jun 2020 09:12:05 +0200
Message-Id: <20200602071205.22057-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
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
under q->blk_trace_mutex. So let's just replace xchg() with
rcu_replace_pointer() and cmpxchg() with explicit check and
rcu_assign_pointer(). This makes the code more efficient and sparse
happy.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 kernel/trace/blktrace.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

Here is version of my patch rebased on top of Luis' blktrace fixes. Luis, if
the patch looks fine, can you perhaps include it in your series since it seems
you'll do another revision of your series due to discussion over patch 5/7?
Thanks!

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ac6650828d49..13bc09e4594c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -346,7 +346,8 @@ static int __blk_trace_remove(struct request_queue *q)
 {
 	struct blk_trace *bt;
 
-	bt = xchg(&q->blk_trace, NULL);
+	bt = rcu_replace_pointer(q->blk_trace, NULL,
+				 lockdep_is_held(&q->blk_trace_mutex));
 	if (!bt)
 		return -EINVAL;
 
@@ -500,7 +501,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 * bdev can be NULL, as with scsi-generic, this is a helpful as
 	 * we can be.
 	 */
-	if (q->blk_trace) {
+	if (rcu_dereference_protected(q->blk_trace,
+				      lockdep_is_held(&q->blk_trace_mutex))) {
 		pr_warn("Concurrent blktraces are not allowed on %s\n",
 			buts->name);
 		return -EBUSY;
@@ -570,10 +572,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	bt->pid = buts->pid;
 	bt->trace_state = Blktrace_setup;
 
-	ret = -EBUSY;
-	if (cmpxchg(&q->blk_trace, NULL, bt))
-		goto err;
-
+	rcu_assign_pointer(q->blk_trace, bt);
 	get_probe_ref();
 
 	ret = 0;
@@ -1662,7 +1661,8 @@ static int blk_trace_remove_queue(struct request_queue *q)
 {
 	struct blk_trace *bt;
 
-	bt = xchg(&q->blk_trace, NULL);
+	bt = rcu_replace_pointer(q->blk_trace, NULL,
+				 lockdep_is_held(&q->blk_trace_mutex));
 	if (bt == NULL)
 		return -EINVAL;
 
@@ -1694,10 +1694,7 @@ static int blk_trace_setup_queue(struct request_queue *q,
 
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

