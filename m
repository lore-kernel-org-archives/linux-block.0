Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA50C76195
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 14:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjCWOat (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 10:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjCWOas (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 10:30:48 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F2B9756
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 07:30:47 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id jl13so14179940qvb.10
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20210112.gappssmtp.com; s=20210112; t=1679581846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW5cWuSORuMPl9h4M/OMu4zN6Ab689Cgd2Jmn907uzA=;
        b=uga6xPblyjNwQ0nys0O9OMOnWPlxzoqUx0tub1g4jl3Ds7H0qu2WTey6xF5KYLxKjC
         SCNdX/4AXYIE5IhDdtecko+9IOBtUIc3U2CM4hPqaHHiSjJXBWP+o6JLCwKslIKRmAED
         TXE8V7Fa5Vj5MdO1Sgso1Toii0RePFj640IY5JVqwEa1uZwDrQZ5LDzFX93GFGZY9IjQ
         hb8Z808MK7gqHrpq+J6Wxii0pqN6Kedc0VTbCmzHxDcz5RluBsBf5YY47foQKVJ8WL5w
         Hhs7tyAu+HDhks/IkXKF2t4EX3GViwlbB8pSikG3+R69thN52bWR4mIjSGgorkjzAiC0
         GC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679581846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DW5cWuSORuMPl9h4M/OMu4zN6Ab689Cgd2Jmn907uzA=;
        b=tJL5zspFFEqy703NLtY15HYhKJCxxUGM0m3Cpo5MRXJubrbQMTqK2afjondnoclYu4
         iyIIstA3C7KmocPRcbwodwt0mFOOX2whkbacwOCBl8SizYPqAAxAN9BAOhYwiZnS7Eub
         F9sm92tFPOYpZt74IScrmEXlBpovM8cyzNoMpJvEoYeMod2va6HxNPDwRXSOp5Vy48ll
         K+8waWa5vaAej14FLG2JtVLqhFMNL/GhEEd/bN1G1iU5SEyBTy6n3TwHJgDdl7YFgQtT
         HQpY+vftcyYkaWdq9+ttrzVPR83uMjzQZ/lIra4KfghB2xsC0NFHcJnoc+qDZA43virE
         zJYA==
X-Gm-Message-State: AO0yUKVsD9FCNemmAgoCN4Ml3zlD62uwd1PJvuwEFyc1XwMqi/xizU2y
        epK14NH1/lktoKzEwCXGL6i3heCAFnHwV5Fy6/Jqwg==
X-Google-Smtp-Source: AK7set/trVllkfcEi+yg3oqpS8DY+A/uEckTTWNRYDqUdJd5erFFIJB2DTR1p2z4pS/Mo+VlMX55/q/gvrdpE0I/XKA=
X-Received: by 2002:a05:6214:8c7:b0:537:7476:41f7 with SMTP id
 da7-20020a05621408c700b00537747641f7mr1552535qvb.3.1679581846154; Thu, 23 Mar
 2023 07:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c@eucas1p2.samsung.com>
 <20230322135013.197076-1-p.raghav@samsung.com>
In-Reply-To: <20230322135013.197076-1-p.raghav@samsung.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 23 Mar 2023 10:30:35 -0400
Message-ID: <CAOg9mSRvPDysNF-GV_ZGf8bu1-50wA5y7L=LuZwGp+vEVzsu1Q@mail.gmail.com>
Subject: Re: [RFC v2 0/5] remove page_endio()
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        willy@infradead.org, brauner@kernel.org, akpm@linux-foundation.org,
        minchan@kernel.org, martin@omnibond.com, mcgrof@kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I have tested this patch on orangefs on top of 6.3.0-rc3, no
regressions.

It is very easy to build a single host orangefs test system on
a vm. There are instructions in orangefs.rst, and also I'd
be glad to help make them better...

-Mike

On Wed, Mar 22, 2023 at 9:50=E2=80=AFAM Pankaj Raghav <p.raghav@samsung.com=
> wrote:
>
> It was decided to remove the page_endio() as per the previous RFC
> discussion[1] of this series and move that functionality into the caller
> itself. One of the side benefit of doing that is the callers have been
> modified to directly work on folios as page_endio() already worked on
> folios.
>
> mpage changes were tested with a simple boot testing. zram and orangefs i=
s
> only build tested. No functional changes were introduced as a part of
> this AFAIK.
>
> Open questions:
> - Willy pointed out that the calls to folio_set_error() and
>   folio_clear_uptodate() are not needed anymore in the read path when an
>   error happens[2]. I still don't understand 100% why they aren't needed
>   anymore as I see those functions are still called in iomap. It will be
>   good to put that rationale as a part of the commit message.
>
> [1] https://lore.kernel.org/linux-mm/ZBHcl8Pz2ULb4RGD@infradead.org/
> [2] https://lore.kernel.org/linux-mm/ZBSH6Uq6IIXON%2Frh@casper.infradead.=
org/
>
> Pankaj Raghav (5):
>   zram: remove zram_page_end_io function
>   orangefs: use folios in orangefs_readahead
>   mpage: split bi_end_io callback for reads and writes
>   mpage: use folios in bio end_io handler
>   filemap: remove page_endio()
>
>  drivers/block/zram/zram_drv.c | 13 +----------
>  fs/mpage.c                    | 44 ++++++++++++++++++++++++++++-------
>  fs/orangefs/inode.c           |  9 +++----
>  include/linux/pagemap.h       |  2 --
>  mm/filemap.c                  | 30 ------------------------
>  5 files changed, 42 insertions(+), 56 deletions(-)
>
> --
> 2.34.1
>
