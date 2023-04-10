Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14955C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 17:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjDJRKA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 13:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjDJRJ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 13:09:58 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BD3272B
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 10:09:43 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id n14so30304025plc.8
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 10:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146582; x=1683738582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OH97FyiGqDA2zARVsFi1ex27JD7c8pRMqyADqs3XcxA=;
        b=DdATwu5ttaXUagJjnNd1EwOovYlt0xNMvsWj4YY4fmOTMyOvbYzez1iafcUSYVl9vq
         wmXKWVIDncW/7YCUmtmM0r+45/57uguWy2PWzkCiunsEkHAmEYk0qYSXQLdGMom+/vDg
         b8gfpo7EzeaZj9WCOKpT/IFLh1ihHCAiJdrbNuK9PLaTD9RinDFWz1tLp6nCa+YMjyx3
         VkAIiGJs3DTIR5XeCTzhiUPSMcnVlv/cHrqRlyuSx8L8KvUJFSwLR/EB1JYuCiqZE1Ii
         ifTMFoiuBje8FbVCnEHVAzeCbGkd9PxKQgf+op6JdOzu9L37udAJZpQI9Ds2fp56Ax8E
         hJig==
X-Gm-Message-State: AAQBX9e8vKP9B9E051aR7XNTEcJT7Z23H8hCh3+sxH6C6/3UI+b8qKmN
        ltYGfxenNcrAD7q149pCwsd93iEa5bM=
X-Google-Smtp-Source: AKy350Zvd6oz5A7QKCkNK7+uRdq0qfYU7chEaRXWpo/g3gQRIPLiKoDkRHrNuTZrKMxYxoSeQyvP2w==
X-Received: by 2002:a17:903:6c4:b0:1a6:4606:6e06 with SMTP id kj4-20020a17090306c400b001a646066e06mr2549710plb.17.1681146581780;
        Mon, 10 Apr 2023 10:09:41 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:11fd:f446:f156:c8? ([2620:15c:211:201:11fd:f446:f156:c8])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902744200b001a5266b90aesm4748650plt.122.2023.04.10.10.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 10:09:41 -0700 (PDT)
Message-ID: <a3355a43-6c2e-005e-06cc-a050a75ad623@acm.org>
Date:   Mon, 10 Apr 2023 10:09:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 09/12] block: mq-deadline: Disable head insertion for
 zoned writes
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-10-bvanassche@acm.org>
 <81ccc853-63f6-5be4-7ab3-fc95c128b7f9@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <81ccc853-63f6-5be4-7ab3-fc95c128b7f9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/23 01:10, Damien Le Moal wrote:
> On 4/8/23 08:58, Bart Van Assche wrote:
>> Make sure that zoned writes are submitted in LBA order.
>>
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Cc: Mike Snitzer <snitzer@kernel.org>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   block/mq-deadline.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>> index 50a9d3b0a291..891ee0da73ac 100644
>> --- a/block/mq-deadline.c
>> +++ b/block/mq-deadline.c
>> @@ -798,7 +798,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>   
>>   	trace_block_rq_insert(rq);
>>   
>> -	if (at_head) {
>> +	if (at_head && !blk_rq_is_seq_zoned_write(rq)) {
>>   		list_add(&rq->queuelist, &per_prio->dispatch);
>>   		rq->fifo_time = jiffies;
>>   	} else {
> 
> Looks OK, but I would prefer us addressing the caller site using at_head = true,
> as that is almost always completely wrong for sequential zone writes.
> That would reduce the number of places we check for blk_rq_is_seq_zoned_write().

Hi Damien,

The code for deciding whether or not to use head insertion is spread all 
over the block layer. I prefer a single additional check to disable head 
insertion instead of modifying all the code that decides whether or not 
to use head-insertion. Additionally, the call to 
blk_rq_is_seq_zoned_write() would remain if the decision whether or not 
to use head insertion is moved into the callers of 
elevator_type.insert_request.

Thanks,

Bart.
