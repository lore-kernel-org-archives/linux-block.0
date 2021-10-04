Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CE1C433EF
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F33561269
	for <linux-block@archiver.kernel.org>; Mon,  4 Oct 2021 12:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhJDM1t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 08:27:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36140 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhJDM1r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Oct 2021 08:27:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 110BF1FFE8;
        Mon,  4 Oct 2021 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633350358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IxxPlB8tzOE9SFdP2TOqN9xF9p9hy5CQPEmRi44+Pc=;
        b=LxxzGCNr1pIiX1sj4CFAHBVWTSgK5By2QZ0gMr1jeDOQkbJWhfgz+EFflxdjp+ZKeI1zEL
        kd3eRPczbKci1YbzQRUsvESYO6x07bxQV0mszHK39Jih6xd6mO8NW4haYU6YvFcLS2SiQj
        roObUJnwAl4ATSAgRUbRCboeFOCw4+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633350358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IxxPlB8tzOE9SFdP2TOqN9xF9p9hy5CQPEmRi44+Pc=;
        b=LTIWelOtknuEf99+xDwbmAPl7HKzN0bZxdc5N7KqVZDT6VcI1m4rkOhnv6HpAtths4yT2Q
        ihXynJAUGS5CgSDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id EB25FA3B88;
        Mon,  4 Oct 2021 12:25:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id D458E518F25A; Mon,  4 Oct 2021 14:25:57 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [RFC] nvme-fc: Allow managed IRQs
Date:   Mon,  4 Oct 2021 14:25:48 +0200
Message-Id: <20211004122548.113722-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <YUL8wz6CM4jrUeeN@T590>
References: <YUL8wz6CM4jrUeeN@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme-fc is currently the only user of blk_mq_alloc_request_hctx().
With the recent changes to teach the nvme subsystem to honor managed
IRQs, the assumption was the complete nvme-fc doesn't use managed
IRQs. Unfortunately, the qla2xxx driver uses the managed IRQs.

Add an interface the nvme-fc drivers to update the mapping and also to
set the use_managed_irq flag. This is very ugly as we have to pass
down struct blk_mq_tag_set. I haven't found any better way so far.

Relax the requirement in the blk_mq_alloc_request_hctx() that only
!managed IRQs are supported. As long one CPU is online in the
requested hctx all is good. If this is not the case we return an
error which allows the upper layer to start the reconnect loop.

As the current qla2xxx already depends on managed IRQs the main
difference with and without this patch is, that we see

  nvme nvme8: Connect command failed, error wo/DNR bit: -16402
  nvme nvme8: NVME-FC{8}: reset: Reconnect attempt failed (-18)

instead of just timeouts such as

  qla2xxx [0000:81:00.0]-5032:1: ABT_IOCB: Invalid completion handle (1da) -- timed-out.

In both cases the system recovers as soon at least one CPUs is online
in all hctx. Also note, this is only for admin request. As long
no FC reset happens and a reconnect attempt is triggered, user space
is able to issue I/Os do the target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

Hi,

I've played a bit with this patch to figure out what the impact is for
the qla2xxx driver. Basically, the situation doesn't change a lot with
Ming's patches. If we happen to run into the situation that all CPUs
are offline in one hctx and a reconnect attempt is triggered all
traffic to the target cease. But as soon we have at least one CPU
online in all hctx the system recovers.

This patch just makes it a bit more verbose (maybe a warning could be
added to blk_mq_alloc_request_hctx()).

Thanks,
Daniel

 block/blk-mq.c                  | 10 +++++++---
 drivers/nvme/host/fc.c          | 13 +++++++++++++
 drivers/scsi/qla2xxx/qla_nvme.c | 14 ++++++++++++++
 drivers/scsi/qla2xxx/qla_os.c   |  3 +++
 include/linux/nvme-fc-driver.h  |  4 ++++
 5 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a2db50886a26..df65690bf649 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -486,9 +486,13 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
 
