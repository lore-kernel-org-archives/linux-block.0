Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:48090 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934537AbdBQPvj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 10:51:39 -0500
Date: Fri, 17 Feb 2017 08:41:57 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, jonathan.derrick@intel.com,
        axboe@fb.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: re-check security protocol support after reset
Message-ID: <20170217154157.GA2254@sbauer-Z170X-UD5>
References: <20170217125941.14319-1-hch@lst.de>
 <20170217125941.14319-5-hch@lst.de>
 <20170217152651.GA18275@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217152651.GA18275@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 17, 2017 at 10:26:51AM -0500, Keith Busch wrote:
> On Fri, Feb 17, 2017 at 01:59:41PM +0100, Christoph Hellwig wrote:
> > @@ -1789,7 +1789,8 @@ static void nvme_reset_work(struct work_struct *work)
> >  	if (result)
> >  		goto out;
> >  
> > -	if ((dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) && !dev->ctrl.opal_dev) {
> > +	kfree(dev->ctrl.opal_dev);
> > +	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
> >  		dev->ctrl.opal_dev =
> >  			init_opal_dev(&dev->ctrl, &nvme_sec_submit);
> >  	}
> 
> A couple things.
> 
> This has a use-after-free in opal_unlock_from_suspend if the nvme
> device had an opal_dev before, but no longer support the capability
> after resume. So you'd want to set ctrl.opal_dev to NULL after the free.
> 
> But we don't want to unconditionally free it anyway during resume
> since opal_unlock_from_suspend requires the exisiting opal_dev state
> information saved in the 'unlk_list'.
> 
> Something like this instead:
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ddc51ad..8fa6be9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1789,13 +1789,17 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (result)
>  		goto out;
>  
> -	if ((dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) && !dev->ctrl.opal_dev) {
> -		dev->ctrl.opal_dev =
> -			init_opal_dev(&dev->ctrl, &nvme_sec_submit);
> +	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP)
> +		if (was_suspend && dev->ctrl.opal_dev)
> +			opal_unlock_from_suspend(dev->ctrl.opal_dev);
> +		else if (!dev->ctrl.opal_dev)
> +			dev->ctrl.opal_dev =
> +				init_opal_dev(&dev->ctrl, &nvme_sec_submit);
> +	} else {
> +		kfree(dev->ctrl.opal_dev);
> +		dev->ctrl.opal_dev = NULL;


Keith's comments made me realize something even deeper as well. Assuming the firmware
changed and we no longer support security commands we need to free the opal_dev structure
like we're doing but there is a possiblity that there were saved ranges in the structure
that we need to free as well.  If the user had previously told the kernel to unlock 5
ranges coming out of a suspend there are 5 structures we need to free inside the opal_dev
before we free the opal dev. We'll need to re-introduce free_opal_dev() in the opal code
like we had a while back.
