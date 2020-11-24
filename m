Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2944EC2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72A220674
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbgKXOXJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:23:09 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2147 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731656AbgKXOXI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 09:23:08 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CgR5V2j7rz67H9R;
        Tue, 24 Nov 2020 22:21:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 24 Nov 2020 15:23:06 +0100
Received: from [10.210.169.36] (10.210.169.36) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 24 Nov 2020 14:23:05 +0000
Subject: Re: [PATCH v2 2/4] sbitmap: remove swap_lock
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     <linux-kernel@vger.kernel.org>
References: <cover.1606058975.git.asml.silence@gmail.com>
 <488177c02dccda60c5e8af2e53156c42b7f1acc0.1606058975.git.asml.silence@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <17b6011c-b519-3332-e9b7-de36109db85a@huawei.com>
Date:   Tue, 24 Nov 2020 14:22:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <488177c02dccda60c5e8af2e53156c42b7f1acc0.1606058975.git.asml.silence@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.36]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/11/2020 15:35, Pavel Begunkov wrote:
> map->swap_lock protects map->cleared from concurrent modification,
> however sbitmap_deferred_clear() is already atomically drains it, so
> it's guaranteed to not loose bits on concurrent
> sbitmap_deferred_clear().
> 
> A one threaded tag heavy test on top of nullbk showed ~1.5% t-put
> increase, and 3% -> 1% cycle reduction of sbitmap_get() according to perf.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>   include/linux/sbitmap.h |  5 -----
>   lib/sbitmap.c           | 14 +++-----------
>   2 files changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index e40d019c3d9d..74cc6384715e 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -32,11 +32,6 @@ struct sbitmap_word {
>   	 * @cleared: word holding cleared bits
>   	 */
>   	unsigned long cleared ____cacheline_aligned_in_smp;
> -
> -	/**
> -	 * @swap_lock: Held while swapping word <-> cleared
> -	 */
> -	spinlock_t swap_lock;
>   } ____cacheline_aligned_in_smp;
>   
>   /**
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index c1c8a4e69325..4fd877048ba8 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -15,13 +15,9 @@
>   static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>   {
>   	unsigned long mask, val;
> -	bool ret = false;
> -	unsigned long flags;
>   
> -	spin_lock_irqsave(&map->swap_lock, flags);
> -
> -	if (!map->cleared)
> -		goto out_unlock;
> +	if (!READ_ONCE(map->cleared))
> +		return false;

So if we race with another cpu, won't the 2nd cpu see that the mask is 0 
returned from the xchg (not shown)? If so, it's odd to continue to do 
the CAS - or atomic not, from later patch - on a mask of 0.

Thanks,
John

>   
>   	/*
>   	 * First get a stable cleared mask, setting the old mask to 0.
> @@ -35,10 +31,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>   		val = map->word;
>   	} while (cmpxchg(&map->word, val, val & ~mask) != val);
>   
> -	ret = true;
> -out_unlock:
> -	spin_unlock_irqrestore(&map->swap_lock, flags);
> -	return ret;
> +	return true;
>   }
>   
>   int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
> @@ -80,7 +73,6 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>   	for (i = 0; i < sb->map_nr; i++) {
>   		sb->map[i].depth = min(depth, bits_per_word);
>   		depth -= sb->map[i].depth;
> -		spin_lock_init(&sb->map[i].swap_lock);
>   	}
>   	return 0;
>   }
> 

