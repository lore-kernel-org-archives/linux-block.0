Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B76C04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A1D2082E
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dEVj7Dhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfEPOMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 10:12:05 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40395 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfEPOMF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 10:12:05 -0400
Received: by mail-it1-f193.google.com with SMTP id g71so6461720ita.5
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2WGsOfO1f/PLd27MvCiVG2GI1dopnHEmq10/2ccQ6BE=;
        b=dEVj7Dhm8qGgbMM+aZJgxfHzhLGKucG/mELvSUwrN6CK17UjNGwqdZj3b0tvbLIILb
         TgvytUwl9QUGaaATdF1HxSXb2Z/5ATVwkLbX3Yn1078ZubUiguypAy8nvlp3VbNPNRjx
         J6RDn9tGYExYvNc6zNNZAB+u6NBiVa4aV3m/fLkZg1tPp0nWNNrcGfO0VZIkK3QDPT1V
         X/cZ/lem3uZZizRFV/Rf7h4sXFOeLEqiPYg8Beo8LGXS1ggDUYTjE7NJVb+LNqyl7V3e
         T4LFniGCPQGKfGMOx807oNVZjujEXgL9qNodAUj3wJhIcoC2DE1nlQWFxrgMvkV66Uwb
         h0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2WGsOfO1f/PLd27MvCiVG2GI1dopnHEmq10/2ccQ6BE=;
        b=lCZqRS9idql9HecKTI7MaJuUC60IMpOfdDeJu+WEDhzGvZeNuBadChLN0/yDV7iLJd
         60Hc30TSoYvcoFLCslG4ZvrnIB/ymx9awuQrg5qE0t2M4haKt8MPtQ6y/zF4z5hXTzlI
         xJJChctWdwsJ8r4DGKisk8BAMiuZCPn4zYEU7P7whUdkv1r0KeJY2WGRK6KpOQ3KiD2e
         YruqBRHhtEd0rupQIYKaaGeipufitzpLFrU1lHBUqOk93CFHf4GxV0Ae35kIkit9Nzb5
         vHv5u4SMXsk0IQX2km/RE55XX3rSU1T0x9Y0rimgvuxtL1M9ffjdFHbaiVgUt1e3p+hA
         2tcg==
X-Gm-Message-State: APjAAAUG3LxX4Fuj/V91wnrP8EfT04o/Y8LgBFcd8b7JucQOoAhUQrIj
        NaJReOjHvrJWH4OZxdvTzDUchIlyGifVmA==
X-Google-Smtp-Source: APXvYqwiQ4jPInTWxH5qxJtYdh7R7YfphmAWNYEXr6qpuwARjaU+2AGnYHR4+wmQzNwavg8YeChUWw==
X-Received: by 2002:a24:aa42:: with SMTP id y2mr12591620iti.23.1558015923345;
        Thu, 16 May 2019 07:12:03 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l80sm1601795ita.15.2019.05.16.07.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:12:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: adjust smp_rmb inside io_cqring_events
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1557978391-26300-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0451672d-afed-99f2-d0d0-b22d9eed56b0@kernel.dk>
Date:   Thu, 16 May 2019 08:12:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557978391-26300-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/15/19 9:46 PM, Jackie Liu wrote:
> Whenever smp_rmb is required to use io_cqring_events,
> keep smp_rmb inside the function io_cqring_events.

Nice cleanup. Applied, thanks.

-- 
Jens Axboe

