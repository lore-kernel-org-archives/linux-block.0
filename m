Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F10C33CB1
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253CA207FF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="PbMEuBcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgAPQsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:48:32 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:43367 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbgAPQsa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 11:48:30 -0500
Received: by mail-il1-f196.google.com with SMTP id v69so18756687ili.10
        for <linux-block@vger.kernel.org>; Thu, 16 Jan 2020 08:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFLululrHyNVTerjV5qHGSuYnmSk+QWZwMjtdQsoK/0=;
        b=PbMEuBcJAwCk3nMl9/l/u/X8Erkh52bBa9x/blf0HuWLu6Jca1LktHJ1lftbuyHEUz
         bBYfMofflBjMVTqc+JYEKd8hgz9TFkGmO7ny94+irja4ELai5SlgLffjZcEopWFK9Xj1
         Z7spjwzPgWQOSvfWsYelLk5u6cruLt2eUb3LwNkunvLROcQ7ddIn/NEkcoe/HqfbE3LF
         sH9SNIH+lwL4Em87tAvgXD4r/UplkR/rZXfIOJ3W1bteGFxoOdDRFBl5PtPTH0Qb69EW
         B9Gp2Ca2eCm+TQW6il0nlbCgwh9oCqzQ1Me4pOiIoKYnP5UbAcof0tiu4JJKVp/MecCt
         lNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFLululrHyNVTerjV5qHGSuYnmSk+QWZwMjtdQsoK/0=;
        b=iiuxm7/Rd0Z5X7VUtDY5iCrmwgkVYSFL4/bMrKVnL45TXu1F0DaAOvAS2UHNPI45TB
         hucctEqCKHgBdV1lc3682L8/3YT1E+NMmhyb7Y0TXX0RsalJ1EaC+MvwPcnPOntpLp19
         nMOHqtCb9BrpH7cdaQpJ5gWpLm19fmrJldnt8DnCrMNtUE9sNKE3scKWdaL/S6hjj6KT
         YFPJx9STzt4jWhNJaQC1/mGEYu+Gg5w6w8yoDGBA1u0TZHsU1CqXgRON6l68hIguKszV
         lSXv7DcQq5BJsPWiUPpLK7mPavvpurVFzTdGNd49TC3BYum+ysCm7iXSmQatsl4z1p8J
         Z/Bg==
X-Gm-Message-State: APjAAAXcgwZ2/An8hokirTaYAt13trdB6msqClQIhygnEyfO0qbA8kW/
        W3QNYQV7P4OX7n30BG/dGqSRD0URi3gKZCn49KLY8A==
X-Google-Smtp-Source: APXvYqwsk6jeD0P2DEllAtVfuNPrwHKY6gD0RDqyTH2mR+m786/lNvecRXjSb2uDyeKol/hWpYHP2nTVq7rq5LZT+Q8=
X-Received: by 2002:a05:6e02:f0f:: with SMTP id x15mr4147307ilj.298.1579193310228;
 Thu, 16 Jan 2020 08:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-7-jinpuwang@gmail.com>
 <20200116145300.GC12433@unreal> <CAMGffE=pym8iz4OVxx7s6i37AU+KPFN3AeVrCTOpLx+N8A9dEQ@mail.gmail.com>
 <20200116155301.GC10759@ziepe.ca>
In-Reply-To: <20200116155301.GC10759@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 16 Jan 2020 17:48:19 +0100
Message-ID: <CAMGffE=0VX2SwNFBd+EeR3Grh=bSGrkGFqbWkORYoocDbYUy6g@mail.gmail.com>
Subject: Re: [PATCH v7 06/25] RDMA/rtrs: client: main functionality
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, Jack Wang <jinpuwang@gmail.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 16, 2020 at 4:53 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jan 16, 2020 at 04:43:41PM +0100, Jinpu Wang wrote:
> > > > +             wake_up(&clt->permits_wait);
> > > > +}
> > > > +EXPORT_SYMBOL(rtrs_clt_put_permit);
> > > > +
> > > > +struct rtrs_permit *rtrs_permit_from_pdu(void *pdu)
> > > > +{
> > > > +     return pdu - sizeof(struct rtrs_permit);
> > >
> > > C standard doesn't allow pointer arithmetic on void*.
> > gcc never complains,  searched aournd:
> > https://stackoverflow.com/questions/3523145/pointer-arithmetic-for-void-pointer-in-c
> >
> > You're right, will fix.
>
> The kernel extensively uses a gcc extension treating arithmatic on a
> void * as the same as a u8, you can leave it for kernel code.
>
> But is generally a big question why code is written like that, always
> better to use a struct and container_of
>
> Jason
Thanks, in fact, it's just a function not used, will remove.
