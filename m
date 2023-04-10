Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EC1C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 16:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDJQ7k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 12:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjDJQ7j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 12:59:39 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C4E1FC2
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 09:59:38 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id e13so4850387plc.12
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 09:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681145978; x=1683737978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AC2EHKiwwllyAylJmsH314maI0pFIg9z3qHyTMCDLOY=;
        b=mESE0OXMfZgh6knuHZvdUWkfOOqrNxlgYd9JHEafQ3k4tpazSLXd9LO67BWrV9WM6a
         UVWNtPFyk2n1lCj+aLy/SQP7oLKetXzLOwS3agKu6g8BCVZmcoxn2NXkRtmkn+ckJzSb
         Z3k58G2Q5OBbAaHQkhreyIPypW8g/tTZVydqdv6KPMsy+LZ/s8nvZzB7zG/lxVAjQX9J
         O4L6co/KowWA4uWNTWir9a12bQ75KiEKqsVrTQHqKabrmfe6yFNqjGDyaqslGb3nNB6r
         31af3WcCDwDZLqoi8ScNYkvF+X9EQA7dl4jo03OYh4RwRu8wYSlU1mxfclA98EdR/XAv
         HxfA==
X-Gm-Message-State: AAQBX9clmqsZTqIVgweoEbKvqiZpG4MnIRgI5oPtY++mvOfVwb1xBraP
        aZx792Gdmrva4esQasNA1M0=
X-Google-Smtp-Source: AKy350avUM7MhmMKnmQT0YHOxXUv9NIJYbPvW+XmQlhIwME/cRRC1IJX1XzxdJYeIJkmD1HmRgYnqA==
X-Received: by 2002:a17:90b:3852:b0:23f:9fac:6b31 with SMTP id nl18-20020a17090b385200b0023f9fac6b31mr13562331pjb.25.1681145978087;
        Mon, 10 Apr 2023 09:59:38 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:11fd:f446:f156:c8? ([2620:15c:211:201:11fd:f446:f156:c8])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a3e0300b0023b4d4ca3a9sm7413219pjc.50.2023.04.10.09.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 09:59:37 -0700 (PDT)
Message-ID: <d211b683-5b34-0c5b-7dc5-d781cbf19b8b@acm.org>
Date:   Mon, 10 Apr 2023 09:59:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 03/12] block: Send requeued requests to the I/O
 scheduler
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-4-bvanassche@acm.org>
 <61231e6f-81c2-a945-d8f2-8f1b2761b2f9@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <61231e6f-81c2-a945-d8f2-8f1b2761b2f9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/23 00:53, Damien Le Moal wrote:
> On 4/8/23 08:58, Bart Van Assche wrote:
>> @@ -2065,9 +2057,14 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>>   		if (nr_budgets)
>>   			blk_mq_release_budgets(q, list);
>>   
>> -		spin_lock(&hctx->lock);
>> -		list_splice_tail_init(list, &hctx->dispatch);
>> -		spin_unlock(&hctx->lock);
>> +		if (!q->elevator) {
>> +			spin_lock(&hctx->lock);
>> +			list_splice_tail_init(list, &hctx->dispatch);
>> +			spin_unlock(&hctx->lock);
>> +		} else {
>> +			q->elevator->type->ops.insert_requests(hctx, list,
>> +							/*at_head=*/true);
> 
> Dispatch at head = true ? Why ? This seems wrong. It may be valid for the
> requeue case (even then, I am not convinced), but looks very wrong for the
> regular dispatch case.

Hi Damien,

blk_mq_sched_dispatch_requests() dispatches requests from hctx->dispatch 
before it checks whether any requests can be dispatched from the I/O 
scheduler. As one can see in the quoted change above, 
blk_mq_dispatch_rq_list() moves any requests that could not be 
dispatched to the hctx->dispatch dispatch list. Since 
blk_mq_sched_dispatch_requests() processes the dispatch list first, this 
comes down to insertion at the head of the list. Hence the at_head=true 
argument in the call to insert_requests().

Thanks,

Bart.
