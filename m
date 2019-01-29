Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2B7C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609142175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfA2Q05 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:26:57 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38181 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfA2Q05 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 11:26:57 -0500
Received: by mail-qk1-f196.google.com with SMTP id m17so11854848qki.5;
        Tue, 29 Jan 2019 08:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+oFI+S/ydcLe9SJt/mvxYvObuKKZslUCh9NpMSWjig=;
        b=oD6V3f0UCFN3hh1qD5UH/P30b6gdTRxlRZNh2pIflkDT2L3x4o8sFKPyMTPcKoHLPa
         NT1ezhLFhEGwcaq6aHZ7CWpMbBJCAiBeT+FNJNqK/wzVSQAkN+auCCkCDPLKgbbrQq+L
         GATANHakodWe2MwPEiZyGqXGX6P6GyF7r2XmF9IrcyA8js73erwtZpoKrC4xNiIPlwGA
         j9lEds8CS2B15tfKAEscViomDZiqhwr6DYvZmQylXq16LV5ek3hwV+9TD79gRzCXgTiH
         1ehifMt8Z3OYjLpLOpN0uxr0Xn+Xp/MO1/LUK/PNJy2fjxpebXxvcecGPSZyzbmYQByk
         kzkg==
X-Gm-Message-State: AJcUukeu1oxzm8wZWGXcl8sBL6qk4QqNHMTH2D498pn4DYRAlR1YnswK
        51/eOH0CpBj929AREHxEiQsANDZbM/giqo7QGFc=
X-Google-Smtp-Source: ALg8bN7Kbs/KC9w5cfLkOXcvaeZbh1Op06x7D5qu6hdeVC5B0/4ZHpvoE7GOC4JadgPtYlsmMxNhZGSMhCYadK33ZOQ=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr23079431qkf.107.1548779216397;
 Tue, 29 Jan 2019 08:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-6-axboe@kernel.dk>
 <20190128145700.GA9795@lst.de> <2729ab43-b2bf-44b0-d41d-dbb495ddffbf@kernel.dk>
 <20190129063043.GC2996@lst.de> <CAK8P3a1x4BsFfacxOmaDXKOKmmQ2j0ypX2+mCNCbjH3E7nC4DQ@mail.gmail.com>
 <4b12d149-99f7-0b2e-0c3f-9b477ce48520@kernel.dk> <CAK8P3a38-FLBH0sp0vaebv29M5oDyiUkwwmVY+9_S3vSER9n5Q@mail.gmail.com>
 <9a66c000-62f3-7567-7919-31e61e28defa@kernel.dk>
In-Reply-To: <9a66c000-62f3-7567-7919-31e61e28defa@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 29 Jan 2019 17:26:39 +0100
Message-ID: <CAK8P3a1=kho718OSdZ0zp5g3mwmsYbd5J-e58kDyq2QMBCak=Q@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 5:19 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/29/19 9:18 AM, Arnd Bergmann wrote:
> > On Tue, Jan 29, 2019 at 4:20 PM Jens Axboe <axboe@kernel.dk> wrote:
> >> That's good info. I am currently using set_user_sigmask() for it.
> >> I'd really like to avoid having to pass in a sigset_t size for the
> >> system call, however.
> >
> > I really wouldn't do it, given that all other signal handling interfaces
> > are prepared for longer signal masks. You /could/ probably extend
> > it later with a flags bit to signify a longer mask instead of using
> > the entire register to hold the bit length, it just seems really
> > inconsistent with all other system calls.
>
> Damnit! OK, I'll keep what I currently have then.

As long as you stay within the 6-argument syscall contraints,
the cost of passing the length is basically free, right?

Is there anything else you are worried about?

     Arnd
