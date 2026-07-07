Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18D70836;
	Tue,  7 Jul 2026 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783397884; cv=none; b=iz1V46cyudpVAeLxIHByhGVs9DzvhWxxl/HsmUKu4RXila3Q1bXJEXBDc0kS6qWInTzHg/AVZVtKbQGHeDIRMbfcOaZBy85tnbHbd9Sa+kfTWM+UAO+J0smv4l+cYmEUS2OdB1kvqqkZzovTK9My17/b52gWCHnHN1LG/RTMlvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783397884; c=relaxed/simple;
	bh=QF8mVjX8IIrE/53BB1Ev0Shy7PrSJ7cJTRxaJKnhcbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMNDySVoOO5O3seRQXyT6gn8OfqTDPEX2zS6ml+7Ty0jnkNYPznsA3mWaSgfuzjzf5/aJh0y6Q42TRTy/SRaHNzu/zVs5D47mbww3WjY9mEz8CYetHwRpMx9AdQKUih86RUOnrcfqvLJD213OI/hBS7ybUi9Y2ff/Z/1zzjypEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJt3gv+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJt3gv+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6541F000E9;
	Tue,  7 Jul 2026 04:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783397883;
	bh=SNRxr4zQ6HOifpngaa6brHBRqw26BzuaHAbkvSeDAeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cJt3gv+MyYvh9dBwqNiO6L+gHRpGI15cHu3O/3s1HirJgkjB7664f/dBL1NHNXRv7
	 faOZTO4RlKSfO1QON0TaqfEO8lkjZGRmzwwSfxhnnHlPzpeT5alYVaH0lU3QajH7fO
	 hElcjsaIzJZZGKbwCsWZA/oRDwzOoG7iFDxqk2qVRXbNJ3mcbHVK/Ub8krYXfs4ZQO
	 9s8ynO32mOpkscjYBmciUy8ITYlOS21oOBJJpQssGQnULRtgpRuy2W+n9uVVixYBzA
	 ahE4bzaSVGQfkqHUN+vPdSAWYakZN1H8ktjdW5E7ZiARnYwXb+o89mSSV9SPoYgdeO
	 v5leB388HOdWQ==
Message-ID: <ca15dc52-d2ee-4fef-8c3d-6b8425e7afb7@kernel.org>
Date: Tue, 7 Jul 2026 13:18:00 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/6] null_blk: register configfs subsystem after
 creating default devices
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 linux-block@vger.kernel.org, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-4-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260707025542.1299859-4-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 11:55, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> In null_init(), configfs_register_subsystem() currently runs before
> register_blkdev(), so when null_blk is built as a module, a racing mkdir()
> + poweron from userspace can reach null_add_dev() while null_major is still
> 0. __add_disk() then hits WARN_ON(disk->minors) (major=0 with minors!=0)
> and fails:
> 
> [root@fedora ~]# [ 2366.521436] WARNING: block/genhd.c:476 at __add_disk+0x8a7/0xde0,
> [ 2366.523552] Modules linked in: null_blk(+) nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
> [ 2366.529081] CPU: 26 UID: 0 PID: 1600 Comm: sh Not tainted 7.2.0-rc1+ #66 PREEMPT(full)
> ......
> [ 2366.547251] Call Trace:
> [ 2366.547575]  <TASK>
> [ 2366.547831]  ? _raw_spin_lock+0x84/0xe0
> [ 2366.548260]  add_disk_fwnode+0x114/0x560
> [ 2366.548739]  null_add_dev+0x102d/0x1b80 [null_blk]
> [ 2366.549310]  ? __pfx_null_add_dev+0x10/0x10 [null_blk]
> [ 2366.549906]  ? mutex_lock+0xde/0x1c0
> [ 2366.550361]  ? __pfx_mutex_lock+0x10/0x10
> [ 2366.550827]  nullb_device_power_store+0x1e7/0x280 [null_blk]
> [ 2366.551499]  ? __pfx_nullb_device_power_store+0x10/0x10 [null_blk]
> [ 2366.552177]  ? __kmalloc_cache_noprof+0x1f5/0x470
> [ 2366.552748]  ? configfs_write_iter+0x35c/0x4e0
> [ 2366.553242]  configfs_write_iter+0x286/0x4e0
> [ 2366.553787]  vfs_write+0x52d/0xd00
> [ 2366.554169]  ? __pfx_vfs_write+0x10/0x10
> [ 2366.554679]  ? __pfx___css_rstat_updated+0x10/0x10
> [ 2366.555196]  ? fdget_pos+0x1cf/0x4c0
> [ 2366.555649]  ksys_write+0xfc/0x1d0
> ......
> 
> Additionally, the err_dev path destroys all devices on nullb_list while
> configfs is still registered. If a racing mkdir() + poweron puts a user
> device on the list, null_destroy_dev()->null_free_dev() kfrees the user
> device's nullb_device but /sys/kernel/config/nullb/<name> is still
> reachable. Any userspace access to the item will trigger a UAF.
> 
> For simplicity, move configfs_register_subsystem() to the end to solve
> the problems above. This also mirrors null_exit().
> 
> Fixes: 3bf2bd20734e ("nullb: add configfs interface")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
