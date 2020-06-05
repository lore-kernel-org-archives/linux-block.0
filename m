Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D52C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 05:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B5B207D3
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 05:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4t9D42d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgFEFCe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEFCe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jun 2020 01:02:34 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDCBC08C5C1
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 22:02:33 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id c194so7205242oig.5
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 22:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLhG8vT3mFcuJfNnH7fIedUGeLesNM4v59nD7h+56nw=;
        b=W4t9D42dX/56NXPsywgadSq1thAD+GBBNZ2NskdtxGtqGfB6W7bJc91zMjQaW8u9K+
         PqZjoIuBP+98duTt+Ut1YmhyPoK0drKLNOMtvNld7YWVlgPyKmlLu4bnaln1gwu/VaHT
         2vbUMflI5BgaYHDLrMyFc84JQ/Dq0wml3E0PgmdWlEKMLgRBUfR3OtUr5bUP3MAdqIIL
         icH74YMBAM7dT2TA1X4czgSHNIuOps1FNtX9fuIXIM29XNVFSwriA8mH6DaZLO6NRehm
         jEuWHBLG6DRdj1SiFEGDj7av12mi0DG90mt2Aq5qCOd9tcbg1VsMAII93br1w2QoQIxa
         ebQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLhG8vT3mFcuJfNnH7fIedUGeLesNM4v59nD7h+56nw=;
        b=P60bvu3mXVlPQWigJj6lUCb2fP3TDukQoAU7y5dHCbYzqCElSEKedka+zHe2n3xXC2
         20pNpNfPOHlpbtdusQioHCvQzFHbGd1Iys7379hJ82Vytuwi2ifxyIdD5UZBSjh75qjD
         PqpAVrRqi4tNZhLZWlSiWcPpoB40wM3G1JKLh460FEXeFJtaNr9UrMW0XYnMTytqHUna
         hJOQ+LSnADgwLiguwrwVCuOeRVNYVMAIsRllhsFPCx9fjlfLNXMwI7t/BZ3TO799E9nR
         9tuSXRRQE9eOXEi1auUVJEUR6n2RK+CTrD0lNTvmc1KgDMMl/FP6OuqTRnBFoqqIh6RT
         sXYg==
X-Gm-Message-State: AOAM532dM16SynqGh56V0EvTnKrHrlv+dXC8qzZsoqNuJs4yF0Mmn5yy
        ro9TinkbtT2RL4IgyJU85E52d/pQM5CGoW2mk0I=
X-Google-Smtp-Source: ABdhPJzfADqkcFrvslW1/AbrDQJe88vAdJaupnE9QInvSjXNnmSTgwA97U2phX1XMxD1ZNmvOkN8t2ZEzFwWG+ET7eE=
X-Received: by 2002:aca:cf43:: with SMTP id f64mr801134oig.141.1591333352465;
 Thu, 04 Jun 2020 22:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com> <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org>
In-Reply-To: <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 4 Jun 2020 22:02:21 -0700
Message-ID: <CAD+ocbzdh0eq+wBQ-DqUUw_Gvwc0xv-FbBUNS0aZfpn+eToUEg@mail.gmail.com>
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On Thu, Jun 4, 2020 at 9:31 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-06-03 22:44, Harshad Shirwadkar wrote:
> > Make sure that user requested memory via BLKTRACESETUP is within
> > bounds. This can be easily exploited by setting really large values
> > for buf_size and buf_nr in BLKTRACESETUP ioctl.
> >
> > blktrace program has following hardcoded values for bufsize and bufnr:
> > BUF_SIZE=(512 * 1024)
> > BUF_NR=(4)
>
> Where is the code that imposes these limits? I haven't found it. Did I
> perhaps overlook something?

From what I understand, these are not limits. These are hardcoded
values used by blktrace userspace when it calls BLKTRACESETUP ioctl.
Inside the kernel, before this patch there is no checking in the linux
kernel.

>
> > diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
> > index 690621b610e5..4d9dc44a83f9 100644
> > --- a/include/uapi/linux/blktrace_api.h
> > +++ b/include/uapi/linux/blktrace_api.h
> > @@ -129,6 +129,9 @@ enum {
> >  };
> >
> >  #define BLKTRACE_BDEV_SIZE   32
> > +#define BLKTRACE_MAX_BUFSIZ  (1024 * 1024)
> > +#define BLKTRACE_MAX_BUFNR   16
> > +#define BLKTRACE_MAX_ALLOC   ((BLKTRACE_MAX_BUFNR) * (BLKTRACE_MAX_BUFNR))
>
> Adding these constants to the user space API is a very inflexible
> approach. There must be better approaches to export constants like these
> to user space, e.g. through sysfs attributes.
>
> It probably will be easier to get a patch like this one upstream if the
> uapi headers are not modified.

Thanks, makes sense. I'll do this in the V2. If we do that, we still
need to define the default values for these limits. Do the values
chosen for MAX_BUFSIZE and MAX_ALLOC look reasonable?

>
> >  /*
> >   * User setup structure passed with BLKTRACESETUP
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index ea47f2084087..b3b0a8164c05 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -482,6 +482,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> >       if (!buts->buf_size || !buts->buf_nr)
> >               return -EINVAL;
> >
> > +     if (buts->buf_size * buts->buf_nr > BLKTRACE_MAX_ALLOC)
> > +             return -E2BIG;
> > +
> >       if (!blk_debugfs_root)
> >               return -ENOENT;
>
> Where do the overflow(s) happen if buts->buf_size and buts->buf_nr are
> large? Is the following code from relay_open() the only code that can
> overflow?
>
>         chan->alloc_size = PAGE_ALIGN(subbuf_size * n_subbufs);

Good catch, I'm not sure if the overflows are checked for, but I maybe
wrong. Given the possibility of overflows, perhaps we should be
checking for individual upper bounds instead of the product?

Thanks,
Harshad

>
> Thanks,
>
> Bart.
>
