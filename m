Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD72B9B5;
	Tue, 17 Sep 2024 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557671; cv=none; b=TnLAdkmajfVCY4/4GzjT3y+MRKuD6ucKtaSdYVArTlqfQ6eYS+p4yQrAD4pVXNQXtd78LIWLKAzSB7CjR4+ngrAMDgvfcwIq9y/81Hw/WhrzjMGHAlafnelsn3Xt2YIL7HMXiyALtZKkPAMIikKDa3bulyOexdOeE7n1KjSA98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557671; c=relaxed/simple;
	bh=/QFbxhZjOF8BpjWHO7vDowst0ZnfkoIqzolAjuUxYAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVaHnpx8GTphnyOKXw4tw6YkdSUXE7Ifx3ujHZQB7X21JSfboQVHyja22ZzuC4/5XLYcwiMvAnrW8Bx0Pt0Ami/ddCrij4mgZ1RGhLfDG9VeSxksQ+sTr1aoRSNQfcUJDS5HqI3F07rmnGGF4BqJeeO2ThpaMZ3Caw5609g2FuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQP5CRva; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQP5CRva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD278C4CEC6;
	Tue, 17 Sep 2024 07:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726557670;
	bh=/QFbxhZjOF8BpjWHO7vDowst0ZnfkoIqzolAjuUxYAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uQP5CRvaBXDL1kZUR/pnYrRzBH6TKxuc9Xe4asZ4Lh+7AUC179Dm6NbeHr0PCLJQf
	 fIaandC0OBKuz4SjQbxNG/TLiuusWKIggG8NSLJbEWU+vnmqe1nN2+o4XNiFLSndZd
	 R1BNRYjX8ympLOi502eeIlGFiVlQWEDswaBPI/T3+rTevisft4GXAI5f5Pxzblc2y2
	 rAdTrJ8SttYQIGF2+I3LSKWKSk2qa01aN6o/PQ9xzoyEwLWPuNebmUq7Bw6KyOCKkq
	 DJKtRvQgKOxRMurVrxwVWyddVNg9Yzur+Zwf6TpGRq9n/cwmAGjMLWboMY86xREb/m
	 RSs/uEEZ+m2xg==
Message-ID: <c50f7ca2-8f3d-4b7e-bd50-1957e4a09b7b@kernel.org>
Date: Tue, 17 Sep 2024 09:21:05 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nullb: Adjust device size calculation in null_alloc_dev()
To: Aleksandr Mishin <amishin@t-argos.ru>, Shaohua Li <shli@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 John Garry <john.g.garry@oracle.com>, Yu Kuai <yukuai3@huawei.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240917070729.15752-1-amishin@t-argos.ru>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240917070729.15752-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/17 16:07, Aleksandr Mishin wrote:
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
>  drivers/block/null_blk/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 2f0431e42c49..5edbf9c0aceb 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -762,7 +762,7 @@ static struct nullb_device *null_alloc_dev(void)
>  		return NULL;
>  	}
>  
> -	dev->size = g_gb * 1024;
> +	dev->size = (unsigned long)g_gb * 1024;

This still does not prevent overflows... So what about doing a proper check ?

>  	dev->completion_nsec = g_completion_nsec;
>  	dev->submit_queues = g_submit_queues;
>  	dev->prev_submit_queues = g_submit_queues;

-- 
Damien Le Moal
Western Digital Research

