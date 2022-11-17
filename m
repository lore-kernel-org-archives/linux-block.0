Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74941C4332F
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 21:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbiKQV6W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241093AbiKQV5u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 16:57:50 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE9C7DED8
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 13:57:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso3283528pjc.2
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 13:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IIh+nGIerLfk4ZB9SpoRZWMODmjSUqXiyhjydKb0Cds=;
        b=PJZ6jbnQhQq9tru88c3QcgjfZaJDnoJRCzzf1bX0/gWQf6BO1kYnGuZiAkcQbfZxF1
         wVZdaktXE7y7G0iGR9w0mDib97tK+9Z1KEN4DGKZzUJEwZpO/1SRERjEZW4dZS1lSmQm
         6pLSDQke2I1tY0Rbt7braOr4eQDXUxJpKb4Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIh+nGIerLfk4ZB9SpoRZWMODmjSUqXiyhjydKb0Cds=;
        b=ThIhrPmDz8ak2ghAoGPYaN4h2CFlJrak76qiKA3OUfQLumc2YWAqE1GS1bkFk1ffUT
         8rRS8nZwDCvxOVdlkaz8Y+zgHOGmd0MX6paPivY4GdvM52kZcrF1yGoyAlbMWZVjTZIo
         rtDUjXoAvRVyGzckTzt21YFse3V04msERvda9O0Z5895ZKtlb4YHwef3xVnBd191jend
         BusRjjeOSs8IbS7qg4ARGRH8+p5vb26FpyuA6U32ZmWu9BLWfhfpszNlsNaGldlT4Rg+
         1q+1OXHDtPLhV1N2VIQynWsk1cOkoJNUKoWk0BwZNVCLh2xOoILBuuFoM8t992SDBg7L
         cvrA==
X-Gm-Message-State: ANoB5pmYyssnkMaL+YtRFWOO/uAOV4lWePS/65KSfSzTDVXP3VbKUyGf
        8eBO1n8SVqSINZQUWpmDLKufVA==
X-Google-Smtp-Source: AA0mqf5F2mDePv/SsUAusLJAu22vdbKLGH3peZOY+MZBhXcyEG7NIlWlaGpyKLA4kx4t011dWowR5A==
X-Received: by 2002:a17:90a:dd82:b0:212:fdb1:720b with SMTP id l2-20020a17090add8200b00212fdb1720bmr10785160pjv.66.1668722234748;
        Thu, 17 Nov 2022 13:57:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a28-20020aa795bc000000b0056beae3dee2sm1674860pfk.145.2022.11.17.13.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:57:14 -0800 (PST)
Date:   Thu, 17 Nov 2022 13:57:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Darrick J . Wong" <djwong@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] treewide: use get_random_u32_inclusive() when
 possible
Message-ID: <202211171349.F42BA5B0@keescook>
References: <20221114164558.1180362-1-Jason@zx2c4.com>
 <20221117202906.2312482-1-Jason@zx2c4.com>
 <20221117202906.2312482-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117202906.2312482-4-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 17, 2022 at 09:29:06PM +0100, Jason A. Donenfeld wrote:
> These cases were done with this Coccinelle:
> 
> @@
> expression H;
> expression L;
> @@
> - (get_random_u32_below(H) + L)
> + get_random_u32_inclusive(L, H + L - 1)
> 
> @@
> expression H;
> expression L;
> expression E;
> @@
>   get_random_u32_inclusive(L,
>   H
> - + E
> - - E
>   )
> 
> @@
> expression H;
> expression L;
> expression E;
> @@
>   get_random_u32_inclusive(L,
>   H
> - - E
> - + E
>   )
> 
> @@
> expression H;
> expression L;
> expression E;
> expression F;
> @@
>   get_random_u32_inclusive(L,
>   H
> - - E
>   + F
> - + E
>   )
> 
> @@
> expression H;
> expression L;
> expression E;
> expression F;
> @@
>   get_random_u32_inclusive(L,
>   H
> - + E
>   + F
> - - E
>   )
> 
> And then subsequently cleaned up by hand, with several automatic cases
> rejected if it didn't make sense contextually.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com> # for infiniband
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/x86/kernel/module.c                      |  2 +-
>  crypto/rsa-pkcs1pad.c                         |  2 +-
>  crypto/testmgr.c                              | 10 ++++----
>  drivers/bus/mhi/host/internal.h               |  2 +-
>  drivers/dma-buf/st-dma-fence-chain.c          |  2 +-
>  drivers/infiniband/core/cma.c                 |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_ah.c       |  5 ++--
>  drivers/mtd/nand/raw/nandsim.c                |  2 +-
>  drivers/net/wireguard/selftest/allowedips.c   |  8 +++---
>  .../broadcom/brcm80211/brcmfmac/p2p.c         |  2 +-
>  .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
>  fs/f2fs/segment.c                             |  6 ++---
>  kernel/kcsan/selftest.c                       |  2 +-
>  lib/test_hexdump.c                            | 10 ++++----
>  lib/test_printf.c                             |  2 +-
>  lib/test_vmalloc.c                            |  6 ++---
>  mm/kasan/kasan_test.c                         |  6 ++---
>  mm/kfence/kfence_test.c                       |  2 +-
>  mm/swapfile.c                                 |  5 ++--
>  net/bluetooth/mgmt.c                          |  5 ++--
>  net/core/pktgen.c                             | 25 ++++++++-----------
>  net/ipv4/tcp_input.c                          |  2 +-
>  net/ipv6/addrconf.c                           |  6 ++---
>  net/netfilter/nf_nat_helper.c                 |  2 +-
>  net/xfrm/xfrm_state.c                         |  2 +-
>  25 files changed, 56 insertions(+), 64 deletions(-)

Even the diffstat agrees this is a nice clean-up. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

The only comment I have is that maybe these cases can just be left as-is
with _below()?

> -             size_t len = get_random_u32_below(rs) + gs;
> +             size_t len = get_random_u32_inclusive(gs, rs + gs - 1);

It seems like writing it in the form of base plus [0, limit) is clearer?

		size_t len = gs + get_random_u32_below(rs);

But there is only a handful, so *shrug*

All the others are much cleaner rewritten as _inclusive().

-- 
Kees Cook
