Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E254C6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 00:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCVAYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 20:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCVAYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 20:24:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5FD30E9E
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:24:08 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M01f2n007274
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:24:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=4Ik0Oblobgnkp3JuFO1WlPrz7GWLxMCFomlHihR68iw=;
 b=F3j7ewUhyYGNJg0quBeURSO8RpR2K7nRN0evdAubAek7JrTV8eK4LLnYQAA5nLNyG4MY
 eggx3XcOeEApibBUUBhGePmF2j2FwUYup06Wp5KKfsNsnlsHdfmoP/DINdguBALLM5ff
 eV2Q++EYNFiyP4uEFjdz+XQiwdU88VQuz0y5pNTfkX/3P0hELdWfJSHR1cnc1jziA8ZO
 j93DN9mL0keLB74MWpSPvSqC5goCNdmuLYmDShkXofKhmHNgMcyb/Z4GH9JaUmfokrQl
 q7FJGZ6SS3du9VSNEeYDq+ToW0NjJRuqR7yOW1cii74tQb/C+hJnvcCKEJKg3SYe+me4 lQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pfdx9v42d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:24:08 -0700
Received: from twshared4298.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Mar 2023 17:24:06 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 3B06814196982; Tue, 21 Mar 2023 17:23:52 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/3] nvme: add polling options for loop target
Date:   Tue, 21 Mar 2023 17:23:49 -0700
Message-ID: <20230322002350.4038048-3-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322002350.4038048-1-kbusch@meta.com>
References: <20230322002350.4038048-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vqb5JE5JhrAmBFFNrIhvVsDvVZ6Rhtv0
X-Proofpoint-ORIG-GUID: vqb5JE5JhrAmBFFNrIhvVsDvVZ6Rhtv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

This is for mostly for testing purposes.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/loop.c | 63 +++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f2d24b2d992f8..0587ead60b09e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -22,6 +22,7 @@ struct nvme_loop_iod {
 	struct nvmet_req	req;
 	struct nvme_loop_queue	*queue;
 	struct work_struct	work;
+	struct work_struct	poll;
 	struct sg_table		sg_table;
 	struct scatterlist	first_sgl[];
 };
@@ -37,6 +38,7 @@ struct nvme_loop_ctrl {
 	struct nvme_ctrl	ctrl;
=20
 	struct nvmet_port	*port;
+	u32			io_queues[HCTX_MAX_TYPES];
 };
=20
 static inline struct nvme_loop_ctrl *to_loop_ctrl(struct nvme_ctrl *ctrl=
)
@@ -76,7 +78,11 @@ static void nvme_loop_complete_rq(struct request *req)
 	struct nvme_loop_iod *iod =3D blk_mq_rq_to_pdu(req);
=20
 	sg_free_table_chained(&iod->sg_table, NVME_INLINE_SG_CNT);
-	nvme_complete_rq(req);
+
+	if (req->mq_hctx->type !=3D HCTX_TYPE_POLL || !in_interrupt())
+		nvme_complete_rq(req);
+	else
+		queue_work(nvmet_wq, &iod->poll);
 }
=20
 static struct blk_mq_tags *nvme_loop_tagset(struct nvme_loop_queue *queu=
e)
@@ -120,6 +126,15 @@ static void nvme_loop_queue_response(struct nvmet_re=
q *req)
 	}
 }
