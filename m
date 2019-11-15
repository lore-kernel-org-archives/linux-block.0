Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB3DC43141
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0621D2077B
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvaAJfIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfKOKnO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:43:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42232 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727151AbfKOKnO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 05:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573814592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/M5kgQpUZ8+HJEaUnuPgsNPU9bN7NMoroHnC8vI5ohc=;
        b=OvaAJfIAKod0Sw+mWQ060xqQyuyZ5PVdiKdVVsOkky3WPVMsxvQ2NXjcMGyQVA1Zt1F5BZ
        JFJiCmCP/mAOnPQAcKM/6NH6Ctc1PxNECc3LbjblL84ajUFSKeMv07lh4I7sgfyWUaQCSy
        nGmDwpiZDoinjEu/YWysTt3rSJaiL1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210--4i6oc75NqyZa1FfY-mmIg-1; Fri, 15 Nov 2019 05:43:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1F0F477;
        Fri, 15 Nov 2019 10:43:07 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F83E5D6BE;
        Fri, 15 Nov 2019 10:43:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH RFC 2/3] nvme: don't use blk_mq_alloc_request_hctx() for allocating connect request
Date:   Fri, 15 Nov 2019 18:42:37 +0800
Message-Id: <20191115104238.15107-3-ming.lei@redhat.com>
In-Reply-To: <20191115104238.15107-1-ming.lei@redhat.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: -4i6oc75NqyZa1FfY-mmIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use one NVMe specific approach to choose transport queue for connect
request:

- IO connect request uses the unique reserved tag 0
- store the queue id into req->private_rq_data in nvme_alloc_request()
- inside .queue_rq(), select the transport queue via the stored qid

Also request's completion handler need to retrieve the block request via
.command_id and the transport queue instance. So store one flag of the conn=
ect
request into rq->private_rq_data before submitting, and make sure that the
flag is available in completion handler, then we can lookup the request
via the flag and the transport queue.

With this approach, we don't need the werid API of blk_mq_alloc_request_hct=
x()
any more.

