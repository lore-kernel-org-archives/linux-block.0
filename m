Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99A1C8FC3;
	Fri,  6 Sep 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618154; cv=none; b=hCAePXywR01wvXw/7c3qN93kmzMFgJ0PY9SAlH1j4DVP0PWMwgxU/4l/+ajGfUJZjSgrUzDmPut9BOI6ipv7iLssaF2mx1NshYm8MAt4ZGCP4jzYl5MOgJvs3atcZnkn2S3TwNMDy/D9d55mZjXBQMdckv8Bz9PToENVZNdOcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618154; c=relaxed/simple;
	bh=kCZfqEd1O2JUBD1zEJYLNSVfJ31+1gmfzt3ZOXrSoAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R63JKbCPU/S85V4353BCz7CPi83rhx5MCIthAgwLJBwrCLpRkOWkv2BtZstmVZZlcmbqEEzu4nGQnSftmNY76vtxS0qNmHwGFF+n4FwJY/B6jlagInVxRSuzqNk+XI07KqLJ3mzz8q+FqX4JHb7Tzzeo0xu3J+13otlf0GBrZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOe9+l0S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOe9+l0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781FEC4CEC4;
	Fri,  6 Sep 2024 10:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725618154;
	bh=kCZfqEd1O2JUBD1zEJYLNSVfJ31+1gmfzt3ZOXrSoAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kOe9+l0SPtXq11L6It7D3XSTUmdLaxCkT54sKMTl3STjEDmx0RPxEaGeuoLxG9ogS
	 o/rQlI++E5SETq/g3eEAop9lwETLsaleJVmmpKvOQe7wExMb0uKBHmtjRvirmwIQJD
	 1T+lgFs569YZWJHXRpWaAQa2HiGBr7e+s+BuZifT0gNO7pkYxyEfBSsI0wnUg38FDf
	 J7LOZh7OndiQ03DODd8LrSkMwnXDKsv3AfpXW/3UArlELD2iJEcBJK8BzRqhBvWTFZ
	 zbc1T5sT98MxTyiyP6/W7No32XWDI8aJigmPk3jrKT73OnPOtZiPi8+6lmbNw9+g0s
	 fatq6u1TV+Udw==
Message-ID: <89639b91-f80e-4794-98a6-2ad896c372b4@kernel.org>
Date: Fri, 6 Sep 2024 19:22:32 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] block: move non sync requests complete flow to softirq
To: ZhangHui <zhanghui31@xiaomi.com>, axboe@kernel.dk, bvanassche@acm.org,
 ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240906095414.386388-1-zhanghui31@xiaomi.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240906095414.386388-1-zhanghui31@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 18:54, ZhangHui wrote:
> From: zhanghui <zhanghui31@xiaomi.com>
> 
> Currently, for a controller that supports multiple queues, like UFS4.0,
> the mq_ops->complete is executed in the interrupt top-half. Therefore, 
> the file system's end io is executed during the request completion process,
> such as f2fs_write_end_io on smartphone.
> 
> However, we found that the execution time of the file system end io
> is strongly related to the size of the bio and the processing speed
> of the CPU. Because the file system's end io will traverse every page
> in bio, this is a very time-consuming operation.
> 
> We measured that the 80M bio write operation on the little CPU will
> cause the execution time of the top-half to be greater than 100ms,
> which will undoubtedly affect interrupt response latency.
> 
> Let's fix this issue by moving non sync requests completion to softirq
> context, and keeping sync requests completion in the IRQ top-half context.
> 
> Signed-off-by: zhanghui <zhanghui31@xiaomi.com>
> ---
> Changes in v5:
> - modify the commit log
> - remove unnecessary variable and add comment
> 
> Changes in v4:
> - fix commit log from "scheduling efficiency" to "interrupt response latency"
> 
> Changes in v3:
> - modify op_is_sync to rq_is_sync
> 
> Changes in v2:
> - fix build warning
> ---
>  block/blk-mq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e3c3c0c21b55..45e4d255ea3b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1210,7 +1210,11 @@ bool blk_mq_complete_request_remote(struct request *rq)
>  		return true;
>  	}
>  
> -	if (rq->q->nr_hw_queues == 1) {
> +	/*
> +	 * To reduce the execution time in the IRQ top-half,
> +	 * move non-sync request completions to softirq context.
> +	 */
> +	if ((rq->q->nr_hw_queues == 1) || !rq_is_sync(rq)) {

I did mention that you do not need the inner parenthesis here...

>  		blk_mq_raise_softirq(rq);
>  		return true;
>  	}

-- 
Damien Le Moal
Western Digital Research

