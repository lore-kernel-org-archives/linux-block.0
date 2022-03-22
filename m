Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7BBC433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 21:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiCVVy3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbiCVVy1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 17:54:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DE93BC
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 14:52:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a17so22276116edm.9
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGrxL9KoLqKPHkR/6k4DFcIQZaJzGdo7QploaybSREM=;
        b=ECA2Ww2aYirZnEdzSOcxu7YgwzbRhVUmZuMhV/G6M+U49OOFm78QrA15+YaD6UD0wl
         PAxZXf/l5F88ZnyArz/FvKnyw/p/Pi41OL5vnX2nilPiuLSD49vOtIICak5w//Dvvyy4
         YnL4gHKr90yMWCwQSI/eWr9J9vf7pw6Bgxk5KCHI+xuHIewcGwMIa8V7AeUZ7uHaXRYC
         g4fW6n7PZpbeWwSQqm0EW9tQOAQZJdx4/Cw0orEdjFnzl9ddD40F/e7DTkQrj6nCCPqV
         64HcorUnowrzn+jmne1AAqR1IaW4DfjJprEe7rjXVoHYDwnD/Euy11gPsiYhh2Iwtosh
         PxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGrxL9KoLqKPHkR/6k4DFcIQZaJzGdo7QploaybSREM=;
        b=q0M4QCSp6QR6+KL0YVcGBiLhajO0YLJf4DNb9KqA7ZYQDrhIVuz76E1+vTjFW3xMdr
         F5nOjnKnX7r0qipZblCQiSGC+8X0ISDQVevPB1kMnMhFVJjwF0rxbzU6XOlBowlVSWLd
         Z9jFxsX/Lv4PA/l0NdXoox9nt6HBfXZbDQww4BRgJwQWL+qpBHxUwfAhuOua0nr0ZQgD
         qLcIigqdPYdYbSw1gOiHI+vwSdqwhnWZc9zUA4pTGWrwEPIzznoSnSbdO1sP89gcvCSS
         GfC7eAy204Y6g8yP6k4qF1scfD4u783WQJzp3P9/B0AiT6gIzbmSawH1jDJsDtW5zR2X
         ptAg==
X-Gm-Message-State: AOAM531W9ZoGg3kpuixnXvE+Wk8eLNQBwZfXev1yXUMU53VKQUWjgnsd
        SpW5I5wEOGRLkm4Ade+p21Uh+xTChj9IrU5RXItido/G+7k=
X-Google-Smtp-Source: ABdhPJzZT/ZfEv9w/dLy4UgNNPTxUnu85oRsyTxaXhMhcL2jk3SMKARLvBt+csyqXY8LJ/G6HJq/fXAzd034Xe6BAlo=
X-Received: by 2002:a05:6402:50cf:b0:418:ee57:ed9 with SMTP id
 h15-20020a05640250cf00b00418ee570ed9mr30615764edb.37.1647985976854; Tue, 22
 Mar 2022 14:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220315172221.9522-1-bgeffon@google.com> <20220321145037.1024083-1-bgeffon@google.com>
 <Yjo75atYTpXqCM4g@google.com>
In-Reply-To: <Yjo75atYTpXqCM4g@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 22 Mar 2022 17:52:20 -0400
Message-ID: <CADyq12zYGJ-L-h5QRt3k7mPATx-sNKhqyeRyugPkbuMHF1G86w@mail.gmail.com>
Subject: Re: [PATCH] zram: Add a huge_idle writeback mode
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 22, 2022 at 5:13 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Mon, Mar 21, 2022 at 07:50:37AM -0700, Brian Geffon wrote:
> > Today it's only possible to write back as a page, idle, or huge.
> > A user might want to writeback pages which are huge and idle first
> > as these idle pages do not require decompression and make a good
> > first pass for writeback.
> >
> > Idle writeback specifically has the advantage that a refault is
> > unlikely given that the page has been swapped for some amount of
> > time without being refaulted.
> >
> > Huge writeback has the advantage that you're guaranteed to get
> > the maximum benefit from a single page writeback, that is, you're
> > reclaiming one full page of memory. Pages which are compressed in
> > zram being written back result in some benefit which is always
> > less than a page size because of the fact that it was compressed.
> >
> > This change allows for users to write back huge pages which are
> > also idle.
>
> Hey Brian,
>
> I really want to add your explanation about the storage endurance
> because it's real issue.
>
> So, could't you add up below in the description?

Sure thing.

>
> From your previous reply
> "
> we're trying to be very sensitive to our devices storage endurance,
> for this reason we will have a fairly conservative writeback limit.
> Given that, we want to make sure we're maximizing what lands on disk
> while still minimizing the refault time. We could take the approach
> where we always writeback huge pages but then we may result in very
> quick refaults which would be a huge waste of time. So idle writeback
> is a must for us and being able to writeback the pages which have
> maximum value (huge) would be very useful
> "
>
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
>
> Other than that, feel free to add my
> Acked-by: Minchan Kim <minchan@kernel.org>

Thanks Minchan.

>
> Thanks.
