Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79587C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 19:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564BD20702
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 19:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pvY/BcI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGATI3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgGATI3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 15:08:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B82C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 12:08:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f3so12187733pgr.2
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dp7e7zTbynI7xs6YFng1gAhwPItlK4RQ7rKItLx0okE=;
        b=pvY/BcI6fU70GFnbo6TkeRv8GtT9BEEkcW3FJQtOX/c9k6f2h2v4NfYtEouWhwJV0S
         OTztqiHFsXRgN2+IN0Eq3Vp+TKaH/mSFL9CJMXLLzc7yRYqY0VmGD/hMxwvJc7kpmh/L
         Xo5vRfvinkweDJkcSDT0Xvp63TsjSZWWdWMyKQoVMQtnDd1mnexP2eGoFCndjmaEfoDR
         hom4U3Lop/XzuDrsUk9apLtQ/Fq2M6FkBtkEzAyEg0skN+hkhq3jUlSk4RHlVm2lBBcD
         ZcFz8bWDTqGY52brzMvNfS2IrBLHhoNrszkxraQQnURT7z2lNxDh6WQgft9wsg4qAhuT
         ABCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dp7e7zTbynI7xs6YFng1gAhwPItlK4RQ7rKItLx0okE=;
        b=S7tELbpA5yh9VS5s15dHa4WPyBvfgb4sCFsSqaey+h61QsanTJxfQ0bXJdCoKoenrg
         TyCKQ+d/2Z2u5s5F2Kk2RIhk047948DRTHrRVQKXTeSW8CsCC4z1IzgHrQC4n3dqCr04
         MidSfaoHykk7+WFvmqnviF/WNmQz0X2ct+zBY8jM4537/i2FP72lwarFH7Z3qIN0qan/
         e9DKmUHx5AkxuQZBcx8zSquTIdI672gMOBU1jI3wfxcTHFMS2TrX0uR+xBdaaD8xGVJy
         j/m2lz/gC++G5fGTJGIbwtMs4ZPvP33V0Mvujx1XwL/m7dOgORyV4y2HmxyWcjY50a+i
         cCaA==
X-Gm-Message-State: AOAM531cffqcc4JlnRajfclRG5vIaGvaemm2+rYMCxTrKWXO3KsUC+w7
        X2Xj3ilNXzdrN7XV4RkGW3B33pUEJRmiXg==
X-Google-Smtp-Source: ABdhPJygiGjjqu1bmzEG4IVko0nuq4bylUujjYA5723nvXZEqvGWmG9wTCUVjGSTlaJKkeR8Enj1Qg==
X-Received: by 2002:a63:308:: with SMTP id 8mr22426124pgd.112.1593630508409;
        Wed, 01 Jul 2020 12:08:28 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ab5a:d4e:a03a:d89? ([2605:e000:100e:8c61:ab5a:d4e:a03a:d89])
        by smtp.gmail.com with ESMTPSA id 83sm6759580pfu.60.2020.07.01.12.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 12:08:27 -0700 (PDT)
Subject: Re: [PATCH] null_blk: add helper for deleting the nullb_list
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200701042653.26207-1-chaitanya.kulkarni@wdc.com>
 <SN4PR0401MB3598CBDDC91C894992996DA29B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BYAPR04MB49657173EED97FAE92FEE156866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <812af519-7bb3-586d-14dc-d3a529b49b69@kernel.dk>
Date:   Wed, 1 Jul 2020 13:08:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49657173EED97FAE92FEE156866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 12:45 PM, Chaitanya Kulkarni wrote:
> Jens,
> 
> On 7/1/20 12:26 AM, Johannes Thumshirn wrote:
>> Looks good
>> Reviewed-by: Johannes Thumshirn<johannes.thumshirn@wdc.com>
>>
> Can we add this ?

Please don't ping me for something trivial just a day after posting
it. I'll queue it up, but it's not like this is a stop everything
and get it in kind of moment.

-- 
Jens Axboe

