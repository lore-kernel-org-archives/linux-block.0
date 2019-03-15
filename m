Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78966C4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9F0218C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rlZwi5KS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfCOJHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:07:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40720 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfCOJGw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 05:06:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2F8xHfW027865;
        Fri, 15 Mar 2019 09:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=wPnBoZe+aGWRd8JQ9uU6MKrXmOk7pVf3H6ud0bgcG0M=;
 b=rlZwi5KSXn8/FlnjWvKWbjjvh3qFNJ4df5UrQbheInNoI+iCZ311iIPdZHDLCMO1laxp
 HOHBhzgGgNZbFO1n2KCkTCy9kEUp0nagtRkU/LJ4+qgD1FX1tnM8TrdDO89Hm7ZdtXXR
 NuJgPPOg47ZNRZseFKzAwnIQ4/RnrFFCBD0SnRCGAypR2VKtg+hNqyT9h6FoDPQUFkZQ
 P1BcjGYH+WutXJDdp8U3cm7ahjyubAbK+aHWNEJp6XD49aKzd2DwLGLqyjXSVbUufHl0
 xdV79F34dMa2QaGkkX9KqXTK5pNY5RnpUoXa7mp3bifBHhccYGY8INmwpRzqWD9U9ZCi GQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r464rwhtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96Uj5006122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:31 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96UBv017660;
        Fri, 15 Mar 2019 09:06:30 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 09:06:30 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] nvme: use blk_mq_queue_tag_busy_iter
Date:   Fri, 15 Mar 2019 16:57:43 +0800
Message-Id: <1552640264-26101-8-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9195 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150067
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here. A new helper
interface nvme_iterate_inflight_rqs is introduced to iterate
all of the ns under a ctrl.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/core.c   | 12 ++++++++++++
 drivers/nvme/host/fc.c     | 12 ++++++------
 drivers/nvme/host/nvme.h   |  2 ++
 drivers/nvme/host/pci.c    |  5 +++--
 drivers/nvme/host/rdma.c   |  6 +++---
 drivers/nvme/host/tcp.c    |  5 +++--
 drivers/nvme/target/loop.c |  6 +++---
 7 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a9dd68..5760fad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3816,6 +3816,18 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+void nvme_iterate_inflight_rqs(struct nvme_ctrl *ctrl,
+		busy_iter_fn *fn, void *data)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_queue_tag_busy_iter(ns->queue, fn, data, true);
+	up_read(&ctrl->namespaces_rwsem);
+}
+EXPORT_SYMBOL_GPL(nvme_iterate_inflight_rqs);
+
 int __init nvme_core_init(void)
 {
 	int result = -ENOMEM;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 89accc7..02b2de0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2368,7 +2368,7 @@ nvme_fc_complete_rq(struct request *rq)
 /*
  * This routine is used by the transport when it needs to find active
  * io on a queue that is to be terminated. The transport uses
- * blk_mq_tagset_busy_itr() to find the busy requests, which then invoke
+ * blk_mq_queue_tag_busy_iter() to find the busy requests, which then invoke
  * this routine to kill them on a 1 by 1 basis.
  *
  * As FC allocates FC exchange for each io, the transport must contact
@@ -2729,7 +2729,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	 * If io queues are present, stop them and terminate all outstanding
 	 * ios on them. As FC allocates FC exchange for each io, the
 	 * transport must contact the LLDD to terminate the exchange,
-	 * thus releasing the FC exchange. We use blk_mq_tagset_busy_itr()
+	 * thus releasing the FC exchange. We use blk_mq_queue_tag_busy_iter
 	 * to tell us what io's are busy and invoke a transport routine
 	 * to kill them with the LLDD.  After terminating the exchange
 	 * the LLDD will call the transport's normal io done path, but it
@@ -2739,7 +2739,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	 */
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
+		nvme_iterate_inflight_rqs(&ctrl->ctrl,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 	}
 
@@ -2757,12 +2757,12 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 
 	/*
 	 * clean up the admin queue. Same thing as above.
-	 * use blk_mq_tagset_busy_itr() and the transport routine to
+	 * use blk_mq_queue_tag_busy_iter() and the transport routine to
 	 * terminate the exchanges.
 	 */
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_fc_terminate_exchange, &ctrl->ctrl);
+	blk_mq_queue_tag_busy_iter(ctrl->ctrl.admin_q,
+				nvme_fc_terminate_exchange, &ctrl->ctrl, true);
 
 	/* kill the aens as they are a separate path */
 	nvme_fc_abort_aen_ops(ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c4a1bb4..6dc4ff8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -441,6 +441,8 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+void nvme_iterate_inflight_rqs(struct nvme_ctrl *ctrl,
+		busy_iter_fn *fn, void *data);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7fee665..0f0e361 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2476,8 +2476,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_suspend_queue(&dev->queues[0]);
 	nvme_pci_disable(dev);
 
-	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
-	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
+	nvme_iterate_inflight_rqs(&dev->ctrl, nvme_cancel_request, &dev->ctrl);
+	blk_mq_queue_tag_busy_iter(dev->ctrl.admin_q,
+			nvme_cancel_request, &dev->ctrl, true);
 
 	/*
 	 * The driver will not be starting up queues again if shutting down so
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 52abc3a..1be5688 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -922,8 +922,8 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 {
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set, nvme_cancel_request,
-			&ctrl->ctrl);
+	blk_mq_queue_tag_busy_iter(ctrl->ctrl.admin_q, nvme_cancel_request,
+			&ctrl->ctrl, true);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_destroy_admin_queue(ctrl, remove);
 }
@@ -934,7 +934,7 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set, nvme_cancel_request,
+		nvme_iterate_inflight_rqs(&ctrl->ctrl, nvme_cancel_request,
 				&ctrl->ctrl);
 		if (remove)
 			nvme_start_queues(&ctrl->ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5f0a004..75eb069 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1686,7 +1686,8 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
-	blk_mq_tagset_busy_iter(ctrl->admin_tagset, nvme_cancel_request, ctrl);
+	blk_mq_queue_tag_busy_iter(ctrl->admin_q,
+			nvme_cancel_request, ctrl, true);
 	blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
 }
@@ -1698,7 +1699,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		return;
 	nvme_stop_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-	blk_mq_tagset_busy_iter(ctrl->tagset, nvme_cancel_request, ctrl);
+	nvme_iterate_inflight_rqs(ctrl, nvme_cancel_request, ctrl);
 	if (remove)
 		nvme_start_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 4aac1b4..0d25083 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -429,7 +429,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 {
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
+		nvme_iterate_inflight_rqs(&ctrl->ctrl,
 					nvme_cancel_request, &ctrl->ctrl);
 		nvme_loop_destroy_io_queues(ctrl);
 	}
@@ -438,8 +438,8 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
+	blk_mq_queue_tag_busy_iter(ctrl->ctrl.admin_q,
+				nvme_cancel_request, &ctrl->ctrl, true);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_loop_destroy_admin_queue(ctrl);
 }
-- 
2.7.4

