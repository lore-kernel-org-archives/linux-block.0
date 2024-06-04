Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E242209B;
	Tue,  4 Jun 2024 07:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484497; cv=none; b=VMQ29rNZ9W0tcpMo1KjUdrT0wCoVnwi6/Xp2HCBsMiPEYhr++/xs+ZBSWwU5BzYOQg7f2jif/2gi3winuy4MpGsSPTQLH9skz1KYZwVUFB6hTwou9V/S5CcfHt7U1bu5gCYkZ5v0J5AL7acWFJPrcQgt0yj9q8eA3ht2ndL++N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484497; c=relaxed/simple;
	bh=PYwQcc4hO1AFYN/zQdNCGfsqlcAjCdxu5bhH8nLjHv0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QVujDSvBLXFvki4oV5Ho8+YqLVPpSKZGaSadAeqplflO7e1VPacuQ/Zrsbax1GVeST20NT78enrZIf46H8BPifKjwfcUtJx1DGhBoKHxOxNPtsky+KPyR5MQKPSC9y1gFS4PIz1+bS35lxBUQPXynHyzXodncip29avoPWMpDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VthMg6H2hz4f3n6k;
	Tue,  4 Jun 2024 15:01:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ED10F1A0184;
	Tue,  4 Jun 2024 15:01:30 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7Ju15mYh0cOg--.37550S3;
	Tue, 04 Jun 2024 15:01:30 +0800 (CST)
Subject: Re: [PATCH -next] blk-wbt: don't throttle swap writes in direct
 reclaim
To: libaokun@huaweicloud.com, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@infradead.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, libaokun1@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240604030522.3686177-1-libaokun@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8b17831e-0132-17af-7ec0-6e05057c3530@huaweicloud.com>
Date: Tue, 4 Jun 2024 15:01:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240604030522.3686177-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7Ju15mYh0cOg--.37550S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFW8Xry5Kr48Cr45uw4Durg_yoW5uw47pr
	43Kas0yFyqvFn7Xws7XayxX3yru3y8Jr43A345Kr1SvrW3Kr13WF4vkw1a9F4UAr97uw42
	gF4Fyry7Jr4avaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/06/04 11:05, libaokun@huaweicloud.com Ð´µÀ:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Now we avoid throttling swap writes by determining whether the current
> process is kswapd (aka current_is_kswapd()), but swap writes can come
> from either kswapd or direct reclaim, so the swap writes from direct
> reclaim will still be throttled.
> 
> When a process holds a lock to allocate a free page, and enters direct
> reclaim because there is no free memory, then it might trigger a hung
> due to the wbt throttling that causes other processes to fail to get
> the lock.
> 
> Both kswapd and direct reclaim set the REQ_SWAP flag, so use REQ_SWAP
> instead of current_is_kswapd() to avoid throttling swap writes. Also
> renamed WBT_KSWAPD to WBT_SWAP and WBT_RWQ_KSWAPD to WBT_RWQ_SWAP.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> ---
>   block/blk-wbt.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 64472134dd26..aaacf2f5b223 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -37,7 +37,7 @@
>   enum wbt_flags {
>   	WBT_TRACKED		= 1,	/* write, tracked for throttling */
>   	WBT_READ		= 2,	/* read */
> -	WBT_KSWAPD		= 4,	/* write, from kswapd */
> +	WBT_SWAP		= 4,	/* write, from swap_writepage() */
>   	WBT_DISCARD		= 8,	/* discard */
>   
>   	WBT_NR_BITS		= 4,	/* number of bits */
> @@ -45,7 +45,7 @@ enum wbt_flags {
>   
>   enum {
>   	WBT_RWQ_BG		= 0,
> -	WBT_RWQ_KSWAPD,
> +	WBT_RWQ_SWAP,
>   	WBT_RWQ_DISCARD,
>   	WBT_NUM_RWQ,
>   };
> @@ -172,8 +172,8 @@ static bool wb_recent_wait(struct rq_wb *rwb)
>   static inline struct rq_wait *get_rq_wait(struct rq_wb *rwb,
>   					  enum wbt_flags wb_acct)
>   {
> -	if (wb_acct & WBT_KSWAPD)
> -		return &rwb->rq_wait[WBT_RWQ_KSWAPD];
> +	if (wb_acct & WBT_SWAP)
> +		return &rwb->rq_wait[WBT_RWQ_SWAP];
>   	else if (wb_acct & WBT_DISCARD)
>   		return &rwb->rq_wait[WBT_RWQ_DISCARD];
>   
> @@ -528,7 +528,7 @@ static bool close_io(struct rq_wb *rwb)
>   		time_before(now, rwb->last_comp + HZ / 10);
>   }
>   
> -#define REQ_HIPRIO	(REQ_SYNC | REQ_META | REQ_PRIO)
> +#define REQ_HIPRIO	(REQ_SYNC | REQ_META | REQ_PRIO | REQ_SWAP)
>   
>   static inline unsigned int get_limit(struct rq_wb *rwb, blk_opf_t opf)
>   {
> @@ -539,13 +539,13 @@ static inline unsigned int get_limit(struct rq_wb *rwb, blk_opf_t opf)
>   
>   	/*
>   	 * At this point we know it's a buffered write. If this is
> -	 * kswapd trying to free memory, or REQ_SYNC is set, then
> +	 * swap trying to free memory, or REQ_SYNC is set, then
>   	 * it's WB_SYNC_ALL writeback, and we'll use the max limit for
>   	 * that. If the write is marked as a background write, then use
>   	 * the idle limit, or go to normal if we haven't had competing
>   	 * IO for a bit.
>   	 */
> -	if ((opf & REQ_HIPRIO) || wb_recent_wait(rwb) || current_is_kswapd())
> +	if ((opf & REQ_HIPRIO) || wb_recent_wait(rwb))
>   		limit = rwb->rq_depth.max_depth;
>   	else if ((opf & REQ_BACKGROUND) || close_io(rwb)) {
>   		/*
> @@ -622,8 +622,8 @@ static enum wbt_flags bio_to_wbt_flags(struct rq_wb *rwb, struct bio *bio)
>   	if (bio_op(bio) == REQ_OP_READ) {
>   		flags = WBT_READ;
>   	} else if (wbt_should_throttle(bio)) {
> -		if (current_is_kswapd())
> -			flags |= WBT_KSWAPD;
> +		if (bio->bi_opf & REQ_SWAP)
> +			flags |= WBT_SWAP;
>   		if (bio_op(bio) == REQ_OP_DISCARD)
>   			flags |= WBT_DISCARD;
>   		flags |= WBT_TRACKED;
> 

