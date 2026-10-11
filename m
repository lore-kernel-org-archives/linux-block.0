Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D80390600;
	Sun, 11 Oct 2026 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791729981; cv=none; b=UySlXBVzG61T6iyM6GJCEJBEJh/IH2O8MpV8xD+mXl0B/I3pNkfPO+sM1Jb2FMR1IxvkDbKK9mSyOllAEeREd90aCEEPYJx5PDu+70D5qLkpr2TO2rjyfVASlNg/GPwyybIpGfgYRhiMeP3SIlb1SXhzwJxX33ig/J8OStGSP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791729981; c=relaxed/simple;
	bh=fyocAXO7Xsf5Sy3fD//8BuOiTzegYpqX4ZZ/0j4J71w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCCAq2RMDwPPcuvT0kb4Ydo7weh9WQaefNiUFFnO/q8s5C4tix2JvGPHgcd+EuBghtSo+yZ2wVWmRPqTIeCW22HTDuJvJti9xsKXkUkoFw/QdBFZOUdNvmgHgUSa47y/pxAtB6nk47hj0uhz2ke6PK/0ls8Ai1jqxbyY6ugk4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/Fz1a/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/Fz1a/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B281F0089B;
	Sun, 11 Oct 2026 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791729979;
	bh=a8Wq7xaJ9QHjtkQKXx8Mftm0gxTB/vSerG9iKyW/5no=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a/Fz1a/hRmosoQNBGgjBEsicc19lP+o6pFwRH/IOtEyOtvYFnDh63aH1GN94nDfrd
	 0rAwHamoL/vdJ2y61h9/zaKytQjExxLYpqlQ0dWeNkH8Cxp+TDoHrGJh2A2jLG9nqI
	 oL5tszm9c9VfWkcbIs+GSRhxMpNdIsMCbT5wrVa+uLWB4dQ6XoxDz97lxKkiZfyI4t
	 KVDBQaSDwxWEMpNqbzFD8LLWRkPN6ZuteqIulaf1bSo+N3skpNtNTsQ096+HEd8jOP
	 A0jQD8DBWeZy419Rk0OmxH2F0Qa/kmpv9DNw2CMXF7IoF3p9AilBpbdoMC04QtwbwQ
	 DiGGlVvIFYBug==
Message-ID: <e146448b-5210-4215-821f-181c91625141@kernel.org>
Date: Sun, 11 Oct 2026 16:46:15 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: only use the cached zone report if
 BLK_ZONE_REP_CACHED is set
To: Shashank Mohan Jain <jain.sm@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261011051906.60397-1-jain.sm@gmail.com>
 <20261011051906.60397-2-jain.sm@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261011051906.60397-2-jain.sm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/11 7:19, Shashank Mohan Jain wrote:
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
> Call blkdev_report_zones_cached() only if BLK_ZONE_REP_CACHED is set,
> and blkdev_report_zones() otherwise.
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
> ---
> Prepared with Claude Code (Anthropic), model Claude Opus 5.5
> (claude-opus-5-5).
> 
>  block/blk-zoned.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 475aa16bc4..9555eae91a 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -400,6 +400,13 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
>  	case BLKREPORTZONEV2:
>  		if (rep.flags & ~BLK_ZONE_REPV2_INPUT_FLAGS)
>  			return -EINVAL;
> +		if (!(rep.flags & BLK_ZONE_REP_CACHED)) {
> +			ret = blkdev_report_zones(bdev, rep.sector,
> +						  rep.nr_zones,
> +						  blkdev_copy_zone_to_user,
> +						  &args);
> +			break;
> +		}
>  		ret = blkdev_report_zones_cached(bdev, rep.sector, rep.nr_zones,
>  					 blkdev_copy_zone_to_user, &args);

Can you reverse this if to be "if (rep.flags & BLK_ZONE_REP_CACHED) {" and to
call blkdev_report_zones_cached if the condition is true? That would be a lot
more logical.

Also, the condition should probably be:

	if ((rep.flags & BLK_ZONE_REP_CACHED) &&
	    blkdev_has_cached_report_zones(bdev))

to be more efficient and avoid a call to blkdev_report_zones_cached() which will
turn into a regular device report zones.


-- 
Damien Le Moal
Western Digital Research
