Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99814C388F7
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 02:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB94208C3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 02:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXPjFqjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgJ1Vsd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgJ1Vs0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 17:48:26 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA72CC0613CF;
        Wed, 28 Oct 2020 14:48:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h6so614755pgk.4;
        Wed, 28 Oct 2020 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+UWJOE6DxOktV3nv6ien/sKPwx9j1tIJmpm9vGaYA7I=;
        b=lXPjFqjwhXw/iFsQFBkHZ5VUqRkmGhvwPvT0vfWZywgfcJPDsdDAFJu4C1/nWgYvvr
         Lk1XxSGsBCBag/lTfyxa0Rb+lTsj0OtFtb+jenJSxU1zPp14RsYBF4JgXkdR0TDB+Al+
         GtulOoehGfzcEdhM8+32GbsxedgDCcMVomSOOY63hVyMoxhuqdhZgGIZtZoh4vS5yBGt
         dZzc3SAaoe/mvXGlBGIHenC7zmjGFJEfNQ04Ah1vqiN/OS97z5BiKGVEGjCbCu8kk9M7
         1ibCfRNKt34YkPRuQSbWm+/sbfSl6lFnRNN1F4MjoXZhr8NLk17Pzdivn2tvcy2rNryt
         2GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+UWJOE6DxOktV3nv6ien/sKPwx9j1tIJmpm9vGaYA7I=;
        b=LiyYXW7S6es2b278rODh9jPu1BNrwVdJIYN22Xyr32p2ic7IbfLxkqchTQdNLYyUO5
         JQZNQ4tJGLdnazs7bKZpaJtn1HMn4fE1ban3yo6mm2NPkDpbM8gBUx+C/2b5CJKre43R
         h59YHYj8EGll5cyRNoefyC823tlV8EuOqgdQqSprUC+ymoLeHej7pTnvPP1ls8wgApeE
         ytprLrZarD2bUYK3c/aENnL7xoTla2Qj46NEtx+zSxH6pojDAWsz13sdPONBX5C7PRN5
         mmrHRSlTphY2sCrl5ZA9WDOxfxrGHSE3sLWThpAJG35u83mQsLNIlDJ/P34X9fQO1KJQ
         MW7A==
X-Gm-Message-State: AOAM533/cW3YX298xCTYwBB9Tk37cU6eWsiDY+p5ZmP1R67Ybd0fP/9N
        HysI+w40a+OEn1KsBqnSZm4Y9Zl4zbA=
X-Google-Smtp-Source: ABdhPJyrFXfda8gm0gS90dr7Yqvdo2q9Ev0XGHc5kZ7klLeWGxN1soRQy9eJZaz5+32PLMbtqvQ6pg==
X-Received: by 2002:a63:1c0c:: with SMTP id c12mr725902pgc.21.1603911569773;
        Wed, 28 Oct 2020 11:59:29 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id x23sm337654pfc.47.2020.10.28.11.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:59:28 -0700 (PDT)
Date:   Thu, 29 Oct 2020 03:59:27 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] zram: break the strict dependency from lzo
Message-ID: <20201028185927.GB128655@google.com>
References: <20201028115921.848-1-rsalvaterra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028115921.848-1-rsalvaterra@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cc-ing Andrew

message-id: 20201028115921.848-1-rsalvaterra@gmail.com

On (20/10/28 11:59), Rui Salvaterra wrote:
> There's nothing special about zram and lzo. It works just fine without it, so
> as long as at least one of the other supported compression algorithms is
> selected.
> 
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Minchan, I'm fine with the change.

Two things from my side:

1) The commit message, probably, can be a bit more informative. Something
like this?

	ZRAM always enables CRYPTO_LZO because lzo-rle is the hardcoded
	fallback compression algorithm, which means that on systems where
	ZRAM always use, for instance, CRYPTO_ZSTD lzo kernel module
	becomes unneeded. This patch removes the hardcoded lzo-lre
	dependency, instead ZRAM picks the first supported CRYPTO
	compression algorithm, should it be ZSTD or LZ4, etc; and only
	forcibly enables CRYPTO_LZO (previous behaviour) if none of the
	alternative algorithms were selected.


2) The ZRAM_AUTOSEL_ALGO allows to deselect CRYPTO_LZO only if
CRYPTO_LZ4/CRYPTO_LZ4HC/CRYPTO_842/CRYPTO_ZSTD are compiled in (=y).
If any of the algorithms is selected as a module (=m) then CRYPTO_LZO
is selected as the default algorithm. Apparently depends on !(CONFIG_FOO)
means depends on !(CONFIG_FOO=y).

It appears that the below change fixes it, but it looks a bit ugly.

---
diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 141ce0ebad06..f2fd34de9200 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -15,7 +15,7 @@ config ZRAM
 
 config ZRAM_AUTOSEL_ALGO
 	def_bool y
-	depends on ZRAM && !(CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842 || CRYPTO_ZSTD)
+	depends on ZRAM && !(CRYPTO_LZ4=m || CRYPTO_LZ4HC=m || CRYPTO_842=m || CRYPTO_ZSTD=m || CRYPTO_LZ4=y || CRYPTO_LZ4HC=y || CRYPTO_842=y || CRYPTO_ZSTD=y)
 	select CRYPTO_LZO
 
 config ZRAM_WRITEBACK
---

	-ss
