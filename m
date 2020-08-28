Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11F6C433E2
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 14:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB732054F
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 14:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l8AdcsAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH1OYG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgH1OYE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 10:24:04 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7541C061264
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2020 07:24:03 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s1so1384126iot.10
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2020 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oBqjUPSW90cdrhvgVWX1qeUHUKkj7fN31Db6DAwayIM=;
        b=l8AdcsAPtgzVlvV4YwX1ZnGjOo8LkTAf40M84alWrqelyO/+gcdXKb6COPy4EAp++t
         7sKFayhVMMky/9+6G8n4RaWYSFdGZB3imIQ94AZL/cO208q1/vk3b71UmbptGHpilk7J
         3RAr8c+h//MSkPbPnJqP8qNedtQDF9Mira/SvCqKAaUrV8s0mmEdmlxAVzx1kfDzDnCD
         fFevxs1v94r7z/SYzcVtiHg5hq2Ni5rOJS8cQWm6orEwIsNPaT6KyZgua/3PGjJkjUYK
         9051FfQN89KL0vzUTGBRhLtBcV02x8/gKme5g2XeKPspV9IG3M6jNcIrYkfKF58xGB+g
         9Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oBqjUPSW90cdrhvgVWX1qeUHUKkj7fN31Db6DAwayIM=;
        b=h6nrFPB0hcDgCXb5e/vmkaaCzQBmTDdkFC2svoax08pscT9wmv2ZcLMhA0O0lIsUjM
         28SMOYYjRs/jgrn7K9zzzX9zglIU/34ezRIq9i432+/WQbpfMSFAqEY9xe0IEgyokfPz
         o8DSqCiqlPWd0wshj83LxiDc4bk0m1l1s4yDHfsgMpvzhRGOSkGc8hb50pYfD76reLIB
         1YBcfHA5LQI2gP/P67+HWzTbcaoORWeaFLkqUTEPA0HJ31UgzrwgbNBMGLz+v1esNqFt
         lxi0n4mtr2mUp7m5Kl1MHaLQB+gH6CthAoVZpmXCmhj4aJvRTVvTZ/GUIEfUkojBIHZ9
         WG3w==
X-Gm-Message-State: AOAM532d5EbYxmFFQ8f2x5sxBTms3XHMM0wUmNlcSL4rp5HVNIFuXvlU
        fOT84gF3W/Qq8XzcIUQ2joUxCxG1h7mK0NAh
X-Google-Smtp-Source: ABdhPJzZgxY321Gzy4/bOLLRVuGtTlDC6tl+9QauAwf2nTLBrFcSAg4hKWRJfXH962WnSaHxCkT+AQ==
X-Received: by 2002:a02:c8c6:: with SMTP id q6mr1353401jao.76.1598624642824;
        Fri, 28 Aug 2020 07:24:02 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p6sm624941ilm.55.2020.08.28.07.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 07:24:02 -0700 (PDT)
Subject: Re: [PATCH RFC] block: defer task/vm accounting until successful
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <bcee7873-198d-1e4a-27b6-8209f6154787@kernel.dk>
 <20200828074801.GA224560@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <395b4c19-cc80-eebb-f6ab-04687110c84a@kernel.dk>
