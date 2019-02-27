Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FE2C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 03:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFAD218D0
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 03:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfB0Dlm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 22:41:42 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:43142 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729128AbfB0Dlm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 22:41:42 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 27 Feb 2019 14:11:37 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gyq69-0007LM-7I; Wed, 27 Feb 2019 14:41:33 +1100
Date:   Wed, 27 Feb 2019 14:41:33 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Christopher Lameter <cl@linux.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] xfs: allocate sector sized IO buffer via page_frag_alloc
Message-ID: <20190227034133.GL23020@dastard>
References: <20190225043648.GE23020@dastard>
 <5ad2ef83-8b3a-0a15-d72e-72652b807aad@suse.cz>
 <20190225202630.GG23020@dastard>
 <20190226022249.GA17747@ming.t460p>
 <20190226030214.GI23020@dastard>
 <20190226032737.GA11592@bombadil.infradead.org>
 <20190226045826.GJ23020@dastard>
 <20190226093302.GA24879@ming.t460p>
 <20190226204550.GK23020@dastard>
 <20190227015054.GC16802@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227015054.GC16802@ming.t460p>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 27, 2019 at 09:50:55AM +0800, Ming Lei wrote:
> On Wed, Feb 27, 2019 at 07:45:50AM +1100, Dave Chinner wrote:
> > On Tue, Feb 26, 2019 at 05:33:04PM +0800, Ming Lei wrote:
> > > On Tue, Feb 26, 2019 at 03:58:26PM +1100, Dave Chinner wrote:
> > > > On Mon, Feb 25, 2019 at 07:27:37PM -0800, Matthew Wilcox wrote:
> > > > > On Tue, Feb 26, 2019 at 02:02:14PM +1100, Dave Chinner wrote:
> > > > > > > Or what is the exact size of sub-page IO in xfs most of time? For
> > > > > > 
> > > > > > Determined by mkfs parameters. Any power of 2 between 512 bytes and
> > > > > > 64kB needs to be supported. e.g:
> > > > > > 
> > > > > > # mkfs.xfs -s size=512 -b size=1k -i size=2k -n size=8k ....
> > > > > > 
> > > > > > will have metadata that is sector sized (512 bytes), filesystem
> > > > > > block sized (1k), directory block sized (8k) and inode cluster sized
> > > > > > (32k), and will use all of them in large quantities.
> > > > > 
> > > > > If XFS is going to use each of these in large quantities, then it doesn't
> > > > > seem unreasonable for XFS to create a slab for each type of metadata?
> > > > 
> > > > 
> > > > Well, that is the question, isn't it? How many other filesystems
> > > > will want to make similar "don't use entire pages just for 4k of
> > > > metadata" optimisations as 64k page size machines become more
> > > > common? There are others that have the same "use slab for sector
> > > > aligned IO" which will fall foul of the same problem that has been
> > > > reported for XFS....
> > > > 
> > > > If nobody else cares/wants it, then it can be XFS only. But it's
> > > > only fair we address the "will it be useful to others" question
> > > > first.....
> > > 
> > > This kind of slab cache should have been global, just like interface of
> > > kmalloc(size).
> > > 
> > > However, the alignment requirement depends on block device's block size,
> > > then it becomes hard to implement as genera interface, for example:
> > > 
> > > 	block size: 512, 1024, 2048, 4096
> > > 	slab size: 512*N, 0 < N < PAGE_SIZE/512
> > > 
> > > For 4k page size, 28(7*4) slabs need to be created, and 64k page size
> > > needs to create 127*4 slabs.
> > 
> > IDGI. Where's the 7/127 come from?
> > 
> > We only require sector alignment at most, so as long as each slab
> > object is aligned to it's size, we only need one slab for each block
> > size.
> 
> Each slab has fixed size, I remembered that you mentioned that the meta
> data size can be 512 * N (1 <= N <= PAGE_SIZE / 512).
> 
> https://marc.info/?l=linux-fsdevel&m=155115014513355&w=2

nggggh. 

*That* *is* *not* *what* *I* *said*.

That is *what you said* and I said that was wrong and the actual
sizes needed were:

dgc> It is not. On a 64k page size machine, we use sub page slabs for
dgc> metadata blocks of 2^N bytes where 9 <= N <= 15..

Please do the maths. I shoul dnot have to do it for you.

Also, please don't confusing sector-in-LBA alignment with /memory
buffer/ alignment. i.e. you're assuming that these 2kB IOs at
different sector offsets like the following:

 0	0.5	1.0	1.5	2.0	2.5	3.0	3.5	4.0
 +-------+-------+-------+-------+-------+-------+-------+-------+
 +ooooooooooooooooooooooooooooooo+
	 +ooooooooooooooooooooooooooooooo+
		 +ooooooooooooooooooooooooooooooo+
			 +ooooooooooooooooooooooooooooooo+
				 +ooooooooooooooooooooooooooooooo+

require a memory buffer alignment that matches the sector-in-LBA
alignment. This is wrong - the memory alignment constraint is
usually a hardware DMA engine limitation and has nothing to do with
the LBA the IO will place/retreive the data in/from.

i.e. An aligned 2kB slab will only allocate 2kB slab objects like so:

 0	0.5	1.0	1.5	2.0	2.5	3.0	3.5	4.0
 +-------+-------+-------+-------+-------+-------+-------+-------+
 +ooooooooooooooooooooooooooooooo+
				 +ooooooooooooooooooooooooooooooo+

and these memory buffers will always have 512 byte alignment. This
meets the memory alignemnt requirements of all hardware (which is
512 byte alignment or smaller), and so we only need one slab per
size.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
