Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFECC54EE9
	for <linux-block@archiver.kernel.org>; Wed, 14 Sep 2022 01:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiINBgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Sep 2022 21:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiINBgH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2022 21:36:07 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA36B8D6
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 18:36:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MS2tQ0RTLzKPxN
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 09:34:06 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgBH53D9LyFjrHRCAw--.50131S3;
        Wed, 14 Sep 2022 09:35:58 +0800 (CST)
Subject: Re: wbt_lat_usec still set despite wbt disabled by BFQ
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        linux-block <linux-block@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <a5041479-f417-2b95-b645-56e665a7e557@applied-asynchrony.com>
 <17e0e889-e848-0bd3-3203-cb4e9b801462@huaweicloud.com>
 <f731dab6-7f55-42d1-53fd-b656d75e5620@applied-asynchrony.com>
 <59272bf8-a53e-d3e8-d7eb-44391ddc97fe@huaweicloud.com>
 <13a8e0d9-08b0-a110-57d6-086b23dba9a7@applied-asynchrony.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4f1ec88a-909c-611f-bfa4-19be9553ebda@huaweicloud.com>
Date:   Wed, 14 Sep 2022 09:35:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <13a8e0d9-08b0-a110-57d6-086b23dba9a7@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH53D9LyFjrHRCAw--.50131S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyDJFy5Xw48Zw1xZw1DWrg_yoWfGFyUp3
        4kJF12kFWagF40qry8twnrX343Kr18K3srXry8GFWFyrsFkr12qa18Wr1jgF18ArZ7CFsr
        Xr15trZxZr17W3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Holger

