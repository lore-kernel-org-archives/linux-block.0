Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19000C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 18:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F36223DD
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 18:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="YBI5KDbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F36223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeKOEab (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:30:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34057 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbeKOEab (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 23:30:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so1777236pfg.1
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 10:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cilLOqpPMwYrIofqEwwMadi2RhC85XkSEiGo4zu33W0=;
        b=YBI5KDbGJmJv5OfI2ISZGFdjMR8KhQssKBumU0dCnrHj98EAX+ffwuVem4UA3nwLah
         pKoP6jv9iFhT1cXWtBw8Xhalf+1/XFxXbNNFuGUQQT3o+J6pA/a4s6Zx/Yuzhd82A2IM
         8ybLYpkTbhRFnDCvmkDiCoIZSTLbxilzOQ2KxbRcDaTB4h26WRrmMoyYjIXuFnZptyvI
         OOq8k7YA+eSwIjdideIoGnjGkugdQhU3y7qT3HPbyZ3ysn44rr1DjHn2HB3D4SGDTr8v
         hEEFqMCWZVsckdd8AYNlYKggENKtz393E8TWsxg9NebXzDbhVuaS8vDUUydoPe2YFbb1
         Xo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cilLOqpPMwYrIofqEwwMadi2RhC85XkSEiGo4zu33W0=;
        b=T9wPNxN0K2qO50kGkP8Q429DYVOAjymsqq3oMwKV6nKYONB4S2ixc69JNUl3jIh38U
         I+Rb+9mTkB8x5vdDYS4Nn8YOqmpZHvvDnRXXWat+Grk59qlQ0E6KxrtnEH2YUiZydWAQ
         opmdXNuBnw3KQ/rfk4u75/shYC5axcF1RHhOYeozTaxx1CEktg/slb9ZGQQ6Vj5+7/MF
         /0ibl+CnjKF+9ntdUIfIuH8+i71H5oxTrHjzlD15oKTNjQr9G7xYYUMM+fV8vvPIRnX+
         mQ9TOdTs7M0Q+nPcNNqo/wMo2T5deJ5VdpFWuvnWqDkz/XL2eubqfv+HgVYMtaJyIfNg
         1UAA==
X-Gm-Message-State: AGRZ1gJROeckca4M23l03NvFIAC0toDRGk0dFoC6sFqeBwxmTgXJjuZb
        bCzQr6dU8w73uP5DJ4im0QuhLw==
X-Google-Smtp-Source: AJdET5cyO9ln0OJO2tVxgluboWTbNsuy3sDhxByTwCj24jhPR4+7RHZ4vsMCb0oR5vcD/uBuQrURkw==
X-Received: by 2002:a63:4342:: with SMTP id q63mr2746794pga.63.1542219972709;
        Wed, 14 Nov 2018 10:26:12 -0800 (PST)
Received: from vader ([2620:10d:c090:180::1:2a61])
        by smtp.gmail.com with ESMTPSA id o86-v6sm30131326pfk.8.2018.11.14.10.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 10:26:12 -0800 (PST)
Date:   Wed, 14 Nov 2018 10:26:10 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     osandov@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] makefile: Add install rule
Message-ID: <20181114182610.GB3253@vader>
References: <20181109151524.50405-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109151524.50405-1-gwendal@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 09, 2018 at 07:15:24AM -0800, Gwendal Grignou wrote:
> Add rule to install to a target directory, /usr/local/blktests by
> default.

This seems reasonale, but I'm curious, what's your use case?

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  Makefile     | 9 +++++++++
>  src/Makefile | 3 +++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 38b8ad1..d7c2b74 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,9 +1,18 @@
> +prefix ?= /usr/local
> +dest = $(DESTDIR)$(prefix)/blktests
> +
>  all:
>  	$(MAKE) -C src all
>  
>  clean:
>  	$(MAKE) -C src clean
>  
> +install:

install should be added to the .PHONY targets.

> +	install -m755 -d $(dest)
> +	install check $(dest)
> +	cp -R tests common $(dest)
> +	$(MAKE) -C src dest=$(dest) install

The src programs need to be installed to $(dest)/src.

>  # SC2119: "Use foo "$@" if function's $1 should mean script's $1". False
>  # positives on helpers like _init_scsi_debug.
>  SHELLCHECK_EXCLUDE := SC2119
> diff --git a/src/Makefile b/src/Makefile
> index 15c1022..f0ddbb5 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -20,6 +20,9 @@ all: $(TARGETS)
>  clean:
>  	rm -f $(TARGETS)
>  
> +install: $(TARGETS)
> +	install $(TARGETS) $(dest)
> +
>  $(C_TARGETS): %: %.c
>  	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^

This ability to install tests could also use a mention in the README.
