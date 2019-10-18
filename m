Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88DECA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 18:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B001C20640
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 18:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0UUcQvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439739AbfJRSul (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:50:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33070 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437152AbfJRSul (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 14:50:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id 60so5842760otu.0
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2019 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7EnrByqqmIEOE49ABywAAVgG26tp5mIBrzx9j+J3oos=;
        b=u0UUcQvpz+1gbP+h4cldoESnznhOX0XqEqXtrcUKWnyuaM+2dg4F/retf8PVcJg1PQ
         DrBELOX855otVJzL7wbThV05XeXJWbdEB6T1f6r/Ne4TRKPzzZsgijxKaKRmyQPyjIkQ
         iry7kcvdl5NHFM+yUcQZIljHRQxO8+eS8Nqwmuvv+NLue2T9pVq0N/NvKwiX/ldELeUi
         sdoM3+KtsnGzdi+broftz4GwymOj4wMaFU3aaAQamK24+eo6mF3tmnk8AtntnbLzF5+V
         /BmfWgCc2BLw9nN+No5hOy6VsI2nt40HdouCXrGRLRdXwAPh1Gk3Yi+/gowZYbsdhfa6
         SIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7EnrByqqmIEOE49ABywAAVgG26tp5mIBrzx9j+J3oos=;
        b=mpsU64bGRb0Eb1g6ff31agu4S13k5hdoKLUqPLjr340SvRpCQG1+iEVHeLFAryqdVD
         zai+OmKfDHEX/dQ6N4xM9yRjD72XcQwWp/24M6MGluRv6+8tXEYAuI4ypHrT3DavB8oV
         ui53/whPI1drSldvY/tJsqMASgIgwhVmZglBf+mb+6uLyS3uSdGzi7aH3ArcA9SSwF/N
         SrPXn3bY4H8SiGLurjjfOfg1sF8AkqP4qaMqyysKVp/RcoKDmKVWId6Kk0kAjjY+31v7
         j1FgOVbOiZ4G2JsB27crQbXFh/+sKmR6de83YukCig6SL8AsV+JYLmb8vDAhc9M2K+Qw
         e6nw==
X-Gm-Message-State: APjAAAXYfuZzvxFgMPSVHO0qy72i8H5r1QseoJ/7qxwudZDRlEeQkj8w
        Y2O/if1sctqrlq1KAhzPPNgegLJPwOwY+UVRi5gofQ==
X-Google-Smtp-Source: APXvYqxxb9IdW237LWetjO5OJn473qUaKFx1pSxkH15+mKxJDSS5qABWBzt0RrNFmzsyyQ1uuySl6R50BT7+O3n7uvk=
X-Received: by 2002:a9d:19ee:: with SMTP id k101mr9069469otk.183.1571424639674;
 Fri, 18 Oct 2019 11:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191017212858.13230-1-axboe@kernel.dk> <20191017212858.13230-2-axboe@kernel.dk>
 <CAG48ez0G2y0JS9=S2KmePO3xq-5DuzgovrLFiX4TJL-G897LCA@mail.gmail.com>
 <0fb9d9a0-6251-c4bd-71b0-6e34c6a1aab8@kernel.dk> <CAG48ez181=JoYudXee0KbU0vDZ=EbxmgB7q0mmjaA0gyp6MFBQ@mail.gmail.com>
 <a54329d5-a128-3ccd-7a12-f6cadaa20dbf@kernel.dk> <CAG48ez1SDQNHjgFku4ft4qw9hdv1g6-sf7-dxuU_tJSx+ofV-w@mail.gmail.com>
 <dbcf874d-8484-9c27-157a-c2752181acb5@kernel.dk> <CAG48ez3KwaQ3DVH1VoWxFWTG2ZfCQ6M0oyv5vZqkLgY0QDEdiw@mail.gmail.com>
 <a8fb7a1f-69c7-bf2a-b3dd-7886077d234b@kernel.dk> <572f40fb-201c-99ce-b3f5-05ff9369b895@kernel.dk>
 <CAG48ez12pteHyZasU8Smup-0Mn3BWNMCVjybd1jvXsPrJ7OmYg@mail.gmail.com>
 <20b44cc0-87b1-7bf8-d20e-f6131da9d130@kernel.dk> <2d208fc8-7c24-bca5-3d4a-796a5a8267eb@kernel.dk>
 <CAG48ez2ZQBVEe8yYRwWX2=TMYWsJ=tK44NM+wqiLW2AmfYEcHw@mail.gmail.com> <0a3de9b2-3d3a-07b5-0e1c-515f610fbf75@kernel.dk>
In-Reply-To: <0a3de9b2-3d3a-07b5-0e1c-515f610fbf75@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Oct 2019 20:50:12 +0200
Message-ID: <CAG48ez1akvnVpK3dMH4H=C2CsNGDZkDaxZEF2stGAPCnUcaa+g@mail.gmail.com>
Subject: Re: [PATCH 1/3] io_uring: add support for async work inheriting files table
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 18, 2019 at 8:16 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 10/18/19 12:06 PM, Jann Horn wrote:
> > But actually, by the way: Is this whole files_struct thing creating a
> > reference loop? The files_struct has a reference to the uring file,
> > and the uring file has ACCEPT work that has a reference to the
> > files_struct. If the task gets killed and the accept work blocks, the
> > entire files_struct will stay alive, right?
>
> Yes, for the lifetime of the request, it does create a loop. So if the
> application goes away, I think you're right, the files_struct will stay.
> And so will the io_uring, for that matter, as we depend on the closing
> of the files to do the final reap.
>
> Hmm, not sure how best to handle that, to be honest. We need some way to
> break the loop, if the request never finishes.

A wacky and dubious approach would be to, instead of taking a
reference to the files_struct, abuse f_op->flush() to synchronously
flush out pending requests with references to the files_struct... But
it's probably a bad idea, given that in f_op->flush(), you can't
easily tell which files_struct the close is coming from. I suppose you
could keep a list of (fdtable, fd) pairs through which ACCEPT requests
have come in and then let f_op->flush() probe whether the file
pointers are gone from them...
