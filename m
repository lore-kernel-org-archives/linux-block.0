Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526021519F;
	Thu, 13 Feb 2025 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444696; cv=none; b=NEwRfQ/xbaQdGyqLVyUhiD6/XqXhudlTSzb0U3ln3LHYaN97DqXqxXnE4zzsso1ouSKqr4j7zJdrVhBol1m0Rbpnzic1mUGXRC2tWusnNVs3O+qR9krQiUecD7SDz7yWHf/9aw24zQ4eoiP+KMl7DzHZm9mVX7wyANQfSr5F+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444696; c=relaxed/simple;
	bh=PzBfe4atz6vSeVyd/u+d7DpT2Rrcjc+RgX6K/j/Og7I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JbuorxMCkmaxiL871lkJpgCLQGI4u0h6OvQYoGuOoiJj4DbEnxOSBl3YizRF5bp17jZi+nC8Qxlt6F2q31ehBok6bUQuSuivJyZoS5O+iSmkHKy/HxCSyBYZL1BUClWbuQ2XaiJW3acL+yGn9rhBu1rir3XbRD8L9Az4FIPKt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ytskr0xNwz4f3kvq;
	Thu, 13 Feb 2025 19:04:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DB6FF1A0BDF;
	Thu, 13 Feb 2025 19:04:42 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7J0a1nLFToDg--.14503S3;
	Thu, 13 Feb 2025 19:04:42 +0800 (CST)
Subject: Re: [PATCH v2 1/2] blk-wbt: Fix some comments
To: Tang Yizhou <yizhou.tang@shopee.com>, yukuai1@huaweicloud.com,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250213100611.209997-1-yizhou.tang@shopee.com>
 <20250213100611.209997-2-yizhou.tang@shopee.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <76cd73b1-52f5-1f19-ae37-c856a765ebc4@huaweicloud.com>
Date: Thu, 13 Feb 2025 19:04:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250213100611.209997-2-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7J0a1nLFToDg--.14503S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AryDKr1fCry8GFW7ZF1UZFb_yoW8XF18p3
	Z2kw1UuF1xKFWxuwnrXa9rZr4fGF4rGF18tryxWrnIqr13Wr1Fvan0kr40vr4FvrWfWr4x
	X3Wj9F95AF48u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/02/13 18:06, Tang Yizhou Ð´µÀ:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> wbt_wait() no longer uses a spinlock as a parameter. Update the function
> comments accordingly.
> 
> RWB_UNKNOWN_BUMP is used when we gradually adjust scale_steps toward the
> center state, which is a value of 0.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>   block/blk-wbt.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 6dfc659d22e2..8b73c0c11aec 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -136,8 +136,9 @@ enum {
>   	RWB_MIN_WRITE_SAMPLES	= 3,
>   
>   	/*
> -	 * If we have this number of consecutive windows with not enough
> -	 * information to scale up or down, scale up.
> +	 * If we have this number of consecutive windows without enough
> +	 * information to scale up or down, slowly return to center state
> +	 * (step == 0).
>   	 */
>   	RWB_UNKNOWN_BUMP	= 5,
>   };
> @@ -638,11 +639,7 @@ static void wbt_cleanup(struct rq_qos *rqos, struct bio *bio)
>   	__wbt_done(rqos, flags);
>   }
>   
> -/*
> - * May sleep, if we have exceeded the writeback limits. Caller can pass
> - * in an irq held spinlock, if it holds one when calling this function.
> - * If we do sleep, we'll release and re-grab it.
> - */
> +/* May sleep, if we have exceeded the writeback limits. */
>   static void wbt_wait(struct rq_qos *rqos, struct bio *bio)
>   {
>   	struct rq_wb *rwb = RQWB(rqos);
> 

