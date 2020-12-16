Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67042C4361B
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 21:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C6C233E2
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 21:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgLPVRR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 16:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgLPVRR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 16:17:17 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246AAC06179C
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 13:16:37 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o17so49070107lfg.4
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 13:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVglo+caBTHSnMTAAMsZjzowCQTkJvWCo63u7bF12dk=;
        b=LH6HLgSOoXzTcWfqiqqlmSuHdscQ5bhlbf989vaMTiM3pVRV+wCsfezLL5lrMexOil
         2ubjTtjf8T2BhX69JDYsqGHw2K+g+QWmnYthtR1p8/ZIGRSFrkcRzdNGcrJkmXUOBDBH
         UZ7rECC55URCigRyEhSWZ05z636tfcRAivsE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVglo+caBTHSnMTAAMsZjzowCQTkJvWCo63u7bF12dk=;
        b=tGlsUP2XqVdtIOCigNpVqARxvC4yw6KRgMrocVYNe4YsA9i3vReXaGSHj+52cX5HFT
         wTUT0Enrtea5kfctIbs1K6x5QeIsdDCp0rJYRBai60EYi7PlEXmTyxRLZ2UQai2qHWq3
         v7AQZc0NZC0+UkB8P0zQMWyeMmAC3yUPRvQ74vlfoEeIWtuKjPwogWn0x8/WAXZo5cPe
         xclTjZCn0N3ctDuG5oSyogBVQx1PR9HIYXa5EZe98IPTPFt0V9dlq6PW/2g6+L0qqHSc
         oMMg6AHCs3VBADFlUirFmj8uiBHUeCyesrDAAVX8hZARCVpF9BzzTe7TilUilOkCz2vH
         nYhQ==
X-Gm-Message-State: AOAM533S1zKkhz57OKlskmv9Qb+NK6FxOsmMxNb3A6q2u8SA2zx+7to9
        O/rnhwTEtgeYyTVOniaeIDVA45uM1PvD/w==
X-Google-Smtp-Source: ABdhPJxgr9cnZMKSSQ56O5iVzzi/UrThpKPoInsyO1UFZ3SvvbQnoA8h8odLN1ZzXWD9g7s/qwI3WQ==
X-Received: by 2002:a05:6512:689:: with SMTP id t9mr13490978lfe.78.1608153395373;
        Wed, 16 Dec 2020 13:16:35 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d12sm351998lfi.164.2020.12.16.13.16.34
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 13:16:34 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id o13so28817011lfr.3
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 13:16:34 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr14234643lfb.421.1608153394344;
 Wed, 16 Dec 2020 13:16:34 -0800 (PST)
MIME-Version: 1.0
References: <8238bb43-756b-e0dc-2484-7e1e21928c0c@kernel.dk> <CAHk-=wjRm36zBu2Vj=VyntiA9Hdc1_uFVeY93d3oYQntXzERag@mail.gmail.com>
In-Reply-To: <CAHk-=wjRm36zBu2Vj=VyntiA9Hdc1_uFVeY93d3oYQntXzERag@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Dec 2020 13:16:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whuWL4=4Sc44sxd16RNLFVvL4O6MM12QTHAB0p=dz9H+Q@mail.gmail.com>
Message-ID: <CAHk-=whuWL4=4Sc44sxd16RNLFVvL4O6MM12QTHAB0p=dz9H+Q@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver changes for 5.11
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 16, 2020 at 1:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Am I missing something?

Ok, I've pushed out my pile of resolutions, please holler if I screwed
up and let's get it fixed asap.

          Linus
