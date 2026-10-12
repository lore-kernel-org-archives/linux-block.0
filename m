Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4484078D5;
	Mon, 12 Oct 2026 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804443; cv=none; b=sS7rx8se40q++RGTYKlkXzepIFq1oyXA4wSvOz69Z7nKYxRgt6XvktnpKsiMMaBfOZLIRGWq5sZ2lx3UP+ax8cxzlV18bP+IxzAB2Qqkd6M5Lsr52aCao+jE4mw9xAiBeqzTPXxwi2arhzU84WNaF+pnLelHnD6swJEOnf57GOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804443; c=relaxed/simple;
	bh=/JIURhd9YMmzn3GzKI0XMXzFFBEwgyz3oUZb4g6UmRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+pBoyCc8Dj1CWjA5saAynVRUeK56XjBGOD19O0M3IiXDPI419mbVu11Ihgh/s/oFz2hsFS7goooIE4Kfy1ULO6wcpCKijVwfSKlZwDMKcjIbhMrh6FtQ1+zhlhAedtoSfGpC+TEYZchL5YfuhACI6uQd6yLPCkph8YSsf1Vq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7kfObIT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7kfObIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC141F0089B;
	Mon, 12 Oct 2026 11:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791804442;
	bh=L9HarjrKcQnuPjWv2Zi+Iwza/WW3+HAhH18kCrHz8vI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=n7kfObITmzVsbaxHyjUADrz3A6u5PFfC6aX4kEH8kks0qtyrBDqUx4lxku6Gz61NH
	 0attlfnBDkLp3/H3kwVxpDzQrcr2E8+XwPebyaTJ1O/bd6NkWQ5Wwzo0h++QMYVu6q
	 iZ6bJ4E+yK6wlUH1U7SNL2otsw9BC0VJusxHVK7A7DdAxLOt2xckL3zAkWdA/nrTHS
	 wicVs3xKED5WnWIDcSQVnpZr3WJL+faAH2Met25DQq+hQ5PuwPxghYM6KITGD90E/m
	 U9hng1gOlloX2FF5tRong4JnXmP75qSrzjBx57914kEfRi7DFNSXVlDqYTJ+kduQgj
	 SmyPy6U/Ip63Q==
Message-ID: <87b3cf42-ae12-40dc-9d84-4bb8b7acac83@kernel.org>
Date: Mon, 12 Oct 2026 13:27:18 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: only use the cached zone report if
 BLK_ZONE_REP_CACHED is set
To: Shashank Mohan Jain <jain.sm@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261011154018.48913-1-jain.sm@gmail.com>
 <20261011154018.48913-2-jain.sm@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261011154018.48913-2-jain.sm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/11 17:40, Shashank Mohan Jain wrote:
> BLKREPORTZONEV2 takes the flags field of struct blk_zone_report as an
> input. With BLK_ZONE_REP_CACHED the report is built from the zone
> information cached by the block layer. Without it, BLKREPORTZONEV2 is
> documented to behave like BLKREPORTZONE and to get the report from the
> device: this is what the changelog of the commit that added the ioctl
> and the comments in include/uapi/linux/blkzoned.h say.
> 
> blkdev_report_zones_ioctl() only uses the flag to validate the input
> and calls blkdev_report_zones_cached() for every BLKREPORTZONEV2
> request. A caller that passes flags == 0 gets the cached report, in
> which implicitly open, explicitly open and closed zones all have the
> condition BLK_ZONE_COND_ACTIVE, and an explicitly opened empty zone is
> reported as empty.
> 
> Example with a zoned null_blk device (10 MiB, 4 MiB zones) after
> BLKOPENZONE on zone 0, and a write of 8 sectors to zone 1 followed by
> BLKCLOSEZONE:
> 
>   BLKREPORTZONE:             zone 0 cond 0x3 (EXP_OPEN)
>                              zone 1 cond 0x4 (CLOSED)
>   BLKREPORTZONEV2, flags 0:  zone 0 cond 0x1 (EMPTY)
>                              zone 1 cond 0xff (ACTIVE)
> 
> The uapi header marks BLKREPORTZONE as deprecated in favour of
> BLKREPORTZONEV2. A program that follows this and does not ask for
> cached information can no longer tell open zones from closed ones, and
> is handed BLK_ZONE_COND_ACTIVE, which is only defined for the cached
> report.
> 
> Use the cached report only when BLK_ZONE_REP_CACHED is set and the
> device has a cached report; otherwise, and whenever the flag is not
> set, get the report from the device with blkdev_report_zones(). Guard
> the cached path with blkdev_has_cached_report_zones() so the redundant
> call is avoided when there is no cached report: in that case
> blkdev_report_zones_cached() already falls back to a device report, so
> the observable behaviour is unchanged. blkdev_has_cached_report_zones()
> is defined lower in the file, so move it, with its comment, above
> blkdev_report_zones_ioctl().
> 
> Tested with zoned null_blk devices in qemu: a program that compares
> the reports of BLKREPORTZONE and BLKREPORTZONEV2 with flags 0 after
> the sequence above finds the differences before this change and none
> with it. The report with BLK_ZONE_REP_CACHED is unchanged.
> 
> Fixes: b30ffcdc0c15 ("block: introduce BLKREPORTZONESV2 ioctl")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
