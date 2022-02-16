Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DC1C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 17:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbiBPRJg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:09:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiBPRJg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 12:09:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05B2A64C2
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 09:09:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F00A868B05; Wed, 16 Feb 2022 18:09:19 +0100 (CET)
Date:   Wed, 16 Feb 2022 18:09:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Markus =?iso-8859-1?Q?Bl=F6chl?= <Markus.Bloechl@ipetronik.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Message-ID: <20220216170919.GA20782@lst.de>
References: <20220216150901.4166235-1-hch@lst.de> <20220216154950.q3uit4ucl6xupvhe@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216154950.q3uit4ucl6xupvhe@ipetronik.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 04:49:50PM +0100, Markus Blöchl wrote:
> > -	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
> > -	blk_queue_start_drain(q);
> > +	set_bit(GD_DEAD, &disk->state);
> > +	blk_queue_start_drain(disk->queue);
> >  }
> > -EXPORT_SYMBOL_GPL(blk_set_queue_dying);
> > +EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
> 
> I might have missed something here, but assuming I am a driver which
> employs multiple different queues, some with a disk attached to them,
> some without (Is that possible? The admin queue e.g.?)
> and I just lost my connection and want to notify everything below me
> that their connection is dead.
> Would I really want to kill disk queues differently from non-disk
> queues?

Yes.  Things like the admin queue in nvme are under full control of
the driver.  While the "disk" queues just get I/O from the file system
and thus need to be cut off.

> How is the admin queue killed? Is it even?

It isn't.  We just stop submitting to it.

> > --- a/drivers/block/mtip32xx/mtip32xx.c
> > +++ b/drivers/block/mtip32xx/mtip32xx.c
> > @@ -4112,7 +4112,7 @@ static void mtip_pci_remove(struct pci_dev *pdev)
> >  			"Completion workers still active!\n");
> >  	}
> >  
> > -	blk_set_queue_dying(dd->queue);
> > +	blk_mark_disk_dead(dd->disk);
> 
> This driver is weird, I did find are reliably hint that dd->disk always
> exists here. At least mtip_block_remove() has an extra check for that.

The driver is a bit of a mess indeed, but the disk and queue will be
non-NULL if ->probe returns successfully so this is fine.  It is more
that some of the checks are not required.

> It also only set QUEUE_FLAG_DEAD if it detects a surprise removal and
> not QUEUE_FLAG_DYING.

Yes, this driver will need further work.
