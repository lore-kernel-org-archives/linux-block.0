Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:47762 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753012AbdKIVRE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Nov 2017 16:17:04 -0500
Date: Thu, 9 Nov 2017 14:21:12 -0700
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/7] nvme: implement multipath access to nvme subsystems
Message-ID: <20171109212111.GA1718@localhost.localdomain>
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171109174450.17142-5-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ahh, I incorporated non-multipath disks into the mix and observing some
trouble. Details below:

On Thu, Nov 09, 2017 at 06:44:47PM +0100, Christoph Hellwig wrote:
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (ns->head->disk) {
> +		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
> +				ctrl->cntlid, ns->head->instance);
> +		flags = GENHD_FL_HIDDEN;
> +	} else
> +#endif
> +		sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);

...
  
> +int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
> +{
> +	struct request_queue *q;
> +	bool vwc = false;
> +
> +	bio_list_init(&head->requeue_list);
> +	spin_lock_init(&head->requeue_lock);
> +	INIT_WORK(&head->requeue_work, nvme_requeue_work);
> +
> +	/*
> +	 * Add a multipath node if the subsystems supports multiple controllers.
> +	 * We also do this for private namespaces as the namespace sharing data could
> +	 * change after a rescan.
> +	 */
> +	if (!(ctrl->subsys->cmic & (1 << 1)) || !multipath)
> +		return 0;

...

> +	sprintf(head->disk->disk_name, "nvme%dn%d",
> +			ctrl->subsys->instance, head->instance);

If we've CMIC capabilities, we'll use the subsys->instance; if we don't
have CMIC, we use the ctrl->instance. 

Since the two instances are independent of each other, they can create
duplicate names.

To fix, I think we'll need to always use the subsys instance for
consistency if CONFIG_NVME_MULTIPATH=y.

---
@@ -2837,8 +2826,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 				ctrl->cntlid, ns->head->instance);
 		flags = GENHD_FL_HIDDEN;
 	} else
+		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance, ns->head->instance);
+#else
+	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 #endif
-		sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
--

This may confuse some people since the block device's name will not always
match up to the controller's chardev name, but I don't see another way
to do it.
