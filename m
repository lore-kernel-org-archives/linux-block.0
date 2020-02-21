Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AC1C11D00
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FFA208CD
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgBUDFZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:05:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729280AbgBUDFY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 22:05:24 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9E4FE2056280458B762B;
        Fri, 21 Feb 2020 11:05:22 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 21 Feb 2020 11:05:13 +0800
Subject: Re: [PATCH 1/4] block: fix use-after-free on cached last_lookup
 partition
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Hou Tao" <houtao1@huawei.com>
References: <20200109062109.2313-1-ming.lei@redhat.com>
 <20200109062109.2313-2-ming.lei@redhat.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <f2f8b3c9-db6b-a5b3-5d0b-91ed65404048@huawei.com>
Date:   Fri, 21 Feb 2020 11:05:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109062109.2313-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.74]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guys,

Did this patch have been forgotten? So, ping...

Thanks,
Yufen


On 2020/1/9 14:21, Ming Lei wrote:
> delete_partition() clears the cached last_lookup partition. However
> the .last_lookup cache may be overwritten by one IO path after
> it is cleared from delete_partition(). Then another IO path may
> use the cached deleting partition after __delete_partition() is
> called, then use-after-free is triggered on the cached partition.
> 
> Fixes the issue by the following approach:
> 
> 1) always get the partition's refcount via hd_struct_try_get() before
> setting .last_lookup
> 
> 2) move clearing .last_lookup from delete_partition() to
> __delete_partition() which is release handle of the partition's
> percpu-refcount, so that no IO path can overwrite .last_lookup after it
> is cleared in __delete_partition().
> 
> It is one candidate approach of Yufen's patch[1] which adds overhead
> in fast path by indirect lookup which may introduce one extra cacheline
> in IO path. Also this patch relies on percpu-refcount's protection, and
> it is easier to understand and verify.
> 
> [1] https://lore.kernel.org/linux-block/20200109013551.GB9655@ming.t460p/T/#t
> 
> Reported-by: Yufen Yu <yuyufen@huawei.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-core.c          | 12 ------------
>   block/genhd.c             |  6 +++++-
>   block/partition-generic.c | 10 +++++++++-
>   include/linux/genhd.h     |  1 +
>   4 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 089e890ab208..79599f5fd5b7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1365,18 +1365,6 @@ void blk_account_io_start(struct request *rq, bool new_io)
>   		part_stat_inc(part, merges[rw]);
>   	} else {
>   		part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
> -		if (!hd_struct_try_get(part)) {
> -			/*
> -			 * The partition is already being removed,
> -			 * the request will be accounted on the disk only
> -			 *
> -			 * We take a reference on disk->part0 although that
> -			 * partition will never be deleted, so we can treat
> -			 * it as any other partition.
> -			 */
> -			part = &rq->rq_disk->part0;
> -			hd_struct_get(part);
> -		}
>   		part_inc_in_flight(rq->q, part, rw);
>   		rq->part = part;
>   	}
> diff --git a/block/genhd.c b/block/genhd.c
> index ff6268970ddc..6029c94510f0 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -286,17 +286,21 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
>   	ptbl = rcu_dereference(disk->part_tbl);
>   
>   	part = rcu_dereference(ptbl->last_lookup);
> -	if (part && sector_in_part(part, sector))
> +	if (part && sector_in_part(part, sector) && hd_struct_try_get(part))
>   		return part;
>   
>   	for (i = 1; i < ptbl->len; i++) {
>   		part = rcu_dereference(ptbl->part[i]);
>   
>   		if (part && sector_in_part(part, sector)) {
> +			if (!hd_struct_try_get(part))
> +				goto exit;
>   			rcu_assign_pointer(ptbl->last_lookup, part);
>   			return part;
>   		}
>   	}
> + exit:
> +	hd_struct_get(&disk->part0);
>   	return &disk->part0;
>   }
>   EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 1d20c9cf213f..1739f750dbf2 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -262,6 +262,12 @@ static void delete_partition_work_fn(struct work_struct *work)
>   void __delete_partition(struct percpu_ref *ref)
>   {
>   	struct hd_struct *part = container_of(ref, struct hd_struct, ref);
> +	struct disk_part_tbl *ptbl =
> +		rcu_dereference_protected(part->disk->part_tbl, 1);
> +
> +	rcu_assign_pointer(ptbl->last_lookup, NULL);
> +	put_device(disk_to_dev(part->disk));
> +
>   	INIT_RCU_WORK(&part->rcu_work, delete_partition_work_fn);
>   	queue_rcu_work(system_wq, &part->rcu_work);
>   }
> @@ -283,8 +289,9 @@ void delete_partition(struct gendisk *disk, int partno)
>   	if (!part)
>   		return;
>   
> +	get_device(disk_to_dev(disk));
>   	rcu_assign_pointer(ptbl->part[partno], NULL);
> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
> +
>   	kobject_put(part->holder_dir);
>   	device_del(part_to_dev(part));
>   
> @@ -349,6 +356,7 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
>   	p->nr_sects = len;
>   	p->partno = partno;
>   	p->policy = get_disk_ro(disk);
> +	p->disk = disk;
>   
>   	if (info) {
>   		struct partition_meta_info *pinfo = alloc_part_info(disk);
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 8bb63027e4d6..1b09cfe00aa3 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -130,6 +130,7 @@ struct hd_struct {
>   	struct disk_stats dkstats;
>   #endif
>   	struct percpu_ref ref;
> +	struct gendisk *disk;
>   	struct rcu_work rcu_work;
>   };
>   
> 
