Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CD2C43214
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 16:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57E1610F8
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 16:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhHRQYV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 12:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhHRQYU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 12:24:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29652C0617A8
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 09:23:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t42so93506pfg.12
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lzxrYwRed6/SHUIlGR9aHlXsbeq7ptb+9qbS8mhHK50=;
        b=fura/iwYKWm9fOvME7hDJZpdSUriPdavtTAkVSOa2xX2KIJSCfPM5f5hHBRLOMJNVT
         C8TmP9pJ5g75mnmQqILjYelAMhhcB8O1+9CANIGbBKb70hbHj+BTAlOIr9GgVz3exTF9
         TFhO4TYp+OCnRkeKSARpNajf1uSPwfn4T3qQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lzxrYwRed6/SHUIlGR9aHlXsbeq7ptb+9qbS8mhHK50=;
        b=QRfDnnauebbIPn2Ihglg/TsmaqazvsEsyWVvfiU2kX424Bl4Kl7jx1Qxoy24nJAZ06
         Ttsrk3rjpqcLmnlVz1wWz6x7/bz/yruGNjbVi6dCfu6Ozhj8ZMAFd4OfFmI1ieQI38yQ
         7x+ny8dx0M6CSWVRR/WMPnZznE7tX7BzqZ4epL5R5jOrnfH1X/0+O20n1zqYujxMRxoq
         /FFn/w/GiP/hOVIKiA5X7jBEiwyqqyOTxqYJq2wS5N4B7y8QbGHKzFptGYSOtnaeKExK
         K0C9pHDwFBUTi/yr1djflBiOGry0vPpwRdb8Eou8kELZ34h6outPH42EcwpJyBF9zHvo
         8cXA==
X-Gm-Message-State: AOAM530+9vfuEcF+jR2dUezYpiiE55zeR/nY+4Zea/xcQaagLlIi/PdA
        SPsIZk1voUu5mH6I4vDyTiPSHQ==
X-Google-Smtp-Source: ABdhPJzGCFU36ZNXujVZMcFiVgKIOCzcVTQ3pkemk0SBlaxknrWVUml2zyNulYLYNdDFzcgK5LoaRw==
X-Received: by 2002:aa7:80d9:0:b029:2ed:49fa:6dc5 with SMTP id a25-20020aa780d90000b02902ed49fa6dc5mr10058545pfn.3.1629303824757;
        Wed, 18 Aug 2021 09:23:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 21sm228958pfh.103.2021.08.18.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:23:44 -0700 (PDT)
Date:   Wed, 18 Aug 2021 09:23:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sean Christopherson <seanjc@google.com>
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
Message-ID: <202108180922.6C9E385A1@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-54-keescook@chromium.org>
 <YR0jIEzEcUom/7rd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR0jIEzEcUom/7rd@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 03:11:28PM +0000, Sean Christopherson wrote:
