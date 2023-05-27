Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CCDC77B7C
	for <linux-block@archiver.kernel.org>; Sat, 27 May 2023 16:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjE0QJ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 May 2023 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjE0QJx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 May 2023 12:09:53 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52219C3
        for <linux-block@vger.kernel.org>; Sat, 27 May 2023 09:09:52 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ae3fe67980so16843505ad.3
        for <linux-block@vger.kernel.org>; Sat, 27 May 2023 09:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685203791; x=1687795791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiQhmIqcu7JM0y3Q8ClGIplJIZSVGBBQywtY0HCYB4s=;
        b=D2GDINJRK+8osyCKhYv1yRC4kpQ60tojl+wy6FvBj5wNuhPKSkyooDqItIqZf8XVI2
         SYB2Z9h805au50HXihsEVZkQIuF3Fy4VXxb+Yuv6tKAWEFWwDuG9fieSDln4bvlU4jNX
         SlaqCIK5mhnUpvlmnMTTCwnswg4YEpOzMHntk6ZJbMqnlWCumhU4uz9epcnwNHlouZ7Z
         xFf/zPSJpedITlewpYjVPcik+w4X+kEOkSu1msKKVajsdLjybk9FZMXq050D9r2CFO0J
         D6c3MphEVXxY4u1a4uY81JL7UQcH+/mEFm1f2tntC2K6104mqXfdyfoIMXzQAwgflUxd
         813Q==
X-Gm-Message-State: AC+VfDwhYg9oXKamSRl9Np+7BJr0NtB3H+BBEVFHR7HY3B0yZV3BoeCa
        txtUQTweXZsI7s2dmbAu2U4=
X-Google-Smtp-Source: ACHHUZ6dY8CPkV1nhNirJn4QiguKDgrOznAOt6vUdERSziinsZ0xkvqGBT+oqbJ8UkZAj6B1tEqiXg==
X-Received: by 2002:a17:903:249:b0:1ab:d6f:51b0 with SMTP id j9-20020a170903024900b001ab0d6f51b0mr7023897plh.18.1685203791442;
        Sat, 27 May 2023 09:09:51 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902bd4400b001ab0669d84csm5101857plx.26.2023.05.27.09.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 09:09:50 -0700 (PDT)
Message-ID: <eb97f471-723f-5c2e-92f6-190986cd51da@acm.org>
Date:   Sat, 27 May 2023 09:09:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 1/9] block: Use pr_info() instead of printk(KERN_INFO
 ...)
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
 <20230522222554.525229-2-bvanassche@acm.org>
 <ZGv2TP1HZE1kgKlA@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZGv2TP1HZE1kgKlA@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/22/23 16:10, Luis Chamberlain wrote:
> On Mon, May 22, 2023 at 03:25:33PM -0700, Bart Van Assche wrote:
>> Switch to the modern style of printing kernel messages. Use %u instead
>> of %d to print unsigned integers.
>>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Cc: Keith Busch <kbusch@kernel.org>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   block/blk-settings.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 896b4654ab00..1d8d2ae7bdf4 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -127,8 +127,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>>   
>>   	if ((max_hw_sectors << 9) < PAGE_SIZE) {
>>   		max_hw_sectors = 1 << (PAGE_SHIFT - 9);
>> -		printk(KERN_INFO "%s: set to minimum %d\n",
>> -		       __func__, max_hw_sectors);
>> +		pr_info("%s: set to minimum %u\n", __func__, max_hw_sectors);
> 
> You may want to then also add at the very top of the file before any
> includes something like:
> 
> #define pr_fmt(fmt) "blk-settings: " fmt
> 
> You can see the other defines of pr_fmt on block/*.c

My goal with this patch is *not* to modify the output so I prefer not to 
define the pr_fmt() macro in this file.

Thanks,

Bart.

