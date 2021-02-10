Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90316C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 15:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3294D64E8C
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 15:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhBJPWl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhBJPWj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 10:22:39 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5749EC06174A
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 07:21:58 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id q5so2142151ilc.10
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 07:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PTHP/d1Wnj5IF8gitLfB3aU+gA4FpGZG9JxnrDNzvss=;
        b=n11hmjoebS3iiJDFKOxOqzT6bG62uhGtDccx7cai9mTGXhXPskWRPXwYLBct8vXv3r
         QXCFs4Ei84UGd0cuBybIp3xnkI4pVIgxFuZo7Jv/35WV8MGPmQuMAD5R1K0AP/GnTojS
         +OBfPCoJ9kmoBE9RfhSf13bLjTVI/cnzfJIbSLZc91T436iQSiCLNtd0mBFciG4gOElZ
         ccLjfTX0fQkCN9AqtzAuOg4KReV4o7KTvKBJ+pUdXo3uUcQoFM9d/b4cxIj8wdWL2Bfk
         gN2W/Tc13gbRp9Y+ZP+3o/dEHfXGIl6Q2k711BypZBVOC6EYz0aOKc/GNvMdeokOIHMI
         D35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PTHP/d1Wnj5IF8gitLfB3aU+gA4FpGZG9JxnrDNzvss=;
        b=ArYFNeMXnZ/jDwTjgUVXa85CorCUtJxChH223dC5gU0q0VxAAFL46x9uBrW1LrzO4P
         rKPIpPWin5YEqVMkgEbi//F9TadznCwvuDPWeMUZHb8wU4WedMn3yJ/0JP4ZULpS0gH7
         /bA1RXnldbwhbPHigUt58ZAIb4yTCRnh14RRHq4zevV3BPmEDCqJu41WbIf2j8qwsDx/
         cE2+L1h4RkTbdeKmtKthO5NJfZU700cCFj61XWOti7AlOMHTUyHrfqfgD8WD1gVbAiYn
         5F00BMSh3ED/L++VoRJP4okbKzENi4wxMah245KzMTVuny4ugbu03/80zhWHAEKe9OZJ
         pg6g==
X-Gm-Message-State: AOAM531ZnfRqt2+6UzVtX8o18upmDF0WCuVNEU/hEVA5Of5BN77UbwZM
        sqM3BYn3NIW2mJ6TIgFhbySWAw==
X-Google-Smtp-Source: ABdhPJw5/Jm3n5wQy6m/lLnZSvMDFe4Now+YRkL0vIOX3A87p/z3b7q12yJXtoVcNI30FxftDOSDlQ==
X-Received: by 2002:a05:6e02:144d:: with SMTP id p13mr1465504ilo.41.1612970517833;
        Wed, 10 Feb 2021 07:21:57 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k11sm1064228iop.45.2021.02.10.07.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:21:57 -0800 (PST)
Subject: Re: [PATCH 1/2] bfq: remove some useless logic of
 bfq_update_next_in_service()
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     Chunguang Xu <brookxu.cn@gmail.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1611917485-584-1-git-send-email-brookxu@tencent.com>
 <B4751549-78D9-4A84-8FB2-5DAA86ED39C8@linaro.org>
 <20210210152034.puimoewzgtnnp2zl@spock.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc39aeb5-4fb6-db15-3ad5-b310f5d5b486@kernel.dk>
Date:   Wed, 10 Feb 2021 08:21:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210152034.puimoewzgtnnp2zl@spock.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/21 8:20 AM, Oleksandr Natalenko wrote:
> On Wed, Feb 10, 2021 at 12:13:29PM +0100, Paolo Valente wrote:
>>
>>
>>> Il giorno 29 gen 2021, alle ore 11:51, Chunguang Xu <brookxu.cn@gmail.com> ha scritto:
>>>
>>> From: Chunguang Xu <brookxu@tencent.com>
>>>
>>> The if statement at the end of the function is obviously useless,
>>> maybe we can delete it.
>>>
>>
>> Thanks for spotting this mistake.
>>
>> Acked-by: Paolo Valente <paolo.valente@linaro.org>
>>
>>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>>> ---
>>> block/bfq-wf2q.c | 3 ---
>>> 1 file changed, 3 deletions(-)
>>>
>>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>>> index 26776bd..070e34a 100644
>>> --- a/block/bfq-wf2q.c
>>> +++ b/block/bfq-wf2q.c
>>> @@ -137,9 +137,6 @@ static bool bfq_update_next_in_service(struct bfq_sched_data *sd,
>>>
>>> 	sd->next_in_service = next_in_service;
>>>
>>> -	if (!next_in_service)
>>> -		return parent_sched_may_change;
>>> -
> 
> Unless I'm missing something, this has already been fixed here:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.12/block&id=1a23e06cdab2be07cbda460c6417d7de564c48e6

Yep indeed.

-- 
Jens Axboe

