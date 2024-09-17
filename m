Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C912F59C
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557704; cv=none; b=rtYJSbnFAzM7PD6u11ksx9VSOab8CcUdFilp0tyLAkMTYANB9T+qtk4aer4keRnhqIEbY8/AsmfNVfzIevpBoCZDmedXFWG+T/7olEy/DwAWLC58nHUCFe8cQqSdsGNk/OBkps9l3m9zutsX5SwowUvJU4ezojJVWBXeKhe/nok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557704; c=relaxed/simple;
	bh=Yc6LMwW6wn3czvbAz0Noq7OXKo67ZvX2OXKfW2cBU4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPlgs/bGloKMxWUXW72flRwLpLUPvYllAKO7LimZZlca4egGYdBhgR6pKjd1fG7udr/ufn/c2+uwwSH0CoAcRToTNXN9o3uT45AfvH8TTlpJYMOyzexyWVXif6jPTV2EoAQbRwMEQHGoh3+sTU3rCnKvmv5wCyfQfArz5YXcEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CQN9y4Ox; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CQN9y4Ox"
Message-ID: <c0e09078-fa89-4dc7-9eab-415e19f22efe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726557699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08yodzFVAN0+1HpjJ2vMO2w6hxWLmIPOfb0AxTJshDI=;
	b=CQN9y4OxdzH/1dtbTuk0FpIlXajU5OjkgqKdIdOEaj062n3Krmgc4Iu33i7Y+SJE2eweDO
	ixP1bMxCcFG2aMj6JiNW3dXwueHh7Hh/jyEwRE/SWFUNLiI9zQzu9y7mdgC353JuDWdlMr
	7pv6bV5mEqoCmmgq+7KaFNhBoMMVmVs=
Date: Tue, 17 Sep 2024 15:21:02 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] nullb: Adjust device size calculation in null_alloc_dev()
To: Aleksandr Mishin <amishin@t-argos.ru>, Shaohua Li <shli@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 John Garry <john.g.garry@oracle.com>, Yu Kuai <yukuai3@huawei.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240917070729.15752-1-amishin@t-argos.ru>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240917070729.15752-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/9/17 15:07, Aleksandr Mishin 写道:
> In null_alloc_dev() device size is a subject to overflow because 'g_gb'
> (which is module parameter, may have any value and is not validated
> anywhere) is not cast to a larger data type before performing arithmetic.
>
> Cast 'g_gb' to unsigned long to prevent overflow.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 2984c8684f96 ("nullb: factor disk parameters")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>   drivers/block/null_blk/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 2f0431e42c49..5edbf9c0aceb 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -762,7 +762,7 @@ static struct nullb_device *null_alloc_dev(void)
>   		return NULL;
>   	}
>   
> -	dev->size = g_gb * 1024;

The member variable size in struct nullb_device is type "unsigned long".

As such, changing g_gb from int to "unsigned long" seems reasonable.

So I am fine with this.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks a lot.

Zhu Yanjun

> +	dev->size = (unsigned long)g_gb * 1024;
>   	dev->completion_nsec = g_completion_nsec;
>   	dev->submit_queues = g_submit_queues;
>   	dev->prev_submit_queues = g_submit_queues;

-- 
Best Regards,
Yanjun.Zhu

