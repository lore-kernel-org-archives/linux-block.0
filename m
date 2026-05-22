Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDC4379982;
	Fri, 22 May 2026 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451945; cv=none; b=KLpQyfF7p/Lsip6f6G1RigMnfTeH34lalbxtA1WUNNwppFRShCY5bkA67xR5h5k/OhEEzyMzbLBHBsprUWraV+jZAP+uRMDdsrn8L94qBRZ1vESBKvhGpCn8fI8qon5W7/SKqa5/kG7HCjZvlAQDBn1mw6Im/7afHyo8513ETHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451945; c=relaxed/simple;
	bh=SKkrgmHUXySw4hFdoM+qZoUTi/eG9VJMo5BodmlbDjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBG2q/qOimNwwxA63EaxKMC7eUsO6a7sOPKBdwvlSu3eDWJsBhB7ByaNzByvV8WB7op9y5CczZOkYK/n2K07wdHPxHrET3dIZXeJQqPRnJ0J+0k0YEmIfq2ZtV7ZIi4B4oxg+P3U6gN/0JuYMuZhpzr6wwuEzsCs+JApFxVd4Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0103868C7B; Fri, 22 May 2026 14:12:19 +0200 (CEST)
Date: Fri, 22 May 2026 14:12:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: axboe@kernel.dk, hch@lst.de, yukuai@fnnas.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: Re: [PATCH] block: propagate in_flight to whole disk on partition
 I/O
Message-ID: <20260522121219.GB21338@lst.de>
References: <20260522113751.171630-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522113751.171630-1-yizhou.tang@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 22, 2026 at 07:37:51PM +0800, Tang Yizhou wrote:
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1043,6 +1043,8 @@ unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
>  	part_stat_lock();
>  	update_io_ticks(bdev, start_time, false);
>  	part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
> +	if (bdev_is_partition(bdev))
> +		part_stat_local_inc(bdev_whole(bdev), in_flight[op_is_write(op)]);

overly lone line.

> +	if (bdev_is_partition(bdev))
> +		part_stat_local_dec(bdev_whole(bdev), in_flight[op_is_write(op)]);

Same.

>  }
> @@ -1144,6 +1147,9 @@ static inline void blk_account_io_start(struct request *req)
>  	part_stat_lock();
>  	update_io_ticks(req->part, jiffies, false);
>  	part_stat_local_inc(req->part, in_flight[op_is_write(req_op(req))]);
> +	if (bdev_is_partition(req->part))
> +		part_stat_local_inc(bdev_whole(req->part),
> +				    in_flight[op_is_write(req_op(req))]);

and tis duplicates the above logic.  Mabye factor the common code
into two little helpers?

