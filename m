Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2D7C433B4
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 16:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322EC61185
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 16:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbhEQQ5H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbhEQQ5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 12:57:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE703C061573
        for <linux-block@vger.kernel.org>; Mon, 17 May 2021 09:55:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j14so5418088wrq.5
        for <linux-block@vger.kernel.org>; Mon, 17 May 2021 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0SbHsdelBsQBb8+A+ZjphqcSc7i/BnJ45oflQMUF2g=;
        b=cAiNfAHMALBczXj0RaoSTyesPa47r8kBHAORdjBwyJ1BCeeCVZyYW7d582niuXUgU5
         2R56PvB3tN/JF3Y5lqG4VIf3S4mxYjsCR7DbNYAH1p9/pyXKvPlDHz8Ny4i6gCL7hblO
         fsFJZ2mtSi3iH/X7bJLAsQwg/3MTJvNLMM7k9qXOePYSpTjaisPzwTvEX/z2QWxFUpXf
         cBi2h1pP4xMfpG0boMl24ZzaQxbHq7/HdhOoaBCN0lI+61EiPtgA3Bq1qV6bLXogHydL
         yt1cDSAaRCmb9prbaifMGFNEfl8r9tVQQGouxGtrCikP0bh4fSFJvhQa7A+xqbiPXop6
         G9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0SbHsdelBsQBb8+A+ZjphqcSc7i/BnJ45oflQMUF2g=;
        b=Vz506SW+S6vb/nCTaP3pMyLTx7iG+Y7Lr/SAhL3/5+uGi3BIgYsK3SWXmQuK0z/B1I
         IzvEKDTh9TlYEDRG3GPQg/ta+DzncVdKhWQMTYNhATCQTCYKAx0dbTielRO8HMyEl39L
         dJ/ISPHkzQM6WhZoAvfuD4SmKtZ4N1mKEp7WBnp+0GYifan0ihtOpJhG107uuhtWx6Q3
         zVWt7iNzL/+hUNGPkOlT/TinC28hMYKD5hgVpY5yCRkBwZJQBb+QVcd7Xn34T+wVacBS
         /EOfwvFNcC2OtDIIx36wKSUqiBEGoQnQAM6U3cYnIv317iOwo5jNurVtWnzEspaMRFdU
         YKPw==
X-Gm-Message-State: AOAM532vMPar4V8NbR6HGIwwPC/tb3bd4h4ZfZasvU5xXqKMzv/bnk0z
        FqCcdRdjYFj5Y65ZrMmyciyg4VB3zjUwQ6fBKGk=
X-Google-Smtp-Source: ABdhPJyxVvzx2e2V5BKPlYe/kYKx+qAVx9p7s/eel32ljWLOXdUDyucQzb1RuI6CsT8aItREGEbjSOx8Kqo2HqnYPns=
X-Received: by 2002:a5d:5508:: with SMTP id b8mr743886wrv.278.1621270548615;
 Mon, 17 May 2021 09:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210423220558.40764-1-kbusch@kernel.org> <20210423220558.40764-6-kbusch@kernel.org>
 <20210426144316.GE20668@lst.de> <20210426151537.GB12593@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210426151537.GB12593@redsun51.ssa.fujisawa.hgst.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Mon, 17 May 2021 22:25:21 +0530
Message-ID: <CA+1E3rLD7Zx2iKtUoTBVc4VXBj2ohXFeXSw59umBZ3Q=QEA0xQ@mail.gmail.com>
Subject: Re: [PATCHv2 5/5] nvme: allow user passthrough commands to poll
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 26, 2021 at 8:46 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Mon, Apr 26, 2021 at 04:43:16PM +0200, Christoph Hellwig wrote:
> > On Fri, Apr 23, 2021 at 03:05:58PM -0700, Keith Busch wrote:
> > > The block layer knows how to deal with polled requests. Let the NVMe
> > > driver use the previously reserved user "flags" fields to define an
> > > option to allocate the request from the polled hardware contexts. If
> > > polling is not enabled, then the block layer will automatically fallback
> > > to a non-polled request.
> >
> > So this only support synchronous polling for a single command.  What
> > use case do we have for that?  I think io_uring based polling would
> > be much more useful once we support NVMe passthrough through that.
>
> There is no significant use case here. I just needed a simple way to
> test the polled exec from earlier in the series. It was simple enough so
> I included the patch here, but it's really not important compared to the
> preceeding patches.

It would be great to see this in at some point; helps in making
passthrough more useful.
I'll look into integrating this with async-passthrough.

-- 
Kanchan
