Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279E5ECAAA1
	for <linux-block@archiver.kernel.org>; Tue,  6 Sep 2022 23:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiIFXAh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Sep 2022 19:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiIFXAh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Sep 2022 19:00:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166037D1E0
        for <linux-block@vger.kernel.org>; Tue,  6 Sep 2022 16:00:35 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286F2mFh004553
        for <linux-block@vger.kernel.org>; Tue, 6 Sep 2022 16:00:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rSdkGaVv+7gcouh5LIlMqQ/dz2Csr1uZZfYId3pDryM=;
 b=niPAo4jdj0dnQy9wd0j37bxEGe7BoGrfoX+2OEcD6XZ7C130C6jUuCV2VHe7AvrnF+dI
 jupxTdd0oTUOYIK6lZ2tSBP/q0ZSUbs/Ycls/lv6HIuagj4th2P1LKSsDYGE7H7sjEFW
 y4D0zUj5xFqeccO2F5LMF9OW7rma6TjRAcU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3je0d0x1dx-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 06 Sep 2022 16:00:35 -0700
Received: from twshared1781.23.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 16:00:34 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id DE3F684BC4B4; Tue,  6 Sep 2022 16:00:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/2] sbitmap: fix batched wait_cnt accounting
Date:   Tue, 6 Sep 2022 16:00:29 -0700
Message-ID: <20220906230029.1287526-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220906230029.1287526-1-kbusch@fb.com>
References: <20220906230029.1287526-1-kbusch@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WDY1M25eklXgD5Br6nrw9s4RTH2Jz9fb
X-Proofpoint-ORIG-GUID: WDY1M25eklXgD5Br6nrw9s4RTH2Jz9fb
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
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
 block/blk-mq-tag.c      |  2 +-
 include/linux/sbitmap.h |  3 ++-
 lib/sbitmap.c           | 36 ++++++++++++++++++------------------
 3 files changed, 21 insertions(+), 20 deletions(-)

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
index ad0670b580d3..0a9a5d5049d9 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -599,27 +599,28 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbi=
tmap_queue *sbq)
 	return NULL;
 }
=20
-static bool __sbq_wake_up(struct sbitmap_queue *sbq)
+static bool __sbq_wake_up(struct sbitmap_queue *sbq, int nr)
 {
 	struct sbq_wait_state *ws;
-	unsigned int wake_batch;
-	int wait_cnt;
+	int wake_batch, wait_cnt, cur;
=20
 	ws =3D sbq_wake_ptr(sbq);
-	if (!ws)
+	if (!ws || !nr)
 		return false;
=20
 	if (!waitqueue_active(&ws->wait))
 		return true;
=20
-	wait_cnt =3D atomic_dec_return(&ws->wait_cnt);
-
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
 	if (wait_cnt > 0)
 		return false;
@@ -630,7 +631,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	 * Wake up first in case that concurrent callers decrease wait_cnt
 	 * while waitqueue is empty.
 	 */
-	wake_up_nr(&ws->wait, wake_batch);
+	wake_up_nr(&ws->wait, wake_batch - wait_cnt);
=20
 	/*
 	 * Pairs with the memory barrier in sbitmap_queue_resize() to
@@ -655,12 +656,11 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	return false;
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
@@ -697,7 +697,7 @@ void sbitmap_queue_clear_batch(struct sbitmap_queue *sb=
q, int offset,
 		atomic_long_andnot(mask, (atomic_long_t *) addr);
=20
 	smp_mb__after_atomic();
-	sbitmap_queue_wake_up(sbq);
+	sbitmap_queue_wake_up(sbq, nr_tags);
 	sbitmap_update_cpu_hint(&sbq->sb, raw_smp_processor_id(),
 					tags[nr_tags - 1] - offset);
 }
@@ -725,7 +725,7 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, uns=
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

