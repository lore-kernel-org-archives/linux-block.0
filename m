Return-Path: <bo.li.liu@oracle.com>
Date: Wed, 30 Aug 2017 16:06:18 -0600
From: Liu Bo <bo.li.liu@oracle.com>
To: linux-block@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, axboe@kernel.dk
Subject: About btrfs on top of wb_throttle
Message-ID: <20170830220618.GC17166@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
Reply-To: bo.li.liu@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi,

While playing with btrfs on top of wb_throttle, an interesting thing
is that writeback from btrfs always falls into %rwb->wb_background
even if there're no other writers.

The peculiarity of btrfs is that, it owns the ability of mananging
disks so that it creates a private bdi stored in sb->s_bdi, which is
different from %queue->backing_device_info.

So running balance_dirty_pages() during btrfs's buffered writes
doesn't take any effect on %queue->backing_device_info->wb, thus it's
got into the wb_background bucket all the time.

Haven't measure the performance numbers with a real test, but in
theory this problem will let buffered writer spend more time in
balance_dirty_pages()'s for(;;) loop.

Chris, Jens, thoughts?

Thanks,

-liubo
