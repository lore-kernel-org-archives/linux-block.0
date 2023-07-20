Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE5DEB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 15:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjGTPo4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 11:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjGTPoz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 11:44:55 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0274C123
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 08:44:54 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b89cfb4571so6923825ad.3
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 08:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867894; x=1690472694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kU0CQ24Eq35ykrcIjcOAgW1d3TQm0JahTjly7//d6Hs=;
        b=Bi6GA7KAjNRGv9C6VpjQ7bZtxQYfwK+QTMmd213S6xqLSfhujkZsXJGWM0FhcQAzDv
         vX1p0XRtL9zxNR8uCVh8plZkRr0b27q6AZ4QIQMjHXv/yf0OnDABloAzsVda7VWZf6Q9
         amPq0ru5diS2dZYxeL0b0UKVFkB3t1gCUuCF+mYby5ayI0poKBajv+0tGj8HNbFI63U2
         dam4A5UVmjlaghpi/Orl+sWjCW29T2Boq6cO3k0IrDSKD8p8I6QxeBAIMpMcQmnQZAJl
         cED8FWzI0rOT5KDk5fmJbxMpkoPR4RZ6pCS+56NhtMlP31Q7XBVJkxHzgm/vadLSg56y
         QFHQ==
X-Gm-Message-State: ABy/qLZiM7aPOyBxQd2S2mnKLUK8VGQ/H6lIkVSoBEmPsGiG52oHDDdv
        gaexNeBC4FMysWBsiEWyPh+p4wTaCtY=
X-Google-Smtp-Source: APBJJlHn3b8YdDObDJtNJJcSiOCGvjOONmEbp2OEMkD0h1Sre/rlzQYG1GaV0lUttxqOhYJdi9pKFA==
X-Received: by 2002:a17:903:22c1:b0:1b8:ae8c:7d88 with SMTP id y1-20020a17090322c100b001b8ae8c7d88mr7637731plg.7.1689867894395;
        Thu, 20 Jul 2023 08:44:54 -0700 (PDT)
Received: from ?IPV6:2601:642:4c05:35c7:a9f2:f55:cb5b:263a? ([2601:642:4c05:35c7:a9f2:f55:cb5b:263a])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b001b86dd825e7sm1563688plr.108.2023.07.20.08.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:44:53 -0700 (PDT)
Message-ID: <2c4f838c-aabc-1ef1-45eb-961114da643b@acm.org>
Date:   Thu, 20 Jul 2023 08:44:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] block: Improve performance for BLK_MQ_F_BLOCKING
 drivers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230719182243.2810134-1-bvanassche@acm.org>
 <20230719182243.2810134-4-bvanassche@acm.org> <20230720055437.GA2665@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230720055437.GA2665@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/19/23 22:54, Christoph Hellwig wrote:
> On Wed, Jul 19, 2023 at 11:22:42AM -0700, Bart Van Assche wrote:
>> + *    for execution. Don't wait for completion. May sleep if BLK_MQ_F_BLOCKING
>> + *    has been set.
>>    *
>>    * Note:
>>    *    This function will invoke @done directly if the queue is dead.
>> @@ -2213,6 +2214,8 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>>   	 */
>>   	WARN_ON_ONCE(!async && in_interrupt());
>>   
>> +	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);
> 
> This is some odd an very complex calling conventions.  I suspect most
> !BLK_MQ_F_BLOCKING could also deal with the may sleep if not async,
> and that would give us a much easier to audit change as we could
> remove the WARN_ON_ONCE above and just do a:
> 
> 	might_sleep_if(!async);
> 
> In fact this might be a good time to split up blk_mq_run_hw_queue
> into blk_mq_run_hw_queue and blk_mq_run_hw_queue_async and do
> away with the bool and have cristal clear calling conventions.
> 
> If we really need !async calles than can sleep we can add a specific
> blk_mq_run_hw_queue_atomic.

Hi Christoph,

blk_mq_run_hw_queue(hctx, false) is called from inside the block layer
with an RCU lock held if BLK_MQ_F_BLOCKING and with an SRCU lock held if
BLK_MQ_F_BLOCKING is not set. So I'm not sure whether it is possible to
simplify the above might_sleep_if() statement. From block/blk-mq.h:

/* run the code block in @dispatch_ops with rcu/srcu read lock held */
#define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
do {								\
	if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {		\
		struct blk_mq_tag_set *__tag_set = (q)->tag_set; \
		int srcu_idx;					\
								\
		might_sleep_if(check_sleep);			\
		srcu_idx = srcu_read_lock(__tag_set->srcu);	\
		(dispatch_ops);					\
		srcu_read_unlock(__tag_set->srcu, srcu_idx);	\
	} else {						\
		rcu_read_lock();				\
		(dispatch_ops);					\
		rcu_read_unlock();				\
	}							\
} while (0)

Thanks,

Bart.
