Return-Path: <axboe@kernel.dk>
Subject: Re: About btrfs on top of wb_throttle
To: bo.li.liu@oracle.com, linux-block@vger.kernel.org
Cc: Chris Mason <clm@fb.com>
References: <20170830220618.GC17166@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6319b2f5-7eca-5746-e4b0-88f9a45bf311@kernel.dk>
Date: Fri, 8 Sep 2017 15:41:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170830220618.GC17166@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/30/2017 04:06 PM, Liu Bo wrote:
> Hi,
> 
> While playing with btrfs on top of wb_throttle, an interesting thing
> is that writeback from btrfs always falls into %rwb->wb_background
> even if there're no other writers.
> 
> The peculiarity of btrfs is that, it owns the ability of mananging
> disks so that it creates a private bdi stored in sb->s_bdi, which is
> different from %queue->backing_device_info.
> 
> So running balance_dirty_pages() during btrfs's buffered writes
> doesn't take any effect on %queue->backing_device_info->wb, thus it's
> got into the wb_background bucket all the time.
> 
> Haven't measure the performance numbers with a real test, but in
> theory this problem will let buffered writer spend more time in
> balance_dirty_pages()'s for(;;) loop.
> 
> Chris, Jens, thoughts?

Sorry for the late reply here... So the issue is that wbt ends up
looking at the lower level device bdi->wb, and balance_dirty_pages()
sets ->dirty_sleep on the bdi that btrfs has created for the volume.
This is pretty much the opposite situation of how we currently
handle bdi congestion, where users (like btrfs) can provide a
congested_fn() that iterates the lower level backing devices.

I think the best fix here is to provide some way for the stacking of
bdi's to be resolvable by the kernel. Either that, or the
balance_dirty_pages() should not just set wb->dirty_sleep, but rather
call into a bdi provided function that sets the dirty_sleep on all the
lower level bdi's. If we do the latter, the problem is similar to
congested_fn(), in that we have the file system provided bdi and ask the
fs to iterate constituent devices and set ->dirty_sleep. The former
might be more difficult, since each lower level bdi could be a member of
multiple top level bdi's.

-- 
Jens Axboe
