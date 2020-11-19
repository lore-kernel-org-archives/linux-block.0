Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC0AC63777
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 22:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720D22224D
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 22:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+4xOo4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgKSW0O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgKSW0O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 17:26:14 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C64EC0613CF;
        Thu, 19 Nov 2020 14:26:14 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r18so5532706pgu.6;
        Thu, 19 Nov 2020 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b2H+78byClGdmIdPEifk9zjxHk4lwzN95YFOCTF8v/M=;
        b=d+4xOo4b+776mhQeBNd/eD+W1pk9/fuMEexUcTnAbiGDHmFDlAcdYM4yexuae26qC9
         pjYIeA+4r2ydH5sYKe6S6jnhCv0gbW3O+5wSHS+D7Rxr55eIxXYUEgALMp4qo4jf8HfL
         lzEJspjgj1+t3fycPabvGWm/ivt7U5xB8+MTfVf2RdddDAV1+CRSqkGHUOrIy65FF3cW
         p5olQKMBUHy7VOtJ96GkTtnhlwW2QwFkgM1DPDJSkEh7s+fx+kzU3L2fb9XEhxE78cCl
         neN7J5lWR9lvPeoKCsnYKvmqF4MVRxGly4cVCqOva70X8MUIlzPst4ZVystRI90cjTYb
         GDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b2H+78byClGdmIdPEifk9zjxHk4lwzN95YFOCTF8v/M=;
        b=AcJn50ihhlp5V1Rl6O1AOq0loqyj90nadgu4grylBmjvz16ELhBLROeh+9ZxsHt8t1
         Fu9pEc2qqH/KVLGS1mN5sIQCNMN4t5dPs7IbNsGE7+2woci9Z4dxjRvQJtLvIMoy0Ds/
         MeW4aMsga3UrugKD6SbLyd6E2iMp+KqmrBpX8Twm7HZKmAimeJyV0a+tsNjpJf7maQox
         +5QpKbYZLkmfu8TA0OztC1mZojrS9MBxPe/d92ZISpHob39BcRmyVhUFN5nU6ihJuW/S
         trhTXfjOgHeiQ98zSVZTf6c/LBLGg2r9+Lp3/lZSi/BpINv/DJZfgrWlC+kqIYS/P3yD
         7M3Q==
X-Gm-Message-State: AOAM532WE3bA9gXFjVFzsT8OsfFTLuuyg8Gkot7+aPwRHAsywz42r1UX
        irTimKu1sN+FdB6zTjjxBJxhn8xw5U0=
X-Google-Smtp-Source: ABdhPJwl/u32kBC6hM/96HpAJaygHZ5Z29CLTLxgq7flJzGrxqWm/mJVKebgHAI69RfjcHZDW8LS1w==
X-Received: by 2002:a62:2ac2:0:b029:18c:25ff:d68 with SMTP id q185-20020a622ac20000b029018c25ff0d68mr11327301pfq.64.1605824773761;
        Thu, 19 Nov 2020 14:26:13 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id g18sm923397pfu.131.2020.11.19.14.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 14:26:12 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 19 Nov 2020 14:26:10 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] zram: break the strict dependency from lzo
