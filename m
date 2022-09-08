Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F438C54EE9
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 21:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIHVxB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHVxA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 17:53:00 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA55FE4A4
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 14:52:59 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288LqrZB028275
        for <linux-block@vger.kernel.org>; Thu, 8 Sep 2022 14:52:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=0z2cAUmv0R4fHZps4ghap9epLVNFTHABSccNsUhIaAc=;
 b=mxwTsBLpj5YfYHnpfDq1cncpH50BnQnJHQRD4p3I5zXhlZP8DdW7X0ondQ32r3IRFkxD
 TKMHzKS7XYKqcpj1xon45Fg7dKceJvgbHtx29+Y9weo7tqQNQU7stmERP99rFqFZLttC
 DklPy4RzV/frRq9uftTM9Ksab/8Xs1a/w0s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jfk74jrqv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 08 Sep 2022 14:52:58 -0700
Received: from twshared7509.08.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 14:51:39 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id A94DC8601C58; Thu,  8 Sep 2022 14:51:35 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4] sbitmap: fix batched wait_cnt accounting
Date:   Thu, 8 Sep 2022 14:51:32 -0700
Message-ID: <20220908215132.3243008-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aGxvn9wauCA76eXdYLbyZw55b0hZI5fq
X-Proofpoint-GUID: aGxvn9wauCA76eXdYLbyZw55b0hZI5fq
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Batched completions can clear multiple bits, but we're only decrementing
the wait_cnt by one each time. This can cause waiters to never be woken,
stalling IO. Use the batched count instead.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215679
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v3->v4:

  Merged to the latest block for-6.1/block that contains the dependency
  fix that I attempted to implement in v3.

 block/blk-mq-tag.c      |  2 +-
 include/linux/sbitmap.h |  3 ++-
 lib/sbitmap.c           | 34 ++++++++++++++++++----------------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 8e3b36d1cb57..9eb968e14d31 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -196,7 +196,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *d=
ata)
 		 * other allocations on previous queue won't be starved.
 		 */
 		if (bt !=3D bt_prev)
-			sbitmap_queue_wake_up(bt_prev);
+			sbitmap_queue_wake_up(bt_prev, 1);
=20
 		ws =3D bt_wait_ptr(bt, data->hctx);
 	} while (1);
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 8f5a86e210b9..4d2d5205ab58 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -575,8 +575,9 @@ void sbitmap_queue_wake_all(struct sbitmap_queue *sbq);
  * sbitmap_queue_wake_up() - Wake up some of waiters in one waitqueue
  * on a &struct sbitmap_queue.
  * @sbq: Bitmap queue to wake up.
+ * @nr: Number of bits cleared.
  */
-void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
+void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr);
=20
 /**
  * sbitmap_queue_show() - Dump &struct sbitmap_queue information to a &str=
uct
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index cbfd2e677d87..cd631d2e4737 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -599,24 +599,27 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbi=
tmap_queue *sbq)
 	return NULL;
 }
=20
-static bool __sbq_wake_up(struct sbitmap_queue *sbq)
+static bool __sbq_wake_up(struct sbitmap_queue *sbq, int nr)
 {
 	struct sbq_wait_state *ws;
 	unsigned int wake_batch;
-	int wait_cnt;
+	int wait_cnt, cur;
 	bool ret;
=20
 	ws =3D sbq_wake_ptr(sbq);
-	if (!ws)
+	if (!ws || nr <=3D 0)
 		return false;
=20
-	wait_cnt =3D atomic_dec_return(&ws->wait_cnt);
-	/*
-	 * For concurrent callers of this, callers should call this function
-	 * again to wakeup a new batch on a different 'ws'.
-	 */
-	if (wait_cnt < 0)
-		return true;
+	cur =3D atomic_read(&ws->wait_cnt);
+	do {
+		/*
+		 * For concurrent callers of this, callers should call this
+		 * function again to wakeup a new batch on a different 'ws'.
+		 */
+		if (cur <=3D 0)
+			return true;
+		wait_cnt =3D cur - nr;
+	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
=20
 	/*
 	 * If we decremented queue without waiters, retry to avoid lost
@@ -638,7 +641,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	 * Wake up first in case that concurrent callers decrease wait_cnt
 	 * while waitqueue is empty.
 	 */
-	wake_up_nr(&ws->wait, wake_batch);
+	wake_up_nr(&ws->wait, wake_batch - wait_cnt);
=20
 	/*
 	 * Pairs with the memory barrier in sbitmap_queue_resize() to
@@ -663,12 +666,11 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	return ret;
 }
=20
-void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
+void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
 {
-	while (__sbq_wake_up(sbq))
+	while (__sbq_wake_up(sbq, nr))
 		;
 }
-EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
=20
 static inline void sbitmap_update_cpu_hint(struct sbitmap *sb, int cpu, in=
t tag)
 {
@@ -705,7 +707,7 @@ void sbitmap_queue_clear_batch(struct sbitmap_queue *sb=
q, int offset,
 		atomic_long_andnot(mask, (atomic_long_t *) addr);
=20
 	smp_mb__after_atomic();
-	sbitmap_queue_wake_up(sbq);
+	sbitmap_queue_wake_up(sbq, nr_tags);
 	sbitmap_update_cpu_hint(&sbq->sb, raw_smp_processor_id(),
 					tags[nr_tags - 1] - offset);
 }
@@ -733,7 +735,7 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, uns=
igned int nr,
 	 * waiter. See the comment on waitqueue_active().
 	 */
 	smp_mb__after_atomic();
-	sbitmap_queue_wake_up(sbq);
+	sbitmap_queue_wake_up(sbq, 1);
 	sbitmap_update_cpu_hint(&sbq->sb, cpu, nr);
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_clear);
--=20
2.30.2

