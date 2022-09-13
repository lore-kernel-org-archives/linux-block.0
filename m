Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1BAC6FA82
	for <linux-block@archiver.kernel.org>; Tue, 13 Sep 2022 17:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiIMR0h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Sep 2022 13:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiIMR0K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2022 13:26:10 -0400
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B34F3BD
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 09:13:50 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd7cb4.dip0.t-ipconnect.de [93.221.124.180])
        by mail.itouring.de (Postfix) with ESMTPSA id B8958103762;
        Tue, 13 Sep 2022 18:13:48 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 69EE5F0160E;
        Tue, 13 Sep 2022 18:13:48 +0200 (CEST)
Subject: Re: wbt_lat_usec still set despite wbt disabled by BFQ
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        linux-block <linux-block@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <a5041479-f417-2b95-b645-56e665a7e557@applied-asynchrony.com>
 <17e0e889-e848-0bd3-3203-cb4e9b801462@huaweicloud.com>
 <f731dab6-7f55-42d1-53fd-b656d75e5620@applied-asynchrony.com>
 <59272bf8-a53e-d3e8-d7eb-44391ddc97fe@huaweicloud.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <13a8e0d9-08b0-a110-57d6-086b23dba9a7@applied-asynchrony.com>
Date:   Tue, 13 Sep 2022 18:13:48 +0200
MIME-Version: 1.0
In-Reply-To: <59272bf8-a53e-d3e8-d7eb-44391ddc97fe@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022-09-13 16:20, Yu Kuai wrote:
> 
> 
> 在 2022/09/13 22:12, Holger Hoffstätte 写道:
>> On 2022-09-13 15:39, Yu Kuai wrote:
>>> Hi, Holger
>>>
>>> 在 2022/08/18 1:12, Holger Hoffstätte 写道:
>>>>
>>>> I just noticed that my device configured with BFQ still shows wbt_lat_usec
>>>> as configured, despite the fact that BFQ disables WBT in bfq_init_queue [1]:
>>>>
>>>> $cat /sys/block/sdc/queue/scheduler
>>>> mq-deadline [bfq] none
>>>> $cat /sys/block/sdc/queue/wbt_lat_usec
>>>> 75000
>>>>
>>>> Is this supposed to be 0 (since it's disabled) or is sysfs confused?
>>>>
>>>> Thanks,
>>>> Holger
>>>
>>> I'm reviewing wbt codes recently, and I found that this problem will
>>> happen if the default elevator is bfq. I'll try to fix this, do you mind
>>> if I add reported-by tag?
>>
>> Do not mind at all - thank you for looking into it!
>> Let me know if I can test a patch or help in some other way.
>>
>> Btw not sure what "default scheduler" means here, I set my schedulers via
>> udev rules. In this case:
>>
>> ACTION=="add", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
>>
> 
> Default means the elevator is bfq when device is created.
> 
> Perhaps can you try the following patch?
> 
>      blk-wbt: don't enable throttling if default elevator is bfq
> 
>      Commit b5dc5d4d1f4f ("block,bfq: Disable writeback throttling") tries to
>      disable wbt for bfq, it's done by calling wbt_disable_default() in
>      bfq_init_queue(). However, wbt is still enabled if default elevator is
>      bfq:
> 
>      device_add_disk
>       elevator_init_mq
>        bfq_init_queue
>         wbt_disable_default -> done nothing
> 
>       blk_register_queue
>        wbt_enable_default -> wbt is enabled
> 
>      Fix the problem by checking elevator name if wbt_enable_default() is
>      called from blk_register_queue().
> 
> 
> diff --git a/block/elevator.h b/block/elevator.h
> index 3f0593b3bf9d..ccded343cf27 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -104,6 +104,11 @@ struct elevator_queue
>          DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
>   };
> 
> +static inline bool check_elevator_name(struct elevator_queue *elevator,
> +                                      const char *name)
> +{
> +       return !strcmp(elevator->type->elevator_name, name);
> +}
>   /*
>    * block elevator interface
>    */
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 7ea427817f7f..f769c90744fd 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -7045,7 +7045,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
>   #endif
> 
>          blk_stat_disable_accounting(bfqd->queue);
> -       wbt_enable_default(bfqd->queue);
> +       wbt_enable_default(bfqd->queue, false);
> 
>          kfree(bfqd);
>   }
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e1f009aba6fd..a630d657c054 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -843,7 +843,7 @@ int blk_register_queue(struct gendisk *disk)
>                  goto put_dev;
> 
>          blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
> -       wbt_enable_default(q);
> +       wbt_enable_default(q, true);
>          blk_throtl_register_queue(q);
> 
>          /* Now everything is ready and send out KOBJ_ADD uevent */
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 246467926253..26ee6ca66a93 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -27,6 +27,7 @@
> 
>   #include "blk-wbt.h"
>   #include "blk-rq-qos.h"
> +#include "elevator.h"
> 
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/wbt.h>
> @@ -636,10 +637,14 @@ void wbt_set_write_cache(struct request_queue *q, bool write_cache_on)
>   /*
>    * Enable wbt if defaults are configured that way
>    */
> -void wbt_enable_default(struct request_queue *q)
> +void wbt_enable_default(struct request_queue *q, bool check_elevator)
>   {
>          struct rq_qos *rqos = wbt_rq_qos(q);
> 
> +       if (check_elevator && q->elevator &&
> +           check_elevator_name(q->elevator, "bfq"))
> +               return;
> +
>          /* Throttling already enabled? */
>          if (rqos) {
>                  if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
> diff --git a/block/blk-wbt.h b/block/blk-wbt.h
> index 7e44eccc676d..1a49b6ac397c 100644
> --- a/block/blk-wbt.h
> +++ b/block/blk-wbt.h
> @@ -90,7 +90,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
> 
>   int wbt_init(struct request_queue *);
>   void wbt_disable_default(struct request_queue *);
> -void wbt_enable_default(struct request_queue *);
> +void wbt_enable_default(struct request_queue *, bool);
> 
>   u64 wbt_get_min_lat(struct request_queue *q);
>   void wbt_set_min_lat(struct request_queue *q, u64 val);
> @@ -108,7 +108,8 @@ static inline int wbt_init(struct request_queue *q)
>   static inline void wbt_disable_default(struct request_queue *q)
>   {
>   }
> -static inline void wbt_enable_default(struct request_queue *q)
> +static inline void wbt_enable_default(struct request_queue *q,
> +                                     bool check_elevator)
>   {
>   }
>   static inline void wbt_set_write_cache(struct request_queue *q, bool wc)
> 

So that didn't help, unfortunately.

Directly after boot (with the above udev rule):

$cat /sys/block/sdc/queue/scheduler
mq-deadline [bfq] none
$cat /sys/block/sdc/queue/wbt_lat_usec
75000

Changing the scheduler back and forth also does not help:

$echo mq-deadline > /sys/block/sdc/queue/scheduler
$echo bfq > /sys/block/sdc/queue/scheduler
$cat /sys/block/sdc/queue/wbt_lat_usec
75000

Sorry :)

Holger
