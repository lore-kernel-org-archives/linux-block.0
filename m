Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12078C433E9
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 16:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9B764F07
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 16:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhBXQpg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:45:36 -0500
Received: from verein.lst.de ([213.95.11.211]:38603 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235220AbhBXQp2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 11:45:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF31A67357; Wed, 24 Feb 2021 17:44:43 +0100 (CET)
Date:   Wed, 24 Feb 2021 17:44:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        minwoo.im.dev@gmail.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V5 1/2] nvme: enable char device per namespace
Message-ID: <20210224164443.GA11338@lst.de>
References: <20210222190107.8479-1-javier.gonz@samsung.com> <20210222190107.8479-2-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222190107.8479-2-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static inline bool nvme_dev_is_generic(struct device *dev)
> +{
> +	return dev->class == nvme_ns_class;
> +}
> +
> +static inline bool nvme_ns_is_generic(struct nvme_ns *ns)
> +{
> +	return !!ns->minor;
> +}

What does is_generic mean here?  In doubt add a few comments..

>  	/* some standard values */
> @@ -2241,6 +2270,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	return 0;
>  
>  out_unfreeze:
> +	/*
> +	 * When the device does not support any of the features required by the
> +	 * kernel (or viceversa), hide the block device. We can still rely on
> +	 * the namespace char device for submitting IOCTLs
> +	 */
> +	ns->disk->flags |= GENHD_FL_HIDDEN;
> +

The out_unfreeze case also handles all kinds of real error, so this needs
to move into a better spot, and probably check a specific error code
or even explicit indicator.

> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
> +{
> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);

> +	struct nvme_ns *ns = container_of(file->f_inode->i_cdev,
> +				struct nvme_ns, cdev);

Maybe add a little cdev_to_ns() helper?

> -	if (nvme_update_ns_info(ns, id))
> -		goto out_put_disk;
> +	nvme_update_ns_info(ns, id);

I don't think we can simplify ignore all errors here.

> +static inline struct nvme_ns *nvme_get_ns_from_cdev(struct device *dev)
> +{
> +	return dev_get_drvdata(dev);
> +}

I think we can keep this in core.c.
