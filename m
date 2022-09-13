Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698F0C6FA82
	for <linux-block@archiver.kernel.org>; Tue, 13 Sep 2022 17:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiIMROv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Sep 2022 13:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiIMROS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2022 13:14:18 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0653ED0746
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 09:02:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MRlvh2Pr8zKHMx
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 22:19:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgBH53DMkSBjN_EqAw--.55836S3;
        Tue, 13 Sep 2022 22:21:01 +0800 (CST)
Subject: Re: wbt_lat_usec still set despite wbt disabled by BFQ
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        linux-block <linux-block@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <a5041479-f417-2b95-b645-56e665a7e557@applied-asynchrony.com>
 <17e0e889-e848-0bd3-3203-cb4e9b801462@huaweicloud.com>
 <f731dab6-7f55-42d1-53fd-b656d75e5620@applied-asynchrony.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <59272bf8-a53e-d3e8-d7eb-44391ddc97fe@huaweicloud.com>
Date:   Tue, 13 Sep 2022 22:20:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f731dab6-7f55-42d1-53fd-b656d75e5620@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH53DMkSBjN_EqAw--.55836S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1rtFy8ur4xWw18ZrykAFb_yoWrKFWrpa
        y8Gan2kF42gFWj9rW8JwnrXw43Kw4vkry7GrykC3yFvr9IkrZFqa1vkF1UZF4vyrZ7CFsr
        Zr4rtFZrWFW0gw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2022/09/13 22:12, Holger Hoffstätte 写道:
> On 2022-09-13 15:39, Yu Kuai wrote:
>> Hi, Holger
>>
>> 在 2022/08/18 1:12, Holger Hoffstätte 写道:
>>>
>>> I just noticed that my device configured with BFQ still shows 
>>> wbt_lat_usec
>>> as configured, despite the fact that BFQ disables WBT in 
>>> bfq_init_queue [1]:
>>>
>>> $cat /sys/block/sdc/queue/scheduler
>>> mq-deadline [bfq] none
>>> $cat /sys/block/sdc/queue/wbt_lat_usec
>>> 75000
>>>
>>> Is this supposed to be 0 (since it's disabled) or is sysfs confused?
>>>
>>> Thanks,
>>> Holger
>>
>> I'm reviewing wbt codes recently, and I found that this problem will
>> happen if the default elevator is bfq. I'll try to fix this, do you mind
>> if I add reported-by tag?
> 
> Do not mind at all - thank you for looking into it!
> Let me know if I can test a patch or help in some other way.
> 
> Btw not sure what "default scheduler" means here, I set my schedulers via
> udev rules. In this case:
> 
> ACTION=="add", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", 
> ATTR{queue/scheduler}="bfq"
> 

Default means the elevator is bfq when device is created.

Perhaps can you try the following patch?

     blk-wbt: don't enable throttling if default elevator is bfq

     Commit b5dc5d4d1f4f ("block,bfq: Disable writeback throttling") 
tries to
     disable wbt for bfq, it's done by calling wbt_disable_default() in
     bfq_init_queue(). However, wbt is still enabled if default elevator is
     bfq:

     device_add_disk
      elevator_init_mq
       bfq_init_queue
        wbt_disable_default -> done nothing

      blk_register_queue
       wbt_enable_default -> wbt is enabled

     Fix the problem by checking elevator name if wbt_enable_default() is
     called from blk_register_queue().


diff --git a/block/elevator.h b/block/elevator.h
index 3f0593b3bf9d..ccded343cf27 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -104,6 +104,11 @@ struct elevator_queue
         DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
  };

+static inline bool check_elevator_name(struct elevator_queue *elevator,
+                                      const char *name)
+{
+       return !strcmp(elevator->type->elevator_name, name);
+}
  /*
   * block elevator interface
   */

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7ea427817f7f..f769c90744fd 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7045,7 +7045,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
  #endif

         blk_stat_disable_accounting(bfqd->queue);
-       wbt_enable_default(bfqd->queue);
+       wbt_enable_default(bfqd->queue, false);

         kfree(bfqd);
  }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e1f009aba6fd..a630d657c054 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -843,7 +843,7 @@ int blk_register_queue(struct gendisk *disk)
                 goto put_dev;

         blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
-       wbt_enable_default(q);
+       wbt_enable_default(q, true);
         blk_throtl_register_queue(q);

         /* Now everything is ready and send out KOBJ_ADD uevent */
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 246467926253..26ee6ca66a93 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -27,6 +27,7 @@

  #include "blk-wbt.h"
  #include "blk-rq-qos.h"
+#include "elevator.h"

  #define CREATE_TRACE_POINTS
  #include <trace/events/wbt.h>
@@ -636,10 +637,14 @@ void wbt_set_write_cache(struct request_queue *q, 
bool write_cache_on)
  /*
   * Enable wbt if defaults are configured that way
   */
-void wbt_enable_default(struct request_queue *q)
+void wbt_enable_default(struct request_queue *q, bool check_elevator)
  {
         struct rq_qos *rqos = wbt_rq_qos(q);

+       if (check_elevator && q->elevator &&
+           check_elevator_name(q->elevator, "bfq"))
+               return;
+
         /* Throttling already enabled? */
         if (rqos) {
                 if (RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 7e44eccc676d..1a49b6ac397c 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -90,7 +90,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)

  int wbt_init(struct request_queue *);
  void wbt_disable_default(struct request_queue *);
-void wbt_enable_default(struct request_queue *);
+void wbt_enable_default(struct request_queue *, bool);

  u64 wbt_get_min_lat(struct request_queue *q);
  void wbt_set_min_lat(struct request_queue *q, u64 val);
@@ -108,7 +108,8 @@ static inline int wbt_init(struct request_queue *q)
  static inline void wbt_disable_default(struct request_queue *q)
  {
  }
-static inline void wbt_enable_default(struct request_queue *q)
+static inline void wbt_enable_default(struct request_queue *q,
+                                     bool check_elevator)
  {
  }
  static inline void wbt_set_write_cache(struct request_queue *q, bool wc)

> cheers
> Holger
> .
> 

