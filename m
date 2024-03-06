Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92846FBD
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688908; cv=none; b=IDNyinryXvK1cDfgosla1xx/ajzArWzbXUxj4cN9G5JL4+NHFHRKP8qNc5QVq6+OwBxPWBMawx6cMvgzMuzb3P1qTdgAz5P6+ZI+pXQRIuNh2JjRi0s7SwbxcpLcSSjmH71eqQAmfGpPNTDU1fbFiXFbCKlStZTSWFsfDXSMi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688908; c=relaxed/simple;
	bh=qsZ5CKGv/6Bfj09SYkHgh9i1wpwPIG4nYVr2NOPpRRo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GKmJLbRhOv/BCVuvdY9vSQJrt9l7JX4LYP88r6vj8CdmtGVgP3Aep8srpEpiKJjk+t5eQZFqdHt/yuKMxWozpYKHvJ10MYUe+KRLqFI2K1KKOw3g+xzdW4y32hNjRLwNVYNKQPZ7xAPIMtbozLDrLwaZ/jo0ZDtwGEzVXfk3kRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TqFNc1Wnxz4f3jd0
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 09:34:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9F8BC1A01A8
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 09:35:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFDyOdlaGZLGA--.28473S3;
	Wed, 06 Mar 2024 09:35:01 +0800 (CST)
Subject: Re: [PATCH] block: Support building the iocost and iolatency policies
 as kernel modules
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240306003911.78697-1-bvanassche@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <396d15a0-eedc-bf00-dd56-c064293fcaa5@huaweicloud.com>
Date: Wed, 6 Mar 2024 09:34:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240306003911.78697-1-bvanassche@acm.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFDyOdlaGZLGA--.28473S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyxGry8CryrtF1kWryrCrg_yoWfCFW8pa
	yDJa13Cw47KF4DZFWIg3Z7uryfWw4kKry3G34kArySyr9Ikr1akF1ktFyktrW8ZrsrCF47
	XF1F9FZrCa1v937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/03/06 8:39, Bart Van Assche Ð´µÀ:
