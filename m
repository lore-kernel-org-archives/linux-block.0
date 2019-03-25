Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFEFC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832A520870
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MMtdqAKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfCYFsM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:48:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58214 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbfCYFsL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:48:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P5iASS003895;
        Mon, 25 Mar 2019 05:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=g8MNxG5h6K02d1j2gbKNvS/YX3Qz/wQcjAOs3taPJWs=;
 b=MMtdqAKWCbA1DAc2NALO4dAUngrWz2oUzJrJJobsDRRqXuZ0P+3nHYQVWn8wgUojCGN7
 Z0DlS/cf8J+mO7QcdSb75Ok++9O+WWJkCzuOT/vTBe1/mxU5+yeIbfxKioeg7uESSuqI
 j4vQiL7vq70luO+S79FdUidm/h16M+uKq8waGpWwVY9k3iTWyKFy2GMVEhtwsbH1pClk
 IFrMUjFM9A2frx+2avuIdDbSd9dsEolkE9EDjKshF6QITniVFAJ7p6K+Q4rGeqWdNVN2
 Ghx6Niyei9yf6uqCfHokZ23OMqFiYEoW4MOtFLL8rmQ9MgFGfb7i5nxZaYYtQu6TXWNt Cg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2re6g0ht0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:47:28 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5lMpj013909
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:47:22 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2P5lMo3030211;
        Mon, 25 Mar 2019 05:47:22 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Mar 2019 22:47:21 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
Date:   Mon, 25 Mar 2019 13:38:37 +0800
Message-Id: <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250044
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_tagset_inflight_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here. A new helper
interface nvme_iterate_inflight_rqs is introduced to iterate
all of the ns under a ctrl.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/core.c   | 12 ++++++++++++
 drivers/nvme/host/fc.c     | 10 +++++-----
 drivers/nvme/host/nvme.h   |  2 ++
 drivers/nvme/host/pci.c    |  5 +++--
 drivers/nvme/host/rdma.c   |  4 ++--
 drivers/nvme/host/tcp.c    |  5 +++--
 drivers/nvme/target/loop.c |  4 ++--
 7 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4706019..d6c53fe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3874,6 +3874,18 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+void nvme_iterate_inflight_rqs(struct nvme_ctrl *ctrl,
+		busy_iter_fn *fn, void *data)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_queue_tag_inflight_iter(ns->queue, fn, data);
+	up_read(&ctrl->namespaces_rwsem);
+}
+EXPORT_SYMBOL_GPL(nvme_iterate_inflight_rqs);
+
 int __init nvme_core_init(void)
 {
 	int result = -ENOMEM;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f3b9d91..667da72 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2367,7 +2367,7 @@ nvme_fc_complete_rq(struct request *rq)
 /*
  * This routine is used by the transport when it needs to find active
  * io on a queue that is to be terminated. The transport uses
- * blk_mq_tagset_busy_itr() to find the busy requests, which then invoke
+ * blk_mq_queue_tag_inflight_iter() to find the busy requests, which then invoke
  * this routine to kill them on a 1 by 1 basis.
  *
  * As FC allocates FC exchange for each io, the transport must contact
@@ -2740,7 +2740,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	 * If io queues are present, stop them and terminate all outstanding
 	 * ios on them. As FC allocates FC exchange for each io, the
 	 * transport must contact the LLDD to terminate the exchange,
-	 * thus releasing the FC exchange. We use blk_mq_tagset_busy_itr()
+	 * thus releasing the FC exchange. We use blk_mq_queue_tag_inflight_iter
 	 * to tell us what io's are busy and invoke a transport routine
 	 * to kill them with the LLDD.  After terminating the exchange
 	 * the LLDD will call the transport's normal io done path, but it
@@ -2750,7 +2750,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	 */
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
+		nvme_iterate_inflight_rqs(&ctrl->ctrl,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 	}
 
@@ -2768,11 +2768,11 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 
 	/*
 	 * clean up the admin queue. Same thing as above.
-	 * use blk_mq_tagset_busy_itr() and the transport routine to
+	 * use blk_mq_queue_tag_inflight_iter() and the transport routine to
 	 * terminate the exchanges.
 	 */
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
+	blk_mq_queue_tag_inflight_iter(ctrl->ctrl.admin_q,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 
 	/* kill the aens as they are a separate path */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 527d645..4c6bc803 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -445,6 +445,8 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+void nvme_iterate_inflight_rqs(struct nvme_ctrl *ctrl,
+		busy_iter_fn *fn, void *data);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a90cf5d..96faa36 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2430,8 +2430,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_suspend_queue(&dev->queues[0]);
 	nvme_pci_disable(dev);
 
-	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
-	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
+	nvme_iterate_inflight_rqs(&dev->ctrl, nvme_cancel_request, &dev->ctrl);
+	blk_mq_queue_tag_inflight_iter(dev->ctrl.admin_q,
+			nvme_cancel_request, &dev->ctrl);
 
 	/*
 	 * The driver will not be starting up queues again if shutting down so
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 11a5eca..5660200 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -914,7 +914,7 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 {
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set, nvme_cancel_request,
+	blk_mq_queue_tag_inflight_iter(ctrl->ctrl.admin_q, nvme_cancel_request,
 			&ctrl->ctrl);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_destroy_admin_queue(ctrl, remove);
@@ -926,7 +926,7 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set, nvme_cancel_request,
+		nvme_iterate_inflight_rqs(&ctrl->ctrl, nvme_cancel_request,
 				&ctrl->ctrl);
 		if (remove)
 			nvme_start_queues(&ctrl->ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e7e0888..4c825dc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1710,7 +1710,8 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
-	blk_mq_tagset_busy_iter(ctrl->admin_tagset, nvme_cancel_request, ctrl);
+	blk_mq_queue_tag_inflight_iter(ctrl->admin_q,
+			nvme_cancel_request, ctrl);
 	blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
 }
@@ -1722,7 +1723,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		return;
 	nvme_stop_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-	blk_mq_tagset_busy_iter(ctrl->tagset, nvme_cancel_request, ctrl);
+	nvme_iterate_inflight_rqs(ctrl, nvme_cancel_request, ctrl);
 	if (remove)
 		nvme_start_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index b9f623a..50d7288 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -421,7 +421,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 {
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
+		nvme_iterate_inflight_rqs(&ctrl->ctrl,
 					nvme_cancel_request, &ctrl->ctrl);
 		nvme_loop_destroy_io_queues(ctrl);
 	}
@@ -430,7 +430,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
+	blk_mq_queue_tag_inflight_iter(ctrl->ctrl.admin_q,
 				nvme_cancel_request, &ctrl->ctrl);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_loop_destroy_admin_queue(ctrl);
-- 
2.7.4

