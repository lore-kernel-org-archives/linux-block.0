Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4535FC433DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 13:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2106E2078B
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 13:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="TmcKxcvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgGHNxF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgGHNxF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 09:53:05 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84EAC061A0B
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 06:53:04 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id by13so32016030edb.11
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ncvb6VeoaaXfIcdBHstcjJpioUW0rI3XEPCr4yiRdjE=;
        b=TmcKxcvBF4N3go1Iss5nYU5Ywl8n9jVe1JzqyoHRkDdFKf35xIqFb3geXPVetwi8QU
         40kjtIYMRMOBDM2MnWIw7g231CVctMIeUgyLpmvS347pPcQq/6Om3op4vHBuB8GZSkyW
         G6jrP0zO/V/uzdS+JPqUcUvQf0mdDj9WGauE3g4j9xbN8f9yHoHN7pmDAcOwAF74tH8W
         WryJYe8kOTq+SOWzgfOz6BEm/2KXG7JK4O4pMF6VGBm3kaJ/zsOmKk/4jG9C/QzAK3IB
         kZPfFvWJjqkvFmd6RAheZnUAxaoSskzjkDGDzfqsko982Gw2yo0rShSoUJ+Bye0FShQ3
         ggLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ncvb6VeoaaXfIcdBHstcjJpioUW0rI3XEPCr4yiRdjE=;
        b=gAPcUHExBgQi3I7mjy+r6Cgy23tjo+Kukb6pA+8SRF7je1raXUgYNAfXnJv2E3QalQ
         ufvH7XGZ8x9TtHZIEmTDDu1C9o4W5X2UkoS2qbMB70qnI+WXE/xzzQ8/VuEckCh1qr/v
         bWJ5Wgomm+0OxlQSze5sNDAeyuE8wdCkQhwedLuP/9/TQTnk/N4EIirDw9qblKq9WS2l
         YAf2gT60Blvg9IcAZOQKPXBxlGzApAu6m+Fh5YoE2ogwMeiTrx65+QoMpKOeVi9pXTdB
         DP6gzLyUa1VQmm8X+pxc2OkALVJhB/DkIs+j91Hr/FqkCE7fcf8OII7IRHP0uKRYpMNz
         rOQA==
X-Gm-Message-State: AOAM531/Al3YXsIK6w6R2Z5A80X7sZHH+ZFrJpRm3kbi+/W9bgL+imxG
        RoiWK0jYp/+Hs64QZ6u2f9sUMQ==
X-Google-Smtp-Source: ABdhPJysxgwhCjV7WAfdYK8zmBz47BscJbNq/a2N/7oiidqDwg/jk+kqbZTIpjmjzM76lQCAXTP/NQ==
X-Received: by 2002:a05:6402:1ade:: with SMTP id ba30mr7065017edb.231.1594216383034;
        Wed, 08 Jul 2020 06:53:03 -0700 (PDT)
Received: from [192.168.178.33] (i5C746C99.versanet.de. [92.116.108.153])
        by smtp.gmail.com with ESMTPSA id o17sm2051708ejb.105.2020.07.08.06.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 06:53:02 -0700 (PDT)
Subject: Re: [PATCH RFC 1/5] block: return ns precision from
 disk_start_io_acct
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
 <20200708075819.4531-2-guoqing.jiang@cloud.ionos.com>
 <20200708132704.GB3340386@T590>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <ad89a0b2-3b40-b515-2120-85bc0274165b@cloud.ionos.com>
Date:   Wed, 8 Jul 2020 15:53:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708132704.GB3340386@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 7/8/20 3:27 PM, Ming Lei wrote:
> On Wed, Jul 08, 2020 at 09:58:15AM +0200, Guoqing Jiang wrote:
>> Currently the duration accounting of bio based driver is converted from
>> jiffies to ns, means it could be less accurate as request based driver.
>>
>> So let disk_start_io_acct return from ns precision, instead of convert
>> jiffies to ns in disk_end_io_acct.
>>
>> Cc: Philipp Reisner <philipp.reisner@linbit.com>
>> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
>> Cc: drbd-dev@lists.linbit.com
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   block/blk-core.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index d9d632639bd1..0e806a8c62fb 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1466,6 +1466,7 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
>>   	struct hd_struct *part = &disk->part0;
>>   	const int sgrp = op_stat_group(op);
>>   	unsigned long now = READ_ONCE(jiffies);
>> +	unsigned long start_ns = ktime_get_ns();
>>   
>>   	part_stat_lock();
>>   	update_io_ticks(part, now, false);
>> @@ -1474,7 +1475,7 @@ unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
>>   	part_stat_local_inc(part, in_flight[op_is_write(op)]);
>>   	part_stat_unlock();
>>   
>> -	return now;
>> +	return start_ns;
>>   }
>>   EXPORT_SYMBOL(disk_start_io_acct);
>>   
>> @@ -1484,11 +1485,11 @@ void disk_end_io_acct(struct gendisk *disk, unsigned int op,
>>   	struct hd_struct *part = &disk->part0;
>>   	const int sgrp = op_stat_group(op);
>>   	unsigned long now = READ_ONCE(jiffies);
>> -	unsigned long duration = now - start_time;
>> +	unsigned long duration = ktime_get_ns() - start_time;
>>   
>>   	part_stat_lock();
>>   	update_io_ticks(part, now, true);
>> -	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
>> +	part_stat_add(part, nsecs[sgrp], duration);
>>   	part_stat_local_dec(part, in_flight[op_is_write(op)]);
>>   	part_stat_unlock();
> Hi Guoqing,
>
> Cost of ktime_get_ns() can be observed as not cheap in high IOPS device,

Could you share some links about it? Thanks.

> so not sure the conversion is good. Also could you share what benefit we can
> get with this change?

Without the conversion, we have to track io latency with jiffies in 4th 
patch.
Then with HZ=100, some rows (such as 1ms, 2ms and 4ms) in that table
don't make sense.

Thanks,
Guoqing
