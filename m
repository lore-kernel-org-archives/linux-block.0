Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A9BC7618B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 07:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B781A2251A
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 07:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="c/ZNarot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbfGWHrF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:47:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34374 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfGWHrE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 03:47:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so42064115wrm.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k7Xz7HKINwi2ffVMf/EFtJWFSDc7hqESTclfwKAt7K4=;
        b=c/ZNarot1m0Bl1tmWrYyhQmPxIX3DYs2q2Gj5GPhiIoalP+pZaR0Bxcjs+qbtQggL+
         HpYpvcffxSSoQ6e3vzPC+Jr1+Y7fqOWhByZoh68dmXrg2pmNrtn6QP4yekhQWLe32Smv
         Lgcpdg3yij/uHiT6xRLXikibHtWQkH9y/yNWC8LWj1R9GmlW1Ow+dA4jDjhQER8wtODg
         P3HNoJOjAMlxmxOQEDK0kNEfxcwZj8zCoRBY1pdZmhobsS52JB4o5lYmEFTwKw9bMbYD
         P1FPqibH2KmI7rd/iym26Pv/u/mJxGS3RR6+vfownrLRWIsxXw7FD+oC8MyDj4OyJB3d
         //sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k7Xz7HKINwi2ffVMf/EFtJWFSDc7hqESTclfwKAt7K4=;
        b=cId5LuXyvWsNLdrAy8dEV2JjJ4YqJHpTh5t19ITQZwsd3CIeC8RsXghfbj02ctF6tT
         Sw8d/SHJbKlhSnPlYes0KPxmNp0K1GlZCp3xgRMcsXuR+OezmJivJrGIEuGS+B5fVXcC
         NOqafKribRYnsfEzxP+bHBsU8iYszIvVY28bkglb17lOcGjIfk3fzpxC04T3OVbsQuES
         oMtAb+zLOI/TILpEJxjZn/PLJ8nJ/60Ms5INuSj1qJHSBAxDnaESPGTBi+1bx0UfD8ZW
         +c09X0oZXMq5piejgWgNBVd2wJnsSNDFXjrHqccdwbgedGotVMtsHuT+zrrrTFJfnqkE
         dMLA==
X-Gm-Message-State: APjAAAWl1I4HO+WflFf7ATim5V6jh9gb72egSRS07h5rE920Oe94WnsS
        UkCnp7uN8TAfYXH2s0AabevuY0pX3fnoI7q8
X-Google-Smtp-Source: APXvYqz/ejC83D8aGx+4kC8dKQ0Qld0zLqocNAoCUYcBJW7FNfVPBFPaYnNJes3G5pDAlnW0XtkZBA==
X-Received: by 2002:adf:c803:: with SMTP id d3mr4552216wrh.130.1563868022896;
        Tue, 23 Jul 2019 00:47:02 -0700 (PDT)
Received: from localhost (static.20.139.203.116.clients.your-server.de. [116.203.139.20])
        by smtp.gmail.com with ESMTPSA id c1sm89787659wrh.1.2019.07.23.00.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 00:47:02 -0700 (PDT)
Date:   Tue, 23 Jul 2019 09:47:01 +0200
From:   Roland Kammerer <roland.kammerer@linbit.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Kees Cook <keescook@chromium.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] drbd: dynamically allocate shash descriptor
Message-ID: <20190723074701.fp2qjjm5dwj4i2x7@rck.sh>
References: <20190722122647.351002-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722122647.351002-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
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

Reviewed-by: Roland Kammerer <roland.kammerer@linbit.com>

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
