Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E15CC433DF
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B98A20874
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rtg1zbBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408819AbgJPO27 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 10:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408814AbgJPO27 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 10:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602858538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8dCETTUY0srMfYpMQV60y38uEv/90/o462XzHM99kUk=;
        b=Rtg1zbBSFhXFG4yH0EbgkjnCGRlVkn2l+/22neiH4JZFeBKgpK+unFtMnYqsFATnL58b0P
        EAKwU9KIn7RR1ZVJYZ5rU4igCkU8n+6NHCIg+2/yxzbFPc+otoZ8pbxOzjhDTUyZDWHFHd
        v6S59TC8m/Sq6I7PBcHW8ICE85h5rx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-uqwPH2clO-mYbcEszgjLkg-1; Fri, 16 Oct 2020 10:28:56 -0400
X-MC-Unique: uqwPH2clO-mYbcEszgjLkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 917F586ABD1;
        Fri, 16 Oct 2020 14:28:54 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 038AA5C1BD;
        Fri, 16 Oct 2020 14:28:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 4/4] nvme: tcp: complete non-IO requests atomically
Date:   Fri, 16 Oct 2020 22:28:11 +0800
Message-Id: <20201016142811.1262214-5-ming.lei@redhat.com>
In-Reply-To: <20201016142811.1262214-1-ming.lei@redhat.com>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

During controller's CONNECTING state, admin/fabric/connect requests
are submitted for recovery, and we allow to abort this request directly
in time out handler for not blocking the setup step.

So timout vs. normal completion race may be triggered on these requests.

Add atomic completion for requests from connect/fabric/admin queue for
avoiding the race.

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 56ac61a90c1b..654061abdc5a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -30,6 +30,8 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+#define REQ_STATE_COMPLETE     0
+
 enum nvme_tcp_send_state {
 	NVME_TCP_SEND_CMD_PDU = 0,
 	NVME_TCP_SEND_H2C_PDU,
@@ -56,6 +58,8 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+	unsigned long		comp_state;
 };
 
 enum nvme_tcp_queue_flags {
@@ -469,6 +473,33 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+/*
+ * requests originated from admin, fabrics and connect_q have to be
+ * completed atomically because we don't cover the race between timeout
+ * and normal completion for these queues.
+ */
+static inline bool nvme_tcp_need_atomic_complete(struct request *rq)
+{
+	return !rq->rq_disk;
+}
+
+static inline void nvme_tcp_clear_rq_complete(struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (unlikely(nvme_tcp_need_atomic_complete(rq)))
+		clear_bit(REQ_STATE_COMPLETE, &req->comp_state);
+}
+
+static inline bool nvme_tcp_mark_rq_complete(struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (unlikely(nvme_tcp_need_atomic_complete(rq)))
+		return !test_and_set_bit(REQ_STATE_COMPLETE, &req->comp_state);
+	return true;
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -483,7 +514,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
+	if (nvme_tcp_mark_rq_complete(rq) &&
+			!nvme_try_complete_req(rq, cqe->status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -674,7 +706,8 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
 	union nvme_result res = {};
 
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
+	if (nvme_tcp_mark_rq_complete(rq) &&
+			!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
 		nvme_complete_rq(rq);
 }
 
@@ -2173,7 +2206,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	/* fence other contexts that may complete the command */
 	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
-	if (!blk_mq_request_completed(rq)) {
+	if (nvme_tcp_mark_rq_complete(rq) && !blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
 		blk_mq_complete_request(rq);
 	}
@@ -2315,6 +2348,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(ret))
 		return ret;
 
+	nvme_tcp_clear_rq_complete(rq);
 	blk_mq_start_request(rq);
 
 	nvme_tcp_queue_request(req, true, bd->last);
-- 
2.25.2

