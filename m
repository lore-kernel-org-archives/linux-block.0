Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632948988A
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634550; cv=none; b=s0B/gDJ31TCp2w17z0ID2beHTpCZ0TDEIosSHNF8je85PCcMzrNp5hXm1fK3Qi+52G82sND8SedFEeVpn/ypmqS0RELh0pSPqgHxyOyHMf926YDznhhlyd3gisRzlYzg3HYFaqmQM2Cdh/2kY9NamSML2/rAjR+8E/ZscAY6AqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634550; c=relaxed/simple;
	bh=ITIC2ORuWtwGAwGgy6PmqjyuE8/xFtZXnbwKnzadr3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/HO74BJVCseSfUJKlHe2omJLnx76dyjI6Vmm6/DMfq1Cf5nbK9gLnLtbv4Pqtp2Nj5veE9VpFHbKzz/bF0YNN9cWu0PMcKPnOKZ5G8n6wZY8TuHmTNRLRi82lxPFzF+9DIpzIbX2fVkKJUwjhD5I2yR5oEBKAjLRqnF3qR3GX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2LE+6fF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2LE+6fF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9021F00A3D;
	Thu, 13 Aug 2026 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786634549;
	bh=Hy3Fv4aJ+ACbSi3m6G2lTLz84Opw4hWd/ZOYE3w9+OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a2LE+6fF2tvM+OC1gppdIbBHTqhLHb5EwyAWQVGoWk1TCkdrI5Xk3NLktAZSBkH04
	 bKZ8J/d0QDo8paKICRU/Ter3WODu1Nm3jKzn8UKVfOlOKTzJz8r1PWZvF+DIsVrUfM
	 G/X/j4ahLklaLfIop1mCNj05K9XVjH2er9kH1G39J3ujjypHE39zAar8wk6ifKx4wr
	 Z+kTPnb8G/NcojXL3V5ZlGETbfIw9lV65HmrRccFXmhjqJCJQzJO7DOawimkp21TtY
	 UHM6aC1ymGEpIeilKYXIKS6ZSQjnlgGSinyFrlcE+4f1oAHuFAEUNyk4wKTWnD45NP
	 2wkpoxLdySquA==
Date: Thu, 13 Aug 2026 17:22:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>,
	Kyungchan Koh <kkc6196@fb.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	syzbot+643a6dd130546afdf1fb@syzkaller.appspotmail.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] null_blk: serialize configfs attribute updates with
 device setup
Message-ID: <an3hMSr9MiQzDC-9@ryzen>
References: <20260813141456.1625857-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813141456.1625857-2-cassel@kernel.org>

On Thu, Aug 13, 2026 at 04:14:56PM +0200, Niklas Cassel wrote:
> The attribute store methods generated with NULLB_DEVICE_ATTR() refuse to
> change the configuration of a live device by testing
> NULLB_DEV_FL_CONFIGURED, but that flag is only set by
> nullb_device_power_store() after null_add_dev() has returned, and the
> store methods take no lock at all. configfs only serializes writes to
> the same open file (buffer->mutex), so a write to any attribute can run
> concurrently with null_add_dev() and change the device configuration
> while it is being used.
> 
> null_add_dev() reads the configuration several times, e.g. dev->zoned is
> read once to set up the queue limits and once to initialize the zone
> resources:
> 
>   CPU0: echo 1 > nullb0/power         CPU1: echo 1 > nullb0/zoned
>   nullb_device_power_store()
>     mutex_lock(&lock)
>     null_add_dev()
>       if (dev->zoned) -> false
>         /* no BLK_FEAT_ZONED */       nullb_device_zoned_store()
>                                         test_bit(FL_CONFIGURED) -> 0
>                                         dev->zoned = true
>       blk_mq_alloc_disk()
>         /* queue is not zoned */
>       if (nullb->dev->zoned) -> true
>         null_register_zoned_dev()
>           blk_revalidate_disk_zones()
> 
> blk_revalidate_disk_zones() is then called for a queue that does not
> have BLK_FEAT_ZONED set, which triggers its WARN_ON_ONCE() and fails the
> device setup with -EIO:
> 
>   WARNING: CPU: 2 PID: 322 at block/blk-zoned.c:2357 blk_revalidate_disk_zones+0x4c/0x560
> 
> Clearing dev->zoned in the same window is worse: the queue is created
> with BLK_FEAT_ZONED but the zone resources are never initialized, so
> add_disk() succeeds for a zoned disk that has no zones. And a store that
> lands after the last dev->zoned test leaves dev->zoned set while
> dev->zones is still NULL, which null_process_zoned_cmd() dereferences on
> the first write.
> 
> Fix this by taking the global lock, which nullb_device_power_store()
> already holds across null_add_dev() and null_del_dev(), around both the
> NULLB_DEV_FL_CONFIGURED test and the update of the device configuration.
> The submit_queues and poll_queues apply callbacks are now called with
> that lock held, so remove the locking they did themselves.
> 
> Since the store methods can run as soon as configfs_register_subsystem()
> returns, that is, before null_init() gets to mutex_init(&lock), also
> initialize the lock statically with DEFINE_MUTEX().
> 
> Fixes: 3bf2bd20734e ("nullb: add configfs interface")
> Reported-by: syzbot+643a6dd130546afdf1fb@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-block/6a7d0b3f.ac361c09.22ff0a.004c.GAE@google.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Patch was verified using reproducer:

$ while :; do echo 1 > /sys/kernel/config/nullb/nullb0/power; echo 0 > /sys/kernel/config/nullb/nullb0/power; done &
$ while :; do echo 1 > /sys/kernel/config/nullb/nullb0/zoned; echo 0 > /sys/kernel/config/nullb/nullb0/zoned; done &


With the fix patch in $subject:
No WARNING after 1 minute of running.

Without the fix patch in $subject:
[ 1120.067545] WARNING: block/blk-zoned.c:2357 at blk_revalidate_disk_zones+0x274/0x2b0 
within 1 second of running.


Kind regards,
Niklas
