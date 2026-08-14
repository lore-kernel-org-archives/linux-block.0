Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7653546C2
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 05:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685128; cv=none; b=auD8JVkwJZjlfpAdIX6CRdidcF5w+nXDIqa+lChA+CoWyU/2BtrwKr2l2E1UjOHOcDmEUA1vSto4VnOE5teaZ5iMHZn1KOLl4rHcMq6QZ+pETYnvZN6s6X8sOnImhGrm2yirXAoaoeYQmjDx4SV9hdC6JhsDs/pTV5XZRDPsaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685128; c=relaxed/simple;
	bh=xtoy4EdrNz3JZzs6kCS08jClgU+LpWELS9voN6FYj/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hm5J+HFUTRr0yuZF+OtdBgZ7i7X5D1GiTmUbJ8s+IR7oxCmWS73NlcUmOZ0CKowsOGuTzYOG2g5gS1mN8gAyifxFMuBjGwIjblR5kk85hF0XfwlRTCB2Vz97vaN5hM3aFlghb6+7kjKFeVeO2ejB34tSSl2qEhSS9c2y0doPHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5+zsUwy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5+zsUwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7631F00A3A;
	Fri, 14 Aug 2026 05:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786685127;
	bh=wZvvV0dBG4E+eN4h03lONwGmmS2XOLtIqa0I7T9iuig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O5+zsUwyf6jMKcNtYtEeDoHdlsemHDQ7kHCunZxRJqtH+3X7PXoPXvy1U+RWMgCXt
	 bQXJRoVvMfPAahlNVlWI4h/Og8h7kJST6xdcudP5L4ruVQBM0tzid8rkrPNr7LpAG6
	 pBnttNxWFN/tXaw3v8q5QBVlTYUJtH8ODGknA44IUB174oj7PTlL/FvP17SciXjzSw
	 yaWeqe10ihtOpaeRgHiu5ZNuqb7IPiPLbKrjACz69WRHhgW5wLrlEc6n1lziJL70hZ
	 LCgpfwFnurKN8iYZWkR+S5VhI50LTdYA9FMrxZMBWh0D8bmkR0RowPBvTb9dl/38ZL
	 TWavENP9Et7ng==
Message-ID: <44c18098-a4ca-4c72-863e-9109251e965c@kernel.org>
Date: Fri, 14 Aug 2026 14:25:24 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: serialize configfs attribute updates with
 device setup
To: Niklas Cassel <cassel@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Shaohua Li <shli@fb.com>, Kyungchan Koh <kkc6196@fb.com>
Cc: syzbot+643a6dd130546afdf1fb@syzkaller.appspotmail.com,
 linux-block@vger.kernel.org
References: <20260813141456.1625857-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260813141456.1625857-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 23:14, Niklas Cassel wrote:
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

Looks good to me. Thanks for fixing this. I had started looking into it, but you
were faster :)

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
