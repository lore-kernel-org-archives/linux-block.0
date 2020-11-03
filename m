Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BC3C388F9
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 21:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2861D22403
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 21:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604438957;
	bh=lFYMb6mAgfy0I5bDuy8r2CQDZBokFbSRlrDZI2z1Bv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=udilw0ze0qkXpMFVggsNCmodAmgkzMLQV1HbUywycb1n6y1RPeAEjztSYwTbzT3sf
	 ST06wDo6jS6S34cN0oxxexOkYRLO4PFX+Q8X0wv7CFWLgLpZ/7apV1BImc3tp4g7i0
	 MBLiDQIiOM+XEaqZJ6SZwmGhd0h57uzBOeIdyEfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgKCV3N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbgKCV3H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Nov 2020 16:29:07 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1FBC0613D1;
        Tue,  3 Nov 2020 13:29:07 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id o3so14695093pgr.11;
        Tue, 03 Nov 2020 13:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ljv1+KvI5hTHcQoof79AZSHu3gwcUWXr8lrxs/yX5Kk=;
        b=bEVxy2H7uj4F63AnHPagvePAt3sVaVtR2OIFbguAGJ7EePVrcUc5Df23c/kp7ynJUC
         08rrmUBSbnzZi2s3Z/EvZKEaMNaq/1ZBp80Qn0LwMw9h0RLZvCgy5fS191wad3UdMTSp
         sj8HE+AuzgIeDvQYB9SAbZLOMW5ImzYT4hUMR3NtyAUl0s+SIubIIRtkMd3U2JHFCroB
         B6vHfOIq+rfhNoChAXNmO+KUH8OkT6ZBc2fkvvNOSJt+9/G4olmfrmJDAP4CixpLIxZS
         ILh+9iE0fnPihopFkQHwqlFr7ZBkVwE6ZTtv02RChzRGFvp9opKOl9vmbNXowQq5NQIC
         3N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ljv1+KvI5hTHcQoof79AZSHu3gwcUWXr8lrxs/yX5Kk=;
        b=B6CeL5GJTeDM3W5xBpoEMQKe1hv3l7E5gN+955Xt6KYIUKVXZotlIJv28l5yVXLqBj
         sxTaW9Cnnaj3N2yz2nZv8Whf0i7KOrYTHbKwC25tT9jvxd92+FbkqXz4m7ZHuYPzNyhJ
         c9Rx9Bv5MYdQLJBryVKHHLdgm79niWwtPkBrWq0EGji27bk7HsnZrKqrzVqsrsfTEQFS
         NIdHL0fyto5sR0R7T59//jhj1rG3zxcCHGDloQxeAOEKcRKAHRqiCs6ajn3B9Szd2cXK
         aXDf2mGivLcfsx5DYxuFG49SCs6HfYAes2lR26zdGYqgUc4heTqHHxup9MVoYrsHF62O
         rjJg==
X-Gm-Message-State: AOAM530j8usol3US6e5R+KUwYQ1aJC7Eym+CaPW9y5c4F3LL1DeOR7Qa
        rM8eu3yENXXfguWnOO7FiMcCAe/Fb+w=
X-Google-Smtp-Source: ABdhPJyKloXD4xINSbgF3o5VbXFU1LF8DbROP7U4Z7BqRpP3+EpVjb9iMilSJqvIIGW0IBezf/lpIg==
X-Received: by 2002:a62:5f83:0:b029:18a:e039:4908 with SMTP id t125-20020a625f830000b029018ae0394908mr12272492pfb.23.1604438946885;
        Tue, 03 Nov 2020 13:29:06 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id a184sm55618pfa.86.2020.11.03.13.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 13:28:52 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 3 Nov 2020 13:28:47 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, ngupta@vflare.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] zram: break the strict dependency from lzo
Message-ID: <20201103212847.GA1631979@google.com>
References: <20201028115921.848-1-rsalvaterra@gmail.com>
 <20201028185927.GB128655@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028185927.GB128655@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sergey and Rui,

On Thu, Oct 29, 2020 at 03:59:27AM +0900, Sergey Senozhatsky wrote:
> Cc-ing Andrew
> 
> message-id: 20201028115921.848-1-rsalvaterra@gmail.com
> 
> On (20/10/28 11:59), Rui Salvaterra wrote:
> > There's nothing special about zram and lzo. It works just fine without it, so
> > as long as at least one of the other supported compression algorithms is
> > selected.
> > 
> > Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Sorry for the late. I am still looking for the time to look into this
patch.

I totally agree with the motivation of Rui. Before that, just a
dumb question.

Can't we just provide choice/endchoice in Kconfig to select default
comp algorithm from admin?

> 
> Minchan, I'm fine with the change.
> 
> Two things from my side:
> 
> 1) The commit message, probably, can be a bit more informative. Something
> like this?
> 
> 	ZRAM always enables CRYPTO_LZO because lzo-rle is the hardcoded
> 	fallback compression algorithm, which means that on systems where
> 	ZRAM always use, for instance, CRYPTO_ZSTD lzo kernel module
> 	becomes unneeded. This patch removes the hardcoded lzo-lre
> 	dependency, instead ZRAM picks the first supported CRYPTO
> 	compression algorithm, should it be ZSTD or LZ4, etc; and only
> 	forcibly enables CRYPTO_LZO (previous behaviour) if none of the
> 	alternative algorithms were selected.
> 
> 
> 2) The ZRAM_AUTOSEL_ALGO allows to deselect CRYPTO_LZO only if
> CRYPTO_LZ4/CRYPTO_LZ4HC/CRYPTO_842/CRYPTO_ZSTD are compiled in (=y).
> If any of the algorithms is selected as a module (=m) then CRYPTO_LZO
> is selected as the default algorithm. Apparently depends on !(CONFIG_FOO)
> means depends on !(CONFIG_FOO=y).
> 
> It appears that the below change fixes it, but it looks a bit ugly.
> 
> ---
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index 141ce0ebad06..f2fd34de9200 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -15,7 +15,7 @@ config ZRAM
>  
>  config ZRAM_AUTOSEL_ALGO
>  	def_bool y
> -	depends on ZRAM && !(CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842 || CRYPTO_ZSTD)
> +	depends on ZRAM && !(CRYPTO_LZ4=m || CRYPTO_LZ4HC=m || CRYPTO_842=m || CRYPTO_ZSTD=m || CRYPTO_LZ4=y || CRYPTO_LZ4HC=y || CRYPTO_842=y || CRYPTO_ZSTD=y)
>  	select CRYPTO_LZO
>  
>  config ZRAM_WRITEBACK
> ---
> 
> 	-ss
