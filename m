Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B27C3F68F
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 12:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AABF20848
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 12:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgACMEE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:04:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727577AbgACMEE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Jan 2020 07:04:04 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9BD94C65A2EB28D9A3E7;
        Fri,  3 Jan 2020 20:04:01 +0800 (CST)
Received: from [10.173.221.193] (10.173.221.193) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 3 Jan 2020 20:03:54 +0800
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
To:     Ming Lei <ming.lei@redhat.com>, Hou Tao <houtao1@huawei.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <hch@lst.de>,
        <zhengchuan@huawei.com>, <yi.zhang@huawei.com>,
        <paulmck@kernel.org>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
References: <20191231110945.10857-1-yuyufen@huawei.com>
 <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
 <20200102012314.GB16719@ming.t460p>
 <c12da8ca-be66-496b-efb2-a60ceaf9ce54@huawei.com>
 <20200103041805.GA29924@ming.t460p>
 <ea362a86-d2de-7dfe-c826-d59e8b5068c3@huawei.com>
 <20200103081745.GA11275@ming.t460p>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <82c10514-aec5-0d7c-118f-32c261015c6a@huawei.com>
Date:   Fri, 3 Jan 2020 20:03:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103081745.GA11275@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.193]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Ming

On 2020/1/3 16:17, Ming Lei wrote:
> 
> We may avoid that by clearing partition pointer after killing the
> partition, how about the following change?
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
> index ff6268970ddc..e3dec90b1f43 100644
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
> +                       if (!hd_struct_try_get(part))
> +                               goto exit;
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
> index 1d20c9cf213f..9ef6c13d5650 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -283,8 +283,8 @@ void delete_partition(struct gendisk *disk, int partno)
>   	if (!part)
>   		return;
>   
> -	rcu_assign_pointer(ptbl->part[partno], NULL);
> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
> +	get_device(disk_to_dev(disk));
> +
>   	kobject_put(part->holder_dir);
>   	device_del(part_to_dev(part));
>   
> @@ -296,6 +296,15 @@ void delete_partition(struct gendisk *disk, int partno)
>   	 */
>   	blk_invalidate_devt(part_devt(part));
>   	hd_struct_kill(part);
> +
> +	/*
> +	 * clear partition pointers after this partition is killed, then
> +	 * IO path can't re-assign ->last_lookup any more
> +	 */
> +	rcu_assign_pointer(ptbl->part[partno], NULL);
> +	rcu_assign_pointer(ptbl->last_lookup, NULL);
> +
> +	put_device(disk_to_dev(disk));
>   }
>   

This change may cannot solve follow case:

disk_map_sector_rcu     delete_partition  disk_map_sector_rcu
hd_struct_try_get(part)
                         hd_struct_kill
                         last_lookup = NULL;
last_lookup = part


call_rcu
                                            read last_lookup

free()
                                            //use-after-free
                                            sector_in_part(part, sector)

There is an interval between getting part and setting last_lookup
in disk_map_sector_rcu(). If we kill the part and clear last_lookup
at that interval, last_lookup will be re-assign again, which can cause
use-after-free for readers after call_rcu.

Thanks
Yufen
