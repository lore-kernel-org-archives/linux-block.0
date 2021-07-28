Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D023BC4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 01:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC37060F6B
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 01:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhG1BlS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 21:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhG1BlR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 21:41:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958E6C061757
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:41:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t21so724688plr.13
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vkigFjj7ZFWSSWQjj+MJXkzceYRMqGIfKde0mYoF2Eg=;
        b=0riDyUSx1alO5MIOxkHqS9cao6uMJofm+3GQNnRAwsa7gioIr7YcZIuoCbIwSXAi07
         h35G1LNS53iZUKzBl+LgXmu8U2Fl6AQf8W0rLNMvNb1Ri5g1NM/I5WfzQbfN7IWyfCsU
         HN/rNg8ucSuc5cUacgX5a/uN3yHQA4vPBZXwOpgnuK7/bAxixzWhZBUaHL6tFluUuebH
         Ska33xT4pGz7RC+6MZzaJIUvZFlt7tjZV77Li4kWzViA/IiiDULkk+KOhS7R1ijYRy9t
         x9iybhxVyX2rUEOkRP0k/2QLVRcbExVHsipeJ9zHh8AZNVlTZ4GzSPHck96roqXWHYaf
         068A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vkigFjj7ZFWSSWQjj+MJXkzceYRMqGIfKde0mYoF2Eg=;
        b=BvzKPluY1q1z+lkk9MlMLQA1lx6YUmQnPaSdv5xVZsWF8hYuenlpS8MELXfKcleVjI
         cDfwRHNxiLbpGJ03vfN2/ExVRipwUCOHwrMRZYhwELimywz+Ok2TeJgDnfEKozucEoVf
         EnWCrcsbvR6bHJQSyiSHnXHnfcn0SEPj3hEEAl/asYeOBtAJ1qpEDM+6nNCxcCWttV8i
         0jkAk+BdvBJBbIVDOky9TUg2H34LQzeEotbzrmJesOExsPZTYRpxCkAUvNM2+v57Y2tl
         An9l/NUjcTBUdyJGooAA8JM0F9kQKv1H0ARhA4qziK6aRjEnLCBt3tC0GI76r3TdR3YE
         5JTw==
X-Gm-Message-State: AOAM532PLvzQkRhBVVHSLDeF2NYznWWEF8tET/CmIWMxzO76AHzMP+h7
        G/Z7AOxlJY4FTS8m/867WAhBt2wwOSV4Fc4b
X-Google-Smtp-Source: ABdhPJyMhQ6T36GdBXucoImr1vyKw7B8yFxuO7gQPXBOn3JwRPnyw547kUy0VGx0nKk7i1hzoGYCdA==
X-Received: by 2002:a63:1b5c:: with SMTP id b28mr9752724pgm.175.1627436475946;
        Tue, 27 Jul 2021 18:41:15 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id n5sm4927804pfv.29.2021.07.27.18.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 18:41:15 -0700 (PDT)
Subject: Re: remove disk_name()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        linux-block@vger.kernel.org
References: <20210727062518.122108-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4910f48-3b6a-3911-c5bd-48c7c613dced@kernel.dk>
Date:   Tue, 27 Jul 2021 19:41:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727062518.122108-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/21 12:25 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes the obsolete disk_name helper in favor of using the
> %pg format specifier.

Applied, thanks.

-- 
Jens Axboe

