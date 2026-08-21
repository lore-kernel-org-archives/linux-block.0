Received: from mta0.migadu.com (out-21.mta0.migadu.com [91.218.175.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686703148A7
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280595; cv=none; b=TnyrKhx3Uq17ubFuYvxN0pVmJqhvdJb724uQ5rFF669vWBUzjuNT+X8I6yBiOJFDoRvzH3tbowvwzW5SuXYmzi8VV77m7of3lomR5lbuVQLnaSuPzR2nzhAS9Im7Ug9wFX58T72tsZsHJhQZMNvt4QXmfVkgEoWLG1seOHM1PEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280595; c=relaxed/simple;
	bh=e2HPCQmk44iRbc7RKAXYq285pp53Adr8C6IxggLNowA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MYCIts9m7o0zKlT79r2II5b+Mtnn3tVURYo7bMZwgeJcz+Taae7eIVi1k+bb5OpDSDM10upPbI0HBUb72aoEJfwyORqg1rNSQyFXzvt116+0bJch6ce01fMXyeyM+oQRYF7K2sU3VPRX+v1wJk2O3QVQSJsEy/KNa6n1Y0pBUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WU2TLWnj; arc=none smtp.client-ip=91.218.175.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WU2TLWnj"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e2HPCQmk44iRbc7RKAXYq285pp53Adr8C6IxggLNowA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787280591; v=1; x=1787885391;
 b=WU2TLWnje19mW37y4oIZvvC470igux/PfcCZDGIkyi5ZCKykAg25l+wTYSpUp6v8NQ/o8q7V
 ADtwc9fksWG7aERZd3ce4R4GcQ5w/KCS4GArrWl3WlVYrx4dIhFvSkabvm8m5josgysp5FOdSWv
 EN0JLieybaInSIw7SFbSEBtM=
X-Envelope-To: linux-block@vger.kernel.org
Received: from [192.168.110.173] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 8c07abb10e4e858f;
	Fri, 21 Aug 2026 02:49:51 +0000
X-Mizu-Trace-ID: 8c07abb10e4e858f
X-Migadu-Flow: FLOW_OUT
Message-ID: <f17cab7f-ee67-4d9c-95f0-01c28b4a520b@linux.dev>
Date: Fri, 21 Aug 2026 10:49:45 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai@fygo.io
Subject: Re: [PATCH v2] blk-wbt: Always change enable_state to MANUAL when
 setting latency
To: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk,
 guzebing1612@gmail.com
References: <20260820161514.371181-1-yizhou.tang@shopee.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260820161514.371181-1-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/21 00:15, Tang Yizhou 写道:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> Commit 1e56f30a73f3 ("block: Make WBT latency writes honor enable
> state") compares only the boolean enabled state in the no-op check.
> Writing the current latency value while WBT is in WBT_STATE_ON_DEFAULT
> is therefore still skipped, and enable_state is not changed to
> WBT_STATE_ON_MANUAL. A subsequent elevator switch to BFQ then disables
> WBT through wbt_disable_default(), silently discarding the explicit
> sysfs setting:
> 
>   # enable_state = WBT_STATE_ON_DEFAULT, min_lat_nsec = 2000000
>   echo 2000 > /sys/block/nullb0/queue/wbt_lat_usec  # skipped as a no-op
>   echo bfq > /sys/block/nullb0/queue/scheduler
>   cat /sys/block/nullb0/queue/wbt_lat_usec          # 0, WBT disabled
> 
> Skip the update only if the stored latency matches and enable_state
> already equals the exact target state: WBT_STATE_ON_MANUAL for a
> non-zero value, WBT_STATE_OFF_MANUAL for zero.
> 
> A write that passes the check then reaches wbt_set_min_lat(), which
> performs the actual transition to the MANUAL state.
> 
> Rename the helper to wbt_lat_changed() to improve readability.
> 
> Fixes: 1e56f30a73f3 ("block: Make WBT latency writes honor enable state")
> Reviewed-by: Yu Kuai <yukuai@fygo.io>
> Reviewed-by: Guzebing <guzebing1612@gmail.com>
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
> v2: Pick Yuai and Guzebing's Reviewed-by tag.
>  block/blk-wbt.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 953d400fd013..4f12a064286e 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -813,7 +813,14 @@ static void wbt_queue_depth_changed(struct rq_qos *rqos)
>  	wbt_update_limits(RQWB(rqos));
>  }
>  
> -static bool wbt_set_lat_changed(struct request_queue *q, u64 val)
> +/*
> + * Return true if writing @val would change the WBT state:
> + * 1) @val differs from the stored min_lat_nsec, or
> + * 2) @val matches, but enable_state is not the corresponding manual state
> + *    (WBT_STATE_ON_MANUAL for non-zero @val, WBT_STATE_OFF_MANUAL for 0),
> + *    so the write still has to update enable_state.
> + */
> +static bool wbt_lat_changed(struct request_queue *q, u64 val)
>  {
>  	struct rq_qos *rqos = wbt_rq_qos(q);
>  	struct rq_wb *rwb;
> @@ -825,7 +832,8 @@ static bool wbt_set_lat_changed(struct request_queue *q, u64 val)
>  	if (rwb->min_lat_nsec != val)
>  		return true;
>  
> -	return rwb_enabled(rwb) != !!val;
> +	return rwb->enable_state !=
> +	       (val ? WBT_STATE_ON_MANUAL : WBT_STATE_OFF_MANUAL);
>  }
>  
>  static void wbt_exit(struct rq_qos *rqos)
> @@ -1021,7 +1029,7 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
>  		val *= 1000ULL;
>  
>  	mutex_lock(&disk->rqos_state_mutex);
> -	if (!wbt_set_lat_changed(q, val)) {
> +	if (!wbt_lat_changed(q, val)) {
>  		mutex_unlock(&disk->rqos_state_mutex);
>  		goto out;
>  	}

Reviewed-by: Tao Cui <cuitao@kylinos.cn>


