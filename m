Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795140284;
	b=JaVp/+nlgmbgvTsEk+CAWHZ7bAequIktKxhkN4b8he7seMkooLqUuBHb53yWICrpErdR
	 wgOaQYg9kcq5GltzF59mF6364hA3Pq3faelbmKGPYXj0JSwnXOXZDRNAUeVuvzxMFpsEg
	 bzM2eY5dfGp+G/dtEo2b4whLorV618xWRlvtxt+ZzRt51ViX2eiyhmT/LS0LdcsPvaRZs
	 S6c5BTqQR4NEiCOvS8zHLYSrZru2pr3YLJM7OVmIULqAVZ5e7P08cg9WvD34m6fN41gJ+
	 iD1jwnMkDE89CMDpNcTTeU7s/LMrIUrWPwlxogdTrZQIhHkyXR1JhBwQM1KqqIm6Cuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795140284;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ki7ACDhjyvtdfKYW4Zkf9GCR7XkHxjgGefiLkkHIQZA=;
	b=s9BiLsYqmKBCpeMcP3Gs+nPOkJrkyceKJpOUFv685F2USrbI5M+UagOkDzHn6rpFHBHb
	 HSS7gejqB2VQsky5ogGTP6wSlGqoXdimDbdv+sRop5WSAvJ/5Yup6Q5rsrNtPdvCLTvnI
	 1WOAL7gaV5zuyptw86zr7nzU/HDwrFQH2FhSor2yRCCcw5X5wrDIltubsYbZG2P/+zL4y
	 X04xFg+Y8LnqIO2aA7fnNw5kGzSL8S6bCO+wnvnopf3pM053nlwDs8cY++5URqcQQUMpA
	 J91bpDTZe7BQOmbKeQ0iIMy/SXqRRN56idnR05xACpdGI/CADTH97giLmm/HBKgVyTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=b3noLNTH;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96755606A320
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96755606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=b3noLNTH
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795140280; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ki7ACDhjyvtdfKYW4Zkf9GCR7XkHxjgGefiLkkHIQZA=;
	b=b3noLNTHSSf4h7/Hn/rtwqZ1hN00ofStgZlpusvXBh/JbYCUvBTGIbReLxbSES48PTnJbvB0Np7/CBob+omDLvyqYmCofxq+T24SV6d0dh8CcgVWAok2ookKDYg5dnF5PHncl9vXkiOqMQdViXEH2SA8ag3os4Skb6VmYXDCkIA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XF4rBzy_1795140277;
Received: from 30.178.67.37(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XF4rBzy_1795140277 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Nov 2026 10:04:38 +0800
Message-ID: <6687d72e-1a1b-4509-aa89-b99c9406b98a@linux.alibaba.com>
Date: Fri, 20 Nov 2026 10:04:36 +0800
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
Subject: Re: [PATCH 5/7] blk-stat: account for the mean of the source in
 blk_rq_stat_sum()
To: Tao Cui <cui.tao@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Tang Yizhou <yizhou.tang@shopee.com>
Cc: linux-block@vger.kernel.org
References: <20261119070548.3125491-1-kanie@linux.alibaba.com>
 <20261119070548.3125491-6-kanie@linux.alibaba.com>
 <d64b0846-2da8-409e-af7f-86b4e0e02a2a@linux.dev>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <d64b0846-2da8-409e-af7f-86b4e0e02a2a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/11/19 21:32, Tao Cui 写道:
> Hello, Guixin,
>
> 在 2026/11/19 15:05, Guixin Liu 写道:
>> blk_rq_stat_sum() folds a src into a dst by combining dst->mean with
>> src->batch only, so it is only correct while src has never been folded
>> itself: its mean is then either zero or stale. blk-iolatency folds the
>> per-cpu stats into a window-local stat first and then folds that result
>> into iolat->cur_stat, so the second fold drops the whole window and
>> cur_stat.rqs.mean stays at zero. On rotating disks, where the mean
>> decides whether the accumulated window meets the latency target,
>> iolatency_check_latencies() therefore always considers the accumulated
>> window OK and scales up more aggressively than intended.
>>
>> Fold src->mean * src->nr_samples into the result as well. The per-cpu
>> users keep their mean at zero through blk_rq_stat_init(), so their
>> behavior is unchanged.
>>
> I posted a fix for the same issue before, which Tang Yizhou reviewed:
>
> https://lore.kernel.org/all/20260904065426.1281914-1-cui.tao@linux.dev/
>
> Adding him here to take a look at your approach as well. Hope the link helps.
>
> Thanks,
> Tao
Hi Tao,
  My thanks for the review, your v3 is better, I will drop my patch5 in
next version.

Best Regards,
Guixin Liu
>
>> Fixes: 451bb7c33197 ("blk-iolatency: keep track of previous windows stats")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>  block/blk-stat.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-stat.c b/block/blk-stat.c
>> index d57c2fc6bf06..6345ae366658 100644
>> --- a/block/blk-stat.c
>> +++ b/block/blk-stat.c
>> @@ -24,7 +24,10 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
>>  	stat->batch = 0;
>>  }
>>  
>> -/* src is a per-cpu stat, mean isn't initialized */
>> +/*
>> + * The mean of @src must have been calculated or set to zero by
>> + * blk_rq_stat_init() before calling this.
>> + */
>>  void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
>>  {
>>  	if (dst->nr_samples + src->nr_samples <= dst->nr_samples)
>> @@ -33,7 +36,8 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
>>  	dst->min = min(dst->min, src->min);
>>  	dst->max = max(dst->max, src->max);
>>  
>> -	dst->mean = div_u64(src->batch + dst->mean * dst->nr_samples,
>> +	dst->mean = div_u64(dst->mean * dst->nr_samples +
>> +				src->mean * src->nr_samples + src->batch,
>>  				dst->nr_samples + src->nr_samples);
>>  
>>  	dst->nr_samples += src->nr_samples;

