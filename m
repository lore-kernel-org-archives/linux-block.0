Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CCAC07E9D
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 21:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiIZVJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiIZVJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 17:09:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D09512636
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 14:09:41 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QKCY8O024826
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 14:09:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=W9l02VgdafWaB7navFc6iYerCclLHuUXxLvgIBCPdMA=;
 b=cO/Rt12jGNUR1urDDVgjFwvtVHkT0QjhGwTZUL3FiX6W+/IHTauTaJQV5FJGtADCK7OV
 ripInxf9OjbaA4gnD+7YWzp+UOHwb5q/pG6BASqOr6UNsKdbQEqpMBloIUF4x9NTQnP3
 8NJNIFOWdynFUyd5wPwtD9RY4bdZd0//dxc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsydxx6fh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 14:09:40 -0700
Received: from twshared6240.04.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 14:09:39 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 799ED9116EF6; Mon, 26 Sep 2022 14:07:03 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH] blk-mq: use queisced elevator switch
Date:   Mon, 26 Sep 2022 14:07:02 -0700
Message-ID: <20220926210702.1776648-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qEVI_6NUhvcniv_dtFUTicY37WTtD9zn
X-Proofpoint-GUID: qEVI_6NUhvcniv_dtFUTicY37WTtD9zn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The hctx's work may be racing with the elevator switch that occurs when
reinitializing hardware queues. This happens because the queue is merely
frozen in this context, but that only prevents requests from allocating
and doesn't stop the hctx work from running. When swapping the io
scheduler, this leaves a race condition open where the work may get a
pointer to an elevator that's being torn down. Use the quiesced elevator
switch instead.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
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

