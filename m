Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630EB22173D;
	Sun, 11 Oct 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791730048; cv=none; b=h6vcAoszfoQckD/sodz+AglTBHMn8Ley8vdvhMnV0ggL7eOiPEEXs84W2nEuiRS05xtqWL4fyV9olkEul4pxF7G8UYwZLgcYUxMCfhznqzcbGGAjBw8d3k32XuhQqw2h2HpjkzZmWtFGXyZnjm9aBMQr89HOQtM+UNmVSzBQwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791730048; c=relaxed/simple;
	bh=hurh2VWq85iUm4YSd057rwam7uoSEd34z8apnlv5u/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqbEiIbGXsC9Nbxk4y/eW4ra8J6glL6PGL+Rb3CgXTWzkvdCVt/iAWKGUgj7XZzXkVWBEd6mEGH04qWmva7TsMOaZbKv/eb7S8NuPR3WffwCrztoIg3326ZdoieID2CmMIXrWbcp88gkDbLqpfxhxh8UuSBBLKDeNzs7wPPmgII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hek6Wk+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hek6Wk+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AC61F0089B;
	Sun, 11 Oct 2026 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791730047;
	bh=BQIqip95oa55W8hj4ZgxkP5jfpQrNG9dQFtpXX0xEh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Hek6Wk+pErCFNPvYAJblp1ESgyA/MVg4+hU30iyWT0FQdlqvBf8wFYGr8N3DF3Ubh
	 mLkGRgCWNCEcxNLlnDfByvYFqT6tH+lslbBDVxA+LnzGKIeGn5mjoZSrtSWmWe1ww7
	 ObrtSXsI/BZUmJiySOpctlruek9B/kbyx7wSD+d45/M45F7BPIkyUUa/I65Nnskhi9
	 xYNr6R1ca4p7zxgQII3lik71SjxShHBHe6bWV6GBOjSnxovb9WP2pFbtrrhqYKlVOr
	 95OcGkFretPMbzkzaRa6Ms95Xg/iNhKkwfHASais4Aam4n0TfTjI6F40u18j3WnI1r
	 1rjWyyBE6qNQw==
Message-ID: <83cfc6c0-b76d-448c-8f9c-3ef5091bdd22@kernel.org>
Date: Sun, 11 Oct 2026 16:47:23 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: fix the length of a smaller last zone in
 blkdev_get_zone_info()
To: Shashank Mohan Jain <jain.sm@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261011051906.60397-1-jain.sm@gmail.com>
 <20261011051906.60397-3-jain.sm@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261011051906.60397-3-jain.sm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/11 7:19, Shashank Mohan Jain wrote:
> blkdev_get_zone_info() sets the length of every zone to the zone size
> of the device. The last zone of a zoned block device may be smaller
> than the others: blk_revalidate_zone_cb() accepts that and remembers
> the capacity of that zone in disk->last_zone_capacity. For such a zone
> the length reported from the cached information is too large, and
> start + len is beyond the end of the device. A conventional last zone
> is also given the capacity of a full zone.
> 
> Example with a zoned null_blk device of 10 MiB (20480 sectors) with
> 4 MiB zones, last zone:
> 
>   BLKREPORTZONE:       start 16384 len 4096 capacity 4096
>   BLKREPORTZONEV2 with
>   BLK_ZONE_REP_CACHED: start 16384 len 8192 capacity 4096
> 
> Limit the length to what is left of the device. disk_zone_is_last()
> still recognises the last zone, as start + len is then equal to the
> capacity of the device. The capacity of a conventional zone is equal
> to its length, which blk_revalidate_conv_zone() checks, so use the
> length there.
> 
> Tested with zoned null_blk devices in qemu (all zones sequential, and
> two conventional zones followed by sequential ones, both with a smaller
> last zone): the start, length and capacity of all zones in the cached
> report are the same as in the report from the device with this change.
> null_blk cannot create a device with a conventional last zone, so that
> case is not tested.
> 
> Fixes: f2284eec5053 ("block: introduce blkdev_get_zone_info()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>

Doh! Good catch.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
