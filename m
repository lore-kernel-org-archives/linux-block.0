Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F059FD266
	for <linux-block@vger.kernel.org>; Tue,  2 Jan 2024 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T48L36MCrz4f3kng
	for <linux-block@vger.kernel.org>; Tue,  2 Jan 2024 18:32:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2302D1A017D
	for <linux-block@vger.kernel.org>; Tue,  2 Jan 2024 18:32:15 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCn9Qst5pNlwRZBFQ--.58827S3;
	Tue, 02 Jan 2024 18:32:15 +0800 (CST)
Subject: Re: [PATCH] blk-cgroup: fix rcu lockdep warning in blkg_lookup()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Changhui Zhong <czhong@redhat.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231219012833.2129540-1-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d067baba-e718-76c1-807f-feb169bd0e71@huaweicloud.com>
Date: Tue, 2 Jan 2024 18:32:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231219012833.2129540-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCn9Qst5pNlwRZBFQ--.58827S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWrXry7Ar43Wr1rCFykKrg_yoW8CF4Upr
	4qgF1rCr1Igr4UZF4F9a47Xry0vw4kWrW5GrZ5Kws0kr4xuFn7ZF15Zr95Xr4FvFZ3A3yD
	XFy5JryDCw1j93JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2023/12/19 9:28, Ming Lei Ð´µÀ:
> blkg_lookup() is called with either queue_lock or rcu read lock, so
> use rcu_dereference_check(lockdep_is_held(&q->queue_lock)) for
> retrieving 'blkg', which way models the check exactly for covering
> queue lock or rcu read lock.
> 
> Fix lockdep warning of "block/blk-cgroup.h:254 suspicious rcu_dereference_check() usage!"
> from blkg_lookup().
> 
> Tested-by: Changhui Zhong <czhong@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-cgroup.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index fd482439afbc..b927a4a0ad03 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -252,7 +252,8 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
>   	if (blkcg == &blkcg_root)
>   		return q->root_blkg;
>   
> -	blkg = rcu_dereference(blkcg->blkg_hint);
> +	blkg = rcu_dereference_check(blkcg->blkg_hint,
> +			lockdep_is_held(&q->queue_lock));

This patch itself is correct, and in fact this is a false positive
warning.

I noticed that commit 83462a6c971c ("blkcg: Drop unnecessary RCU read
[un]locks from blkg_conf_prep/finish()") drop rcu_read_lock/unlock()
because 'queue_lock' is held. This is correct, however you add this back
for tg_conf_updated() later in commit 27b13e209ddc ("blk-throttle: fix
lockdep warning of "cgroup_mutex or RCU read lock required!"") because
rcu_read_lock_held() from blkg_lookup() is triggered. And this patch is
again another use case cased by commit 83462a6c971c.

I just wonder, with the respect of rcu implementation, is it possible to
add preemptible() check directly in rcu_read_lock_held() to bypass all
this kind of false positive warning?

Thanks,
Kuai

>   	if (blkg && blkg->q == q)
>   		return blkg;
>   
> 