在 2022/09/14 0:13, Holger Hoffstätte 写道:
> On 2022-09-13 16:20, Yu Kuai wrote:
>>
>>
>> 在 2022/09/13 22:12, Holger Hoffstätte 写道:
>>> On 2022-09-13 15:39, Yu Kuai wrote:
>>>> Hi, Holger
>>>>
>>>> 在 2022/08/18 1:12, Holger Hoffstätte 写道:
>>>>>
>>>>> I just noticed that my device configured with BFQ still shows 
>>>>> wbt_lat_usec
>>>>> as configured, despite the fact that BFQ disables WBT in 
>>>>> bfq_init_queue [1]:
>>>>>
>>>>> $cat /sys/block/sdc/queue/scheduler
>>>>> mq-deadline [bfq] none
>>>>> $cat /sys/block/sdc/queue/wbt_lat_usec
>>>>> 75000
>>>>>
>>>>> Is this supposed to be 0 (since it's disabled) or is sysfs confused?
>>>>>
>>>>> Thanks,
>>>>> Holger
>>>>
>>>> I'm reviewing wbt codes recently, and I found that this problem will
>>>> happen if the default elevator is bfq. I'll try to fix this, do you 
>>>> mind
>>>> if I add reported-by tag?
>>>
>>> Do not mind at all - thank you for looking into it!
>>> Let me know if I can test a patch or help in some other way.
>>>
>>> Btw not sure what "default scheduler" means here, I set my schedulers 
>>> via
>>> udev rules. In this case:
>>>
>>> ACTION=="add", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", 
>>> ATTR{queue/scheduler}="bfq"
>>>
>>
>> Default means the elevator is bfq when device is created.
>>
>> Perhaps can you try the following patch?
>>
>>      blk-wbt: don't enable throttling if default elevator is bfq
>>
>>      Commit b5dc5d4d1f4f ("block,bfq: Disable writeback throttling") 
>> tries to
>>      disable wbt for bfq, it's done by calling wbt_disable_default() in
>>      bfq_init_queue(). However, wbt is still enabled if default 
>> elevator is
>>      bfq:
>>
>>      device_add_disk
>>       elevator_init_mq
>>        bfq_init_queue
>>         wbt_disable_default -> done nothing
>>
>>       blk_register_queue
>>        wbt_enable_default -> wbt is enabled
>>
>>      Fix the problem by checking elevator name if wbt_enable_default() is
>>      called from blk_register_queue().
>>
>>
>> diff --git a/block/elevator.h b/block/elevator.h
>> index 3f0593b3bf9d..ccded343cf27 100644
>> --- a/block/elevator.h
>> +++ b/block/elevator.h
>> @@ -104,6 +104,11 @@ struct elevator_queue
>>          DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
>>   };
>>
>> +static inline bool check_elevator_name(struct elevator_queue *elevator,
>> +                                      const char *name)
>> +{
>> +       return !strcmp(elevator->type->elevator_name, name);
>> +}
>>   /*
>>    * block elevator interface
>>    */
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 7ea427817f7f..f769c90744fd 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -7045,7 +7045,7 @@ static void bfq_exit_queue(struct elevator_queue 
>> *e)
>>   #endif
>>
>>          blk_stat_disable_accounting(bfqd->queue);
>> -       wbt_enable_default(bfqd->queue);
>> +       wbt_enable_default(bfqd->queue, false);
>>
>>          kfree(bfqd);
>>   }
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index e1f009aba6fd..a630d657c054 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -843,7 +843,7 @@ int blk_register_queue(struct gendisk *disk)
>>                  goto put_dev;
>>
>>          blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
>> -       wbt_enable_default(q);
>> +       wbt_enable_default(q, true);
>>          blk_throtl_register_queue(q);
>>
>>          /* Now everything is ready and send out KOBJ_ADD uevent */
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index 246467926253..26ee6ca66a93 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -27,6 +27,7 @@
>>
>>   #include "blk-wbt.h"
>>   #include "blk-rq-qos.h"
>> +#include "elevator.h"
>>
>>   #define CREATE_TRACE_POINTS
>>   #include <trace/events/wbt.h>
>> @@ -636,10 +637,14 @@ void wbt_set_write_cache(struct request_queue 
>> *q, bool write_cache_on)
>>   /*
>>    * Enable wbt if defaults are configured that way
>>    */
>> -void wbt_enable_default(struct request_queue *q)
>> +void wbt_enable_default(struct request_queue *q, bool check_elevator)
>>   {
>>          struct rq_qos *rqos = wbt_rq_qos(q);
>>
>> +       if (check_elevator && q->elevator &&
>> +           check_elevator_name(q->elevator, "bfq"))
>> +               return;
>> +
>>          /* Throttling already enabled? */
>>          if (rqos) {
>>                  if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
>> diff --git a/block/blk-wbt.h b/block/blk-wbt.h
>> index 7e44eccc676d..1a49b6ac397c 100644
>> --- a/block/blk-wbt.h
>> +++ b/block/blk-wbt.h
>> @@ -90,7 +90,7 @@ static inline unsigned int wbt_inflight(struct rq_wb 
>> *rwb)
>>
>>   int wbt_init(struct request_queue *);
>>   void wbt_disable_default(struct request_queue *);
>> -void wbt_enable_default(struct request_queue *);
>> +void wbt_enable_default(struct request_queue *, bool);
>>
>>   u64 wbt_get_min_lat(struct request_queue *q);
>>   void wbt_set_min_lat(struct request_queue *q, u64 val);
>> @@ -108,7 +108,8 @@ static inline int wbt_init(struct request_queue *q)
>>   static inline void wbt_disable_default(struct request_queue *q)
>>   {
>>   }
>> -static inline void wbt_enable_default(struct request_queue *q)
>> +static inline void wbt_enable_default(struct request_queue *q,
>> +                                     bool check_elevator)
>>   {
>>   }
>>   static inline void wbt_set_write_cache(struct request_queue *q, bool 
>> wc)
>>
> 
> So that didn't help, unfortunately.
> 
> Directly after boot (with the above udev rule):
> 
> $cat /sys/block/sdc/queue/scheduler
> mq-deadline [bfq] none
> $cat /sys/block/sdc/queue/wbt_lat_usec
> 75000
> 
> Changing the scheduler back and forth also does not help:
> 
> $echo mq-deadline > /sys/block/sdc/queue/scheduler
> $echo bfq > /sys/block/sdc/queue/scheduler
> $cat /sys/block/sdc/queue/wbt_lat_usec
> 75000

Thanks for the test, it turns out this way doesn't select bfq as default
as I expected...

wbt can show min_lat_nsec despite that wbt can be disabled by
wbt_disable_default(), I do miss that previously...

Can you try the following patch again?

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a630d657c054..3e8adb95ff02 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -467,10 +467,14 @@ static ssize_t queue_io_timeout_store(struct 
request_queue *q, const char *page,

  static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
  {
+       u64 lat;
+
         if (!wbt_rq_qos(q))
                 return -EINVAL;

-       return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
+       lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
+
+       return sprintf(page, "%llu\n", lat);
  }

  static ssize_t queue_wb_lat_store(struct request_queue *q, const char 
*page,
@@ -493,6 +497,9 @@ static ssize_t queue_wb_lat_store(struct 
request_queue *q, const char *page,
                         return ret;
         }

+       if (wbt_disabled(q))
+               return -EINVAL;
+
         if (val == -1)
                 val = wbt_default_latency_nsec(q);
         else if (val >= 0)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 26ee6ca66a93..55d1015ef117 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -423,6 +423,13 @@ static void wbt_update_limits(struct rq_wb *rwb)
         rwb_wake_all(rwb);
  }

+bool wbt_disabled(struct request_queue *q)
+{
+       struct rq_qos *rqos = wbt_rq_qos(q);
+
+       return !rqos || RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT;
+}
+
  u64 wbt_get_min_lat(struct request_queue *q)
  {
         struct rq_qos *rqos = wbt_rq_qos(q);
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 1a49b6ac397c..4252b8077257 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -94,6 +94,7 @@ void wbt_enable_default(struct request_queue *, bool);

  u64 wbt_get_min_lat(struct request_queue *q);
  void wbt_set_min_lat(struct request_queue *q, u64 val);
+bool wbt_disabled(struct request_queue *);

  void wbt_set_write_cache(struct request_queue *, bool);

> 
> Sorry :)
> 
> Holger
> 
> .
> 