Cc: James Smart <james.smart@broadcom.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c   |  9 +++-----
 drivers/nvme/host/fc.c     | 10 +++++++++
 drivers/nvme/host/rdma.c   | 40 +++++++++++++++++++++++++++++++++---
 drivers/nvme/host/tcp.c    | 41 ++++++++++++++++++++++++++++++++++---
 drivers/nvme/target/loop.c | 42 +++++++++++++++++++++++++++++++++++---
 5 files changed, 127 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca77..e96e3997389b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -481,15 +481,12 @@ struct request *nvme_alloc_request(struct request_que=
ue *q,
 =09unsigned op =3D nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
 =09struct request *req;
=20
-=09if (qid =3D=3D NVME_QID_ANY) {
-=09=09req =3D blk_mq_alloc_request(q, op, flags);
-=09} else {
-=09=09req =3D blk_mq_alloc_request_hctx(q, op, flags,
-=09=09=09=09qid ? qid - 1 : 0);
-=09}
+=09req =3D blk_mq_alloc_request(q, op, flags);
 =09if (IS_ERR(req))
 =09=09return req;
=20
+=09if (qid !=3D NVME_QID_ANY)
+=09=09req->private_rq_data =3D (unsigned long)qid;
 =09req->cmd_flags |=3D REQ_FAILFAST_DRIVER;
 =09nvme_clear_nvme_request(req);
 =09nvme_req(req)->cmd =3D cmd;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 265f89e11d8b..6c836e83e59c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2333,6 +2333,16 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 =09u32 data_len;
 =09blk_status_t ret;
=20
+=09/* connect request requires to use the specified queue */
+=09if (rq->tag =3D=3D 0 && ctrl->ctrl.admin_q !=3D hctx->queue) {
+=09=09unsigned qid =3D rq->private_rq_data;
+
+=09=09WARN_ON_ONCE(!blk_rq_is_private(rq));
+
+=09=09queue =3D &ctrl->queues[qid];
+=09=09op->queue =3D queue;
+=09}
+
 =09if (ctrl->rport->remoteport.port_state !=3D FC_OBJSTATE_ONLINE ||
 =09    !nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 =09=09return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cb4c3000a57e..6056679e8c77 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1436,13 +1436,35 @@ static void nvme_rdma_submit_async_event(struct nvm=
e_ctrl *arg)
 =09WARN_ON_ONCE(ret);
 }
=20
+static struct request *nvme_rdma_lookup_rq(struct nvme_rdma_queue *queue,
+=09=09struct nvme_rdma_qe *qe, struct nvme_completion *cqe)
+{
+=09int i;
+
+=09if (cqe->command_id || !nvme_rdma_queue_idx(queue))
+=09=09return blk_mq_tag_to_rq(nvme_rdma_tagset(queue),
+=09=09=09=09cqe->command_id);
+
+=09/* lookup request for connect IO */
+=09for (i =3D 1; i < queue->ctrl->ctrl.queue_count; i++) {
+=09=09struct request *rq =3D blk_mq_tag_to_rq(nvme_rdma_tagset(
+=09=09=09=09=09&queue->ctrl->queues[i]), 0);
+
+=09=09if (rq && rq->private_rq_data =3D=3D (unsigned long)qe)
+=09=09=09return rq;
+=09}
+
+=09return NULL;
+}
+
 static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
-=09=09struct nvme_completion *cqe, struct ib_wc *wc)
+=09=09struct nvme_rdma_qe *qe, struct ib_wc *wc)
 {
 =09struct request *rq;
 =09struct nvme_rdma_request *req;
+=09struct nvme_completion *cqe =3D qe->data;
=20
-=09rq =3D blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
+=09rq =3D nvme_rdma_lookup_rq(queue, qe, cqe);
 =09if (!rq) {
 =09=09dev_err(queue->ctrl->ctrl.device,
 =09=09=09"tag 0x%x on QP %#x not found\n",
@@ -1506,7 +1528,7 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, str=
uct ib_wc *wc)
 =09=09nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 =09=09=09=09&cqe->result);
 =09else
-=09=09nvme_rdma_process_nvme_rsp(queue, cqe, wc);
+=09=09nvme_rdma_process_nvme_rsp(queue, qe, wc);
 =09ib_dma_sync_single_for_device(ibdev, qe->dma, len, DMA_FROM_DEVICE);
=20
 =09nvme_rdma_post_recv(queue, qe);
@@ -1743,6 +1765,18 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq=
_hw_ctx *hctx,
=20
 =09WARN_ON_ONCE(rq->tag < 0);
=20
+=09/* connect request requires to use the specified queue */
+=09if (rq->tag =3D=3D 0 && queue->ctrl->ctrl.admin_q !=3D hctx->queue) {
+=09=09unsigned qid =3D rq->private_rq_data;
+
+=09=09WARN_ON_ONCE(!blk_rq_is_private(rq));
+
+=09=09queue =3D &queue->ctrl->queues[qid];
+=09=09req->queue =3D queue;
+
+=09=09rq->private_rq_data =3D (unsigned long)sqe;
+=09}
+
 =09if (!nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 =09=09return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
=20
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 770dbcbc999e..5087e2d168f1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -425,12 +425,35 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl =
*ctrl)
 =09queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
=20
+static struct request *nvme_tcp_lookup_rq(struct nvme_tcp_queue *queue,
+=09=09struct nvme_tcp_rsp_pdu *pdu, struct nvme_completion *cqe)
+{
+=09int i;
+
+=09if (cqe->command_id || !nvme_tcp_queue_id(queue))
+=09=09return blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
+=09=09=09=09cqe->command_id);
+
+=09/* lookup request for connect IO */
+=09for (i =3D 1; i < queue->ctrl->ctrl.queue_count; i++) {
+=09=09struct request *rq =3D blk_mq_tag_to_rq(nvme_tcp_tagset(
+=09=09=09=09=09&queue->ctrl->queues[i]), 0);
+
+=09=09if (rq && rq->private_rq_data =3D=3D (unsigned long)pdu)
+=09=09=09return rq;
+=09}
+
+=09return NULL;
+}
+
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
-=09=09struct nvme_completion *cqe)
+=09=09struct nvme_tcp_rsp_pdu *pdu)
 {
+=09struct nvme_completion *cqe =3D &pdu->cqe;
 =09struct request *rq;
=20
-=09rq =3D blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
+=09rq =3D nvme_tcp_lookup_rq(queue, pdu, cqe);
 =09if (!rq) {
 =09=09dev_err(queue->ctrl->ctrl.device,
 =09=09=09"queue %d tag 0x%x not found\n",
@@ -496,7 +519,7 @@ static int nvme_tcp_handle_comp(struct nvme_tcp_queue *=
queue,
 =09=09nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 =09=09=09=09&cqe->result);
 =09else
-=09=09ret =3D nvme_tcp_process_nvme_cqe(queue, cqe);
+=09=09ret =3D nvme_tcp_process_nvme_cqe(queue, pdu);
=20
 =09return ret;
 }
@@ -2155,6 +2178,18 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_=
hw_ctx *hctx,
 =09bool queue_ready =3D test_bit(NVME_TCP_Q_LIVE, &queue->flags);
 =09blk_status_t ret;
=20
+=09/* connect request requires to use the specified queue */
+=09if (rq->tag =3D=3D 0 && queue->ctrl->ctrl.admin_q !=3D hctx->queue) {
+=09=09unsigned qid =3D rq->private_rq_data;
+
+=09=09WARN_ON_ONCE(!blk_rq_is_private(rq));
+
+=09=09queue =3D &queue->ctrl->queues[qid];
+=09=09req->queue =3D queue;
+
+=09=09rq->private_rq_data =3D (unsigned long)queue->pdu;
+=09}
+
 =09if (!nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 =09=09return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
=20
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 11f5aea97d1b..d97c3155d86a 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -90,6 +90,28 @@ static struct blk_mq_tags *nvme_loop_tagset(struct nvme_=
loop_queue *queue)
 =09return queue->ctrl->tag_set.tags[queue_idx - 1];
 }
=20
+static struct request *nvme_loop_lookup_rq(struct nvme_loop_queue *queue,
+=09=09struct nvmet_req *req)
+{
+=09struct nvme_completion *cqe =3D req->cqe;
+=09int i;
+
+=09if (cqe->command_id || !nvme_loop_queue_idx(queue))
+=09=09return blk_mq_tag_to_rq(nvme_loop_tagset(queue),
+=09=09=09=09cqe->command_id);
+
+=09/* lookup request for connect IO */
+=09for (i =3D 1; i < queue->ctrl->ctrl.queue_count; i++) {
+=09=09struct request *rq =3D blk_mq_tag_to_rq(nvme_loop_tagset(
+=09=09=09=09=09&queue->ctrl->queues[i]), 0);
+
+=09=09if (rq && rq->private_rq_data =3D=3D (unsigned long)req)
+=09=09=09return rq;
+=09}
+
+=09return NULL;
+}
+
 static void nvme_loop_queue_response(struct nvmet_req *req)
 {
 =09struct nvme_loop_queue *queue =3D
@@ -107,9 +129,7 @@ static void nvme_loop_queue_response(struct nvmet_req *=
req)
 =09=09nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 =09=09=09=09&cqe->result);
 =09} else {
-=09=09struct request *rq;
-
-=09=09rq =3D blk_mq_tag_to_rq(nvme_loop_tagset(queue), cqe->command_id);
+=09=09struct request *rq =3D nvme_loop_lookup_rq(queue, req);
 =09=09if (!rq) {
 =09=09=09dev_err(queue->ctrl->ctrl.device,
 =09=09=09=09"tag 0x%x on queue %d not found\n",
@@ -139,6 +159,22 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_h=
w_ctx *hctx,
 =09bool queue_ready =3D test_bit(NVME_LOOP_Q_LIVE, &queue->flags);
 =09blk_status_t ret;
=20
+=09/* connect request requires to use the specified queue */
+=09if (req->tag =3D=3D 0) {
+=09=09struct nvme_loop_ctrl *ctrl =3D hctx->queue->tag_set->driver_data;
+
+=09=09if (ctrl->ctrl.admin_q !=3D hctx->queue) {
+=09=09=09unsigned qid =3D req->private_rq_data;
+
+=09=09=09WARN_ON_ONCE(!blk_rq_is_private(req));
+
+=09=09=09queue =3D &ctrl->queues[qid];
+=09=09=09iod->queue =3D queue;
+
+=09=09=09req->private_rq_data =3D (unsigned long)&iod->req;
+=09=09}
+=09}
+
 =09if (!nvmf_check_ready(&queue->ctrl->ctrl, req, queue_ready))
 =09=09return nvmf_fail_nonready_command(&queue->ctrl->ctrl, req);
=20
--=20
2.20.1

