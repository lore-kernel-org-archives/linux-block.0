Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E7AC282E1
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 10:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86816217FA
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 10:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fEX4myZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfDYKck (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:32:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59028 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfDYKck (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 06:32:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3PAIvWE004073;
        Thu, 25 Apr 2019 10:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=xdANYl6fSEzdzL4N5hz6RPXEDgzV2XxjUIiPRhSj/Zk=;
 b=fEX4myZIq7NifUaGFhJP5zWMLy8F2m8ejq1iRwlG5ZbeD9XBV90idrQecsI7Hlc33WE8
 23Zpkd6mDNuLS0cga+5fwQRr9jQwJbnvS7GOrmkaUr7SZmS/fFZqLkqY7aIto9KaJKjp
 g7ScKlDVqWPcOS5h/ClST/rvrzlPjQKS/DXjuKCVSv1yIby/Bb4uFwCGwLJ7ukGYaIEa
 7od1bAutLglklIEldQ6VZeIeupGmU9mWG+NtU577x0Fy+N3hs8xxuIjwgX1f/pD3UV31
 f9fvuNpzHLfK57tEFWNI013xihIn3+z3u8mguCA+dqk7VS0SKeBv7CN3/ixvx5oqUtWW oQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ryv2qfed5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 10:32:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3PASl90160868;
        Thu, 25 Apr 2019 10:30:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2s0dwfb05e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 10:30:10 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3PAU806006422;
        Thu, 25 Apr 2019 10:30:09 GMT
Received: from localhost.localdomain (/101.95.182.98) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Thu, 25 Apr 2019 03:29:55 -0700
MIME-Version: 1.0
Message-ID: <20190425102846.28911-1-bob.liu@oracle.com>
Date:   Thu, 25 Apr 2019 03:28:46 -0700 (PDT)
From:   Bob Liu <bob.liu@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        jinpuwang@gmail.com, rpenyaev@suse.de, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH v4] blk-mq: fix hang caused by freeze/unfreeze sequence
X-Mailer: git-send-email 2.9.5
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904250067
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904250067
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following is a description of a hang in blk_mq_freeze_queue_wait().
The hang happens on attempting to freeze a queue while another task does
queue unfreeze.

The root cause is an incorrect sequence of percpu_ref_resurrect() and
percpu_ref_kill() and as a result those two can be swapped:

 CPU#0                         CPU#1
 ----------------              -----------------
 q1 = blk_mq_init_queue(shared_tags)

                                q2 = blk_mq_init_queue(shared_tags)
                                  blk_mq_add_queue_tag_set(shared_tags)
                                    blk_mq_update_tag_set_depth(shared_tags)
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

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 v4:
   - Update commit log
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

