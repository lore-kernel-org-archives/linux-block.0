Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AAEC00140
	for <linux-block@archiver.kernel.org>; Wed, 24 Aug 2022 17:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbiHXRBZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Aug 2022 13:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbiHXRAj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Aug 2022 13:00:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBB340BD0
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 10:00:33 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OE7Bn4031986
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 10:00:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=4OcnsB8T+960cpg+rADBjmt5u+yoJVErj6otQ0N+uj0=;
 b=ORzhdgpkXIAtEmSBW8mkaD+ZZ4uTQT/ahVMseDGjelzTCAnSm0H1S/npMuZyROOUMEzr
 tgnVi7RM6MjJrkdBLT85Vhs2y4CmBp7+Nl7TCwdhiAaYuy5miAa21vxeCvahTyGJ2PVj
 YoiHb/VqvIQy/1QDe3txquFSLoGcEyMq4nQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5nfc9ast-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 10:00:33 -0700
Received: from twshared25684.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 10:00:31 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id A42BB7BFB028; Wed, 24 Aug 2022 10:00:24 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH] sbitmap: fix batched wait_cnt accounting
Date:   Wed, 24 Aug 2022 10:00:23 -0700
Message-ID: <20220824170023.3241858-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: AiLbfrTcZ0IYhVeNfT1015kdb7abhVxH
X-Proofpoint-ORIG-GUID: AiLbfrTcZ0IYhVeNfT1015kdb7abhVxH
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_09,2022-08-22_02,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Batched completions can clear multiple bits, but we're only decrementing
the wait_cnt by one each time. This can cause waiters to never be woken,
stalling IO. Use the batched account instead.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215679
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-tag.c      |  2 +-
 include/linux/sbitmap.h |  3 ++-
 lib/sbitmap.c           | 23 ++++++++++++-----------
 3 files changed, 15 insertions(+), 13 deletions(-)

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
index 8f5a86e210b9..3062ce6534fb 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -575,8 +575,9 @@ void sbitmap_queue_wake_all(struct sbitmap_queue *sbq);
  * sbitmap_queue_wake_up() - Wake up some of waiters in one waitqueue
  * on a &struct sbitmap_queue.
  * @sbq: Bitmap queue to wake up.
+ * @nr: Number of tags being released.
  */
-void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
+void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr);
=20
 /**
  * sbitmap_queue_show() - Dump &struct sbitmap_queue information to a &str=
uct
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 1f31147872e6..b1fd7cab6f1a 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -600,17 +600,20 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbi=
tmap_queue *sbq)
 	return NULL;
 }
=20
-static bool __sbq_wake_up(struct sbitmap_queue *sbq)
+static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
 {
 	struct sbq_wait_state *ws;
-	unsigned int wake_batch;
-	int wait_cnt;
+	int wake_batch, wait_cnt, sub;
=20
 	ws =3D sbq_wake_ptr(sbq);
-	if (!ws)
+	if (!ws || !(*nr))
 		return false;
=20
-	wait_cnt =3D atomic_dec_return(&ws->wait_cnt);
+	wake_batch =3D READ_ONCE(sbq->wake_batch);
+	sub =3D min3(wake_batch, *nr, atomic_read(&ws->wait_cnt));
+	wait_cnt =3D atomic_sub_return(sub, &ws->wait_cnt);
+	*nr -=3D sub;
+
 	/*
 	 * For concurrent callers of this, callers should call this function
 	 * again to wakeup a new batch on a different 'ws'.
@@ -621,7 +624,6 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	if (wait_cnt > 0)
 		return false;
=20
-	wake_batch =3D READ_ONCE(sbq->wake_batch);
=20
 	/*
 	 * Wake up first in case that concurrent callers decrease wait_cnt
@@ -652,12 +654,11 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 	return false;
 }
=20
-void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
+void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
 {
-	while (__sbq_wake_up(sbq))
+	while (__sbq_wake_up(sbq, &nr))
 		;
 }
-EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
=20
 static inline void sbitmap_update_cpu_hint(struct sbitmap *sb, int cpu, in=
t tag)
 {
@@ -694,7 +695,7 @@ void sbitmap_queue_clear_batch(struct sbitmap_queue *sb=
q, int offset,
 		atomic_long_andnot(mask, (atomic_long_t *) addr);
=20
 	smp_mb__after_atomic();
-	sbitmap_queue_wake_up(sbq);
+	sbitmap_queue_wake_up(sbq, nr_tags);
 	sbitmap_update_cpu_hint(&sbq->sb, raw_smp_processor_id(),
 					tags[nr_tags - 1] - offset);
 }
@@ -722,7 +723,7 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, uns=
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

