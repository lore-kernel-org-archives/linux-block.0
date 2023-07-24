Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F126DC001B0
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 21:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGXVjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGXVjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 17:39:18 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D37D8
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 14:39:17 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso2712865b3a.3
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 14:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234757; x=1690839557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMOJZoB1ZiGHHnf61HdAHIDN8pvTrNFcKOiHD/l1/KA=;
        b=FCLJo9kYV8sMK/GImRjf9AKLBAHY5kCrcyjkOsMaIdPvgFm+mrMMv1GFc2z2eo0XLJ
         EAfWdLU2lQXPBuGyB2GCAIucRM4n6oze5xNSc9dl/exbYNMvCamOU6nhrED43Nm3h9Bm
         yHBqt+RMc35c9HcWjKGKocsmLqQerXoeASC5ulG8OT1Q32OWyBqGjaMkpiC6q9zEBkkw
         8r4d8atJ1ZyUqoFwO6kXXRp6IzqCZvJzUOBMw3aROt2B5P6CeYSzt06KiE7wGydzWLL/
         WjXJsxOIX+GClL1014vuol5cPls+eSxA4ZwmiOlx/FdgSQKlkdruHfPlnLKExnwbfrwx
         q0UA==
X-Gm-Message-State: ABy/qLZOaPRK4NCxdy837sEt+UxnNsAFnUsxs2Ax9H5MABrNep8MxsMy
        TM4zJPeNFNkkfX9Yu0nXCng=
X-Google-Smtp-Source: APBJJlE2eYJfaTEJ/EcZJDT3nyk7t9mpjb8aJ+fmMU4rZHLlxn3+Bx04d1qa2uPpift7dXeV/4HswQ==
X-Received: by 2002:a05:6a20:13da:b0:138:92ef:78f9 with SMTP id ho26-20020a056a2013da00b0013892ef78f9mr5966609pzc.6.1690234756781;
        Mon, 24 Jul 2023 14:39:16 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:bda6:6519:2a73:345e? ([2620:15c:211:201:bda6:6519:2a73:345e])
        by smtp.gmail.com with ESMTPSA id ff12-20020a056a002f4c00b005d22639b577sm8094818pfb.165.2023.07.24.14.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 14:39:16 -0700 (PDT)
Message-ID: <d4207aa2-8e01-ea13-4bd5-7c941c6f01df@acm.org>
Date:   Mon, 24 Jul 2023 14:39:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/5] block/mq-deadline: Only use zone locking if
 necessary
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230710180210.1582299-1-bvanassche@acm.org>
 <20230710180210.1582299-3-bvanassche@acm.org>
 <98e2f100-76b0-c28f-bb02-4a41c1b71f5e@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <98e2f100-76b0-c28f-bb02-4a41c1b71f5e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/17/23 23:38, Damien Le Moal wrote:
> On 7/11/23 03:01, Bart Van Assche wrote:
>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>> index 6aa5daf7ae32..0bed2bdeed89 100644
>> --- a/block/mq-deadline.c
>> +++ b/block/mq-deadline.c
>> @@ -353,7 +353,8 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>>   		return NULL;
>>   
>>   	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
>> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
>> +	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
>> +	    blk_queue_pipeline_zoned_writes(rq->q))
> 
> What about using blk_req_needs_zone_write_lock() ?

Hmm ... how would using blk_req_needs_zone_write_lock() improve the 
generated code? blk_queue_pipeline_zoned_writes() can be inlined and 
only tests a single bit (a request queue flag) while 
blk_req_needs_zone_write_lock() cannot be inlined by the compiler 
because it has been defined in a .c file. Additionally, 
blk_req_needs_zone_write_lock() has to dereference more pointers than 
blk_queue_pipeline_zoned_writes(). From block/blk-zoned.c:

bool blk_req_needs_zone_write_lock(struct request *rq)
{
	if (!rq->q->disk->seq_zones_wlock)
		return false;

	return blk_rq_is_seq_zoned_write(rq);
}
EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);

Thanks,

Bart.
