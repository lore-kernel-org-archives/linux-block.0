Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC17FC433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9102561132
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 18:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhDHSM2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 14:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232666AbhDHSM1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Apr 2021 14:12:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54E9B610CA;
        Thu,  8 Apr 2021 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617905536;
        bh=BqztVmZIbJuytVg+mW+7eFDUwYfIKYJkiciFaVu9TIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHSt3CuP58xfpmbv3+G0Ltl/LM9Kc5xBAH6pMNsnTX3NNoi0E23Nrv0BkLMhjxYBl
         3EWuzdSBZdQt+zrka9nbYtdLVkArylHqgQUK43c2ioNQ0Yi4pSe6KJbIYyEZde2kNe
         V2USA7il7fkRZMfYMQyFMWOkBPKQaHIKxAkObwd+kC0bCQ+l3pEnMWY3Unw34GvXj9
         /7wVU9Jr9krrlCDKO8pEhXplY1laNvu3IcqnO7AqTYc87yJ1wWoGNhBBBHTM0l2ulo
         d7PJnRzV++6utaGfHjOx3G5bIBljgQLqP7Sxjt2gPFfC/LEnooJrjDLPEjZb8CwRM+
         JJ3IVH5J2xCAQ==
Date:   Thu, 8 Apr 2021 11:12:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jian Cai <jiancai@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Christopher Di Bella <cjdb@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: fix alignment mismatch.
Message-ID: <20210408181210.u7cudatr7zcmbmb2@archlinux-ax161>
References: <20210330230249.709221-1-jiancai@google.com>
 <20210330232946.m5p7426macyjduzm@archlinux-ax161>
 <114a5697-9b5c-daf1-f0fc-dc190d4db74d@roeck-us.net>
 <CA+SOCLKbrOS9HJHLqRrdeq2ene_Rjs42ak9UzA=jtYb0hqWY1g@mail.gmail.com>
 <CA+SOCLLBgKtTz732O5zcrNs_F=iS6C2bE4HBmJfoPTum3Yu1oQ@mail.gmail.com>
 <20210331215802.r4rp6wynjqutdoup@archlinux-ax161>
 <CAKwvOdmoud9=Uf2xN7q1c1gP06ZNU4K2-Q5PDD-LTynHC+qOMA@mail.gmail.com>
 <CA+SOCLL67K=reMX=pBQzRV6dYbbS6EPVeOxZ8Xdw90P91Zb8Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+SOCLL67K=reMX=pBQzRV6dYbbS6EPVeOxZ8Xdw90P91Zb8Zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jian,

On Thu, Apr 08, 2021 at 10:57:54AM -0700, Jian Cai wrote:
> So this issue is blocking the LLVM upgrading on ChromeOS. Nathan, do
> you mind sending out the smaller patch like Nick suggested just to see
> what feedback we could get? I could send it for you if you are busy,
> and please let me know what tags I should use in that case.
> 
> Thanks,
> Jian

I will go ahead and send the smaller patch at some point today.

For what it's worth, Nick brought up https://reviews.llvm.org/D100037,
which may be relevant here.

Cheers,
Nathan

> On Wed, Mar 31, 2021 at 3:06 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Mar 31, 2021 at 2:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Wed, Mar 31, 2021 at 02:27:03PM -0700, Jian Cai wrote:
> > > >
> > > > I just realized you already proposed solutions for skipping the check
> > > > in https://lore.kernel.org/linux-block/20210310225240.4epj2mdmzt4vurr3@archlinux-ax161/#t.
> > > > Do you have any plans to send them for review?
> > >
> > > I was hoping to gather some feedback on which option would be preferred
> > > by Jens and the other ClangBuiltLinux folks before I sent them along. I
> > > can send the first just to see what kind of feedback I can gather.
> >
> > Either approach is fine by me. The smaller might be easier to get
> > accepted into stable. The larger approach will probably become more
> > useful in the future (having the diag infra work properly with clang).
> > I think the ball is kind of in Jens' court to decide.  Would doing
> > both be appropriate, Jens? Have the smaller patch tagged for stable
> > disabling it for the whole file, then another commit on top not tagged
> > for stable that adds the diag infra, and a third on top replacing the
> > file level warning disablement with local diags to isolate this down
> > to one case?  It's a fair but small amount of churn IMO; but if Jens
> > is not opposed it seems fine?
> > --
> > Thanks,
> > ~Nick Desaulniers
