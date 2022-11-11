Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D97C43217
	for <linux-block@archiver.kernel.org>; Fri, 11 Nov 2022 10:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiKKKjj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Nov 2022 05:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKKKji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2022 05:39:38 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E7654F0
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 02:39:37 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 78so4080993pgb.13
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 02:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2JUDV1unVlaXbofWs/pNvlYuHbbOkp9TycnqFbOAXE=;
        b=F+RBn0VN/l/Y5JdSEZ8vZ3ybsM7Js2Nn5c/9xjxvRezBTsc7XxRbmgSuss6c3f3JFU
         AvqELYzGgFD1+2dTP9v9k9qvY+UDPtlwona1Lz6F0bNcNoBSxE9JbuWaT4TxkwvnZ4ep
         CT9eGaywFuc1S9zV1Wec4IFXOLBbaE7iV00k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2JUDV1unVlaXbofWs/pNvlYuHbbOkp9TycnqFbOAXE=;
        b=fE2ni/jYRq856JHLyjuQIT6jWJcfSSL74hvzMB9m9cPXO1c3oedAmBWTZC98kUM6a7
         51he45NBRDFnxJtEC/msD+p3ASnFVckpmSWI/4e4/Iku2PlNdnOrrBoiJaOrArhx3Hc9
         QxjACFGOjzPy1pPbXx1dLv16AyRQS3GwThAouPy2Jk2vEonvg3jHbefFl+RIwpliAHmO
         qBwn5hSUHc+G6bt4b6VJEq+hilcSm7f+vjOX3SxxOJLMq03RUKctouGkT54P5MQmZi9B
         733xM6AcDn9B4XzQba+TeUNIDgBqiGwaZjBftZEi4l9wrf192fjgvj+7Iamc6iZFlt+c
         L5CQ==
X-Gm-Message-State: ANoB5pmFsTOj1wsPTe16rSjC1yR2L1RHmtYNaEIxB/JKH8HrtA+854XK
        fBgjIyKxiZkVPsAvafH/rMelDw==
X-Google-Smtp-Source: AA0mqf7/PaKUrzSWu4IL6ADDSKU5/ZNHIQuZjV3IauWIvRuN5B2UAJJg4qQg3bJ+YQXuRJ3Td6vVJQ==
X-Received: by 2002:a63:c146:0:b0:464:a9a6:5717 with SMTP id p6-20020a63c146000000b00464a9a65717mr1036159pgi.584.1668163176947;
        Fri, 11 Nov 2022 02:39:36 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id s19-20020a634513000000b0046faefad8a1sm1084596pga.79.2022.11.11.02.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 02:39:36 -0800 (PST)
Date:   Fri, 11 Nov 2022 19:39:31 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Romanov <avromanov@sberdevices.ru>,
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
Message-ID: <Y24mY4QFq+3Obnkd@google.com>
References: <202211100847.388C61B3@keescook>
 <Y22WtxzDXM5PfFnb@google.com>
 <202211101904.7A0B0C3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211101904.7A0B0C3@keescook>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/11/10 19:15), Kees Cook wrote:
> On Fri, Nov 11, 2022 at 09:26:31AM +0900, Sergey Senozhatsky wrote:
> > On (22/11/10 08:47), coverity-bot wrote:
> > > *** CID 1527270:    (OVERRUN)
> > > drivers/block/zram/zram_drv.c:1727 in zram_recompress()
> > > 1721     		zstrm = zcomp_stream_get(zram->comps[prio]);
> > > 1722     		src = kmap_atomic(page);
> > > 1723     		ret = zcomp_compress(zstrm, src, &comp_len_new);
> > > 1724     		kunmap_atomic(src);
> > > 1725
> > > 1726     		if (ret) {
> > > vvv     CID 1527270:    (OVERRUN)
> > > vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).
> > 
> > Hmm... I don't really see how prio can evaluate to 4.
> 
> Yeah, I agree. This looks like a false positive. I'm not sure why
> Coverity triggered for it. Looking at the extended report, it seems to
> not have any idea that prio_max is correctly bounded.
> 
> Sorry for the noise!

No worries!