-	WARN_ON_ONCE(blk_mq_hctx_use_managed_irq(data.hctx));
-
-	cpu = blk_mq_first_mapped_cpu(data.hctx);
+	if (blk_mq_hctx_use_managed_irq(data.hctx)) {
+		cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+		if (cpu >= nr_cpu_ids)
+			return ERR_PTR(ret);
+	} else {
+		cpu = blk_mq_first_mapped_cpu(data.hctx);
+	}
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (!q->elevator)
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aa14ad963d91..001ba8f0776b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2841,6 +2841,17 @@ nvme_fc_complete_rq(struct request *rq)
 	nvme_fc_ctrl_put(ctrl);
 }
 
+static int
+nvme_fc_map_queues(struct blk_mq_tag_set *set)
+{
+	struct nvme_fc_ctrl *ctrl = set->driver_data;
+
+	if (ctrl->lport->ops->map_queues)
+		return ctrl->lport->ops->map_queues(&ctrl->lport->localport, set);
+
+	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+}
+
 
 static const struct blk_mq_ops nvme_fc_mq_ops = {
 	.queue_rq	= nvme_fc_queue_rq,
@@ -2849,6 +2860,7 @@ static const struct blk_mq_ops nvme_fc_mq_ops = {
 	.exit_request	= nvme_fc_exit_request,
 	.init_hctx	= nvme_fc_init_hctx,
 	.timeout	= nvme_fc_timeout,
+	.map_queues	= nvme_fc_map_queues,
 };
 
 static int
@@ -3392,6 +3404,7 @@ static const struct blk_mq_ops nvme_fc_admin_mq_ops = {
 	.exit_request	= nvme_fc_exit_request,
 	.init_hctx	= nvme_fc_init_admin_hctx,
 	.timeout	= nvme_fc_timeout,
+	.map_queues	= nvme_fc_map_queues,
 };
 
 
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 1c5da2dbd6f9..b7681f66d05b 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -667,6 +667,19 @@ static void qla_nvme_remoteport_delete(struct nvme_fc_remote_port *rport)
 	complete(&fcport->nvme_del_done);
 }
 
+static int qla_nvme_map_queues(struct nvme_fc_local_port *lport,
+				struct blk_mq_tag_set *set)
+{
+
+	struct blk_mq_queue_map *qmap = &set->map[HCTX_TYPE_DEFAULT];
+	int ret;
+
+	ret = blk_mq_map_queues(qmap);
+	qmap->use_managed_irq = true;
+
+	return ret;
+}
+
 static struct nvme_fc_port_template qla_nvme_fc_transport = {
 	.localport_delete = qla_nvme_localport_delete,
 	.remoteport_delete = qla_nvme_remoteport_delete,
@@ -676,6 +689,7 @@ static struct nvme_fc_port_template qla_nvme_fc_transport = {
 	.ls_abort	= qla_nvme_ls_abort,
 	.fcp_io		= qla_nvme_post_cmd,
 	.fcp_abort	= qla_nvme_fcp_abort,
+	.map_queues	= qla_nvme_map_queues,
 	.max_hw_queues  = 8,
 	.max_sgl_segments = 1024,
 	.max_dif_sgl_segments = 64,
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d2e40aaba734..188ce9b7f407 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7914,6 +7914,9 @@ static int qla2xxx_map_queues(struct Scsi_Host *shost)
 		rc = blk_mq_map_queues(qmap);
 	else
 		rc = blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
+
+	qmap->use_managed_irq = true;
+
 	return rc;
 }
 
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 2a38f2b477a5..afae40d8c347 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -471,6 +471,8 @@ struct nvme_fc_remote_port {
  *       specified by the fcp_request->private pointer.
  *       Value is Mandatory. Allowed to be zero.
  */
+struct blk_mq_tag_set;
+
 struct nvme_fc_port_template {
 	/* initiator-based functions */
 	void	(*localport_delete)(struct nvme_fc_local_port *);
@@ -497,6 +499,8 @@ struct nvme_fc_port_template {
 	int	(*xmt_ls_rsp)(struct nvme_fc_local_port *localport,
 				struct nvme_fc_remote_port *rport,
 				struct nvmefc_ls_rsp *ls_rsp);
+	int	(*map_queues)(struct nvme_fc_local_port *localport,
+				struct blk_mq_tag_set *set);
 
 	u32	max_hw_queues;
 	u16	max_sgl_segments;
-- 
2.29.2