> On Tue, Aug 17, 2021, Kees Cook wrote:
> >  arch/x86/kvm/emulate.c     |  3 +--
> >  arch/x86/kvm/kvm_emulate.h | 19 +++++++++++--------
> >  2 files changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > index 2837110e66ed..2608a047e769 100644
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -5377,8 +5377,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
> >  
> >  void init_decode_cache(struct x86_emulate_ctxt *ctxt)
> >  {
> > -	memset(&ctxt->rip_relative, 0,
> > -	       (void *)&ctxt->modrm - (void *)&ctxt->rip_relative);
> > +	memset(&ctxt->decode_cache, 0, sizeof(ctxt->decode_cache));
> >  
> >  	ctxt->io_read.pos = 0;
> >  	ctxt->io_read.end = 0;
> > diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> > index 68b420289d7e..9b8afcb8ad39 100644
> > --- a/arch/x86/kvm/kvm_emulate.h
> > +++ b/arch/x86/kvm/kvm_emulate.h
> > @@ -341,14 +341,17 @@ struct x86_emulate_ctxt {
> >  	 * the rest are initialized unconditionally in x86_decode_insn
> >  	 * or elsewhere
> >  	 */
> > -	bool rip_relative;
> > -	u8 rex_prefix;
> > -	u8 lock_prefix;
> > -	u8 rep_prefix;
> > -	/* bitmaps of registers in _regs[] that can be read */
> > -	u32 regs_valid;
> > -	/* bitmaps of registers in _regs[] that have been written */
> > -	u32 regs_dirty;
> > +	struct_group(decode_cache,
> 
> This is somewhat misleading because half of this struct is the so called "decode
> cache", not just these six fields.
> 
> KVM's "optimization" is quite ridiculous as this has never been such a hot path
> that saving a few mov instructions would be noticeable.  And hilariously, the
> "optimization" is completely unnecessary because both gcc and clang are clever
> enough to batch the first five into a movq even when zeroing the fields individually.
> 
> So, I would much prefer to go with the following:

Sounds good to me!

> 
> From dbdca1f4cd01fee418c252e54c360d518b2b1ad6 Mon Sep 17 00:00:00 2001
> From: Sean Christopherson <seanjc@google.com>
> Date: Wed, 18 Aug 2021 08:03:08 -0700
> Subject: [PATCH] KVM: x86: Replace memset() "optimization" with normal
>  per-field writes
> 
> Explicitly zero select fields in the emulator's decode cache instead of
> zeroing the fields via a gross memset() that spans six fields.  gcc and
> clang are both clever enough to batch the first five fields into a single
> quadword MOV, i.e. memset() and individually zeroing generate identical
> code.
> 
> Removing the wart also prepares KVM for FORTIFY_SOURCE performing
> compile-time and run-time field bounds checking for memset().
> 
> No functional change intended.
> 
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Do you want me to take this patch into my tree, or do you want to carry
it for KVM directly?

Thanks!

-Kees

> ---
>  arch/x86/kvm/emulate.c     | 9 +++++++--
>  arch/x86/kvm/kvm_emulate.h | 6 +-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 2837110e66ed..bf81fd017e7f 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -5377,8 +5377,13 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
> 
>  void init_decode_cache(struct x86_emulate_ctxt *ctxt)
>  {
> -	memset(&ctxt->rip_relative, 0,
> -	       (void *)&ctxt->modrm - (void *)&ctxt->rip_relative);
> +	/* Clear fields that are set conditionally but read without a guard. */
> +	ctxt->rip_relative = false;
> +	ctxt->rex_prefix = 0;
> +	ctxt->lock_prefix = 0;
> +	ctxt->rep_prefix = 0;
> +	ctxt->regs_valid = 0;
> +	ctxt->regs_dirty = 0;
> 
>  	ctxt->io_read.pos = 0;
>  	ctxt->io_read.end = 0;
> diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> index 68b420289d7e..bc1fecacccd4 100644
> --- a/arch/x86/kvm/kvm_emulate.h
> +++ b/arch/x86/kvm/kvm_emulate.h
> @@ -336,11 +336,7 @@ struct x86_emulate_ctxt {
>  		fastop_t fop;
>  	};
>  	int (*check_perm)(struct x86_emulate_ctxt *ctxt);
> -	/*
> -	 * The following six fields are cleared together,
> -	 * the rest are initialized unconditionally in x86_decode_insn
> -	 * or elsewhere
> -	 */
> +
>  	bool rip_relative;
>  	u8 rex_prefix;
>  	u8 lock_prefix;
> --
> 2.33.0.rc1.237.g0d66db33f3-goog
> 
> > +		bool rip_relative;
> > +		u8 rex_prefix;
> > +		u8 lock_prefix;
> > +		u8 rep_prefix;
> > +		/* bitmaps of registers in _regs[] that can be read */
> > +		u32 regs_valid;
> > +		/* bitmaps of registers in _regs[] that have been written */
> > +		u32 regs_dirty;
> > +	);
> > +
> >  	/* modrm */
> >  	u8 modrm;
> >  	u8 modrm_mod;
> > -- 
> > 2.30.2
> > 

-- 
Kees Cook
