Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC57C433E2
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 15:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2482065E
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 15:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WREJSjZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgGOP7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgGOP7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 11:59:48 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34A8C061755
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 08:59:48 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i18so2400416ilk.10
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M6/N0Qn1n5qzNowRg6oLqQeni7+/TuEUR/sgLZKpfHk=;
        b=WREJSjZwfybflKUK/XeTqV8B7qAt/y2yO7JkqmvJ480gBO3onVbnfzDS7t+h4sehar
         jR371V8d/dL8SZHQBiQbAMUPOT2bbk4z9NRSoaz4E8KqwmEvGTx8vXVbszKuK6E13lWl
         MClj4NngyCiqm17u1lslEf0ygUaRhtwHtV9a/uXDQig0T//qcab4QGjuYIZK46BFeX1i
         dYhdbldw7FhcO8b+f3g9QmpZm7Jvcw7AtHlaQ8m+iqzIC9Gntw60XsmbNJHaXzC0/uLN
         11PM7UYUZTbqc5i8Epq8zQSFpMbrjFuOqvdxNMTfa7NWliE6tz7rcK1YYuirEQE7bzTq
         U4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M6/N0Qn1n5qzNowRg6oLqQeni7+/TuEUR/sgLZKpfHk=;
        b=iEX9JxLLyVY8swQk+tbE4SC8Oa2fTo+sJjTfcuofmFQLa4Ysw8xiD09JvAHU4GfsGM
         B5mkJcJLMbQK1tq4IoAFwaY2QZ66P9k6zcuWA1jD1/ZVKSG5MRuYER3/Zyg4omFY/6ZJ
         c40ELqAiLAdSBYeAMAd45QH6Yiuye/gPUpe9OmPcqAHI06gIL4BQKFiTVuPTW6OCaXxx
         nZ4xy3hqL1CPnXnDee19k8Xhu5d47Lrp3WiqBVMPrHLawt7/m9igJEOVaZBpbhVZJiUE
         MqLoiKnimr9Swz1jqZ8Zw4f6rD7qg9QtGA4o8MhRnEqcj37/uaA2LW8+tjMVxN6nry2x
         uwaw==
X-Gm-Message-State: AOAM532g68tznFytX3L/HcpC8WV2b+46tR4Ihhot2T0+L3BjoFDVsKKU
        eqHq1ly6LAruojmsHXEtIXmeILZ5HIXnzQ==
X-Google-Smtp-Source: ABdhPJylwvOxmUjJkc6XlSm9bwpOoaDysTI3/F/Ul+S6yeicW1+fE6eSMlteVWEQEYa3aNgKUPOyUA==
X-Received: by 2002:a05:6e02:dc4:: with SMTP id l4mr203168ilj.134.1594828787909;
        Wed, 15 Jul 2020 08:59:47 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t7sm1310637iol.2.2020.07.15.08.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 08:59:47 -0700 (PDT)
Subject: Re: Possible bug in block/bounce.c
To:     Ziyang Li <liby99@seas.upenn.edu>, linux-block@vger.kernel.org
References: <1CEFBFC5-7B0D-4F92-BE37-013CFDEC9F5B@seas.upenn.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f46b7cd7-c6c9-e73c-b6f1-348f7df2279c@kernel.dk>
Date:   Wed, 15 Jul 2020 09:59:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1CEFBFC5-7B0D-4F92-BE37-013CFDEC9F5B@seas.upenn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/20 9:50 AM, Ziyang Li wrote:
> Hi all:
> 
> I hope this is the right place to ask about a potential bug in
> bounce.c. So on line 329 we assign the result of `mempool_alloc` to
> `to->bv_page` but we never check if `to->bv_page` is a valid pointer,
> also given that this variable is dereferenced in inc_zone_page_state.
> I wonder if we should add something like `if (to->bv_page == null)`
> here?
> 
> 329: to->bv_page = mempool_alloc(pool, q->bounce_gfp);
> 330: inc_zone_page_state(to->bv_page, NR_BOUNCE);

bounce_gfp must have __GFP_WAIT set, which guarantees that
mempool_alloc() will always (eventually) return an allocation
successfully.

-- 
Jens Axboe

