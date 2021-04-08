Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4141C433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 15:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B9A6113A
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 15:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhDHP5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhDHP5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 11:57:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ED8C061760
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 08:57:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 7so1275064plb.7
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zcZFNsMTpilMw093I7tUJj5oEXqj/qdn4xKNNR9pRBA=;
        b=EyX0kMIxhRopWybTgq1u+nhMJwf4DJTBtLCkjnLsz089gad9GtsZ2Jtt/5rx2+Tysk
         MHbbUhXBjA8Kbl6XzYmKcnF8f2qCJK+upgXcAh/PpTLpJ11VX0AvHYSnZih/7TqRq7J0
         7xZ6z9pTZlSzGJaMvmBkPouPKFHjSIL15VSAyBlzFmhY8j0TJvydROn9OefSMVflzSIK
         nbLL6Lw8yQOFDTGLhP/ZehlYcBKfuLu3+YRcSg/gaOOGSuxDgScr9Q7RViq2inz1w748
         mekzPiNjbKtOsMwhG/R40y4lzIf+nzxR9XnKTs0XAYfC3F8CAH/m2Fo9WQYqoKi0E8Xw
         mcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zcZFNsMTpilMw093I7tUJj5oEXqj/qdn4xKNNR9pRBA=;
        b=oYrQWIoQnj8TNq9+6irX8hWDNcKw9s874Lx0RrCXV5Pc+a5PFxOw6Kp4fO0yjxT8PS
         /G25IeP71wXHT5gpuUopSZR7+bbJ/+C+Y+ZIUQXsMgZdIBsC9lzyu9ElyyVm2RQfyH6M
         gRTMuRr2x9R5NZFs/ueRuC2ZgKGTeaEyz5buDsnebRCwmitKb79ItfN58Rx/zwj1CyUC
         EAv86xGfRk8YQWFGr5dX1neKmDkM73ySbkCArszZV8w8BqHndlRp5i2DFgmZOQnXBdfo
         Jokn96rBTIbTuqELNKoZOjx6JYgc8BsbhUrYK07c76Rn2r5D7lMgauvTY4xoUai6mj1a
         0bLw==
X-Gm-Message-State: AOAM530+Dw0uyfonQlmVqoBQ/0HDduiXIQt5imKN/xDkzY3IdRwefm4a
        ZbcjiWy+nIvL/4LLalZ974qfRw==
X-Google-Smtp-Source: ABdhPJxPWHmtjZfpXPKjA/QmQkFzgvHMuTaLEwtddrCm8JH2DjYaGeFkCUw38ElI9i+eSRm/gKZkGQ==
X-Received: by 2002:a17:90b:4a4c:: with SMTP id lb12mr9183217pjb.133.1617897444525;
        Thu, 08 Apr 2021 08:57:24 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id f21sm23339643pfe.6.2021.04.08.08.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:57:23 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: set default elevator as deadline in case of hctx
 shared tagset
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Yanhui Ma <yama@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210406031933.767228-1-ming.lei@redhat.com>
 <YG7AlzvLSyyeM8lL@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa7304ad-c616-443b-fc27-c37cdb136e74@kernel.dk>
Date:   Thu, 8 Apr 2021 09:57:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YG7AlzvLSyyeM8lL@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/21 2:36 AM, Ming Lei wrote:
> Hello Jens,
> 
> On Tue, Apr 06, 2021 at 11:19:33AM +0800, Ming Lei wrote:
>> Yanhui found that write performance is degraded a lot after applying
>> hctx shared tagset on one test machine with megaraid_sas. And turns out
>> it is caused by none scheduler which becomes default elevator caused by
>> hctx shared tagset patchset.
>>
>> Given more scsi HBAs will apply hctx shared tagset, and the similar
>> performance exists for them too.
>>
>> So keep previous behavior by still using default mq-deadline for queues
>> which apply hctx shared tagset, just like before.
>>
>> Fixes: 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per tagset")
>> Reported-by: Yanhui Ma <yama@redhat.com>
>> Cc: John Garry <john.garry@huawei.com>
>> Cc: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Any chance to make it in 5.12 if you are fine?

Let's just queue it through stable when it's in Linus's tree. This isn't
a new regression, so there should be no need to expedite into the current
release.

-- 
Jens Axboe

