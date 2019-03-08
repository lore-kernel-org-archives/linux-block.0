Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14B3C43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 22:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CFA20857
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 22:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552085753;
	bh=5LVU4CwJIR0ViXcHaM9ZWACdCHo/5XTGwKRhfPnFIh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QOjStbDmqV5kS7mNX1frDScH3PalkKoXeHwu8hd89wx5coZTonI2qIELDrUUWhgQR
	 NDpZQuVzVZcK3T6npX886oR9xrTkinkWNj6J2lredNgd2X95ZUxFAZ6TSIZKZkN9bE
	 yppIJaB4zExmxv6hMtyRpQ+dli4AwOA+SrhqId7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCHWzx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:55:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33467 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfCHWzw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 17:55:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id z23so15385840lfe.0
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 14:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNKR2ldy22W3Wy4LlweEp4+EE9Adg5YCnspdgt5KT+4=;
        b=YfdwYKx3mgfrC13R3hJUC++CK2e9F7QNpPmUFhVVhxXkdvh0pK8nRGAVvT1Qq6wrp4
         PSOZbOwN99EG8zkGLL3PS0j0C6PrBgjele0eBSYGgOG+bH1uFAt/jsDSSyZpo4BFbqAd
         LJ5+bSlFYzlF85XihHAPA7v1+aFLNREJz/pTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNKR2ldy22W3Wy4LlweEp4+EE9Adg5YCnspdgt5KT+4=;
        b=M+Uuou6/ub+dEA+DKzccaZ7f0QK7JsRe6GF9GSg6cVsDhIyM3YSoJ+M0fKGBl3Fi+m
         QPSmsR8/SRyZhfNyJw/0MrH3nVTe+XhH4KXlDnzUD4R6FDB7OtBRyFTb1MTENJMkuUcx
         U8NIboCEfiuSJGMzW+141Dyx6NL/7u8ZpfnWKcPIR9dH9w6vFJ2qJgf1968ieCVFu2RQ
         +0LGYcRcBz2VHsX7LiXOI8r6q8+V8wX/m0CHbynf7QnfmovaoAlfin5nsruSQ0xjbWwM
         vqBVwqiFTv35zKOrgIVJEuDFm7gFxXsh+cWJpQCcqi4qbz9Sxgyx5FBbTze2quskC5LR
         TPQw==
X-Gm-Message-State: APjAAAVtZquky73G/YDwo+F7oQtJtloOFIHjDToOfGDsmVfPkPwetL3M
        XPpAe62iHMtJQ6SRpHc+auoeXunhRHY=
X-Google-Smtp-Source: APXvYqyviZtoY42TMQa35RGiUOVCTvM/nnInCtc257lOhvCRIogeJnQFrWhV+npKmuuzL6mU0rGVVw==
X-Received: by 2002:a19:7516:: with SMTP id y22mr10409712lfe.106.1552085750407;
        Fri, 08 Mar 2019 14:55:50 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n25sm1706522lfe.70.2019.03.08.14.55.48
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 14:55:49 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id z25so18780697ljk.8
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 14:55:48 -0800 (PST)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr10463984lji.135.1552085748284;
 Fri, 08 Mar 2019 14:55:48 -0800 (PST)
MIME-Version: 1.0
References: <db961c75-8468-b5ec-1201-1ba0b37fa30a@kernel.dk> <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk>
In-Reply-To: <5c128dfd-9e6c-21fe-7b2b-397d495e112a@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Mar 2019 14:55:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
Message-ID: <CAHk-=whtxVReSOZ2NpP7O-N+fwNw0hctBr1LdbTZ6Fu32=xcWg@mail.gmail.com>
Subject: Re: [GIT PULL] Support for the io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 6, 2019 at 12:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Slight mess up in the stats, here's the correct one... Note that this
> also throws a few more merge conflicts now, due to the syscall merges.
> All trivial, though, and the branch was prepared for it in terms of
> numbering.

Ok, merged in my tree, but not pushed out yet.

I'm going to run the usual build tests, but also look at the basic
sanity tests and boot and run them just to be careful before actually
doing that final "ok pushed out".

                  Linus
