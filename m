Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D09CC61DA4
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 22:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBVWrv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 17:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjBVWru (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 17:47:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1326474FB
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 14:47:45 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z20-20020a17090a8b9400b002372d7f823eso6617416pjn.4
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 14:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677106065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkE3+r0Ypgx60NOPBHd/9KloHsuAy3vQ6wZXt1foZQk=;
        b=hGTgO3vpHN/XdvSP63H01e0LtBwGcr95BgZgjyAxTASHF62G40fwOv72Et/e/ujydH
         Pdv3A4KlgjFVQ7XEZmEeXcQImm85YqUlEkzWbvZ69vxKwKiXvFa+1GmFI+Nmf/ZD14v5
         jA2utG7QLcD9Nfb/HFWly6eu+ENkgbKlMvHFB1eUo37HbJna1qFh3dhX2ZEZTIyNfjDh
         IesmVC8RJ5khLvr1ZDHxk24qmLKHJxMQkTWfzPi1N1qX4DZy/XDToVAQyEGsK9LZXnaz
         YWXUZ1SqIzB3XHajQ0wg+mzrucoNt4CLiy1n9LFt5kvkJDKV1Oo800LzTlQtQ4qQXDJc
         /kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677106065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkE3+r0Ypgx60NOPBHd/9KloHsuAy3vQ6wZXt1foZQk=;
        b=OttiWas++lTOuHZjKvENsgyhJoLCVkizlS4mXVK3jemJrt9i+TV2dSOE3Z0ZGF3Nj0
         OauhHZeUd7SS0WNqrve9eTTZy977jr03PGgVXRCBrzhCbPlR0LbjwlRANCRv7KTOf97m
         8sEpyBPZCqaK1w4zn3FmGyS+5tB1JvcT3o89w+bT7l4N8OLuHgTPaU1YXr9sHA1Hg49O
         pEx21r96RVp7sZN/avD/zWka5s1OkdB1T4ucI3NInkS2AE5q2y/F3r4N3LVW+pf9bPQy
         mRRCmgmyjf8EzNYkVLm5qyrwudAYVHujKmXL2q5kAIfep7TxtceUV8SFtQ6jS+jwm9k2
         DqGg==
X-Gm-Message-State: AO0yUKWR6HMFNjdUmhgFlOV84YzssF9V4PUy71fWmLV2I3ixcsIMHBLQ
        eyJtb2ZxoV01UTm8ROC90QiH0g==
X-Google-Smtp-Source: AK7set8dtYdhWsx5s9vvdhIHVAyQ4wlqXb1fUHZPhmbx5k2pmLuYE8aH8okSLQt1t8dR23fEfupI/Q==
X-Received: by 2002:a17:90a:c915:b0:234:175:839a with SMTP id v21-20020a17090ac91500b002340175839amr8700253pjt.4.1677106064999;
        Wed, 22 Feb 2023 14:47:44 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090a498e00b00233790759cesm3998309pjh.47.2023.02.22.14.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 14:47:44 -0800 (PST)
Message-ID: <1b3b5d37-ff2c-6a0a-87c0-3de33ea254e1@kernel.dk>
Date:   Wed, 22 Feb 2023 15:47:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        gost.dev@samsung.com, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <Y+Gsu0PiXBIf8fFU@T590>
 <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com> <Y+nwh7V5xehxMWDR@T590>
 <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
 <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
 <8cc2659b-b7f9-eb8a-e73b-3056b82f159b@samsung.com>
 <db1d7cd7-6c89-7d6b-3fe5-3778bb3cb5e9@kernel.dk>
 <a10f11a5-2646-6db9-ab25-f2bb41190cc8@samsung.com>
 <Y/U+sxv6s09s/AyX@bombadil.infradead.org>
 <339e527b-2f2f-8b6f-6de4-84d7b5e3f96d@kernel.dk>
 <Y/aaSsNGLhXyJ2+t@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y/aaSsNGLhXyJ2+t@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/23 3:42?PM, Luis Chamberlain wrote:
> On Tue, Feb 21, 2023 at 04:51:21PM -0700, Jens Axboe wrote:
>> On 2/21/23 2:59?PM, Luis Chamberlain wrote:
>>> On Fri, Feb 17, 2023 at 08:22:15PM +0530, Pankaj Raghav wrote:
>>>> I will park this effort as blk-mq doesn't improve the performance for brd,
>>>> and we can retain the submit_bio interface.
>>>
>>> I am not sure if the feedback was intended to suggest we shouldn't do
>>> the blk-mq conversion, but rather explain why in some workloads it
>>> may not be as good as the old submit_bio() interface. Probably low
>>> hanging fruit, if we *really* wanted to provide parity for the odd
>>> workloads.
>>>
>>> If we *mostly*  we see better performance with blk-mq it would seem
>>> likely reasonable to merge. Dozens of drivers were converted to blk-mq
>>> and *most* without *any* performance justification on them. I think
>>> ming's was the commit log that had the most elaborate performacne
>>> metrics and I think it also showed some *minor* slowdown on some
>>> workloads, but the dramatic gains made it worthwhile.
>>>
>>> Most of the conversions to blk-mq didn't even have *any* metrics posted.
>>
>> You're comparing apples and oranges. I don't want to get into (fairly)
>> ancient history at this point, but the original implementation was honed
>> with the nvme conversion - which is the most performant driver/hardware
>> we have available.
>>
>> Converting something that doesn't need a scheduler, doesn't need
>> timeouts, doesn't benefit from merging, doesn't need tagging etc doesn't
>> make a lot of sense. If you need none of that, *of course* you're going
>> to see a slowdown from doing all of these extra things by default.
>> That's pretty obvious.
>>
>> This isn't about workloads at all.
> 
> I'm not arguing mq design over-architecture for simple devices. It is a
> given that if one doesn't need some of those things surely they can
> create a minor delta loss in performance. I'm asking and suggesting that
> despite a few workloads being affected with a *minor delta* for brd for mq
> conversion if the huge gains possible on some *other* workloads suffice for
> it to be converted over.
> 
> We're talking about + ~125% performance boost benefit for randreads.

Please actually read the whole thread. The boost there was due to brd
not supporting nowait, that has since been corrected. And the latest
numbers reflect that and how the expected outcome (bio > blk-mq for brd,
io_uring > aio for both).

-- 
Jens Axboe

