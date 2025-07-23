Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5B28C5A5
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269945; cv=none; b=caLJx8/87pWL9QwOgW9Dmc/SZiPYz7nh5L2lowRhCyGxF78ljS4mXdFRsRAci+bivg2ClkLHwFMSGO0aYbwQIPACNQ1igcaLQ869CQNuOpZV0npDIrso9SG/KEQlbFXvvwYP5b5XjGbinPjir9SKjXiFwOQ/NN7c1blvrpf4rG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269945; c=relaxed/simple;
	bh=viBfvw0b+o5LAMCwnd67+2wCsa0i9NjH8GcHO0QLknc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/X+HThjA/E/2/bXyDBFLxm4imb6r0tOm7Y00fPwMy3l/X428UmkSgYkEN42/2PT+fAJdid3BkG38wjpgfTiAcv+RuPseCCKMkm5dAjKfQBsBO3z8piGJis9yAvX2atI5l1WhhQdWCfXYHRB6EaZh+OMBSHPErN8QiZBZQEsHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLTi8G/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLTi8G/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D349EC4CEF6;
	Wed, 23 Jul 2025 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753269943;
	bh=viBfvw0b+o5LAMCwnd67+2wCsa0i9NjH8GcHO0QLknc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLTi8G/NwtDfWzyubzKlv+AgWjaBFLk9YDoox2l/rLbgce+/oESHAZFJm4hHaGt6K
	 XE8DKiAON5oKtoiQLANc/L4ldMQ347by6GkTVqmk1ySekc5Q79lNV9zTsV9RY6p3d+
	 YhyKPLpcHCkViEtWPj1BHONf5vu0np0FO5KUYsTW2pCJvxTf4gquapLJLdVsx3G0U7
	 upfMZWLDfoIwPTLCyuGQa/FuuNckj+sOTEliFYDTEkiDXFpxk17RXykWq1p5evPtMw
	 4PhCZIGbtCKAeL4Y0Tqy9Rrd0iUwTsH60TfT4paDp8yAgVEBdBrdcJ63a/FveDUqn8
	 HJ9Tmbxd17Z1A==
Date: Wed, 23 Jul 2025 19:25:36 +0800
From: Coly Li <colyli@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 4/5] bcache, tracing: Remove superfluous casts
Message-ID: <6lyettjmfycegqwh5vs5k2d4gbigeljnw7tdllezctpoi5i554@l2zzodakdi54>
References: <20250715165249.1024639-1-bvanassche@acm.org>
 <20250715165249.1024639-5-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715165249.1024639-5-bvanassche@acm.org>

On Tue, Jul 15, 2025 at 09:52:38AM +0800, Bart Van Assche wrote:
> sector_t is a synonym for u64 and all architectures define u64 as unsigned
> long long. Hence, it is not necessary to cast type sector_t to unsigned
> long long. Remove the superfluous casts to improve compile-time type checking.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Coly Li <colyli@kernel.org>

Thanks.

Coly Li

> ---
>  include/trace/events/bcache.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
> index d0eee403dc15..697e0f80d17c 100644
> --- a/include/trace/events/bcache.h
> +++ b/include/trace/events/bcache.h
> @@ -33,9 +33,9 @@ DECLARE_EVENT_CLASS(bcache_request,
>  
>  	TP_printk("%d,%d %s %llu + %u (from %d,%d @ %llu)",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  __entry->rwbs, (unsigned long long)__entry->sector,
> +		  __entry->rwbs, __entry->sector,
>  		  __entry->nr_sector, __entry->orig_major, __entry->orig_minor,
> -		  (unsigned long long)__entry->orig_sector)
> +		  __entry->orig_sector)
>  );
>  
>  DECLARE_EVENT_CLASS(bkey,
> @@ -107,7 +107,7 @@ DECLARE_EVENT_CLASS(bcache_bio,
>  
>  	TP_printk("%d,%d  %s %llu + %u",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
> -		  (unsigned long long)__entry->sector, __entry->nr_sector)
> +		  __entry->sector, __entry->nr_sector)
>  );
>  
>  DEFINE_EVENT(bcache_bio, bcache_bypass_sequential,
> @@ -144,7 +144,7 @@ TRACE_EVENT(bcache_read,
>  
>  	TP_printk("%d,%d  %s %llu + %u hit %u bypass %u",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  __entry->rwbs, (unsigned long long)__entry->sector,
> +		  __entry->rwbs, __entry->sector,
>  		  __entry->nr_sector, __entry->cache_hit, __entry->bypass)
>  );
>  
> @@ -175,7 +175,7 @@ TRACE_EVENT(bcache_write,
>  
>  	TP_printk("%pU inode %llu  %s %llu + %u hit %u bypass %u",
>  		  __entry->uuid, __entry->inode,
> -		  __entry->rwbs, (unsigned long long)__entry->sector,
> +		  __entry->rwbs, __entry->sector,
>  		  __entry->nr_sector, __entry->writeback, __entry->bypass)
>  );
>  
> @@ -243,8 +243,7 @@ TRACE_EVENT(bcache_journal_write,
>  
>  	TP_printk("%d,%d  %s %llu + %u keys %u",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
> -		  (unsigned long long)__entry->sector, __entry->nr_sector,
> -		  __entry->nr_keys)
> +		  __entry->sector, __entry->nr_sector, __entry->nr_keys)
>  );
>  
>  /* Btree */
> 
