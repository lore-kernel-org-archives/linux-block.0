Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA01C7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 19:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbjEWTfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 15:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbjEWTfn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 15:35:43 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D51AE42
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 12:35:20 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-64d24136685so194262b3a.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 12:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870480; x=1687462480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l56aD8/mdRLQCsrjMlRAQbntAbaQFCPQZG8LTFt9CKM=;
        b=hP4+ZKGO9+n5dfz87iJmRx6sg2LZ4rt2RXLrdxOEqY88XX1UNE9YGctHUve45eP2bV
         OmUrtNYVk5ajR9HD0b5yDkGcAC2oAbu9s6vA31syg9XJXM9q1hh5KT2jyVcFHHdFWyiM
         88JKk/kKfwEvu/D9KNQzfDHgEAMDNXRGyYVQuGft/66swMYq+17Ke6t/dKI/Ff3UwB9D
         ztEMLy8gYkj4DmFZ+77aFD5VknuLkK7ah+tp3jazN5IwXrdYt7qmAF46PO4jcnwwsEDU
         T5N45I8Q2ARCuOG+3h9Cf4ZrncpaFjsr+5chuimYwvAg/hiiSUzImqWKi7JXdEmzhJXp
         yttg==
X-Gm-Message-State: AC+VfDw2Cr0bSuPhb9ABbrL9SleZ/9wZAVqJYHratXFcDuf5+8R6CgzB
        JstR7fWh8MsIvPDA4uo7Gf8=
X-Google-Smtp-Source: ACHHUZ7UPUZuvX3h97y1lfsHKbn4xiQw2Xs3hhS2dTZpMGB4g5j06Q80R48wmJOuIJ6Z/iYa9Ht3Zw==
X-Received: by 2002:a05:6a00:4294:b0:64d:2a87:2596 with SMTP id bx20-20020a056a00429400b0064d2a872596mr75322pfb.10.1684870480359;
        Tue, 23 May 2023 12:34:40 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:24d2:69cd:ef9a:8f83? ([2620:15c:211:201:24d2:69cd:ef9a:8f83])
        by smtp.gmail.com with ESMTPSA id a20-20020aa780d4000000b005e0699464e3sm6119514pfn.206.2023.05.23.12.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 12:34:39 -0700 (PDT)
Message-ID: <41dd1a93-2491-a094-dc61-f424b51af6cb@acm.org>
Date:   Tue, 23 May 2023 12:34:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3 4/7] block: Make it easier to debug zoned write
 reordering
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-5-bvanassche@acm.org> <20230523071957.GD8758@lst.de>
Content-Language: en-US
In-Reply-To: <20230523071957.GD8758@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 00:19, Christoph Hellwig wrote:
> On Mon, May 22, 2023 at 11:38:39AM -0700, Bart Van Assche wrote:
>> @@ -2429,6 +2429,9 @@ static void blk_mq_request_bypass_insert(struct request *rq, blk_insert_t flags)
>>   {
>>   	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>>   
>> +	WARN_ON_ONCE(rq->rq_flags & RQF_USE_SCHED &&
>> +		     blk_rq_is_seq_zoned_write(rq));
>> +
>>   	spin_lock(&hctx->lock);
>>   	if (flags & BLK_MQ_INSERT_AT_HEAD)
>>   		list_add(&rq->queuelist, &hctx->dispatch);
>> @@ -2562,6 +2565,9 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>>   	};
>>   	blk_status_t ret;
>>   
>> +	WARN_ON_ONCE(rq->rq_flags & RQF_USE_SCHED &&
>> +		     blk_rq_is_seq_zoned_write(rq));
> 
> What makes sequential writes here special vs other requests that are
> supposed to be using the scheduler and not a bypass?

Hi Christoph,

If some REQ_OP_WRITE or REQ_OP_WRITE_ZEROES requests are submitted to 
the I/O scheduler and others bypass the I/O scheduler this may lead to 
reordering. Hence this patch that triggers a kernel warning if any 
REQ_OP_WRITE or REQ_OP_WRITE_ZEROES requests bypass the I/O scheduler.

Thanks,

Bart.
