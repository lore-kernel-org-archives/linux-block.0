Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82913C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 19:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA2020811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 19:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="geZHGCDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA2020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeLMT7H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:59:07 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52024 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeLMT7H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 14:59:07 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so5560234itl.1
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9HwpeAASKDoLDycZu15Kfrt0tmVJZsz205csfagvOvA=;
        b=geZHGCDbgfLinIkbNb/845U5nz2zHshC+5XD62FCn9wqH7jasLCgvWT1ef6Mr9ZhYo
         scMP/6d/l6T2uz19pF395AmlNc8EJYmdflBe9okVZGBHXmjVdPAbb22Yf3I1zoAOSe82
         U2Q5HxQV7oOVPEFI95aHF3osdFdYL4deyB06ljjNyiWqY+jITFGo+gDKliW4RXeLytBs
         H+28YeHddtTW7s6xsWTBhTJtUhItRK2LHl0/bGzJ6yGDNisoJbzUfJsaqMMENW8DJ92e
         fAAsO3X57jFXcgXFkp0cQMBSZ/XTFvVyIaaDc0UNm8hizr6JyjplEfCxmR46tXBXK6Kg
         zWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9HwpeAASKDoLDycZu15Kfrt0tmVJZsz205csfagvOvA=;
        b=nAUmRcddGyHjzKW6DKWk2tXutQtMmYEKqq6e5Dl2k37npNZoWDvljKCrCVt3nBNQS0
         lndN0BgFZLV+WhIxzoYCMkv3I4OY0VH/KJlgrjLPbGoQyeapzEYHUBlLaoSDg/R4MTkD
         ZdQ4HykGiN1eUi31CV6LE4zWunI4eR1+aOBhRPetXhmcaPaQvg7wJBYxaTgsFl2ElWND
         sRUpPpHNEaXH75jkyK0wU7VWOPwq9NJ+gT0U4G72M7h6G5zKn9PudEK5wQ3x5uIy0S/I
         E3duVJ4zZLf+kFmYjOSGJQkb5jHiv/OMhi86vTd45hr8NkIkOoibOPypWni/7iqRMhyz
         BJCg==
X-Gm-Message-State: AA+aEWbo15wTW5O6BL7kSm2RQrT8xsR+rmr1aYTiL7ZP5PkAzHtQmdt2
        WauvEC01J0mGuKG2JIl6/P++OQ==
X-Google-Smtp-Source: AFSGD/Wa9A+kQUutB6aZWf3Ccc/A30nBOLwdGkk5A0U0Vm/mgS6ADdyo9a4nYLXgRLF5/+v97VXOdA==
X-Received: by 2002:a24:3007:: with SMTP id q7mr648649itq.57.1544731146059;
        Thu, 13 Dec 2018 11:59:06 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 85sm192509iou.8.2018.12.13.11.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 11:59:04 -0800 (PST)
Subject: Re: [PATCH v2] block: fix iolat timestamp and restore accounting
 semantics
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181211230114.65967-1-dennis@kernel.org>
 <59500829-10f5-fa83-b2db-fcfa4a1cd11d@kernel.dk>
 <20181213195208.qgvfeb5ilbf3ttsf@MacBook-Pro-91.local>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cbf1ca87-6a47-6c98-0c41-5cf495d6508b@kernel.dk>
Date:   Thu, 13 Dec 2018 12:59:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213195208.qgvfeb5ilbf3ttsf@MacBook-Pro-91.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 12:52 PM, Josef Bacik wrote:
> On Thu, Dec 13, 2018 at 12:48:11PM -0700, Jens Axboe wrote:
>> On 12/11/18 4:01 PM, Dennis Zhou wrote:
>>> The blk-iolatency controller measures the time from
>>> rq_qos_throttle() to rq_qos_done_bio() and attributes this time to
>>> the first bio that needs to create the request. This means if a bio
>>> is plug-mergeable or bio-mergeable, it gets to bypass the
>>> blk-iolatency controller.
>>>
>>> The recent series, to tag all bios w/ blkgs in [1] changed the
>>> timing incorrectly as well. First, the iolatency controller was
>>> tagging bios and using that information if it should process it in
>>> rq_qos_done_bio().  However, now that all bios are tagged, this
>>> caused the atomic_t for the struct rq_wait inflight count to
>>> underflow resulting in a stall. Second, now the timing was using the
>>> duration a bio from generic_make_request() rather than the timing
>>> mentioned above.
>>>
>>> This patch fixes these issues by reusing the BLK_QUEUE_ENTERED flag
>>> to determine if a bio has entered the request layer and is
>>> responsible for starting a request. Stacked drivers don't recurse
>>> through blk_mq_make_request(), so the overhead of using time between
>>> generic_make_request() and the blk_mq_get_request() should be
>>> minimal.  blk-iolatency now checks if this flag is set to determine
>>> if it should process the bio in rq_qos_done_bio().
>>
>> I'm having a hard time convincing myself that this is correct...
>> Maybe we should just add a new flag for this specific use case? Or
>> feel free to convince me otherwise.
>>
> 
> I mean it'll work for now, but then when somebody else wants to do
> something similar *cough*io.weight*cough* it'll need a new flag.  I
> kind of hate adding a new flag for every controller, but then again
> it's not like there's thousands of these things.  I'm having a hard
> time coming up with a solution other than a per-tracker flag.  As for
> this specific version, I still think it needs to be in iolatency
> itself, trying to make it generic just means it'll get fucked up again
> later down the line.  Thanks,

We definitely don't have that many flags, and I'd hate to add a
per-whatever flag for this.

But do we need that? We really just need single flag for this, my main
worry was overloading ENTERED. Especially since we're adding different
clearing and setting for it. If we had a specific one, if it's set, we
would need to disallow merging for it, I guess.

And there's already BIO_THROTTLED...

-- 
Jens Axboe

