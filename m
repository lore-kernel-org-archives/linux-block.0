Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31420C43331
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 17:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF0C2051A
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 17:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsbrGR1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgCXRRa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:17:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44201 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgCXRRa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 13:17:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so7647573plr.11
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2020 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZGYRf7bljlV95062/kAIKLYYfvkZE5yLnQI9lCDJN/o=;
        b=CsbrGR1kakDt6gdEAN2mnN4rODtq3EuL3ugdMU8VFJU3a52q/D9r9aEung8lJYoe52
         vzM/Xc5d3U/CgEiqyLV8fsyyR46cz49XOLjdWRFwVy7svFnXzu9ScHHSrsoYiQ735jMl
         ceMOKstmieXXE3e1LyQf6rHu7ArbQMcmLLPPh2Hd2ON2J864s9CzBzCwIcj6bcFD9v69
         EnF7CQeF7vpnBmYbvhGVbFsKeQsVdPHqbZtUpTtEGP7t3mBfehpkLt12vPgg4BJHeRiD
         EzuUyEAMi25X59mGhwNHaEvkB3qoOfd5g2NBUDh204R4H9b0tKGELCTlUb+wnrn0+dIw
         IQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZGYRf7bljlV95062/kAIKLYYfvkZE5yLnQI9lCDJN/o=;
        b=T3XiH4qpbBrcD97iWU6d+Cae+kUF7TbMliFJDj/ZD/g6sHOnfZSrMUUSVuVNKvau3Q
         5i1OI310ekHjkuKN/qbR7fmVIOWYPkGsvhsmpAmxFvpi1Gto6LSUFQVTmUgPZd8rKvGj
         NoqSUAjpWn9PHFI4xZx6LOHxMd5FycdcU+LOEc5AfI0NhMsjDkUv7jYI77L9/YF3yIRH
         R19ni4xPpr8bHccxCTaEXW8OHeyZyMKkzKAuYURuCbt3ZOBkNlMsyAnjQcixwKwvWfYD
         py9F8epddzbiprCGCJcH1lLtjvfruFyPjm7oriLbKL74m5lHYal+1TTuZn0XY494z1vi
         YRig==
X-Gm-Message-State: ANhLgQ1dY8VrSIiBBo0/JTWzUEFj1t7VgzqrEaBksXN/8/joXYv6ZLil
        1TFuvQ/z+OkmVoH/H4sBjoM=
X-Google-Smtp-Source: ADFU+vuZIr/pgGhT1UOwU8wrrDA3p2As5Cza9affk2zUmovV5tMCSTipVd4R3F2K03PHkZyZ2ECVeg==
X-Received: by 2002:a17:90a:9f88:: with SMTP id o8mr6526752pjp.145.1585070248234;
        Tue, 24 Mar 2020 10:17:28 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a? ([240b:10:2720:5510:a182:288:3ffa:432a])
        by smtp.gmail.com with ESMTPSA id 144sm6660646pgd.29.2020.03.24.10.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 10:17:27 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
To:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <2293733b-77d7-6fbb-a81a-b68c10656757@suse.de>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <5e296f02-27a4-5c6e-35a4-5bd6a53bef3c@gmail.com>
Date:   Wed, 25 Mar 2020 02:17:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2293733b-77d7-6fbb-a81a-b68c10656757@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2020/03/24 16:16, Hannes Reinecke wrote:
> On 3/23/20 7:23 PM, Tokunori Ikegami wrote:
>> Currently data length can be specified as UINT_MAX but failed.
>> This is caused by the max segments parameter limit set as USHRT_MAX.
>> To resolve this issue change to increase the value limit range.
>>
>> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
>> Cc: linux-block@vger.kernel.org
>> Cc: linux-nvme@lists.infradead.org
>> ---
>>   block/blk-settings.c     | 2 +-
>>   drivers/nvme/host/core.c | 2 +-
>>   include/linux/blkdev.h   | 7 ++++---
>>   3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index c8eda2e7b91e..ed40bda573c2 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -266,7 +266,7 @@ EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
>>    *    Enables a low level driver to set an upper limit on the 
>> number of
>>    *    hw data segments in a request.
>>    **/
>> -void blk_queue_max_segments(struct request_queue *q, unsigned short 
>> max_segments)
>> +void blk_queue_max_segments(struct request_queue *q, unsigned int 
>> max_segments)
>>   {
>>       if (!max_segments) {
>>           max_segments = 1;
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index a4d8c90ee7cc..2b48aab0969e 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2193,7 +2193,7 @@ static void nvme_set_queue_limits(struct 
>> nvme_ctrl *ctrl,
>>             max_segments = min_not_zero(max_segments, 
>> ctrl->max_segments);
>>           blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
>> -        blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
>> +        blk_queue_max_segments(q, min_t(u32, max_segments, UINT_MAX));
>>       }
>>       if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
>>           is_power_of_2(ctrl->max_hw_sectors))
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index f629d40c645c..4f4224e20c28 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -338,8 +338,8 @@ struct queue_limits {
>>       unsigned int        max_write_zeroes_sectors;
>>       unsigned int        discard_granularity;
>>       unsigned int        discard_alignment;
>> +    unsigned int        max_segments;
>>   -    unsigned short        max_segments;
>>       unsigned short        max_integrity_segments;
>>       unsigned short        max_discard_segments;
>>   @@ -1067,7 +1067,8 @@ extern void blk_queue_make_request(struct 
>> request_queue *, make_request_fn *);
>>   extern void blk_queue_bounce_limit(struct request_queue *, u64);
>>   extern void blk_queue_max_hw_sectors(struct request_queue *, 
>> unsigned int);
>>   extern void blk_queue_chunk_sectors(struct request_queue *, 
>> unsigned int);
>> -extern void blk_queue_max_segments(struct request_queue *, unsigned 
>> short);
>> +extern void blk_queue_max_segments(struct request_queue *q,
>> +                   unsigned int max_segments);
>>   extern void blk_queue_max_discard_segments(struct request_queue *,
>>           unsigned short);
>>   extern void blk_queue_max_segment_size(struct request_queue *, 
>> unsigned int);
>> @@ -1276,7 +1277,7 @@ static inline unsigned int 
>> queue_max_hw_sectors(const struct request_queue *q)
>>       return q->limits.max_hw_sectors;
>>   }
>>   -static inline unsigned short queue_max_segments(const struct 
>> request_queue *q)
>> +static inline unsigned int queue_max_segments(const struct 
>> request_queue *q)
>>   {
>>       return q->limits.max_segments;
>>   }
>>
> One would assume that the same reasoning goes for 
> max_integrity_segment, no?

The error case itself can be resolved by the change without the 
max_integrity_segment changes.
Also the value is set to 0 as default and set to 1 by the nvme driver so 
it seems that not necessary to change for this case.

>
> Otherwise looks good.
>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
Thanks for your reviewing.
>
> Cheers,
>
> Hannes
