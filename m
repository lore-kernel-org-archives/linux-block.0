Return-Path: <SRS0=SW/x=55=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394CAC2BA2B
	for <linux-block@archiver.kernel.org>; Mon, 13 Apr 2020 22:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156CF20735
	for <linux-block@archiver.kernel.org>; Mon, 13 Apr 2020 22:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t8A7iMHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389728AbgDMWrw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389718AbgDMWqC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Apr 2020 18:46:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6DDC00860C
        for <linux-block@vger.kernel.org>; Mon, 13 Apr 2020 15:46:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a22so40328pjk.5
        for <linux-block@vger.kernel.org>; Mon, 13 Apr 2020 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DlHdQCi2H0syDxvBTC80XrvhxI1nKgFH20mTvIJx2R4=;
        b=t8A7iMHy98lu7aAj4Ut0S8YhVHvcvCxI9S3dKCLqAUsAhOMzP0oaKn2wmky8zOKVR8
         6re8LkR/m7gtqbwzNdZvByfUtDnk5W0dWQzV/L4qfAvVcbEopb1J5OrWuQWsb4E3iJqv
         y/6wIYtiRzl0pN/wmo8jTv8Dk5gPRuOgXsfPhrxLf7R+qPZbJwmo1ZemsUjz25v84Y7f
         n6WVhLQMSf/sUFd7OmT10rmqZUGJNcdY+/fo1ju+DATjIJ3Ge6iBYMCq4ATWEgZCuevF
         ruiANqNHMHwZWM2zgdMkkNVHE6wJ9WySyvBUd62wIqd98h4bH0PBTo//KbojRRhEYQhJ
         Yvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DlHdQCi2H0syDxvBTC80XrvhxI1nKgFH20mTvIJx2R4=;
        b=Ou7k/ZJ3o/UEyv8+Z+xdwZogP19PC07f9EZVfXezkOFncvqnqJMQWyoui4CZHHuw/h
         x0L4jDoVcu7FblJf91XW18KgEcC13k14HxchOgecWv07uFFBrGS/byc5AY8OCTaU08Q8
         hMGv89MvzjrDVbwivVs6zezt4QdwjSwPPtaultEZ+zqkwavDNVkfMcmPw2wU1YZoSmEh
         MAU1vkF/j+1eBGv4mFD7oY3afvHC+eB9FOnluIxJHEAI8tELHUW14j5pKIXAfLxx/rec
         Efpa8Y8Ae47c/muNOSa9ZWy8pNIUQ24tZm3e9qUb9VGyhwrfX5MiDBWE2ZsafXEuVxLL
         +k/A==
X-Gm-Message-State: AGi0PubQD+OP07pzfaF2k1OHm2PENCgT7/tOsUlq8fKv915kU2CjarAw
        YYjrqB2FGLjY324JPcTwj35ETg==
X-Google-Smtp-Source: APiQypIvoBKuQy6cwYwfIns6rwGnd547U/pvTpc3Kss5nY9OI46KjTwcmT48rQdpUQXQyjsNWZqaGQ==
X-Received: by 2002:a17:902:9b90:: with SMTP id y16mr18672617plp.227.1586818004731;
        Mon, 13 Apr 2020 15:46:44 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y26sm4441549pfq.107.2020.04.13.15.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 15:46:43 -0700 (PDT)
Subject: Re: [PATCH 00/23] Floppy driver cleanups
To:     Willy Tarreau <w@1wt.eu>, Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Ian Molton <spyro@f2s.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>, x86@kernel.org
References: <20200331094054.24441-1-w@1wt.eu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae23d88d-fc21-6f46-7c27-ea0adf6211e5@kernel.dk>
Date:   Mon, 13 Apr 2020 16:46:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331094054.24441-1-w@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/20 3:40 AM, Willy Tarreau wrote:
> This series applies a second batch of cleanups to the floppy driver and
> its multiple arch-specific parts. Here the focus was on getting rid of
> hard-coded registers and flags values to switch to their symbolic
> definitions instead, and on making use of the global current_fdc variable
> much more explicit throughout the code to reduce the risk of accidental
> misuse as was the case with the most recently fixed bug.
> 
> Note that this code base is very old and the purpose is not to rewrite
> nor reorganize the driver at all, but instead to make certain things
> more obvious while keeping changes reviewable. It does not even address
> style issues that make checkpatch continue to complain a little bit (15
> total warnings which were already there and don't seem worth addressing
> without more careful testing). Some comments were added to document a
> few non-obvious assumptions though.
> 
> This series was rediffed against today's master (458ef2a25e0c) which
> contains the first series. The changes were tested on x86 with real
> hardware, and was build-tested on ARM.

I'll be happy to queue these up for 5.8 when ready. Would be handy
if you could resend a v2 patchset with the extra patches, makes my
life so much easier...

-- 
Jens Axboe

