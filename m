Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1608BC433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 22:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiCKWwa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiCKWwV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 17:52:21 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4D024150E
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 14:30:29 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id h10so5320915vkn.4
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 14:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgoWWN4hCZyheZL5Lpc6F+SOSSfbZr+cmTie+FjLL/U=;
        b=mtZIDQzI4w//KeWsJ2nREBRH48vSl8kYr4h6KnIe5cSL9HdR1uL1d2bNyoM0PZOzzw
         haxsrBtRb50oLszHGuDm4wP0mFzjTuj6eU5mK/YlsBIdTacrztfsSa2dZjq/F22ftdf/
         Ab2B5xTbjsD9TjWdiEZ13yf6BPF0wsH2hEAXH97meu5+HdWshInu+w8KECW4kWfbVGWz
         vX+TikxSASI1HD9Hq/eZv9xIrOZBlPbEM2mCQGYpCUVvDqraEr408jrdz+RmxOCVO7uu
         y7/Y27NTTBCn1y/5V+KIa+om8njF4ssjv71xBVaRmfzwOyMG5i4yLZBZJx4wW4CuzUDu
         iX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgoWWN4hCZyheZL5Lpc6F+SOSSfbZr+cmTie+FjLL/U=;
        b=eHUbUzeQDDOe7Imw5DwoBQK/a9dQDcn+e2u83SsLqJgtuJKDtRAAffn0sf7B2C2DQh
         pLYItpABAEm2gBQnIXr41sZtAYV4RZMlV9zGhFoe/7/ytiZVSVsSmhlCheWBnvqW/QMv
         KVTh8bQIfqx6U0+cszOeI6vBwXRaeIa0m7YlP6AuEcG6JJEnHOP8ehp64U5OKljc9yA7
         9YWqWBe07D2rro+5qOrG64OEDQfEnwHbwTUA0In/vvCQDe6Lj4qq1JsmsHVCBTrBm5wt
         82h85YhqeWTf+6/LEDNWsVGkKV9mbfC37Zi5wFkuNr1CQ0IE6PUvXyxAu52dkX0Uq5EV
         /BSg==
X-Gm-Message-State: AOAM5313kZyFhitVZYcgzIOeh1PwD1gqhAZ3jlbz+gEPCqOwo4/Iywv5
        bYXOTJ559lWAJ5iMvcsEnOErzN1Ivpog+F7TVAsiDw==
X-Google-Smtp-Source: ABdhPJx9tE2Kubv2Fs9EUFi1p9vKnotywBkb0W4tg339TVlhtA1C3NOlV0UI5eOnfiIJHug6YMriDbGtX8klgeeMdaw=
X-Received: by 2002:a05:6122:887:b0:332:699e:7e67 with SMTP id
 7-20020a056122088700b00332699e7e67mr5861257vkf.35.1647037828452; Fri, 11 Mar
 2022 14:30:28 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
In-Reply-To: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 11 Mar 2022 15:30:17 -0700
Message-ID: <CAOUHufb=GQaX_2Bp2YfY4ntBZj8iwb8z9mvxUFXw+KkySRu+KA@mail.gmail.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 12:52 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>
> Hello,
>
> We're looking into using zram, but unfortunately we ran into some
> corruption issues.

Kernel version(s) please?
