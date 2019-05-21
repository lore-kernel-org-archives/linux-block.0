Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD75C04AAC
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 03:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2936321743
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 03:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T+Dxe7Fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEUD0u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 23:26:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40382 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEUD0u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 23:26:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4L3OOAA102389;
        Tue, 21 May 2019 03:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ms/yO2cVAZlAe5B7/bbWhMORCl5zDDhIAl2cusS8HK0=;
 b=T+Dxe7Fee073Q7Ot+UjFkGoaTn2je7TZOL32O6wy2zHLFmQeIJyh59CXtyvgm7PHXHRy
 2b66ONLSSHmQx3Rk2KoHahUEmj4tloQOR8wpeGB/qGKJttc9ZHoL1EkrBIW0wVgHOqMz
 22Yyp7O98dfVSxhqr3XpE3oQL568XhMIh/BTw3vqPmmZFrgfoDe/clkoPRcAFb8y8jez
 sJ2MriOzkAynsDx7VZtR3uCynmOCZbtLoPe97mJbTml9DoEI1RQgZ0H1OAq5P/2VqcW7
 79EiSv1r+jMoy4woCgHr6RRTe4lAiNv80x41L4gGE/ubdTCil9Ukvz6eeWqmciiiwaAk yA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sj9ftajxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 03:26:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4L3QPmR166265;
        Tue, 21 May 2019 03:26:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2skudb4uk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 03:26:27 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4L3QKnk016391;
        Tue, 21 May 2019 03:26:21 GMT
Received: from localhost.localdomain (/101.95.182.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 03:26:20 +0000
From:   Bob Liu <bob.liu@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        jinpuwang@gmail.com, rpenyaev@suse.de,
        Bob Liu <bob.liu@oracle.com>,
        Roman Pen <roman.penyaev@profitbricks.com>
Subject: [RESEND PATCH v4] blk-mq: fix hang caused by freeze/unfreeze sequence
Date:   Tue, 21 May 2019 11:25:55 +0800
Message-Id: <20190521032555.31993-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210019
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210020
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following is a description of a hang in blk_mq_freeze_queue_wait().
The hang happens on attempt to freeze a queue while another task does
queue unfreeze.

The root cause is an incorrect sequence of percpu_ref_resurrect() and
percpu_ref_kill() and as a result those two can be swapped:

 CPU#0                         CPU#1
 ----------------              -----------------
 q1 = blk_mq_init_queue(shared_tags)

                                q2 = blk_mq_init_queue(shared_tags):
                                  blk_mq_add_queue_tag_set(shared_tags):
                                    blk_mq_update_tag_set_depth(shared_tags):
				     list_for_each_entry()
                                      blk_mq_freeze_queue(q1)
                                       > percpu_ref_kill()
                                       > blk_mq_freeze_queue_wait()

 blk_cleanup_queue(q1)
  blk_mq_freeze_queue(q1)
   > percpu_ref_kill()
                 ^^^^^^ freeze_depth can't guarantee the order

                                      blk_mq_unfreeze_queue()
                                        > percpu_ref_resurrect()

   > blk_mq_freeze_queue_wait()
                 ^^^^^^ Hang here!!!!

This wrong sequence raises kernel warning:
percpu_ref_kill_and_confirm called more than once on blk_queue_usage_counter_release!
WARNING: CPU: 0 PID: 11854 at lib/percpu-refcount.c:336 percpu_ref_kill_and_confirm+0x99/0xb0

But the most unpleasant effect is a hang of a blk_mq_freeze_queue_wait(),
which waits for a zero of a q_usage_counter, which never happens
because percpu-ref was reinited (instead of being killed) and stays in
PERCPU state forever.

How to reproduce:
 - "insmod null_blk.ko shared_tags=1 nr_devices=0 queue_mode=2"
 - cpu0: python Script.py 0; taskset the corresponding process running on cpu0
 - cpu1: python Script.py 1; taskset the corresponding process running on cpu1

 Script.py:
 ------
 #!/usr/bin/python3

import os
import sys

while True:
    on = "echo 1 > /sys/kernel/config/nullb/%s/power" % sys.argv[1]
    off = "echo 0 > /sys/kernel/config/nullb/%s/power" % sys.argv[1]
    os.system(on)
    os.system(off)
------

This bug was first reported and fixed by Roman, previous discussion:
[1] Message id: 1443287365-4244-7-git-send-email-akinobu.mita@gmail.com
[2] Message id: 1443563240-29306-6-git-send-email-tj@kernel.org
[3] https://patchwork.kernel.org/patch/9268199/

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Signed-off-by: Bob Liu <bob.liu@oracle.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c       |  3 ++-
 block/blk-mq.c         | 19 ++++++++++---------
 include/linux/blkdev.h |  7 ++++++-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 419d600..1bf83a0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -413,7 +413,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		smp_rmb();
 
 		wait_event(q->mq_freeze_wq,
-			   (atomic_read(&q->mq_freeze_depth) == 0 &&
+			   (!q->mq_freeze_depth &&
 			    (pm || (blk_pm_request_resume(q),
 				    !blk_queue_pm_only(q)))) ||
 			   blk_queue_dying(q));
@@ -503,6 +503,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	spin_lock_init(&q->queue_lock);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
+	mutex_init(&q->mq_freeze_lock);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 08a6248..32b8ad3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -144,13 +144,14 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 
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
@@ -199,14 +200,14 @@ EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
 
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
index 1aafeb9..592669b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -542,7 +542,7 @@ struct request_queue {
 	struct list_head	unused_hctx_list;
 	spinlock_t		unused_hctx_lock;
 
-	atomic_t		mq_freeze_depth;
+	int			mq_freeze_depth;
 
 #if defined(CONFIG_BLK_DEV_BSG)
 	struct bsg_class_device bsg_dev;
@@ -554,6 +554,11 @@ struct request_queue {
 #endif
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
+	/*
+	 * Protect concurrent access to q_usage_counter by
+	 * percpu_ref_kill() and percpu_ref_reinit().
+	 */
+	struct mutex		mq_freeze_lock;
 	struct percpu_ref	q_usage_counter;
 
 	struct blk_mq_tag_set	*tag_set;
-- 
2.9.5

