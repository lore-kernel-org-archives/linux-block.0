Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E97F1FDA
	for <linux-block@vger.kernel.org>; Wed,  3 Jan 2024 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4WjX5KTpz4f3nZq
	for <linux-block@vger.kernel.org>; Wed,  3 Jan 2024 09:05:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 65E141A0949
	for <linux-block@vger.kernel.org>; Wed,  3 Jan 2024 09:05:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDnNw7VspRlkN16FQ--.142S3;
	Wed, 03 Jan 2024 09:05:26 +0800 (CST)
Subject: Re: [PATCH] blk-cgroup: fix rcu lockdep warning in blkg_lookup()
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Changhui Zhong <czhong@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20231219012833.2129540-1-ming.lei@redhat.com>
 <d067baba-e718-76c1-807f-feb169bd0e71@huaweicloud.com>
 <ZZPzHZsSa0g0PzDg@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <13caebf7-55e2-fc86-1af6-7d1b2f649db7@huaweicloud.com>
Date: Wed, 3 Jan 2024 09:05:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZZPzHZsSa0g0PzDg@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnNw7VspRlkN16FQ--.142S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3tF1fGr15ArW8Cw4xCrg_yoW5JFWrpF
	WqkFn5CF1Igrnrur4S93Waqry0vw4vgrW3GrWrGr4Y9ryfZFn2vF13urn5ur1FvFZ7Aa1r
	Xa45Gr9rCw1j93JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/



在 2024/01/02 19:27, Ming Lei 写道:
> On Tue, Jan 02, 2024 at 06:32:13PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/12/19 9:28, Ming Lei 写道:
>>> blkg_lookup() is called with either queue_lock or rcu read lock, so
>>> use rcu_dereference_check(lockdep_is_held(&q->queue_lock)) for
>>> retrieving 'blkg', which way models the check exactly for covering
>>> queue lock or rcu read lock.
>>>
>>> Fix lockdep warning of "block/blk-cgroup.h:254 suspicious rcu_dereference_check() usage!"
>>> from blkg_lookup().
>>>
>>> Tested-by: Changhui Zhong <czhong@redhat.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    block/blk-cgroup.h | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
>>> index fd482439afbc..b927a4a0ad03 100644
>>> --- a/block/blk-cgroup.h
>>> +++ b/block/blk-cgroup.h
>>> @@ -252,7 +252,8 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
>>>    	if (blkcg == &blkcg_root)
>>>    		return q->root_blkg;
>>> -	blkg = rcu_dereference(blkcg->blkg_hint);
>>> +	blkg = rcu_dereference_check(blkcg->blkg_hint,
>>> +			lockdep_is_held(&q->queue_lock));
>>
>> This patch itself is correct, and in fact this is a false positive
>> warning.
> 
> Yeah, it is, but we always teach lockdep to not trigger warning,
> 
>>
>> I noticed that commit 83462a6c971c ("blkcg: Drop unnecessary RCU read
>> [un]locks from blkg_conf_prep/finish()") drop rcu_read_lock/unlock()
>> because 'queue_lock' is held. This is correct, however you add this back
>> for tg_conf_updated() later in commit 27b13e209ddc ("blk-throttle: fix
>> lockdep warning of "cgroup_mutex or RCU read lock required!"") because
>> rcu_read_lock_held() from blkg_lookup() is triggered. And this patch is
>> again another use case cased by commit 83462a6c971c.
> 
> We should add:
> 
> Fixes: 83462a6c971c ("blkcg: Drop unnecessary RCU read [un]locks from blkg_conf_prep/finish()")

With the above fix tag,

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
>>
>> I just wonder, with the respect of rcu implementation, is it possible to
>> add preemptible() check directly in rcu_read_lock_held() to bypass all
>> this kind of false positive warning?
> 
> It isn't related with rcu_read_lock_held(), and the check is done in
> RCU_LOCKDEP_WARN(). rcu_dereference_check() does cover this situation,
> and no need to invent wheel for avoiding the warning.
> 
> Thanks,
> Ming
> 
> 
> .
> 

