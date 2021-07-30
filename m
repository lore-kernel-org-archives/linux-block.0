Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB84C4338F
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 14:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3217460C3F
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 14:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhG3Olq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhG3Olp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jul 2021 10:41:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A61C06175F
        for <linux-block@vger.kernel.org>; Fri, 30 Jul 2021 07:41:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so14597598pji.5
        for <linux-block@vger.kernel.org>; Fri, 30 Jul 2021 07:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6l1SzWIJp6ui72AjoLHGw4IEPvjHDoRffC3JlmN+BDI=;
        b=Flv9EIz53uWi+fTwLEBY6FqGAB6tY7YgNeOuZMKtPWeh4J61iwmFDgq3xIAvJ+VQ4Q
         hafLuibmMA7IBvKkTgdFGGN8Ew+2tQ7IOcGiy4izJiPUVq0h134rFceAO067CIBlDT6f
         l/WKtwF8t4GMGAsAE5HnTPAh1UufQLcbS6NjaJdyUb+hqsfOMRDFAEtqjZANTbtQtn/3
         yHVej4igT9jpj/jivTGu7Bk4jLE2EyaTu0LDzY3EGDFAAc05SHPdChfIx4L0uC6rJT2b
         sCmnw3spzLMfzZNkTgQlknMFNEkJfWMlTiEpqxAyS4DW5iz9FJNrCmcruoTMtmE5aEz9
         rADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6l1SzWIJp6ui72AjoLHGw4IEPvjHDoRffC3JlmN+BDI=;
        b=Y1sEFlh/3aX2otlKvuoe3cg5HDaO+kBT515zpTOYJfT0YYJriULqIgWpl7LNtV9Ok7
         9NiVH5MXZHRzmm9Ummn9cn55WkBl3vyGgvHyBO7nREJr+KtH8Dmv0UTz9A+fMw+KRTpL
         R8zgyxEZt2zUCDDxVupWHsxl3C1d6O/0z8hROH0dnuXXh0TZO2bY7F3zMqehmggy9uAS
         vBYuPJyJBAToAAvRkLNxU63QetZASedtoFGDVRDDW//OTvC1qYG32CpsLB6/PPMwzY86
         BKLUAxxnz257NIcrP5CJfHfffCqMRG7WeZI5cjkkc9Vee+hVeqxXItnCVcCNOq6PQ1XL
         R4LA==
X-Gm-Message-State: AOAM533ebfwbOgWQWTHT+HUAJx8AtTahZKOmDAK2LHXxbBnZ+3tRvy7n
        DJGOQR25kZ/sjp8cl5NhulOWJaPVVzlzIpab
X-Google-Smtp-Source: ABdhPJwnqlhU+5PizCX1p68UoT1UiLeRDWhWHyDlSfb6+/NWP1LOtGJ8W6jjB+ZjLE4dRCqqz6dIlg==
X-Received: by 2002:a17:90a:5201:: with SMTP id v1mr3361419pjh.46.1627656100166;
        Fri, 30 Jul 2021 07:41:40 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id p10sm3125207pgr.14.2021.07.30.07.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 07:41:39 -0700 (PDT)
Subject: Re: [PATCH] block: Fix typo in comments
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     linux-block@vger.kernel.org
References: <20210730073928.2813-1-caihuoqing@baidu.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d09d100-06aa-bd8a-8476-12ef90aaa6f7@kernel.dk>
Date:   Fri, 30 Jul 2021 08:41:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210730073928.2813-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/30/21 1:39 AM, Cai Huoqing wrote:
> Fix typo:
> *submited  ==> submitted
> *IFF  ==> if
> *becasue  ==> because
> *idential  ==> identical
> *iff  ==> if
> *trival  ==> trivial
> *splitted  ==> split
> *attributs  ==> attributes
> *insted  ==> instead
> *removeable  ==> removable
> *unnecessarilly  ==> unnecessarily
> *prefered  ==> preferred
> *IFF  ==> If

iff/IFF are not typos, they are commonly used in spec writing to say "if
and only if". The way they are used here is identical to that.

Outside of that, I generally don't want to take typo fixes like this as
it just makes backporting more of a pain for no real gain. I do welcome
typo fixes if you're changing the surrounding code anyway.

-- 
Jens Axboe

