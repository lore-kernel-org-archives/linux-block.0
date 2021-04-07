Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7F5C433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4276112F
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 15:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhDGPi4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 11:38:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2801 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhDGPiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 11:38:52 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFpML2D3Kz682Z9;
        Wed,  7 Apr 2021 23:33:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 17:38:40 +0200
Received: from [10.210.168.126] (10.210.168.126) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 16:38:39 +0100
Subject: Re: [PATCH v6 1/5] blk-mq: Move the elevator_exit() definition
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Hannes Reinecke" <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Khazhy Kumykov <khazhy@google.com>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-2-bvanassche@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f5b4e317-b74d-9dc7-300b-cdadfcde794e@huawei.com>
Date:   Wed, 7 Apr 2021 16:36:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210406214905.21622-2-bvanassche@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.126]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/04/2021 22:49, Bart Van Assche wrote:
> Since elevator_exit() has only one caller, move its definition from
> block/blk.h into block/elevator.c. Remove the inline keyword since modern
> compilers are smart enough to decide when to inline functions that occur
> in the same compilation unit.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Khazhy Kumykov <khazhy@google.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk.h      | 9 ---------
>   block/elevator.c | 8 ++++++++
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 8f4337c5a9e6..2ed6c684d63a 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -199,15 +199,6 @@ void __elevator_exit(struct request_queue *, struct elevator_queue *);
>   int elv_register_queue(struct request_queue *q, bool uevent);
>   void elv_unregister_queue(struct request_queue *q);
>   
> -static inline void elevator_exit(struct request_queue *q,
> -		struct elevator_queue *e)
> -{
> -	lockdep_assert_held(&q->sysfs_lock);
> -
> -	blk_mq_sched_free_requests(q);
> -	__elevator_exit(q, e);
> -}
> -
>   ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
>   		char *buf);
>   ssize_t part_stat_show(struct device *dev, struct device_attribute *attr,
> diff --git a/block/elevator.c b/block/elevator.c
> index 293c5c81397a..4b20d1ab29cc 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -197,6 +197,14 @@ void __elevator_exit(struct request_queue *q, struct elevator_queue *e)
>   	kobject_put(&e->kobj);
>   }
>   
> +static void elevator_exit(struct request_queue *q, struct elevator_queue *e)
> +{
> +	lockdep_assert_held(&q->sysfs_lock);
> +
> +	blk_mq_sched_free_requests(q);
> +	__elevator_exit(q, e);

To me, it seems odd that the double-underscore prefix symbol is public 
(__elevator_exit), while the companion symbol (elevator_exit) is private.

But it looks a sensible change to bring into the c file anyway.

Thanks,
John

> +}
> +
>   static inline void __elv_rqhash_del(struct request *rq)
>   {
>   	hash_del(&rq->hash);
> .
> 

