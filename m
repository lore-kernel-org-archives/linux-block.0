Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB49C67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCE02086D
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MUawQUVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCE02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeLKXfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:35:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLKXf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2DnRvD3pPSCLqF/elFCzuQFFPoeooPyRxtLOiFC77Ow=; b=MUawQUVT2DnkcUEsPRn7Pk2r1
        JD7Mnpwxa+SL2UbHxc1zMxS52AP7a9QuW4WYiRhJlsBSXIx6YyGVzj1Ht7j9MgDCH+44dbBO7KcOq
        yy9BI493qUcleCiA7b94eF/WmD0jIgoL+vX9JJFTP2w8wDYakWOcLozTza4bMJs5XgdDfWV5x5J8f
        j/a90guaGlkoarW19x0IUyITw/uoL/axTEGYsfCFTThM9nujVfbs3XUB+9QOM5UeIVtoeNaGnz+/+
        meEnD/jPR0/J0swvaSAqpplp1hoYp7YAoQEAgjMPVi3sJDDpbMt01Y8GuZg9XZ33OMhvIN8SU76jk
        ntHSuSv4w==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWrYh-0002L4-Nj; Tue, 11 Dec 2018 23:35:23 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v2 4/5] nvme-tcp: support separate queue maps for read and write
Date:   Tue, 11 Dec 2018 15:35:17 -0800
Message-Id: <20181211233519.9350-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233519.9350-1-sagi@grimberg.me>
References: <20181211233519.9350-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow NVMF_OPT_NR_WRITE_QUEUES and allocate nvme queues for
write additionally. In addition, implement .map_queues that
will apply 2 queue maps for read and write queue sets.

Note that with the separate queue map, HCTX_TYPE_READ will always
use nr_io_queues and HCTX_TYPE_DEFAULT will use nr_write_queues.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 44 +++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15543358e245..61eeed758f4b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1215,7 +1215,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	struct linger sol = { .l_onoff = 1, .l_linger = 0 };
-	int ret, opt, rcv_pdu_size;
+	int ret, opt, rcv_pdu_size, n;
 
 	queue->ctrl = ctrl;
 	INIT_LIST_HEAD(&queue->send_list);
@@ -1271,7 +1271,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	}
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
-	queue->io_cpu = (qid == 0) ? 0 : qid - 1;
+	n = (qid ? qid - 1 : 0) % num_online_cpus();
+	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1433,6 +1434,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
+		set->nr_maps = 2 /* default + read */;
 	}
 
 	ret = blk_mq_alloc_tag_set(set);
@@ -1527,7 +1529,12 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 
 static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
 {
-	return min(ctrl->queue_count - 1, num_online_cpus());
+	unsigned int nr_io_queues;
+
+	nr_io_queues = min(ctrl->opts->nr_io_queues, num_online_cpus());
+	nr_io_queues += min(ctrl->opts->nr_write_queues, num_online_cpus());
+
+	return nr_io_queues;
 }
 
 static int nvme_alloc_io_queues(struct nvme_ctrl *ctrl)
@@ -2052,6 +2059,29 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
+{
+	struct nvme_tcp_ctrl *ctrl = set->driver_data;
+
+	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
+	set->map[HCTX_TYPE_READ].nr_queues = ctrl->ctrl.opts->nr_io_queues;
+	if (ctrl->ctrl.opts->nr_write_queues) {
+		/* separate read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =
+				ctrl->ctrl.opts->nr_write_queues;
+		set->map[HCTX_TYPE_READ].queue_offset =
+				ctrl->ctrl.opts->nr_write_queues;
+	} else {
+		/* mixed read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =
+				ctrl->ctrl.opts->nr_io_queues;
+		set->map[HCTX_TYPE_READ].queue_offset = 0;
+	}
+	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
+	return 0;
+}
+
 static struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
 	.complete	= nvme_complete_rq,
@@ -2059,6 +2089,7 @@ static struct blk_mq_ops nvme_tcp_mq_ops = {
 	.exit_request	= nvme_tcp_exit_request,
 	.init_hctx	= nvme_tcp_init_hctx,
 	.timeout	= nvme_tcp_timeout,
+	.map_queues	= nvme_tcp_map_queues,
 };
 
 static struct blk_mq_ops nvme_tcp_admin_mq_ops = {
@@ -2113,7 +2144,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 
 	INIT_LIST_HEAD(&ctrl->list);
 	ctrl->ctrl.opts = opts;
-	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
+	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
@@ -2155,7 +2186,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	ctrl->queues = kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queues),
+	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
 				GFP_KERNEL);
 	if (!ctrl->queues) {
 		ret = -ENOMEM;
@@ -2206,7 +2237,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 	.required_opts	= NVMF_OPT_TRADDR,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
-			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST,
+			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
+			  NVMF_OPT_NR_IO_QUEUES,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.17.1

