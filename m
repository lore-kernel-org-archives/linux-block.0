Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1283C433E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633EE20897
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdsTg0Aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408818AbgJPO2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 10:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408814AbgJPO2v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 10:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602858529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lz3Ou5mJa3qRn8JaO0Ng0wU2ITlWqsK2TaLAz5ZaXd8=;
        b=gdsTg0AamYqEiAAQzS48I4islGAjFgkd0v/eKjOWDR1xYKu339m6o3RLp/aBzHGTNXGB0+
        URrW0/To0SYcv0fNrjQOMFyBGgfa5B5KyTsQSBdhFKiD4DOaqVlimoAOfjUAk/Yr84W1wd
        QwFswxt1NcUwn7dngaLprXhbcyQxAJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-ANENXbAcPSyuCtPLGJdHug-1; Fri, 16 Oct 2020 10:28:47 -0400
X-MC-Unique: ANENXbAcPSyuCtPLGJdHug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0171B186DD2A;
        Fri, 16 Oct 2020 14:28:46 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D2556EF55;
        Fri, 16 Oct 2020 14:28:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 3/4] nvme: tcp: fix race between timeout and normal completion
Date:   Fri, 16 Oct 2020 22:28:10 +0800
Message-Id: <20201016142811.1262214-4-ming.lei@redhat.com>
In-Reply-To: <20201016142811.1262214-1-ming.lei@redhat.com>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

1) aborting timed out request directly only in case that controller is in
CONNECTING and DELETING state. In the two states, controller has been shutdown,
so it is safe to do so; Also, it is enough to recovery controller in this way,
because we only stop/destroy queues during RESETTING, and cancel all in-flight
requests, no new request is required in RESETTING.

2) delay unquiesce io queues and admin queue until controller is LIVE
because it isn't necessary to start queues during RESETTING. Instead,
this way may risk timeout vs. normal completion race because we need
to abort timed-out request directly during CONNECTING state for setting
up controller.

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/tcp.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6a3e1487354..56ac61a90c1b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1886,7 +1886,6 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	if (ctrl->admin_tagset) {
@@ -1897,15 +1896,13 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
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
@@ -1918,8 +1915,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (remove)
 		nvme_start_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
-out:
-	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
@@ -1938,6 +1933,8 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
 		dev_info(ctrl->device, "Removing controller...\n");
+		nvme_start_queues(ctrl);
+		blk_mq_unquiesce_queue(ctrl->admin_q);
 		nvme_delete_ctrl(ctrl);
 	}
 }
@@ -2030,11 +2027,11 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
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
@@ -2051,6 +2048,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 
+	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	if (shutdown)
@@ -2058,6 +2056,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	else
 		nvme_disable_ctrl(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
+	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
@@ -2192,19 +2191,20 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
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
-		 *
-		 * All other requests should be cancelled by the error
-		 * recovery work, so it's fine that we fail it here.
 		 */
 		nvme_tcp_complete_timed_out(rq);
 		return BLK_EH_DONE;
-- 
2.25.2

