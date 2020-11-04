Return-Path: <SRS0=E+wN=EK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BB3C2D0A3
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 03:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B02F206D4
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 03:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jap3DivD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgKDD0b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 22:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgKDD0b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Nov 2020 22:26:31 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E0DC061A4D
        for <linux-block@vger.kernel.org>; Tue,  3 Nov 2020 19:26:30 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id b11so9171959qvr.9
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2020 19:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rGgCfPeyoNNWrcu3PEERgDJb8/+a0V5f0tx7Yt5bdvs=;
        b=Jap3DivDSSJAOM94pxabM/BHE/W8WtIAJi8NxUw5c0LOTrcD5VgW3sMulBo1VtaHHv
         3WDv5A95r2dW0TuhEBvmuFZnlOB4vE/B9HBYQx8kM7XyR8/VE6kGLuQlxzJElrsLXAM1
         9an5CpFwvGYFvJiRgvnLlbXPDPveMD6sSGTrncDfV/Htq+1F4m2tTTvhWIhkgW/hSw9+
         bC1k+XP81Qa3zKoKwo6muE/O3iLcALwdHmrren3dS3Sx9occ+4QJw5S7Hu6rQblcDYYy
         Q8uO2+LSa8GW4OHLnVXxNnRdgNyvXrvj4tk9kfG2U6xiVnMbOkgjVLZTm4YoWhJK1IDC
         dSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rGgCfPeyoNNWrcu3PEERgDJb8/+a0V5f0tx7Yt5bdvs=;
        b=U+no/YdzWWO+bf0Jb/RgAUnlyvnbideK/DNwZdgfwBXSX60FgOR+uFOawWYokpeuzj
         GFaqTowwV6OqOy+VFkV6dPVipGyAPHeF1xAB/EB1uqiIHFB+L0UgJdF0hWltEzdZLBK/
         o8G42BKHVz02uWB60zvuI4rzG2AT3B4qGQ/wo3tUnyK3xdZlGnyRq4e08ma07BQ1cKpL
         Wwr6MvgP/0TOIaHnsc1Qms9YxKCOEmRKm6JNc/NsxFNR9+bgKUHAiamOHpBqIUqVZYJ2
         JEFy0M58QfHKPa1U+2B+riRm74QNTTSPt0zBQVtkhMFQRUCGZDJG5lHATrRpV7UcDiUe
         0qNQ==
X-Gm-Message-State: AOAM533TUYQWObeZs33CaXUfgCKHINn3Wtar3cUmzP6p3SmKk73zpyYP
        wClBjPhrh3wL0PfZkEmX0pPFNrCD6YhZdjhB/kXyuABTHpI=
X-Google-Smtp-Source: ABdhPJwphdtXjfP0jjTp/216SeL6bXGa/fePoRBv7NFzI8cf85mNu7YitKl6Rp327JQhQWPSgrhnP7hL+tK/rx8Gsl8=
X-Received: by 2002:a0c:ee4b:: with SMTP id m11mr28204883qvs.0.1604460389341;
 Tue, 03 Nov 2020 19:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20201027045411.GA39796@192.168.3.9>
In-Reply-To: <20201027045411.GA39796@192.168.3.9>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 4 Nov 2020 11:26:13 +0800
Message-ID: <CAA70yB7bepwNPAMtxth8qJCE6sQM9vxr1A5sU8miFn3tSOSYQQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] fix inaccurate io_ticks
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, mpatocka@redhat.com,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping

On Wed, Oct 28, 2020 at 6:59 AM Weiping Zhang
<zhangweiping@didiglobal.com> wrote:
>
> Hi,
>
> This patchset include two patches,
>
> 01. block: fix inaccurate io_ticks
> fix the io_ticks if start a new IO and there is no inflight IO before.
>
> 02. blk-mq: break more earlier when interate hctx
> An optimization for blk_mq_queue_inflight and blk_mq_part_is_in_flight
> these two function only want to know if there is IO inflight and do
> not care how many inflight IOs are there.
> After this patch blk_mq_queue_inflight will stop interate other hctx
> when find a inflight IO, blk_mq_part_is_in_inflight stop interate
> other setbit/hctx when find a inflight IO.
>
> Changes since v4:
>  * only get inflight in update_io_ticks when start a new IO every jiffy.
>
> Changes since v3:
>  * add a parameter for blk_mq_queue_tag_busy_iter to break earlier
>    when interate hctx of a queue, since blk_mq_part_is_in_inflight
>    and blk_mq_queue_inflight do not care how many inflight IOs.
>
> Changes since v2:
> * use blk_mq_queue_tag_busy_iter framework instead of open-code.
> * update_io_ticks before update inflight for __part_start_io_acct
>
> Changes since v1:
> * avoid iterate all tagset, return directly if find a set bit.
> * fix some typo in commit message
>
> Weiping Zhang (2):
>   block: fix inaccurate io_ticks
>   blk-mq: break more earlier when interate hctx
>
>  block/blk-core.c       | 19 ++++++++++----
>  block/blk-mq-tag.c     | 11 ++++++--
>  block/blk-mq-tag.h     |  2 +-
>  block/blk-mq.c         | 58 +++++++++++++++++++++++++++++++++++++++---
>  block/blk-mq.h         |  1 +
>  block/blk.h            |  1 +
>  block/genhd.c          | 13 ++++++++++
>  include/linux/blk-mq.h |  1 +
>  8 files changed, 94 insertions(+), 12 deletions(-)
>
> --
> 2.18.4
>
