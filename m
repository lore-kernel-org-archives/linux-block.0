Return-Path: <SRS0=14Po=UQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C82C31E5C
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 14:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BAF20833
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 14:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="e9qEJ+bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfFQOgj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:36:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35679 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQOgi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 10:36:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so9397619wml.0
        for <linux-block@vger.kernel.org>; Mon, 17 Jun 2019 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KCXEErRlP/VgSfc8Kg4eH/erTW//QnAw2fRJEs6JRxU=;
        b=e9qEJ+bcK9JflnlfwwGwrN4h4wHcIqG+ys8sJHZ7/CSdytLj3wWhYinN5+W0HhP4TZ
         l5n4Z1qd7JhVOZqB/eJ+x5RkAqQQ0KSAXtw6vY0eCMZqH0FyFoi3Yw1C42dLVrLLkydr
         1rViz3QCYvqRI7L8LMHWDshGnRd7b1dwKaSp6K75D1R48+RZ2IZiuXwGthudvCb2afEp
         w0mKh8+KbMex/bKVRdgiaz0LIscPlpV6jEAR5Opu+VBAYDpr7I7VvZ5NwtIAeM6DEV9V
         qm3nMMZVMaNwybXKIfMAaVurF0+oYttYoOOdTj8xa/8s4vAt6IpLNDNBklMzpgvkVPMA
         guQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KCXEErRlP/VgSfc8Kg4eH/erTW//QnAw2fRJEs6JRxU=;
        b=rudNMOlUdPe8CnIbsuGc+zHxT0nvBKgx4YLEx5FiW+RmbbTv5Mtm4TSbNr2oCN4A4/
         7kSdprYEOAg0b2lmZw5xbVe8fLz55KSP/gEEfKprlliJHMeUOhUcL+0sFmTKddpsLZwg
         7hV0usQmPxIdfsOeAPC3RLoBnkomYF8Qg3RLbGNYdPjDibx1o9WmWVh5s63nKrH0rxiv
         +ZTSMoiHN/RCEEEFhtYmgjrOtChGJOZmZWs3BsH0aGNapnmY+DP6bUuC7Xf4QXWAHLxp
         uDql+GjM3eXO9zmdoOGzRm18wZGF4LObKHs8awH6YPH7sw0eb5YRlg5mJXrRZjVCYqb6
         mVhA==
X-Gm-Message-State: APjAAAUWkRg/+vb6ezFrLFhX9WTQvms595sBMv+uCcpmOvEo67FWrIAu
        /l0FuwvkssuG4p4nvWcuu0/IGw==
X-Google-Smtp-Source: APXvYqyv836+V0UtaEzVzckkI+45TgYV548FwF4a1QDm57MM8ttFoqIGy22tTUSoJchU4jXEjCxs/w==
X-Received: by 2002:a1c:c14b:: with SMTP id r72mr19295976wmf.166.1560782196872;
        Mon, 17 Jun 2019 07:36:36 -0700 (PDT)
Received: from localhost (static.20.139.203.116.clients.your-server.de. [116.203.139.20])
        by smtp.gmail.com with ESMTPSA id l1sm12697489wmg.13.2019.06.17.07.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 07:36:36 -0700 (PDT)
Date:   Mon, 17 Jun 2019 16:36:35 +0200
From:   Roland Kammerer <roland.kammerer@linbit.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drbd: dynamically allocate shash descriptor
Message-ID: <20190617143635.xkbmoug5swqoi5em@rck.sh>
References: <20190617132440.2721536-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617132440.2721536-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 17, 2019 at 03:24:13PM +0200, Arnd Bergmann wrote:
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
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/drbd/drbd_receiver.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 90ebfcae0ce6..10fb26e862d7 100644
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
> +			crypto_shash_descsize(connection->cram_hmac_tfm),
> +		       GFP_KERNEL);
> +	if (!desc) {
> +		rv = -1;
> +		goto fail;
> +	}
>  	desc->tfm = connection->cram_hmac_tfm;
>  
>  	rv = crypto_shash_setkey(connection->cram_hmac_tfm, (u8 *)secret, key_len);
> @@ -5572,6 +5579,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
>  	kfree(response);
>  	kfree(right_response);
>  	shash_desc_zero(desc);
> +	kfree(desc);
>  
>  	return rv;
>  }

Hi Arnd,

are you sure your cleanup is okay?

>  	shash_desc_zero(desc);
> +	kfree(desc);

You shash_desc_zero() a potential NULL pointer. memzero_expicit() in the
function then dereferences it:

memzero_explicit(desc,
	sizeof(*desc) + crypto_shash_descsize(desc->tfm));

Maybe some if (desc) guard?

Best, rck
