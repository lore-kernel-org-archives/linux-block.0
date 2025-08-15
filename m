Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52139248863
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247186; cv=none; b=Rol3q5NTwFPREqK2mqFadOZLTsAbGmG5oufobiiz/fniRILKsNUFYI6JM3UBxrAiWSORfNSwYkxr/fkSkkx+cvH7isj6ld6Q2D1OjxIuFVboJs7IOvey91SRu+vlPGiYI2DxMz1ODQ5Zn4hJwQj1VK1HA3zzZowTFrJoOlWLUBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247186; c=relaxed/simple;
	bh=3Pt511DJShmNLzOcfK/KyS7QctXtILx+ATnQUaupYQQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F+KBrIdn9ElQxQB015ckR58aiugyYKBCWT3l8bWxJuagKyHdC3srvZ6WhxAackvrBt5sgsyYaJNCxWxsHn3VKL3nczQpxslIhffIa4YHLhXS+hqefoKTOeSxqZqDtnASegzB0YBszgVnRJVR+ZkgSA7zl3CPu7gPugtgXzX14ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3FsS24VjzKHMmC
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 16:39:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 975911A0A46
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 16:39:39 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBn4hJH8p5oL20BDw--.56165S3;
	Fri, 15 Aug 2025 16:39:37 +0800 (CST)
Subject: Re: [PATCHv3 3/3] block: avoid cpu_hotplug_lock depedency on
 freeze_lock
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
 axboe@kernel.dk, hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com,
 gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-4-nilay@linux.ibm.com> <aJ3aR2JodRrAqVcO@fedora>
 <e125025b-d576-4919-b00e-5d9b640bed77@linux.ibm.com>
 <aJ3myQW2A8HtteBC@fedora>
 <e33e97f7-0c12-4f70-81d0-4fea05557579@linux.ibm.com>
 <aJ57lZLhktXxaBoh@fedora>
 <6d5949db-0df9-93d3-4397-966be5c2fac9@huaweicloud.com>
 <aJ7ozolL_rKWkdS5@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <20c21ce3-ecb4-69e2-2594-89b55ac1fb0f@huaweicloud.com>
Date: Fri, 15 Aug 2025 16:39:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aJ7ozolL_rKWkdS5@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn4hJH8p5oL20BDw--.56165S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy7Cr13Zr17try3CrW3KFg_yoWfur17pa
	y8KF47AFWjqr1kZa48tw48Zr13t3s5Kr17Xr13JrySvr1qvr12yF18JFWUKFy8ZryxAr48
	Xr48Jrn7Jr1YkwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/15 15:59, Ming Lei 写道:
