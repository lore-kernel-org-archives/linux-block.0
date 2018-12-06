Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12250C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C889A2146F
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qMQrGIl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C889A2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeLFWcm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:32:42 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:36394 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeLFWcm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 17:32:42 -0500
Received: by mail-io1-f50.google.com with SMTP id m19so1758147ioh.3
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 14:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ERi/cAhOHD8JsztLL7rNAgDllIUG/im4lYMpKWa36RU=;
        b=qMQrGIl5goe5RT0tj7z02RcSutYJAkdJNtydM3Y+aE8aqwfS2BS4b4GpeWoxZ+Mr8j
         +XUom9JEMGCcnz+4stJd0ggtFtZxh8EpTCwiFo8ynazKujR8rTMkId+Ph4ZLpfiv0OeR
         5rUTKxpAku8C8b38h7t7baGqPW4hwaeNx0MQo6qcQi06m4uyH8SzKQg8EJZvWtA6qFin
         yw5vTteM9gHP4ySebLVe0m9FfcqBt+dislSC6usVZhPQujRpkUEq7ngp7xpQkwM1aI0D
         XdLq0vN2IHdKmtVBv9FGBhtean+72fZ7kWaLB1KFlmJK45MQVqc0O3cZgc0Z0AODuej/
         7zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ERi/cAhOHD8JsztLL7rNAgDllIUG/im4lYMpKWa36RU=;
        b=qy64w3jalwl4u188LLOJ5y8uBND2+eTWIYtyB6+xuBApj6RTt/+XamPO5jtY60r7z9
         BM8w8nJ4eMS9Bfr4edlZmGTu8AzjtqECau8lExlQrncZl42iSoz2I1k6Do7JfCwI/Di2
         4s5isejAo0rj5EIxD2bqTYMkwtLySbjIYwRLZ1DYhohIV/0pKsZszsO9i4f1vWDvLjua
         LpT1oFbzZuu9FPiXKjbwxcUMvSqcivSGu32kznkSKncxAAYHw7g13YWz8+K7ppdhhkDo
         iJYdSFORoynjZ6SLnJGcMP8ZJQfEyxJXFeSOmXedG0INGIpXemCXTvFJkkOy/lDDbxfT
         41yQ==
X-Gm-Message-State: AA+aEWZIKpZMqkeenpLyBrU9it0Ay9mvfLoISeq3QgqGS2b4d+wfhijh
        QrcZMg55jX53ZqqQB3zWX6V8TAFLBmo=
X-Google-Smtp-Source: AFSGD/XLZBRv3cGcKnSIkrRDaKJHCG+tRbT9lvdQ1qTTwR2Vb2293G10WVp3ISeZRvHVtShmpWSasg==
X-Received: by 2002:a5d:9813:: with SMTP id a19mr8831070iol.181.1544135560698;
        Thu, 06 Dec 2018 14:32:40 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o18sm599006ioh.31.2018.12.06.14.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 14:32:39 -0800 (PST)
Subject: Re: block: fix direct dispatch issue failure for clones
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
 <20181206222823.GA16730@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8770373d-d984-bacd-0963-65c43568c4f9@kernel.dk>
Date:   Thu, 6 Dec 2018 15:32:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206222823.GA16730@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 3:28 PM, Mike Snitzer wrote:
> On Thu, Dec 06 2018 at  5:20pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> After the direct dispatch corruption fix, we permanently disallow direct
>> dispatch of non read/write requests. This works fine off the normal IO
>> path, as they will be retried like any other failed direct dispatch
>> request. But for the blk_insert_cloned_request() that only DM uses to
>> bypass the bottom level scheduler, we always first attempt direct
>> dispatch. For some types of requests, that's now a permanent failure,
>> and no amount of retrying will make that succeed.
>>
>> Don't use direct dispatch off the cloned insert path, always just use
>> bypass inserts. This still bypasses the bottom level scheduler, which is
>> what DM wants.
>>
>> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index deb56932f8c4..4c44e6fa0d08 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -2637,7 +2637,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
>>  		 * bypass a potential scheduler on the bottom device for
>>  		 * insert.
>>  		 */
>> -		return blk_mq_request_issue_directly(rq);
>> +		blk_mq_request_bypass_insert(rq, true);
>> +		return BLK_STS_OK;
>>  	}
>>  
>>  	spin_lock_irqsave(q->queue_lock, flags);
> 
> Not sure what this trailing spin_lock_irqsave(q->queue_lock, flags) is
> about.. but this looks good.

It's because it's against current -git, that is gone from the 4.21 branch.


> I'll cleanup dm-rq.c to do away with the
> extra STS_RESOURCE checks for its call to blk_insert_cloned_request()
> once this lands.
That is indeed a nice benefit, all source based failure cases can be
removed from the caller after this.

-- 
Jens Axboe

