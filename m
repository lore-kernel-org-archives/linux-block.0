Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82AB8BE8
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046111; cv=none; b=PFwcqK50wIUsCmQnEFb/JQvd5ODGanlKAsk5M8k5IKFZ0GOwjlg7nKPrL5P5qdI2alR+IAiCdHPclq4l+76BY3DR9yFbYTyy9/BU6xjMqY8eIwaC+3dpQbtGuCaGvSGiSRNzpw5be2F7TCIGLxzljVt4O5TpgYXpu7bTSa+QJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046111; c=relaxed/simple;
	bh=8oLrgK9C6ohIruy69uYk8Zr9m9fpqhzgQWbPiZSS5uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoqTH2MPvCShEjB4Ff7ANbe3t9Cg+Bsv6CrigmPtYcrLmeJWIT9t+ZFdRXZp+/BFkg4HsJZS/1yPrAwBD+TYJK+eAJs4e3amq6mJ7C2bVQG5T0cu7iqx0p8W/BigfwkmHdYv2YDYiZwkohiJT6m27Fu1ppsXzN9wT25bMpUMpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WP19fEZu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WP19fEZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715046108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jz6tGiN3/pDsycUAR7ZqH96/XZ78mMH+/bfT4uIpUXI=;
	b=WP19fEZuu1N4sgq8BedqnQsZAiVWaN/yJ0mmQvVpv8Zow1wkp29UO2rqnqyqywrRYhhs5h
	wYUOkDvy3vggxLCwiZV35zwRNyJ5RBbv2zgxrK96IAjKVPdoZNkO40DsrL5bI83C7nm1Mv
	Zzu+eG2vBcWZDTwI04beZWjqnbaTznI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-YrudfUUUMmuaOUjf8JeyHg-1; Mon,
 06 May 2024 21:41:45 -0400
X-MC-Unique: YrudfUUUMmuaOUjf8JeyHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A87C71C0515D;
	Tue,  7 May 2024 01:41:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.102])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 057B7C13FA1;
	Tue,  7 May 2024 01:41:40 +0000 (UTC)
Date: Tue, 7 May 2024 09:41:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] block: set default max segment size in case of
 virt_boundary
Message-ID: <ZjmG0aFl1oU2OeDZ@fedora>
References: <20240424134722.2584284-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424134722.2584284-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Wed, Apr 24, 2024 at 09:47:22PM +0800, Ming Lei wrote:
> For devices with virt_boundary limit, the driver may provide zero max
> segment size, we have to set it as UINT_MAX at default. Otherwise, it
> may cause warning in driver when handling sglist.
> 
> Fix it by setting default max segment size as UINT_MAX.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Fixes: b561ea56a264 ("block: allow device to have both virt_boundary_mask and max segment size")
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Closes: https://lore.kernel.org/linux-block/7e38b67c-9372-a42d-41eb-abdce33d3372@linux-m68k.org/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-settings.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index d2731843f2fc..9d6033e01f2e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -188,7 +188,10 @@ static int blk_validate_limits(struct queue_limits *lim)
>  	 * bvec and lower layer bio splitting is supposed to handle the two
>  	 * correctly.
>  	 */
> -	if (!lim->virt_boundary_mask) {
> +	if (lim->virt_boundary_mask) {
> +		if (!lim->max_segment_size)
> +			lim->max_segment_size = UINT_MAX;
> +	} else {
>  		/*
>  		 * The maximum segment size has an odd historic 64k default that
>  		 * drivers probably should override.  Just like the I/O size we

Hello Jens,

Looks this fix is missed, can you make it to v6.9?


Thanks,
Ming

