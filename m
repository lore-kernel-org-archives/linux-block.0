Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C837F73A;
	Wed, 15 Jul 2026 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159172; cv=none; b=VG90SBphF1H9POl/I+9a8Lsk4l10QnUOc2ey2bPoJDyWZjFITmy0ZQ0juKKBwbGT34LX9NPPvhhRVKyCdsFb+odcrqxHX9peHqaRN7VoFrcI7CrimGy36euZrqpqjAyn9+/A76lM8QTda+tjLudizOLnFQAjX7ob3Lf9AtGtqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159172; c=relaxed/simple;
	bh=6uMNR5oarpyq6tX6RbV5j8SK/SGqTXi9w+SuZ8P4fN0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZjCyBGjR+fJ2oHrZ42tPnlWg/Ii8bIvtrZqLGooUYCIY4tUMgO5qE/otPi3cHzpHoKNM0Xf6ukeT/wuqeEEfGEjdzLekbs31QivJK/I86cT+aslejnNlL+bNDliPllFrrQKYNhIGxhLbSB3PgWtlb5nuIuwKGQUd9I/OCZvS0sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uZ8AVIew; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uZ8AVIew"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784159166; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=NtXKJgcppxQMV/NMv1E3913o595U21E8wW1PC7YDYbw=;
	b=uZ8AVIewffc8p/3vT4uT8B2ygrUpa82KbRDh/j7iVeGhlTMyoldJIvRhdZLhwBOOqAdHvP1zgcp9Kx6W6Pq6YCwxBSeQ06OIF576IOVSaDYTx0IxwLs/I/h+WH50ekV3CB3JU55tMkUUIwUrHKTGbTaPiuLLjQcsZVUpvK5LA58=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X7AYwT3_1784159165;
Received: from 30.134.110.188(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X7AYwT3_1784159165 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jul 2026 07:46:05 +0800
Message-ID: <da6a57b6-8bbc-4ee6-b3ec-37bcc4db0e44@linux.alibaba.com>
Date: Thu, 16 Jul 2026 07:46:03 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: try slab allocation in bio_alloc_bioset()
 before mempool
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Baokun Li <libaokun@linux.alibaba.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260709020145.4011533-1-joseph.qi@linux.alibaba.com>
In-Reply-To: <20260709020145.4011533-1-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Gentle ping...

On 7/9/26 10:01 AM, Joseph Qi wrote:
> When the per-CPU bio cache is enabled but empty, bio_alloc_percpu_cache()
> returns NULL and bio_alloc_bioset() falls straight through to the mempool
> fallback:
> 
>     if (unlikely(!bio)) {
>         if (!(saved_gfp & __GFP_DIRECT_RECLAIM))
>             return NULL;
>         ...
>     }
> 
> For non-sleeping allocations (no __GFP_DIRECT_RECLAIM) this returns NULL
> without ever attempting a slab allocation, even when there is plenty of
> free memory.
> 
> Commit b520c4eef83d ("block: split bio_alloc_bioset more clearly into a
> fast and slowpath") introduced this. Before it, a percpu cache miss fell
> through to mempool_alloc(), which attempted the underlying slab allocation
> first and only failed when that slab allocation failed. The restructuring
> dropped the slab attempt that non-sleeping callers of a cache-enabled
> bioset (such as the default fs_bio_set used by bio_alloc()) relied on.
> 
> Try a slab allocation with optimistic GFP_ flags before falling back to
> the mempool whenever the bio is still NULL, so both the cache-empty and
> non-cache paths share the same slab attempt. This restores the previous
> behavior for non-sleeping allocations.
> 
> Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  block/bio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index f2a5f4d0a9672..982f2e47a4218 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -555,6 +555,14 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
>  		bio = bio_alloc_percpu_cache(bs);
>  	} else {
>  		opf &= ~REQ_ALLOC_CACHE;
> +	}
> +
> +	/*
> +	 * For a bioset without a percpu cache, or when the percpu cache was
> +	 * empty, try a slab allocation with optimistic GFP_ flags before
> +	 * falling back to the mempool.
> +	 */
> +	if (!bio) {
>  		p = kmem_cache_alloc(bs->bio_slab, gfp);
>  		if (p)
>  			bio = p + bs->front_pad;

