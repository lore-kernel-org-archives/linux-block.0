Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E57081A;
	Mon, 11 Aug 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754874020; cv=none; b=mK6UzdjnWCwIXqAiKg5OdFnhoXDG4jWm8JzokMk1Cteyx1Sy9HMzBTgv53MJCdKloLV7O1gLgYMPqOamYFqiPhKsBx28+bkVY7XVadlXi0zKJoHDB7ZdyTlpStpReRkZFmQwfe78R6kLn4hU/Sv0L5C+B3aeTsyJc3NrL4iC+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754874020; c=relaxed/simple;
	bh=eIR1n7/khWFT026qVwX/dHdNIhGNnu8XN3QeCgWObMk=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HIuHb9kqvlukBDmBQww60N8PAaUWqMpT/Uw/YuOr98FpRDO3qBz41wqx0ibeK4RtQ/+JkRMPI6+D8HzaOcS7pKpNpzlWnAOlo5X6PENRE543oqOvW07/ytashhiKAGo8Vnnz7/gE/Oxnz6a43qhViPARMufDooTgu+U4smCaoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c0bs4537wzYQtwW;
	Mon, 11 Aug 2025 09:00:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 54CB11A0359;
	Mon, 11 Aug 2025 09:00:07 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3QBFpQJloNzEWDQ--.54664S3;
	Mon, 11 Aug 2025 08:59:23 +0800 (CST)
Subject: Re: [PATCH] block, bfq: remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250809142240.174197-1-rongqianfeng@vivo.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <233497ad-4d0e-2aa0-96ab-fbabdc68bb5e@huaweicloud.com>
Date: Mon, 11 Aug 2025 08:59:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250809142240.174197-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3QBFpQJloNzEWDQ--.54664S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4rurW8Aw4kWry3Gw4xXrb_yoWDurbEq3
	WkJF1FvF1DZry2vrsYvFn5ZF95taySqr1xGF45Jr43ZF15XanYk39I9r4rAF4fWrs7GFsI
	kF9Yqa43JryUWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/09 22:22, Qianfeng Rong Ð´µÀ:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>   block/bfq-iosched.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 3bf76902f07f..db0ae65186ec 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5848,7 +5848,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
>   	}
>   
>   	bfqq = kmem_cache_alloc_node(bfq_pool,
> -				     GFP_NOWAIT | __GFP_ZERO | __GFP_NOWARN,
> +				     GFP_NOWAIT | __GFP_ZERO,
Can you also combine this line with the one above?

Otherwise LGTM. Feel free to add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

>   				     bfqd->queue->node);
>   
>   	if (bfqq) {
> 

