Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0048C761A6
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 00:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjCVAYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 20:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCVAYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 20:24:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6E52FCE0
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:24:08 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M01vwm016441
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:24:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=J4Zpi1yqSm85ldGR5wpBzPETmvR1yC8F/Ig/J1L9XYY=;
 b=euAeIyuJWR9HFG1S4M7WA83K5xFtDPCi5iuLluB7qZyvRNdh9izTPOvcW+5du18JN7+v
 bWsjs8LVb153Q4VYJ8XabN4RSC6QIWpGhjxj2bq0T7fhW1G+HKqsqsu6upGQBkb0lx+p
 KIhh+eNWzQCVOK1UWpj6nsE1be5FQ6PIxOliuj9ETB0ud/hX1l3rmuAGBui2BwGk+FJE
 D3ub/STaPAJMQySYDCgXVSPEDG6FzfGWow/8JMBbyikm32hSU0a6uutPni/4z/NOweZQ
 /+LcfKb22tEyNdCR3ZyprCyMyZIYZe0Di3BT/ysVLTQjGRqvPPNmV4Dt3R4HDQ+x3Rsy hQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pfgr8aqdb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 17:24:07 -0700
Received: from twshared4298.02.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Mar 2023 17:24:06 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id DF30D1419697F; Tue, 21 Mar 2023 17:23:51 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Date:   Tue, 21 Mar 2023 17:23:48 -0700
Message-ID: <20230322002350.4038048-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322002350.4038048-1-kbusch@meta.com>
References: <20230322002350.4038048-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sR82SuWav2FqGdKDNWK-RecePNwa4q_0
X-Proofpoint-GUID: sR82SuWav2FqGdKDNWK-RecePNwa4q_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

tcp and rdma transports have lots of duplicate code setting up the
different queue mappings. Add common helpers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/fabrics.c | 95 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  5 ++
 drivers/nvme/host/rdma.c    | 81 ++-----------------------------
 drivers/nvme/host/tcp.c     | 92 ++---------------------------------
 4 files changed, 109 insertions(+), 164 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502b..9dcb56ea1cc00 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015-2016 HGST, a Western Digital Company.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/blk-mq-rdma.h>
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -957,6 +958,100 @@ static int nvmf_parse_options(struct nvmf_ctrl_opti=
ons *opts,
 	return ret;
 }
