Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE8C433FE
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 01:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiJ0BVK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 21:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiJ0BVJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 21:21:09 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184246C747
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 18:21:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MySVc0dJgz6V50H
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 09:18:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgC3xuj63Flj+5AFAQ--.55747S3;
        Thu, 27 Oct 2022 09:20:59 +0800 (CST)
Subject: Re: [bug report] blk-iocost: don't release 'ioc->lock' while updating
 params
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <Y1lAtdAkRp8JYJ+c@kili>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bb525f2f-4975-2219-7132-c4d7dffcb53d@huaweicloud.com>
Date:   Thu, 27 Oct 2022 09:20:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y1lAtdAkRp8JYJ+c@kili>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3xuj63Flj+5AFAQ--.55747S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur15Ar4UZrWxKw47AFyUGFg_yoWrAw1UpF
        WfKF9xt348Xw40gr97AayUK3sYkr43JryxZFZrKrySvrZxKw1vq3W8GFWq9348XFs7GFW5
        Jr4UJFWvyrWDGrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Dan!

ÔÚ 2022/10/26 22:14, Dan Carpenter Ð´µÀ:
> Hello Yu Kuai,
> 
> The patch 2c0647988433: "blk-iocost: don't release 'ioc->lock' while
> updating params" from Oct 12, 2022, leads to the following Smatch
> static checker warnings:
> 
> block/blk-iocost.c:3211 ioc_qos_write() warn: sleeping in atomic context
> block/blk-iocost.c:3240 ioc_qos_write() warn: sleeping in atomic context
> block/blk-iocost.c:3407 ioc_cost_model_write() warn: sleeping in atomic context
> 
> block/blk-iocost.c
>      3168 static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>      3169                              size_t nbytes, loff_t off)
>      3170 {
>      3171         struct block_device *bdev;
>      3172         struct gendisk *disk;
>      3173         struct ioc *ioc;
>      3174         u32 qos[NR_QOS_PARAMS];
>      3175         bool enable, user;
>      3176         char *p;
>      3177         int ret;
>      3178
>      3179         bdev = blkcg_conf_open_bdev(&input);
>      3180         if (IS_ERR(bdev))
>      3181                 return PTR_ERR(bdev);
>      3182
>      3183         disk = bdev->bd_disk;
>      3184         ioc = q_to_ioc(disk->queue);
>      3185         if (!ioc) {
>      3186                 ret = blk_iocost_init(disk);
>      3187                 if (ret)
>      3188                         goto err;
>      3189                 ioc = q_to_ioc(disk->queue);
>      3190         }
>      3191
>      3192         blk_mq_freeze_queue(disk->queue);
>      3193         blk_mq_quiesce_queue(disk->queue);
>      3194
>      3195         spin_lock_irq(&ioc->lock);
> 
> Preempt disabled.
> 
>      3196         memcpy(qos, ioc->params.qos, sizeof(qos));
>      3197         enable = ioc->enabled;
>      3198         user = ioc->user_qos_params;
>      3199
>      3200         while ((p = strsep(&input, " \t\n"))) {
>      3201                 substring_t args[MAX_OPT_ARGS];
>      3202                 char buf[32];
>      3203                 int tok;
>      3204                 s64 v;
>      3205
>      3206                 if (!*p)
>      3207                         continue;
>      3208
>      3209                 switch (match_token(p, qos_ctrl_tokens, args)) {
>      3210                 case QOS_ENABLE:
> --> 3211                         match_u64(&args[0], &v);
>                                   ^^^^^^^^^^^^^^^^^^^^^^^^
> match functions do sleeping allocations.
Thanks for the report, I'll try to fix this soon.

Kuai
> 
>      3212                         enable = v;
>      3213                         continue;
>      3214                 case QOS_CTRL:
>      3215                         match_strlcpy(buf, &args[0], sizeof(buf));
>      3216                         if (!strcmp(buf, "auto"))
>      3217                                 user = false;
>      3218                         else if (!strcmp(buf, "user"))
>      3219                                 user = true;
>      3220                         else
>      3221                                 goto einval;
>      3222                         continue;
>      3223                 }
>      3224
>      3225                 tok = match_token(p, qos_tokens, args);
>      3226                 switch (tok) {
>      3227                 case QOS_RPPM:
>      3228                 case QOS_WPPM:
>      3229                         if (match_strlcpy(buf, &args[0], sizeof(buf)) >=
>      3230                             sizeof(buf))
>      3231                                 goto einval;
>      3232                         if (cgroup_parse_float(buf, 2, &v))
>      3233                                 goto einval;
>      3234                         if (v < 0 || v > 10000)
>      3235                                 goto einval;
>      3236                         qos[tok] = v * 100;
>      3237                         break;
>      3238                 case QOS_RLAT:
>      3239                 case QOS_WLAT:
>      3240                         if (match_u64(&args[0], &v))
>      3241                                 goto einval;
>      3242                         qos[tok] = v;
>      3243                         break;
>      3244                 case QOS_MIN:
>      3245                 case QOS_MAX:
>      3246                         if (match_strlcpy(buf, &args[0], sizeof(buf)) >=
>      3247                             sizeof(buf))
>      3248                                 goto einval;
>      3249                         if (cgroup_parse_float(buf, 2, &v))
>      3250                                 goto einval;
>      3251                         if (v < 0)
>      3252                                 goto einval;
>      3253                         qos[tok] = clamp_t(s64, v * 100,
>      3254                                            VRATE_MIN_PPM, VRATE_MAX_PPM);
>      3255                         break;
>      3256                 default:
>      3257                         goto einval;
>      3258                 }
>      3259                 user = true;
>      3260         }
>      3261
>      3262         if (qos[QOS_MIN] > qos[QOS_MAX])
>      3263                 goto einval;
>      3264
>      3265         if (enable) {
>      3266                 blk_stat_enable_accounting(disk->queue);
>      3267                 blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
>      3268                 ioc->enabled = true;
>      3269                 wbt_disable_default(disk->queue);
>      3270         } else {
>      3271                 blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
>      3272                 ioc->enabled = false;
>      3273                 wbt_enable_default(disk->queue);
>      3274         }
>      3275
>      3276         if (user) {
>      3277                 memcpy(ioc->params.qos, qos, sizeof(qos));
>      3278                 ioc->user_qos_params = true;
>      3279         } else {
>      3280                 ioc->user_qos_params = false;
>      3281         }
>      3282
>      3283         ioc_refresh_params(ioc, true);
>      3284         spin_unlock_irq(&ioc->lock);
>      3285
>      3286         blk_mq_unquiesce_queue(disk->queue);
>      3287         blk_mq_unfreeze_queue(disk->queue);
>      3288
>      3289         blkdev_put_no_open(bdev);
>      3290         return nbytes;
>      3291 einval:
>      3292         spin_unlock_irq(&ioc->lock);
>      3293
>      3294         blk_mq_unquiesce_queue(disk->queue);
>      3295         blk_mq_unfreeze_queue(disk->queue);
>      3296
>      3297         ret = -EINVAL;
>      3298 err:
>      3299         blkdev_put_no_open(bdev);
>      3300         return ret;
>      3301 }
> 
> regards,
> dan carpenter
> 
> .
> 

