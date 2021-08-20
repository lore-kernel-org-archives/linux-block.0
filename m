Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B93C4320E
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 15:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A8B610FF
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 15:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbhHTPtu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241128AbhHTPt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 11:49:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C606DC061760
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 08:48:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so1283054pjx.5
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+X4tplmtLpNByUEVXOfNbGWn8TfE6IQ/s3keb98s9Zw=;
        b=TQi9mHrog4hPanBaikdC3rkAqhWlJoZ9vaxMBbVCpuTo6U3O8D/l7D3vj3Dwl9Evpk
         9+Ar2w4FVMAo3iFJgQJ24Rf/5z+Jb9VcsmknpA1sA/dgnc+y+KKgkLyHTejrjon296vl
         nVvqNextVO6bfDk20DLfoQeW8dUpsfILdnoVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+X4tplmtLpNByUEVXOfNbGWn8TfE6IQ/s3keb98s9Zw=;
        b=EGkO097pfM6bXGT6CkShPZjhOgS4TG3lkE1TUqUz0MBZ/IsaFTrFn4aYlIrD8dDeyC
         uTSAq+3BadvFv6MZisWslVFg86SPD6LjTdUsq2Xj8gHDoNmxjdnqJ9g4+ndZTkLYlval
         +d5e1r+qF1ja3QPIx2cyqRMawRXc7e7GJ2xpAAYSkUANyPBxdGMygPwRevU7IgsqOCq3
         yva0zGfxIgY2Ew+C/tRs/2P0I+0jNRoC5AFKbSyD9SA6QQJ25vXkaUtTLYk2mWPtIfew
         izMpIM8uImO8KJNXbM9WUp3vQ7jvFoWTQv0SANwuOiE6/RRoqGd1fVPF6K0QxhTHmOla
         I8Pg==
X-Gm-Message-State: AOAM530Y7eAVOk0CMXlix+U1vEJzIphRbJY0+jWUASa4JigQrWIiaKYl
        k8SEWAHYOomRUI5Dwvn9QCNtaw==
X-Google-Smtp-Source: ABdhPJy28AqDYlCk7fSw2jInR24wvj759kZeVQ/aeXK5FOKx4YXAZlQAlIPt57DIYl/oWb05ha9YZQ==
X-Received: by 2002:a17:90a:f0d1:: with SMTP id fa17mr1603893pjb.33.1629474531324;
        Fri, 20 Aug 2021 08:48:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q21sm6457593pjg.55.2021.08.20.08.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:48:50 -0700 (PDT)
Date:   Fri, 20 Aug 2021 08:48:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 22/63] HID: cp2112: Use struct_group() for memcpy()
 region
Message-ID: <202108200848.E9DB1511A@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-23-keescook@chromium.org>
 <nycvar.YFH.7.76.2108201501340.15313@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2108201501340.15313@cbobk.fhfr.pm>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 20, 2021 at 03:01:43PM +0200, Jiri Kosina wrote:
> On Tue, 17 Aug 2021, Kees Cook wrote:
> 
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally writing across neighboring fields.
> > 
> > Use struct_group() in struct cp2112_string_report around members report,
> > length, type, and string, so they can be referenced together. This will
> > allow memcpy() and sizeof() to more easily reason about sizes, improve
> > readability, and avoid future warnings about writing beyond the end of
> > report.
> > 
> > "pahole" shows no size nor member offset changes to struct
> > cp2112_string_report.  "objdump -d" shows no meaningful object
> > code changes (i.e. only source line number induced differences.)
> > 
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Cc: linux-input@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Applied, thanks.

I'm not sure if my other HTML email got through, but please don't apply
these to separate trees -- struct_group() is introduced as part of this
series.

-- 
Kees Cook
