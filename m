Return-Path: <SRS0=4Sb2=2K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604ECC43603
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 18:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADC520866
	for <linux-block@archiver.kernel.org>; Fri, 20 Dec 2019 18:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0S4Y/Juj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLTSvF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:51:05 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:46592 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTSvF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Dec 2019 13:51:05 -0500
Received: by mail-pl1-f172.google.com with SMTP id y8so4459668pll.13
        for <linux-block@vger.kernel.org>; Fri, 20 Dec 2019 10:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P3LgoDajJi8NhpzZhnIrCelcw8i2dBD2mH+AdVzJYAk=;
        b=0S4Y/JujN1TB5nDtEqa3WxCvPo3no00WVjStIv84nvV7tqshNMpsbgSTrRYgqq64D5
         hYsGfnZX4IvS9c4JowUA+0LlpWGR82qDBUh1+LLmZAhFZWEPbopU/g9Bk/ugEYllKism
         cQ3kdQQdUF6ShQBGe6aFpHO6Bo28LcHzv3A8pc8BYYpSV3P0J44vpKwQzD7/R6LEss/C
         iyPCoV9rZpCzgKsv4uP/I8/aB5HEcC+eRHbfm8aMIZnfa+7ye1eBFupVMwcyo6uA4aEB
         t0YGcI6Q++5Yw02393Kdmf5ENXWYidlt9P9UBoGvj4OhlV1w3cgO1KpUcMrO/Qtyjv7q
         jQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P3LgoDajJi8NhpzZhnIrCelcw8i2dBD2mH+AdVzJYAk=;
        b=k/Frv4Dw1lJNjBZqGDv00lJlfZfOfEiZqlcJ6Bgz/bJuwPLMAfmdktw7EeYkZqutnb
         Idv0MJPPn6R3sg+AWaJtbvuPZ2rKKMJd3jWnJORPZbGZa9iLOH6a/MLiqk4xH/1bvsHC
         jtIymIwy+Rix5zqdi3lA72Zq+e34hww0hStONJiyG5543IHl1DtIYblv3INdsA5iB/gn
         LAgws2nWinluNNfR2KJPcU1+ST4r6RFICAGsYYkt4WKtwevS2q2ZVOXKDUYAGWk1xdHc
         lYuEK3dmMx09rWWKdr7Vl8flDYAulS4fytNEIKwjxGaddd80lIZBVxz32JCVQA9HwJ86
         mvqQ==
X-Gm-Message-State: APjAAAXdCvFK7PZpI0FV5LqHXR46HXY516PX0fJx7xc4wGEKhcMwLTWQ
        cspFeyuoAPzYrEZKCIdoAdDXb3KoRYw=
X-Google-Smtp-Source: APXvYqx4xhErgEvMkWYRRFJNlfwhjb5mEHCVGD2Q94x0usmyjy9mKTY41PYIhhO0e89hFvoXqAvS0A==
X-Received: by 2002:a17:902:6b0a:: with SMTP id o10mr16238473plk.15.1576867862889;
        Fri, 20 Dec 2019 10:51:02 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::10ef? ([2620:10d:c090:180::9a29])
        by smtp.gmail.com with ESMTPSA id j3sm13235578pfi.8.2019.12.20.10.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:51:02 -0800 (PST)
Subject: Re: [GIT PULL] Block fixes for 5.5-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <b596cdab-4a73-39c6-1d35-4804794cf8f4@kernel.dk>
 <CAHk-=wgd+TGrrzews6PWH0LzftBs+KpsUnPWHd=SUKwuMWKnJQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <667f59d4-48bb-699c-f195-2195d9f7bf1b@kernel.dk>
Date:   Fri, 20 Dec 2019 11:51:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgd+TGrrzews6PWH0LzftBs+KpsUnPWHd=SUKwuMWKnJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/19 11:49 AM, Linus Torvalds wrote:
> On Fri, Dec 20, 2019 at 9:51 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Here's a set of block changes that should go into this release.
> 
> No can do.
> 
>> - Series from Arnd with compat_ioctl fixes
> 
> This doesn't even build:
> 
>   block/compat_ioctl.c: In function ‘compat_blkdev_ioctl’:
>   block/compat_ioctl.c:411:7: error: ‘IOC_PR_REGISTER’ undeclared
> (first use in this function)
>     411 |  case IOC_PR_REGISTER:
>         |       ^~~~~~~~~~~~~~~
> 
> with several other related errors (IOC_PR_RESERVE, IOC_PR_RELEASE,
> IOC_PR_PREEMPT, IOC_PR_PREEMPT_ABORT, IOC_PR_CLEAR)

Ugh, that sucks, sorry about that. Wonder why kernel bot didn't
find that either. I'll drop this part and resend.

-- 
Jens Axboe

