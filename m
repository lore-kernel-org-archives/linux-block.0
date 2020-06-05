Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A38C433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 09:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69991207D0
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 09:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgFEJ2u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:28:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbgFEJ2u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 05:28:50 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E1AAEA2634ECAAA0C8B5;
        Fri,  5 Jun 2020 10:28:48 +0100 (IST)
Received: from [127.0.0.1] (10.210.169.114) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 5 Jun 2020
 10:28:48 +0100
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
To:     Ming Lei <ming.lei@redhat.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de> <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590>
 <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
 <20200604120747.GB2336493@T590>
 <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
 <20200605083349.GA2392879@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <161ad789-11f9-b422-99e3-0abf18e1b167@huawei.com>
Date:   Fri, 5 Jun 2020 10:27:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200605083349.GA2392879@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.114]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/06/2020 09:33, Ming Lei wrote:
>> LLDD does not use request->tag - it generates its own.
>>
>>   and suggest you to double check
>>> hisi_sas's queue mapping which has to be exactly same with blk-mq's
>>> mapping.
>>>
>> scheduler=none is ok, so I am skeptical of a problem there.
> Please try the following patch, and we may not drain in-flight
> requests correctly:
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 97bb650f0ed6..ae110e2754bf 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -265,6 +265,7 @@ struct bt_tags_iter_data {
>   
>   #define BT_TAG_ITER_RESERVED		(1 << 0)
>   #define BT_TAG_ITER_STARTED		(1 << 1)
> +#define BT_TAG_ITER_STATIC_RQS		(1 << 2)
>   
>   static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   {
> @@ -280,7 +281,10 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	 * We can hit rq == NULL here, because the tagging functions
>   	 * test and set the bit before assining ->rqs[].
>   	 */
> -	rq = tags->rqs[bitnr];
> +	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
> +		rq = tags->static_rqs[bitnr];
> +	else
> +		rq = tags->rqs[bitnr];
>   	if (!rq)
>   		return true;
>   	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
> @@ -335,11 +339,13 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
>    *		indicates whether or not @rq is a reserved request. Return
>    *		true to continue iterating tags, false to stop.
>    * @priv:	Will be passed as second argument to @fn.
> + *
> + * Caller has to pass the tag map from which requests are allocated.
>    */
>   void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
>   		void *priv)
>   {
> -	return __blk_mq_all_tag_iter(tags, fn, priv, 0);
> +	return __blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
>   }
>   
>   /**
> 

ok, so early test shows that this is ok. I didn't try scheduler=none though.

I'll let you know.

Thanks,
John

