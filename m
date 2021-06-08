Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8609DC47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 17:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BBF61380
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 17:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhFHRgZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhFHRgY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 13:36:24 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31062C061787
        for <linux-block@vger.kernel.org>; Tue,  8 Jun 2021 10:34:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t9so17088530pgn.4
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YLvKoBEvfY2Ptqya3hzaWF4xLVwI7EHKO0HHIAZbjlk=;
        b=i0MmDl8Ps0IZQmWQ2ViKg1qX561L8Orz5iYseHhCKEYr93sUci8K/7wS9nivt46/z8
         myDrRIqzCtf6XZHgB/yp7wRZxT3r6mBuocIx00CTkorpFU3db3YRdvOAXbfrnieGxlgx
         LCLQNEC2KqG1w+FfuXKHUpQh2dflywFCwrjhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YLvKoBEvfY2Ptqya3hzaWF4xLVwI7EHKO0HHIAZbjlk=;
        b=brN4XFyBkZs3k69PnW8Lr2dnwAE/8QZj2DPTpIcf2I9teMoWXKJxZcdzg1fHYvOwYS
         vb4f0C3z1mms2hBCflog2M9bZZQ92ztyWmps2Wph/4KfT62oBn43T4VFdHovnqSuTPJd
         sRPAZVx/DNMQkG0wXsh5UxvPjFQtrDUamGjG8KRCQJlTiNcz8fBBBTzll0n+nmSeAZMt
         iOF6FF6gWzvXdO/SpFGxPR9un3HB+zmfRQ6G+ekPhRs88GoD7WiTz4cFKPseHdA9Acp4
         BLig5D3h6HwQQoLsyudsNn3EgIA522/La4iGc3NFDOwdBYKMDfBGXq/lSiiZ67XNn+dn
         8nwQ==
X-Gm-Message-State: AOAM533mnrQtGes1OdTvIHWmG20+y+LGisan6Wcq2ba+zK5Elt40vjaT
        o2tDQLxRQrBFxHXjDusZ9pRsgA==
X-Google-Smtp-Source: ABdhPJw9cte543iNlOqM4Zf8WDgZK8UQ3GrQhbOt80HpmTn122EUoVoTmcwVaheYzTeFl8F9id315w==
X-Received: by 2002:aa7:8114:0:b029:2e9:ae2b:7ff with SMTP id b20-20020aa781140000b02902e9ae2b07ffmr1055597pfi.48.1623173670797;
        Tue, 08 Jun 2021 10:34:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u19sm6420346pfi.127.2021.06.08.10.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:34:29 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:34:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, gmpy.liaowx@gmail.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark pstore-blk as broken
Message-ID: <202106081033.F59D7A4@keescook>
References: <20210608161327.1537919-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608161327.1537919-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 08, 2021 at 06:13:27PM +0200, Christoph Hellwig wrote:
> pstore-blk just pokes directly into the pagecache for the block
> device without going through the file operations for that by faking
> up it's own file operations that do not match the block device ones.
> 
> As this breaks the control of the block layer of it's page cache,
> and even now just works by accident only the best thing is to just
> disable this driver.
> 
> Fixes: 17639f67c1d6 ("pstore/blk: Introduce backend for block devices")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/pstore/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 8adabde685f1..328da35da390 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -173,6 +173,7 @@ config PSTORE_BLK
>  	tristate "Log panic/oops to a block device"
>  	depends on PSTORE
>  	depends on BLOCK
> +	depends on BROKEN
>  	select PSTORE_ZONE
>  	default n
>  	help
> -- 
> 2.30.2
> 

NAK, please answer my concerns about your patches instead:
https://lore.kernel.org/lkml/202012011149.5650B9796@keescook/

-- 
Kees Cook
