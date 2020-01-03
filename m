Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD5DC3F68F
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 07:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607C424649
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 07:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgACHf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:35:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbgACHf5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Jan 2020 02:35:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F25DE6E83B8FB17F2FD6;
        Fri,  3 Jan 2020 15:35:52 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 3 Jan 2020
 15:35:43 +0800
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
To:     Ming Lei <ming.lei@redhat.com>
CC:     Yufen Yu <yuyufen@huawei.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <hch@lst.de>,
        <zhengchuan@huawei.com>, <yi.zhang@huawei.com>,
        <paulmck@kernel.org>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
References: <20191231110945.10857-1-yuyufen@huawei.com>
 <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
 <20200102012314.GB16719@ming.t460p>
 <c12da8ca-be66-496b-efb2-a60ceaf9ce54@huawei.com>
 <20200103041805.GA29924@ming.t460p>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <ea362a86-d2de-7dfe-c826-d59e8b5068c3@huawei.com>
Date:   Fri, 3 Jan 2020 15:35:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20200103041805.GA29924@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020/1/3 12:18, Ming Lei wrote:
> On Fri, Jan 03, 2020 at 11:06:25AM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 2020/1/2 9:23, Ming Lei wrote:
>>> On Tue, Dec 31, 2019 at 10:55:47PM +0800, Hou Tao wrote:
>>>> Hi,
>>>>
snip

>> We have got a seemingly better solution: caching the index of last_lookup in tbl->part[]
>> instead of caching the pointer itself, so we can ensure the validity of returned pointer
>> by ensuring it's not NULL in tbl->part[] as does when last_lookup is NULL or 0.
> 
> Thinking of the problem further, looks we don't need to hold ref for
> .last_lookup.
> 
> What we need is to make sure the partition's ref is increased just
> before assigning .last_lookup, so how about something like the following?
> 
The approach will work for the above case, but it will not work for the following case:

when blk_account_io_done() releases the last ref-counter of last_lookup and calls call_rcu(),
and then a RCU read gets the to-be-freed hd-struct.

blk_account_io_done
  rcu_read_lock()
  // the last ref of last_lookup
  hd_struct_put()
    call_rcu

                              rcu_read_lock
                              read last_lookup

    free()
                              // use-after-free ?
                              hd_struct_try_get

Regards,
Tao

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 089e890ab208..79599f5fd5b7 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1365,18 +1365,6 @@ void blk_account_io_start(struct request *rq, bool new_io)
>  		part_stat_inc(part, merges[rw]);
>  	} else {
>  		part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
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
>  		part_inc_in_flight(rq->q, part, rw);
>  		rq->part = part;
>  	}
> diff --git a/block/genhd.c b/block/genhd.c
> index ff6268970ddc..21f4a9b8d24d 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -286,17 +286,24 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
>  	ptbl = rcu_dereference(disk->part_tbl);
>  
>  	part = rcu_dereference(ptbl->last_lookup);
> -	if (part && sector_in_part(part, sector))
> +	if (part && sector_in_part(part, sector)) {
> +		if (!hd_struct_try_get(part))
> +			goto exit;
>  		return part;
> +	}
>  
>  	for (i = 1; i < ptbl->len; i++) {
>  		part = rcu_dereference(ptbl->part[i]);
>  
>  		if (part && sector_in_part(part, sector)) {
> +                       if (!hd_struct_try_get(part))
> +                               goto exit;
>  			rcu_assign_pointer(ptbl->last_lookup, part);
>  			return part;
>  		}
>  	}
> + exit:
> +	hd_struct_get(&disk->part0);
>  	return &disk->part0;
>  }
>  EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
> 
> 
>>
>>> Given partition is actually protected by percpu-refcount now, I guess the
>>> RCU annotation for referencing ->part[partno] and ->last_lookup may not
>>> be necessary, together with the part->rcu_work.
>>>
>> So we will depends on the invocation of of call_rcu() on __percpu_ref_switch_mode() to
>> ensure the RCU readers will find part[i] is NULL before trying to increasing
>> the atomic ref-counter of part[i], right ?
> 
> Yeah.
> 
> Thanks,
> Ming
> 
> 
> .
> 

