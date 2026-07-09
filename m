Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464838B7B4;
	Thu,  9 Jul 2026 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560106; cv=none; b=TMpg0J+UWDWfTiBcA2kKuHSHnxDZetwv8Mj4clFojmDwBq5fn2OqHi8uY2jQ/iqJYANbU4cIdRo+yJlpPj5OUAEpX10YceI+ySz64tt0NMlXjlvB5Kf9bagXhGBAhzScvzm7xgeZEr/ZFp5KiCLI/Br5yUQn6HoFQPMh+R1uN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560106; c=relaxed/simple;
	bh=+DihPCn4xArVV/YqZmr1a/09s4lPoQjYYS7iV5R7SW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gh/NWpWTtK7dq37FxZEHnKpWcDlEKiBk9bAkCs1puqNEQqNO1ql/YWAWQBNTjbZs5vyImE0HAg7vWtXQ1Kr9XJzbrQ01VLhUATI9kBUOzBLTCUqpSP12o5Qt5MuQV+ONSSBVgjMXuiStcMxggCdljK2aLtGeNXBjG2ALCLgJ65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CkqkLXCJ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CkqkLXCJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783560100; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=K7F9uC92T4GAk+VUln9wzSr5AAHGp3bwf4vD/uf3Hqc=;
	b=CkqkLXCJWhTAsIErPKL9dAN+XxWK8L9t3jJk+FFfmgIXnKZO1HDuDTMb0Th7cwAK2fPCXtaCwJVs86NCO7JazpuR2yA6Tw8RmH8fU0ltW9HRqtTvID+tuEQ0NNKhflh/v0POZTTGvyfJ6zjBs9ySXghV8K6KV1jURkIQGJ8i+28=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6intuN_1783560098;
Received: from 30.221.145.97(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X6intuN_1783560098 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Jul 2026 09:21:39 +0800
Message-ID: <4383327c-0e74-4aa7-b682-04f874b23478@linux.alibaba.com>
Date: Thu, 9 Jul 2026 09:21:37 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix bio_alloc_bioset() percpu cache fallback for
 non-reclaim contexts
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun@linux.alibaba.com>
References: <20260708011413.1710118-1-joseph.qi@linux.alibaba.com>
 <20260708084547.GA3591@lst.de>
 <b8b95aeb-8443-404b-a320-e3bd3fed1598@linux.alibaba.com>
 <20260708162100.GA2502@lst.de>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20260708162100.GA2502@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 12:21 AM, Christoph Hellwig wrote:
> On Wed, Jul 08, 2026 at 05:49:21PM +0800, Joseph Qi wrote:
>> Looks sane. So commit b520c4eef83d exposed the bug but not introduced it.
> 
> Well, there is a bug in virtio_pmem for sure.  But I also think the
> bio_alloc_bioset behavior isn't quite optimal for non-sleeping
> allocations.  But I'd probably go more for something like this there:
> 
> diff --git a/block/bio.c b/block/bio.c
> index f2a5f4d0a967..bdca2e60514b 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -555,6 +555,13 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
>  		bio = bio_alloc_percpu_cache(bs);
>  	} else {
>  		opf &= ~REQ_ALLOC_CACHE;
> +	}
> +
> +	/*
> +	 * If the percpu cache was empty, try an slab allocation with optimistic
> +	 * GFP_ flags ass well before falling back to the mempool.
> +	 */
> +	if (!bio) {
>  		p = kmem_cache_alloc(bs->bio_slab, gfp);
>  		if (p)
>  			bio = p + bs->front_pad;

I wrote like this firstly, but to not mixed the bs->cache and normal
case so I dropped it.
Anyway I'm fine with this way. I'll send v2 later.

Thanks,
Joseph