> On Fri, Aug 15, 2025 at 09:04:53AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/08/15 8:13, Ming Lei 写道:
>>> On Thu, Aug 14, 2025 at 08:01:11PM +0530, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 8/14/25 7:08 PM, Ming Lei wrote:
>>>>> On Thu, Aug 14, 2025 at 06:27:08PM +0530, Nilay Shroff wrote:
>>>>>>
>>>>>>
>>>>>> On 8/14/25 6:14 PM, Ming Lei wrote:
>>>>>>> On Thu, Aug 14, 2025 at 01:54:59PM +0530, Nilay Shroff wrote:
>>>>>>>> A recent lockdep[1] splat observed while running blktest block/005
>>>>>>>> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
>>>>>>>> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
>>>>>>>> ("block: blk-rq-qos: guard rq-qos helpers by static key").
>>>>>>>>
>>>>>>>> That change added a static key to avoid fetching q->rq_qos when
>>>>>>>> neither blk-wbt nor blk-iolatency is configured. The static key
>>>>>>>> dynamically patches kernel text to a NOP when disabled, eliminating
>>>>>>>> overhead of fetching q->rq_qos in the I/O hot path. However, enabling
>>>>>>>> a static key at runtime requires acquiring both cpu_hotplug_lock and
>>>>>>>> jump_label_mutex. When this happens after the queue has already been
>>>>>>>> frozen (i.e., while holding ->freeze_lock), it creates a locking
>>>>>>>> dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
>>>>>>>> potential deadlock reported by lockdep [1].
>>>>>>>>
>>>>>>>> To resolve this, replace the static key mechanism with q->queue_flags:
>>>>>>>> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
>>>>>>>> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
>>>>>>>> otherwise, the access is skipped.
>>>>>>>>
>>>>>>>> Since q->queue_flags is commonly accessed in IO hotpath and resides in
>>>>>>>> the first cacheline of struct request_queue, checking it imposes minimal
>>>>>>>> overhead while eliminating the deadlock risk.
>>>>>>>>
>>>>>>>> This change avoids the lockdep splat without introducing performance
>>>>>>>> regressions.
>>>>>>>>
>>>>>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>>>>>
>>>>>>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>>>>> Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>>>>> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
>>>>>>>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>>>>>> ---
>>>>>>>>    block/blk-mq-debugfs.c |  1 +
>>>>>>>>    block/blk-rq-qos.c     |  9 ++++---
>>>>>>>>    block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
>>>>>>>>    include/linux/blkdev.h |  1 +
>>>>>>>>    4 files changed, 37 insertions(+), 28 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>>>>>>>> index 7ed3e71f2fc0..32c65efdda46 100644
>>>>>>>> --- a/block/blk-mq-debugfs.c
>>>>>>>> +++ b/block/blk-mq-debugfs.c
>>>>>>>> @@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
>>>>>>>>    	QUEUE_FLAG_NAME(SQ_SCHED),
>>>>>>>>    	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
>>>>>>>>    	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
>>>>>>>> +	QUEUE_FLAG_NAME(QOS_ENABLED),
>>>>>>>>    };
>>>>>>>>    #undef QUEUE_FLAG_NAME
>>>>>>>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>>>>>>>> index b1e24bb85ad2..654478dfbc20 100644
>>>>>>>> --- a/block/blk-rq-qos.c
>>>>>>>> +++ b/block/blk-rq-qos.c
>>>>>>>> @@ -2,8 +2,6 @@
>>>>>>>>    #include "blk-rq-qos.h"
>>>>>>>> -__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
>>>>>>>> -
>>>>>>>>    /*
>>>>>>>>     * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
>>>>>>>>     * false if 'v' + 1 would be bigger than 'below'.
>>>>>>>> @@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
>>>>>>>>    		struct rq_qos *rqos = q->rq_qos;
>>>>>>>>    		q->rq_qos = rqos->next;
>>>>>>>>    		rqos->ops->exit(rqos);
>>>>>>>> -		static_branch_dec(&block_rq_qos);
>>>>>>>>    	}
>>>>>>>> +	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
>>>>>>>>    	mutex_unlock(&q->rq_qos_mutex);
>>>>>>>>    }
>>>>>>>> @@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>>>>>>>>    		goto ebusy;
>>>>>>>>    	rqos->next = q->rq_qos;
>>>>>>>>    	q->rq_qos = rqos;
>>>>>>>> -	static_branch_inc(&block_rq_qos);
>>>>>>>> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
>>>>>>>
>>>>>>> One stupid question: can we simply move static_branch_inc(&block_rq_qos)
>>>>>>> out of queue freeze in rq_qos_add()?
>>>>>>>
>>>>>>> What matters is just the 1st static_branch_inc() which switches the counter
>>>>>>> from 0 to 1, when blk_mq_freeze_queue() guarantees that all in-progress code
>>>>>>> paths observe q->rq_qos as NULL. That means static_branch_inc(&block_rq_qos)
>>>>>>> needn't queue freeze protection.
>>>>>>>
>>>>>> I thought about it earlier but that won't work because we have
>>>>>> code paths freezing queue before it reaches upto rq_qos_add(),
>>>>>> For instance:
>>>>>>
>>>>>> We have following code paths from where we invoke
>>>>>> rq_qos_add() APIs with queue already frozen:
>>>>>>
>>>>>> ioc_qos_write()
>>>>>>    -> blkg_conf_open_bdev_frozen() => freezes queue
>>>>>>    -> blk_iocost_init()
>>>>>>      -> rq_qos_add()
>>>>>>
>>>>>> queue_wb_lat_store()  => freezes queue
>>>>>>    -> wbt_init()
>>>>>>     -> rq_qos_add()
>>>>>
>>>>> The above two shouldn't be hard to solve, such as, add helper
>>>>> rq_qos_prep_add() for increasing the static branch counter.
>>>>>
>> I thought about this, we'll need some return value to know if rq_qos
>> is really added and I feel code will be much complex. We'll need at
>> least two different APIs for cgroup based policy iocost/iolatency and
>> pure rq_qos policy wbt.
> 
> Yes, but not too bad, such as:
> 
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 5bfd70311359..05b13235ebb3 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3227,6 +3227,8 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>   
>   	blkg_conf_init(&ctx, input);
>   
> +	rq_qos_prep_add();
> +
>   	memflags = blkg_conf_open_bdev_frozen(&ctx);
>   	if (IS_ERR_VALUE(memflags)) {
>   		ret = memflags;
> @@ -3344,7 +3346,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>   	if (enable)
>   		wbt_disable_default(disk);
>   	else
> -		wbt_enable_default(disk);
> +		wbt_enable_default(disk, false);
>   
>   	blk_mq_unquiesce_queue(disk->queue);
>   
> @@ -3356,6 +3358,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>   	ret = -EINVAL;
>   err:
>   	blkg_conf_exit_frozen(&ctx, memflags);
> +	rq_qos_prep_del();
>   	return ret;
>   }

This is not enough for iocost:

1) ioc_qos_write() can be called with iocost already registered, we need
to call rq_qos_prep_del() in the succeed branch as well.
2) ioc_cost_model_write() have to have the same treatment.

>   
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 848591fb3c57..27047f661e3f 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -319,7 +319,7 @@ void rq_qos_exit(struct request_queue *q)
>   		struct rq_qos *rqos = q->rq_qos;
>   		q->rq_qos = rqos->next;
>   		rqos->ops->exit(rqos);
> -		static_branch_dec(&block_rq_qos);
> +		rq_qos_prep_del();
>   	}
>   	mutex_unlock(&q->rq_qos_mutex);
>   }
> @@ -346,7 +346,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>   		goto ebusy;
>   	rqos->next = q->rq_qos;
>   	q->rq_qos = rqos;
> -	static_branch_inc(&block_rq_qos);
>   
>   	blk_mq_unfreeze_queue(q, memflags);
>   
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
> index 39749f4066fb..38572a7eb2b7 100644
> --- a/block/blk-rq-qos.h
> +++ b/block/blk-rq-qos.h
> @@ -179,4 +179,14 @@ static inline void rq_qos_queue_depth_changed(struct request_queue *q)
>   
>   void rq_qos_exit(struct request_queue *);
>   
> +static inline void rq_qos_prep_add(void)
> +{
> +	static_branch_inc(&block_rq_qos);
> +}
> +
> +static inline void rq_qos_prep_del(void)
> +{
> +	static_branch_dec(&block_rq_qos);
> +}
> +
>   #endif

Wonder can we simplify this, we already have a disk level lock
rq_qos_mutex, that is held before freeze queue for iocost and iolatency,
and we can grab it before freeze queue for wbt as well, then we can just
do the static_branch_inc/dec with rq_qos_mutex held easily since
everything is serialized.

+static inline bool rq_qos_prep_add(struct request_queue *q, enum 
rq_qos_id id)
+{
+       lockdep_assert_held(q->rq_qos_mutex);
+
+       if (!rq_qos_id(q, id)) {
+               static_branch_inc(&block_rq_qos);
+               return true;
+       }
+
+       return false;
+}
+
+/* paired with rq_qos_prep_add */
+static inline bool rq_qos_prep_del(struct request_queue *q, enum 
rq_qos_id id, bool prepared)
+{
+       lockdep_assert_held(q->rq_qos_mutex);
+
+       if (prepared && !rq_qos_id(q, id))
+               static_branch_dec(&block_rq_qos);
+}
+

