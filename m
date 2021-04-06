Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A1C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 22:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE1461284
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 22:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhDFW1q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 18:27:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2778 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhDFW1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 18:27:46 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFMRV00Rkz68624;
        Wed,  7 Apr 2021 06:20:37 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 7 Apr 2021 00:27:36 +0200
Received: from [10.210.168.220] (10.210.168.220) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 23:27:35 +0100
Subject: Re: [PATCH] blk-mq: set default elevator as deadline in case of hctx
 shared tagset
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Yanhui Ma <yama@redhat.com>,
        "Hannes Reinecke" <hare@suse.de>
References: <20210406031933.767228-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d081eb6a-ace7-c9b2-7374-7f05a31551a0@huawei.com>
Date:   Tue, 6 Apr 2021 23:25:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210406031933.767228-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.220]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/04/2021 04:19, Ming Lei wrote:

Hi Ming,

> Yanhui found that write performance is degraded a lot after applying
> hctx shared tagset on one test machine with megaraid_sas. And turns out
> it is caused by none scheduler which becomes default elevator caused by
> hctx shared tagset patchset.
> 
> Given more scsi HBAs will apply hctx shared tagset, and the similar
> performance exists for them too.
> 
> So keep previous behavior by still using default mq-deadline for queues
> which apply hctx shared tagset, just like before.

I think that there a some SCSI HBAs which have nr_hw_queues > 1 and 
don't use shared sbitmap - do you think that they want want this as well 
(without knowing it)?

IIRC, the upcoming broadcom SCSI HBA driver does this.

Thanks,
John

> 
> Fixes: 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per tagset")
> Reported-by: Yanhui Ma <yama@redhat.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/elevator.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 293c5c81397a..440699c28119 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -621,7 +621,8 @@ static inline bool elv_support_iosched(struct request_queue *q)
>    */
>   static struct elevator_type *elevator_get_default(struct request_queue *q)
>   {
> -	if (q->nr_hw_queues != 1)
> +	if (q->nr_hw_queues != 1 &&
> +			!blk_mq_is_sbitmap_shared(q->tag_set->flags))
>   		return NULL;
>   
>   	return elevator_get(q, "mq-deadline", false);
> 

