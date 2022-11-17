Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3534C433FE
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 22:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbiKQWA5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241061AbiKQWAm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 17:00:42 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280E287A41
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 13:59:07 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b62so3360353pgc.0
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 13:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5js234S10qtjTG5ViD8Z5NsYYM8xXfh9lDGiYeYzTNk=;
        b=FgMUyRzC1HQVet+tDCWA8ljDeGrHXk7NWmfvGzfwmovUinDK9knhVBWqOEaxR/WKhH
         wwHz/N4KP6pHF44qAgHaZHzh9z++AStihN6Ao5uRAf+yYgVBMZnVIZpD5gjuBWFIjThJ
         QsnQdQgUO9c1DQGCG/8tbnX/sYDH6HkHB7Fks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5js234S10qtjTG5ViD8Z5NsYYM8xXfh9lDGiYeYzTNk=;
        b=I6RXMwmq4gEs4srCYMCAQBcH5uzDsswY0+E1sHmvvg7WsU+CHFbviAd1vAQ0eaiget
         LyR7GqA12sdwdrr64X4hFA9KeYwKQi1e/biD3xRInoNxc26MDiUJvPEbAJHeA3WKDjA9
         8GneuZMVpXlGajlHktKCj2KJ9q2vZlAGsWHqHjDD8r/0Vr5+GX+cgrQ3igUiOC1vSQxH
         vSW+yD39o0XY0AE7eqXnQSP/W/XJYH5Cy48kQmt5WxSLwSrXgSMMPCOJfxrUx7/WD10Z
         s8H/O7v1XNY19F5cgkCYbCSV8fUO8DtJMU4O3fSu6Dh8J6xY12HJuDMv1E0wwBHhaEKb
         Y7WQ==
X-Gm-Message-State: ANoB5pm/dymHx1it4ep2Jb2tI/6k+TsVT4yrRFzZfBh23tG56g8yKZIK
        lpV/g2Ep+6DkHyRZE/a5D94yBg==
X-Google-Smtp-Source: AA0mqf7QpiIvhVAGN52Mpwqa6vfs4EXQo0/q1js7mM6/xkzmq3rihpfcQy2O/U405oXjhY2LdIG4eg==
X-Received: by 2002:a63:f00d:0:b0:458:f364:b00e with SMTP id k13-20020a63f00d000000b00458f364b00emr3876253pgh.577.1668722346647;
        Thu, 17 Nov 2022 13:59:06 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090341c500b00188fce6e8absm156864ple.280.2022.11.17.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:59:06 -0800 (PST)
Date:   Thu, 17 Nov 2022 13:59:05 -0800
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
        linux-mmc@vger.kernel.org, linux-parisc@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] treewide: use get_random_u32_below() instead of
 deprecated function
Message-ID: <202211171359.412AEEE0@keescook>
References: <20221114164558.1180362-1-Jason@zx2c4.com>
 <20221117202906.2312482-1-Jason@zx2c4.com>
 <20221117202906.2312482-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117202906.2312482-2-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 17, 2022 at 09:29:04PM +0100, Jason A. Donenfeld wrote:
> This is a simple mechanical transformation done by:
> 
> @@
> expression E;
> @@
> - prandom_u32_max
> + get_random_u32_below
>   (E)
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Darrick J. Wong <djwong@kernel.org> # for xfs
> Reviewed-by: SeongJae Park <sj@kernel.org> # for damon
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com> # for infiniband
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk> # for arm
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # for mmc
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
