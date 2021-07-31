Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D30C432BE
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F183461019
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 15:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhGaPCH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 31 Jul 2021 11:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhGaPCG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Jul 2021 11:02:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E653EC0613CF
        for <linux-block@vger.kernel.org>; Sat, 31 Jul 2021 08:01:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a20so14650991plm.0
        for <linux-block@vger.kernel.org>; Sat, 31 Jul 2021 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6NzNWl7LhGEt5gulXFub5aIXRWGd7b+RfXfHU7IL/eI=;
        b=Jx/NovSJ2alFyoaVfse4LYGuhNMlBcAWv6JTiM3YSwvodvaXCAulhewOn2HF0FC+nz
         N7t2fd02SxFeFS/jAywZfBDu3dF82py23YxGadXmxU6FsZZNwFLKknaPYZ73JtAAQWAr
         FgjDEpjlNdXTBhWlUNhxTGhy3p9i8wqoga8qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6NzNWl7LhGEt5gulXFub5aIXRWGd7b+RfXfHU7IL/eI=;
        b=FgTO+AO8vLRKbE6VWIHogseKkjf/AdHdR1G60xiE0ENAXOyN7U3VQ7eT+BPtA7O+3M
         P/1D4aEvGmVAQxGrvolq/no7J8CGr5rfymPd6QngaNSiQBlBSrhQ6oL8HjN792prDhSR
         obl33t5MXOxNMpMsZ9Z5FQpPaA0wV3/5va2y+4Yb73fV4N2AWAkh+LfXYE7vsX1FKs8u
         42XnED1YbUPAUOoJuF/7f2KXGovOW6c8nw6Vzi9N+e4JhMUQkjh7ngepZovfxzzD88J8
         cM4YMepEOAiU9N9dVqcBTypqsXHuyW5yql25ntb5cbiwbCz3r0b2ZOnlQf/bzD1+j1FQ
         lutA==
X-Gm-Message-State: AOAM530BszUdEQ1aM+CHUzcx/YivMq2/GZuVbn5gjp5ErwhnfWMM6xeQ
        oiX0NRMlXngM3pdMmM1iNn6RAA==
X-Google-Smtp-Source: ABdhPJxldKFq/Rzqofqxn4rJbNcLhr5hYJ4ZeyAVRbwaYS9Cd10PchwbLiRXEC7+1Qe+4tL2UtPocg==
X-Received: by 2002:a65:53ce:: with SMTP id z14mr2617394pgr.275.1627743719538;
        Sat, 31 Jul 2021 08:01:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jz24sm1857832pjb.9.2021.07.31.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 08:01:58 -0700 (PDT)
Date:   Sat, 31 Jul 2021 08:01:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 54/64] ipv6: Use struct_group() to zero rt6_info
Message-ID: <202107310801.D50070F@keescook>
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-55-keescook@chromium.org>
 <20210729115850.7f913c73@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729115850.7f913c73@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 29, 2021 at 11:58:50AM -0700, Jakub Kicinski wrote:
> On Tue, 27 Jul 2021 13:58:45 -0700 Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memset(), avoid intentionally writing across
> > neighboring fields.
> > 
> > Add struct_group() to mark region of struct rt6_info that should be
> > initialized to zero.
> 
> memset_after() ?

Oh, hah. Yes. I will adjust for v2.

-- 
Kees Cook
