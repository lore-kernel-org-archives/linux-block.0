Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C2BC433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Nov 2022 03:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiKKDQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 22:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiKKDQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 22:16:18 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820BA265
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 19:16:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b29so3772222pfp.13
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 19:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHYtmfAkk1aJiFrWOQcK74WseWK+F2wWdmGdTPL8r5I=;
        b=PLhiLl2rFexSXAqPrdy+JcBIIVG9if/iJukhcki/6b31uXZj13fFwWK2CUJm1Baj2s
         /30vEA6cCpgthMu5aerjhcoSyL3VNIf7YC6No9K3mAw9NTtQZXBxIAdl8YFcrSUNk2ax
         PKLw8/PceYAM/t+0hRJJeWRUDRoy+1/uckzZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHYtmfAkk1aJiFrWOQcK74WseWK+F2wWdmGdTPL8r5I=;
        b=PeSYhI7LseKM1y+8x0Fou7rjI99t6KkjJp80Vus7NCn4SJTCWj+ttva+NLDdtEoXNY
         YVzyEjPH9OAVKdKJCwxxBAS/swwOtufIqjmEO9ccLD6o7NpUpjTCITsQWwYfkKeGy5hR
         0qKErVlfppfRotRMK6h/C7OMdHpIXposnjsLO909rihiNrejtlIzqf4Eokl0CcW5ysiN
         OlMnKceOjYFY9M9HIKMnyY8Roa6a2ysLpmIbJQPyPpQq3rXD8/vPF/cRT0/NDgWnviSm
         jD9SdH+ZbpfHntdStqdUtENuSwYjk+AQ3la3rhlW1QSCebkXMSTI4p5ZbXt7TUNH5DQo
         Yzhg==
X-Gm-Message-State: ANoB5plaMX+M8aUkwfMkbJNUeJ/DkAEmdDaFTY6B2WyaRq5uis+yRsHv
        DFZjD6+TbwdVXAcuAL4uXu7ZjQ==
X-Google-Smtp-Source: AA0mqf5oumcRWXs+UNB8JbUMhp0s1tVKT0S+NPKFT46G7SRi1Mu55t1aEsRugB1x0ZpTt2hj0XpNyg==
X-Received: by 2002:aa7:9218:0:b0:562:ce80:1417 with SMTP id 24-20020aa79218000000b00562ce801417mr692070pfo.19.1668136577012;
        Thu, 10 Nov 2022 19:16:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z28-20020aa7959c000000b0056be4dbd4besm402806pfj.111.2022.11.10.19.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 19:16:16 -0800 (PST)
Date:   Thu, 10 Nov 2022 19:16:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Alexey Romanov <avromanov@sberdevices.ru>,
        linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: zram_recompress(): OVERRUN
Message-ID: <202211101915.6A6C5758AA@keescook>
References: <202211100847.388C61B3@keescook>
 <Y22ZNtdH9s+cuL9l@google.com>
 <Y22afneyl4pZ32ig@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y22afneyl4pZ32ig@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 11, 2022 at 09:42:38AM +0900, Sergey Senozhatsky wrote:
> On (22/11/11 09:37), Sergey Senozhatsky wrote:
> > On (22/11/10 08:47), coverity-bot wrote:
> > [..]
> > > 1704     	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
> > > 1705     	/*
> > > 1706     	 * Iterate the secondary comp algorithms list (in order of priority)
> > > 1707     	 * and try to recompress the page.
> > > 1708     	 */
> > > 1709     	for (; prio < prio_max; prio++) {
> > > vvv     CID 1527270:    (OVERRUN)
> > > vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).
> > > 1710     		if (!zram->comps[prio])
> > > 1711     			continue;
> > > 1712
> > > 1713     		/*
> > > 1714     		 * Skip if the object is already re-compressed with a higher
> > > 1715     		 * priority algorithm (or same algorithm).
> > 
> > prio_max is always limited and max value it can have is 4 (ZRAM_MAX_COMPS).
> > Depending on use case we can limit prio_max even to lower values.
> > 
> > So we have
> > 
> > 	for (; prio < 4; prio++) {
> > 		foo = comps[prio];
> > 	}
> > 
> > I don't see how prio can be 4 inside of this loop.
> 
> Kees, if we do something like this will it make coverity happy?
> 
> ---
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 9d33801e8ba8..e67a124f2e88 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1706,6 +1706,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
>  	 * Iterate the secondary comp algorithms list (in order of priority)
>  	 * and try to recompress the page.
>  	 */
> +	prio_max = min(prio_max, ZRAM_MAX_COMPS);
>  	for (; prio < prio_max; prio++) {
>  		if (!zram->comps[prio])
>  			continue;

It would, but given this is a clear false positive, don't feel the need
to add this just for Coverity's sake. It is a nice bit of added
robustness, but I leave that decision up to you! :)

-- 
Kees Cook
