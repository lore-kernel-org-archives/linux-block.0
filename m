Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59896C433F5
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 13:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiEWNpg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 09:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbiEWNpe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 09:45:34 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8993A5521D
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 06:45:33 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id dm17so12116154qvb.2
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fXXuOXxpYqAa8ZcL4iQ7Zr/0+vXNmpz1OjtE6mlyRoA=;
        b=2FYHK8Xr8KL+RJmbK4hGu7IWiSs0Im5AZ8BEgjzCBWMhM/xyoNfWrtHN9Gjz4RogAn
         J9IeWd2Xt+y4sq3Bc2hVj7ERoW3YbK2TejxICpbtdfz/by7nAPr83bma4PxocdzzjZdf
         SjH4nOzoA0Kp7VX82t3rMQsDmqrdXeJg0CpISNe6UFm7dHX7USWZrQkVpixVqW54GMIV
         +X/aRzFjIDtKnBLBA+fh74MeZTm4kLDqI30frQXaI4Pq6PbtpDVkEiWvqV6G5X+493Xc
         jCShrDVu79TOpMP/tu2CFPc0Hb8uf5S4UKhQ9wiiMskO+Xik46gFff4XRW964onmxIen
         dyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fXXuOXxpYqAa8ZcL4iQ7Zr/0+vXNmpz1OjtE6mlyRoA=;
        b=lE6ALA6qaWSn083MnoEPbCyFBzRCbbj4k8tFXns5gmiMv82Rmxz5U3RrYDH/9u9h14
         B/q86/wp4MPUA1O7vxKW8qPYoJMPer/LQhUYSfx1PCbAgrrYblgJjU7nzsVR6KHse9K5
         YsKiRtzdxGxOm1ndWCPt9m64xnb3SYDPLZXZL9cGnmL4XDWTJhxY80zHQIT6gryDwWCB
         PsrpeC7FY/Q8TLcRebmJPfw/O1ebz5QpDXfXaPh6tJf/Fit11cxhfbe5ywSVp8TwWzza
         EgcUKnnHsUZ6uQzbMWU3b3pL/JopM2qNPhCtTQK8FSG8s3jDagHJTDIIHizrIe4AP7k0
         qUTQ==
X-Gm-Message-State: AOAM53146ESAcB1/FpDwPAi8tH5+bmESwPlCmm0FxJVx7RwN0DmZOGJs
        Y6tltWTApujqhudrTXlWT6HrUw==
X-Google-Smtp-Source: ABdhPJy9KbQYqYcUYxEaBJ+1DpKGdb0pGacMRGgVYJXOymh0fdyUVC8WUcqRnj1UQTFSwFwuT+5j7g==
X-Received: by 2002:ad4:5c41:0:b0:462:199a:1f45 with SMTP id a1-20020ad45c41000000b00462199a1f45mr9969474qva.31.1653313532702;
        Mon, 23 May 2022 06:45:32 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id i1-20020a37b801000000b006a03cbb1323sm4410299qkf.65.2022.05.23.06.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:45:32 -0700 (PDT)
Date:   Mon, 23 May 2022 09:45:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next] zram: fix Kconfig dependency warning
Message-ID: <YouP++kk8TztpN7/@cmpxchg.org>
References: <20220522204027.22964-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522204027.22964-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 22, 2022 at 01:40:27PM -0700, Randy Dunlap wrote:
> ZSMALLOC depends on MMU so ZRAM should also depend on MMU
> since 'select' does not follow any dependency chains.
> 
> Fixes this Kconfig warning:
> 
> WARNING: unmet direct dependencies detected for ZSMALLOC
>   Depends on [n]: MMU [=n]
>   Selected by [y]:
>   - ZRAM [=y] && BLK_DEV [=y] && BLOCK [=y] && SYSFS [=y] && (CRYPTO_LZO [=y] || CRYPTO_ZSTD [=m] || CRYPTO_LZ4 [=m] || CRYPTO_LZ4HC [=n] || CRYPTO_842 [=n])
> 
> Fixes: b3fbd58fcbb10 ("mm: Kconfig: simplify zswap configuration")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nitin Gupta <ngupta@vflare.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Randy!
