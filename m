Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459CCC433E5
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2540720663
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 17:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyfkzOIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgFVRAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbgFVRAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 13:00:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FB6C061796
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2020 10:00:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b5so8408140pgm.8
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2020 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BGCSUQL5tzelRNBUzUtnoDU4FBOgbBEZDAqmf1y2tY=;
        b=qyfkzOIs3IOcHqZGIEiR8JGq0nJVsevXD15ku29SFyXssZXEUC3c86hg9Gv/KJ2BHe
         y3Hp8Hq1zqOS9OOFR3gNNpt0Qv7Nm37wmlte3OKeZWdMeR9NA90wXNwkm6gxb1GWESrg
         FV+TpCchSKop95+zTyCexbHOPt326ZBObp2o6QnHWx5CQujP1LVI+R0x75IanRkYHnnq
         8sIguoxvjbcrJCtaYT0jWDLSWi2vPjWi4gWLpfFDTJyQet65QDVBdYYTPy34m1tTALHH
         MyJ02UqH4YfMYS1tNdV8DEY2h1OHgS9vwRBU8tnsCUN5ZqCoUAJ9paYX1bhDXSLYsgvR
         L24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BGCSUQL5tzelRNBUzUtnoDU4FBOgbBEZDAqmf1y2tY=;
        b=XhDcdflrW/QCFVv5UYh8xCE8MbTaaI5jbFqmg/z8ecndnJpZ/e69CkNvI3AO4py/1R
         zNKyOqEBT3EPmnK8En+MTQg8PLIAmyY1933mqHomRJgHV/OTEPie10MDCUPfBIAh7tZf
         OXVZ1v+S87TEEoW2h2xZozVlr1zMCMNIh0o7pq7qDw4NI4ps45TMdYHsBqUUAJ++5Es9
         8ckQYRvFrmqR/1dC67DfmkXR8voZ7XoIYMkzut0S20MLoGFp/boyyzRZc5vZKRLxoM+t
         /1QAYa4ZD1msXQ79wB5VTmgzfcH/3STzYRWG1+FA91+YuUHxP82TU+aV6vF0Z+gPsdY9
         HDGA==
X-Gm-Message-State: AOAM532s6B1oSqvzxhXOUOl6Gv7xju70OV0Dgz1nQS0DF4rXVSOWRZzf
        PfkF6pS2gro2Q+CouCw+aUF86hpn0geuGfR5tdLv4w==
X-Google-Smtp-Source: ABdhPJzRctk7sbdkIMQOmqVpecK2ZcMwEAt3JEckAnE+NdDNoij2Ixhlu/aU/MySqDydTtISB1suO3tr/npvXJ5DjBc=
X-Received: by 2002:aa7:9abc:: with SMTP id x28mr21131306pfi.39.1592845205633;
 Mon, 22 Jun 2020 10:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200620033007.1444705-1-keescook@chromium.org> <20200620033007.1444705-2-keescook@chromium.org>
In-Reply-To: <20200620033007.1444705-2-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jun 2020 09:59:54 -0700
Message-ID: <CAKwvOd=a+aSb5Scg=jD-jDfvnKJjOCVQ8CidgEo-39g2b2z-3A@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] docs: deprecated.rst: Add uninitialized_var()
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org,
        Network Development <netdev@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 19, 2020 at 8:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> Nothing should be using this macro, and the entire idea of tricking the
> compiler into silencing such warnings is a mistake.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Documentation/process/deprecated.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 652e2aa02a66..943a926ecbbb 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -51,6 +51,24 @@ to make sure their systems do not continue running in the face of
>  "unreachable" conditions. (For example, see commits like `this one
>  <https://git.kernel.org/linus/d4689846881d160a4d12a514e991a740bcb5d65a>`_.)
>
> +uninitialized_var()
> +-------------------
> +For any compiler warnings about uninitialized variables, just add
> +an initializer. Using the uninitialized_var() macro (or similar
> +warning-silencing tricks) is dangerous as it papers over `real bugs
> +<https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/>`_
> +(or can in the future), and suppresses unrelated compiler warnings
> +(e.g. "unused variable"). If the compiler thinks it is uninitialized,
> +either simply initialize the variable or make compiler changes. Keep in
> +mind that in most cases, if an initialization is obviously redundant,
> +the compiler's dead-store elimination pass will make sure there are no
> +needless variable writes.
> +
> +As Linus has said, this macro
> +`must <https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/>`_
> +`be <https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/>`_
> +`removed <https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/>`_.
> +
>  open-coded arithmetic in allocator arguments
>  --------------------------------------------
>  Dynamic size calculations (especially multiplication) should not be
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200620033007.1444705-2-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
