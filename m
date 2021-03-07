Return-Path: <SRS0=nGPF=IF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4822C433DB
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 20:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7496B64FE9
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 20:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhCGUl5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Mar 2021 15:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhCGUlk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Mar 2021 15:41:40 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24FDC06174A
        for <linux-block@vger.kernel.org>; Sun,  7 Mar 2021 12:41:40 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id w34so4015136pga.8
        for <linux-block@vger.kernel.org>; Sun, 07 Mar 2021 12:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7/d4om0ohwwj8Ihc9aj9cAGxv2Fxe1zZP149StO2flQ=;
        b=J/xZIsquufb+zPte+L/pBXWf9HGO7v9EmN/ly91VKI6N9ykYGrZa9pA18wnfnxQqbf
         ZUEn10DDyFf2KPucbf7rVsVO9QfthihIVgOZx9ROg4zcoHJ5uBa5QpkWDi/tw9qFtEHs
         r1l5ub4l7LirjVxeUzDhN+Oof4LzL2Vgug56E1MOM4BSMd28fOYdm+bx6QGF581J7PSU
         9cx9HCTGnYOR1h/QGLbr6uD4H2NyuRu0X0efmOBunqn5tZesZCOA8YES8ONkgFYcpljz
         9u0/bdda1vPBoWxc432FICcZlos+6r2afY+EAoN/wi+fGpQqrTVesj+GhSHmpSNn1oEy
         Tz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7/d4om0ohwwj8Ihc9aj9cAGxv2Fxe1zZP149StO2flQ=;
        b=UlwGZ3j22slZFPmocwip4kLIxMWbQ5bLET49Gx5ZNjGD9gjFqNlb2goqBoN+GnN0tQ
         9gcDZIKzEldngTu9SfuRjmS/nxr5cqa2g5Dt+CDm7zkdhPNZTmIMTboCdlPMw5ZbsJve
         WJ6HQ8BXJSoZhHqaf/KOZ4CfzTAsZ4r9zhlaTQzmReERTEM1aXf1XnEDk2Ug69yVKt1A
         /EOfX51BDyrHUxGfBeg1ZnIw1we6W0mvtRQSF6I6DNbnLmye9LLAl94cdMoF1yokkhzx
         2BlG3xEYQtEPCdAcZHZ/dYbtWjiFYnkvOCXmBvM6IvCmJ/caci+JjfY4gqMjf/F/3+gQ
         CxLg==
X-Gm-Message-State: AOAM530X8XU7DJ87cjeXPNU5+FyibDAdLFoC9YjD67oIhWoS1B6s87ys
        2cLNDFDxG3knSyxhWLuCya6Rgg==
X-Google-Smtp-Source: ABdhPJxCXjHgzhDNxCo74pxi0w4+LVa2A7jLYPizUTbAtyvC5KC0s+vQBXERvfwyODnW9CVghaXblw==
X-Received: by 2002:a65:46c9:: with SMTP id n9mr17358686pgr.116.1615149699643;
        Sun, 07 Mar 2021 12:41:39 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:ac1a])
        by smtp.gmail.com with ESMTPSA id 17sm4498213pfb.71.2021.03.07.12.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 12:41:38 -0800 (PST)
Date:   Sun, 7 Mar 2021 12:41:36 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     osandov@fb.com, linux-block@vger.kernel.org, bvanassche@acm.org
Subject: Re: [PATCH blktests v2] tests/srp/rc, tests/nvmeof-mp/rc: add fio
 check to group_requires
Message-ID: <YEU6gBo0o8KA1QuF@relinquished.localdomain>
References: <20210307163142.6918-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307163142.6918-1-yi.zhang@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 08, 2021 at 12:31:42AM +0800, Yi Zhang wrote:
> Most of the srp and nvmeof-mp tests need fio, we need add fio
> check before running the tests
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
> v2: update to based on Bart's patch
> [PATCH blktests v2] rdma: Use rdma link instead of
> /sys/class/infiniband/*/parent
> ---
>  tests/nvmeof-mp/rc | 2 +-
>  tests/srp/rc       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks, applied.
