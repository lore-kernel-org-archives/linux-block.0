Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3C4C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 23:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3F6611B0
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 23:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJSXdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJSXdt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 19:33:49 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F757C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 16:31:36 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h27so14417078ila.5
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=z7956vRXsD/+kZcHm9VUsFq/OKQCwx+ympYT/+UXWnw=;
        b=7TEZ2heqyBcewvv8GpR90DK3sB0CaY/WI4sZwPmKITWbdvXLMbVqRTqSmHGYdaMElt
         VwoSzu9LWP3MPhfT4u1iWEMnykgvQOJ7QoE87jJAHcQiSc2UOrkmPlkRmSCPBqM87MIW
         pVS32mFevRvO8egNxzIWy7UP+r4rsQxraxrI6E0Lltb8jPdjbEpwprfk2hqkSi4AUmjI
         YXMxpb2WbUMzajB4InWFUbu3pOgKZzEbR5+DGq0k/BWuszAHXspo7FX7FU3tzwDBwH8C
         QvMRBBgiSQLbloH+sSBc/ncyc4euZyXJ8v95yTAVss+xgYH7196JVxNPrBrBH0pddZ/d
         VX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z7956vRXsD/+kZcHm9VUsFq/OKQCwx+ympYT/+UXWnw=;
        b=OYzHUXxFZzDQXvwRSogQ5M0EjO0sGzm6+e117X/43ynoRuC3YmycCZPXPdFXH68DVJ
         sg96uJShZrNbNQ2TvtGy0APzldfCgqWBjO10cV9TLn3viBo4MPj98FqayYBWFaxMsNJv
         Ak8uM6LHUCU4qe14kzU56CFGUGE7sAnubxkNKuCNhPOzmkafut4/vNAgEO8EePhgfHOZ
         484OJN6gecsWJntM6qTTw+JZecZOQuVX3n8jjvKfMOMGNwlO8XIqMaXyU0NW8lIKzyhe
         4+xrubBiATniuFnY6NdauzWorLiCdpAGdooca3mxurGUxZVOY9mybl9ZSnK1yvjwDZa2
         fI5A==
X-Gm-Message-State: AOAM533R3ydKb4D212hCDbHL+FLDsIZe1diFWlsr1Ztc/T4rndbBJMxt
        boUGgoxQBgUn2a7Y6NLW9RSMY0iEOqlgYw==
X-Google-Smtp-Source: ABdhPJzGMkMHUuBLQvrDbbCPP8Q/JHXJRbhycniNCaF/jXvRwIfcz6twntOivbAH6HUrV7nI+2JC/g==
X-Received: by 2002:a05:6e02:1a42:: with SMTP id u2mr20695061ilv.214.1634686295689;
        Tue, 19 Oct 2021 16:31:35 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u12sm239956ioc.33.2021.10.19.16.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 16:31:35 -0700 (PDT)
Subject: Re: [PATCH 00/16] block optimisation round
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
References: <cover.1634676157.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ef4fd7e4-e357-9973-e9b7-f818b85315b4@kernel.dk>
Date:   Tue, 19 Oct 2021 17:31:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 3:24 PM, Pavel Begunkov wrote:
> Jens tried out a similar series with some not yet sent additions:
> 8.2-8.3 MIOPS -> ~9 MIOPS, or 8-10%.
> 
> 12/16 is bulky, but it nicely drives the numbers. Moreover, with
> it we can rid of some not used anymore optimisations in
> __blkdev_direct_IO() because it awlays serve multiple bios.
> E.g. no need in conditional referencing with DIO_MULTI_BIO,
> and _probably_ can be converted to chained bio.

These look good to me, only the trivial comment that patch 7
has a blocK instead of block.

I'll await further comments/reviews on these.

-- 
Jens Axboe

