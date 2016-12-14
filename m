Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55527 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932170AbcLNLNy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2016 06:13:54 -0500
Date: Wed, 14 Dec 2016 12:13:51 +0100
From: Jan Kara <jack@suse.cz>
To: Jerome Glisse <jglisse@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
        linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Un-addressable device memory and
 block/fs implications
Message-ID: <20161214111351.GC18624@quack2.suse.cz>
References: <20161213181511.GB2305@redhat.com>
 <20161213201515.GB4326@dastard>
 <20161213203112.GE2305@redhat.com>
 <20161213211041.GC4326@dastard>
 <20161213212433.GF2305@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161213212433.GF2305@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue 13-12-16 16:24:33, Jerome Glisse wrote:
> On Wed, Dec 14, 2016 at 08:10:41AM +1100, Dave Chinner wrote:
> > On Tue, Dec 13, 2016 at 03:31:13PM -0500, Jerome Glisse wrote:
> > > On Wed, Dec 14, 2016 at 07:15:15AM +1100, Dave Chinner wrote:
> > > > On Tue, Dec 13, 2016 at 01:15:11PM -0500, Jerome Glisse wrote:
> > > > > I would like to discuss un-addressable device memory in the context of
> > > > > filesystem and block device. Specificaly how to handle write-back, read,
> > > > > ... when a filesystem page is migrated to device memory that CPU can not
> > > > > access.
> > > > 
> > > > You mean pmem that is DAX-capable that suddenly, without warning,
> > > > becomes non-DAX capable?
> > > > 
> > > > If you are not talking about pmem and DAX, then exactly what does
> > > > "when a filesystem page is migrated to device memory that CPU can
> > > > not access" mean? What "filesystem page" are we talking about that
> > > > can get migrated from main RAM to something the CPU can't access?
> > > 
> > > I am talking about GPU, FPGA, ... any PCIE device that have fast on
> > > board memory that can not be expose transparently to the CPU. I am
> > > reusing ZONE_DEVICE for this, you can see HMM patchset on linux-mm
> > > https://lwn.net/Articles/706856/
> > 
> > So ZONE_DEVICE memory that is a DMA target but not CPU addressable?
> 
> Well not only target, it can be source too. But the device can read
> and write any system memory and dma to/from that memory to its on
> board memory.
> 
> > 
> > > So in my case i am only considering non DAX/PMEM filesystem ie any
> > > "regular" filesystem back by a "regular" block device. I want to be
> > > able to migrate mmaped area of such filesystem to device memory while
> > > the device is actively using that memory.
> > 
> > "migrate mmapped area of such filesystem" means what, exactly?
> 
> fd = open("/path/to/some/file")
> ptr = mmap(fd, ...);
> gpu_compute_something(ptr);
> 
> > 
> > Are you talking about file data contents that have been copied into
> > the page cache and mmapped into a user process address space?
> > IOWs, migrating ZONE_NORMAL page cache page content and state
> > to a new ZONE_DEVICE page, and then migrating back again somehow?
> 
> Take any existing application that mmap a file and allow to migrate
> chunk of that mmaped file to device memory without the application
> even knowing about it. So nothing special in respect to that mmaped
> file. It is a regular file on your filesystem.

OK, so I share most of Dave's concerns about this. But let's talk about
what we can do and what you need and we may find something usable. First
let me understand what is doable / what are the costs on your side.

So we have a page cache page that you'd like to migrate to the device.
Fine. You are willing to sacrifice direct IO - even better. We can fall
back to buffered IO in that case (well, except for XFS which does not do it
but that's a minor detail). One thing I'm not sure about: When a page is
migrated to the device, is its contents available and is just possibly stale
or will something bad happen if we try to access (or even modify) page data?

And by migration you really mean page migration? Be aware that migration of
pagecache pages may be a problem for some pages of some filesystems on its
own - e. g. page migration may fail because there is a filesystem transaction
outstanding modifying that page. For userspace these will be really hard
to understand sporadic errors because it's really filesystem internal
thing. So far page migration was widely used only for free space
defragmentation and for that purpose if page is not migratable for a minute
who cares.

So won't it be easier to leave the pagecache page where it is and *copy* it
to the device? Can the device notify us *before* it is going to modify a
page, not just after it has modified it? Possibly if we just give it the
page read-only and it will have to ask CPU to get write permission? If yes,
then I belive this could work and even fs support should be doable.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
