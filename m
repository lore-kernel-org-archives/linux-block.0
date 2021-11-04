Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED86FC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0C161168
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhKDRia (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhKDRi3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 13:38:29 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96418C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 10:35:51 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id t21-20020a9d7295000000b0055bf1807972so1178816otj.8
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VT96vZeIQqx6ZVf5lI+gTTdo5LCZsvVbKRsx6QokeTw=;
        b=k2T5UYMBHoHE7u8Ugfn52bpsXiEsZuMqex+8VmOeIHXqun3zQ+5ctjZgnPI7XdFFkC
         ZpoGoQQBpoBpHvTptDCCuHyHzWNiVOO0VBJ7UaXyMxwjGEy9lit3ohfWNEQ0XXT2USBK
         a9hRMmPt3Yat7IgmHjzu4GyoigEdOannz3yj5N7YicM8sQk5U6h0KAcNh1jZ53KP3MBT
         8Y5ujTQRKZqjMnVWyJVeIhXwuo+i9xkokldNzI2kAgYA1fqQZPDjL4rfB5hR/l3uGB0S
         66VXEtzZeGnyFIXLPxJDDSkYO3TN10v95ab7h1HiN+mxJkYUTVM/bHwbhff5S8r4cwmG
         mJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VT96vZeIQqx6ZVf5lI+gTTdo5LCZsvVbKRsx6QokeTw=;
        b=qHcwE8dOYC+VeTAQ8sQ2XOPjqJVuWo/RHXv8QsABoupo9M+bLDuOm4AvCyS3/tIUfd
         E/IP31omw1TmXg7vKhVDxTTdoCKCIO+fa8nDGXWzuVpqCaXwdGxTNVysl+Vv1tyv4Y6q
         EdxCdOVAvqkep7t11ozfeCdRF+pgZVTzLoltUv0l2luc+5bnG3w4nkQbOe0A5Qfshs0T
         kpEjL1W5cmMWDfImITckmLlWCFOE5MlV6CQL4w7/fR6e51XMVHBEwZOxW63E1FVM+9AI
         srwQTLWJU+tS9ZSRhSeMeiv8TwC6Q8xZcl/vyaMPFuR7BZ8V3DOpa2MgweFJB1LxI60t
         g+cg==
X-Gm-Message-State: AOAM530JeU0OHkQYUJnpFwrXCyirlPeS2ukxc+pFnsUNyUVc1gsDQgqQ
        JgrLob5Wblth9pltdf8DfSOr9xCOqA5dNg==
X-Google-Smtp-Source: ABdhPJx8Qu8Aj9IGu581dq4eQ02qv5eCabrvlQ7cd1utWaMKVrYrK++8g7XE6xHuwk5z0nN1eA90Yw==
X-Received: by 2002:a05:6830:23a3:: with SMTP id m3mr38861894ots.111.1636047350765;
        Thu, 04 Nov 2021 10:35:50 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s9sm1608435oic.14.2021.11.04.10.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 10:35:50 -0700 (PDT)
Subject: Re: [PATCH 3/4] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-4-axboe@kernel.dk> <YYOjcuEExwJN1eiw@infradead.org>
 <ff6be121-5753-fe5f-90dc-8703da656d53@kernel.dk>
 <4d92696b-41a3-b0f3-90de-5b41555f011d@kernel.dk>
 <YYQZQKDBAUhQnqsq@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33138951-e79e-caa3-efbb-465af41c7b56@kernel.dk>
Date:   Thu, 4 Nov 2021 11:35:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYQZQKDBAUhQnqsq@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 11:32 AM, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 06:14:30AM -0600, Jens Axboe wrote:
>> To player it safer, I would suggest we fold in something like the
>> below. That keeps the submit_checks() under the queue enter.
> 
> Yes, this looks much better.  Nit below:
> 
>>  	struct block_device *bdev = bio->bi_bdev;
>>  	struct request_queue *q = bdev_get_queue(bdev);
>> @@ -868,14 +868,13 @@ static void __submit_bio(struct bio *bio)
>>  {
>>  	struct gendisk *disk = bio->bi_bdev->bd_disk;
>>  
>> -	if (!submit_bio_checks(bio) || !blk_crypto_bio_prep(&bio))
>> -		return;
>>  	if (!disk->fops->submit_bio) {
>>  		blk_mq_submit_bio(bio);
>>  	} else {
>>  		if (unlikely(bio_queue_enter(bio) != 0))
>>  			return;
>> -		disk->fops->submit_bio(bio);
>> +		if (submit_bio_checks(bio) && blk_crypto_bio_prep(&bio))
>> +			disk->fops->submit_bio(bio);
>>  		blk_queue_exit(disk->queue);
>>  	}
> 
> A this point moving the whole ->submit_bio based branch into a
> helper probably makes sense as well.

Sure, I can do that.

>> +	if (unlikely(!blk_crypto_bio_prep(&bio)))
>> +		return;
>> +
>>  	blk_queue_bounce(q, &bio);
>>  	if (blk_may_split(q, bio))
>>  		__blk_queue_split(q, &bio, &nr_segs);
>> @@ -2551,6 +2554,8 @@ void blk_mq_submit_bio(struct bio *bio)
>>  
>>  		if (unlikely(!blk_mq_queue_enter(q, bio)))
>>  			return;
>> +		if (unlikely(!submit_bio_checks(bio)))
>> +			goto put_exit;
> 
> This now skips the checks for the cached request case, doesn't it?

It did, I did add that when folding it in though.

-- 
Jens Axboe

