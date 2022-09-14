Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49462ECAAD3
	for <linux-block@archiver.kernel.org>; Wed, 14 Sep 2022 09:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiINJcl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Sep 2022 05:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiINJcW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2022 05:32:22 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F98C20BDE
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 02:23:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MSFFv0CnFzl27Q
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 17:21:39 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgD3SXOBnSFjUS5SAw--.59189S3;
        Wed, 14 Sep 2022 17:23:15 +0800 (CST)
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
 <4f1ec88a-909c-611f-bfa4-19be9553ebda@huaweicloud.com>
 <fb7b8224-70e7-7597-5a84-82293991573a@applied-asynchrony.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d18af425-049e-7870-50fa-60db356b2d24@huaweicloud.com>
Date:   Wed, 14 Sep 2022 17:23:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fb7b8224-70e7-7597-5a84-82293991573a@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD3SXOBnSFjUS5SAw--.59189S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1UGFWUCrWxCry5KF47XFb_yoW5tw1Dp3
        4kJF47JFWagF4kXFy8tr1UX3yakr1Ut3srJrWkXFyYyr43Cr12vF4kXrnFgF1kArW8Cr4U
        Zr1YqrZxZr17WFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/09/14 14:05, Holger Hoffstätte 写道:
> On 2022-09-14 03:35, Yu Kuai wrote:
> [snip]
>> Thanks for the test, it turns out this way doesn't select bfq as default
>> as I expected...
>>
>> wbt can show min_lat_nsec despite that wbt can be disabled by
>> wbt_disable_default(), I do miss that previously...
>>
>> Can you try the following patch again?
>>
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index a630d657c054..3e8adb95ff02 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -467,10 +467,14 @@ static ssize_t queue_io_timeout_store(struct 
>> request_queue *q, const char *page,
>>
>>   static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
>>   {
>> +       u64 lat;
>> +
>>          if (!wbt_rq_qos(q))
>>                  return -EINVAL;
>>
>> -       return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 
>> 1000));
>> +       lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
>> +
>> +       return sprintf(page, "%llu\n", lat);
>>   }
>>
>>   static ssize_t queue_wb_lat_store(struct request_queue *q, const 
>> char *page,
>> @@ -493,6 +497,9 @@ static ssize_t queue_wb_lat_store(struct 
>> request_queue *q, const char *page,
>>                          return ret;
>>          }
>>
>> +       if (wbt_disabled(q))
>> +               return -EINVAL;
>> +
>>          if (val == -1)
>>                  val = wbt_default_latency_nsec(q);
>>          else if (val >= 0)
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index 26ee6ca66a93..55d1015ef117 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -423,6 +423,13 @@ static void wbt_update_limits(struct rq_wb *rwb)
>>          rwb_wake_all(rwb);
>>   }
>>
>> +bool wbt_disabled(struct request_queue *q)
>> +{
>> +       struct rq_qos *rqos = wbt_rq_qos(q);
>> +
>> +       return !rqos || RQWB(rqos)->enable_state == 
>> WBT_STATE_OFF_DEFAULT;
>> +}
>> +
>>   u64 wbt_get_min_lat(struct request_queue *q)
>>   {
>>          struct rq_qos *rqos = wbt_rq_qos(q);
>> diff --git a/block/blk-wbt.h b/block/blk-wbt.h
>> index 1a49b6ac397c..4252b8077257 100644
>> --- a/block/blk-wbt.h
>> +++ b/block/blk-wbt.h
>> @@ -94,6 +94,7 @@ void wbt_enable_default(struct request_queue *, bool);
>>
>>   u64 wbt_get_min_lat(struct request_queue *q);
>>   void wbt_set_min_lat(struct request_queue *q, u64 val);
>> +bool wbt_disabled(struct request_queue *);
>>
>>   void wbt_set_write_cache(struct request_queue *, bool);
>>
> 
> This one works! :)
> 
> After boot:
> 
> $cat /sys/block/sdc/queue/scheduler
> mq-deadline [bfq] none
> $cat /sys/block/sdc/queue/wbt_lat_usec
> 0
> 
> Changing schedulers  back and forth - here on a device with different
> default - also works:
> 
> $cat /sys/block/sda/queue/scheduler
> [mq-deadline] bfq none
> $cat /sys/block/sda/queue/wbt_lat_usec
> 2000
> $echo bfq > /sys/block/sda/queue/scheduler
> $cat /sys/block/sda/queue/wbt_lat_usec
> 0
> $echo deadline > /sys/block/sda/queue/scheduler
> $cat /sys/block/sda/queue/wbt_lat_usec
> 2000
> 
> Feel free to add my Reported-by and Tested-by.
> 
I'll send a patch soon. Thanks again for the test.

Kuai
> cheers!
> Holger
> 
> .
> 

