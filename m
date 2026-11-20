Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143071;
	b=0TD+cS0Hz1Ty3Isd9wQQ8gyXxXYko1GmydmYhfZIGP29x/agsGXI110PJNWlCJXlCK09
	 1FPCGY8uo+RMkWvMEyPfsuLNsY0IWxkL2puixuSm8vm+NM/33haiCxjYsob+7SWz+msGQ
	 h1go9YGcsWJpWzty0kZ6VjouZKAVcToc16bXMSLBkZjnxoQHxmks15s2tpxVVJvPl+fBX
	 9JzOQPQVJlilTs/MnRALUXWzjhh0TQQwCvyUqeWapMk0SLLkUllYnMMaGoecbN3HVCeuk
	 nE6L3mmGg51EfwnHkf+cS7MBVZK2kYcjdnLziPk8jHCVkOtFAbKpwgKcrAG9wfpEVtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143071;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yicg9qJVr/bFbWgkUpOKGBjL1cnWrB0lAC4D9KcriEU=;
	b=TUpiQrL8Pk2rEwEWksaUGih6vqhBzXsbWx5xyvZPEt7b93SS4IPftV7VEdCGBWFFMutJ
	 kHz6eRutYanOgdzJShxKAzUyZDI4NPl6TVUbF5/6ZztzVqi2xAOOjRb0b9oXli9BeQXgn
	 Rpm/KkjAXA69L8gNAtM/33OjLmWQPAddkNylfhmb+S9m+6UfSmSZhqxZBLxOBYRcpfcFR
	 MbDSDvBxGY6gmS7d5uSTlHNYjGMUfv2/x02FD8bIOIPgVbowVi2bp74j32F608hkOZtCy
	 ZoAJoI+I8BeV1qgvk5BnZ1c8LuUJI2Dt1PG8NUelz2k4KOZMBPVh7s5dYJWiC84AU3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EgjOCB8G;
	arc=none smtp.remote-ip=91.218.175.23
Received: from mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C5606A320
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E6C5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EgjOCB8G
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AZwJdsTp2E5+/EYXhe4dvrbfpQhNHuYPOymwqGC65Nc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795143068; v=1; x=1795747868;
 b=EgjOCB8GzQdzjufQQp/ncw0B9TQ1b9OVN0cG7/da4CVaDoBdH4qZ9ShjNGggVKFMS5crIN9E
 j/I47Y52mDjQ1U8vHjinYIDHC0bFtV1MT3l4lMTGAGUGLF8BqpiEyLoQvHtQMXyhn1kOK1Ub22P
 lnuOIEhcgTjldlwIuaEHSPNY=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e11279f180861b77;
	Fri, 20 Nov 2026 02:51:08 +0000
X-Mizu-Trace-ID: e11279f180861b77
X-Migadu-Flow: FLOW_OUT
Message-ID: <1e27d0b9-faab-46fe-b6a6-a3fbcff12e7e@linux.dev>
Date: Fri, 20 Nov 2026 10:50:58 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH 5/7] blk-stat: account for the mean of the source in
 blk_rq_stat_sum()
To: Guixin Liu <kanie@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Tang Yizhou <yizhou.tang@shopee.com>
References: <20261119070548.3125491-1-kanie@linux.alibaba.com>
 <20261119070548.3125491-6-kanie@linux.alibaba.com>
 <d64b0846-2da8-409e-af7f-86b4e0e02a2a@linux.dev>
 <6687d72e-1a1b-4509-aa89-b99c9406b98a@linux.alibaba.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <6687d72e-1a1b-4509-aa89-b99c9406b98a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Guixin

在 2026/11/20 10:04, Guixin Liu 写道:
> 
> 
> 在 2026/11/19 21:32, Tao Cui 写道:
>> Hello, Guixin,
>>
>> 在 2026/11/19 15:05, Guixin Liu 写道:
>>> blk_rq_stat_sum() folds a src into a dst by combining dst->mean with
>>> src->batch only, so it is only correct while src has never been folded
>>> itself: its mean is then either zero or stale. blk-iolatency folds the
>>> per-cpu stats into a window-local stat first and then folds that result
>>> into iolat->cur_stat, so the second fold drops the whole window and
>>> cur_stat.rqs.mean stays at zero. On rotating disks, where the mean
>>> decides whether the accumulated window meets the latency target,
>>> iolatency_check_latencies() therefore always considers the accumulated
>>> window OK and scales up more aggressively than intended.
>>>
>>> Fold src->mean * src->nr_samples into the result as well. The per-cpu
>>> users keep their mean at zero through blk_rq_stat_init(), so their
>>> behavior is unchanged.
>>>
>> I posted a fix for the same issue before, which Tang Yizhou reviewed:
>>
>> https://lore.kernel.org/all/20260904065426.1281914-1-cui.tao@linux.dev/
>>
>> Adding him here to take a look at your approach as well. Hope the link helps.
>>
>> Thanks,
>> Tao
> Hi Tao,
>   My thanks for the review, your v3 is better, I will drop my patch5 in
> next version.
> 
Sorry, that's not what I meant. The issue is real and your patch works; I just felt changing the contract of blk_rq_stat_sum() has a wider impact, so I adapted the fix to the contract in the caller instead. That said, my v3 has been pending for months without review, so it may well have problems I haven't noticed myself, seeing your patch I also realized my Fixes tag is wrong.

Thanks,
Tao
> Best Regards,
> Guixin Liu
>>
>>> Fixes: 451bb7c33197 ("blk-iolatency: keep track of previous windows stats")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>>> ---
>>>  block/blk-stat.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-stat.c b/block/blk-stat.c
>>> index d57c2fc6bf06..6345ae366658 100644
>>> --- a/block/blk-stat.c
>>> +++ b/block/blk-stat.c
>>> @@ -24,7 +24,10 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
>>>  	stat->batch = 0;
>>>  }
>>>  
>>> -/* src is a per-cpu stat, mean isn't initialized */
>>> +/*
>>> + * The mean of @src must have been calculated or set to zero by
>>> + * blk_rq_stat_init() before calling this.
>>> + */
>>>  void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
>>>  {
>>>  	if (dst->nr_samples + src->nr_samples <= dst->nr_samples)
>>> @@ -33,7 +36,8 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
>>>  	dst->min = min(dst->min, src->min);
>>>  	dst->max = max(dst->max, src->max);
>>>  
>>> -	dst->mean = div_u64(src->batch + dst->mean * dst->nr_samples,
>>> +	dst->mean = div_u64(dst->mean * dst->nr_samples +
>>> +				src->mean * src->nr_samples + src->batch,
>>>  				dst->nr_samples + src->nr_samples);
>>>  
>>>  	dst->nr_samples += src->nr_samples;
> 

