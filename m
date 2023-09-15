Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91ECEDE989
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 03:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjIODVL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Sep 2023 23:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjIODVL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Sep 2023 23:21:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DFE270C
        for <linux-block@vger.kernel.org>; Thu, 14 Sep 2023 20:21:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fbb10dec7so1546138b3a.3
        for <linux-block@vger.kernel.org>; Thu, 14 Sep 2023 20:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694748067; x=1695352867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNCca9HAWNyt4gE3OVRVGxMtbFHTAjcpvCI+K2BMyeI=;
        b=YKwoe7hgo+y3wpmuoJ+EXfuBQcnXtrQZvz32it2fv3IOXLkfa4wN/tNADcU/+CCxg6
         tKwRpiAyYEhnuA+cWxyn1FF0ubhILvv/qQUTwNbk6F1E5wqZoHDQf2iYbYzhanwVuOp7
         GLfLINbXHQMPcugNoOvRFyVK89UvWsg/bWtEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694748067; x=1695352867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNCca9HAWNyt4gE3OVRVGxMtbFHTAjcpvCI+K2BMyeI=;
        b=dMZ5HbhridMUKac9kB6naPbyTdc0tA+I6tUdXAGNUiUGgy2oQkNsfFw9MAUw6iJNut
         O29sUvv+ZBSWLC6v2JpR9Nx/jaODSdFroe0GmoMWwJ0nw0mppADuhzemkgcaJubnmWXZ
         7S+kePsirzOCAI7sC9OjsELsTwiPQKyUGTrYqLvSAOvhhAr9KWPXoprrW4VRSA/L5ioO
         QbHTQuj0EacxlN10K/gsoZnFE6fP9oLP7AMUxPPOXR7cc8/M8h8ZXUKkHz3WiUmPj9F4
         GmQZ8fdQlBExhvS92LA4EWFxf5MM5tfPHqkCir1JV44yxIWJIq82+3bLHeahLJ2ETXht
         oK+A==
X-Gm-Message-State: AOJu0Yy3rxvpRSbvwx5fp571KN4tEIf6QfS5Zpf3cNqiidDKyj31vURo
        nLIp4YFn1AkZ4OWRzbCP2O52nA==
X-Google-Smtp-Source: AGHT+IGLlrv1Bl6tT5S/FeoOxy9wYOBPYcVHJ81JTaECm9y21+rjB8sm1Ztcd+jc0+kI49Q66NcUng==
X-Received: by 2002:a05:6a20:5611:b0:13d:5b70:17da with SMTP id ir17-20020a056a20561100b0013d5b7017damr622812pzc.26.1694748066782;
        Thu, 14 Sep 2023 20:21:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090332c600b001a183ade911sm2321702plr.56.2023.09.14.20.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:21:06 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:21:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com>
Subject: Re: [PATCH] aoe: refactor deprecated strncpy
Message-ID: <202309142019.23A7D80A@keescook>
References: <20230911-strncpy-drivers-block-aoe-aoenet-c-v1-1-9643d6137ff9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-strncpy-drivers-block-aoe-aoenet-c-v1-1-9643d6137ff9@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 11, 2023 at 09:09:07PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `aoe_iflist` is expected to be NUL-terminated which is evident by its
> use with string apis later on like `strspn`:
> | 	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);
> 
> It also seems `aoe_iflist` does not need to be NUL-padded which means
> `strscpy` [2] is a suitable replacement due to the fact that it
> guarantees NUL-termination on the destination buffer while not
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Xu Panda <xu.panda@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Agreed, truncation is the current behavior, and padding isn't needed.
(Or more precisely, it's already zeroed and this function is called
once.)

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> Note: This exact same patch exists [3] but seemed to die so I'm
> resending. If it was actually picked-up somewhere then we can ignore
> this patch.
> 
> [3]: https://lore.kernel.org/all/202212051930256039214@zte.com.cn/

Ah, weird. Well, I think this current one has a more complete commit
log, so let's use this one.

-Kees

> ---
>  drivers/block/aoe/aoenet.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
> index 63773a90581d..c51ea95bc2ce 100644
> --- a/drivers/block/aoe/aoenet.c
> +++ b/drivers/block/aoe/aoenet.c
> @@ -39,8 +39,7 @@ static struct ktstate kts;
>  #ifndef MODULE
>  static int __init aoe_iflist_setup(char *str)
>  {
> -	strncpy(aoe_iflist, str, IFLISTSZ);
> -	aoe_iflist[IFLISTSZ - 1] = '\0';
> +	strscpy(aoe_iflist, str, IFLISTSZ);
>  	return 1;
>  }
>  
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230911-strncpy-drivers-block-aoe-aoenet-c-024debad6105
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
