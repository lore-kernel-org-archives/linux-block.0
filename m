Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49961 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934293AbdBQPS2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 10:18:28 -0500
Date: Fri, 17 Feb 2017 10:26:51 -0500
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: scott.bauer@intel.com, jonathan.derrick@intel.com, axboe@fb.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: re-check security protocol support after reset
Message-ID: <20170217152651.GA18275@localhost.localdomain>
References: <20170217125941.14319-1-hch@lst.de>
 <20170217125941.14319-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217125941.14319-5-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 17, 2017 at 01:59:41PM +0100, Christoph Hellwig wrote:
> @@ -1789,7 +1789,8 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (result)
>  		goto out;
>  
> -	if ((dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) && !dev->ctrl.opal_dev) {
> +	kfree(dev->ctrl.opal_dev);
> +	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
>  		dev->ctrl.opal_dev =
>  			init_opal_dev(&dev->ctrl, &nvme_sec_submit);
>  	}

A couple things.

This has a use-after-free in opal_unlock_from_suspend if the nvme
device had an opal_dev before, but no longer support the capability
after resume. So you'd want to set ctrl.opal_dev to NULL after the free.

But we don't want to unconditionally free it anyway during resume
since opal_unlock_from_suspend requires the exisiting opal_dev state
information saved in the 'unlk_list'.

Something like this instead:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ddc51ad..8fa6be9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1789,13 +1789,17 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	if ((dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) && !dev->ctrl.opal_dev) {
-		dev->ctrl.opal_dev =
-			init_opal_dev(&dev->ctrl, &nvme_sec_submit);
+	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP)
+		if (was_suspend && dev->ctrl.opal_dev)
+			opal_unlock_from_suspend(dev->ctrl.opal_dev);
+		else if (!dev->ctrl.opal_dev)
+			dev->ctrl.opal_dev =
+				init_opal_dev(&dev->ctrl, &nvme_sec_submit);
+	} else {
+		kfree(dev->ctrl.opal_dev);
+		dev->ctrl.opal_dev = NULL;
 	}
 
-	if (was_suspend)
-		opal_unlock_from_suspend(dev->ctrl.opal_dev);
 
 	result = nvme_setup_io_queues(dev);
 	if (result)
--
