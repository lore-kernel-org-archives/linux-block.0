Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF93F4E9
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TD6qC3m21z4f3kKV
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 17:51:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9D7AF1A0E81
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 17:51:37 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgC3iBEoAKVlV36bAw--.37374S2;
	Mon, 15 Jan 2024 17:51:37 +0800 (CST)
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
 Gabriel Krisman Bertazi <krisman@suse.de>,
 Chengming Zhou <zhouchengming@bytedance.com>, Jan Kara <jack@suse.cz>
References: <20230721095715.232728-1-ming.lei@redhat.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <8e1571ed-cc9d-c674-64e1-756c57526df0@huaweicloud.com>
Date: Mon, 15 Jan 2024 17:51:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230721095715.232728-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgC3iBEoAKVlV36bAw--.37374S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArWfWw43Kw4UZw1ktryUGFg_yoW5XF4fpr
	429FnrCFsYqr42k397JryUZa4rKw4kGrZxKr1fta4Fkr45tr9aqr4fKFs0kFsxuFZ5Ca9x
	AF4jg343Gw15Xa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 7/21/2023 5:57 PM, Ming Lei wrote:
> From: David Jeffery <djeffery@redhat.com>
> 
> Current code supposes that it is enough to provide forward progress by just
> waking up one wait queue after one completion batch is done.
> 
> Unfortunately this way isn't enough, cause waiter can be added to
> wait queue just after it is woken up.
> 
Sorry for missed this. The change looks good and makes code simpler. But the
issue is not supposed to heppen in real world.
> Follows one example(64 depth, wake_batch is 8)
> 
> 1) all 64 tags are active
> 
> 2) in each wait queue, there is only one single waiter
> 
> 3) each time one completion batch(8 completions) wakes up just one waiter in each wait
> queue, then immediately one new sleeper is added to this wait queue
> 
> 4) after 64 completions, 8 waiters are wakeup, and there are still 8 waiters in each
> wait queue>
As we only wait when all tags are consumed (After sbitmap_prepare_to_wait,
we will try sbitmap_queue_get before sleep), there will be 64 active tags again
when any new sleeper is added. Then the menthioned issue should not exist.
If there was no any gain with old way to wakeup, this looks good. Otherwise
we may need to reconsider this.
Wish this helps, thanks!
> 5) after another 8 active tags are completed, only one waiter can be wakeup, and the other 7
> can't be waken up anymore.
> 
> Turns out it isn't easy to fix this problem, so simply wakeup enough waiters for
> single batch.
> 
> Cc: David Jeffery <djeffery@redhat.com>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: Gabriel Krisman Bertazi <krisman@suse.de>
> Cc: Chengming Zhou <zhouchengming@bytedance.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  lib/sbitmap.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index eff4e42c425a..d0a5081dfd12 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -550,7 +550,7 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
>  
>  static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>  {
> -	int i, wake_index;
> +	int i, wake_index, woken;
>  
>  	if (!atomic_read(&sbq->ws_active))
>  		return;
> @@ -567,13 +567,12 @@ static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>  		 */
>  		wake_index = sbq_index_inc(wake_index);
>  
> -		/*
> -		 * It is sufficient to wake up at least one waiter to
> -		 * guarantee forward progress.
> -		 */
> -		if (waitqueue_active(&ws->wait) &&
> -		    wake_up_nr(&ws->wait, nr))
> -			break;
> +		if (waitqueue_active(&ws->wait)) {
> +			woken = wake_up_nr(&ws->wait, nr);
> +			if (woken == nr)
> +				break;
> +			nr -= woken;
> +		}
>  	}
>  
>  	if (wake_index != atomic_read(&sbq->wake_index))
> 

