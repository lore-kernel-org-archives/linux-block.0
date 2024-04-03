Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300413666C
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140547; cv=none; b=XUuQFQbgHhy8qzvYLffu99JU+WteLVYK87WcYOn6Wx1i7Kxp7GJECcr2/91yrZVIBWotULbi5UooE/7Utv2pP5Cy4BGIOvGFtnlGCQW12FvR+C91AK/yQxMZ4qksLSCQ6EivCcpRh+tUohccQDjJKmSr8F3YPTTpUGyQaLeI55g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140547; c=relaxed/simple;
	bh=eimD9Lt4Yg4QM+lDgjczBjCLI5AiAFAb+X243EbZMAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=amCdfrni1jUfMcY2oVgcLl1WFq31aX9anvCxLTIPp77mFklTTyxtw/2GlJhwi2BELdAwoK532yYqZtO1h8/IMB43cmkJU/fjCmVztWVvIoGLSFuMipk/qlTlWlaMb/F4EmkPdogpEiBv6vjX7yOg9Zw0TfyxJmBkGRA7DE9UIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V8h0T1M5Mz1h5GB;
	Wed,  3 Apr 2024 18:32:57 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B614118001A;
	Wed,  3 Apr 2024 18:35:42 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 18:35:42 +0800
Message-ID: <8ae59f89-403d-4843-9766-c40fcb75c086@huawei.com>
Date: Wed, 3 Apr 2024 18:35:41 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-cgroup: use group allocation/free of per-cpu counters
 API
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Dennis Zhou <dennis@kernel.org>
CC: <linux-block@vger.kernel.org>
References: <20240325035955.50019-1-wangkefeng.wang@huawei.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240325035955.50019-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Hi Jens, kindly ping...

On 2024/3/25 11:59, Kefeng Wang wrote:
> Use group allocation/free of per-cpu counters api to accelerate
> blkg_rwstat_init/exit() and simplify code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   block/blk-cgroup-rwstat.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
> index 3304e841df7c..a55fb0c53558 100644
> --- a/block/blk-cgroup-rwstat.c
> +++ b/block/blk-cgroup-rwstat.c
> @@ -9,25 +9,19 @@ int blkg_rwstat_init(struct blkg_rwstat *rwstat, gfp_t gfp)
>   {
>   	int i, ret;
>   
> -	for (i = 0; i < BLKG_RWSTAT_NR; i++) {
> -		ret = percpu_counter_init(&rwstat->cpu_cnt[i], 0, gfp);
> -		if (ret) {
> -			while (--i >= 0)
> -				percpu_counter_destroy(&rwstat->cpu_cnt[i]);
> -			return ret;
> -		}
> +	ret = percpu_counter_init_many(rwstat->cpu_cnt, 0, gfp, BLKG_RWSTAT_NR);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < BLKG_RWSTAT_NR; i++)
>   		atomic64_set(&rwstat->aux_cnt[i], 0);
> -	}
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(blkg_rwstat_init);
>   
>   void blkg_rwstat_exit(struct blkg_rwstat *rwstat)
>   {
> -	int i;
> -
> -	for (i = 0; i < BLKG_RWSTAT_NR; i++)
> -		percpu_counter_destroy(&rwstat->cpu_cnt[i]);
> +	percpu_counter_destroy_many(rwstat->cpu_cnt, BLKG_RWSTAT_NR);
>   }
>   EXPORT_SYMBOL_GPL(blkg_rwstat_exit);
>   
