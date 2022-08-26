Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3DAECAAD6
	for <linux-block@archiver.kernel.org>; Fri, 26 Aug 2022 19:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiHZTk7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Aug 2022 15:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiHZTk6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Aug 2022 15:40:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEC6D3447
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 12:40:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f17so2449348pfk.11
        for <linux-block@vger.kernel.org>; Fri, 26 Aug 2022 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=9TDQl3EoawGEasiUrqXO4xQE7T1QwXgU3F9o0j9eN/8=;
        b=V/L7c94QmrtxPqVBgIH91Ok9TP6RE02q6PTDffeOvjVkPtepI8X6AsxcnjE8Ap8oFL
         3XC5pia+UTBmSrhTShqCyJH9kkJo/8h22G09gRb+68zjlYpSBFIo7MjmT2cZPYnWQrJs
         LDHidpuWUuGivq53EMP3PU+MGgnaw4Og7XDwfwj+7PgL690jFY5wEMu154wZJlo2xhCt
         8bIWOid6L7LtEASpG8dOOvzM6R6sHfxdSjfNnBpW5OSG+WIDa1e6tA/d74o4BEm8HUyt
         TY9rt1zV7m0kXug6QywBPrJdaLk1cjgp9XjA02eqhKLOjRACGCXAhe0XmNruJfXwjqqh
         WYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9TDQl3EoawGEasiUrqXO4xQE7T1QwXgU3F9o0j9eN/8=;
        b=TSPWHXws6WS87ZboOdl6V8nUYVEg7jxxwtky7DUKjmTxJMSin7OH5jzSdR8jWng1/w
         fiJ+I6Eos1h0jV+zbjb8MjuWmob9kgjBL9UzQT7nV1WsNEp9Mks7W3pj1dPTks8rgLbt
         ONOuqics9FjwMcs+qh8uLOSJPzhrODTHk16P5qX2M8doHc6CJ8PhPLFd/0VRYVr2JVuH
         ZSuVKqfTa8BWxPRHB3m6XgrZCnqPUV6QoLiaN/pt6QFnHVs33Prby2wEqFMuY7Ac1wnY
         0FEKszbgg8wh1kwwFW8CwYKSpE7KKzUTc5AldbuaRp1mPmhbJh95vj4U4lAfGTK186VX
         qXpw==
X-Gm-Message-State: ACgBeo2fOVPPFlg4tUYFMfPe39abEbumAIUtYHGXiJD7iObQkKwcl22b
        hrNzLD5GqCuuLu3I+Zu+r5ZnHAQCjoGH2A==
X-Google-Smtp-Source: AA6agR5S5hIUv3jD9W6fA2d06mSv5Xd3akVS7JzlWzo5LOqkKaVJd4gKTM6yFmXFzJroEkWt9uJH4A==
X-Received: by 2002:a05:6a00:1356:b0:537:9b9a:4db3 with SMTP id k22-20020a056a00135600b005379b9a4db3mr5150512pfu.69.1661542856679;
        Fri, 26 Aug 2022 12:40:56 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z10-20020a6552ca000000b0041c30def5e8sm1811520pgp.33.2022.08.26.12.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 12:40:56 -0700 (PDT)
Message-ID: <07dbb2ac-04ea-d09c-9e46-8d77bcedbb93@kernel.dk>
Date:   Fri, 26 Aug 2022 13:40:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] block: I/O error occurs during SATA disk stress test
To:     Bart Van Assche <bvanassche@acm.org>, gumi@linux.alibaba.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org
References: <000a01d8b8fb$7b4a7950$71df6bf0$@linux.alibaba.com>
 <81c70a13-0317-49b7-c3b6-61f6aaa21c10@kernel.dk>
 <f95bf278-e999-2068-01bd-c01f363e66a5@acm.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f95bf278-e999-2068-01bd-c01f363e66a5@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/22 10:06 AM, Bart Van Assche wrote:
> On 8/26/22 06:36, Jens Axboe wrote:
>> That aside, I think there's a misunderstanding here. v1 has some
>> parts and v2 has others. Please post a v3 that has the hunk
>> that guarantees that deadline always has the lowest bit set if
>> assigned, and the !deadline check as well.
> 
> Hi Jens,
> 
> Would it be considered acceptable to store the request state
> (rq->state) in the lowest two bits of rq->deadline? This would reduce
> the deadline resolution a little bit but I think that's acceptable.
> Except for blk_abort_request(), all changes of rq->state and
> rq->deadline are already serialized. So with this approach only
> blk_abort_request() would have to use an atomic-compare-exchange loop.

Sure, I think that would be fine, as long as:

1) We keep the expensive bits in the actual timeout/abort path and not
   part of regular issue.

2) We rename the field while doing so.

Might even be worthwhile to look into NOT having both timeout and
deadline in struct request, it's a bit annoying to waste double the
space on something that should just be one field.

-- 
Jens Axboe
