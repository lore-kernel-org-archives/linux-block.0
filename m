Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6286DC76194
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 16:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3833421738
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 16:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lMVKoC32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfGVQwd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:52:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44360 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfGVQwc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 12:52:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so17939144pgl.11
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D5i5eeVRTyq7Qm2OPmoZkgOgQ/VLsd39M3tEbxvABCE=;
        b=lMVKoC32q6jdc5s52CXFaKProF9HEK95pIIg8BJ02KRdMo2T+G1UQFwnI3hhGF8+qU
         sA+I2b5X4bmmD3l4DMPwDW82vI93F3KlS+ABw8rfpPxwGuJjlU4ikbVcjw+QJS8Ok0+k
         NfKpy3LGpTZr6M9s+RV94qzCTTn8uIg1TOEHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D5i5eeVRTyq7Qm2OPmoZkgOgQ/VLsd39M3tEbxvABCE=;
        b=FUWtyDmDVas/HvnZ3SvnWH9y+Iw39dGLTsTvN5I5VqqW72p/FFay7DjbAiqSjztvL9
         PDMKrfUNgJgIFnxDRA+avDAz2cIFHHMMkhgdQE31guJouHzxNMZOiWNtMJYCU6uiF/s2
         OC7ZV4U7qQFSyFeu1P+yAYZjHxgfZOFW2gCEtozb8w/JYlxIpp28OZY5ZA6RkXJ5oRex
         /z0wgXdZ+rUtzdwPY0ZMRIGTclJZ3Om7Lj73h6q65BtdRtF587O5sOEEiwFKColh4ax3
         uhQM0Z6670v1xAnKk04XMaLgVDLH216JeCYxZRnXoWF6M01dqFnzbZQP3qUWTA3la5nD
         Hl5A==
X-Gm-Message-State: APjAAAXP7urwzMFEYw1qddZbJn2JhWtcwsxlVXjQs6CPp7wIIliAQlaP
        x5GARbrOUTovyijCHkFx0cGVNg==
X-Google-Smtp-Source: APXvYqx5EPVBdAZB9hQMVYd5b0pm0ScpmGtAOsQZBAbG8Ghj6g8EOLpHTo6yIfQxYVdOh6K7G5nb9g==
X-Received: by 2002:a63:7b4d:: with SMTP id k13mr70901703pgn.182.1563814351931;
        Mon, 22 Jul 2019 09:52:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8sm36678029pgh.45.2019.07.22.09.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 09:52:31 -0700 (PDT)
Date:   Mon, 22 Jul 2019 09:52:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] drbd: dynamically allocate shash descriptor
Message-ID: <201907220952.EA05EEE9FC@keescook>
References: <20190722122647.351002-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722122647.351002-1-arnd@arndb.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 22, 2019 at 02:26:34PM +0200, Arnd Bergmann wrote:
> Building with clang and KASAN, we get a warning about an overly large
> stack frame on 32-bit architectures:
> 
> drivers/block/drbd/drbd_receiver.c:921:31: error: stack frame size of 1280 bytes in function 'conn_connect'
>       [-Werror,-Wframe-larger-than=]
> 
> We already allocate other data dynamically in this function, so
> just do the same for the shash descriptor, which makes up most of
> this memory.
> 
> Link: https://lore.kernel.org/lkml/20190617132440.2721536-1-arnd@arndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> v2:
> - don't try to zero a NULL descriptor pointer,
>   based on review from Roland Kammerer.
> ---
>  drivers/block/drbd/drbd_receiver.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 90ebfcae0ce6..2b3103c30857 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -5417,7 +5417,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
>  	unsigned int key_len;
>  	char secret[SHARED_SECRET_MAX]; /* 64 byte */
>  	unsigned int resp_size;
> -	SHASH_DESC_ON_STACK(desc, connection->cram_hmac_tfm);
> +	struct shash_desc *desc;
>  	struct packet_info pi;
>  	struct net_conf *nc;
>  	int err, rv;
> @@ -5430,6 +5430,13 @@ static int drbd_do_auth(struct drbd_connection *connection)
>  	memcpy(secret, nc->shared_secret, key_len);
>  	rcu_read_unlock();
>  
> +	desc = kmalloc(sizeof(struct shash_desc) +
> +		       crypto_shash_descsize(connection->cram_hmac_tfm),
> +		       GFP_KERNEL);
> +	if (!desc) {
> +		rv = -1;
> +		goto fail;
> +	}
>  	desc->tfm = connection->cram_hmac_tfm;
>  
>  	rv = crypto_shash_setkey(connection->cram_hmac_tfm, (u8 *)secret, key_len);
> @@ -5571,7 +5578,10 @@ static int drbd_do_auth(struct drbd_connection *connection)
>  	kfree(peers_ch);
>  	kfree(response);
>  	kfree(right_response);
> -	shash_desc_zero(desc);
> +	if (desc) {
> +		shash_desc_zero(desc);
> +		kfree(desc);
> +	}
>  
>  	return rv;
>  }
> -- 
> 2.20.0
> 

-- 
Kees Cook
