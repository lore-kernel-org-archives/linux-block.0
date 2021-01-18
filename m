Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43702C433E6
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 18:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1094122D71
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 18:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407543AbhARS2V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:28:21 -0500
Received: from verein.lst.de ([213.95.11.211]:49165 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407498AbhARS2G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 13:28:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C7B506736F; Mon, 18 Jan 2021 19:27:23 +0100 (CET)
Date:   Mon, 18 Jan 2021 19:27:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Message-ID: <20210118182723.GD11082@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-5-chaitanya.kulkarni@wdc.com> <20210112074805.GA24443@lst.de> <BYAPR04MB4965CE08B1DE8BC36585991686A90@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965CE08B1DE8BC36585991686A90@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 13, 2021 at 04:57:15AM +0000, Chaitanya Kulkarni wrote:
> >>  	/* command sets supported: NVMe command set: */
> >>  	ctrl->cap = (1ULL << 37);
> >> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> >> +		ctrl->cap |= (1ULL << 43);
> >>  	/* CC.EN timeout in 500msec units: */
> >>  	ctrl->cap |= (15ULL << 24);
> >>  	/* maximum queue entries supported: */
> > This needs to go into a separate patch for multiple command set support.
> > We can probably merge the CAP and CC bits with the CSI support, though.
> Do you mean previous patch ?

Yes.

> but we don't add handlers non-default I/O
> command set until this patch..

No, bit 43 just means the TP to support multiple comman sets is supported.
That infrastructure can be used even by controllers only supporting the
NVM command set.

> > bdev_is_zoned should be probably stubbed out for !CONFIG_BLK_DEV_ZONED
> > these days.
> Are you saying something like following in the prep patch ?or should
> just remove
> theIS_ENABLED(CONFIG_BLK_DEV_ZONED)part in above if?
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 028ccc9bdf8d..124086c1a0ba 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1570,6 +1570,9 @@ static inline bool bdev_is_zoned(struct
> block_device *bdev)
>  {
>         struct request_queue *q = bdev_get_queue(bdev);
>  
> +       if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +               return false;
> +
>         if (q)
>                 return blk_queue_is_zoned(q);

blk_queue_is_zoned calls blk_queue_zoned_model, which is stubbed out
already.  So no extra work should be required.

> 	/*
> 	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
> 	 * to the device physical block size. So use this value as the *physical*
> 	 * block size to avoid errors.
> 	 */

See my reply to Damien.
