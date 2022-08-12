Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE0AC00140
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 12:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiHLMki (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbiHLMkg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 08:40:36 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC6EA8304
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 05:40:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f28so867722pfk.1
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=s3Kp5U/VqVuXGiRK973FMZHaRwO0ydhDLvBsgwOJLzA=;
        b=gLZsBiTTLEPVy2cmiA3Pwmxne/zs8SA1JDvPET37cNfShVVdR4C9eT2XTlOE/P/tss
         jRAVksKlRd3vS9kBOvGs2qpbgb1ijPxjVN2brh+pdtHi/8TU5Kr+Br0VD9GkT9IkLJDb
         DF2B4vwV0WhpfSSs/j0ehgRaEog8cd0gFzBWROL+2P3/MpviuVKN+KRVQtiO/DlUlSnu
         4XQ4+35mi269Ptxvpt3cqokzQnYPHfM3+QrKJirYutFmq3oFYxsYTGGm2DGlSZVSu7TQ
         1BQxqzoReT/ITmn+Ck6gxfg1PLOPTvEGh2XpW9XeZboXboeEG0ShuXV4i8Oe/xwUgYTe
         T5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=s3Kp5U/VqVuXGiRK973FMZHaRwO0ydhDLvBsgwOJLzA=;
        b=6IrZW9OOE5+uiSckk8zAcA5dbKpwA7VZajZR8O4tncUDvtMTcYbIz727UEbex6EBMU
         GWNoAsOGLvQIZBwNwtUhRJpukgFSS9Pi88LY4VeqLepPJ70poNirFY7qzHw9SOccq3Qj
         /27rP1JoDnAK0V0yvwoCoLHemw2c9dCDIVnZeguq/49u8/TLaPre4CdfTDdzPymYj1eA
         NB+oO16Hia6JogiLjQF8emTVS+dwEe6eP4ZPnjGfAtmV8DwHtFqgZ2KmwjThmmM5u4mi
         97Va2FpChkZHVu9f2UeMAOryF2JQHQVmz/BkElomJl2UVmkXzFjig3WJ9fYmgT/pP2rj
         FweQ==
X-Gm-Message-State: ACgBeo2yl4mv0hzwxeb0UyeDF6Fw9aqbf5Po9E622K65e7i8dunIHLsV
        5lA7X/+HjtmxHg3r4Nv1wikF7mEUJ5AriQ==
X-Google-Smtp-Source: AA6agR45hdm0gHtQS1u4JLDnGlQnpfrE9Vhym1N9TiwMCG31vlAKdrRpslpiENNjFvZsFscXGyl94g==
X-Received: by 2002:a63:565c:0:b0:41d:17e1:32f with SMTP id g28-20020a63565c000000b0041d17e1032fmr2943973pgm.445.1660308034832;
        Fri, 12 Aug 2022 05:40:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a134900b001f766b6a879sm5249203pjf.44.2022.08.12.05.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 05:40:34 -0700 (PDT)
Message-ID: <330468da-a778-6cfc-ce46-a62566d71c8d@kernel.dk>
Date:   Fri, 12 Aug 2022 06:40:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] blk-mq: move bio merge attempt to blk_mq_submit_bio()
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220812083944.79616-1-zhouchengming@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220812083944.79616-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/22 2:39 AM, Chengming Zhou wrote:
> We will try to get request from cache before alloc request, in
> both cases will first attempt bio merge.
> 
> This patch move this common part to blk_mq_submit_bio(), which
> simplify the code and avoid passing in the pointer of bio.

I don't think this will work. If we get a cached request, then we
know we have a reference to the queue. If you swap these around,
then that's no longer the case and we can have a use-after-free if
the queue goes away.

-- 
Jens Axboe