=20
+static void nvme_loop_poll_work(struct work_struct *work)
+{
+	struct nvme_loop_iod *iod =3D
+		container_of(work, struct nvme_loop_iod, poll);
+	struct request *req =3D blk_mq_rq_from_pdu(iod);
+
+	nvme_complete_rq(req);
+}
+
 static void nvme_loop_execute_work(struct work_struct *work)
 {
 	struct nvme_loop_iod *iod =3D
@@ -170,6 +185,30 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq=
_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
=20
+static bool nvme_loop_poll_iter(struct sbitmap *bitmap, unsigned int bit=
nr, void *data)
+{
+	struct blk_mq_hw_ctx *hctx =3D data;
+	struct nvme_loop_iod *iod;
+	struct request *rq;
+
+	rq =3D blk_mq_tag_to_rq(hctx->tags, bitnr);
+	if (!rq)
+		return true;
+
+	iod =3D blk_mq_rq_to_pdu(rq);
+	flush_work(&iod->poll);
+	return true;
+}
+
+static int nvme_loop_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_bat=
ch *iob)
+{
+	struct blk_mq_tags *tags =3D hctx->tags;
+	struct sbitmap_queue *btags =3D &tags->bitmap_tags;
+
+	sbitmap_for_each_set(&btags->sb, nvme_loop_poll_iter, hctx);
+	return 1;
+}
+
 static void nvme_loop_submit_async_event(struct nvme_ctrl *arg)
 {
 	struct nvme_loop_ctrl *ctrl =3D to_loop_ctrl(arg);
@@ -197,6 +236,7 @@ static int nvme_loop_init_iod(struct nvme_loop_ctrl *=
ctrl,
 	iod->req.cqe =3D &iod->cqe;
 	iod->queue =3D &ctrl->queues[queue_idx];
 	INIT_WORK(&iod->work, nvme_loop_execute_work);
+	INIT_WORK(&iod->poll, nvme_loop_poll_work);
 	return 0;
 }
=20
@@ -247,11 +287,20 @@ static int nvme_loop_init_admin_hctx(struct blk_mq_=
hw_ctx *hctx, void *data,
 	return 0;
 }
=20
+static void nvme_loop_map_queues(struct blk_mq_tag_set *set)
+{
+	struct nvme_loop_ctrl *ctrl =3D to_loop_ctrl(set->driver_data);
+
+	nvme_map_queues(set, &ctrl->ctrl, NULL, ctrl->io_queues);
+}
+
 static const struct blk_mq_ops nvme_loop_mq_ops =3D {
 	.queue_rq	=3D nvme_loop_queue_rq,
 	.complete	=3D nvme_loop_complete_rq,
 	.init_request	=3D nvme_loop_init_request,
 	.init_hctx	=3D nvme_loop_init_hctx,
+	.map_queues	=3D nvme_loop_map_queues,
+	.poll		=3D nvme_loop_poll,
 };
=20
 static const struct blk_mq_ops nvme_loop_admin_mq_ops =3D {
@@ -305,7 +354,7 @@ static int nvme_loop_init_io_queues(struct nvme_loop_=
ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret, i;
=20
-	nr_io_queues =3D min(opts->nr_io_queues, num_online_cpus());
+	nr_io_queues =3D nvme_nr_io_queues(opts);
 	ret =3D nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret || !nr_io_queues)
 		return ret;
@@ -321,6 +370,7 @@ static int nvme_loop_init_io_queues(struct nvme_loop_=
ctrl *ctrl)
 		ctrl->ctrl.queue_count++;
 	}
=20
+	nvme_set_io_queues(opts, nr_io_queues, ctrl->io_queues);
 	return 0;
=20
 out_destroy_queues:
@@ -494,7 +544,7 @@ static int nvme_loop_create_io_queues(struct nvme_loo=
p_ctrl *ctrl)
 		return ret;
=20
 	ret =3D nvme_alloc_io_tag_set(&ctrl->ctrl, &ctrl->tag_set,
-			&nvme_loop_mq_ops, 1,
+			&nvme_loop_mq_ops, ctrl->ctrl.opts->nr_poll_queues ? 3 : 2,
 			sizeof(struct nvme_loop_iod) +
 			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
 	if (ret)
@@ -534,6 +584,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct=
 device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_loop_ctrl *ctrl;
+	unsigned int nr_io_queues;
 	int ret;
=20
 	ctrl =3D kzalloc(sizeof(*ctrl), GFP_KERNEL);
@@ -559,7 +610,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct=
 device *dev,
 	ctrl->ctrl.kato =3D opts->kato;
 	ctrl->port =3D nvme_loop_find_port(&ctrl->ctrl);
=20
-	ctrl->queues =3D kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queues),
+	nr_io_queues =3D nvme_nr_io_queues(ctrl->ctrl.opts);;
+	ctrl->queues =3D kcalloc(nr_io_queues + 1, sizeof(*ctrl->queues),
 			GFP_KERNEL);
 	if (!ctrl->queues)
 		goto out_uninit_ctrl;
@@ -648,7 +700,8 @@ static struct nvmf_transport_ops nvme_loop_transport =
=3D {
 	.name		=3D "loop",
 	.module		=3D THIS_MODULE,
 	.create_ctrl	=3D nvme_loop_create_ctrl,
-	.allowed_opts	=3D NVMF_OPT_TRADDR,
+	.allowed_opts	=3D NVMF_OPT_TRADDR | NVMF_OPT_NR_WRITE_QUEUES |
+			  NVMF_OPT_NR_POLL_QUEUES,
 };
=20
 static int __init nvme_loop_init_module(void)
--=20
2.34.1

