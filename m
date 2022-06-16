Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1129FC433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 21:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378332AbiFPVQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379009AbiFPVQQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 17:16:16 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B806C60D92
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 14:16:15 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id a17so272921pls.6
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 14:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UO3DB2P8RmslW2Pupywb0N1XROey2IelAqcxveMW1IY=;
        b=XKXePPFoIxJFK5ezJN1w6l3kAvnZPwePw0uNkLgh9wpq8urUfPLLKOlrWmlzSCk6dT
         c7pXiY0R6yJjcFVK9uTlMzq8kjJlZyFj03IwAB2W58jFcudZ3VpWTcz+nPuvYG8QuRqM
         xDLslswmbPwRpfuzmu54fwDBAwmvh5l1tiYAz8jKTEWqRK9R9NCGKLLtBausjnzvM1OC
         Wuhwo8bEs3HBAEmPZMFl54ha+ykzYcibvBnt+Pqg++FqftxGBZ8KcNXoXbv6ElxJMRoi
         NIwVh7h5HhxkkqxOMtYkrbZAQ4ExizjjlsmhDMdZCXBuxu5hXeZuQS15r7q1MlzwJQL2
         hpTg==
X-Gm-Message-State: AJIora+4NsRbu9Dq1eYCYCWuqOstslBUT+2qze/l2HIwytRyV/MxdroL
        2OJLHsbfLkkU5cmDSqeRKlHIapwmAro=
X-Google-Smtp-Source: AGRyM1vg54VPHdizQnqhB7Jtmc/LmG+caH2OAu42deIr6w3BUkrq0ryXduQjsVkGl47wBP1LqR5aNw==
X-Received: by 2002:a17:90a:17ce:b0:1ea:c77d:c99e with SMTP id q72-20020a17090a17ce00b001eac77dc99emr16689573pja.63.1655414175124;
        Thu, 16 Jun 2022 14:16:15 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:55f1:e134:5606:bb89? ([2620:15c:211:201:55f1:e134:5606:bb89])
        by smtp.gmail.com with ESMTPSA id p15-20020a1709027ecf00b001674b0d4e4esm2034492plb.241.2022.06.16.14.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 14:16:14 -0700 (PDT)
Message-ID: <a15d7dcc-20a3-d7dc-7813-f7a4600647fc@acm.org>
Date:   Thu, 16 Jun 2022 14:16:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/5] block: Introduce the blk_rq_is_seq_write() function
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-2-bvanassche@acm.org>
 <96fa5291-a945-c745-2ee9-e453d85c1bee@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <96fa5291-a945-c745-2ee9-e453d85c1bee@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/22 13:41, Jens Axboe wrote:
> On 6/14/22 11:49 AM, Bart Van Assche wrote:
>> Introduce a function that makes it easy to verify whether a write
>> request is for a sequential write required or sequential write preferred
>> zone.
>>
>> Cc: Damien Le Moal <damien.lemoal@wdc.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   include/linux/blk-mq.h | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index e2d9daf7e8dd..3e7feb48105f 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -1129,6 +1129,15 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
>>   	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
>>   }
>>   
>> +/**
>> + * blk_rq_is_seq_write() - Whether @rq is a write request for a sequential zone.
>> + * @rq: Request to examine.
>> + */
>> +static inline bool blk_rq_is_seq_write(struct request *rq)
>> +{
>> +	return req_op(rq) == REQ_OP_WRITE && blk_rq_zone_is_seq(rq);
>> +}
> 
> This should include something telling us it's a zone thing, because it
> sounds generic. blk_rq_is_zoned_seq_write()?

Agreed. I will rename this function before I repost this patch series.

Thanks,

Bart.

