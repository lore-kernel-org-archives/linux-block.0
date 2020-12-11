Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D1C1B0D8
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 11:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A926D23D5A
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 11:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbgLKLdy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 06:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390637AbgLKLdb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 06:33:31 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31B2C0613D6;
        Fri, 11 Dec 2020 03:32:51 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id s2so4443951plr.9;
        Fri, 11 Dec 2020 03:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BWICF8mwrTJeoR9Oo9x9XDSK1j/Izqnc/UFYRBFw/rc=;
        b=tVwZEIX/WRoIKkoCKEs+j9YBD+oZGTrQ+l9j9L6hnAQiMHogyFxxZYUUQvw9cugbgD
         R23stujM5wc84x0rM3oV2K7LcnV0kgP563A7mt2eWWheM+YShlL8C7ubg5xwMRykVkw3
         sgEuxkEAibbwnYL0UsGoswFbnEhOIAuudx8tT/8uynVxbHgAJXTTI3PqwYo0+g4JKJ7v
         64DNk3tgPqqDFqZpAeW7oweSZ/ABHuJ2cIqMLGL0KlfIeh09y4NIYT9hFzUZ5N9hSpcK
         hRuzEdGnxKUiQkImxnJSVIlDxx9R4YzdO2033S8IjCqNR03vB+71dumFPHZHJdgvkGy3
         YcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BWICF8mwrTJeoR9Oo9x9XDSK1j/Izqnc/UFYRBFw/rc=;
        b=DytnOWSIMVQUahZR9YCF9eaTNgHi0uN4EIMuh8QZ4a1BzXAJaTlWuspNuliLj2bDzf
         PQXs8q+yBZhJ9vjYiqiqG30AMclFjvQCRga4Dgj1UXq2xUGA4Acxx5AHpYfC6IYN9Qtq
         pXQRgD9chuHICPs7s+dMueYF/lzSRJe4XrjfULn/IcHuYzRc1lERXK9FMSk6TrO9uamU
         om6kl0sHhTBjS6fOgh7QNIkGAu31MRLINzk7GS5e3DTtueMEZ0Rn07h3lZptkdrDSnYT
         oFEqoxFqOhIkY4lnF5iuyduyJ8pZcyzoavgttjZBr3T9t+te2zzJO6VOOvVCaPyA7yV1
         Yh4A==
X-Gm-Message-State: AOAM5309/oRHvRh2AKbdjF+RnzbpV89sweR1FODuyu6jn3UyVdR2aCa4
        ucs/+/BTKm9OMc2T0p3wGZUfDsAXv5We8w==
X-Google-Smtp-Source: ABdhPJwIcYTJzWTHyktVdpGBAPDPtsyyn3U31r7gB0V31U4TP1HtNJpKZZam/iNveOnuSJPRdqME/Q==
X-Received: by 2002:a17:90a:d256:: with SMTP id o22mr8690654pjw.195.1607686371133;
        Fri, 11 Dec 2020 03:32:51 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id f24sm1809642pjj.5.2020.12.11.03.32.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Dec 2020 03:32:50 -0800 (PST)
Date:   Fri, 11 Dec 2020 20:32:48 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] blk-mq: trivial helper and fixes comments
Message-ID: <20201211113248.GA6945@localhost.localdomain>
References: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20-12-05 00:20:52, Minwoo Im wrote:
> Hello,
> 
> This patch set contains:
>   - Introduce a helper to allocate tagset tags for the first time
>     without 'realloc' keyword that used to be taken.
>   - Fixes for comments need to be updated.
> 
> Please have a look.
> 
> Thanks,
> 
> 
> Minwoo Im (3):
>   blk-mq: add helper allocating tagset->tags
>   blk-mq: update arg in comment of blk_mq_map_queue
>   blk-mq: fix msec comment from micro to milli seconds
> 
>  block/blk-mq.c | 14 ++++++++++----
>  block/blk-mq.h |  2 +-
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1
> 

Hello,

Gentle ping.

Thanks!
