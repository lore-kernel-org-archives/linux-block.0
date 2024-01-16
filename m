Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A31A1C68D
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZHEHTIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E230EC433C7;
	Tue, 16 Jan 2024 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705421603;
	bh=xoZFeHqQobIyWNDfnWjvip7s2dxbUjiFqEPf50SX6sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZHEHTIwGQs1ioKPRlEsKgckbf+95n+xTCaE//7kRpXKckYawJ9igHK73ZQoe99qj
	 a9Hb0LSAyxgwHJ/2AWwHPSzgUJTYaMNjcB7Ze9eiOkcDlGL5wVsuXa76t4JT+VjdXN
	 PHUVm6mlTOVUpZSmNMGgJFr8akILCc8j9Sf5q99rbLEw+mWypWh7sGm6fAxEW+Ulmz
	 TynLF401mTRVKckVJCsx+eRCWBdzjJKu/uPxRLRZfwda0+MOW+Ta1Q2NquAa4IdKbJ
	 DVulRZIumUTuLsnFvtpa3w/rBO13X/c+3prCkDbn2vPn3jos4mTvUGrgO40EWP8LwO
	 en/6DNvWd6s2A==
Date: Tue, 16 Jan 2024 09:13:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: cache current nsec time in struct blk_plug
Message-ID: <ZaarIH6-Elu2g3rL@kbusch-mbp.dhcp.thefacebook.com>
References: <20240115215840.54432-1-axboe@kernel.dk>
 <20240115215840.54432-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115215840.54432-3-axboe@kernel.dk>

On Mon, Jan 15, 2024 at 02:53:55PM -0700, Jens Axboe wrote:
> If the block plug gets flushed, eg on preempt or schedule out, then
> we invalidate the cached clock.

There must be something implicitly happening that I am missing. Where is
the 'cur_time' cached clock invalidated on a plug flush?
 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 11342af420d0..cc4db4d92c75 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1073,6 +1073,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
>  	if (tsk->plug)
>  		return;
>  
> +	plug->cur_ktime = 0;
>  	plug->mq_list = NULL;
>  	plug->cached_rq = NULL;
>  	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2f9ceea0e23b..23c237b22071 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -942,6 +942,7 @@ struct blk_plug {
>  
>  	/* if ios_left is > 1, we can batch tag/rq allocations */
>  	struct request *cached_rq;
> +	u64 cur_ktime;
>  	unsigned short nr_ios;
>  
>  	unsigned short rq_count;
> @@ -977,7 +978,15 @@ long nr_blockdev_pages(void);
>  
>  static inline u64 blk_time_get_ns(void)
>  {
> -	return ktime_get_ns();
> +	struct blk_plug *plug = current->plug;
> +
> +	if (!plug)
> +		return ktime_get_ns();
> +	if (!(plug->cur_ktime & 1ULL)) {
> +		plug->cur_ktime = ktime_get_ns();
> +		plug->cur_ktime |= 1ULL;
> +	}
> +	return plug->cur_ktime;
>  }
>  #else /* CONFIG_BLOCK */
>  struct blk_plug {
