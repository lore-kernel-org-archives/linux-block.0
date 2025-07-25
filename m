Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09BFBE65;
	Fri, 25 Jul 2025 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445046; cv=none; b=tQaq34zLmulEwNpRDIMQODU9FiWL5CbUPW4ohOwW/lB9JOfjH/q91YoVk1H7p2aqZmkPDADumSKOPvrEAa/mdaO47bxdEBTKyxD5hgGnbC8jadoeNOGUVLh8Vipjt3/EJetiMvMxVxy9iZ7Qf6peVqB3YL2AzE7yne/bSJtOLpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445046; c=relaxed/simple;
	bh=jg0MiCs6Po5ZRx/w8FmPIFw4SEGPVSu2akZ6JIqO8HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUqt3xIcAf8Jr+uvHh2H1f37xIiT6mKcq6vg0b5WP9GOx+zD5vd3RpFXwKTSQBWGn/Fn5Hj6hXrM+q3Dxy/tcMbeQ5tZyyp86eoUbGiA9PO4sraZJF/HRAnYTwHn6eCONlYRmsCyUXguMgaHnhctqNxPDHCs8Sc+gjFJ/Ej37zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xawo2ZYa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xawo2ZYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6A7C4CEE7;
	Fri, 25 Jul 2025 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753445045;
	bh=jg0MiCs6Po5ZRx/w8FmPIFw4SEGPVSu2akZ6JIqO8HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xawo2ZYacbJ7O0jS9FlDOnvtcQqMASajSLi6ezYxe8pC7nllp1MWKrRg8xdCiGpOF
	 /Lw9NuBdDawbVcOb8hn4hDycUMAkpPspGpqQeWkLZ2SOxyTdiLaEmlVzYc3yJBubBe
	 luiTgtzLE1X2cGzrhWvmACTsp1jnOnBatTQgEbqY=
Date: Fri, 25 Jul 2025 14:04:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardeep Sharma <quic_hardshar@quicinc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y v2 1/1] block: Fix bounce check logic in
 blk_queue_may_bounce()
Message-ID: <2025072551-tingling-botany-f00d@gregkh>
References: <20250725112710.219313-1-quic_hardshar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725112710.219313-1-quic_hardshar@quicinc.com>

On Fri, Jul 25, 2025 at 04:57:10PM +0530, Hardeep Sharma wrote:
> Buffer bouncing is needed only when memory exists above the lowmem region,
> i.e., when max_low_pfn < max_pfn. The previous check (max_low_pfn >=
> max_pfn) was inverted and prevented bouncing when it could actually be
> required.
> 
> Note that bouncing depends on CONFIG_HIGHMEM, which is typically enabled
> on 32-bit ARM where not all memory is permanently mapped into the kernel’s
> lowmem region.
> 
> Fixes: 9bb33f24abbd0 ("block: refactor the bounce buffering code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hardeep Sharma <quic_hardshar@quicinc.com>
> ---
> Changelog v1..v2:
> 
> * Updated subject line
> 
>  block/blk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 67915b04b3c1..f8a1d64be5a2 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -383,7 +383,7 @@ static inline bool blk_queue_may_bounce(struct request_queue *q)
>  {
>  	return IS_ENABLED(CONFIG_BOUNCE) &&
>  		q->limits.bounce == BLK_BOUNCE_HIGH &&
> -		max_low_pfn >= max_pfn;
> +		max_low_pfn < max_pfn;
>  }
>  
>  static inline struct bio *blk_queue_bounce(struct bio *bio,
> -- 
> 2.25.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
