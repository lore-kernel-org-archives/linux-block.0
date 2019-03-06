Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653FCC4360F
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3503E20675
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfCFIss (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:48:48 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47870 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729628AbfCFIsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 03:48:47 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from talgi@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Mar 2019 10:48:43 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (gen-l-vrt-691.mtl.labs.mlnx [10.141.69.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x268mhhj017647;
        Wed, 6 Mar 2019 10:48:43 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (localhost [127.0.0.1])
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Debian-11ubuntu1) with ESMTP id x268mhWF057831;
        Wed, 6 Mar 2019 10:48:43 +0200
Received: (from talgi@localhost)
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id x268mh5m057830;
        Wed, 6 Mar 2019 10:48:43 +0200
From:   Tal Gilboa <talgi@mellanox.com>
To:     linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [RFC/PATCH net-next 9/9] drivers/infiniband: Use blk_dim in infiniband driver
Date:   Wed,  6 Mar 2019 10:48:32 +0200
Message-Id: <20190306084832.57753-10-talgi@mellanox.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yamin Friedman <yaminf@mellanox.com>

Added the interface in the infiniband driver that applies the blk_dim adaptive
moderation.

Performance improvment (ConnectX-5 100GbE, x86) running FIO benchmark over NVMf
between two equal end-hosts across a Mellanox switch:
Running long tests that switch between periods of high bandwidth high latency
and low bandwidth low latency, using the blk_dim algorithm there is a much
shorter wait before the moderation is reduced and thus tail latency is reduced.
There is a 200% reduction on tail latency when switching from high bandwidth to
low bandwidth traffic without degredation of other flow parameters.

The blk_dim algorithm was designed to measure the effectiveness of moderation
on the flow in a general way and thus should be appropriate for all RDMA storage
protocols.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Signed-off-by: Tal Gilboa <talgi@mellanox.com>
---
 drivers/infiniband/core/cq.c    | 75 ++++++++++++++++++++++++++++++---
 drivers/infiniband/hw/mlx4/qp.c |  2 +-
 drivers/infiniband/hw/mlx5/qp.c |  2 +-
 include/linux/irq_poll.h        |  7 +++
 include/rdma/ib_verbs.h         | 11 ++++-
 lib/irq_poll.c                  | 13 +++++-
 6 files changed, 100 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index d61e5e1427c2..065b54978dae 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <rdma/ib_verbs.h>
+#include <linux/blk_dim.h>
 
 /* # of WCs to poll for with a single call to ib_poll_cq */
 #define IB_POLL_BATCH			16
@@ -26,6 +27,51 @@
 #define IB_POLL_FLAGS \
 	(IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)
 
+static bool use_am = true;
+module_param(use_am, bool, 0444);
+MODULE_PARM_DESC(use_am, "Use cq adaptive moderation");
+
+static int ib_cq_dim_modify_cq(struct ib_cq *cq, unsigned short level)
+{
+	u16 usec = blk_dim_prof[level].usec;
+	u16 comps = blk_dim_prof[level].comps;
+
+	return cq->device->modify_cq(cq, comps, usec);
+}
+
+static void update_cq_moderation(struct dim *dim, struct ib_cq *cq)
+{
+	dim->state = DIM_START_MEASURE;
+
+	ib_cq_dim_modify_cq(cq, dim->profile_ix);
+}
+
+static void ib_cq_blk_dim_workqueue_work(struct work_struct *w)
+{
+	struct dim *dim = container_of(w, struct dim, work);
+	struct ib_cq *cq = container_of(dim, struct ib_cq, workqueue_poll.dim);
+
+	update_cq_moderation(dim, cq);
+}
+
+static void ib_cq_blk_dim_irqpoll_work(struct work_struct *w)
+{
+	struct dim *dim = container_of(w, struct dim, work);
+	struct irq_poll *iop = container_of(dim, struct irq_poll, dim);
+	struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
+
+	update_cq_moderation(dim, cq);
+}
+
+void blk_dim_init(struct dim *dim, work_func_t func)
+{
+	memset(dim, 0, sizeof(*dim));
+	dim->state = DIM_START_MEASURE;
+	dim->tune_state = DIM_GOING_RIGHT;
+	dim->profile_ix = BLK_DIM_START_PROFILE;
+	INIT_WORK(&dim->work, func);
+}
+
 static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
 			   int batch)
 {
@@ -105,19 +151,28 @@ static void ib_cq_completion_softirq(struct ib_cq *cq, void *private)
 
 static void ib_cq_poll_work(struct work_struct *work)
 {
-	struct ib_cq *cq = container_of(work, struct ib_cq, work);
+	struct ib_cq *cq = container_of(work, struct ib_cq, workqueue_poll.work);
 	int completed;
+	struct dim_sample e_sample;
+	struct dim_sample *m_sample = &cq->workqueue_poll.dim.measuring_sample;
 
 	completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, cq->wc,
 				    IB_POLL_BATCH);
+
+	if (cq->workqueue_poll.dim_used)
+		dim_create_sample(m_sample->event_ctr + 1, m_sample->pkt_ctr, m_sample->byte_ctr,
+							m_sample->comp_ctr + completed, &e_sample);
+
 	if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
 	    ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
-		queue_work(cq->comp_wq, &cq->work);
+		queue_work(cq->comp_wq, &cq->workqueue_poll.work);
+	else if (cq->workqueue_poll.dim_used)
+		blk_dim(&cq->workqueue_poll.dim, e_sample);
 }
 
 static void ib_cq_completion_workqueue(struct ib_cq *cq, void *private)
 {
-	queue_work(cq->comp_wq, &cq->work);
+	queue_work(cq->comp_wq, &cq->workqueue_poll.work);
 }
 
 /**
@@ -172,12 +227,20 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private,
 		cq->comp_handler = ib_cq_completion_softirq;
 
 		irq_poll_init(&cq->iop, IB_POLL_BUDGET_IRQ, ib_poll_handler);
+		if (cq->device->modify_cq && use_am) {
+			blk_dim_init(&cq->iop.dim, ib_cq_blk_dim_irqpoll_work);
+			cq->iop.dim_used = true;
+		}
 		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
 		break;
 	case IB_POLL_WORKQUEUE:
 	case IB_POLL_UNBOUND_WORKQUEUE:
 		cq->comp_handler = ib_cq_completion_workqueue;
-		INIT_WORK(&cq->work, ib_cq_poll_work);
+		INIT_WORK(&cq->workqueue_poll.work, ib_cq_poll_work);
+		if (cq->device->modify_cq && use_am) {
+			blk_dim_init(&cq->workqueue_poll.dim, ib_cq_blk_dim_workqueue_work);
+			cq->workqueue_poll.dim_used = true;
+		}
 		ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
 		cq->comp_wq = (cq->poll_ctx == IB_POLL_WORKQUEUE) ?
 				ib_comp_wq : ib_comp_unbound_wq;
@@ -217,7 +280,9 @@ void ib_free_cq(struct ib_cq *cq)
 		break;
 	case IB_POLL_WORKQUEUE:
 	case IB_POLL_UNBOUND_WORKQUEUE:
-		cancel_work_sync(&cq->work);
+		cancel_work_sync(&cq->workqueue_poll.work);
+		if (cq->workqueue_poll.dim_used)
+			flush_work(&cq->iop.dim.work);
 		break;
 	default:
 		WARN_ON_ONCE(1);
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 971e9a9ebdaf..f3e5dbe4689a 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4365,7 +4365,7 @@ static void handle_drain_completion(struct ib_cq *cq,
 				irq_poll_enable(&cq->iop);
 				break;
 			case IB_POLL_WORKQUEUE:
-				cancel_work_sync(&cq->work);
+				cancel_work_sync(&cq->workqueue_poll.work);
 				break;
 			default:
 				WARN_ON_ONCE(1);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index dd2ae640bc84..4b65147010cc 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -6102,7 +6102,7 @@ static void handle_drain_completion(struct ib_cq *cq,
 				irq_poll_enable(&cq->iop);
 				break;
 			case IB_POLL_WORKQUEUE:
-				cancel_work_sync(&cq->work);
+				cancel_work_sync(&cq->workqueue_poll.work);
 				break;
 			default:
 				WARN_ON_ONCE(1);
diff --git a/include/linux/irq_poll.h b/include/linux/irq_poll.h
index 16aaeccb65cb..ede1a390159b 100644
--- a/include/linux/irq_poll.h
+++ b/include/linux/irq_poll.h
@@ -2,14 +2,21 @@
 #ifndef IRQ_POLL_H
 #define IRQ_POLL_H
 
+#include <linux/blk_dim.h>
+
 struct irq_poll;
 typedef int (irq_poll_fn)(struct irq_poll *, int);
+typedef int (irq_poll_dim_fn)(struct irq_poll *);
 
 struct irq_poll {
 	struct list_head list;
 	unsigned long state;
 	int weight;
 	irq_poll_fn *poll;
+
+	bool dim_used;
+	struct dim dim;
+	irq_poll_dim_fn *dimfn;
 };
 
 enum {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a3ceed3a040a..d8060c3cee06 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1584,6 +1584,13 @@ enum ib_poll_context {
 	IB_POLL_UNBOUND_WORKQUEUE, /* poll from unbound workqueue */
 };
 
