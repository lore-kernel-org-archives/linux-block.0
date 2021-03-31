Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E821C433ED
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 22:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7BD61059
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 22:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhCaWGj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 18:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCaWGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 18:06:18 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43DDC061574
        for <linux-block@vger.kernel.org>; Wed, 31 Mar 2021 15:06:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 15so68763ljj.0
        for <linux-block@vger.kernel.org>; Wed, 31 Mar 2021 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QLAC5kN/WTgkwkL/JFTyfACTaPGT2EBf3L5262ee+4=;
        b=ADTGFd4lk9p+Q+wx9GIWrS3fgJRyAxfL9keWhU1AajmwQ7JNHeSKUjj8seO3YINUdT
         MVoDfIP75V7pkXaEvdPSxKJD55YG+eurYiLsXz8688cGJmg4fLD08X0dLETnO+zlcIY5
         Nsib1gSnvPeBnFv1H5zoO1DGqgcoyi3muxpG9bkVDDhREZkWZnkR2mqebP5KSv0ybqNn
         1oaLNsOF+4ydbnJ5+BkIHP11tui3h03YPgBP1dwtBWNHNvx+wp4F4PzDxOHHNqtInvbZ
         tC7GGOlPEpRowAN1evP0wYWXCo1yqu7o8kQcrYibnqwX6TVcdXj7AD1+b+e8YUXnceK3
         ls3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QLAC5kN/WTgkwkL/JFTyfACTaPGT2EBf3L5262ee+4=;
        b=QhsKTlf16lt4Mkw6y8aw788nk98JkinQaIpkNqpCaa4Kos7Is562Bl+0c7ek4hwsmI
         nQYRh6J4eAYSaYl3K5MM6ltcrETuQAQkeacvwBJQt3y+yRRQ7iyNYpjlqd7xIGA7EZrp
         twi56I365TqbSgKAA+5qeweyQbcLUdF4MWuoaGrmxmaNwF2YLzBNnCHs/z/9RbtFnQ5L
         rw6CWjOJRLuClfVILAdg148ZlruyVOygrVZLLcwTy7pjj1gjmcQNxPb+V+aGjYtR/2oR
         9Pjwpq7SPyP+C2MBl14QrGFQ7NAfrOMCxDLfZcUHmFa37BGUt4ZLp8YTIoGS4x4EcxaD
         DfNA==
X-Gm-Message-State: AOAM530vliQR2gVMxUf8MIuJLSnkNmsXG5Kx3hMT2ijVhDOcepFTxEwD
        oiGdpNcHb9/95ryMrZ8u0aW4mp+OBHD879dcy5CxVQ==
X-Google-Smtp-Source: ABdhPJyoZW5ZCpawMvEh8m06nfRQeoGo8aGODeEmAJXnZJmb8H0MPRbES64y2zB7W9P4SMx0Y1mqNcOQpk8Fd/JLhH8=
X-Received: by 2002:a2e:3603:: with SMTP id d3mr3354196lja.495.1617228376110;
 Wed, 31 Mar 2021 15:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210330230249.709221-1-jiancai@google.com> <20210330232946.m5p7426macyjduzm@archlinux-ax161>
 <114a5697-9b5c-daf1-f0fc-dc190d4db74d@roeck-us.net> <CA+SOCLKbrOS9HJHLqRrdeq2ene_Rjs42ak9UzA=jtYb0hqWY1g@mail.gmail.com>
 <CA+SOCLLBgKtTz732O5zcrNs_F=iS6C2bE4HBmJfoPTum3Yu1oQ@mail.gmail.com> <20210331215802.r4rp6wynjqutdoup@archlinux-ax161>
In-Reply-To: <20210331215802.r4rp6wynjqutdoup@archlinux-ax161>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 31 Mar 2021 15:06:05 -0700
Message-ID: <CAKwvOdmoud9=Uf2xN7q1c1gP06ZNU4K2-Q5PDD-LTynHC+qOMA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix alignment mismatch.
To:     Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Jian Cai <jiancai@google.com>, Guenter Roeck <linux@roeck-us.net>,
        Christopher Di Bella <cjdb@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 31, 2021 at 2:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Mar 31, 2021 at 02:27:03PM -0700, Jian Cai wrote:
> >
> > I just realized you already proposed solutions for skipping the check
> > in https://lore.kernel.org/linux-block/20210310225240.4epj2mdmzt4vurr3@archlinux-ax161/#t.
> > Do you have any plans to send them for review?
>
> I was hoping to gather some feedback on which option would be preferred
> by Jens and the other ClangBuiltLinux folks before I sent them along. I
> can send the first just to see what kind of feedback I can gather.

Either approach is fine by me. The smaller might be easier to get
accepted into stable. The larger approach will probably become more
useful in the future (having the diag infra work properly with clang).
I think the ball is kind of in Jens' court to decide.  Would doing
both be appropriate, Jens? Have the smaller patch tagged for stable
disabling it for the whole file, then another commit on top not tagged
for stable that adds the diag infra, and a third on top replacing the
file level warning disablement with local diags to isolate this down
to one case?  It's a fair but small amount of churn IMO; but if Jens
is not opposed it seems fine?
-- 
Thanks,
~Nick Desaulniers
