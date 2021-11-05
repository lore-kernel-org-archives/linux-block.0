Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA350C433EF
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 14:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A244461244
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 14:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhKEOgW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhKEOgW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Nov 2021 10:36:22 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02B1C061714
        for <linux-block@vger.kernel.org>; Fri,  5 Nov 2021 07:33:42 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so3049132ooi.7
        for <linux-block@vger.kernel.org>; Fri, 05 Nov 2021 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gxt0C+WfTPpT7LA1LNZfzoe3TbHJPTsUQ10BMxP8OfE=;
        b=QN/b0MPHozm4vFdnEXNbmL5h5FqwRTx0/K7GAEZE1t/1BDaMaKwwIOJrfDPNuSh3Tv
         gaFCwCjhbilDlYy8do952R8VM978X6rWK+lnOpMseEmvLaJj3MLr+Fe/5+7Q961BeJaf
         5qMHeH/wFYX+7vQtHUv49iKm8sqhPG6Z09orRmWauec2DFiQx0CJN9+vqNWeHc2/xc+k
         K/GR+zDLzWKx1oRwoQXtA1DRVaqTwYXDuTFBeR6eaDxTN1LC5V5/EjN3eJbtYvStW3Au
         rlzPEAzK07mo9bd86ipZpVb8CKusAdy2wOn7KMt1WkcJAbgVAQM6Pfl/Vwd6ooClKQQT
         WIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gxt0C+WfTPpT7LA1LNZfzoe3TbHJPTsUQ10BMxP8OfE=;
        b=1MYbPAvZ9fkfx6OCRwXWBqQ4eFcTsxdti3DMmhKP8BworJWdBZkj0Oco9ZcZ42aPQp
         mMiCISRqE1Z1K5HbTk3mL8UDZuLbe2xTeXS2VauIUfnmzaZ5AVmyHNqUJ1RchiWODLcY
         StHaDlzBjy3uMCIcKSlmrU5eTppOXFLNdRIhdpoFfrgPMbejfeqeHetYMrOmYwmRlnFp
         rXon/dZi5Xza9PO2GyfoOo98z8sP6Cs9txAv1u/FQmKx2OV3DzhizEbJOIgUeSUyu3ES
         +4Btha/0Zrw5C/nnNvLAYcUcZItqbpCa9n47blet832KP8piNmu0YTyEL6tHVywRtvZk
         sbeQ==
X-Gm-Message-State: AOAM532U8vVn2HZzCX8zB7QcxpjYiHXxM/Rh263Q6MEwm2kTWlzIUPaH
        98G6cT0N6ej9hyI5CrZiZd8o6SHvkjmjxg==
X-Google-Smtp-Source: ABdhPJzMZ96DQn0ak2np3KvxPM9hvl31Ea5AVqWtxImQHRQ+YR0MAixOz6pvs366cjOrn0h0Z2XgHw==
X-Received: by 2002:a4a:9707:: with SMTP id u7mr8596663ooi.29.1636122821464;
        Fri, 05 Nov 2021 07:33:41 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y18sm913790oov.29.2021.11.05.07.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 07:33:41 -0700 (PDT)
Subject: Re: block: please restore 2d52c58b9c9b ("block, bfq: honor
 already-setup queue merges")
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        linux-block <linux-block@vger.kernel.org>
References: <65495934-09fe-55b0-62a9-c649dc9940ba@applied-asynchrony.com>
 <a66f5127-8b0b-d21a-eda5-73968255b52c@kernel.dk>
 <672815A0-3C5B-4DCD-9583-24497FC31D5D@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <86cf1cbe-c905-f83f-1c57-2a53a1e084d9@kernel.dk>
Date:   Fri, 5 Nov 2021 08:33:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <672815A0-3C5B-4DCD-9583-24497FC31D5D@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/5/21 3:43 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 4 nov 2021, alle ore 15:41, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 11/4/21 8:04 AM, Holger Hoffstätte wrote:
>>>
>>> Hi Jens,
>>>
>>> a simple no-code request:
>>>
>>> Commit d29bd41428cf ("block, bfq: reset last_bfqq_created on group change")
>>> fixed a UAF in bfq, which was previously worked-around by ebc69e897e17
>>> ("Revert "block, bfq: honor already-setup queue merges"").
>>>
>>> However since then the original commit 2d52c58b9c9b was never restored.
>>>
>>> Reinstating 2d52c58b9c9b has so far not resulted in any problems for me,
>>> and I think it would be nice to bring it back in early just to get
>>> feedback as early as possible in this cycle.
>>
>> Adding Paolo.
>>
> 
> Yep, now that we have the fix, we should restore that commit.

Please send a patch that does that then, with the rationale included
in the commit message on why it's now safe to do so.

-- 
Jens Axboe

