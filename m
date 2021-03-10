Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE61C433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 20:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84A664F58
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 20:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCJUdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 15:33:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhCJUd1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 15:33:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3714D64FB3;
        Wed, 10 Mar 2021 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615408406;
        bh=OJnZxm8CcetkOZ55C4tsAeBTnG2Ccq7MXXTmvkchl9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4tUPg34U8CBqEZQ2EwErNfCtqPiAHb/lvFZi0wM6RSj6J859+Ae+sVpNXv//i8bk
         ooXoeCUKPecd0uY2Yyfvc4iwWnHNV2mL65TlazKg/C0wp92ynF329n33RBf4QgQrrO
         NO7JH2iIK//3uK+EU0pFOFhJ7k1R7Kr+7oXKfwoCe0mCazG9zuqy5E5h1zqkzVqeAs
         xSPTUyCIeL+ggVAEfjPeOlmZxwT948pGQwo49KtqbO5mrfqDnrzn3j6WZR33rLzzX+
         ckoX//fcnvQ667FuhbQQBex7tKWmYdkXlSbvwFeC5JWWUBr3rWcv4CsUiwYG66q80h
         qAkoN6lixZV/g==
Date:   Wed, 10 Mar 2021 13:33:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: -Walign-mismatch in block/blk-mq.c
Message-ID: <20210310203323.35w2q7tlnxe23ukg@Ryzen-9-3900X.localdomain>
References: <20210310182307.zzcbi5w5jrmveld4@archlinux-ax161>
 <99cf90ea-81c0-e110-4815-dd1f7df36cb4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99cf90ea-81c0-e110-4815-dd1f7df36cb4@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 10, 2021 at 01:21:52PM -0700, Jens Axboe wrote:
> On 3/10/21 11:23 AM, Nathan Chancellor wrote:
> > Hi Jens,
> > 
> > There is a new clang warning added in the development branch,
> > -Walign-mismatch, which shows an instance in block/blk-mq.c:
> > 
> > block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to
> > 32-byte aligned parameter 2 of 'smp_call_function_single_async' may
> > result in an unaligned pointer access [-Walign-mismatch]
> >                 smp_call_function_single_async(cpu, &rq->csd);
> >                                                     ^
> > 1 warning generated.
> > 
> > There appears to be some history here as I can see that this member was
> > purposefully unaligned in commit 4ccafe032005 ("block: unalign
> > call_single_data in struct request"). However, I later see a change in
> > commit 7c3fb70f0341 ("block: rearrange a few request fields for better
> > cache layout") that seems somewhat related. Is it possible to get back
> > the alignment by rearranging the structure again? This seems to be the
> > only solution for the warning aside from just outright disabling it,
> > which would be a shame since it seems like it could be useful for
> > architectures that cannot handle unaligned accesses well, unless I am
> > missing something obvious :)
> 
> It should not be hard to ensure that alignment without re-introducing
> the bloat. Is there some background on why 32-byte alignment is
> required?
> 

This alignment requirement was introduced in commit 966a967116e6 ("smp:
Avoid using two cache lines for struct call_single_data") and it looks
like there was a thread between you and Peter Zijlstra that has some
more information on this:
https://lore.kernel.org/r/a9beb452-7344-9e2d-fc80-094d8f5a0394@kernel.dk/

Cheers,
Nathan
