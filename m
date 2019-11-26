Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D160C432C3
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242052071E
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J8dkOrdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfKZRZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:25:26 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46942 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfKZRZ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 12:25:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so963859pga.13
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rbowQs+49KFUfE63zlU9AJNWOfkPvUP9843DnIqGKrU=;
        b=J8dkOrdQCYK7YTUsbT26F1kz+C7u/kvu833xthA7KoCzpydjZCVJNyIndPcSI7mT9O
         XhkS4jIWxdyAZRv5MYGSOT2H1qIhP5xWmiXyB5s6fhDc46r67jgrNp8ki3Cp0YKhy2vZ
         GRJqLamrEMCwXRNBBDmSniRFGuaTWkh2S937Vb3cz49HnL2CASH/QL8zoaVsm2xY7FPU
         7dohB+gdttbN8W6LnMn9++UPLCS7oXrDBSNpyCCsSBUGk4pMwedwQBFCZ9FP5yUKsflt
         RoIQjA+JcMT+T6YaLJCyPqbojRpP1QChlScrAWU3nC0ZuVleFgWkzvrd+E38B7+xXkQt
         NKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rbowQs+49KFUfE63zlU9AJNWOfkPvUP9843DnIqGKrU=;
        b=BxYU4Gc0WkxqEwtZoorv0oVYhijRIr9+f15ZWT3iBDLJUp06ggsfUfdmJMoNJ9Uerw
         BNxehigFy5LIgWKfVY+NCnbbTq5OSM9c1LYDrd5dpHYBPyrmi9QD6pQPBXO+GQjz/UsF
         qwLarhE2Z/uMV5TQWP6kKOmoZaa31zoCJcNz5RCi73u1c+Zgqawx8XxZ8IRZYR9eqyM0
         2E+C1JENvy3j8+VExp0lrI2yZpnovTU0rZHxCqBiWvxdJX9kONMnIDHaGZT7h6NvBMlZ
         nDK/v7Xbi3uZPjboSVz9IqIqknESN2Mmfphl0sXYDXTW0RQAAwCfduQzFegkJBknsQF5
         q8Tg==
X-Gm-Message-State: APjAAAUe2oBJd3e/cKPN+BbhM4o/iDEEnYQp7FhVcXh7YyayqtrqsAgn
        r0GhkzvdKHWlNPJCtSX1xI3t+XnCxTfPpQ==
X-Google-Smtp-Source: APXvYqzbBUJCcQuaRLtk8T4/jyeXHyhSrB07NoMSoHqe291SeK3iYlAf33OozCB8VwZE9nnb1q3v8g==
X-Received: by 2002:a63:df09:: with SMTP id u9mr39816064pgg.20.1574789124632;
        Tue, 26 Nov 2019 09:25:24 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id b5sm13814908pfp.149.2019.11.26.09.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 09:25:23 -0800 (PST)
Subject: Re: [PATCH 3/8] blk-mq: Use a pointer for sbitmap
To:     John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20191126091416.20052-1-hare@suse.de>
 <20191126091416.20052-4-hare@suse.de>
 <8f0522ee-2a81-c2ae-d111-3ff89ee6f93e@kernel.dk>
 <62838bca-cd3c-fccf-767c-76d8bea12324@huawei.com>
 <00a6d920-1855-c861-caa3-e845dcbe1fd8@kernel.dk>
 <baffb360-56c0-3da5-9a52-400fb763adbf@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9290eb7f-8d0b-8012-f9a4-a49c068def1b@kernel.dk>
Date:   Tue, 26 Nov 2019 10:25:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <baffb360-56c0-3da5-9a52-400fb763adbf@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/19 10:23 AM, John Garry wrote:
> On 26/11/2019 17:11, Jens Axboe wrote:
>> On 11/26/19 9:54 AM, John Garry wrote:
>>> On 26/11/2019 15:14, Jens Axboe wrote:
>>>> On 11/26/19 2:14 AM, Hannes Reinecke wrote:
>>>>> Instead of allocating the tag bitmap in place we should be using a
>>>>> pointer. This is in preparation for shared host-wide bitmaps.
>>>>
>>>> Not a huge fan of this, it's an extra indirection in the hot path
>>>> of both submission and completion.
>>>
>>> Hi Jens,
>>>
>>> Thanks for having a look.
>>>
>>> I checked the disassembly for blk_mq_get_tag() as a sample - which I
>>> assume is one hot path function which you care about - and the cost of
>>> the indirection is a load instruction instead of an add, denoted by ***,
>>> below:
>>
> 
> Hi Jens,
> 
>> I'm not that worried about an extra instruction, my worry is the extra
>> load is from different memory. When it's embedded in the struct, we're
>> on the same cache line or adjacent.
> 
> Right, so the earlier iteration of this series kept the embedded struct
> and we simply pointed at that, so I wouldn't expect a caching issue of
> different memory in that case.

That would be a much better solution for the common case, my concern
here is slowing down the fast path for device that don't need shared
tags.

Would be interesting to check the generated code for that, ideally we'd
get rid of the extra load for that case, even if it is in the same
cacheline.

-- 
Jens Axboe