> Distributors of Linux kernel binary images, including the Android kernel
> team, have to make a difficult choice: either enable the iocost and
> iolatency cgroup policies in the kernel build and increase the kernel
> size or disable these cgroup policies in the kernel configuration. This
> patch supports building the iocost and iolatency cgroup policies as
> kernel modules. This allows users to only load these policies that they
> need.
> 
> If these policies are loaded as a kernel module these may be loaded
> after request queues have already been created instead of before and
> blkcg_policy_register() and blkcg_policy_unregister() will be called
> while request queues already exist. The BFQ I/O scheduler already calls
> blkcg_policy_register() and blkcg_policy_unregister() after request
> queues have been created so this is not a new use case for these
> functions.
> 
> The changes in this patch are as follows:
> * Change 'bool' into 'tristate' in block/Kconfig for the iocost and
>    iolatency controllers.
> * Change #ifdef CONFIG_BLK_CGROUP_IOCOST into #if
>    IS_ENABLED(CONFIG_BLK_CGROUP_IOCOST).
> * Export the symbols necessary to build iocost and iolatency as kernel
>    modules.
> * Add MODULE_AUTHOR/LICENSE/DESCRIPTION() declarations.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/Kconfig             | 4 ++--
>   block/bio.c               | 2 +-
>   block/blk-cgroup.c        | 7 ++++++-
>   block/blk-iocost.c        | 4 ++++
>   block/blk-iolatency.c     | 4 ++++
>   block/blk-rq-qos.c        | 4 ++++
>   block/blk-stat.c          | 3 +++
>   fs/kernfs/dir.c           | 1 +
>   include/linux/blk_types.h | 2 +-
>   kernel/cgroup/cgroup.c    | 1 +
>   10 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 1de4682d48cc..abbfa9c0bb8e 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -148,7 +148,7 @@ config BLK_WBT_MQ
>   	Enable writeback throttling by default for request-based block devices.
>   
>   config BLK_CGROUP_IOLATENCY
> -	bool "Enable support for latency based cgroup IO protection"
> +	tristate "Enable support for latency based cgroup IO protection"
>   	depends on BLK_CGROUP
>   	help
>   	Enabling this option enables the .latency interface for IO throttling.
> @@ -168,7 +168,7 @@ config BLK_CGROUP_FC_APPID
>   	  application specific identification into the FC frame.
>   
>   config BLK_CGROUP_IOCOST
> -	bool "Enable support for cost model based cgroup IO controller"
> +	tristate "Enable support for cost model based cgroup IO controller"
>   	depends on BLK_CGROUP
>   	select BLK_RQ_ALLOC_TIME
>   	help
> diff --git a/block/bio.c b/block/bio.c
> index 496867b51609..32f801520282 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -262,7 +262,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
>   	bio->bi_issue.value = 0;
>   	if (bdev)
>   		bio_associate_blkg(bio);
> -#ifdef CONFIG_BLK_CGROUP_IOCOST
> +#if IS_ENABLED(CONFIG_BLK_CGROUP_IOCOST)
>   	bio->bi_iocost_cost = 0;
>   #endif
>   #endif
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bdbb557feb5a..d096db4fb53c 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -56,7 +56,8 @@ static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
>   
>   static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
>   
> -bool blkcg_debug_stats = false;
> +bool blkcg_debug_stats;
> +EXPORT_SYMBOL_GPL(blkcg_debug_stats);
>   
>   static DEFINE_RAW_SPINLOCK(blkg_stat_lock);
>   
> @@ -666,6 +667,7 @@ const char *blkg_dev_name(struct blkcg_gq *blkg)
>   		return NULL;
>   	return bdi_dev_name(blkg->q->disk->bdi);
>   }
> +EXPORT_SYMBOL_GPL(blkg_dev_name);
>   
>   /**
>    * blkcg_print_blkgs - helper for printing per-blkg data
> @@ -793,6 +795,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
>   	ctx->bdev = bdev;
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(blkg_conf_open_bdev);
>   
>   /**
>    * blkg_conf_prep - parse and prepare for per-blkg config update
> @@ -1976,6 +1979,7 @@ void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
>   		current->use_memdelay = use_memdelay;
>   	set_notify_resume(current);
>   }
> +EXPORT_SYMBOL_GPL(blkcg_schedule_throttle);
>   
>   /**
>    * blkcg_add_delay - add delay to this blkg
> @@ -1993,6 +1997,7 @@ void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
>   	blkcg_scale_delay(blkg, now);
>   	atomic64_add(delta, &blkg->delay_nsec);
>   }
> +EXPORT_SYMBOL_GPL(blkcg_add_delay);
>   
>   /**
>    * blkg_tryget_closest - try and get a blkg ref on the closet blkg
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 4b0b483a9693..879eb699b90d 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3534,3 +3534,7 @@ static void __exit ioc_exit(void)
>   
>   module_init(ioc_init);
>   module_exit(ioc_exit);
> +
> +MODULE_AUTHOR("Tejun Heo");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("blkio cost cgroup policy");

Looks like there are lots of work need to be done as well, for
exapmle:

- ping the iocost Module before enabling it for a disk, otherwise unload
the Module will cause problems;
- free the iocost structure after disabling it, otherwise iocost Module
can never be unloaded;

Thanks,
Kuai

> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index ebb522788d97..bac13ee02ac4 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -1069,3 +1069,7 @@ static void __exit iolatency_exit(void)
>   
>   module_init(iolatency_init);
>   module_exit(iolatency_exit);
> +
> +MODULE_AUTHOR("Josef Bacik");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("blkio latency cgroup policy");
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index dd7310c94713..d2bf466ebc0e 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -22,6 +22,7 @@ bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit)
>   {
>   	return atomic_inc_below(&rq_wait->inflight, limit);
>   }
> +EXPORT_SYMBOL_GPL(rq_wait_inc_below);
>   
>   void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio)
>   {
> @@ -285,6 +286,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>   	} while (1);
>   	finish_wait(&rqw->wait, &data.wq);
>   }
> +EXPORT_SYMBOL_GPL(rq_qos_wait);
>   
>   void rq_qos_exit(struct request_queue *q)
>   {
> @@ -332,6 +334,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>   	blk_mq_unfreeze_queue(q);
>   	return -EBUSY;
>   }
> +EXPORT_SYMBOL_GPL(rq_qos_add);
>   
>   void rq_qos_del(struct rq_qos *rqos)
>   {
> @@ -353,3 +356,4 @@ void rq_qos_del(struct rq_qos *rqos)
>   	blk_mq_debugfs_unregister_rqos(rqos);
>   	mutex_unlock(&q->debugfs_mutex);
>   }
> +EXPORT_SYMBOL_GPL(rq_qos_del);
> diff --git a/block/blk-stat.c b/block/blk-stat.c
> index 7ff76ae6c76a..639d9887ad91 100644
> --- a/block/blk-stat.c
> +++ b/block/blk-stat.c
> @@ -23,6 +23,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
>   	stat->max = stat->nr_samples = stat->mean = 0;
>   	stat->batch = 0;
>   }
> +EXPORT_SYMBOL_GPL(blk_rq_stat_init);
>   
>   /* src is a per-cpu stat, mean isn't initialized */
>   void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
> @@ -38,6 +39,7 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
>   
>   	dst->nr_samples += src->nr_samples;
>   }
> +EXPORT_SYMBOL_GPL(blk_rq_stat_sum);
>   
>   void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
>   {
> @@ -46,6 +48,7 @@ void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
>   	stat->batch += value;
>   	stat->nr_samples++;
>   }
> +EXPORT_SYMBOL_GPL(blk_rq_stat_add);
>   
>   void blk_stat_add(struct request *rq, u64 now)
>   {
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index bce1d7ac95ca..6893c7edc6b6 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -279,6 +279,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
>   out:
>   	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
>   }
> +EXPORT_SYMBOL_GPL(pr_cont_kernfs_path);
>   
>   /**
>    * kernfs_get_parent - determine the parent node and pin it
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 1c07848dea7e..a58c4d2f8438 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -244,7 +244,7 @@ struct bio {
>   	 */
>   	struct blkcg_gq		*bi_blkg;
>   	struct bio_issue	bi_issue;
> -#ifdef CONFIG_BLK_CGROUP_IOCOST
> +#if IS_ENABLED(CONFIG_BLK_CGROUP_IOCOST)
>   	u64			bi_iocost_cost;
>   #endif
>   #endif
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index a66c088c851c..9b30123af809 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6950,6 +6950,7 @@ int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
>   	*v = whole * power_of_ten(dec_shift) + frac;
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(cgroup_parse_float);
>   
>   /*
>    * sock->sk_cgrp_data handling.  For more info, see sock_cgroup_data
> 
> .
> 