=20
+unsigned int nvme_nr_io_queues(struct nvmf_ctrl_options *opts)
+{
+	unsigned int nr_io_queues;
+
+	nr_io_queues =3D min(opts->nr_io_queues, num_online_cpus());
+	nr_io_queues +=3D min(opts->nr_write_queues, num_online_cpus());
+	nr_io_queues +=3D min(opts->nr_poll_queues, num_online_cpus());
+
+	return nr_io_queues;
+}
+EXPORT_SYMBOL_GPL(nvme_nr_io_queues);
+
+void nvme_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues=
,
+			u32 io_queues[HCTX_MAX_TYPES])
+{
+	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
+		/*
+		 * separate read/write queues
+		 * hand out dedicated default queues only after we have
+		 * sufficient read queues.
+		 */
+		io_queues[HCTX_TYPE_READ] =3D opts->nr_io_queues;
+		nr_io_queues -=3D io_queues[HCTX_TYPE_READ];
+		io_queues[HCTX_TYPE_DEFAULT] =3D
+			min(opts->nr_write_queues, nr_io_queues);
+		nr_io_queues -=3D io_queues[HCTX_TYPE_DEFAULT];
+	} else {
+		/*
+		 * shared read/write queues
+		 * either no write queues were requested, or we don't have
+		 * sufficient queue count to have dedicated default queues.
+		 */
+		io_queues[HCTX_TYPE_DEFAULT] =3D
+			min(opts->nr_io_queues, nr_io_queues);
+		nr_io_queues -=3D io_queues[HCTX_TYPE_DEFAULT];
+	}
+
+	if (opts->nr_poll_queues && nr_io_queues) {
+		/* map dedicated poll queues only if we have queues left */
+		io_queues[HCTX_TYPE_POLL] =3D
+			min(opts->nr_poll_queues, nr_io_queues);
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_set_io_queues);
+
+void nvme_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
+		     struct ib_device *dev, u32 io_queues[HCTX_MAX_TYPES])
+{
+	struct nvmf_ctrl_options *opts =3D ctrl->opts;
+
+	if (opts->nr_write_queues && io_queues[HCTX_TYPE_READ]) {
+		/* separate read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
+			io_queues[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
+		set->map[HCTX_TYPE_READ].nr_queues =3D
+			io_queues[HCTX_TYPE_READ];
+		set->map[HCTX_TYPE_READ].queue_offset =3D
+			io_queues[HCTX_TYPE_DEFAULT];
+	} else {
+		/* shared read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
+			io_queues[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
+		set->map[HCTX_TYPE_READ].nr_queues =3D
+			io_queues[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_READ].queue_offset =3D 0;
+	}
+
+	if (dev) {
+		blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_DEFAULT], dev, 0);
+		blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ], dev, 0);
+	} else {
+		blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+		blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
+	}
+
+	if (opts->nr_poll_queues && io_queues[HCTX_TYPE_POLL]) {
+		/* map dedicated poll queues only if we have queues left */
+		set->map[HCTX_TYPE_POLL].nr_queues =3D io_queues[HCTX_TYPE_POLL];
+		set->map[HCTX_TYPE_POLL].queue_offset =3D
+			io_queues[HCTX_TYPE_DEFAULT] +
+			io_queues[HCTX_TYPE_READ];
+		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
+	}
+
+	dev_info(ctrl->device,
+		"mapped %d/%d/%d default/read/poll queues.\n",
+		io_queues[HCTX_TYPE_DEFAULT],
+		io_queues[HCTX_TYPE_READ],
+		io_queues[HCTX_TYPE_POLL]);
+}
+EXPORT_SYMBOL_GPL(nvme_map_queues);
+
 static int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
 		unsigned int required_opts)
 {
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f76..bad3e21ffb8ba 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -215,5 +215,10 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *b=
uf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
+void nvme_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues=
,
+			u32 io_queues[HCTX_MAX_TYPES]);
+unsigned int nvme_nr_io_queues(struct nvmf_ctrl_options *opts);
+void nvme_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
+		     struct ib_device *dev, u32 io_queues[HCTX_MAX_TYPES]);
=20
 #endif /* _NVME_FABRICS_H */
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bbad26b82b56d..cbec566db2761 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -718,18 +718,10 @@ static int nvme_rdma_start_io_queues(struct nvme_rd=
ma_ctrl *ctrl,
 static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts =3D ctrl->ctrl.opts;
-	struct ib_device *ibdev =3D ctrl->device->dev;
-	unsigned int nr_io_queues, nr_default_queues;
-	unsigned int nr_read_queues, nr_poll_queues;
+	unsigned int nr_io_queues;
 	int i, ret;
=20
-	nr_read_queues =3D min_t(unsigned int, ibdev->num_comp_vectors,
-				min(opts->nr_io_queues, num_online_cpus()));
-	nr_default_queues =3D  min_t(unsigned int, ibdev->num_comp_vectors,
-				min(opts->nr_write_queues, num_online_cpus()));
-	nr_poll_queues =3D min(opts->nr_poll_queues, num_online_cpus());
-	nr_io_queues =3D nr_read_queues + nr_default_queues + nr_poll_queues;
-
+	nr_io_queues =3D nvme_nr_io_queues(opts);
 	ret =3D nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
@@ -744,34 +736,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdm=
a_ctrl *ctrl)
 	dev_info(ctrl->ctrl.device,
 		"creating %d I/O queues.\n", nr_io_queues);
=20
-	if (opts->nr_write_queues && nr_read_queues < nr_io_queues) {
-		/*
-		 * separate read/write queues
-		 * hand out dedicated default queues only after we have
-		 * sufficient read queues.
-		 */
-		ctrl->io_queues[HCTX_TYPE_READ] =3D nr_read_queues;
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_READ];
-		ctrl->io_queues[HCTX_TYPE_DEFAULT] =3D
-			min(nr_default_queues, nr_io_queues);
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	} else {
-		/*
-		 * shared read/write queues
-		 * either no write queues were requested, or we don't have
-		 * sufficient queue count to have dedicated default queues.
-		 */
-		ctrl->io_queues[HCTX_TYPE_DEFAULT] =3D
-			min(nr_read_queues, nr_io_queues);
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	}
-
-	if (opts->nr_poll_queues && nr_io_queues) {
-		/* map dedicated poll queues only if we have queues left */
-		ctrl->io_queues[HCTX_TYPE_POLL] =3D
-			min(nr_poll_queues, nr_io_queues);
-	}
-
+	nvme_set_io_queues(opts, nr_io_queues, ctrl->io_queues);
 	for (i =3D 1; i < ctrl->ctrl.queue_count; i++) {
 		ret =3D nvme_rdma_alloc_queue(ctrl, i,
 				ctrl->ctrl.sqsize + 1);
@@ -2143,46 +2108,8 @@ static void nvme_rdma_complete_rq(struct request *=
rq)
 static void nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl =3D to_rdma_ctrl(set->driver_data);
-	struct nvmf_ctrl_options *opts =3D ctrl->ctrl.opts;
=20
-	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
-		/* separate read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
-		set->map[HCTX_TYPE_READ].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_READ];
-		set->map[HCTX_TYPE_READ].queue_offset =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	} else {
-		/* shared read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
-		set->map[HCTX_TYPE_READ].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_READ].queue_offset =3D 0;
-	}
-	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_DEFAULT],
-			ctrl->device->dev, 0);
-	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
-			ctrl->device->dev, 0);
-
-	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
-		/* map dedicated poll queues only if we have queues left */
-		set->map[HCTX_TYPE_POLL].nr_queues =3D
-				ctrl->io_queues[HCTX_TYPE_POLL];
-		set->map[HCTX_TYPE_POLL].queue_offset =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT] +
-			ctrl->io_queues[HCTX_TYPE_READ];
-		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
-	}
-
-	dev_info(ctrl->ctrl.device,
-		"mapped %d/%d/%d default/read/poll queues.\n",
-		ctrl->io_queues[HCTX_TYPE_DEFAULT],
-		ctrl->io_queues[HCTX_TYPE_READ],
-		ctrl->io_queues[HCTX_TYPE_POLL]);
+	nvme_map_queues(set, &ctrl->ctrl, ctrl->device->dev, ctrl->io_queues);
 }
