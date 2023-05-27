Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EE4C77B73
	for <linux-block@archiver.kernel.org>; Sat, 27 May 2023 16:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjE0QUe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 May 2023 12:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE0QUd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 May 2023 12:20:33 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6AFC7
        for <linux-block@vger.kernel.org>; Sat, 27 May 2023 09:20:32 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53033a0b473so1177321a12.0
        for <linux-block@vger.kernel.org>; Sat, 27 May 2023 09:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685204432; x=1687796432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ojg4IqCV1oiJttYU3BXocew7RtoY4Ss8QKbhNf8EBWg=;
        b=d/g1L7joy9kbn+eOzLcG67RHeK1WFelrvm8fF4sEMGDkLv1lRglTJd+Dt9l5nc4RSy
         4kJ15tOsa10HIN0NWPKdzMVD55e4fvYsnc44bjwRCXKv8KxqjegRL8hVLmtOMyi3Kr+H
         YJCAuEWXO6xX9CjO6er89hWRIz/MYu8x1YLuOxHW7lMc8ZuBhjVbCGsGiAupp7xEgmWX
         tItYQx1r8bzEvhM8qvhDKHx9RKqN8pnDsWPUl0QmthnOJH4OsUotBDFfuWejIdezCbaM
         d5U35JQEGijdaUPoZ6FY5w1Zt3EamUqbc0C9PW2x1eHrptFq1F6A+bmIw/1S9h+nlGQ2
         pemA==
X-Gm-Message-State: AC+VfDzPZwvabIoMMyS2fxPt3DP50eleYUsUzE7fbPQNVduUcyFvVf+h
        9yH2atiiaxAXcjtSY2oAPjA=
X-Google-Smtp-Source: ACHHUZ5+eoJxh0/S3Xq5Bj/bJdwxRcizWRqrm8rQ9N8vTC3zfzY1ZORP4VXY2RLOtj8kI3vIs1TgPw==
X-Received: by 2002:a17:903:5d0:b0:1a9:7b5e:14ba with SMTP id kf16-20020a17090305d000b001a97b5e14bamr6084885plb.29.1685204431633;
        Sat, 27 May 2023 09:20:31 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902edd000b001b02162c866sm1928924plk.44.2023.05.27.09.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 09:20:30 -0700 (PDT)
Message-ID: <62e672ad-be3a-2ce8-ee11-c9682ab7d21d@acm.org>
Date:   Sat, 27 May 2023 09:20:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 3/9] block: Support configuring limits below the page
 size
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
 <20230522222554.525229-4-bvanassche@acm.org>
 <ZHF2Hbv5qBJl9CZl@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZHF2Hbv5qBJl9CZl@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/23 20:16, Luis Chamberlain wrote:
> So I see this as a critical fix too. And it gets me wondering what has
> happened for 512 byte controllers on 4K PAGE_SIZE?

What is a "512 byte controller"? Most storage controllers I'm familiar 
with support DMA segments well above 4 KiB.

>> @@ -126,6 +173,11 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>>   	unsigned int min_max_hw_sectors = PAGE_SIZE >> SECTOR_SHIFT;
>>   	unsigned int max_sectors;
>>   
>> +	if (max_hw_sectors < min_max_hw_sectors) {
>> +		blk_enable_sub_page_limits(limits);
>> +		min_max_hw_sectors = 1;
>> +	}
>> +
>>   	if (max_hw_sectors < min_max_hw_sectors) {
>>   		max_hw_sectors = min_max_hw_sectors;
>>   		pr_info("%s: set to minimum %u\n", __func__, max_hw_sectors);
> 
> It would seem like max_dev_sectors would have saved the day too,
> but that is said to be set by the "disk" on the documentation.
> I see scsi/sd.c and drivers/s390/block/dasd_*.c set this too,
> is that a layering violation, or was that to help perhaps with
> similar problems? If not could stroage controller have used this
> for this issue as well?

min_not_zero(max_hw_sectors, max_dev_sectors) is the maximum transfer 
size used by the block layer. max_hw_sectors typically represents the 
transfer limit of the DMA controller and max_dev_sectors typically 
represents the transfer limit of the storage device. If e.g. a RAID 
controller exists between the host and the storage devices these limits 
can be different.

> Could the documentation for blk_queue_max_hw_sectors() be enhanced to
> clarify this?

I will look into this.

> The way I'm thinking about this is, if this is a fix for stable too,
> what would a minimum safe stable fix be like? And then after whatever
> we need to make it better (non stable fixes).

Hmm ... doesn't the "upstream first" rule apply to stable kernels? 
Shouldn't only patches land in stable kernels that are already upstream 
instead of applying different patches on stable kernels?

Thanks,

Bart.
