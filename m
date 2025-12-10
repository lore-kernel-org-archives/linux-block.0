Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8443200110
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765341218; cv=none; b=ej34m8hbiny6SGO0Kzkk0aa4M0lF1jVXK0yr0MT2pWUdrIOBnCc9ly7tteJTtaHnKaqdw88QKhZktb98sHf1slLkLBmPgvjNQfUjjzlMGgFscOcFg0vbBzc54w3s4b2Asint8RMPRsgtZ3wM+OkjagjQFZ1xXy+uippEpjj6e0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765341218; c=relaxed/simple;
	bh=+Wl3X+2l2Wo/m6IwOjzQles6rrYEuoN7MvF/3dVmJm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmR+KE71tZbeNFTLCttUQzE/FdTL+4sA9RPilI3igavCgmqNTiVb8qAnUKPazricbBmhijnFZ1J+Mw4TZc/x8aEw4UDjBmIEFQWw3dQxGLh+3EnzcFvbKJl5G7AX4DfBPBC3uMkqWv6Oeiqqa6YeHd8AReAs6b2ob8IE8N9snGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJmFxXtS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJmFxXtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E79EC4CEF1;
	Wed, 10 Dec 2025 04:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765341218;
	bh=+Wl3X+2l2Wo/m6IwOjzQles6rrYEuoN7MvF/3dVmJm8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cJmFxXtSKOInfK/wYGEMAGm9+5XqcuIbzdqvr+CduWZCOZftmKYnF3dgtvN743+xM
	 rcAhKRqSxvzDnzcnoxvjdiRNqGHI0Qhmuw89B7Noh2k/0aj4XZah59W+n66CD/1bhT
	 LJADGu6XhzZnwUrj/D0vBqc/Oj0q4IM413T5JkJTg24B5SXO+iuwRXNDpIKhUATOg+
	 4+5V99x0qANSSjD/cZFp8OceQctJkyTFQGpbZnIgAxeZWc496ryWPpqqUc1ZQWfCrC
	 2lMYt/IkK23hrwsVdnm/UBNzFG2gSMzajyTjZV+Kx5SwmI9QPVGDF7GWxfz+ncGprK
	 oIV2ONEfc05eQ==
Message-ID: <5f521c8d-5c26-4a4a-96a5-034906d7792f@kernel.org>
Date: Tue, 9 Dec 2025 20:33:37 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix cached zone reports on devices with native
 zone append
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
References: <20251210021037.10106-1-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251210021037.10106-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/12/09 18:10, Johannes Thumshirn wrote:
> When mounting a btrfs file system on virtio-blk which supports native
> Zone Append there has been a WARN triggering in btrfs' space management
> code.
> 
> Further looking into btrfs' zoned statistics uncovered the filesystem
> expecting the zones to be used, but the write pointers being 0:
>  # cat /sys/fs/btrfs/8eabd2e7-3294-4f9e-9b58-7e64135c8bf4/zoned_stats
>  active block-groups: 4
>          reclaimable: 0
>          unused: 0
>          need reclaim: false
>  data relocation block-group: 1342177280
>  active zones:
>          start: 1073741824, wp: 0 used: 0, reserved: 0, unusable: 0
>          start: 1342177280, wp: 0 used: 0, reserved: 0, unusable: 0
>          start: 1610612736, wp: 0 used: 16384, reserved: 0, unusable: 18446744073709535232
>          start: 1879048192, wp: 0 used: 131072, reserved: 0, unusable: 18446744073709420544
> 
> Looking at the blkzone report output for the zone in question
> (1610612736) the write pointer on the device moved, but the filesystem
> did not see a change on the write pointer:
>  # blkzone report -c 1 -o 0x300000 /dev/vda
>    start: 0x000300000, len 0x080000, cap 0x080000, wptr 0x000040 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
> 
> The zone write pointer is 0, because btrfs is using the cached version
> of blkdev_report_zones() and as virtio-blk is supporting native zone
> append, but blkdev_revalidate_zones() does not initialize the zone write
> plugs in this case.
> 
> Not skipping the revalidate of sequential zones in
> blkdev_revalidate_zones() callchain fixes this issue.

May be here, add: Adding zone write plugs for active zones is not an issue
because these plugs will be removed if the user issues a zone append command and
this same operation will also disable the cached report zones.

> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Maybe also add a fixes tag for completeness ?

Other than that, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
