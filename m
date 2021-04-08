Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3549C433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 17:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF326610C8
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 17:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhDHR6T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhDHR6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 13:58:18 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ADEC061760
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 10:58:06 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so710087oot.4
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjjtxfZDaRiLXHBjXX5lq0Oke8MJeuPXuGP2r18boHY=;
        b=cT3vv+ZiDCbDV/FET0fxhkXBCZwdGl378BVLqXWtyciSxd8qG9WbC0+lMNJqLouBPF
         U2zhvH2eGr9xr5Wys9tvjQJ2+6qD/7OhQUVtOb7juPLrhLMsfKZ4W6CMc8OFMH1SuJym
         ISZlXnl5KlkoIIJM4H65TfDi17FDCAOeYcnhJPSwefWcio9hQxCLjfXIETVwZrOxFtug
         jCYqSgVS6klH/hRpUKUMUoKHS+ASjEp5iY2n1eLLsoJSlI7NIu5atKcwyZ8RDEvoAcWT
         aMZzgIyOGnnK1aY9wh4P/aqYo7Fgw7xnTftGluo6ehffXb0DWRuM5i3M1Bkxn6YnrxRi
         o8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjjtxfZDaRiLXHBjXX5lq0Oke8MJeuPXuGP2r18boHY=;
        b=nY6B3y3uoupKsgiH8GqgW5riF7kZeWVqUf3iKVI395X4lVnInp5UT13QiKBLcEWCMy
         MRnwXqRs2SdfYlf+oLy+kR7gFhGr90bi0EZSBH9VnGztdaqX0Q45hnx+VQBIk/4ekryA
         CJ9YL1kI+Op6owFJhYHWpC09WT5D0I6+uXO1z7Bo7UQ4Vd4v9s8T0IeqS3tIyODxAuB4
         bChzS09LBgScEWSrcVcmprb5YE6/e/NwlT2+UcOtZczzRvl0JKYDagJhzTUSuo1XCa8S
         GJmVD2Jp+fj1dRVmeAzdS9DiW/q3Pp8PivzJBj8l8Weg/Olaa572dQjA4268uRppVwzz
         UVIg==
X-Gm-Message-State: AOAM530o1/q7HNOonKdRu4OS3e3u/7zCz27AhCbgv8GBlL0WU4DTI+IR
        omiG5U9aqXFVorgmWhIifqyHY9aWmJ3E0HEY54+OPQ==
X-Google-Smtp-Source: ABdhPJxxMXmWAigVetBbknCH4DYF1uDfItCk4A0H0BbWtzHTerVhk9pCqqb2Pc+RcoMsAzg5s1ehu5zhwwNheHliE4U=
X-Received: by 2002:a4a:e6c2:: with SMTP id v2mr8545609oot.74.1617904685371;
 Thu, 08 Apr 2021 10:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210330230249.709221-1-jiancai@google.com> <20210330232946.m5p7426macyjduzm@archlinux-ax161>
 <114a5697-9b5c-daf1-f0fc-dc190d4db74d@roeck-us.net> <CA+SOCLKbrOS9HJHLqRrdeq2ene_Rjs42ak9UzA=jtYb0hqWY1g@mail.gmail.com>
 <CA+SOCLLBgKtTz732O5zcrNs_F=iS6C2bE4HBmJfoPTum3Yu1oQ@mail.gmail.com>
 <20210331215802.r4rp6wynjqutdoup@archlinux-ax161> <CAKwvOdmoud9=Uf2xN7q1c1gP06ZNU4K2-Q5PDD-LTynHC+qOMA@mail.gmail.com>
In-Reply-To: <CAKwvOdmoud9=Uf2xN7q1c1gP06ZNU4K2-Q5PDD-LTynHC+qOMA@mail.gmail.com>
From:   Jian Cai <jiancai@google.com>
Date:   Thu, 8 Apr 2021 10:57:54 -0700
Message-ID: <CA+SOCLL67K=reMX=pBQzRV6dYbbS6EPVeOxZ8Xdw90P91Zb8Zw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix alignment mismatch.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Guenter Roeck <linux@roeck-us.net>,
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

So this issue is blocking the LLVM upgrading on ChromeOS. Nathan, do
you mind sending out the smaller patch like Nick suggested just to see
what feedback we could get? I could send it for you if you are busy,
and please let me know what tags I should use in that case.

Thanks,
Jian

On Wed, Mar 31, 2021 at 3:06 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Mar 31, 2021 at 2:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Wed, Mar 31, 2021 at 02:27:03PM -0700, Jian Cai wrote:
> > >
> > > I just realized you already proposed solutions for skipping the check
> > > in https://lore.kernel.org/linux-block/20210310225240.4epj2mdmzt4vurr3@archlinux-ax161/#t.
> > > Do you have any plans to send them for review?
> >
> > I was hoping to gather some feedback on which option would be preferred
> > by Jens and the other ClangBuiltLinux folks before I sent them along. I
> > can send the first just to see what kind of feedback I can gather.
>
> Either approach is fine by me. The smaller might be easier to get
> accepted into stable. The larger approach will probably become more
> useful in the future (having the diag infra work properly with clang).
> I think the ball is kind of in Jens' court to decide.  Would doing
> both be appropriate, Jens? Have the smaller patch tagged for stable
> disabling it for the whole file, then another commit on top not tagged
> for stable that adds the diag infra, and a third on top replacing the
> file level warning disablement with local diags to isolate this down
> to one case?  It's a fair but small amount of churn IMO; but if Jens
> is not opposed it seems fine?
> --
> Thanks,
> ~Nick Desaulniers
