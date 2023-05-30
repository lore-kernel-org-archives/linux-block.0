Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35738C7EE2F
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 17:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjE3R0E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 13:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjE3RZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 13:25:49 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761F51B6
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 10:25:18 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UGY90h031170
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 10:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=bHlDZ98iZ2yfgOB8PPLdZzv6+izKLcs4GDZzU2G+rPE=;
 b=BqTHeYYaLgLknyO8xaTdKS0UwXRvuI2IwkNK2sLTn3jK8N3KW1VD0H5aZsV0mAxIMozc
 S/rJ8/HJI7IzZJxleACqD2zcXXn7oDgIkVfS3paskizdXVE91yesiQfFcbLwAW7h3MoT
 v5hiSJXWVmyKRIzuGpIuVsk0gZhzY/6mY9CE8BgWUVJvC0E4o61kiMpUZ7pBhJyAlfx/
 uGtozZGfD8Me098sjNM4vYbNybvoItrUPf1QhlAaI9PSYJNSSOb6C54VneOAas8cozJQ
 M68m48u17PZoA+oW21PZZICvsn3G6XZxOT6aNKAHX2YUqEiACufyfcs6LrtYyrKMAVZ+ eg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qwb4x49fq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 10:23:53 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 10:23:50 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id AB3A3194BF685; Tue, 30 May 2023 10:23:48 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <hch@lst.de>, <axboe@kernel.dk>
CC:     <sagi@grimberg.me>, <joshi.k@samsung.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] block: add request polling helper
Date:   Tue, 30 May 2023 10:23:42 -0700
Message-ID: <20230530172343.3250958-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nXojOi3prQ4b0CbaX9w2uVOJVzqYvSDw
X-Proofpoint-ORIG-GUID: nXojOi3prQ4b0CbaX9w2uVOJVzqYvSDw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_12,2023-05-30_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

This will be used by drivers that allocate polling requests. It
interface does not require a bio, and can skip the overhead associated
with polling those.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 29 ++++++++++++++++++++++++++---
 include/linux/blk-mq.h |  2 ++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6dad0886a2fa..3c12c476e3a5c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4740,10 +4740,9 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_=
set *set, int nr_hw_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
=20
-int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp=
_batch *iob,
-		unsigned int flags)
+static int blk_hctx_poll(struct request_queue *q, struct blk_mq_hw_ctx *=
hctx,
+			 struct io_comp_batch *iob, unsigned int flags)
 {
-	struct blk_mq_hw_ctx *hctx =3D blk_qc_to_hctx(q, cookie);
 	long state =3D get_current_state();
 	int ret;
=20
@@ -4768,6 +4767,30 @@ int blk_mq_poll(struct request_queue *q, blk_qc_t =
cookie, struct io_comp_batch *
 	return 0;
 }
=20
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp=
_batch *iob,
+		unsigned int flags)
+{
+	return blk_hctx_poll(q, blk_qc_to_hctx(q, cookie), iob, flags);
+}
+
+int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
+		unsigned int poll_flags)
+{
+	struct request_queue *q =3D rq->q;
+	int ret;
+
+	if (!blk_rq_is_poll(rq))
+		return 0;
+	if (!percpu_ref_tryget(&q->q_usage_counter))
+		return 0;
+
+	ret =3D blk_hctx_poll(q, rq->mq_hctx, iob, poll_flags);
+	blk_queue_exit(q);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blk_rq_poll);
+
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
 	return rq->mq_ctx->cpu;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed66..579818fa1f91d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -722,6 +722,8 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *se=
t,
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
=20
 void blk_mq_free_request(struct request *rq);
+int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
+		unsigned int poll_flags);
=20
 bool blk_mq_queue_inflight(struct request_queue *q);
=20
--=20
2.34.1

