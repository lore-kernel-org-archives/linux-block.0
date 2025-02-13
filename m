Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224326B2C3;
	Thu, 13 Feb 2025 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445408; cv=none; b=fGf+zayA1RRi9QiDUMgU8Gjh0deFK2diQeMRv/HBuFDZMHRRfIF5PK5F0pWKKNB7KRcpJBWnZTKdE5iiTSK75wb8QFs1jMphq3ih6bk9SWfOVR9TpwvzH1vXSdjvNb1Ae5Q5/p2B+6Pad9h8yzHQ5bWZu9iPyuLNkhy6Z8nUOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445408; c=relaxed/simple;
	bh=HIOVjcEv+ZGkw7f45KBkYZaWuM7soKabY6Ed0gbXGbE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I03cTnPA/Xgjf/x3Mxz7NMHUsi4tRX4xXw+sg5qF5j4lLMd4GnMKPZHDZZiG1TKOWNNlOgK3rwaTQApXKqirjv5XpAhvrt8fx3FLNb5AigD4qd284g7Dz7S8toiZRn2QURvPrFE2WD+/Au897qLBf7A+TvwSkvuVs+wwcRtT/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ytt0q0PTRz4f3jsy;
	Thu, 13 Feb 2025 19:16:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 278191A0ACF;
	Thu, 13 Feb 2025 19:16:43 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHq1+Z1K1nox_pDg--.15280S3;
	Thu, 13 Feb 2025 19:16:43 +0800 (CST)
Subject: Re: [PATCH v2 2/2] blk-wbt: Cleanup a comment in wb_timer_fn
To: Tang Yizhou <yizhou.tang@shopee.com>, yukuai1@huaweicloud.com,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250213100611.209997-1-yizhou.tang@shopee.com>
 <20250213100611.209997-3-yizhou.tang@shopee.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <70741bf4-1d1f-e017-7c76-8b7e3b1d9203@huaweicloud.com>
Date: Thu, 13 Feb 2025 19:16:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250213100611.209997-3-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq1+Z1K1nox_pDg--.15280S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4ruFW8KrWUKFyrAFW8WFg_yoWkGwcEg3
	97JFn7WF1DAr47u3ZF9F1rGFW8KwsrAw4UWrWrKasxJa4xXwn29ws5tF13WayfXF4UWrnx
	Krn8ZF1xCry0qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbPl1PUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/02/13 18:06, Tang Yizhou Ð´µÀ:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> The original comment contains a grammatical error. Rewrite it into a more
> easily understandable sentence.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>   block/blk-wbt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Personally, I don't think this patch is necessary, people can still
understand with this error. I'm not expecting a seperate patch :(

Thanks,
Kuai

> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 8b73c0c11aec..f1754d07f7e0 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -447,9 +447,9 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
>   		break;
>   	case LAT_UNKNOWN_WRITES:
>   		/*
> -		 * We started a the center step, but don't have a valid
> -		 * read/write sample, but we do have writes going on.
> -		 * Allow step to go negative, to increase write perf.
> +		 * We don't have a valid read/write sample, but we do have
> +		 * writes going on. Allow step to go negative, to increase
> +		 * write performance.
>   		 */
>   		scale_up(rwb);
>   		break;
> 

