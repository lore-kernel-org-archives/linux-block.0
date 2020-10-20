Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF82C433E7
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E7F222C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAegNf7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389754AbgJTIx6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389704AbgJTIx5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 04:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603184035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yg2Zneytrl5FZ8UHJ9cXCmTPn7+LllDaDSbb8wYavDE=;
        b=TAegNf7j72qKD5aIhJvCHAk7soGgi+7aGq96ft7CPqX2a9EmP+l42HhgUpT2ZclHxE7vn/
        woM8dq5jq+76D4hriqsfYNCFBxWUNzw3IpTnIIaRoP+ljABrJxYqG4Td9vR3E/JBtqtS+9
        D7MATxFsJ7z3S7sYKLKV+YVeTgdcm7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-Vp7788i4Op6o11ytMrrJGg-1; Tue, 20 Oct 2020 04:53:53 -0400
X-MC-Unique: Vp7788i4Op6o11ytMrrJGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D6A48049CB;
        Tue, 20 Oct 2020 08:53:52 +0000 (UTC)
Received: from localhost (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23BA155760;
        Tue, 20 Oct 2020 08:53:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH V2 4/4] nvme: tcp: fix race between timeout and normal completion
Date:   Tue, 20 Oct 2020 16:53:01 +0800
Message-Id: <20201020085301.1553959-5-ming.lei@redhat.com>
In-Reply-To: <20201020085301.1553959-1-ming.lei@redhat.com>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe TCP timeout handler allows to abort request directly when the
controller isn't in LIVE state. nvme_tcp_error_recovery() updates
controller state as RESETTING, and schedule reset work function. If
new timeout comes before the work function is called, the new timedout
request will be aborted directly, however at that time, the controller
isn't shut down yet, then timeout abort vs. normal completion race
will be triggered.

Fix the race by the following approach:

1) delay unquiesce io queues and admin queue until controller is LIVE
because it isn't necessary to start queues during RESETTING. Instead,
this way may risk timeout vs. normal completion race because we need
to abort timed-out request directly during CONNECTING state for setting
up controller.

2) aborting timed out request directly only in case that controller is in
CONNECTING and DELETING state. In CONNECTING state, requests are only
submitted for recovering controller, and normal IO requests aren't
allowed, so it is safe to do so. In DELETING state, teardown controller
if IO request timeout happens.

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/tcp.c | 58 +++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7e85bd4a8d1b..3a137631b2b3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1919,7 +1919,6 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	if (ctrl->admin_tagset) {
@@ -1930,15 +1929,13 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	if (remove)
 		blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
-	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	if (ctrl->queue_count <= 1)
-		goto out;
+		return;
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
@@ -1951,8 +1948,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (remove)
 		nvme_start_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
-out:
-	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
@@ -1971,6 +1966,10 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
 		dev_info(ctrl->device, "Removing controller...\n");
+
+		/* start queues for not blocking removing path */
+		nvme_start_queues(ctrl);
+		blk_mq_unquiesce_queue(ctrl->admin_q);
 		nvme_delete_ctrl(ctrl);
 	}
 }
@@ -2063,11 +2062,11 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
 	nvme_stop_keep_alive(ctrl);
+
+	mutex_lock(&tcp_ctrl->teardown_lock);
 	nvme_tcp_teardown_io_queues(ctrl, false);
-	/* unquiesce to fail fast pending requests */
-	nvme_start_queues(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
-	blk_mq_unquiesce_queue(ctrl->admin_q);
+	mutex_unlock(&tcp_ctrl->teardown_lock);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
@@ -2084,6 +2083,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 
+	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	if (shutdown)
@@ -2091,6 +2091,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	else
 		nvme_disable_ctrl(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
+	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
@@ -2225,22 +2226,41 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
 		"queue %d: timeout request %#x type %d\n",
 		nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
 
-	if (ctrl->state != NVME_CTRL_LIVE) {
+	/*
+	 * During CONNECTING or DELETING, the controller has been shutdown,
+	 * so it is safe to abort the request directly, otherwise timeout
+	 * vs. normal completion will be triggered.
+	 */
+	if (ctrl->state == NVME_CTRL_CONNECTING ||
+			ctrl->state == NVME_CTRL_DELETING ||
+			ctrl->state == NVME_CTRL_DELETING_NOIO) {
 		/*
-		 * If we are resetting, connecting or deleting we should
-		 * complete immediately because we may block controller
-		 * teardown or setup sequence
+		 * If we are connecting we should complete immediately because
+		 * we may block controller setup sequence
 		 * - ctrl disable/shutdown fabrics requests
 		 * - connect requests
 		 * - initialization admin requests
-		 * - I/O requests that entered after unquiescing and
-		 *   the controller stopped responding
+		 */
+		if (!rq->rq_disk) {
+			nvme_tcp_complete_timed_out(rq);
+			return BLK_EH_DONE;
+		}
+
+		/*
+		 * During CONNECTING, any in-flight requests are aborted, and
+		 * queue is stopped, so in theory not possible to see timed out
+		 * requests. And it might happen when one IO timeout is triggered
+		 * before changing to CONNECTING, but the timeout handling is
+		 * scheduled after updating to CONNECTING, so safe to ignore
+		 * this case.
 		 *
-		 * All other requests should be cancelled by the error
-		 * recovery work, so it's fine that we fail it here.
+		 * During DELETING, tear down controller and make forward
+		 * progress.
 		 */
-		nvme_tcp_complete_timed_out(rq);
-		return BLK_EH_DONE;
+		if (ctrl->state != NVME_CTRL_CONNECTING) {
+			nvme_tcp_teardown_ctrl(ctrl, false);
+			return BLK_EH_DONE;
+		}
 	}
 
 	/*
-- 
2.25.2

