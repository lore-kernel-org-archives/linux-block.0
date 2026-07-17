Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10E39E184
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784267095; cv=none; b=qEyUpRpW4p1qPkvdeGPyciIoyveHc6BCE/HFBC0nIZU8I+x/2zmhRBAPnMh13LyjWjI65T8XdjIg5MbdoZeTFFDrU5dDOjhF9SdeIkD1/H4qYuxWtSDVZrML2r30l+9Be20q8bj8j3T6gpRwL9ylrEW40FRl8ZRnUGE5HCnRrUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784267095; c=relaxed/simple;
	bh=E2dSBkOKulO/PfX9Y1ObM0pfvwRMw8/USAXWVGaU/pY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uTdfUeS+OzNbjti0NAKT+YVrH7HM+S6mvguNgyX1EcnrY02aBcDs4S2+Ue9DjMfigcdszXc+mlj3KrGcIx5sBGRuomMqbI0jhLsdLiPajyk+2w5SQWxh1KdcrZtS17Yfjy/KP98T9cysWsPuPfFOa5poNT/acJVcpN/yaAd9XSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rt7GAOYO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rt7GAOYO"
Message-ID: <eda14aea-d8f0-4f88-a239-2922d21be826@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784267081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNGhDHPafl4m8joiPI83tO0EntyBoiK1+fC2v1uh4m4=;
	b=Rt7GAOYO9fhNg65pVgNwNsu8YiaPK9ZaM2wqDhj+nhTm367uOABY4FIuc76+L2mVCBjGjc
	14TV37gJdccppu3djqGsr5+Y6y0nPFiToYsudAqmU/SgElU4ofDwMyMLyRFBi+arjHthm3
	zQMcMu/E6gmXpjMSl7DK/G6QtO0lHDU=
Date: Fri, 17 Jul 2026 13:44:33 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [PATCH] blk-iolatency: use spin_lock_irqsave() in
 iolatency_clear_scaling()
To: Leon Hwang <leon.hwang@linux.dev>, Jens Axboe <axboe@kernel.dk>
References: <20260717040653.1999364-1-cui.tao@linux.dev>
 <418d9e2a-30b8-47d8-b919-6a777e0993f9@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <418d9e2a-30b8-47d8-b919-6a777e0993f9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/17 13:36, Leon Hwang 写道:
> On 17/7/26 12:06, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> child_lat.lock is acquired with spin_lock_irqsave() in both
>> iolatency_check_latencies() (called from the blkcg_iolatency_done_bio()
>> softirq path) and blkiolatency_timer_fn() (timer softirq).
>> iolatency_clear_scaling() instead uses a plain spin_lock(), which only
>> happens to be safe because both of its callers enter with interrupts
>> already disabled:
>>
>>   * iolatency_set_limit() runs under queue_lock via blkg_conf_prep(),
>>     which returns with the lock held and interrupts disabled;
>>   * iolatency_pd_offline() runs under queue_lock from blkg_destroy() and
>>     blkcg_deactivate_policy(), both of which take it with spin_lock_irq().
>>
>> Take the lock with spin_lock_irqsave()/spin_unlock_irqrestore() so the
>> locking is self-contained and consistent with the other two sites, instead
>> of relying on an undocumented caller precondition. No functional change.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>  block/blk-iolatency.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
>> index cef02b6c5fa9..68b74258cd95 100644
>> --- a/block/blk-iolatency.c
>> +++ b/block/blk-iolatency.c
>> @@ -811,16 +811,17 @@ static void iolatency_clear_scaling(struct blkcg_gq *blkg)
>>  	if (blkg->parent) {
>>  		struct iolatency_grp *iolat = blkg_to_lat(blkg->parent);
>>  		struct child_latency_info *lat_info;
>> +		unsigned long flags;
>>  		if (!iolat)
>>  			return;
>>  
>>  		lat_info = &iolat->child_lat;
>> -		spin_lock(&lat_info->lock);
>> +		spin_lock_irqsave(&lat_info->lock, flags);
> 
> Better to use guard(spinlock_irqsave)(&lat_info->lock).
> 

Good point, thanks.  Will switch to guard(spinlock_irqsave)() in v2.

Thanks,
Tao
> Thanks,
> Leon
> 
>>  		atomic_set(&lat_info->scale_cookie, DEFAULT_SCALE_COOKIE);
>>  		lat_info->last_scale_event = 0;
>>  		lat_info->scale_grp = NULL;
>>  		lat_info->scale_lat = 0;
>> -		spin_unlock(&lat_info->lock);
>> +		spin_unlock_irqrestore(&lat_info->lock, flags);
>>  	}
>>  }
>>  
> 

