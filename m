Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF17C43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 19:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiFZTod (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 15:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiFZToc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 15:44:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA10DE6;
        Sun, 26 Jun 2022 12:44:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so10279423edm.13;
        Sun, 26 Jun 2022 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=74vKUR9P0PfhWnNbmRpmSz+FzncXcOsWOCMYdktEcSc=;
        b=D3bVQQO+7CV4+y1Y6o3F/1IfLdydA1DV3yPXOz37bcqcmCS3Tk95WPS0zcpA5mJLPl
         8vhkhDoOEXa6Xz8uEHInuJMRlgBiWTBPNgJXSyDo1voXwfo1CbchCJnUnfctgozyFUZv
         oUsoxMgrMY6GafVjmLDZMSxo5Yk/+Nw1bXNtsHe9ekbltnwvn7V70ho4GlBiOXMF925p
         W3x1JdvjdkD5HnhyHTbXIZhAfbwlG/iI/Rz1nvNL47hjsQXdHpsbIkHkcMkNosdyEUz0
         Ds5drsPsNhEH2aoslanpoICR1XhV3l14Fu5PSIphyiNyGqZIm87vYWL0TA84mKSDF+Tc
         Kj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=74vKUR9P0PfhWnNbmRpmSz+FzncXcOsWOCMYdktEcSc=;
        b=TiWY3aYW3ayPg34FGunJEi+ugq6Iuu6Q/DFiQBnDgUKfGx4osmWe+O53eYwvc2L12k
         3Jbyw+ofLAp/hDEEP10N0+S9xQirvG56ml54ZmMoUAxYQlowlKBD+SB5/YYylLiA+1pi
         xuwkHuTo7bN+GWyefjfCGDZtZvXAZ5zu72ey5akB2aCuLrmTV1tN90XEJFpwvBOKWqLQ
         CRxHScglCcpyafebdpnyNINGWoJeg3SdoQZrJdXF+UL9fHMarq7vJ+SKXL5ooAgsBBi/
         NKOPauIbklUPrTuk/AMvYJ12QpmEwYc7TIMNTTWRyOdRBXF/Xkn4/jAyvA/G9AdUGqqg
         W9yg==
X-Gm-Message-State: AJIora/ss4gR2NdbzTT1HC4WHcsDDc0AgONwZqgQ5GOn8hDdESYg8Nqj
        7jfyC0pI1eH2qFHeuc3yJT0=
X-Google-Smtp-Source: AGRyM1tFbBdg5Quq5PwZc0cXeuaL2+j07fHbcWZKGyoNNod0CEFQFntHKVlEsdVp9Fi0m4/LOTEZXw==
X-Received: by 2002:a05:6402:4387:b0:435:94c6:716d with SMTP id o7-20020a056402438700b0043594c6716dmr12928630edc.298.1656272670209;
        Sun, 26 Jun 2022 12:44:30 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906671200b00718e4e64b7bsm4108424ejp.79.2022.06.26.12.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 12:44:29 -0700 (PDT)
Date:   Sun, 26 Jun 2022 21:44:28 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Message-ID: <20220626194428.qffkjds5tpzty5vh@mail>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-52-bvanassche@acm.org>
 <20220624045613.GA4505@lst.de>
 <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
 <20220625092349.GA23530@lst.de>
 <3eed7994-8de2-324d-c373-b6f4289a2734@acm.org>
 <20220626095814.7wtma47w4sph7dha@mail>
 <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 26, 2022 at 09:33:57AM -0700, Linus Torvalds wrote:
> On Sun, Jun 26, 2022 at 2:58 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > What about I would add to sparse something to strip away the bitwise/
> > recover the underlying type? Something like __unbitwiseof() or
> > __underlying_typeof() (some better name is needed)?
> 
> Please no, we don't want to make random macros have to have sparse
> logic in them when it's not actually sparse-related.
> 
> I think it would be better if sparse just recognized some of these
> kinds of situation. In particular:

Yes, sure, it's ideal.
 
>  (a) for the casting part, I actually suspect we should drop the
> warning about castign integers to restricted types.
> 
> Note that this is actually one of the main causes of "__force" use in
> the kernel, with code like
> 
>         VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
>         VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
>         VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
>         VM_FAULT_WRITE          = (__force vm_fault_t)0x000008,

This example is about an enumeration. It's, IMO, a very special case
in its own. Two years ago or so, I had proposed to have 'bitwise'
enums where the cast was not needed. In itself is was very easy to do
but there was a lot of subtle issues about type attributes. I think
I've since solved these issues but on the way I've lost my motivation
for these bitwise enums. I'll take a look at it again.
 
> and I think that we could/should just say that "explicit casts of
> constants are ok".

I'm not convinced, for example when thinking about __be{16,32}.
But on the principle, I fully agree: unneeded casts should be avoided.
 
> That would remove two of the four warnings right there, and probably
> make bitwise types more convenient in general.
> 
> We already treat "0" as special (because for bitwise things, zero is
> kind of the universal constant), and we should continue to warn about
> _implicit_ casts of restricted types, but I think the use of "__force"
> in the kernel does show that the explicit casts are probably a bad
> idea.

Yes.

>  (b) I think we could also recognize "comparison of constants" to be
> something that doesn't necessarily require a warning.
> 
> And here in particular the "compare with zero" and "compare with all
> bits set" - which is exactly that "-1" case.
>
> In fact, there's a very good argument that "-1" is as special as zero
> is ("all bits set" vs "all bits clear"), so for that (a) case, I think
> at a _minimum_ we shouldn't warn about that particular constant.
> 
> So I think we could silence this sparse warning entirely, without
> really introducing any new syntax, and actually improving on how
> bitwise works.

Yes, indeed.

-- Luc 
