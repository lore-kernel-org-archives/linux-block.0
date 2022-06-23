Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E972AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 23:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiFWXTR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiFWXTP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 19:19:15 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF2D4B1C4
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:19:15 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id jb13so547401plb.9
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0RVQTbCxjFXFbdbOPCmgbtV8zJzDZdXX+nhdoQ8g6P0=;
        b=LT1LN7lkb3zwCUZUlLiFILuFv6zYl6D8yy/+CrtSdz8o256hLUXqavHRgtSyYYUKao
         67UX+dSZBNwKCJCUmZNxxWnle5mzEHIL8ZQJ1RkmzSBz6YciJiHjZXq++bdtYuM4EI/s
         HDEKEu/7PUI+B+wHJi9ng3dzeW/WPUs7CkbyJkyI0gIUD0A+76UEaj9a0VQ0jifM2vjy
         oLrzTco2NCqHjWA3T3YY6iF0WLAKw9EwhSeBgTHAcIsK1pMvkTnrh2Hv5bVrxhfUlLI3
         ktylncj6/2x5/fMHpj2gHp8ibdseg0rmZQ8JmhFeOI0Dz2xS2eGREZTQmsfwhhTADvvW
         hf8A==
X-Gm-Message-State: AJIora9OhJbk0qtZhK59V0wPPOc7GTNfB2QTgfA7tvnmHFC2PsgntCQm
        GzGdawoWa9hlzmz2AqSIIByqHayDJPjHbQ==
X-Google-Smtp-Source: AGRyM1v+gMqgf0lPpPlR8AWAf+0Wn8wvRFx1ArTD5Vf+lhBYYvo6I26SQ8ScPNkBJWPjcg1yaQx69A==
X-Received: by 2002:a17:90a:560b:b0:1ec:75f3:1f8d with SMTP id r11-20020a17090a560b00b001ec75f31f8dmr404229pjf.95.1656026354363;
        Thu, 23 Jun 2022 16:19:14 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:85b2:5fa3:f71e:1b43? ([2620:15c:211:201:85b2:5fa3:f71e:1b43])
        by smtp.gmail.com with ESMTPSA id h6-20020a17090a3d0600b001eab99a42efsm270726pjc.31.2022.06.23.16.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 16:19:13 -0700 (PDT)
Message-ID: <d5896d8a-a30d-2778-58c4-2c4b998da6d3@acm.org>
Date:   Thu, 23 Jun 2022 16:19:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-52-bvanassche@acm.org>
 <c7de3cfd-ec60-05ab-d05c-a9c356ba6cf6@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c7de3cfd-ec60-05ab-d05c-a9c356ba6cf6@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 15:48, Damien Le Moal wrote:
> On 6/24/22 03:05, Bart Van Assche wrote:
>> Since __bitwise types are not supported by the tracing infrastructure, store
>> the operation type as an int in the tracing event.
>>
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Naohiro Aota <naohiro.aota@wdc.com>
>> Cc: Johannes Thumshirn <jth@kernel.org>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   fs/zonefs/trace.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
>> index 21501da764bd..8707e1c3023c 100644
>> --- a/fs/zonefs/trace.h
>> +++ b/fs/zonefs/trace.h
>> @@ -32,15 +32,15 @@ TRACE_EVENT(zonefs_zone_mgmt,
>>   	    TP_fast_assign(
>>   			   __entry->dev = inode->i_sb->s_dev;
>>   			   __entry->ino = inode->i_ino;
>> -			   __entry->op = op;
>> +			   __entry->op = (__force int)op;
>>   			   __entry->sector = ZONEFS_I(inode)->i_zsector;
>>   			   __entry->nr_sectors =
>>   				   ZONEFS_I(inode)->i_zone_size >> SECTOR_SHIFT;
>>   	    ),
>>   	    TP_printk("bdev=(%d,%d), ino=%lu op=%s, sector=%llu, nr_sectors=%llu",
>>   		      show_dev(__entry->dev), (unsigned long)__entry->ino,
>> -		      blk_op_str(__entry->op), __entry->sector,
>> -		      __entry->nr_sectors
>> +		      blk_op_str((__force enum req_op)__entry->op),
>> +		      __entry->sector, __entry->nr_sectors
>>   	    )
>>   );
>>   
> 
> How do you get the warning ? I always run sparse and have not seen any
> warning... Looks good anyway, will apply.

Hi Damien,

The warning fixed by this patch has been introduced by the patch that 
changes enum req_op from a regular enum into a bitwise enum. The warning 
does not occur with Jens' latest for-next branch.

Thanks,

Bart.


