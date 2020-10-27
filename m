Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C635C4363A
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 01:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB0E20829
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 01:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH0VX8/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503547AbgJ0BWJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 21:22:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34277 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408536AbgJ0BWJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 21:22:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id o129so1656302pfb.1;
        Mon, 26 Oct 2020 18:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rI8te7v5ilh6pzRn0d2OmLYfZc63jY1KzGefybMeBy4=;
        b=ZH0VX8/9+sGfUb4G0/V2yn4UqoCEjIThPJk1zgAQE3FTpuBgJoWrSz46fWBUQdRlcj
         hyKFV/8XcnhoU3yFl6//DHqBBLcIMgQeoA6JUCwi/TR476A90QuQzLUsZKLlzbE8BiXn
         o+W3jM4O7AkahBLq4WOmja4LghnH4QpchM9GktDkbmIDQsYnzizgDu7IGeaxi9tCLCXi
         Cu0/YrXFGBfi92SkAOXB8CCCKvoImvSa42nN7gxzA8Uepfb6NM+DSjf8HUbqjsuLh9LU
         FtiAIs/W842hY825JWndVu7fr/MVvY/2WMHADkOSBXHLsrxC7yEPCQ+4tQ26M9irgkak
         +2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rI8te7v5ilh6pzRn0d2OmLYfZc63jY1KzGefybMeBy4=;
        b=d++bQU5k8oooyQc5By8JlQENyVviMzVRBIpq0/kr3hBYr6faycdGNLdMygx/sdgBqN
         1lpqRV9/0EM69pk0Z90G8ocfxjoy9Rm9USzXHRM9B2NkkxMrw62KIQd5j6okO+PyMt1L
         /VAr6W/ERmayyLTY5MiaTQZ3tecRvJJXEqSCBUiKI9bmCOJ6eK8dyKNe36kCRU3lOzyA
         3mICT5vMERc7iOPeMlgDMbo+hzNI08XZFMmD0e+7MSPPW1qxX5WPZev2ZmDUMlgt1TnA
         Xs/QAn9HvPlUVduOgJfmnjY16n+umJOhH7AOC5oyHxJ1Rj9Kpqj5PCUcLL9ixpfTi8zT
         kFLQ==
X-Gm-Message-State: AOAM53014j7Rpu8LrmnYOp3ogtRxYisuKOU/mdowsU5KoepSC5FEsprP
        +oOhOOpk7OAg6MgC776Ne/+k8RU8ijc=
X-Google-Smtp-Source: ABdhPJyDoGNgp7gqxwSKzvvLhi9UVRs6VaLzoTzGBU4T6Rgncmr844y6MuptgtwNGp0OmdRlnVWeBg==
X-Received: by 2002:a62:8744:0:b029:162:8c76:a8a1 with SMTP id i65-20020a6287440000b02901628c76a8a1mr632100pfe.54.1603761727963;
        Mon, 26 Oct 2020 18:22:07 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id b1sm12696338pft.127.2020.10.26.18.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 18:22:07 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:22:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3] zram: break the strict dependency from lzo
Message-ID: <20201027012204.GD2412725@google.com>
References: <20201026085141.1179-1-rsalvaterra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026085141.1179-1-rsalvaterra@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (20/10/26 08:51), Rui Salvaterra wrote:
>  static const char * const backends[] = {
> +#if IS_ENABLED(CONFIG_CRYPTO_LZO)
>  	"lzo",
>  	"lzo-rle",
> +#endif
>  #if IS_ENABLED(CONFIG_CRYPTO_LZ4)
>  	"lz4",
>  #endif
[..]
> +static const char *default_compressor =
> +#if IS_ENABLED(CONFIG_CRYPTO_LZO)
> +	"lzo-rle";
> +#elif IS_ENABLED(CONFIG_CRYPTO_LZ4)
> +	"lz4";
> +#elif IS_ENABLED(CONFIG_CRYPTO_LZ4HC)
> +	"lz4hc";
> +#elif IS_ENABLED(CONFIG_CRYPTO_842)
> +	"842";
> +#elif IS_ENABLED(CONFIG_CRYPTO_ZSTD)
> +	"zstd";
> +#endif

Honestly, I'm not entirely excited. lzo is a fallback compression
algorithm. If you want to use zram with something else thenconfigure
zram to use something else. What do all these #if/#elif buy us?

	-ss
