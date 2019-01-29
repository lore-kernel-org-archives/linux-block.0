Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3828C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB672083B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfA2Qqm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:46:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34252 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfA2Qqm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 11:46:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so23030138qtp.1;
        Tue, 29 Jan 2019 08:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFOtMZARozBLOdkxDxm7uc5sYi3GnMM0oX5d7uWJvM0=;
        b=cSbSi+Ii9RMqwoTe8m3OYdd17fyzHvD1+rQfVAgFCobEBJkSMfmx+6HqEdTnw4NB1u
         LMHHeC4Vd3iQh/4PG5KPLSHgjwjFICzyy2ud5VQGrrU276wMxlLWuf1FU0ubwCsj3/JG
         Bh6M8wc1gDyrjwWhlWKuzvrImjelyBqoqZU5XZLy34CieC70ZBh4449AZhai46xLR7tE
         1pQasJH70NQoIw3Dl8xqrnh6qMmbC+kZJ/XejIbSj3YeCnOai9wdXRmtV4f16Vxbh9kc
         c28BglNvfzNHeLBae08Ec7RU1zoV7N+ACUcSzx0M1rSWfQ+Qx4lMJzFjY+r2p1yPhB9x
         ia/Q==
X-Gm-Message-State: AJcUukd03qaB1atQ6l13FzQG/qoeF7U5gQtSVS6n/nHGsIj/mj4P8pzf
        //doUYpARj52n9VAxp0F/CzXNppzKjnr0E1+aFSUxQSC
X-Google-Smtp-Source: ALg8bN4SmrGEwAZwuOmWR5VpEGMa5FxtcFmKkv6y3WbiTQnWyOfjJwQquwsjQ6QLujjHElxFI+7PyV+hca4a79cHWds=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr25787393qvj.161.1548780400862;
 Tue, 29 Jan 2019 08:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20190123153536.7081-1-axboe@kernel.dk> <20190123153536.7081-6-axboe@kernel.dk>
 <20190128145700.GA9795@lst.de> <2729ab43-b2bf-44b0-d41d-dbb495ddffbf@kernel.dk>
 <20190129063043.GC2996@lst.de> <CAK8P3a1x4BsFfacxOmaDXKOKmmQ2j0ypX2+mCNCbjH3E7nC4DQ@mail.gmail.com>
 <4b12d149-99f7-0b2e-0c3f-9b477ce48520@kernel.dk> <CAK8P3a38-FLBH0sp0vaebv29M5oDyiUkwwmVY+9_S3vSER9n5Q@mail.gmail.com>
 <9a66c000-62f3-7567-7919-31e61e28defa@kernel.dk> <CAK8P3a1=kho718OSdZ0zp5g3mwmsYbd5J-e58kDyq2QMBCak=Q@mail.gmail.com>
 <4395ae02-54fe-d5fe-dea9-c50f7eaba3b1@kernel.dk>
In-Reply-To: <4395ae02-54fe-d5fe-dea9-c50f7eaba3b1@kernel.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 29 Jan 2019 17:46:24 +0100
Message-ID: <CAK8P3a3+RHqoAST7TXyL1NX_5OjuFpi8M-5xuuX3y4DU_xNk+g@mail.gmail.com>
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

On Tue, Jan 29, 2019 at 5:28 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/29/19 9:26 AM, Arnd Bergmann wrote:
> > On Tue, Jan 29, 2019 at 5:19 PM Jens Axboe <axboe@kernel.dk> wrote:
> >> On 1/29/19 9:18 AM, Arnd Bergmann wrote:
> >>> On Tue, Jan 29, 2019 at 4:20 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>> That's good info. I am currently using set_user_sigmask() for it.
> >>>> I'd really like to avoid having to pass in a sigset_t size for the
> >>>> system call, however.
> >>>
> >>> I really wouldn't do it, given that all other signal handling interfaces
> >>> are prepared for longer signal masks. You /could/ probably extend
> >>> it later with a flags bit to signify a longer mask instead of using
> >>> the entire register to hold the bit length, it just seems really
> >>> inconsistent with all other system calls.
> >>
> >> Damnit! OK, I'll keep what I currently have then.
> >
> > As long as you stay within the 6-argument syscall contraints,
> > the cost of passing the length is basically free, right?
> >
> > Is there anything else you are worried about?
>
> My main worry is not the extra argument, more that we're at capacity
> for the system call. If we wanted to add a timeout parameter, then we'd
> need to bundle them up, which sucks.

Ok, got it. If it turns out that we do need the timeout argument after all,
you could avoid one indirection level by grouping the sigset_t with
min_complete, timeout_ns and/or sigset_size, as long as the
sigset_t comes last (similar to struct sigaction).

Another (also awkward) trick might be to combine min_complete and
sigset_size into a 32-bit integer argument, as each of them can
fit into 16 bits.

      Arnd
