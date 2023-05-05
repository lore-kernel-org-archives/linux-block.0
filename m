Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2E9C77B7F
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 16:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjEEQRD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 12:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEEQRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 12:17:01 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB7F1814D
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 09:16:53 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ab01bf474aso14522635ad.1
        for <linux-block@vger.kernel.org>; Fri, 05 May 2023 09:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683303412; x=1685895412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iowBHYHqsWhvZro/2jzYxDq+P9jtf4FaTWKQwnfBfMY=;
        b=bWULWN6s44yNc6i4OPjw0dggFyY45HWm5r5ARBV4PBzWRke/HePk6ZWYOLMpMBZXJH
         oXHWbUTbKJw3dCJ8wuH2EqfU98MiUJBRHGZzC3tm5f0wRB0IAs0/pbKRMBtCH8GzWFNQ
         qRGAhxz3A5P1FJH9D+3B1MkJWtLImowhhnyBbVwzZ5ctJLP/2/os1kmH1X3NjmmL+1DV
         kwguhVcVfUmw7rr+CC+TSahZe/43yy3m15eGn4KilHB0AA4H4/jzVGlq964AJaalxNJH
         oJo/5JsBROheKFqjUFAckd19FxEJvc6c5NK3qVAeWgV0TAwDvDkZS2EsR7bXx6VsU9Xy
         Cy2g==
X-Gm-Message-State: AC+VfDxR2JL1G6hbTwtEtdYyM3V4jifHXSmAb/njVp8NTe5RJOrN0YBJ
        cuj9MLZjIktYY4vIXCx+xxY=
X-Google-Smtp-Source: ACHHUZ4CjBOl9jjuoBrX5PGCakqL3ZPxScv1s2XqfJjUxNPs0gYDFax5Z592sSYvqptjJTBc3LWK9g==
X-Received: by 2002:a17:902:a501:b0:1a1:e01e:7279 with SMTP id s1-20020a170902a50100b001a1e01e7279mr1980740plq.4.1683303412562;
        Fri, 05 May 2023 09:16:52 -0700 (PDT)
Received: from [100.125.242.89] ([136.226.64.124])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709028bc900b001a4fecf79e4sm1974840plo.49.2023.05.05.09.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 09:16:52 -0700 (PDT)
Message-ID: <0b68d517-ac3d-3893-7449-143662c130be@acm.org>
Date:   Fri, 5 May 2023 09:16:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 08/11] block: mq-deadline: Reduce lock contention
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230503225208.2439206-1-bvanassche@acm.org>
 <20230503225208.2439206-9-bvanassche@acm.org> <20230505055626.GD11748@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230505055626.GD11748@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/4/23 22:56, Christoph Hellwig wrote:
> On Wed, May 03, 2023 at 03:52:05PM -0700, Bart Van Assche wrote:
>> blk_mq_free_requests() calls dd_finish_request() indirectly. Prevent
>> nested locking of dd->lock and dd->zone_lock by unlocking dd->lock
>> before calling blk_mq_free_requests().
> 
> Do you have a reproducer for this that we could wire up in blktests?
> Also please add a Fixes tag and move it to the beginning of the series.

Hi Christoph,

I think the nested locking is triggered during every run of blktests.
Additionally, I don't think that nested locking of spinlocks is a bug
so I'm surprised to see a request to add a Fixes: tag?

>>   static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>   			      blk_insert_t flags)
>> +	__must_hold(dd->lock)
>>   {
>>   	struct request_queue *q = hctx->queue;
>>   	struct deadline_data *dd = q->elevator->elevator_data;
>> @@ -784,7 +785,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>   	}
>>   
>>   	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>> +		spin_unlock(&dd->lock);
>>   		blk_mq_free_requests(&free);
>> +		spin_lock(&dd->lock);
>>   		return;
> 
> Fiven that free is a list, why don't we declare the free list in
> dd_insert_requests and just pass it to dd_insert_request and then do
> one single blk_mq_free_requests call after the loop?

That sounds like an interesting approach to me. I will make this change.

Thanks,

Bart.
