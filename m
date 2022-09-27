Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72691C6FA93
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 15:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiI0P5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiI0P5P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 11:57:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234C57A52B
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 08:56:58 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28REX401030466
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 08:56:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=eK7IizjpmJoGWCM/Foe7SAp6epAVBSkJvRtEeJbLa4M=;
 b=b+SQYYQI4E2BhOgnyjulmnfsHTK6g1qEKPm7MlKuwaUF+pNjRdh3l3343bg1EekInF9h
 Nt9E7lmlsD73VoEAG+ln0KfVeY8f61QHTc51vSxeWWVZUUnyc+aCnvTWGEm3Fp4VVezG
 orqknpS5ExexbdYcBaDFnfQNPBFcvLVpONc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3juntgvy59-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 08:56:57 -0700
Received: from twshared3028.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 08:56:57 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id A5C989191318; Tue, 27 Sep 2022 08:56:53 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2] blk-mq: use quiesced elevator switch when reinitializing queues
Date:   Tue, 27 Sep 2022 08:56:52 -0700
Message-ID: <20220927155652.3260724-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xAauH8WVkaHIDf3t1Rfne0Ryp9HtU35E
X-Proofpoint-GUID: xAauH8WVkaHIDf3t1Rfne0Ryp9HtU35E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_07,2022-09-27_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The hctx's run_work may be racing with the elevator switch when
reinitializing hardware queues. The queue is merely frozen in this
context, but that only prevents requests from allocating and doesn't
stop the hctx work from running. The work may get an elevator pointer
that's being torn down, and can result in use-after-free errors and
kernel panics (example below). Use the quiesced elevator switch instead,
and make the previous one static since it is now only used locally.

  nvme nvme0: resetting controller
  nvme nvme0: 32/0/0 default/read/poll queues
  BUG: kernel NULL pointer dereference, address: 0000000000000008
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 80000020c8861067 P4D 80000020c8861067 PUD 250f8c8067 PMD 0
  Oops: 0000 [#1] SMP PTI
  Workqueue: kblockd blk_mq_run_work_fn
  RIP: 0010:kyber_has_work+0x29/0x70

...

  Call Trace:
   __blk_mq_do_dispatch_sched+0x83/0x2b0
   __blk_mq_sched_dispatch_requests+0x12e/0x170
   blk_mq_sched_dispatch_requests+0x30/0x60
   __blk_mq_run_hw_queue+0x2b/0x50
   process_one_work+0x1ef/0x380
   worker_thread+0x2d/0x3e0

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v1->v2:

  Updates to changelog subject, message, and reviewers. The title
  exceeds the recommended 50-char limit, but anything shorter will not
  capture the intent.

 block/blk-mq.c   | 6 +++---
 block/blk.h      | 3 +--
 block/elevator.c | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 29bb48de5bda..034b24aad3fe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4470,14 +4470,14 @@ static bool blk_mq_elv_switch_none(struct list_he=
ad *head,
 	list_add(&qe->node, head);
=20
 	/*
-	 * After elevator_switch_mq, the previous elevator_queue will be
+	 * After elevator_switch, the previous elevator_queue will be
 	 * released by elevator_release. The reference of the io scheduler
 	 * module get by elevator_get will also be put. So we need to get
 	 * a reference of the io scheduler module here to prevent it to be
 	 * removed.
 	 */
 	__module_get(qe->type->elevator_owner);
-	elevator_switch_mq(q, NULL);
+	elevator_switch(q, NULL);
 	mutex_unlock(&q->sysfs_lock);
=20
 	return true;
@@ -4509,7 +4509,7 @@ static void blk_mq_elv_switch_back(struct list_head=
 *head,
 	kfree(qe);
=20
 	mutex_lock(&q->sysfs_lock);
-	elevator_switch_mq(q, t);
+	elevator_switch(q, t);
 	mutex_unlock(&q->sysfs_lock);
 }
=20
diff --git a/block/blk.h b/block/blk.h
index d7142c4d2fef..52432eab621e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -270,8 +270,7 @@ bool blk_bio_list_merge(struct request_queue *q, stru=
ct list_head *list,
=20
 void blk_insert_flush(struct request *rq);
=20
-int elevator_switch_mq(struct request_queue *q,
-			      struct elevator_type *new_e);
+int elevator_switch(struct request_queue *q, struct elevator_type *new_e=
);
 void elevator_exit(struct request_queue *q);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index c319765892bb..bd71f0fc4e4b 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -588,7 +588,7 @@ void elv_unregister(struct elevator_type *e)
 }
 EXPORT_SYMBOL_GPL(elv_unregister);
=20
-int elevator_switch_mq(struct request_queue *q,
+static int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e)
 {
 	int ret;
@@ -723,7 +723,7 @@ void elevator_init_mq(struct request_queue *q)
  * need for the new one. this way we have a chance of going back to the =
old
  * one, if the new one fails init for some reason.
  */
-static int elevator_switch(struct request_queue *q, struct elevator_type=
 *new_e)
+int elevator_switch(struct request_queue *q, struct elevator_type *new_e=
)
 {
 	int err;
=20
--=20
2.30.2

