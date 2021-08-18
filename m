Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56179C43214
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 22:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41752610D2
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 22:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhHRWyk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 18:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhHRWyk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 18:54:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA779C0613D9
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 15:54:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n12so2804268plf.4
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bdg/OtOV5wymBEUwuQlX5+GK5JjmwLGgSiZ+Tmmadzg=;
        b=bGU4j745GyvuoiOCvJ9XjMdyezUrxYO1pPcd3Nh9uTw2AHyNof0gLDjkyhM8xE1bpY
         ZhK4WiLLT0bHAnhPZz+LIR1+EgOwNsqitav2SEBVEKiVfgPXmLnjjumcy0TFltdAkpUp
         +Y/iv2y66lHJkcJw8yDjHLrdQLAKo5xhCntkA7/YsKW0wiAtv4Qvj7Ok2yu75nvP5VG/
         kQ33sD5kcz6G3nunSMjMr3GEhOael40I5f0/SkDnOprQdLkOYlZpBPRnAiPwJ3is8bPU
         tVhgUeDxPTVKaaCpoehLowvGyCLbirnVXNHyIzEPJxHcN9722SczInchAhVN3qboCzK5
         oo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bdg/OtOV5wymBEUwuQlX5+GK5JjmwLGgSiZ+Tmmadzg=;
        b=ZlGewXIl8o8V4c9iUguviDIetC36uoMUjhEJ8UOghEiVp+oPzWVR0R5X4ClqCAxFvF
         ijSZbL9yOdPEuEsbu6PBTPnTzgZm4rIpDJiwsh7PWW9MKsKj31MXdST1Z1MaihKii12V
         euxlWZ6dgYSNabE1AG6Q9pcfGPmXjDkbW/1qtVjxD7zDakvt+YyAAIv7a2SwH7VbJDzy
         PyCYKcSZfvotELCH0Fw2BONecXv2aMeqlmBd/1hMTPcHDCtAI+fWOQK8v7ddW6ZKJ8wM
         QX4jTyucWo9B5K+i4UW7x2ilMG/FqwnD3qhlZHYBwYWdw40QndkugwpYpeJfd9abcH86
         a6xg==
X-Gm-Message-State: AOAM532+LCSKMpNO1N9JValg0BthbP1xzuLOBVarWxFx/wpQPqnwv9jR
        g8/IpOfih6mCuKc+N3eRwSNLtg==
X-Google-Smtp-Source: ABdhPJzzXby04WbbyigGFBDREGEkGV8RqUxAeMQ0ojYzJgYocP/xgVxlZiD/Hh9heqjmIsz5yKhdZw==
X-Received: by 2002:a17:90a:af88:: with SMTP id w8mr11746328pjq.104.1629327244194;
        Wed, 18 Aug 2021 15:54:04 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s26sm894895pgv.46.2021.08.18.15.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:54:03 -0700 (PDT)
Date:   Wed, 18 Aug 2021 22:53:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 53/63] KVM: x86: Use struct_group() to zero decode
 cache
Message-ID: <YR2PhlO3njPcFOkg@google.com>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-54-keescook@chromium.org>
 <YR0jIEzEcUom/7rd@google.com>
 <202108180922.6C9E385A1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108180922.6C9E385A1@keescook>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021, Kees Cook wrote:
> On Wed, Aug 18, 2021 at 03:11:28PM +0000, Sean Christopherson wrote:
> > From dbdca1f4cd01fee418c252e54c360d518b2b1ad6 Mon Sep 17 00:00:00 2001
> > From: Sean Christopherson <seanjc@google.com>
> > Date: Wed, 18 Aug 2021 08:03:08 -0700
> > Subject: [PATCH] KVM: x86: Replace memset() "optimization" with normal
> >  per-field writes
> > 
> > Explicitly zero select fields in the emulator's decode cache instead of
> > zeroing the fields via a gross memset() that spans six fields.  gcc and
> > clang are both clever enough to batch the first five fields into a single
> > quadword MOV, i.e. memset() and individually zeroing generate identical
> > code.
> > 
> > Removing the wart also prepares KVM for FORTIFY_SOURCE performing
> > compile-time and run-time field bounds checking for memset().
> > 
> > No functional change intended.
> > 
> > Reported-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Do you want me to take this patch into my tree, or do you want to carry
> it for KVM directly?

That's a Paolo question :-)

What's the expected timeframe for landing stricter bounds checking?  If it's
5.16 or later, the easiest thing would be to squeak this into 5.15.