=20
 static const struct blk_mq_ops nvme_rdma_mq_ops =3D {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7723a49895244..96298f8794e1a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1781,58 +1781,12 @@ static int __nvme_tcp_alloc_io_queues(struct nvme=
_ctrl *ctrl)
 	return ret;
 }
=20
-static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
-{
-	unsigned int nr_io_queues;
-
-	nr_io_queues =3D min(ctrl->opts->nr_io_queues, num_online_cpus());
-	nr_io_queues +=3D min(ctrl->opts->nr_write_queues, num_online_cpus());
-	nr_io_queues +=3D min(ctrl->opts->nr_poll_queues, num_online_cpus());
-
-	return nr_io_queues;
-}
-
-static void nvme_tcp_set_io_queues(struct nvme_ctrl *nctrl,
-		unsigned int nr_io_queues)
-{
-	struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(nctrl);
-	struct nvmf_ctrl_options *opts =3D nctrl->opts;
-
-	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
-		/*
-		 * separate read/write queues
-		 * hand out dedicated default queues only after we have
-		 * sufficient read queues.
-		 */
-		ctrl->io_queues[HCTX_TYPE_READ] =3D opts->nr_io_queues;
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_READ];
-		ctrl->io_queues[HCTX_TYPE_DEFAULT] =3D
-			min(opts->nr_write_queues, nr_io_queues);
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	} else {
-		/*
-		 * shared read/write queues
-		 * either no write queues were requested, or we don't have
-		 * sufficient queue count to have dedicated default queues.
-		 */
-		ctrl->io_queues[HCTX_TYPE_DEFAULT] =3D
-			min(opts->nr_io_queues, nr_io_queues);
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	}
-
-	if (opts->nr_poll_queues && nr_io_queues) {
-		/* map dedicated poll queues only if we have queues left */
-		ctrl->io_queues[HCTX_TYPE_POLL] =3D
-			min(opts->nr_poll_queues, nr_io_queues);
-	}
-}
-
 static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	unsigned int nr_io_queues;
 	int ret;
=20
-	nr_io_queues =3D nvme_tcp_nr_io_queues(ctrl);
+	nr_io_queues =3D nvme_nr_io_queues(ctrl->opts);
 	ret =3D nvme_set_queue_count(ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
@@ -1847,8 +1801,8 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctr=
l *ctrl)
 	dev_info(ctrl->device,
 		"creating %d I/O queues.\n", nr_io_queues);
=20
-	nvme_tcp_set_io_queues(ctrl, nr_io_queues);
-
+	nvme_set_io_queues(ctrl->opts, nr_io_queues,
+			   to_tcp_ctrl(ctrl)->io_queues);
 	return __nvme_tcp_alloc_io_queues(ctrl);
 }
=20
@@ -2428,44 +2382,8 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_m=
q_hw_ctx *hctx,
 static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(set->driver_data);
-	struct nvmf_ctrl_options *opts =3D ctrl->ctrl.opts;
-
-	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
-		/* separate read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
-		set->map[HCTX_TYPE_READ].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_READ];
-		set->map[HCTX_TYPE_READ].queue_offset =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	} else {
-		/* shared read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
-		set->map[HCTX_TYPE_READ].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_READ].queue_offset =3D 0;
-	}
-	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
-	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
-
-	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
-		/* map dedicated poll queues only if we have queues left */
-		set->map[HCTX_TYPE_POLL].nr_queues =3D
-				ctrl->io_queues[HCTX_TYPE_POLL];
-		set->map[HCTX_TYPE_POLL].queue_offset =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT] +
-			ctrl->io_queues[HCTX_TYPE_READ];
-		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
-	}
-
-	dev_info(ctrl->ctrl.device,
-		"mapped %d/%d/%d default/read/poll queues.\n",
-		ctrl->io_queues[HCTX_TYPE_DEFAULT],
-		ctrl->io_queues[HCTX_TYPE_READ],
-		ctrl->io_queues[HCTX_TYPE_POLL]);
+
+	nvme_map_queues(set, &ctrl->ctrl, NULL, ctrl->io_queues);
 }
=20
 static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batc=
h *iob)
--=20
2.34.1

