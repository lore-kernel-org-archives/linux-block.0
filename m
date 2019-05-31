Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39444C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1854B25F06
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfEaC2y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:28:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaC2y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:28:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1E0A3082133;
        Fri, 31 May 2019 02:28:53 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8C9160CAC;
        Fri, 31 May 2019 02:28:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/9] scsi: hpsa: convert private reply queue to blk-mq hw queue
Date:   Fri, 31 May 2019 10:27:58 +0800
Message-Id: <20190531022801.10003-7-ming.lei@redhat.com>
In-Reply-To: <20190531022801.10003-1-ming.lei@redhat.com>
References: <20190531022801.10003-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 31 May 2019 02:28:53 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SCSI's reply qeueue is very similar with blk-mq's hw queue, both
assigned by IRQ vector, so map te private reply queue into blk-mq's hw
queue via .host_tagset.

Then the private reply mapping can be removed.

Another benefit is that the request/irq lost issue may be solved in
generic approach because managed IRQ may be shutdown during CPU
hotplug.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/hpsa.c | 49 ++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 1bef1da273c2..c7136f9f0ce1 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -51,6 +51,7 @@
 #include <linux/jiffies.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
+#include <linux/blk-mq-pci.h>
 #include <asm/unaligned.h>
 #include <asm/div64.h>
 #include "hpsa_cmd.h"
@@ -902,6 +903,18 @@ static ssize_t host_show_legacy_board(struct device *dev,
 	return snprintf(buf, 20, "%d\n", h->legacy_board ? 1 : 0);
 }
 
+static int hpsa_map_queues(struct Scsi_Host *shost)
+{
+	struct ctlr_info *h = shost_to_hba(shost);
+	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+
+	/* Switch to cpu mapping in case that managed IRQ isn't used */
+	if (shost->nr_hw_queues > 1)
+		return blk_mq_pci_map_queues(qmap, h->pdev, 0);
+	else
+		return blk_mq_map_queues(qmap);
+}
+
 static DEVICE_ATTR_RO(raid_level);
 static DEVICE_ATTR_RO(lunid);
 static DEVICE_ATTR_RO(unique_id);
@@ -971,6 +984,7 @@ static struct scsi_host_template hpsa_driver_template = {
 	.slave_alloc		= hpsa_slave_alloc,
 	.slave_configure	= hpsa_slave_configure,
 	.slave_destroy		= hpsa_slave_destroy,
+	.map_queues		= hpsa_map_queues,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl		= hpsa_compat_ioctl,
 #endif
@@ -978,6 +992,7 @@ static struct scsi_host_template hpsa_driver_template = {
 	.shost_attrs = hpsa_shost_attrs,
 	.max_sectors = 2048,
 	.no_write_same = 1,
+	.host_tagset = 1,
 };
 
 static inline u32 next_command(struct ctlr_info *h, u8 q)
@@ -1145,7 +1160,7 @@ static void __enqueue_cmd_and_start_io(struct ctlr_info *h,
 	dial_down_lockup_detection_during_fw_flash(h, c);
 	atomic_inc(&h->commands_outstanding);
 
-	reply_queue = h->reply_map[raw_smp_processor_id()];
+	reply_queue = scsi_cmnd_hctx_index(h->scsi_host, c->scsi_cmd);
 	switch (c->cmd_type) {
 	case CMD_IOACCEL1:
 		set_ioaccel1_performant_mode(h, c, reply_queue);
@@ -5785,6 +5800,9 @@ static int hpsa_scsi_add_host(struct ctlr_info *h)
 {
 	int rv;
 
+	/* map reply queue to blk_mq hw queue */
+	h->scsi_host->nr_hw_queues = h->nreply_queues;
+
 	rv = scsi_add_host(h->scsi_host, &h->pdev->dev);
 	if (rv) {
 		dev_err(&h->pdev->dev, "scsi_add_host failed\n");
@@ -7386,26 +7404,6 @@ static void hpsa_disable_interrupt_mode(struct ctlr_info *h)
 	h->msix_vectors = 0;
 }
 
-static void hpsa_setup_reply_map(struct ctlr_info *h)
-{
-	const struct cpumask *mask;
-	unsigned int queue, cpu;
-
-	for (queue = 0; queue < h->msix_vectors; queue++) {
-		mask = pci_irq_get_affinity(h->pdev, queue);
-		if (!mask)
-			goto fallback;
-
-		for_each_cpu(cpu, mask)
-			h->reply_map[cpu] = queue;
-	}
-	return;
-
-fallback:
-	for_each_possible_cpu(cpu)
-		h->reply_map[cpu] = 0;
-}
-
 /* If MSI/MSI-X is supported by the kernel we will try to enable it on
  * controllers that are capable. If not, we use legacy INTx mode.
  */
@@ -7802,9 +7800,6 @@ static int hpsa_pci_init(struct ctlr_info *h)
 	if (err)
 		goto clean1;
 
-	/* setup mapping between CPU and reply queue */
-	hpsa_setup_reply_map(h);
-
 	err = hpsa_pci_find_memory_BAR(h->pdev, &h->paddr);
 	if (err)
 		goto clean2;	/* intmode+region, pci */
@@ -8516,7 +8511,6 @@ static struct workqueue_struct *hpsa_create_controller_wq(struct ctlr_info *h,
 
 static void hpda_free_ctlr_info(struct ctlr_info *h)
 {
-	kfree(h->reply_map);
 	kfree(h);
 }
 
@@ -8528,11 +8522,6 @@ static struct ctlr_info *hpda_alloc_ctlr_info(void)
 	if (!h)
 		return NULL;
 
-	h->reply_map = kcalloc(nr_cpu_ids, sizeof(*h->reply_map), GFP_KERNEL);
-	if (!h->reply_map) {
-		kfree(h);
-		return NULL;
-	}
 	return h;
 }
 
-- 
2.20.1

