Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36776 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbcD0SBK (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 27 Apr 2016 14:01:10 -0400
Date: Wed, 27 Apr 2016 20:01:05 +0200
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, jack@suse.cz, dchinner@redhat.com,
	sedat.dilek@gmail.com
Subject: Re: [PATCHSET v5] Make background writeback great again for the
 first time
Message-ID: <20160427180105.GA17362@quack2.suse.cz>
References: <1461686131-22999-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461686131-22999-1-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

On Tue 26-04-16 09:55:23, Jens Axboe wrote:
> Since the dawn of time, our background buffered writeback has sucked.
> When we do background buffered writeback, it should have little impact
> on foreground activity. That's the definition of background activity...
> But for as long as I can remember, heavy buffered writers have not
> behaved like that. For instance, if I do something like this:
> 
> $ dd if=/dev/zero of=foo bs=1M count=10k
> 
> on my laptop, and then try and start chrome, it basically won't start
> before the buffered writeback is done. Or, for server oriented
> workloads, where installation of a big RPM (or similar) adversely
> impacts database reads or sync writes. When that happens, I get people
> yelling at me.
> 
> I have posted plenty of results previously, I'll keep it shorter
> this time. Here's a run on my laptop, using read-to-pipe-async for
> reading a 5g file, and rewriting it. You can find this test program
> in the fio git repo.

I have tested your patchset on my test system. Generally I have observed
noticeable drop in average throughput for heavy background writes without
any other disk activity and also somewhat increased variance in the
runtimes. It is most visible on this simple testcases:

dd if=/dev/zero of=/mnt/file bs=1M count=10000

and

dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync

The machine has 4GB of ram, /mnt is an ext3 filesystem that is freshly
created before each dd run on a dedicated disk.

Without your patches I get pretty stable dd runtimes for both cases:

dd if=/dev/zero of=/mnt/file bs=1M count=10000
Runtimes: 87.9611 87.3279 87.2554

dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
Runtimes: 93.3502 93.2086 93.541

With your patches the numbers look like:

dd if=/dev/zero of=/mnt/file bs=1M count=10000
Runtimes: 108.183, 97.184, 99.9587

dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
Runtimes: 104.9, 102.775, 102.892

I have checked whether the variance is due to some interaction with CFQ
which is used for the disk. When I switched the disk to deadline, I still
get some variance although, the throughput is still ~10% lower:

dd if=/dev/zero of=/mnt/file bs=1M count=10000
Runtimes: 100.417 100.643 100.866

dd if=/dev/zero of=/mnt/file bs=1M count=10000 conv=fsync
Runtimes: 104.208 106.341 105.483

The disk is rotational SATA drive with writeback cache, queue depth of the
disk reported in /sys/block/sdb/device/queue_depth is 1.

So I think we still need some tweaking on the low end of the storage
spectrum so that we don't lose 10% of throughput for simple cases like
this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
