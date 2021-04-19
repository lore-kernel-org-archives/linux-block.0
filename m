Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF4C433B4
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 22:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A22661354
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 22:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhDSWzj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 18:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhDSWzi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 18:55:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFD5C06174A
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 15:55:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s14so13931874pjl.5
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OjNIyo1ouR7Rm7xQa5YQ9BBtXhRi6YK2FoHlFloTjSg=;
        b=G/rMkRmkgPkfMYXEk6fNegYRCTWAVqmXdxlT0IqBHnfbW76vmuTo0JLtcnh7z5xH6G
         7KBesPBLABJ+t/Sjnw7DLSDlnFUJbyyYNjpgUlCfWSi42UmROMP8wx8miM/2ZqfMxNms
         +z9ny9iFAPN9z+5jO5bUPd5nnSdJNxVS/cybw3Oov+q1F9Ff5VOnolGu7aeR4UTaFXKt
         RnSnO2dqdgtMIl2HMenE4FG/cb2U4Pa96SbNtZ3sLQ5A3YLFZOadLgnpSK4bHXSJGJdV
         ot2CJF1j+bKNzvmLD6ymTcM99R6tORsE6KSKzgI5bbqm2KLbhpAEJ7vyZeEBs+ZltyyN
         Ggbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OjNIyo1ouR7Rm7xQa5YQ9BBtXhRi6YK2FoHlFloTjSg=;
        b=ZtjaBkNMK/o/Nq03J4LmxUNpQNutoHMlhytQ7QW2y4MMLmy8jUR1o9ux19+WvMZf3Y
         q9fHj/kjuOlFOOFaWqHpZsrL0VVetnuRpVRTmJO+VP9J/gjztMWZfi3KZyvVXPgwlvef
         Q1/Lfjw9pTL4fVdD4LNPW8DrIPe62iZOpm38igxlTUMMjdHGfvKkRMMtqY8bGgAE9arD
         y+MRhIJoTypGMnO8Dwq0lal4YN7nb+IdNz8MbhmIQ8VAXsCAUmQK8ImWbwI14f5umH70
         Z3gAus3w8T5kW6WzJ6j945pYSBZLeoHO0MvRZnQU13qHA7uS/WrRzfUmMPcSqDGL+WhT
         jynA==
X-Gm-Message-State: AOAM531hBJV9u4vs2OxjAnzz7Fk0bfPaGcDYZKUBMBJyJ0cp3SC/nsvC
        2lQKwFLjoB4kLwpZwZ1M8m+yP/NxiYT7SA==
X-Google-Smtp-Source: ABdhPJxm5OBocMpYgUD/t4CJVTsVByZDQoqaV1RglVkUxCZQkrjYRIHXgK9w3inX02gQyWkF4fAt7Q==
X-Received: by 2002:a17:902:8ec1:b029:e9:998d:91f3 with SMTP id x1-20020a1709028ec1b02900e9998d91f3mr25216726plo.59.1618872907656;
        Mon, 19 Apr 2021 15:55:07 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c11sm13970949pgk.83.2021.04.19.15.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 15:55:07 -0700 (PDT)
Subject: Re: [PATCH] null_blk: poll queue support
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
 <BYAPR04MB49654A1D4AC52FA3A8110240864A9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <68a28d55-8c50-31e3-505a-2de330914942@kernel.dk>
 <BYAPR04MB496554C1F67A051A11FAB48A86499@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9ab31a42-18ad-a9a0-c448-3812c06915bc@kernel.dk>
Date:   Mon, 19 Apr 2021 16:55:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496554C1F67A051A11FAB48A86499@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/21 4:19 PM, Chaitanya Kulkarni wrote:
> Jens,
> 
> On 4/19/21 12:48, Jens Axboe wrote:
>>> +
>>> +               cmd->error = sts;
>>> +
>>>                 nullb_complete_cmd(cmd);
>>>                 nr++;
>>>         }
>>>
>>> If you are okay I can send a well tested patch with little bit code
>>> cleanup once this is in the tree.
>> Yes, that might be a good idea. I'll just fold it in, I've got it
>> sitting separately so far. Just let me know when you've tested it.
>>
>> -- Jens Axboe
> 
> I'm OOO, won't be able to do the testing for couple of days.
> 
> Meanwhile if you apply your patch, I'll send ZBD patch with testing
> in couple of days.

OK that's fine, we can just do a separate patch, or fold in as needed.

-- 
Jens Axboe

