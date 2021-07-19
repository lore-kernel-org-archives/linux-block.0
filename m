Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B34C12002
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC73C6108B
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhGSJLF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 05:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhGSJLC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 05:11:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EAFC061574;
        Mon, 19 Jul 2021 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iQFwetNCWaohzZV8iv6PgQHcEZRJwlyL4/9LIhUB9pw=; b=matIADMbTAYO362FQ2DGfB63BD
        T+r8d82ScXlI16RPcEPNLHx5ljrAqlKlLZxVaqmmvCdewB8xM2nZXOryoJJuUOTQDcINEWx/pmExA
        z/7cSvlQ5frxZbrEOtm3KoE29G5OEXMyEIThZS3mYrbKYKzjcjueeVGTqgskBMatVnLyiJAK6tMRJ
        hT9Flh19DQ5xYK7cTtc4Lb6qJlTWBkaJuiND6CEkJkUXV934buWe7g4TO87ggElupQsEPdsfhsXR4
        s6V0C5zB0+pQZDzkw9jdCx4D/b7OfEDVZ0LwbI5wRKwCBMVe2qV9yZzZXnAA/k75Fr7smfLzBfrie
        SrgaNwtw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5Puf-006ibR-5I; Mon, 19 Jul 2021 09:50:23 +0000
Date:   Mon, 19 Jul 2021 10:50:13 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] block: skip queue if NULL on blk_cleanup_queue()
Message-ID: <YPVK1SPI0ZWmkOgd@infradead.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
 <20210715045531.420201-7-mcgrof@kernel.org>
 <YO/fvbe5LeAP2Mtq@infradead.org>
 <20210715190726.xlukndxddvph4fx6@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715190726.xlukndxddvph4fx6@garbanzo>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 15, 2021 at 12:07:26PM -0700, Luis Chamberlain wrote:
> > For all drivers using blk_alloc_disk/blk_mq_alloc_disk there should
> > always be a queue.  The others ones aren't ready to handle errors
> > from add_disk yet in any way I think (and I plan to fix this up
> > ASAP).
> 
> Have an example in mind?

The only ones left are nvme, dasd and scsi.  NVMe is trivial (attached),
dasd needs a little more work, I need to send up a WIP to the
maintainers.  scsi is the real problem and will require a fair amount
of work.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11779be42186..35da956acef6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3726,9 +3726,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!ns)
 		goto out_free_id;
 
-	ns->queue = blk_mq_init_queue(ctrl->tagset);
-	if (IS_ERR(ns->queue))
+	disk = blk_mq_alloc_disk(ctrl->tagset, ns);
+	if (IS_ERR(disk))
 		goto out_free_ns;
+	disk->fops = &nvme_bdev_ops;
+	disk->private_data = ns;
+
+	ns->disk = disk;
+	ns->queue = disk->queue;
 
 	if (ctrl->opts && ctrl->opts->data_digest)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
@@ -3737,20 +3742,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
 		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
 
-	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
 	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
-		goto out_free_queue;
-
-	disk = alloc_disk_node(0, node);
-	if (!disk)
-		goto out_unlink_ns;
+		goto out_cleanup_disk;
 
-	disk->fops = &nvme_bdev_ops;
-	disk->private_data = ns;
-	disk->queue = ns->queue;
 	/*
 	 * Without the multipath code enabled, multiple controller per
 	 * subsystems are visible as devices and thus we cannot use the
@@ -3759,15 +3756,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!nvme_mpath_set_disk_name(ns, disk->disk_name, &disk->flags))
 		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
 			ns->head->instance);
-	ns->disk = disk;
 
 	if (nvme_update_ns_info(ns, id))
-		goto out_put_disk;
+		goto out_unlink_ns;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk->disk_name, node)) {
 			dev_warn(ctrl->device, "LightNVM init failure\n");
-			goto out_put_disk;
+			goto out_unlink_ns;
 		}
 	}
 
@@ -3786,10 +3782,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	kfree(id);
 
 	return;
- out_put_disk:
-	/* prevent double queue cleanup */
-	ns->disk->queue = NULL;
-	put_disk(ns->disk);
+
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
@@ -3797,8 +3790,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
 	nvme_put_ns_head(ns->head);
- out_free_queue:
-	blk_cleanup_queue(ns->queue);
+ out_cleanup_disk:
+	blk_cleanup_disk(disk);
  out_free_ns:
 	kfree(ns);
  out_free_id:
