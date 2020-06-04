Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F159C433DF
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 01:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF52207D0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 01:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AbKWjJtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgFDBom (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 21:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgFDBom (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 21:44:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7323C08C5C3
        for <linux-block@vger.kernel.org>; Wed,  3 Jun 2020 18:44:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so1729218pfw.10
        for <linux-block@vger.kernel.org>; Wed, 03 Jun 2020 18:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wpybr1+0oFA6UqMQJBfZL+PEEh3VzZMl9GH1YHu1354=;
        b=AbKWjJtgEgSZdlRzZpINmLHh+V8xJj2UZ2odKQ2c5ZSQmdk1BLZaB0K4agCmc9jSmi
         AAmX5SqtRhMCVwb4wbdCeXmP+MI0pU+26rg/PWtbK/suB70n8LKxY+RL9wU3Qn6Y4nm2
         zGn/UOyM2NglkPBkMHcXSP1vQ8Fpyy930e1GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wpybr1+0oFA6UqMQJBfZL+PEEh3VzZMl9GH1YHu1354=;
        b=pyz3xC/ePUpF8ifHD+3THJzsISPf2cke7Z0J5cQDunY8hJBJY4tV3Q13l4H6oCWktB
         g6JRHLoQwtUinVc0h1H8zu2mWBkTEW91TnQyo0y1QQ3i74rZUxdDNeTpYWQ2JbNhmxLD
         Zcukitr369mpxRxwskAA3Gz7oWGrx5dz7ZzyD4GcVr5Oi+n4bqVSvVqs9gIjDw8Wxrpk
         vJ4ra4WJj24xQodxsVVevz08tJrBJHdPITZ8TW0aH7PU3q7UPBTNkqpa+/WCyuJQDymm
         Q+r4GV7nQFAHLCMCevAKc0W2FaedNN5m1D3nWieOAJndRteia6i+7OIZrkWXqewq/UhS
         z7QA==
X-Gm-Message-State: AOAM531xqsrkyQ8xPJCuHzsAxevidwOs9UOmYS2ZqAXILZ2P0KvhyReI
        sfQfW31VB4qGGF7Lf07NsmqpuA==
X-Google-Smtp-Source: ABdhPJw6n1UeZs2KwVXXpsKVlKB/eX8l0Vu/Wi69L010BRhnAwssMdnRSJ//zeA4lceo/p+HCVbgnA==
X-Received: by 2002:a63:5f90:: with SMTP id t138mr2082803pgb.122.1591235081380;
        Wed, 03 Jun 2020 18:44:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i21sm2541029pgn.20.2020.06.03.18.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 18:44:40 -0700 (PDT)
Date:   Wed, 3 Jun 2020 18:44:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 00/10] Remove uninitialized_var() macro
Message-ID: <202006031840.E2F0D15D8B@keescook>
References: <20200603233203.1695403-1-keescook@chromium.org>
 <CA+icZUVZwjM9o7aNXAkYu8K2BQAajw=60varP4g+NizCqu5gRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVZwjM9o7aNXAkYu8K2BQAajw=60varP4g+NizCqu5gRw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 04, 2020 at 03:23:28AM +0200, Sedat Dilek wrote:
> what is the base for your patchset?

Hi! This was actually on Linus's latest tree (which is basically -next),
mostly because I figured this might be a bit of an RFC but if it was
clean enough, it might actually make the merge window (I can dream).

> I would like to test on top of Linux v5.7.
> 
> Can you place the series in your Git tree for easy fetching, please?

Sure! https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git in
the kspp/uninit/v5.7/macro branch. There were three small differences.
I'm doing the "all my cross compilers allmodconfig" build run now, but
figured I'd push it for you now so you didn't have to wait.

-- 
Kees Cook
