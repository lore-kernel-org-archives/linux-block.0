Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510F42049C;
	Fri, 14 Aug 2026 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694098; cv=none; b=d2357y11NLjHAU4F1ubLz+2Kh+AfOZBUz79y3h598fJ7+uRXG0dsgi0s0uwjHw8lTiYn4Cv9nsea9/Ha3bb3JjLB5e+85njNJmXFT6gDp6eFLoQdTwqKHT/cW7JhsCF+IiqEN/ZcH8Y4LnYWZf6K5kBfFpDlsSfQ38CuAQL7LCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694098; c=relaxed/simple;
	bh=wop70r+nhC9TKgE7R7tCAxqnFhreUO/dQAKbmrHO9lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gEVwnvg34YnDeFB4rRNJCX7jbcxSj1FgPLZhvGiUJXUH455z3jVXIb3i/72bupbE7v1U2eFK2FMcsI/LgMofbY4U/cHo0gn9/I//1rm3TgxJTKsWWC7iusrNhPBgpY+TFUYBHLK/BesC9jh2Y2EK5oE2QYbf0DwUKLQ7JwMUi+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Q6VD96bX; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Q6VD96bX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nN3Xr4d2ouubrK5bbdRzjTkGu4rlKnCelNUWWTSgOaM=;
	b=Q6VD96bX72jHvH04euXsKof6ZOSmjaFemOTjo/mLI5/Crg120EIsmVShUZSqqlfII8jgeMfsN
	qarGpLhTXA/vMjgKxiTJEfhdoYFNBF6ETyPIsq25COAPYhuZ163Id7g64XuOKGMTOdJSDYcWsCO
	mL5DwBru7imlofFPSkA+oV4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hLvPc1bmsz12LG0;
	Fri, 14 Aug 2026 15:44:20 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BE8C20333;
	Fri, 14 Aug 2026 15:54:44 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 14 Aug 2026 15:54:43 +0800
Message-ID: <87f85f83-5514-429b-8dec-8ca4da39a3d6@huawei.com>
Date: Fri, 14 Aug 2026 15:54:42 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] nbd: is the add_socket queue freeze needed on the initial
 (pre-start) connect path?
To: Zhichao Huang <huangzhichao.1@bytedance.com>, <josef@toxicpanda.com>
CC: <hch@lst.de>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <CANUnaiYZNj2n40HitJFJnzg1GSFg-VXZJSGEEHL5E7YqL3EHhA@mail.gmail.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <CANUnaiYZNj2n40HitJFJnzg1GSFg-VXZJSGEEHL5E7YqL3EHhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Hi Zhichao,

Thanks for your attention to this issue. I have try fix this with this 
patchset. Please check does it solve your problem.

https://lore.kernel.org/all/20260805122930.57647-1-yangerkun@huawei.com/

Thanks,
Erkun.

在 2026/8/14 15:14, Zhichao Huang 写道:
> To: Josef Bacik <josef@toxicpanda.com>
> Cc: Christoph Hellwig <hch@lst.de>,
>      Jens Axboe <axboe@kernel.dk>,
>      Ming Lei <ming.lei@redhat.com>,
>      linux-block@vger.kernel.org,
>      linux-kernel@vger.kernel.org
> 
> Hi all,
> 
> This is a question / RFC, not a patch -- I'd like your opinion before
> proposing anything, because the code in question is a deliberate,
> stable-tagged UAF fix and I don't want to weaken it.
> 
> Background / motivation
> -----------------------
> We run large numbers of Firecracker microVMs whose block devices are
> backed by NBD. On the VM-create hot path each microVM does an initial
> NBD connect (netlink NBD_CMD_CONNECT), and we launch many of them
> concurrently on the same many-core host. Profiling the create path
> shows a large chunk of kernel time is spent in blk_mq_freeze_queue()
> during the connect: each freeze waits for a full RCU grace period, which
> on these many-core hosts we measure at roughly 35-50ms. Because several
> connects run concurrently, these grace-period waits stack up and become
> a visible tail-latency contributor on VM start.
> 
> One of the freezes on that path is in nbd_add_socket(), added by
> 
>    b98e762e3d71 ("nbd: freeze the queue while we're adding connections")
> 
> with the comment "We need to make sure we don't get any errant requests
> while we're reallocating the ->socks array." I understand this freeze
> fences the krealloc() of config->socks[] against a concurrent
> nbd_queue_rq() -> nbd_handle_cmd(), which dereferences
> config->socks[index] and config->num_connections -- i.e. it prevents a
> use-after-free / out-of-bounds read, and it was Cc: stable. I am *not*
> questioning that this is needed while the device is live.
> 
> Observation about the *initial* connect
> ----------------------------------------
> On the initial connect, before the device is started (nbd->pid == 0),
> nbd_add_socket() runs while:
> 
>    - capacity is still 0. set_capacity_and_notify() is only reached in
>      nbd_set_size() after the "if (!nbd->pid) return 0;" early return,
>      and on both the netlink and ioctl paths nbd_add_socket() runs
>      strictly before nbd_start_device() sets nbd->pid; and
> 
>    - the queue advertises no write cache / discard / write-zeroes yet
>      (those queue_limits features are also only set in the nbd->pid
>      branch of nbd_set_size()).
> 
> Walking submit_bio_noacct() with capacity == 0 and no features, every
> I/O op seems to be rejected before it can become a request that reaches
> nbd_handle_cmd():
> 
>    - READ/WRITE with sectors: bio_check_eod() -> -EIO (maxsector == 0);
>    - flush (REQ_PREFLUSH): !bdev_write_cache() path strips the flush and
>      completes a zero-sector bio with BLK_STS_OK without dispatch;
>    - DISCARD / WRITE_ZEROES / SECURE_ERASE / ZONE_*: not_supported since
>      the corresponding limits are 0 / not set;
>    - passthrough (DRV_IN/OUT): not_supported on the bio submit path, and
>      nbd issues none itself.
> 
> The only theoretical gap I can see is a zero-length, non-flush data bio
> (bio_check_eod() skips the check when nr_sectors == 0), but the VFS /
> direct-IO layers don't actually submit zero-length data bios.
> 
> The question
> ------------
> Given the above, is the nbd_add_socket() freeze effectively redundant on
> the *initial*, pre-start (!nbd->pid) connect, where no I/O can reach the
> driver? If so, would any of the following be acceptable, or is the
> freeze intentionally kept unconditional for robustness?
> 
>    1) Skip the freeze only when (!nbd->pid && get_capacity(disk) == 0),
>       falling back to the stock freeze otherwise (fail-shut);
>    2) Some cheaper barrier than a full-queue-freeze RCU grace period for
>       this "no I/O possible yet" case;
>    3) Leave it as-is -- the "no I/O reaches the driver" property relies on
>       a non-local invariant spanning bio_check_eod(), the flush filter,
>       the pre-start queue_limits, and the set_capacity() ordering, and you
>       consider that too fragile to build on.
> 
> My instinct is that (3) is a legitimate answer and that the invariant is
> fragile, which is exactly why I'm asking rather than sending a patch. If
> there's a direction you'd be willing to take, I'm happy to do the work
> and the testing.
> 
> Thanks,
> Zhichao Huang <huangzhichao.1@bytedance.com>
> 

