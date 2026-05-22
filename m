Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D4436606A
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458040; cv=none; b=LUVFQ+y6L6mzxT40AyLxoRd3E+OMBDs3HjaGHw/zGysXzzHJVyxKaFksAEVDVXV9cu02ynCM8bpzOdids0jLs6ekEywR0/imtYB5cHN9aMJF9zDPc0P39VxRmeEJINCoC3ngVWtT6i+7U+m/B/CleiX7XrF/tz72dwDSW7Ure+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458040; c=relaxed/simple;
	bh=RmNo5dh/QTmEkdwcuurXUdGvUNVGGNZJdYIVdA1smZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBMoA0vujz6V2+SBPRmINvIzM3yfhumIPfIUHWzrY7t1xvT0hCyGC7GHJgHYz4fzBVTeu1jmFlefHKOLt/z4KPlyLyD364Ay/r6bYdhyfvBNStyJPfzfpyBJYk+qz0P3CttwLN7XgtpdbbbbAmEQT+YuQfnXFUWtfZl3qP7yOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wf5vJSsi; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wf5vJSsi"
Message-ID: <f1d32a66-3012-47d1-aa0b-44bcf273c29d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779458026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxSnp7co5OeY1WYH1TTbRUWf58UGt2Y3upyhixDx34k=;
	b=Wf5vJSsi2bmlwLkMqh3Ji1jvPdWoG3NAlr7fKNHG7IYNNtPlO9LuAX7jDQW1akAzaO5bG6
	wLPIB/DTipvvGm3ma2Wm+uaNm9gY/d2w9s/BVeXS2PSXg4+25kRNAVFnv6HUCHQzaXc1MA
	ShNSJqYGWDI+fx0Dqyrab4muCPxrA1s=
Date: Fri, 22 May 2026 21:53:00 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] block: propagate in_flight to whole disk on partition
 I/O
To: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, hch@lst.de
Cc: yukuai@fnnas.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leon Hwang <leon.huangfu@shopee.com>
References: <20260522131409.261259-1-yizhou.tang@shopee.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260522131409.261259-1-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/22 21:14, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
[...]
> diff --git a/block/blk.h b/block/blk.h
> index b998a7761faf..05099aab6863 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/bio-integrity.h>
>  #include <linux/blk-crypto.h>
> +#include <linux/part_stat.h>
>  #include <linux/lockdep.h>
>  #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
>  #include <linux/sched/sysctl.h>
> @@ -11,6 +12,7 @@
>  #include <xen/xen.h>
>  #include "blk-crypto-internal.h"
>  
> +

NIT: I think this new line is added unintentionally. Should be dropped.

Thanks,
Leon


>  struct elv_change_ctx;
>  
>  /*
> @@ -485,6 +487,26 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
>  		q->last_merge = NULL;
>  }
>  
> +static inline void bdev_inc_in_flight(struct block_device *bdev,
> +				      enum req_op op)
> +{
> +	bool rw = op_is_write(op);
> +
> +	part_stat_local_inc(bdev, in_flight[rw]);
> +	if (bdev_is_partition(bdev))
> +		part_stat_local_inc(bdev_whole(bdev), in_flight[rw]);
> +}
> +
> +static inline void bdev_dec_in_flight(struct block_device *bdev,
> +				      enum req_op op)
> +{
> +	bool rw = op_is_write(op);
> +
> +	part_stat_local_dec(bdev, in_flight[rw]);
> +	if (bdev_is_partition(bdev))
> +		part_stat_local_dec(bdev_whole(bdev), in_flight[rw]);
> +}
> +
>  /*
>   * Internal io_context interface
>   */