Message-ID: <20201119222610.GD3113267@google.com>
References: <20201115101514.954-1-rsalvaterra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115101514.954-1-rsalvaterra@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Nov 15, 2020 at 10:15:14AM +0000, Rui Salvaterra wrote:
> From the beginning, the zram block device always enabled CRYPTO_LZO, since
> lzo-rle is hardcoded as the fallback compression algorithm. As a consequence, on
> systems where another compression algorithm is chosen (e.g. CRYPTO_ZSTD), the
> lzo kernel module becomes unused, while still having to be built/loaded.
> 
> This patch removes the hardcoded lzo-rle dependency and allows the user to
> select the default compression algorithm for zram at build time. The previous
> behaviour is kept, as the default algorithm is still lzo-rle.
> 
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Suggested-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
> v5: incorporate Minchan's feedback. Allow the user to choose a default algorithm.
> v4: incorporate Sergey's feedback and fix a small typo.
> v3: fix the default selection when lzo isn't present. Rebase against 5.10-rc1.
> v2: fix the dependency on CRYPTO.
> 
> I believe this is the final version, but it does deserve some comment. Given the
> choice of having more preprocessor #if/#endif directives in C files or making
> the kconfig a bit more complex, I went for the latter. However, since kconfig
> choices can only be boolean, I had to devise a way to make a string selection
> based on the boolean choice, hence the ZRAM_DEF_COMP symbol.
> I also tried to make the ZRAM_AUTOSEL_ALGO definition a bit less painful to the
> eye, while still allowing for the compression algorithms to be selected as
> modules, as per Sergey's suggestion.
> 
>  drivers/block/zram/Kconfig    | 49 ++++++++++++++++++++++++++++++++++-
>  drivers/block/zram/zcomp.c    |  2 ++
>  drivers/block/zram/zram_drv.c |  2 +-
>  3 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index fe7a4b7d30cf..cde089c30ffb 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -2,7 +2,6 @@
>  config ZRAM
>  	tristate "Compressed RAM block device support"
>  	depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
> -	select CRYPTO_LZO
>  	help
>  	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
>  	  Pages written to these disks are compressed and stored in memory
> @@ -14,6 +13,54 @@ config ZRAM
>  
>  	  See Documentation/admin-guide/blockdev/zram.rst for more information.
>  
> +choice
> +	prompt "Default zram compression algorithm"
> +	depends on ZRAM
> +
> +config ZRAM_DEF_COMP_LZORLE
> +	bool "lzo-rle"
> +	depends on CRYPTO_LZO
> +
> +config ZRAM_DEF_COMP_ZSTD
> +	bool "zstd"
> +	depends on CRYPTO_ZSTD
> +
> +config ZRAM_DEF_COMP_LZ4
> +	bool "lz4"
> +	depends on CRYPTO_LZ4
> +
> +config ZRAM_DEF_COMP_LZO
> +	bool "lzo"
> +	depends on CRYPTO_LZO
> +
> +config ZRAM_DEF_COMP_LZ4HC
> +	bool "lz4hc"
> +	depends on CRYPTO_LZ4HC
> +
> +config ZRAM_DEF_COMP_842
> +	bool "842"
> +	depends on CRYPTO_842
> +
> +endchoice
> +
> +config ZRAM_DEF_COMP
> +	string
> +	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
> +	default "zstd" if ZRAM_DEF_COMP_ZSTD
> +	default "lz4" if ZRAM_DEF_COMP_LZ4
> +	default "lzo" if ZRAM_DEF_COMP_LZO
> +	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
> +	default "842" if ZRAM_DEF_COMP_842
> +
> +config ZRAM_AUTOSEL_ALGO
> +	def_bool y
> +	depends on ZRAM && \
> +		!(CRYPTO_LZ4=m   || CRYPTO_LZ4=y   || \
> +		  CRYPTO_LZ4HC=m || CRYPTO_LZ4HC=y || \
> +		  CRYPTO_842=m   || CRYPTO_842=y   || \
> +		  CRYPTO_ZSTD=m  || CRYPTO_ZSTD=y)
> +	select CRYPTO_LZO
> +

Hi Rui,

What's the purpose of ZRAM_AUTOSEL_ALGO?
If you and Sergey already discussed, sorry about the missing it.

Below doesn't work for your goal?

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fe7a4b7d30cf..7f3c50f5f87e 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -2,7 +2,6 @@
 config ZRAM
        tristate "Compressed RAM block device support"
        depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
-       select CRYPTO_LZO
        help
          Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
          Pages written to these disks are compressed and stored in memory
@@ -14,6 +13,32 @@ config ZRAM

          See Documentation/admin-guide/blockdev/zram.rst for more information.

+
+choice
+       prompt "zram default compressor"
+       default ZRAM_COMP_LZO_DEF
+       depends on ZRAM || CRYPTO_LZ4
+       help
+         a
+
+config ZRAM_COMP_LZO_DEF
+       bool "lzo"
+       select CRYPTO_LZO
+       help
+         b
+
+config ZRAM_COMP_LZ4_DEF
+       bool "lz4"
+       depends on CRYPTO_LZ4
+       help
+         c
+endchoice
+
+config ZRAM_DEF_COMP
+       string
+       default "lzo" if ZRAM_COMP_LZO_DEF
+       default "lz4" if ZRAM_COMP_LZ4_DEF

