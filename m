Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7402C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 15:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBF460FC4
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 15:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhHMPr6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhHMPr6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 11:47:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8A5C061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 08:47:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a20so12552504plm.0
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TAHZ9xtB9D+0vRE/S8GTVqJgU+M+H3OBUaxsP5GUUy0=;
        b=zVjjfXmmFL6uWMbplx8qwZpKz/qocv3OVo5bNSrKq2e6ZZYOqKGKmh7AfjPTlW0Zf8
         SrSGtTajDjFnJNra5e8EzvyCTOSQ+ZjqioJL7JaMl8wnMkaxidHfr8kkQzb3RP7+fmKL
         yf08NXmMWpdfesnTrEVBz6hLoRCoqeirvNUFFZP7mmdof0SOJnFTgvkJdj0l+TGvcE3o
         pXmAb+gj8p6VESU6aff0hxI5l23p3/R1gQSmP+gbfj6m1nEXgBmwp/sUaVG5F1dAG9LQ
         vHtN0c3sSPTGOaXib1ipAuP+5FAy9rG1q1Ll5IOEgs5ndNLXeNGEeUPZJJDXB9itiizA
         lfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TAHZ9xtB9D+0vRE/S8GTVqJgU+M+H3OBUaxsP5GUUy0=;
        b=d2Eu7dfNVPiiTZ8NYDhxxfZ+SdDpj0CNByKT/s50fsUl8wnB7wnK1rtEqFxWLE9F/3
         i4gczx4oPdCURSnxTPidAjKuO6R1qEqpre7lB7TIyApO7+lBPfbcdtt0gCVXNIPKd/4D
         wYRdS5cVlHm//JO/GBpAE+RvCPPXAuI7WTzo0xMwW2Q1MqyPTzERuidT1Rp0k/L4vDtj
         Flb3yUvl3pOUtxKoFnL6IoLDSkBJa5ZU+GaF4NBobki8VZrRyhLAuQrOjdERltxgjES/
         hcFV18OZMyhWC4wh4cSwHAg9K6/Snhq6vnKfk6BBXBJBWUwE0aUg/uWbXE4KSFgP1V2f
         I3dQ==
X-Gm-Message-State: AOAM532SppsH2zaIueDSXzZLt77x4l8x6rNiW/x3trf2z1K+QM94SMAJ
        ebU4JZYmAH3FYN9e28l0+EKwXA==
X-Google-Smtp-Source: ABdhPJxu6iFt3It7c7oZuenO9Kkj1tWXwzMyk2OuNiEAvBiV7YGUQDEIvvCICn8DBh7RyvJAj9Xf0w==
X-Received: by 2002:a17:90a:6684:: with SMTP id m4mr3230706pjj.127.1628869650611;
        Fri, 13 Aug 2021 08:47:30 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i6sm2768562pfa.44.2021.08.13.08.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 08:47:30 -0700 (PDT)
Subject: Re: [PATCH RESEND] nbd: Aovid double completion of a request
To:     Xie Yongji <xieyongji@bytedance.com>, josef@toxicpanda.com
Cc:     jiangyadong@bytedance.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20210813151330.96-1-xieyongji@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b10e7bd-f00f-33de-5e53-38947b270fe3@kernel.dk>
Date:   Fri, 13 Aug 2021 09:47:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210813151330.96-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/13/21 9:13 AM, Xie Yongji wrote:
> There is a race between iterating over requests in
> nbd_clear_que() and completing requests in recv_work(),
> which can lead to double completion of a request.
> 
> To fix it, flush the recv worker before iterating over
> the requests and don't abort the completed request
> while iterating.

Applied, thanks.

-- 
Jens Axboe

