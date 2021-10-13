Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B7DC433FE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC49A61151
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbhJMRvO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbhJMRua (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:50:30 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118AC06174E
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:47:20 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 188so607567iou.12
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JDBMe3SzAQxJKdyd8wakW1XfyNC/H6eSKPi6XabT10Y=;
        b=jxGmUjXWDJXZBj6Wl4fl4SR+Xdf9gBE+bMbxKX7HyKTCG45qG4sKqpWWjARRcWI6Xy
         K9ZCu+pKtSx84sTLzEviXed8Q1nhu3ZBtmkZKkZyxCMv8tXZoBLExLPiFqkeEm3hGA4M
         ze9Jhnb4Jkhh64cRLbls0iivFwX765Ewg2g12M0ps5GbO+AakAfqDpsXvR04GmOLPdGl
         f8jx9qOsOr4qtn+plRFic3tlkUXFab3+lAw5Un8X7uYckP4k8zKVwgbLpcJWICf8kSZl
         0iawYh68bQrGj6spkXuYp04PIvKfaqMP6PW41X8xV9yIRVgz43QdZL930s5bog+qoPmw
         ozkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JDBMe3SzAQxJKdyd8wakW1XfyNC/H6eSKPi6XabT10Y=;
        b=pJDmFZvijf+unnWWRoAljpepIcXaVtCfDEPvfHPLJhpMg8+waUSdD7zAMIIuymAjwi
         byLbPwTuKP7HiEsrGAPkRLFE1u/9gfKGrgE4s0WYU0rXejRfnniNw8zeIjHuT0tUFdqf
         UOp65ZxFk6Z7a1XtqBqN2qt2LK1mtzhA7Io1iMqwowb0soVuObB9sY7wu9ZqUmzBPe8f
         0zif9+lbRLf66TpzBVm+vCskkz0c1PmFSadkdonkPUyhsRdBew4jhKKQE9KuEjAc5sPA
         qcQ7hlcCRHENDlwOAXpKYsdY/PL8kIbbFlBsKhkB0N6OS6XNTj75tbZCGF2h7oITCIP4
         uiig==
X-Gm-Message-State: AOAM531U6z2JVNN9rRGB+d/JyTJROj0NwZCGZVSdU2cncfXY0XCZojyg
        5n8/eerYqNDzg2WOmnARMDFZ4b+ba3yQOQ==
X-Google-Smtp-Source: ABdhPJyPgdxGXqx1bk5az2FKgouQR/jZ6vgNreZ0YPdbazaEhoZWh/V2D2ioW8u5MPRgvo6evWoNaw==
X-Received: by 2002:a6b:c38d:: with SMTP id t135mr510284iof.99.1634147239841;
        Wed, 13 Oct 2021 10:47:19 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 26sm114123ioz.55.2021.10.13.10.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 10:47:19 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: provide helpers for rq_list manipulation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-2-axboe@kernel.dk> <YWcTWJzo2WV9L/k9@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff452fbf-3f92-da10-4d4d-6cd7de1e159c@kernel.dk>
Date:   Wed, 13 Oct 2021 11:47:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWcTWJzo2WV9L/k9@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 11:11 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 10:49:34AM -0600, Jens Axboe wrote:
>> Instead of open-coding the list additions, traversal, and removal,
>> provide a basic set of helpers.
>>
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-mq.c         | 21 +++++----------------
>>  include/linux/blk-mq.h | 25 +++++++++++++++++++++++++
>>  2 files changed, 30 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 6dfd3aaa6073..46a91e5fabc5 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -426,10 +426,10 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>>  			tag = tag_offset + i;
>>  			tags &= ~(1UL << i);
>>  			rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
>> -			rq->rq_next = *data->cached_rq;
>> -			*data->cached_rq = rq;
>> +			rq_list_add_tail(data->cached_rq, rq);
>>  		}
> 
> This doesn't seem to match the code in the current for-5.6/block branch.

It's after the 2 patch improvement series.

>>  		data->nr_tags -= nr;
>> +		return rq_list_pop(data->cached_rq);
>>  	} else {
> 
> But either way no need for an else after a return.

We can kill that, but it's really independent and unrelated to this patch.

-- 
Jens Axboe

