Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49803 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbcKQK2K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2016 05:28:10 -0500
Date: Thu, 17 Nov 2016 02:28:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@fb.com,
        martin.petersen@oracle.com, keith.busch@intel.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
Subject: Re: [PATCH 5/5] nvmet: add support for the Write Zeroes command
Message-ID: <20161117102803.GA8295@infradead.org>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-6-git-send-email-chaitanya.kulkarni@hgst.com>
 <6591bf30-6f66-c4e6-e304-9b580489a9b9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6591bf30-6f66-c4e6-e304-9b580489a9b9@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 16, 2016 at 06:47:22PM +0200, Sagi Grimberg wrote:
> > +	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
> > +				GFP_KERNEL, &bio, false))
> > +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> > +
> > +	if (bio) {
> > +		bio->bi_private = req;
> > +		bio->bi_end_io = nvmet_bio_done;
> > +		if (status) {
> 
> if (status != NVME_SC_SUCCESS) can this happen?
> can we end up with a bio if __blkdev_issue_zeroout
> failed?

This can't happen, it's copy and paste from deallocate which operates on a
range, and where it could happen.

> > +			bio->bi_error = -EIO;
> > +			bio_endio(bio);
> 
> Something looks odd here, how does the status propagate in
> this case?

We'd only need the -EIO - but as said this can't actually happen and
we can just remove it.
