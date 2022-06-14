Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A665DC43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 16:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiFNQqY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242998AbiFNQqA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 12:46:00 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B0928723
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:45:59 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id r1so8194755plo.10
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=tuHSMAswfP4PDhL4XI5a/Llq4rMmNVqNDh3Ui2JM9rU=;
        b=UVs66hjteWar40H2T4ZiERzPasyzhMcLVln2NVAz6T7zj/318TAgN5IjDJCdc6FOBz
         P3mvgbqIRHoDTYcGxYWjNXE8IUQKk3XSPzwobZRdKr+ws/exZRdHXZafrsyUBij7u8MS
         X6C2S49G138ToGR58jXg0/xDz7u+Yun88B4RYdR74l+oQuwx7sqtw1lo1XGbl/Clziko
         zCRSHpFXO9+4FX7GjA62YLtEFlXP9JVzvce4bdoBqNodP2oerIAXBnQHvmEg8EZPPTMX
         mbk01coIZoXJ6fbeCXYMqTOSWufQZTmQ60cXVxaxU4awAFMg51k0FHrmSFDbZxgg3MRs
         P6Uw==
X-Gm-Message-State: AJIora8XkMT2ONxJAhAcbn7GetuonctePEv4LDRm9rYbftgAMMrk2wDf
        x+T/u8KITGOwosMXup42UHQ=
X-Google-Smtp-Source: AGRyM1sl2/QyN23Bh9vXZmMJcEtm2ae2dgvu7qiWC0RwOL+/NkIgeyj3t4A8uWlUfj5gVwnybtmQdw==
X-Received: by 2002:a17:903:230b:b0:167:5310:9eed with SMTP id d11-20020a170903230b00b0016753109eedmr5522694plh.46.1655225159302;
        Tue, 14 Jun 2022 09:45:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id i132-20020a62878a000000b0051827128aeasm7811406pfe.131.2022.06.14.09.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:45:58 -0700 (PDT)
Message-ID: <dd5e7690-ffad-69c2-5d73-07b35eedeae6@acm.org>
Date:   Tue, 14 Jun 2022 09:45:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/6] block: open code blk_max_size_offset in
 blk_rq_get_max_sectors
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220614090934.570632-1-hch@lst.de>
 <20220614090934.570632-4-hch@lst.de>
 <02468bd8-f2b3-1d5c-01dd-c9e9d6d5b09e@acm.org>
In-Reply-To: <02468bd8-f2b3-1d5c-01dd-c9e9d6d5b09e@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 09:43, Bart Van Assche wrote:
> On 6/14/22 02:09, Christoph Hellwig wrote:
>> blk_rq_get_max_sectors always uses q->limits.chunk_sectors as the
>> chunk_sectors argument, and already checks for max_sectors through the
>> call to blk_queue_get_max_sectors.  That means much of
>> blk_max_size_offset is not needed and open coding it simplifies the code.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/blk-merge.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index db2e03c8af7f4..df003ecfbd474 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -566,17 +566,18 @@ static inline unsigned int 
>> blk_rq_get_max_sectors(struct request *rq,
>>                             sector_t offset)
>>   {
>>       struct request_queue *q = rq->q;
>> +    unsigned int max_sectors;
>>       if (blk_rq_is_passthrough(rq))
>>           return q->limits.max_hw_sectors;
>> +    max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
>>       if (!q->limits.chunk_sectors ||
>>           req_op(rq) == REQ_OP_DISCARD ||
>>           req_op(rq) == REQ_OP_SECURE_ERASE)
>> -        return blk_queue_get_max_sectors(q, req_op(rq));
>> -
>> -    return min(blk_max_size_offset(q, offset, 0),
>> -            blk_queue_get_max_sectors(q, req_op(rq)));
>> +        return max_sectors;
>> +    return min(max_sectors,
>> +           blk_chunk_sectors_left(offset, q->limits.chunk_sectors));
>>   }
> 
> blk_set_default_limits() initializes chunk_sectors to zero and 
> blk_chunk_sectors_left() triggers a division by zero if a zero is passed 
> as the second argument. What am I missing?

Answering my own question: I overlooked one of the return statements.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
