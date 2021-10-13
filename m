Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4BEC4332F
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1A360F21
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhJMPGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbhJMPGp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:06:45 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE35C061749
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:04:41 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j8so3056331ila.11
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w2jgNNc357e8RqjPllKDcjNosbT6cGqclg0KFwnLUY0=;
        b=02sKR+wgW/K2ZEq9riQYkQBuWo7fCRlOpjrUziTzFmezbuDBI3UM12KsGeJm2U3ACC
         sjrJaxDfuqQvcwIKJeD7fMMgtajtQWhGdw+3KXgVzZETDlfQFu0J7OFYm/o5In6+I/zm
         E6Prfp5un9Iw3mA5uIa+uHayISAPzXlGi6d+wb3TZCn/tJR1oQYb3fmmx1+DFgBUgl8T
         uIV6WnrlhzAKExDuagJK68JZv32Icn/MLM1Z91dFaQAvJKeVbbJBRzw1YHmFLu+Bk3hL
         T61MNy6EWUZN/dzHWHN8z0Uyf+bsC3FxTmgjrC24lJqBo7jEm7mS2LHT0E/rUWpS9tJJ
         tk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w2jgNNc357e8RqjPllKDcjNosbT6cGqclg0KFwnLUY0=;
        b=qRt6YyBP5q4Cvqb5OZJi/R2K5TAji+Ft612fwELpGHTKAOajXaDNp7HbRMJLyE+c0b
         XVDe7CGo7uKNvswp5gmVH4l4nbizTN3Y0AYbmZLQKvlw8dAhHegq6Rvj8arTJ6Tlrb09
         8T9m2cJ+wtl4q/J6gZEq4eJFsjJ4Hs/M4Pgf9AMdfH2K4/dCk4g6az5oREcWAw40VJOl
         sQIhgcMJ6DnfNpsVynn2+X/jgoN52zY0jZ4JncFpzPEM3VUJggIxXxOM+/l3Iwzv0x4/
         45r75SlynK8KWD7FphyoLJXqMNRkPtEgE3gQovZxlUktFcjrhbh8418pvp4MkY1d6tZ1
         y0EQ==
X-Gm-Message-State: AOAM530nkuWfB490r2U2mXqRD4WqNSNxS9eZkJOlPuZ4usFshb844Rme
        HxXBcy0qZG0T5wIcvME4aVHTVnmK7p6TxQ==
X-Google-Smtp-Source: ABdhPJytNrGVe3HWp9npn2OZmD2EhOqPh92mhIEmyhLx/eiqJxESPTctr9COlhruT0qKYCze55jzyw==
X-Received: by 2002:a92:cf06:: with SMTP id c6mr1411ilo.177.1634137480797;
        Wed, 13 Oct 2021 08:04:40 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g3sm7103208ile.61.2021.10.13.08.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 08:04:40 -0700 (PDT)
Subject: Re: [PATCH 9/9] nvme: wire up completion batching for the IRQ path
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-10-axboe@kernel.dk> <YWaG2c9IAm1y3275@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f0992fda-e1ec-9751-5d2c-90d7c0ae013f@kernel.dk>
Date:   Wed, 13 Oct 2021 09:04:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWaG2c9IAm1y3275@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 1:12 AM, Christoph Hellwig wrote:
> On Tue, Oct 12, 2021 at 12:17:42PM -0600, Jens Axboe wrote:
>> Trivial to do now, just need our own io_batch on the stack and pass that
>> in to the usual command completion handling.
>>
>> I pondered making this dependent on how many entries we had to process,
>> but even for a single entry there's no discernable difference in
>> performance or latency. Running a sync workload over io_uring:
>>
>> t/io_uring -b512 -d1 -s1 -c1 -p0 -F1 -B1 -n2 /dev/nvme1n1 /dev/nvme2n1
>>
>> yields the below performance before the patch:
>>
>> IOPS=254820, BW=124MiB/s, IOS/call=1/1, inflight=(1 1)
>> IOPS=251174, BW=122MiB/s, IOS/call=1/1, inflight=(1 1)
>> IOPS=250806, BW=122MiB/s, IOS/call=1/1, inflight=(1 1)
>>
>> and the following after:
>>
>> IOPS=255972, BW=124MiB/s, IOS/call=1/1, inflight=(1 1)
>> IOPS=251920, BW=123MiB/s, IOS/call=1/1, inflight=(1 1)
>> IOPS=251794, BW=122MiB/s, IOS/call=1/1, inflight=(1 1)
>>
>> which definitely isn't slower, about the same if you factor in a bit of
>> variance. For peak performance workloads, benchmarking shows a 2%
>> improvement.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  drivers/nvme/host/pci.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 4713da708cd4..fb3de6f68eb1 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1076,8 +1076,10 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
>>  
>>  static inline int nvme_process_cq(struct nvme_queue *nvmeq)
>>  {
>> +	struct io_batch ib;
>>  	int found = 0;
>>  
>> +	ib.req_list = NULL;
> 
> Is this really more efficient than
> 
> 	struct io_batch ib = { };

Probably not. I could add a DEFINE_IO_BATCH() helper, would make it easier if
other kinds of init is ever needed.

-- 
Jens Axboe

