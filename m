Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:56756 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932205AbdAJEYs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Jan 2017 23:24:48 -0500
Date: Mon, 9 Jan 2017 23:24:42 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
Message-ID: <20170110042442.ixxxi4yhj5gu7byh@thunk.org>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
 <20170104165745.7uuwl6phm6g6kouu@thunk.org>
 <1b457b77-34d8-ab82-ae1d-279e86053af9@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1b457b77-34d8-ab82-ae1d-279e86053af9@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 10, 2017 at 10:42:45AM +0900, Damien Le Moal wrote:
> Thank you for the information. I will check this out. Is it the
> optimization that aggressively delay meta-data update by allowing
> reading of meta-data blocks directly from the journal (for blocks that
> are not yet updated in place) ?

Essentially, yes.  In some cases, the metadata might never be written
back to its permanent location in disk.  Instead, we might copy a
metadata block from the tail of the journal to the head, if there is
enough space.  So effectively, it turns the journal into a log
structured store for metadata blocks.  Over time, if metadata blocks
become cold we can evict them from the journal to make room for more
frequently updated metadata blocks (given the currently running
workload).  Eliminating the random 4k updates to the allocation
bitmaps, inode table blocks, etc., really helps with host-aware SMR
drives, without requiring the massive amount of changes needed to make
a file system compatible with the host-managed model.

When you consider that for most files, they are never updated in
place, but are usually just replaced, I suspect that with some
additional adjustments to a traditional file system's block allocator,
we can get even further wins.  But that's for future work...

> Emulators may indeed be very useful for development. But we could also
> go further and implement the different models using device mappers too.
> Doing so, the same device could be used with different FTL through the
> same DM interface. And this may also simplify the implementation of
> complex models using DM stacking (e.g. the host-aware model can be
> implemented on top of a host-managed model).

Yes, indeed.  That would also allow people to experiment with how much
benefit can be derived if we were to give additional side channel
information to STL / FTL's --- since it's much easier to adjust kernel
code than to go through a negotiations with a HDD/SSD vendor to make
firmware changes!

This may be an area where if we can create the right framework, and
fund some research work, we might be able to get some researchers and
their graduate students interested in doing some work in figuring out
what sort of divisions of responsibilities and hints back and forth
between the storage device and host have the most benefit.

Cheers,

						- Ted
