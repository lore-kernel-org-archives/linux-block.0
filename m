Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836CEC4320E
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 04:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6769E60F13
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 04:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhGaEUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 31 Jul 2021 00:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhGaEUk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Jul 2021 00:20:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54796C0613D5
        for <linux-block@vger.kernel.org>; Fri, 30 Jul 2021 21:20:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nh14so6288766pjb.2
        for <linux-block@vger.kernel.org>; Fri, 30 Jul 2021 21:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2rZ9kzapSn9AYE0eMMnwGkMNI7xYc/vEgm+TA1Yc3wc=;
        b=kzkctvvNb0ShS1nE2Wqqqn7Z+lkc9IkqCaSxgDE+W4cNa7ElmV6eqi/hsxBTgUGOT7
         yT40vj00aRlu1HRv6Mtup3+uZulpZ8P1kroGaDVwv4G3QErDjEpyR+stG1AW6mrMBIrR
         OJ3iwnlXAm7Yt6bm3VvVwhqzyglWUXeDjxPZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2rZ9kzapSn9AYE0eMMnwGkMNI7xYc/vEgm+TA1Yc3wc=;
        b=Z0GWkuXZo1EqcyLjx2Il91dN5V12SW0hmSmfrn5DqwhbMM1aKl/avfjFWClkZ52c/D
         pnHlnwQL4RlmEq21H0nQzkopyEHv6MpsKhg4bnIEc2fOXdqR2iqi1pQBZnQQbRgzJoJN
         XbPOJr+7/FJXpLsviLblqSnR0Cql6glH2TVaiZoNNTY20giaixcApqi17PcoTkLPJkqm
         TivAfqrbkfcIeGJn6RQSYlZgtNnbr9urw1WZ6qppFeWn3mWxEFGf9Gd/DZB6PENLbhf2
         ZfoqOZklCNbmH1Df4uNrayPHotR1nkj3QcOnQ+Ab3eCdu34DZZOqtBm5HBONF/wuIXmV
         O+Ig==
X-Gm-Message-State: AOAM531gTWnbSAEVigUvcVKCySh1p9EBLvQGIL13qXxXSgekr1NILwxY
        hgEBBOYLtzjsXXdXJHwPlMk6fg==
X-Google-Smtp-Source: ABdhPJzZaza126Vv3WlcT6KBKm6/ibQnq8c34Xqn2AoVgq2DTgH6cZz+KdKXk9j+VMHkrcs62jXe1w==
X-Received: by 2002:a17:90b:110c:: with SMTP id gi12mr6515447pjb.163.1627705233841;
        Fri, 30 Jul 2021 21:20:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w18sm4094035pjg.50.2021.07.30.21.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 21:20:32 -0700 (PDT)
Date:   Fri, 30 Jul 2021 21:20:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, netdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-block@vger.kernel.org, clang-built-linux@googlegroups.com,
        Keith Packard <keithpac@amazon.com>,
        linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 25/64] drm/mga/mga_ioc32: Use struct_group() for memcpy()
 region
Message-ID: <202107302118.C0B84E521@keescook>
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-26-keescook@chromium.org>
 <YQDxmEYfppJ4wAmD@kroah.com>
 <YQKa76A6XuFqgM03@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQKa76A6XuFqgM03@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 29, 2021 at 02:11:27PM +0200, Daniel Vetter wrote:
> On Wed, Jul 28, 2021 at 07:56:40AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jul 27, 2021 at 01:58:16PM -0700, Kees Cook wrote:
> > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > > intentionally writing across neighboring fields.
> > > 
> > > Use struct_group() in struct drm32_mga_init around members chipset, sgram,
> > > maccess, fb_cpp, front_offset, front_pitch, back_offset, back_pitch,
> > > depth_cpp, depth_offset, depth_pitch, texture_offset, and texture_size,
> > > so they can be referenced together. This will allow memcpy() and sizeof()
> > > to more easily reason about sizes, improve readability, and avoid future
> > > warnings about writing beyond the end of chipset.
> > > 
> > > "pahole" shows no size nor member offset changes to struct drm32_mga_init.
> > > "objdump -d" shows no meaningful object code changes (i.e. only source
> > > line number induced differences and optimizations).
> > > 
> > > Note that since this includes a UAPI header, struct_group() has been
> > > explicitly redefined local to the header.
> > > [...]
> > 
> > Why can you use __struct_group in this uapi header, but not the
> > networking one?
> 
> If there's others, maybe we can stuff the uapi __struct_group into
> linux/types.h where all the other __ uapi types hang out?

Ah yeah; it looks like include/uapi/linux/stddef.h is the place for it.

> Anyway mga is very dead, I don't anyone cares.
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I'm assuming this goes in through a topic pull from you?

Thanks! Yeah, my intention is to carry this as topic branch for Linus.

-Kees

-- 
Kees Cook
