Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F02FC4361B
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 21:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45024235FC
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 21:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgLPVR5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 16:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgLPVR5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 16:17:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EFEC061794
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 13:17:17 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y8so13660488plp.8
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 13:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DKf0l9pqpvG/DVRFw7tn0BKeYMhczqQZ1KCea+Q4LuA=;
        b=VIUL43z1+XHRCjtTY950PQU8yaAuEZQCXayhHvkzU+AsxQ7xItYB2pLnP37WWlffSh
         NXgye1OM3kPQv1C2Am17GjEHC7RwGuR0jjlgoXo1aXTB0ph4mAGgGuoLXrJ+rSfKgJx7
         lAfP14HJnMEtiny+ggNUhhPvx9OYiXWsitvJTlnfTilq6f55r4upy7rdgF679VhKLwsd
         YviKHUqQyPLCTYgXLSP2I7UOFSM7Wbp8MN5rAyCJuUgH2U/GaEZkjOFcythetU9dyDBs
         WCEtJ+i0JpXLv0my6OaCnmWcROnM1abOV1CF9BXzvUhGRNA3ekyaHaqyn2OhxQHM3hr3
         jWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DKf0l9pqpvG/DVRFw7tn0BKeYMhczqQZ1KCea+Q4LuA=;
        b=kM2i0dP51a8Z9dTgJUD88f5MaWK+NkT7tXeEvm6RVoBt6QjDPoZXSc2OTvMaBV91BF
         HIPZ7m1xdMyTH6b6axj6YvoVuLgLMdI7uPFR+9o7IDo+EBdrVaShokjaAvy4ZZ1YSLKa
         280+pwXRQRxP/CvOhxF9uyXtVnYnimv9kXp3if+k9/6FWGG9pDZlT3Xoro+I9T2zRmv0
         ZS2UAp8QJpVAe8hKRAapulw0Pyk7bWbM8vXoRjGXcfGt8+rfZQ/+hK376vW+6NuKL6V/
         mRttu4/6JYPb4mGKLhe56kIruONBY6mkDro1QU9Sld+ILHrkeCHk26bdFmB9GAHm5p6u
         11/w==
X-Gm-Message-State: AOAM532wWM9aW+nsSwgPnytDnzeSlArPmw2OSOxvyAc4fIB+F7Rkq9K9
        xPerTGGSt9FldPeGOcAvzOvKDO/5camgY0Co
X-Google-Smtp-Source: ABdhPJy7jBCqxl5eYUW6+0LStIc6CuPKjBnLiuyk7wsmHW3pNXODfLBeWPktEr6MFZ8mPx/N9QyVrw==
X-Received: by 2002:a17:902:a412:b029:db:cf5a:8427 with SMTP id p18-20020a170902a412b02900dbcf5a8427mr33251996plq.48.1608153436809;
        Wed, 16 Dec 2020 13:17:16 -0800 (PST)
Received: from ?IPv6:2600:380:b516:bac8:47db:e26:30a9:2340? ([2600:380:b516:bac8:47db:e26:30a9:2340])
        by smtp.gmail.com with ESMTPSA id c62sm3450513pfa.116.2020.12.16.13.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 13:17:16 -0800 (PST)
Subject: Re: [GIT PULL] Block driver changes for 5.11
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <8238bb43-756b-e0dc-2484-7e1e21928c0c@kernel.dk>
 <CAHk-=wjRm36zBu2Vj=VyntiA9Hdc1_uFVeY93d3oYQntXzERag@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cfceb1dc-1e14-2e83-f9ab-33c7412b8191@kernel.dk>
Date:   Wed, 16 Dec 2020 14:17:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjRm36zBu2Vj=VyntiA9Hdc1_uFVeY93d3oYQntXzERag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/20 2:13 PM, Linus Torvalds wrote:
> On Mon, Dec 14, 2020 at 7:30 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Note that this throws a merge conflict in drivers/md/raid10.c, again due
>> to the late md discard revert for 5.10. Resolution is straight forward,
>> __make_request() just needs to use the non-HEAD part of the resolution:
>>
>> r10_bio->read_slot = -1;
>> memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->geo.raid_disks);
> 
> What?
> 
> No, that can't be right. That undoes part of the revert.
> 
> The proper resolution looks to be
> 
> +       r10_bio->read_slot = -1;
>  -      memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) *
> conf->geo.raid_disks);
>  +      memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->copies);
> 
> as far as I can tell.
> 
> Am I missing something?

No you are right, looking at the current tree!

-- 
Jens Axboe

