Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA907ECAAD3
	for <linux-block@archiver.kernel.org>; Sun,  4 Sep 2022 12:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIDMjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Sep 2022 08:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIDMjR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Sep 2022 08:39:17 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47F23F1CF
        for <linux-block@vger.kernel.org>; Sun,  4 Sep 2022 05:39:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id c24so5899440pgg.11
        for <linux-block@vger.kernel.org>; Sun, 04 Sep 2022 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NbFG56hK+I6GviLATYTXzCpVIXX+44MuvGDwFE5SfwM=;
        b=xzyJcQpgvut0s4RE8zd33agXqmjjNt1mLSZsGUSEp2+e4dZOPWh181FPHEaxpe97w7
         TybRZRTXcuahrhmVZ99Zpj8gUMxyFhvXzvM2vNdSw4pMbXNehF5jqfcdLmX9TIAb3j92
         EYrMGgT4s56noJSXdCI4VIefKmMF8oRqxA1M5rT2ARuKhIzVkER0H+MsCU3wy1Ogk7rV
         AHeH+j9IiHJBaBSBz+WiM4itVdrVqZg8G/CBWY6e0rSYebRNcubl8bdB6mADcybXKvYp
         eQPTQEsC7JQvjHfv97qyy7pMnK/NDdLswmsZySjV/URvLkWX7tQyLg91AtQ3tRV3bII8
         ezlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NbFG56hK+I6GviLATYTXzCpVIXX+44MuvGDwFE5SfwM=;
        b=sLqi+Heo4wfB2MjDPrJxwY0EhsoOnd8MSd9t2AAgjKPyCIXuWTxfg3EkI3LuJy71sB
         eOd1jwdjIraHZIV/Dg36w/qDuL8O2gd6EPsFlGaYaLq+I0BImXRZGtYOw5MXvScZXo8z
         FKHn7zwQMimooccac/ZLjeYRHPNixKo5mO28jjSggOfiPz52UmBG8pW8Zu2E2GSZeSXL
         b4VO1VJW3wDR2fwyrYV4QQXJoj+c9tB10KP8SsIVqXcShOPRm79Xx3vqJ7fZWcREXkiE
         idibZuPIaZ6l8RcPtch+6sNBZGvJno8jjWEziBAjqcFU6CF3LdeYFj/cqPm+3qauJf01
         AbGg==
X-Gm-Message-State: ACgBeo06mkeCBwNakKV+djZYiOoEaZA59HHCH+Z/JJ44kvMDHcxC0FCH
        RLoTNgLkaXZvKscgaGyUlRn1CzBzPftn7A==
X-Google-Smtp-Source: AA6agR5m+kdWymz+svuz8b9E37QQGz6i9hVDY7GYh1QqktTo2wAypCWl7OhphIeeCaGrPrR2nVZOOw==
X-Received: by 2002:a63:fa53:0:b0:42c:18d3:6a6 with SMTP id g19-20020a63fa53000000b0042c18d306a6mr27946571pgk.79.1662295155967;
        Sun, 04 Sep 2022 05:39:15 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b005379c1368e4sm5692068pfr.179.2022.09.04.05.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 05:39:15 -0700 (PDT)
Message-ID: <e742813b-ce5c-0d58-205b-1626f639b1bd@kernel.dk>
Date:   Sun, 4 Sep 2022 06:39:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCHv3] sbitmap: fix batched wait_cnt accounting
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Keith Busch <kbusch@fb.com>
Cc:     pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>, hare@suse.de
References: <20220825145312.1217900-1-kbusch@fb.com>
 <166205058410.59240.3725947759855970973.b4-ty@kernel.dk>
In-Reply-To: <166205058410.59240.3725947759855970973.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/22 10:43 AM, Jens Axboe wrote:
> On Thu, 25 Aug 2022 07:53:12 -0700, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> Batched completions can clear multiple bits, but we're only decrementing
>> the wait_cnt by one each time. This can cause waiters to never be woken,
>> stalling IO. Use the batched count instead.
>>
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] sbitmap: fix batched wait_cnt accounting
>       commit: 16ede66973c84f890c03584f79158dd5b2d725f5

This is causing CPU stalls for me running make -j256 with the source
hosted on an ATA device with QD=32. It's not running with a scheduler.
It just goes spammy on most/all CPUs so  hard to get a real trace out of
it, but it looks like we're just looping forever off
sbitmap_queue_wake_up().

I'm going to revert this one for now until we can investigate what is
going on here.

-- 
Jens Axboe
