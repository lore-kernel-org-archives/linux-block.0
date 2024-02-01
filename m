Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1C1FD7;
	Thu,  1 Feb 2024 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747782; cv=none; b=Ut/0pp8SDqX5aHC8Q6dI5XJLSXQ5oh6IPCxS/jxtEBcPUS3kJKD+5x3QkrPjViiUm2DcbFSrMQ719IxaIWjX+ro0qcun+nr0RS08BntAS5kOYDmcPDFUqX/NxK7wuPQVCL2cag6Iq0O3gHr5GqpHvzLQwwoxxqLHuq0JMnjJxOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747782; c=relaxed/simple;
	bh=0JtscoZzimQzp2qkEcWvxbxxzEjKJfAvKpp5ErN+JRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLXPeMm61T/gjvcT6yfIuiCPoQTZmbGaAUL1MtMAHBa5FSuu2MINLYFEz2Jf4GUiGQsXKtHkhgtdgQQpMqVX8+FqeFYjXvPU4TzyY0b3tF28YdTxkQDWa8jcDBxCWk1Yyoe8dnoisVhqN3GdK3Zs8prHGsM2NUoEhVqweDnXWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hdj1O3eT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hdj1O3eT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93251C433F1;
	Thu,  1 Feb 2024 00:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747781;
	bh=0JtscoZzimQzp2qkEcWvxbxxzEjKJfAvKpp5ErN+JRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hdj1O3eTlMJ5bNCLIljTMwhz4Ww4bqYUMvrHtpjmot/k5qbNGF93N1onIpUznJnrO
	 IDiPQsEdl5HfbfFEXnJLRN5YhAYMvgEExsGwNC2xH26C3zwYrnE51VGmkLnZbLkhO6
	 agMEGfcAZjUvB+EdBye9rmc3W9mTqLPwifIi1FYb5h/Ea/WqpHmSZ1o0FwrZuHMC9w
	 SXmURZUVXViiBF49/ionbkWJ81ktopVaeqppc3Qh6F/kkGxu9ua8C+nmutT+Gmy7uy
	 zANJK1OLoEkjbjwuXhnVOMdJATbKPqLFserhHWxntsKFLkWFI5uHhPicWpgTMkCtCg
	 YBy4P1/MEwX9g==
Date: Wed, 31 Jan 2024 17:36:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 05/14] block: add a max_user_discard_sectors queue limit
Message-ID: <ZbrngpaAisIJGQ0T@kbusch-mbp.dhcp.thefacebook.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131130400.625836-6-hch@lst.de>

On Wed, Jan 31, 2024 at 02:03:51PM +0100, Christoph Hellwig wrote:
>  static ssize_t queue_discard_max_store(struct request_queue *q,
>  				       const char *page, size_t count)
>  {
> -	unsigned long max_discard;
> -	ssize_t ret = queue_var_store(&max_discard, page, count);
> +	unsigned long max_discard_bytes;
> +	ssize_t ret;
>  
> +	ret = queue_var_store(&max_discard_bytes, page, count);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (max_discard & (q->limits.discard_granularity - 1))
> +	if (max_discard_bytes & (q->limits.discard_granularity - 1))
>  		return -EINVAL;
>  
> -	max_discard >>= 9;
> -	if (max_discard > UINT_MAX)
> +	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
>  		return -EINVAL;
>  
> -	if (max_discard > q->limits.max_hw_discard_sectors)
> -		max_discard = q->limits.max_hw_discard_sectors;
> -
> -	q->limits.max_discard_sectors = max_discard;
> +	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> +	q->limits.max_discard_sectors =
> +		min_not_zero(q->limits.max_hw_discard_sectors,
> +			     q->limits.max_user_discard_sectors);

s/min_not_zero/min

Otherwise the whole series looks pretty good! And with that:

Reviewed-by: Keith Busch <kbusch@kernel.org>
