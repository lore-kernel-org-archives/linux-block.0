Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DD6C4332F
	for <linux-block@archiver.kernel.org>; Fri, 23 Dec 2022 11:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiLWLvM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Dec 2022 06:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiLWLvL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Dec 2022 06:51:11 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC3E5FCD
        for <linux-block@vger.kernel.org>; Fri, 23 Dec 2022 03:51:10 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f3so3192949pgc.2
        for <linux-block@vger.kernel.org>; Fri, 23 Dec 2022 03:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjv/rRvXeISjMwkyg4jOWEP5q4M57HHzk7yPJaOOhtY=;
        b=ZpIa3DS09D5ozTUeEZeNzSvBicRKYBlwZZu7/O2+K5u9TUnLAPK+jYdhX//qFzYKQ1
         lp1K1u18zcUB2k5Wdo5kqOopWseXOCBpZBlMFA+DUQnqx2rwC1rEAiHQGcDYjn0+sFaa
         Lhck/cvE9uuTmcBqo4rW2NyEKmTGYCAM39JOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjv/rRvXeISjMwkyg4jOWEP5q4M57HHzk7yPJaOOhtY=;
        b=FJ8OeZkaGBJZYi+DZrJd6B8KPPtdx7jff1mmSZmzqJBSx7Sj1eLzZexy1BJbHlb6fE
         l9RrrkoaF1f8z8dk/tUojiqFX1eiUQ8N5B4wNGap6s2ueEjmp2DDSkv7wKjFxN8Q9o+r
         EVeaZpQzxEPW5PSxlo8Dm2sghw5K317GuUx4hXHOictaWXlNrbmyWHOy6yBALGKgmziB
         cnAON8gzxr6bMZpDZkwSerBDjHk8Jki31ElcMrdjEmIQxaim4dwSR10HCKLB3cUZgQ0r
         icGZs0PbhGI9CMHDTEJpSjf+iqamcyyaISDeDnkKKZjhHkn8VQ7D85dVh9UhoxQerITO
         EKuQ==
X-Gm-Message-State: AFqh2krC/Gt504+WGPIfyGIxPPnMuHnaVx+mSGWIqMPz07HmGhf+USZS
        yipEwnKnd90lCROlpDxXc9fX7ZfMZ4M9fuBE
X-Google-Smtp-Source: AMrXdXsPk67PjFUI8adM5H88BkzcWWRaJBvouYJe9gvxHtQcPi5cLcb9STmHwmKGx7YUo2uB609Uog==
X-Received: by 2002:a05:6a00:1ca7:b0:56d:1bb6:af75 with SMTP id y39-20020a056a001ca700b0056d1bb6af75mr23752646pfw.4.1671796270329;
        Fri, 23 Dec 2022 03:51:10 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id a3-20020a624d03000000b0056ee49d6e95sm2369161pfb.86.2022.12.23.03.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 03:51:09 -0800 (PST)
Date:   Fri, 23 Dec 2022 20:51:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     JeongHyeon Lee <jhs2.lee@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        senozhatsky@chromium.org, minchan@kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: fix typos in comments
Message-ID: <Y6WWKXUEDcq26XEF@google.com>
References: <CGME20221223040335epcas1p45bda0013a3a42f176fa137e0597fd7c9@epcas1p4.samsung.com>
 <20221223040331.4194-1-jhs2.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223040331.4194-1-jhs2.lee@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cc-ing Andrew

On (22/12/23 13:03), JeongHyeon Lee wrote:
> - The double `range` is duplicated in comment, remove one.
>  - change `syfs` to `sysfs`
> 
> Signed-off-by: JeongHyeon Lee <jhs2.lee@samsung.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