Date:   Fri, 28 Aug 2020 08:24:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828074801.GA224560@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/28/20 1:48 AM, Ming Lei wrote:
> On Thu, Aug 27, 2020 at 08:41:30PM -0600, Jens Axboe wrote:
>> We currently increment the task/vm counts when we first attempt to queue a
>> bio. But this isn't necessarily correct - if the request allocation fails
>> with -EAGAIN, for example, and the caller retries, then we'll over-account
>> by as many retries as are done.
>>
>> This can happen for polled IO, where we cannot wait for requests. Hence
>> retries can get aggressive, if we're running out of requests. If this
>> happens, then watching the IO rates in vmstat are incorrect as they count
>> every issue attempt as successful and hence the stats are inflated by
>> quite a lot potentially.
>>
>> Abstract out the accounting function, and move the blk-mq accounting into
>> blk_mq_make_request() when we know we got a request. For the non-mq path,
>> just do it when the bio is queued.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index d9d632639bd1..aabd016faf79 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -28,7 +28,6 @@
>>  #include <linux/slab.h>
>>  #include <linux/swap.h>
>>  #include <linux/writeback.h>
>> -#include <linux/task_io_accounting_ops.h>
>>  #include <linux/fault-inject.h>
>>  #include <linux/list_sort.h>
>>  #include <linux/delay.h>
>> @@ -1113,6 +1112,8 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>>  	struct bio_list bio_list_on_stack[2];
>>  	blk_qc_t ret = BLK_QC_T_NONE;
>>  
>> +	blk_account_bio(bio);
>> +
>>  	BUG_ON(bio->bi_next);
>>  
>>  	bio_list_init(&bio_list_on_stack[0]);
>> @@ -1232,35 +1233,6 @@ blk_qc_t submit_bio(struct bio *bio)
>>  	if (blkcg_punt_bio_submit(bio))
>>  		return BLK_QC_T_NONE;
>>  
>> -	/*
>> -	 * If it's a regular read/write or a barrier with data attached,
>> -	 * go through the normal accounting stuff before submission.
>> -	 */
>> -	if (bio_has_data(bio)) {
>> -		unsigned int count;
>> -
>> -		if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
>> -			count = queue_logical_block_size(bio->bi_disk->queue) >> 9;
>> -		else
>> -			count = bio_sectors(bio);
>> -
>> -		if (op_is_write(bio_op(bio))) {
>> -			count_vm_events(PGPGOUT, count);
>> -		} else {
>> -			task_io_account_read(bio->bi_iter.bi_size);
>> -			count_vm_events(PGPGIN, count);
>> -		}
>> -
>> -		if (unlikely(block_dump)) {
>> -			char b[BDEVNAME_SIZE];
>> -			printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
>> -			current->comm, task_pid_nr(current),
>> -				op_is_write(bio_op(bio)) ? "WRITE" : "READ",
>> -				(unsigned long long)bio->bi_iter.bi_sector,
>> -				bio_devname(bio, b), count);
>> -		}
>> -	}
>> -
>>  	/*
>>  	 * If we're reading data that is part of the userspace workingset, count
>>  	 * submission time as memory stall.  When the device is congested, or
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 0015a1892153..b77c66dfc19c 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/crash_dump.h>
>>  #include <linux/prefetch.h>
>>  #include <linux/blk-crypto.h>
>> +#include <linux/task_io_accounting_ops.h>
>>  
>>  #include <trace/events/block.h>
>>  
>> @@ -2111,6 +2112,39 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>>  	}
>>  }
>>  
>> +void blk_account_bio(struct bio *bio)
>> +{
>> +	unsigned int count;
>> +
>> +	/*
>> +	 * If it's a regular read/write or a barrier with data attached,
>> +	 * go through the normal accounting stuff before submission.
>> +	 */
>> +	if (unlikely(!bio_has_data(bio)))
>> +		return;
>> +
>> +	if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
>> +		count = queue_logical_block_size(bio->bi_disk->queue) >> 9;
>> +	else
>> +		count = bio_sectors(bio);
>> +
>> +	if (op_is_write(bio_op(bio))) {
>> +		count_vm_events(PGPGOUT, count);
>> +	} else {
>> +		task_io_account_read(bio->bi_iter.bi_size);
>> +		count_vm_events(PGPGIN, count);
>> +	}
>> +
>> +	if (unlikely(block_dump)) {
>> +		char b[BDEVNAME_SIZE];
>> +		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
>> +		current->comm, task_pid_nr(current),
>> +			op_is_write(bio_op(bio)) ? "WRITE" : "READ",
>> +			(unsigned long long)bio->bi_iter.bi_sector,
>> +			bio_devname(bio, b), count);
>> +	}
>> +}
>> +
>>  /**
>>   * blk_mq_submit_bio - Create and send a request to block device.
>>   * @bio: Bio pointer.
>> @@ -2165,6 +2199,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>>  		goto queue_exit;
>>  	}
>>  
>> +	blk_account_bio(bio);
> 
> bio merged to plug list or sched will not be accounted in this way.

Indeed, it's either one or the other... The only other alternative I
could think of is to mark the bio as accounted already, and only do the
accounting on the first queue. That might be a saner way to go.

-- 
Jens Axboe

