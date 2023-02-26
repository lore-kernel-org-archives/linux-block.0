Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C756DC64ED6
	for <linux-block@archiver.kernel.org>; Sun, 26 Feb 2023 03:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBZDiP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Feb 2023 22:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjBZDiO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Feb 2023 22:38:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928A383EE
        for <linux-block@vger.kernel.org>; Sat, 25 Feb 2023 19:38:13 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p20so2273374plw.13
        for <linux-block@vger.kernel.org>; Sat, 25 Feb 2023 19:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w5Rg6I1cmXAeRDJOuxnp8t4y5fBQt8rslGX6AycVTYk=;
        b=obvxZQfuGGnnl0eWnSNpRy8gi2zG6/icUwEZTew7bdim4vM02+Fg6mJccssdsiDCWI
         63zm2EG8p7Z6jWDA/0NrSMWHmtqZWOwEYzJ08Tn0UbGmQl+EcZNQEUlBf47n9bw1CQvt
         IVfL9pJ8jl8m2Yy0Z8+D/DjGMnhYt7hZoHf14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5Rg6I1cmXAeRDJOuxnp8t4y5fBQt8rslGX6AycVTYk=;
        b=NPhgrsQjWBYRidb8nTqC/LAczrHNvkAtoAZKlXNR19L5Ro8oDyZuMRhwJmMKvxgK8t
         v4G/qEwhO1zxJNgsKCiCfxpiD+5PCSn4ruU4S4dykmsJo2r5D4S3JPCoS2OqtmxT6DtM
         PEbpVU3tNJ8pAj+0AXncbLieGZYTi4StmWzuvyzPvTp8YQAGxDTl7c/ODjXVONOm+Atr
         8d8EgbxIKudSEqLz9F6oZHO8IEylersFpP7oMO3j54PWozgPjl7EwQ3NncBuuuNDfn7Z
         0oSPbwac1aiKac2sqLvweUqtCjWXqwMK+m090D5c5bOPGGDTBExT3LhESLbTYEh7qp0B
         wLqw==
X-Gm-Message-State: AO0yUKWwvUPkcHWNrZRJMsrj5QxNY3VUz0NVt9SPqKqCxqnRMkpulDXq
        y6WLHtxD+Pvl36UvuNoWQQSasA==
X-Google-Smtp-Source: AK7set9j6WCf61CgO8Sw1yGGWG+IoM9Cunn4SttlHzt4ea/KDHgO9cUcUw7eLdT15DrEniMbPKl4Lg==
X-Received: by 2002:a17:902:7292:b0:196:56ae:ed1d with SMTP id d18-20020a170902729200b0019656aeed1dmr15761934pll.69.1677382693024;
        Sat, 25 Feb 2023 19:38:13 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709026b4300b00198e346c35dsm1937190plt.9.2023.02.25.19.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 19:38:12 -0800 (PST)
Date:   Sun, 26 Feb 2023 12:38:08 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: Use atomic_long_read() to read atomic_long_t
Message-ID: <Y/rUIF9Tc97GC6Ue@google.com>
References: <20230225121523.3288544-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230225121523.3288544-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/02/25 13:15), Geert Uytterhoeven wrote:
> On 32-bit:
> 
>     drivers/block/zram/zram_drv.c: In function ‘mm_stat_show’:
>     drivers/block/zram/zram_drv.c:1234:23: error: passing argument 1 of ‘atomic64_read’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>      1234 |    (u64)atomic64_read(&pool_stats.objs_moved));
> 	  |                       ^~~~~~~~~~~~~~~~~~~~~~
> 	  |                       |
> 	  |                       atomic_long_t * {aka struct <anonymous> *}
>     In file included from ./include/linux/atomic.h:82,
> 		     from ./include/linux/mm_types_task.h:13,
> 		     from ./include/linux/mm_types.h:5,
> 		     from ./include/linux/buildid.h:5,
> 		     from ./include/linux/module.h:14,
> 		     from drivers/block/zram/zram_drv.c:18:
>     ./include/linux/atomic/atomic-instrumented.h:644:33: note: expected ‘const atomic64_t *’ {aka ‘const struct <anonymous> *’} but argument is of type ‘atomic_long_t *’ {aka ‘struct <anonymous> *’}
>       644 | atomic64_read(const atomic64_t *v)
> 	  |               ~~~~~~~~~~~~~~~~~~^
> 
> Fix this by using atomic_long_read() instead.

Hi Geert,
The patch that cause the warning probably will be droppped from
the series in v3.
