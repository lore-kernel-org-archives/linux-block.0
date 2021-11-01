Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE78C433F5
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 16:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31FFA60EE5
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 16:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhKAQe1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 12:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhKAQe1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 12:34:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F7AC061714
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 09:31:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c28so37327626lfv.13
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QeCgWLdBZcWN+CI5uUTjHPltwZqjSPQa7WxdJX9QYM=;
        b=HTgGCv+DsB/02el/Q7htcihorrNXfoygrr/8PgPoPXTB7tZ/AdBv5vcy4U2Oy+cYSD
         nq6e2tu1sdLOP5umdDQhHvNwuNjkEaKfJqjvC5CV46jxU7J0SuionPPzo7hPG71utVdd
         7HWES7sg2jz4P/ipGUnH6ldAh31Zh0sriBMMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QeCgWLdBZcWN+CI5uUTjHPltwZqjSPQa7WxdJX9QYM=;
        b=6X6URlmEx2CEuNsvEcZOSDtTSoyPIaYtaCk+NbB9y7PWATdSTVScMrDPC0GLgUHpE4
         adTZ6bL3hRgB6lcVFtKaPA0u4wOctiW92bpE7U7LW2F5G32PYTdWYQjOwKYzUjjSgoUA
         M2dFuciJS91a+OUyyDHy2Hju5xrxj1flC2a2g5FluY82GTrOGW4GOufBll9zCIPn0arM
         Q98eXZoyOUlSf/MBcLNYxhI1nywUr+/Db0Si9x/eMJAw3zw+dXo8uaMu3qkLFX2kQroV
         2CEP7b/rNflX2ClSOVo5Ba9PH9WCn1oUwbhcQUQRzrx/7mV5VxAO9xHd2LxcP6lgugKI
         20PA==
X-Gm-Message-State: AOAM533eMW5Z4JF6q1Qzd3VzeYdq1AZStB6mwxNKlm57KtiATwrXg0sF
        6K5oM33nWTSj0llgzZmEVOXxcyyrE2JOHe98
X-Google-Smtp-Source: ABdhPJyfMSjgTw8+G3DIZx2QMU3mfirTxk+g+aOy3DjgVzT9lIlLrXXKraC94WehrWhuRjk9Z8jZeQ==
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr27376101lfb.189.1635784310287;
        Mon, 01 Nov 2021 09:31:50 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id g18sm1633596lfr.120.2021.11.01.09.31.49
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 09:31:49 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id s24so1371557lji.12
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 09:31:49 -0700 (PDT)
X-Received: by 2002:a2e:9e13:: with SMTP id e19mr32736276ljk.494.1635784308994;
 Mon, 01 Nov 2021 09:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <36d0a261-bd28-123d-5eb8-4003eac7fad7@kernel.dk>
In-Reply-To: <36d0a261-bd28-123d-5eb8-4003eac7fad7@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 09:31:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2JmPuCie_paZAD4Kdk6d0bBs+U8CHxWHQy5e5Ex1=AA@mail.gmail.com>
Message-ID: <CAHk-=wj2JmPuCie_paZAD4Kdk6d0bBs+U8CHxWHQy5e5Ex1=AA@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver updates for 5.16-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 31, 2021 at 12:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> - paride driver cleanups (Christoph)

The mind boggles.

I've pulled it, but I did have a double-take at this. Anybody still
actually _use_ that thing?

             Linus
