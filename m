Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BBEC433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 03:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90DD253A4
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 03:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T5FJg0Sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgFVDDN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgFVDDM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jun 2020 23:03:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D81C061794
        for <linux-block@vger.kernel.org>; Sun, 21 Jun 2020 20:03:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so6955558plo.12
        for <linux-block@vger.kernel.org>; Sun, 21 Jun 2020 20:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LXJvj9vkvkt7k2eIzmJGrptkL0ygQB5cYVWK/klF8Xw=;
        b=T5FJg0Sq0oLGuBmaFNM81sZOq6wmCEe1mmFYC7Vo8rI8M65jCW0DCaZASaB3IOvsNu
         nV9jAEmWdpHP5vcRaeF3k77XnegzOfAzwATj0X6B0n2I8Ab8IOkhd6tPjbWNcVBg5Rxk
         r0SQjNZ1CFkrlxrQ7ss+gezRCxLItzqgjm05SDXyRYCoLZQCmi+dXYIeIRCagP9rXFUN
         BiIleovQCqIX4fxkfWk5dSOB+fVJtBZpzjPDJloAk7vsv79SBK5ZAGEPE5LJ/f2skj9a
         +q+LhcQzB5ISme1Mf0BHmBg2v60q/RUWEyHbYkgqn8+qXMKbZi2ZWLERozu3f2Z+Wd67
         d6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LXJvj9vkvkt7k2eIzmJGrptkL0ygQB5cYVWK/klF8Xw=;
        b=Xl/Z9pnLoQM6WLqgMENZShsgSVhnM2blBrNZSUkPdOEbk+VyAvVPLmejVrrnTzV64T
         qItWYJNDP91Ibh4CysjrKGl1DSo0yNUcoXI78jjBB9809c9Ra5o5XRSvfW+Vw/unPw2P
         ElN9eAwVBV1RU90VZPi2xUnvyN9U97wDrCR5vod5F/y2z00IIHSYEji9yyKYf61EInUK
         GvhlWo3XBxN104GSg0/sYeXsH+/0qu9mucteyNlbEKcfdUKChVMDerCePHIV7eGDbDTh
         Kum7G0PDXegwt78GCavA0ceCGU3zMJkHSO6B4fENRFuEkBcnJAFVw/6tE6nVM4wm/4mb
         0akA==
X-Gm-Message-State: AOAM533XUDBUwqZ7BdDRziBNycEoZRE/IikxS3aei30O7QDhQYoPTZD5
        XwjBv8mXFgMJZFzjGsigG9J29w==
X-Google-Smtp-Source: ABdhPJw7RxoXhvZDFrIxRRcyT+T59CUeoxbDsl/9nI73FoTAXV4zMG4ug4Yzb9Y472aLwi5UzwDgRw==
X-Received: by 2002:a17:902:7c16:: with SMTP id x22mr17618063pll.66.1592794991279;
        Sun, 21 Jun 2020 20:03:11 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 200sm12500762pfb.15.2020.06.21.20.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 20:03:10 -0700 (PDT)
Subject: Re: [PATCH] null_blk: Move the null_blk source files into a
 subdirectory
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20200621204257.16006-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7d33a3a0-bc04-48e0-3e68-c792920823f7@kernel.dk>
Date:   Sun, 21 Jun 2020 21:03:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200621204257.16006-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/20 2:42 PM, Bart Van Assche wrote:
> Since the number of source files of the null_blk driver keeps growing,
> move these source files into a new subdirectory.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/Kconfig                         | 8 +-------
>  drivers/block/Makefile                        | 7 +------
>  drivers/block/null_blk/Kconfig                | 9 +++++++++
>  drivers/block/null_blk/Makefile               | 8 ++++++++
>  drivers/block/{ => null_blk}/null_blk.h       | 0
>  drivers/block/{ => null_blk}/null_blk_main.c  | 0
>  drivers/block/{ => null_blk}/null_blk_trace.c | 0
>  drivers/block/{ => null_blk}/null_blk_trace.h | 0
>  drivers/block/{ => null_blk}/null_blk_zoned.c | 0
>  9 files changed, 19 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/block/null_blk/Kconfig
>  create mode 100644 drivers/block/null_blk/Makefile
>  rename drivers/block/{ => null_blk}/null_blk.h (100%)
>  rename drivers/block/{ => null_blk}/null_blk_main.c (100%)
>  rename drivers/block/{ => null_blk}/null_blk_trace.c (100%)
>  rename drivers/block/{ => null_blk}/null_blk_trace.h (100%)
>  rename drivers/block/{ => null_blk}/null_blk_zoned.c (100%)

I'm all for this since, but why not name them null_blk/main.c etc?  A
bit annoying/redundant to have them be drivers/block/null_blk/null_main.c
and so forth.

Probably have null_blk.h be the exception.

-- 
Jens Axboe

