Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C36EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 15:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiBPPqM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:46:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiBPPqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 10:46:12 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AE52A796A
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 07:45:59 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C07C768B05; Wed, 16 Feb 2022 16:45:55 +0100 (CET)
Date:   Wed, 16 Feb 2022 16:45:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        markus.bloechl@ipetronik.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Message-ID: <20220216154555.GA19362@lst.de>
References: <20220216150901.4166235-1-hch@lst.de> <20220216150901.4166235-2-hch@lst.de> <20220216153722.GB1936276@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216153722.GB1936276@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 07:37:22AM -0800, Keith Busch wrote:
> On Wed, Feb 16, 2022 at 04:09:01PM +0100, Christoph Hellwig wrote:
> > -	fsync_bdev(disk->part0);
> > +	/*
> > +	 * If this is not a surprise removal see if there is a file system
> > +	 * mounted on this device and sync it (although this won't work for
> > +	 * partitions).  For surprise removals that have already marked the
> > +	 * disk dead skip this call as no I/O is possible anyway.
> > +	 */
> > +	if (!test_bit(GD_DEAD, &disk->state))
> > +		fsync_bdev(disk->part0);
> >  	__invalidate_device(disk->part0, true);
> 
> It used to be that any dirty pages would attempt to write, and get an
> error on a surprise removal. Now that you're skipping the fsync_bdev(),
> is something else taking responsibility to error those pages?

truncate_inode_pages when closing the device.
