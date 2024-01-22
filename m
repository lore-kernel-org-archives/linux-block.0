Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409454EB3F;
	Mon, 22 Jan 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948039; cv=none; b=RPTKYI9n6E4/9OKzGiZsw3HdKVkSTcClMIdN0XM5YfZddxzuMxvdXbkD+e/avRbazeKzHmLCZ9pVCjBhvqMsVZ1iV1rkrDvUpl8TdOt+PWZ85Wuauk0tCcndjd6pdhhneq0JG5p2+uhSphVYHMJ1WBkfQ9TZslkYq0fxoDaHBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948039; c=relaxed/simple;
	bh=PlJsX8lq4hlaXsdUus+uVis54Jh85qBVrYR1P5XnPmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXjDlcd4aej1JS/2hiPe0wbNdo8WBFwQ46GksyGsgKOFrajYpXIjUMOr2tkAXMoh5KE8aRVyTb4OnkQVYW1Yyt04fmr2wbbc806NyGL4hNm4cv43z769Ivj9s9Zc5lpYjjYrblreXn1GyHlIp3qLuZtsVjMo0IUBmBaGchATUAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWMOAhkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWMOAhkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52EDC433C7;
	Mon, 22 Jan 2024 18:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705948038;
	bh=PlJsX8lq4hlaXsdUus+uVis54Jh85qBVrYR1P5XnPmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWMOAhkwVSBJ3AEfqFEvKX11Hz05OIRqB4ABWsbho088Ga2Cx0RG7E35ba45no3Zi
	 zaVv5Mbe+zgWL0AuaZXj2BRHaCkBpS2ud8TZ6mGSu1KL+z2Z2fl97EIAZ03N6Fgjet
	 pEqGlVkThabnQoyFEJihfuPQMlFG0MD3qLx9Bck72plbi8mYijTgka0czNY7guWoii
	 Hro4Arm3HOAxnyL8Bkg+TTKXm7xK8G9Zm6zyrD/tWkTbQP+ZsD57U9EIWRhjfxq5qj
	 Xe66J+3zLwsB/OARPDDie1prAtn5Dt8SW4VDYZEc+n5vIAqh5PgUyuSKABGIXHv4jd
	 mL3mbpNpnldng==
Date: Mon, 22 Jan 2024 11:27:15 -0700
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
	linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 05/15] block: add a max_user_discard_sectors queue limit
Message-ID: <Za6zg-pA8IJkIb_b@kbusch-mbp.dhcp.thefacebook.com>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122173645.1686078-6-hch@lst.de>

On Mon, Jan 22, 2024 at 06:36:35PM +0100, Christoph Hellwig wrote:
> @@ -174,23 +174,23 @@ static ssize_t queue_discard_max_show(struct request_queue *q, char *page)
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

Shouldn't writing 0 disable discards?
