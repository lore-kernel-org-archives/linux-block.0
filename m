Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FF4C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 13:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2417C20823
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 13:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z1SifWi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgFDNXK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgFDNXK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 09:23:10 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1102DC08C5C3
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 06:23:09 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w9so5155722qtv.3
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zd56CSP9N2M4FrfN9ySWd7Nzjr+sOLOVU8sX9ZsvxYk=;
        b=Z1SifWi8Glj9s1ZlViEQIoOzrtW4kQqhJPAuBmH8BuAfTlSORzOP5/aBkVIpDCF065
         4tet6nf/xexKbX9HERYTEiH7bvvMa7jEzJZJ+Y9NbTVNdXZMe5cuQGHU5U8XYpc6rEpA
         0M5eGOL/GQzV1R+AsSeBTDbzXk+YExg+XOlZLmxAbhKhBOAjkHQZ06AbVHRZdzvZiU7w
         cHe+L3V8vNXxybekuzSoIvOp1xxWvK8SbdjJVplyLz5vYnbOtUIAIDcZULCyq5qUdBWf
         hegDa8ghfSlITKfZUXou8d2OJHz3pI/kZh5/E9mjrrfnPUc08cS9ulbxQPmbEBYY1pID
         +u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zd56CSP9N2M4FrfN9ySWd7Nzjr+sOLOVU8sX9ZsvxYk=;
        b=VW8MZu7FmDLYgY0rzO1+Uv8tljppiimDjPdgiaRNkAHH2Gr9RDe19eNXQhvI3reFUE
         Rh6T3JfSHKv3toARLL2GKtUYil23Gb5SIjhCKS8NI9BhREcTbazf9OqB+dcR03jncTEL
         mO1bGuKKD4HuCasoogTFZZzMPq+uppVi2AMQ01bAG7Ieb4R65EJqlUxxNdu/7o+KDmjO
         9VxZc4w6TR9fEcgSdiZvQUJ0/ZrH1VmV66CVEaJG+Mqikb8mF1/uDBS8y/spKP0FC2IJ
         cs4cHRNfyz43fAoUvdzK8iw0SKXPoHUvS0GOshWXxA8jGlVS9sLWrZthbufFsWEpq1kD
         I4xQ==
X-Gm-Message-State: AOAM533WKMO6awyYBS0Yfd6xiPQs2fOxTDdRq35mSdf+MWmuBFcvUkod
        cW27bhpqeRPIz3H1Ym5vTKFnxg==
X-Google-Smtp-Source: ABdhPJxRZn/pXIUEkZhANETiTogTGf06kqn6Gs1x5NZFGFUPmFe5McyxpBqwN0tWHmbj+GOZ4kP/eQ==
X-Received: by 2002:aed:3fa5:: with SMTP id s34mr4444014qth.343.1591276988114;
        Thu, 04 Jun 2020 06:23:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 126sm4330150qkj.89.2020.06.04.06.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 06:23:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgppq-001CIj-Sr; Thu, 04 Jun 2020 10:23:06 -0300
Date:   Thu, 4 Jun 2020 10:23:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
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
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 09/10] treewide: Remove uninitialized_var() usage
Message-ID: <20200604132306.GO6578@ziepe.ca>
References: <20200603233203.1695403-1-keescook@chromium.org>
 <20200603233203.1695403-10-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603233203.1695403-10-keescook@chromium.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 03, 2020 at 04:32:02PM -0700, Kees Cook wrote:
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings
> (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> either simply initialize the variable or make compiler changes.
> 
> I preparation for removing[2] the[3] macro[4], remove all remaining
> needless uses with the following script:
> 
> git grep '\buninitialized_var\b' | cut -d: -f1 | sort -u | \
> 	xargs perl -pi -e \
> 		's/\buninitialized_var\(([^\)]+)\)/\1/g;
> 		 s:\s*/\* (GCC be quiet|to make compiler happy) \*/$::g;'
> 
> drivers/video/fbdev/riva/riva_hw.c was manually tweaked to avoid
> pathological white-space.
> 
> No outstanding warnings were found building allmodconfig with GCC 9.3.0
> for x86_64, i386, arm64, arm, powerpc, powerpc64le, s390x, mips, sparc64,
> alpha, and m68k.

At least in the infiniband part I'm confident that old gcc versions
will print warnings after this patch.

As the warnings are wrong, do we care? Should old gcc maybe just -Wno-
the warning?

Otherwise the IB bits look ok to me

Acked-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
