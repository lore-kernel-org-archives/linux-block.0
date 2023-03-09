Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D973FC64EC4
	for <linux-block@archiver.kernel.org>; Thu,  9 Mar 2023 03:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCIDMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 22:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjCIDMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 22:12:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A5A8B330
        for <linux-block@vger.kernel.org>; Wed,  8 Mar 2023 19:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cnh2PwgwDS2WH4kIC5pZpp2NHAqDnwhKLpmMJgyiWyU=; b=x3XQ+2EJFMpjRAh/d98IefK8Wp
        11SFpd8vD/fMb8C4LbuySejKOaydXq4V+c7MO2UgfzPWd8rvMvyBteS9iRQLroruQUryATngbak7G
        fgcH5fpzJibyyPMEdglSIQX7D+tgueXScBvqDHcYXvKt324unToG25EB6KYi7pLvZVQZd/8tD4iUB
        gYhqPsw6FfeT9fTj/C2oh5YO2blTRm65/H5xH29kdkXVieSWpgvPH8j8ORFOu8UfFNt227E4WvoV6
        X4eqGtNn6/s1neVDEjv6TsXcW4yWAWMWQ1opq3DDzubHt/p6rpG7mJxwPK8CFeCh4Tz5fWE32io/E
        /QZ5Qj/g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pa6hs-007cIj-QZ; Thu, 09 Mar 2023 03:12:40 +0000
Date:   Wed, 8 Mar 2023 19:12:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Boaz Harrosh <boazh@netapp.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH 3/5] brd: make sector size configurable
Message-ID: <ZAlOqMMKWhyIzmlN@bombadil.infradead.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306120127.21375-4-hare@suse.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 06, 2023 at 01:01:25PM +0100, Hannes Reinecke wrote:
> Add a module option 'rd_blksize' to allow the user to change
> the sector size of the RAM disks.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/block/brd.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index fc41ea641dfb..11bac3c3f1b6 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -46,6 +46,8 @@ struct brd_device {
>  	spinlock_t		brd_lock;
>  	struct radix_tree_root	brd_folios;
>  	u64			brd_nr_folios;
> +	unsigned int		brd_sector_shift;
> +	unsigned int		brd_sector_size;
>  };

Why not just do this first and initialize this to the defaults set
without the module parameter. Then you don't need to declare over
and over unsigned int rd_sectors, etc in tons of routines and just
pass the brd which most routines get.

Then most of this and the prior patch can be squeezed into one.

The functional changes would be the addition of the module parameter.

> @@ -410,7 +418,7 @@ static int brd_alloc(int i)
>  	 *  otherwise fdisk will align on 1M. Regardless this call
>  	 *  is harmless)
>  	 */
> -	blk_queue_physical_block_size(disk->queue, PAGE_SIZE);
> +	blk_queue_physical_block_size(disk->queue, rd_blksize);

And this was added for DAX support, but DAX support was long removed
from brd see commit 7a862fbbdec6 ("brd: remove dax support"). This
nugget was added by Boaz via commit c8fa31730fc72a8 ("brd: Request from
fdisk 4k alignment"), but if we don't support DAX, can't we just kill
that line?

Current doc for blk_queue_physical_block_size() says:

*   This should be set to the lowest possible sector size that the             
*   hardware can operate on without reverting to read-modify-write             
*   operations.  

But since we're working directly with RAM, do we care?

The comment above that line referring to direct_access should be killed
at the very least.

While you're at it, can you then also update Documentation/filesystems/dax.rst
to remove the brd as an example driver with DAX support.

That leaves us with only a few block drivers with DAX:

- dcssblk: s390 dcss block device driver                                        
- pmem: NVDIMM persistent memory driver  
- some dm targets
- fuse virtio_fs

Wonder which is the right example these days for DAX, now that
persistant memory has End of Life'd with Optane dead, curious also of
the value of the above and DAX in general other than support for
whatever made it out.

Should we EOL DAX too?

  Luis
