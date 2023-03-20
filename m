Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94101C6FD1C
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 22:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCTWw1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 18:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCTWwY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 18:52:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3A2FCCC
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 15:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w2OJ+mOGImrqQPknP79DwqcM1SlfvROPb49PtpOT3P0=; b=3CS2jTg2fuf2pQ4GNGwUVBysEa
        rutBna2lPkl6YFkqZ6QdrUTP3HQkF7HBdKGzd2W+lOBnMTMdMtwWrOJ2J1XxrkEEvRHoIRXIbLNkb
        9GaaFHl+jooPyWJ+h7v6lg05ekbJvaG/PdJbOFmijhpkLfXGrAsGLL1AJs/aO8PtvdZY6TpJ2AKlI
        M2Y//KTRDm6ZpJgKuq/oGXFmuCernWNqgYClkJgIyNxH97rKt0v03XvCmh64+9+t/j2yHxOvoRMn+
        lmyUmLI4BHco4bueR2Oy9j5yMnaGAIJ6MmiavO2SatJj7pGYNlNVXR0oxLu3yQj3wtBJm6H0G6euw
        DhAunisw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peOMG-00AiEe-2W;
        Mon, 20 Mar 2023 22:52:04 +0000
Date:   Mon, 20 Mar 2023 15:52:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
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
Message-ID: <ZBjjlLTxWIp9rY7J@bombadil.infradead.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-4-hare@suse.de>
 <ZAlOqMMKWhyIzmlN@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAlOqMMKWhyIzmlN@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 08, 2023 at 07:12:40PM -0800, Luis Chamberlain wrote:
> On Mon, Mar 06, 2023 at 01:01:25PM +0100, Hannes Reinecke wrote:
> > Add a module option 'rd_blksize' to allow the user to change
> > the sector size of the RAM disks.
> > 
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> > ---
> >  drivers/block/brd.c | 30 +++++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> > index fc41ea641dfb..11bac3c3f1b6 100644
> > --- a/drivers/block/brd.c
> > +++ b/drivers/block/brd.c
> > @@ -46,6 +46,8 @@ struct brd_device {
> >  	spinlock_t		brd_lock;
> >  	struct radix_tree_root	brd_folios;
> >  	u64			brd_nr_folios;
> > +	unsigned int		brd_sector_shift;
> > +	unsigned int		brd_sector_size;
> >  };
> 
> Why not just do this first and initialize this to the defaults set
> without the module parameter. Then you don't need to declare over
> and over unsigned int rd_sectors, etc in tons of routines and just
> pass the brd which most routines get.
> 
> Then most of this and the prior patch can be squeezed into one.
> 
> The functional changes would be the addition of the module parameter.
> 
> > @@ -410,7 +418,7 @@ static int brd_alloc(int i)
> >  	 *  otherwise fdisk will align on 1M. Regardless this call
> >  	 *  is harmless)
> >  	 */
> > -	blk_queue_physical_block_size(disk->queue, PAGE_SIZE);
> > +	blk_queue_physical_block_size(disk->queue, rd_blksize);
> 
> And this was added for DAX support, but DAX support was long removed
> from brd see commit 7a862fbbdec6 ("brd: remove dax support"). This
> nugget was added by Boaz via commit c8fa31730fc72a8 ("brd: Request from
> fdisk 4k alignment"), but if we don't support DAX, can't we just kill
> that line?
> 
> Current doc for blk_queue_physical_block_size() says:
> 
> *   This should be set to the lowest possible sector size that the             
> *   hardware can operate on without reverting to read-modify-write             
> *   operations.  
> 
> But since we're working directly with RAM, do we care?
> 
> The comment above that line referring to direct_access should be killed
> at the very least.

I was curious whether or not Martin's comments about "mkfs already
considers the reported queue limits (for the filesystems most people use,
anyway)" applies to say XFS [0] and whether or not the above helps guide
mkfs that way, so I took a look now.

[0] https://lore.kernel.org/all/yq1ttytbox9.fsf@ca-mkp.ca.oracle.com/

There's a default struct mkfs_default_params which sets the blocksize
to 1 << XFS_DFL_BLOCKSIZE_LOG and so at least validate_blocksize() will
use that if no parameter was passed on the cli. We also set the default
sector size to XFS_MIN_SECTORSIZE.

There are two aspects to what we use for the final mkfs, first we use
validate_blocksize(), then validate_sectorsize(). The first will set
the default block size to  1 << XFS_DFL_BLOCKSIZE_LOG (4096 bytes) if
the user did not specify anything. Then validate_sectorsize() uses
get_topology() to get the physical / logical block sizes and both:

  * blkid_topology_get_minimum_io_size()
  * blkid_topology_get_optimal_io_size()

These come from utilil-linux:

https://github.com/util-linux/util-linux.git

https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-block

So that's just

/sys/block/<disk>/queue/physical_block_size
/sys/block/<disk>/queue/logical_block_size

Then:

/sys/block/<disk>/queue/minimum_io_size

The documentation suggests " For disk drives this is often the physical block size."

/sys/block/<disk>/queue/optimal_io_size

The documentation suggests this is "This is rarely reported for disk drives."

From my review of xfs's mkfs is we essentially use the physical block
size as a default sector size if set, otherwise we use the device's logical block
size if set otherwise xfsprog's default and so 4096.

And so the above comment referring to DAX could be killed and replaced
with allowing userspace mkfs utils to use a more appropriate block size.
Or just kill the comment all together and we update the docs for
blk_queue_physical_block_size() instead.

> While you're at it, can you then also update Documentation/filesystems/dax.rst
> to remove the brd as an example driver with DAX support.
> 
> That leaves us with only a few block drivers with DAX:
> 
> - dcssblk: s390 dcss block device driver                                        
> - pmem: NVDIMM persistent memory driver  
> - some dm targets
> - fuse virtio_fs
> 
> Wonder which is the right example these days for DAX, now that
> persistant memory has End of Life'd with Optane dead, curious also of
> the value of the above and DAX in general other than support for
> whatever made it out.

Looking at this:

https://lore.kernel.org/all/62ef05515b085_1b3c29434@dwillia2-xfh.jf.intel.com.notmuch/

> Should we EOL DAX too?

I think the answer is no as a generic kernel thing, however, it probably
means we should really update the DAX documentation to reflect what our
real expecations are for its current and future uses. And that is to
highlight the non-PMEM use cases as *those* probably are EOL'd now.

  Luis
