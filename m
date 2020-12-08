Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7899EC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 14:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D6523A33
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 14:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgLHOWe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:22:34 -0500
Received: from verein.lst.de ([213.95.11.211]:46410 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgLHOWe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Dec 2020 09:22:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 482E16736F; Tue,  8 Dec 2020 15:21:51 +0100 (CET)
Date:   Tue, 8 Dec 2020 15:21:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        minwoo.im.dev@gmail.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2] nvme: enable char device per namespace
Message-ID: <20201208142151.GA4108@lst.de>
References: <20201208132934.625-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208132934.625-1-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A bunch of nitpicks (mostly naming as usual, sorry..):

> +static int __nvme_ns_ioctl(struct gendisk *disk, unsigned int cmd,
> +			   unsigned long arg)
>  {

What about nvme_disk_ioctl instead as that is what it operates on?

> +static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
> +		      unsigned int cmd, unsigned long arg)
> +{
> +	return __nvme_ns_ioctl(bdev->bd_disk, cmd, arg);
> +}
> +
> +static long nvme_cdev_ioctl(struct file *file, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	return __nvme_ns_ioctl((struct gendisk *)file->private_data, cmd, arg);
> +}

No need for the cast.

Also can we keep all the char device methods together close to the
struct file_operations declaration?  I just prefer to keep the code
a little grouped.

> -static int nvme_open(struct block_device *bdev, fmode_t mode)
> +static int __nvme_open(struct nvme_ns *ns)
>  {
> -	struct nvme_ns *ns = bdev->bd_disk->private_data;
> -
>  #ifdef CONFIG_NVME_MULTIPATH
>  	/* should never be called due to GENHD_FL_HIDDEN */
>  	if (WARN_ON_ONCE(ns->head->disk))
> @@ -1846,12 +1859,24 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
>  	return -ENXIO;
>  }
>  
> +static void __nvme_release(struct nvme_ns *ns)
> +{
> +	module_put(ns->ctrl->ops->module);
> +	nvme_put_ns(ns);
> +}

nvme_ns_open and nvme_ns_release?

> +
> +static int nvme_open(struct block_device *bdev, fmode_t mode)
> +{
> +	struct nvme_ns *ns = bdev->bd_disk->private_data;
> +
> +	return __nvme_open(ns);
> +}
> +
>  static void nvme_release(struct gendisk *disk, fmode_t mode)
>  {
>  	struct nvme_ns *ns = disk->private_data;
>  
> -	module_put(ns->ctrl->ops->module);
> -	nvme_put_ns(ns);
> +	__nvme_release(ns);

No need for the local ns variable in both cases.

> +static int nvme_cdev_open(struct inode *inode, struct file *file)
> +{
> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
> +	int ret;
> +
> +	ret = __nvme_open(ns);
> +	if (!ret)
> +		file->private_data = ns->disk;
> +
> +	return ret;

Do we need the ->private_data assignment at all?  I think the ioctl
handler could just grab it directly from i_cdev.

> +	sprintf(cdisk_name, "nvme%dn%dc", ctrl->instance, ns->head->instance);

And the most important naming decision is this.  I have two issues with
naming still:

 - we aready use the c for controller in the hidden disk naming.  Although
   that is in a different position, but I think this not super intuitive.
 - this is missing multipath support entirely, so once we want to add
   multipath support we'll run into issues.  So maybe use something
   based off the hidden node naming?  E.g.:

	sprintf(disk_name, "nvme-generic-%dc%dn%d", ctrl->subsys->instance,
		ctrl->instance, ns->head->instance);

> +	/* When the device does not support any of the features required by the
> +	 * kernel (or viceversa), hide the block device. We can still rely on
> +	 * the namespace char device for submitting IOCTLs
> +	 */

Normal kernel comment style is the opening

	/*

on its own line.

>  	if (nvme_update_ns_info(ns, id))
> -		goto out_put_disk;
> +		disk->flags |= GENHD_FL_HIDDEN;

I don't think we can do this based on all the error returns.  I think
we'll have to move the flags manipulation into nvme_update_ns_info to
also cover the revalidate case.
