Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD507C2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9EE20882
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 14:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKFOOd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 09:14:33 -0500
Received: from verein.lst.de ([213.95.11.211]:51728 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgKFOOc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Nov 2020 09:14:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 71E9868B02; Fri,  6 Nov 2020 15:14:29 +0100 (CET)
Date:   Fri, 6 Nov 2020 15:14:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        joshi.k@samsung.com, k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH] nvme: enable ro namespace for ZNS without append
Message-ID: <20201106141428.GA23884@lst.de>
References: <20201106122637.14490-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106122637.14490-1-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (blk_queue_is_zoned(disk->queue) && !ns->zoned_ns_supp)
> +		set_disk_ro(disk, true);
> +#endif

I think we can simplify this at bit.  Add a new NVME_NS_FORCE_RO flag
to ns->flags, set it in nvme_update_zone_info, and just query it here
without any ifdefs.

>  	struct request_queue *q = disk->queue;
>  	struct nvme_command c = { };
>  	struct nvme_id_ns_zns *id;
> +	bool zoned_ns_supp = true;
>  	int status;
>  
>  	/* Driver requires zone append support */
>  	if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
>  			NVME_CMD_EFFECTS_CSUPP)) {
> +		zoned_ns_supp = false;
>  		dev_warn(ns->ctrl->device,
>  			"append not supported for zoned namespace:%d\n",
>  			ns->head->ns_id);
> +	} else {
> +		/* Lazily query controller append limit for the first
> +		 * zoned namespace
> +		 */
> +		if (!ns->ctrl->max_zone_append) {
> +			status = nvme_set_max_append(ns->ctrl);
> +			if (status)
> +				return status;
> +		}

While you're at it:  my inverse the polarity of the if check as that reads just
a little more natural, and maybe mention in the warning that the namespace is
forced to read-only mode?

Otherwise this looks good.
