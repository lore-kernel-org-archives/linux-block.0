Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380D8C2BA2B
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 14:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087E7206C1
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 14:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XsJ8/9gG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDJOhw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:37:52 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55384 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgDJOhv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 10:37:51 -0400
Received: by mail-pj1-f65.google.com with SMTP id a32so842853pje.5
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2020 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QpFUHeYARcWxcv/XtWLks1oXuKFfj/QFlKA/6W8HbRY=;
        b=XsJ8/9gGZxW/s6QakxkZuFEin2epaQlHyDme9yLny+rIH9eDvXJQ/UtRhWipv/pn6b
         JWYGmOKb/HlaccGNJtZqXWAQ3ZOp9KE6tZL76Z+bYvm61oSYzBWk+Ihz1Z0JiOejG8Jr
         XX2Q4HsXgHDM2x+9Mtjn8h1hJIlvsweZaKXle1hk4EEgLDPA68DHf37GIHwNBFBMxDF0
         LuxArw+eCPB40asq5Ee/WCJ3qsvMTQzs448BzvroincCy1tQjaj4bccBmtQThPBRKG2h
         ib8OxvGMVCukCUxyKSWHXx8DTMZ+sYTgYlxrlk4wbO0QshhNRF1Id+rFxyXSrI2zuvqt
         Asog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QpFUHeYARcWxcv/XtWLks1oXuKFfj/QFlKA/6W8HbRY=;
        b=WJtL8PNJI57wCo98s6lOzCvY9c1Qtgg+3DR38i3k6dJd1BO8CZ/I3x+vwZjNlXVFzb
         vBCMxytoeHcAImiu3oXyIqCK+fL57C9O4IiG0F3U4kUDie1w+wPiPCMX8mTQCB/LlYVb
         iecFgDMwnn3KWblMxYv+xhjKcD49KPFQHWcngMulYhJvb2Qnuy/fD+LiRk3BI4ECZyTj
         +eR0M1DBJuwzXr91lepNg1CtT1d59JtssZT3ST/jwttLwSpgAZXziK7rwTxWh0B3/bFG
         2DgHWP4CuXbI4k/EXZHf+85vJE1gFfbXx1HqDHcwAU5FEF6cuiCcERuw7itmIjU0qchd
         0IMg==
X-Gm-Message-State: AGi0PuZqeDNngZI+Cgv663P2ysq/y8TjFvUtQUPWn0Y95mHD9SJO+xEX
        x0HiPnlikMsqBCC4MH6H1HvyleACiyH2zQ==
X-Google-Smtp-Source: APiQypL1Dk+Tuypi0t5oDutvKdJdO0EMMxY3PNdojkVmeVpTqrXXQOWp16Aw9G20nlO4m0/x041cBQ==
X-Received: by 2002:a17:90b:24c:: with SMTP id fz12mr5630317pjb.85.1586529470684;
        Fri, 10 Apr 2020 07:37:50 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:942b:36b0:ed39:fc6? ([2605:e000:100e:8c61:942b:36b0:ed39:fc6])
        by smtp.gmail.com with ESMTPSA id f20sm1864369pfa.173.2020.04.10.07.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 07:37:50 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.7-rc1
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0d580c9a-be04-0b48-0594-17a0339df1b5@kernel.dk>
Message-ID: <5b4a4f64-3a39-e1a6-6141-60436bb9249b@kernel.dk>
Date:   Fri, 10 Apr 2020 07:37:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0d580c9a-be04-0b48-0594-17a0339df1b5@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/9/20 6:07 PM, Jens Axboe wrote:
> Hi Linus,
> 
> Here's a set of fixes that should go into this merge window. This pull
> request contains:
> 
> - NVMe pull request from Christoph with various fixes
> 
> - Better discard support for loop (Evan)
> 
> - Only call ->commit_rqs() if we have queued IO (Keith)
> 
> - blkcg offlining fixes (Tejun)
> 
> Please pull! 
> 
> 
>   git://git.kernel.dk/linux-block.git tags/block-5.7-2020-04-09

Followup pull request, as the partition check from Christoph had a
one-off that caused a boot failure on S390 (and perhaps others, but
didn't see it in my testing, and that's the only known report).

This one sits on top of the previous, figured that was easier than
redoing the other one fully.

Please pull after pulling tags/block-5.7-2020-04-09!


  git://git.kernel.dk/linux-block.git tags/block-5.7-2020-04-10


----------------------------------------------------------------
Christoph Hellwig (1):
      block: fix busy device checking in blk_drop_partitions again

 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


-- 
Jens Axboe

