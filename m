Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724FCC43381
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 13:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD6664F45
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 13:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCSNF5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 09:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhCSNFk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 09:05:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BD8C06175F
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 06:05:28 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v186so3637104pgv.7
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 06:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hTdKyQIaqcPxeY5I/JNuY5Iz2ypiwcneaqLgnosgVlo=;
        b=UNj2P9IBDWWQbYgV+zqNzk4pmN8wQaCSYpXS3X8sD3YmagQFQVliE0NfG9tI7t+BK4
         ZwbMJJBXmLjnDl1d87FVrB3hZMyK65KVQXkEVp+iukrBiVMt02MMwW9WhcqPKNn2tSbH
         vLwbjiSe+KXMNVln8mresYY3I9p50YKWv6kJkBXyYJyA+oPEqJkkRRSAxd6KPkAevrze
         mBYlaUForng5fMTkr1ZSI7274P3oTT01anF7I4oWDLttYlAr4IKK73Y8S0LX/SVAJ1RM
         jryQtdAm6+YCLlrqGxc8S7rokR2a/KCPrrmP1Gw+BXOmWgMt+s9nP8+vzZjn2ccRDjba
         SlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hTdKyQIaqcPxeY5I/JNuY5Iz2ypiwcneaqLgnosgVlo=;
        b=VIbk4hgS8W+kypQOrHpJHOk++lSq1gzKFrh2RnMwdKDMzwkUfOJ2Nh4GIyn07v6wFp
         yi0TRmVq1fVQiEsQPdaB8OKHN+eNxCIZUEdhrSmP1Mjke/ElbVqIuy5Y4GqMKh7plnT/
         LmGgfFFrWzY+rI+iP3JFQCyKqMmxYr3RfGMQCJD38EfZRsdta1BzH8Q06zOjHRd8H3tS
         nJGh+MWIuSza69bBkvA4nXniCQLq9rdeYnn+3OPqS1hCblFNlZbLrGWnqP6ar4Y0i8mz
         Lyi2RtjuMRMRZcicWVOKuz3ccIgt4LWNvIgdGtky6csaaOi2e61/We1+9fPdRDJprYMQ
         5ubA==
X-Gm-Message-State: AOAM5309baX93TxgFbklioM4Wo/tUp4b+VxH+dCpZzARwgKvBhYsqia/
        MJiIHkABdwakLE+mKGkKAKkI3w==
X-Google-Smtp-Source: ABdhPJwWtDdhAR39TFmz2Vco5mNCA9DtfWjlNWpxR55AOve7NcxFRH65z/6LP65chsjDyb7zTAJGhw==
X-Received: by 2002:a63:460e:: with SMTP id t14mr11149637pga.230.1616159127805;
        Fri, 19 Mar 2021 06:05:27 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c12sm5948967pfp.17.2021.03.19.06.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 06:05:27 -0700 (PDT)
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210318151626.17442-1-colin.king@canonical.com>
 <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
 <62cd71bc-86e1-412d-b2b9-716c0f8021be@canonical.com>
 <d32641ca-e34a-2bfd-9b86-28c95546f434@kernel.dk>
 <a99533a9-d96e-4e45-502b-066fe9286a42@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d9b0f7c7-6954-407d-1bd5-ff738ff72ec2@kernel.dk>
Date:   Fri, 19 Mar 2021 07:05:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a99533a9-d96e-4e45-502b-066fe9286a42@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/19/21 3:59 AM, Krzysztof Kozlowski wrote:
> On 18/03/2021 21:42, Jens Axboe wrote:
>> On 3/18/21 2:24 PM, Colin Ian King wrote:
>>> On 18/03/2021 20:12, Jens Axboe wrote:
>>>> On 3/18/21 9:16 AM, Colin King wrote:
>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>>
>>>>> The 3rd argument to alloc_workqueue should be the max_active count,
>>>>> however currently it is the lo->lo_number that is intended for the
>>>>> loop%d number. Fix this by adding in the missing max_active count.
>>>>
>>>> Dan, please fold this (or something similar) in when you're redoing the
>>>> series.
>>>>
>>> Appreciate this fix being picked up. Are we going to lose the SoB?
>>
>> If it's being redone, would be silly to have that error in there. Do
>> we have a tag that's appropriate for this? I often wonder when I'm
>> folding in a fix. Ala Fixes-by: or something like that.
> 
> Why it is being redone if it was put into next? And even then, several
> other maintainers just apply a fix on top (I think Andrew Morton, Greg
> KH, Mark Brown) to avoid rebasing, preserve the history and also give
> credits to the fixer.

linux-next doesn't have continual history, and I rebase my for-next
all the time. Since the series was going to be re-done and applied to
a different tree even, it would be silly to retain a bug _just_ so that
we can have credits to the fixer separately. For this case, it's
rebased anyway, and there's honestly not any history to preserve here.
The only downside is losing the fixer attribution, which I do agree is
annoying and hence why I asked/lobbied in a fixes-by kind of tag.

-- 
Jens Axboe

