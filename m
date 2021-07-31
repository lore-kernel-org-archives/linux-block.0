Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A9BC43214
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 15:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BC860F56
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 15:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhGaPK3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 31 Jul 2021 11:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbhGaPK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Jul 2021 11:10:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00B3C061798
        for <linux-block@vger.kernel.org>; Sat, 31 Jul 2021 08:10:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z3so13279226plg.8
        for <linux-block@vger.kernel.org>; Sat, 31 Jul 2021 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lfME4cjM5NCmgici7VQUeLVxABhRdomGydOStVoPzx4=;
        b=L1DNvP8P4y6KQNKh86u6z0gd+tOQyO7mJoJt8B2bk6sGD8lMj6Noy13eCNQYPK3Dgy
         aDVIvQEK9ubu5kah/3TCTRHCNGkVaZuPiLrC8xqR8E3ktJaFvicJZgoCG3Pk4ob+PTGz
         EpAjtcymW/wEeRKic3KicM0N2mM2qfw23QKRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lfME4cjM5NCmgici7VQUeLVxABhRdomGydOStVoPzx4=;
        b=BRxOFFeC2zf7Tm0ibwLM1nh7EowWQqiHYrr5SQGy82Yf2WWEsZXrFYvCIvCO3GfffP
         Mf2gpRxp8QomqsF1mi4Mp0rKFD4sgB22wMOe6FoF5QTOBaJflF78wVR8fMog+UApLqmZ
         7Y0YMfuFuQW/VA0Mn2yrRN3r54oKpR5gOsAlbYE3qxRhjfayV9JZKXEx1eQhu9k67m2e
         Rg2dFEb7JcOiZRMQqZ/pLF/EunZHSyJmg6Q5f9hG4zeSroJrmfx9QkLDYEkTnaANzPMe
         aZ1jIvOCVkSgDpUWG+tFH1+XNwbgnuB/+ZWNete4GjjNaBe5B/nJ5DI1SBMoZjtxh//b
         iEVw==
X-Gm-Message-State: AOAM532X99Sj2MBwep2pZSd+1D80Nop4GJKNcWoVLMPJa6vbpLtfTgrc
        oPL5din0VrZxzLP+r4TQB5Odtg==
X-Google-Smtp-Source: ABdhPJyHVa4d8FlEw//xZVgbZjv62jZZqTBJVRdefEHg8GdXxlxk+maNXdDjshUpKLrxricctBpEKw==
X-Received: by 2002:a05:6a00:1488:b029:332:5e67:1198 with SMTP id v8-20020a056a001488b02903325e671198mr8347873pfu.9.1627744222329;
        Sat, 31 Jul 2021 08:10:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1sm891630pgt.63.2021.07.31.08.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 08:10:21 -0700 (PDT)
Date:   Sat, 31 Jul 2021 08:10:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>, keithpac@amazon.com,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        gustavoars@kernel.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 04/64] stddef: Introduce struct_group() helper macro
Message-ID: <202107310806.CD5D546DB7@keescook>
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-5-keescook@chromium.org>
 <41183a98-bdb9-4ad6-7eab-5a7292a6df84@rasmusvillemoes.dk>
 <202107281456.1A3A5C18@keescook>
 <1d9a2e6df2a9a35b2cdd50a9a68cac5991e7e5f0.camel@intel.com>
 <202107301952.B484563@keescook>
 <CAKwiHFheDv2pwsm6Fa+-KnOFyvk7bfZQjb2BQ-CSwH61gxgVYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwiHFheDv2pwsm6Fa+-KnOFyvk7bfZQjb2BQ-CSwH61gxgVYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 31, 2021 at 07:24:44AM +0200, Rasmus Villemoes wrote:
> On Sat, Jul 31, 2021, 04:59 Kees Cook <keescook@chromium.org> wrote:
> 
> > On Fri, Jul 30, 2021 at 10:19:20PM +0000, Williams, Dan J wrote:
> > > On Wed, 2021-07-28 at 14:59 -0700, Kees Cook wrote:
> >
> > >  /**
> > >   * struct_group(NAME, MEMBERS)
> > >   *
> > > @@ -67,7 +73,10 @@ enum {
> > >   * @NAME: The name of the mirrored sub-struct
> > >   * @MEMBERS: The member declarations for the mirrored structs
> > >   */
> > > -#define struct_group(NAME, MEMBERS)    \
> > > +#define struct_group(NAME, MEMBERS...) \
> > >         struct_group_attr(NAME, /* no attrs */, MEMBERS)
> > >
> > > +#define struct_group_typed(TYPE, NAME, MEMBERS...) \
> > > +       struct_group_attr_typed(TYPE, NAME, /* no attrs */, MEMBERS)
> > > +
> > >  #endif
> >
> > Awesome! My instinct is to expose the resulting API as:
> >
> > __struct_group(type, name, attrs, members...)
> >
> > struct_group(name, members...)
> > struct_group_attr(name, attrs, members...)
> > struct_group_typed(type, name, members...)
> 
> Bikeshed: can we use proper nomenclature please. s/type/tag/,
> s/typed/tagged.

Ah! Thank you. I went looking for the spec on what these are called and
couldn't find it. "struct $tag" is the type, then, yes? So IIUC now:

       |    type   | members  | name
       |       tag
	struct foo { int bar; } baz;

-- 
Kees Cook
