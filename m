Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB84C38142
	for <linux-block@archiver.kernel.org>; Sat, 21 Jan 2023 21:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjAUVKv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Jan 2023 16:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjAUVKv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Jan 2023 16:10:51 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AF722035
        for <linux-block@vger.kernel.org>; Sat, 21 Jan 2023 13:10:50 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso3616671pjp.3
        for <linux-block@vger.kernel.org>; Sat, 21 Jan 2023 13:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Djyjh13RqJ4kOtdxR/wVl+Aysm17X2NUplyO6emi9aE=;
        b=E9DbKMu2MW0JK3umG1bOWRSs9/y6oB0m76cE/gelGA1fBPwE3tXZT+ucUoOnjInvtw
         JH6L1USxfKG5q/syYD84gF/+iOXyVlmVjN9xFmW/QM+BS7SORENYUB8NddnCNuOJL4fb
         Wt+TreYEyDmXdjNPmVIAums7SRwyeexdBcqJPT93sKmXt7LvFY/sugPo3yOOwyrH6/0v
         DlDkdex+E41d4gEmcRo5fDGkn85d+8/ZaB74Y4aCLpbzEiGZUdhHqZ2ny7fa3EL2TrID
         GYm/FvXndRkF/NudZ34mniDhXKNg2mALWs52WPUg1ePO6lLxlFMDFAhPD5yggKMhZDVU
         J6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Djyjh13RqJ4kOtdxR/wVl+Aysm17X2NUplyO6emi9aE=;
        b=Xeb63ALt4iqjr/vIlZ0yOB1UgGizJcn6TknZhLRu0lLRHQPSDChOP4v3WX8c9F7qmB
         KkOXIXUJTH1IyIZgU7zgjzEcJqkHwHIcN0CkUClUn8BTICMCffUJqu9DK46gqjvY6jju
         RPgZU2lX4PAaRtepZCw4+c3PowC5VhLqupYUUuKg5UeHWNpJ6GrbC41o7dcYP+zPJGr+
         zQ+rz3CZiHYOvACfsaMJuegxJmgoBeRj1YMw2oxUmawlgrJiaUD8f1AgLMzAkmgT4tnW
         yaK0LKoAf70ZTK82311H6HaH+0gmStYgeidifvyzE0OgM/9QoZQIjwMEBaJg4/Gy5hN9
         1npA==
X-Gm-Message-State: AFqh2koqxli6FYD+ApcWdKRIo5D2oQp//esqgqX4pDRl0F/YDosSRH3Z
        OtB8CXww0m/F2iqW6ro5Irva2iOvBta2Yizn
X-Google-Smtp-Source: AMrXdXssuABPH3eF5WzCoSn692wc1HX+urPYcmQur7yncDoXnWXf9dRXoARrAQeQcI9ubY6nonCeYg==
X-Received: by 2002:a17:90a:bb90:b0:22a:d161:2bba with SMTP id v16-20020a17090abb9000b0022ad1612bbamr1785444pjr.1.1674335449615;
        Sat, 21 Jan 2023 13:10:49 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a318700b002293b1aa2b6sm3818776pjb.30.2023.01.21.13.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 13:10:49 -0800 (PST)
Message-ID: <167f918d-8417-8f3c-e208-5a4cc3004004@kernel.dk>
Date:   Sat, 21 Jan 2023 14:10:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
References: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
 <BYAPR21MB168890325173FD3A35CB89DDD7CA9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <BYAPR21MB168890325173FD3A35CB89DDD7CA9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/20/23 9:56?PM, Michael Kelley (LINUX) wrote:
> From: Jens Axboe <axboe@kernel.dk> Sent: Monday, January 16, 2023 1:06 PM
>>
>> If we're doing a large IO request which needs to be split into multiple
>> bios for issue, then we can run into the same situation as the below
>> marked commit fixes - parts will complete just fine, one or more parts
>> will fail to allocate a request. This will result in a partially
>> completed read or write request, where the caller gets EAGAIN even though
>> parts of the IO completed just fine.
>>
>> Do the same for large bios as we do for splits - fail a NOWAIT request
>> with EAGAIN. This isn't technically fixing an issue in the below marked
>> patch, but for stable purposes, we should have either none of them or
>> both.
>>
>> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")
>>
>> Cc: stable@vger.kernel.org # 5.15+
>> Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
>> Link: https://github.com/axboe/liburing/issues/766
>> Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> Since v1: catch this at submit time instead, since we can have various
>> valid cases where the number of single page segments will not take a
>> bio segment (page merging, huge pages).
>>
>> diff --git a/block/fops.c b/block/fops.c
>> index 50d245e8c913..d2e6be4e3d1c 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -221,6 +221,24 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct
>> iov_iter *iter,
>>  			bio_endio(bio);
>>  			break;
>>  		}
>> +		if (iocb->ki_flags & IOCB_NOWAIT) {
>> +			/*
>> +			 * This is nonblocking IO, and we need to allocate
>> +			 * another bio if we have data left to map. As we
>> +			 * cannot guarantee that one of the sub bios will not
>> +			 * fail getting issued FOR NOWAIT and as error results
>> +			 * are coalesced across all of them, be safe and ask for
>> +			 * a retry of this from blocking context.
>> +			 */
>> +			if (unlikely(iov_iter_count(iter))) {
>> +				bio_release_pages(bio, false);
>> +				bio_clear_flag(bio, BIO_REFFED);
>> +				bio_put(bio);
>> +				blk_finish_plug(&plug);
>> +				return -EAGAIN;
>> +			}
>> +			bio->bi_opf |= REQ_NOWAIT;
>> +		}
>>
>>  		if (is_read) {
>>  			if (dio->flags & DIO_SHOULD_DIRTY)
>> @@ -228,9 +246,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>  		} else {
>>  			task_io_account_write(bio->bi_iter.bi_size);
>>  		}
>> -		if (iocb->ki_flags & IOCB_NOWAIT)
>> -			bio->bi_opf |= REQ_NOWAIT;
>> -
>>  		dio->size += bio->bi_iter.bi_size;
>>  		pos += bio->bi_iter.bi_size;
>>
> 
> I've wrapped up my testing on this patch.  All testing was via
> io_uring -- I did not test other paths.  Testing was against a
> combination of this patch and the previous patch set for a similar
> problem. [1]
> 
> I tested with a simple test program to issue single I/Os, and verified
> the expected paths were taken through the block layer and io_uring
> code for various size I/Os, including over 1 Mbyte.  No EAGAIN errors
> were seen. This testing was with a 6.1 kernel.
> 
> Also tested the original app that surfaced the problem.  It's a larger
> scale workload using io_uring, and is where the problem was originally
> encountered.  That workload runs on a purpose-built 5.15 kernel, so I
> backported both patches to 5.15 for this testing.  All looks good. No
> EAGAIN errors were seen.

Thanks a lot for your thorough testing! Can you share the 5.15
backports, so we can put them into 5.15-stable as well potentially?

-- 
Jens Axboe

