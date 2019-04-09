Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BDFC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3AB20651
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O2Ci7LUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfDIJJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:09:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46356 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDIJJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 05:09:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3993ceG030477;
        Tue, 9 Apr 2019 09:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=XoCGbypPfVgywZhfIvQD9juZEXsILJVfuiOaDvsV7UI=;
 b=O2Ci7LUl/Mt8fIqdNnWqL0lYoE4xT1pNkbsV0mBKIzjXf3Iuml7jDWSv/kEpAb8Lgczt
 qcuKb3gxHLRdcP18KnLQoN0zs8CKTD26rvs8Be/uZMzuHyDV5ykRJTCjpgr9hUW/xWMx
 KP2yHMm2Byb6fSqpTRyOupIoqQbvQfndUvbkG5yHihKUD4MUMPAqvJ1aQlLSE6J4sLQm
 XAN3/0cFKCXQBHlPEsILcun9CamZIqJa9KAdGjBf3687cmO98QjrK2f1Ug6qi614g11z
 zWIObL1Scd0/fpKosQnvNPCI+ADoxRoCGLxF8gQbSrnpOUg+WLUrDhJudyZOfEuzJmTe 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rphmebue3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 09:09:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3998SvQ064298;
        Tue, 9 Apr 2019 09:09:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rph7sff0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 09:09:09 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x399968H019284;
        Tue, 9 Apr 2019 09:09:07 GMT
Received: from localhost.localdomain (/101.95.182.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 02:09:05 -0700
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     shirley.ma@oracle.com, martin.petersen@oracle.com,
        Bob Liu <bob.liu@oracle.com>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] blk-mq: fix hang caused by freeze/unfreeze sequence
Date:   Tue,  9 Apr 2019 17:08:28 +0800
Message-Id: <20190409090828.16282-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090060
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090060
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch was proposed by Roman Pen[3] years ago.
Recently we hit a bug which is likely caused by the same reason,so rebased his
fix to v5.1 and resend.
Below is almost copied from that patch[3].

------
Long time ago there was a similar fix proposed by Akinobu Mita[1],
but it seems that time everyone decided to fix this subtle race in
percpu-refcount and Tejun Heo[2] did an attempt (as I can see that
patchset was not applied).

The following is a description of a hang in blk_mq_freeze_queue_wait() -
same fix but a bug from another angle.

The hang happens on attempt to freeze a queue while another task does
queue unfreeze.

The root cause is an incorrect sequence of percpu_ref_reinit() and
percpu_ref_kill() and as a result those two can be swapped:

 CPU#0               CPU#1
 ----------------    -----------------
 percpu_ref_kill()

                     percpu_ref_kill() << atomic reference does
 percpu_ref_reinit()                   << not guarantee the order

                     blk_mq_freeze_queue_wait() << HANG HERE

                     percpu_ref_reinit()

Firstly this wrong sequence raises two kernel warnings:

  1st. WARNING at lib/percpu-recount.c:309
       percpu_ref_kill_and_confirm called more than once

  2nd. WARNING at lib/percpu-refcount.c:331

But the most unpleasant effect is a hang of a blk_mq_freeze_queue_wait(),
which waits for a zero of a q_usage_counter, which never happens
because percpu-ref was reinited (instead of being killed) and stays in
PERCPU state forever.

The simplified sequence above can be reproduced on shared tags, when
queue A is going to die meanwhile another queue B is in init state and
is trying to freeze the queue A, which shares the same tags set:

 CPU#0                           CPU#1
 ------------------------------- ------------------------------------
 q1 = blk_mq_init_queue(shared_tags)

                                q2 = blk_mq_init_queue(shared_tags):
                                  blk_mq_add_queue_tag_set(shared_tags):
                                    blk_mq_update_tag_set_depth(shared_tags):
                                      blk_mq_freeze_queue(q1)
 blk_cleanup_queue(q1)                 ...
   blk_mq_freeze_queue(q1)   <<<->>>   blk_mq_unfreeze_queue(q1)

[1] Message id: 1443287365-4244-7-git-send-email-akinobu.mita@gmail.com
[2] Message id: 1443563240-29306-6-git-send-email-tj@kernel.org
[3] https://patchwork.kernel.org/patch/9268199/

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Signed-off-by: Bob Liu <bob.liu@oracle.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
 v3:
   - rebase to v5.1
 v2:
   - forgotten hunk from local repo
   - minor tweaks in the commit message
---
 block/blk-core.c       |  3 ++-
 block/blk-mq.c         | 19 ++++++++++---------
 include/linux/blkdev.h |  7 ++++++-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a55389b..fb97497 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -433,7 +433,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		smp_rmb();

 		wait_event(q->mq_freeze_wq,
-			   (atomic_read(&q->mq_freeze_depth) == 0 &&
+			   (!q->mq_freeze_depth &&
 			    (pm || (blk_pm_request_resume(q),
 				    !blk_queue_pm_only(q)))) ||
 			   blk_queue_dying(q));
@@ -523,6 +523,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	spin_lock_init(&q->queue_lock);

 	init_waitqueue_head(&q->mq_freeze_wq);
+	mutex_init(&q->mq_freeze_lock);

 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a935483..373af60 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -143,13 +143,14 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,

 void blk_freeze_queue_start(struct request_queue *q)
 {
-	int freeze_depth;
-
-	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
-	if (freeze_depth == 1) {
+	mutex_lock(&q->mq_freeze_lock);
+	if (++q->mq_freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
+		mutex_unlock(&q->mq_freeze_lock);
 		if (queue_is_mq(q))
 			blk_mq_run_hw_queues(q, false);
+	} else {
+		mutex_unlock(&q->mq_freeze_lock);
 	}
 }
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
@@ -198,14 +199,14 @@ EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);

 void blk_mq_unfreeze_queue(struct request_queue *q)
 {
-	int freeze_depth;
-
-	freeze_depth = atomic_dec_return(&q->mq_freeze_depth);
-	WARN_ON_ONCE(freeze_depth < 0);
-	if (!freeze_depth) {
+	mutex_lock(&q->mq_freeze_lock);
+	q->mq_freeze_depth--;
+	WARN_ON_ONCE(q->mq_freeze_depth < 0);
+	if (!q->mq_freeze_depth) {
 		percpu_ref_resurrect(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
+	mutex_unlock(&q->mq_freeze_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5c58a3b..64f7683 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -535,7 +535,7 @@ struct request_queue {

 	struct mutex		sysfs_lock;

-	atomic_t		mq_freeze_depth;
+	int			mq_freeze_depth;

 #if defined(CONFIG_BLK_DEV_BSG)
 	struct bsg_class_device bsg_dev;
@@ -547,6 +547,11 @@ struct request_queue {
 #endif
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
+	/*
+	 * Protect concurrent access to q_usage_counter by
+	 * percpu_ref_kill() and percpu_ref_reinit().
+	 */
+	struct mutex		mq_freeze_lock;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;

--
2.9.5