+struct ib_cq_workqueue_poll {
+	struct dim              dim;
+	struct work_struct      work;
+	bool                    dim_used;
+};
+
+
 struct ib_cq {
 	struct ib_device       *device;
 	struct ib_uobject      *uobject;
@@ -1595,8 +1602,8 @@ struct ib_cq {
 	enum ib_poll_context	poll_ctx;
 	struct ib_wc		*wc;
 	union {
-		struct irq_poll		iop;
-		struct work_struct	work;
+		struct irq_poll			iop;
+		struct ib_cq_workqueue_poll	workqueue_poll;
 	};
 	struct workqueue_struct *comp_wq;
 	/*
diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 86a709954f5a..2b5e41f0e583 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -53,6 +53,8 @@ static void __irq_poll_complete(struct irq_poll *iop)
 	list_del(&iop->list);
 	smp_mb__before_atomic();
 	clear_bit_unlock(IRQ_POLL_F_SCHED, &iop->state);
+	if (iop->dim_used)
+		blk_dim(&iop->dim, iop->dim.measuring_sample);
 }
 
 /**
@@ -86,6 +88,7 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 	while (!list_empty(list)) {
 		struct irq_poll *iop;
 		int work, weight;
+		struct dim_sample *m_sample;
 
 		/*
 		 * If softirq window is exhausted then punt.
@@ -104,10 +107,16 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 		 */
 		iop = list_entry(list->next, struct irq_poll, list);
 
+		m_sample = &iop->dim.measuring_sample;
 		weight = iop->weight;
 		work = 0;
-		if (test_bit(IRQ_POLL_F_SCHED, &iop->state))
+		if (test_bit(IRQ_POLL_F_SCHED, &iop->state)) {
 			work = iop->poll(iop, weight);
+			if (iop->dim_used)
+				dim_create_sample(m_sample->event_ctr + 1, m_sample->pkt_ctr,
+					m_sample->byte_ctr, m_sample->comp_ctr + work,
+						&iop->dim.measuring_sample);
+		}
 
 		budget -= work;
 
@@ -144,6 +153,8 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
  **/
 void irq_poll_disable(struct irq_poll *iop)
 {
+	if (iop->dim_used)
+		flush_work(&iop->dim.work);
 	set_bit(IRQ_POLL_F_DISABLE, &iop->state);
 	while (test_and_set_bit(IRQ_POLL_F_SCHED, &iop->state))
 		msleep(1);
-- 
2.19.1

