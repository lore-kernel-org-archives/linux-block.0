Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA3ECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 14 Sep 2022 06:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiINGFy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Sep 2022 02:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiINGFp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2022 02:05:45 -0400
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1663F3B
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 23:05:43 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd7cb4.dip0.t-ipconnect.de [93.221.124.180])
        by mail.itouring.de (Postfix) with ESMTPSA id 9F21E103762;
        Wed, 14 Sep 2022 08:05:41 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 21D4BF01609;
        Wed, 14 Sep 2022 08:05:41 +0200 (CEST)
Subject: Re: wbt_lat_usec still set despite wbt disabled by BFQ
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        linux-block <linux-block@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <a5041479-f417-2b95-b645-56e665a7e557@applied-asynchrony.com>
 <17e0e889-e848-0bd3-3203-cb4e9b801462@huaweicloud.com>
 <f731dab6-7f55-42d1-53fd-b656d75e5620@applied-asynchrony.com>
 <59272bf8-a53e-d3e8-d7eb-44391ddc97fe@huaweicloud.com>
 <13a8e0d9-08b0-a110-57d6-086b23dba9a7@applied-asynchrony.com>
 <4f1ec88a-909c-611f-bfa4-19be9553ebda@huaweicloud.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <fb7b8224-70e7-7597-5a84-82293991573a@applied-asynchrony.com>
Date:   Wed, 14 Sep 2022 08:05:41 +0200
MIME-Version: 1.0
In-Reply-To: <4f1ec88a-909c-611f-bfa4-19be9553ebda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022-09-14 03:35, Yu Kuai wrote:
[snip]
> Thanks for the test, it turns out this way doesn't select bfq as default
> as I expected...
> 
> wbt can show min_lat_nsec despite that wbt can be disabled by
> wbt_disable_default(), I do miss that previously...
> 
> Can you try the following patch again?
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index a630d657c054..3e8adb95ff02 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -467,10 +467,14 @@ static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
> 
>   static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
>   {
> +       u64 lat;
> +
>          if (!wbt_rq_qos(q))
>                  return -EINVAL;
> 
> -       return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
> +       lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
> +
> +       return sprintf(page, "%llu\n", lat);
>   }
> 
>   static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
> @@ -493,6 +497,9 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
>                          return ret;
>          }
> 
> +       if (wbt_disabled(q))
> +               return -EINVAL;
> +
>          if (val == -1)
>                  val = wbt_default_latency_nsec(q);
>          else if (val >= 0)
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 26ee6ca66a93..55d1015ef117 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -423,6 +423,13 @@ static void wbt_update_limits(struct rq_wb *rwb)
>          rwb_wake_all(rwb);
>   }
> 
> +bool wbt_disabled(struct request_queue *q)
> +{
> +       struct rq_qos *rqos = wbt_rq_qos(q);
> +
> +       return !rqos || RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT;
> +}
> +
>   u64 wbt_get_min_lat(struct request_queue *q)
>   {
>          struct rq_qos *rqos = wbt_rq_qos(q);
> diff --git a/block/blk-wbt.h b/block/blk-wbt.h
> index 1a49b6ac397c..4252b8077257 100644
> --- a/block/blk-wbt.h
> +++ b/block/blk-wbt.h
> @@ -94,6 +94,7 @@ void wbt_enable_default(struct request_queue *, bool);
> 
>   u64 wbt_get_min_lat(struct request_queue *q);
>   void wbt_set_min_lat(struct request_queue *q, u64 val);
> +bool wbt_disabled(struct request_queue *);
> 
>   void wbt_set_write_cache(struct request_queue *, bool);
> 

This one works! :)

After boot:

$cat /sys/block/sdc/queue/scheduler
mq-deadline [bfq] none
$cat /sys/block/sdc/queue/wbt_lat_usec
0

Changing schedulers  back and forth - here on a device with different
default - also works:

$cat /sys/block/sda/queue/scheduler
[mq-deadline] bfq none
$cat /sys/block/sda/queue/wbt_lat_usec
2000
$echo bfq > /sys/block/sda/queue/scheduler
$cat /sys/block/sda/queue/wbt_lat_usec
0
$echo deadline > /sys/block/sda/queue/scheduler
$cat /sys/block/sda/queue/wbt_lat_usec
2000

Feel free to add my Reported-by and Tested-by.

cheers!
Holger
