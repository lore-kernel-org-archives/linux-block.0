Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB4DC433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 15:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31037207F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 15:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJptTsl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgFDP0T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgFDP0T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 11:26:19 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4244EC08C5C0
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 08:26:19 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s21so5395654oic.9
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSADmdbVCiNC9Ki2APyoC7YsMa+jSTxASJIEHNj3OrE=;
        b=WJptTsl/KnIhHazDis0SXQMp1kCeb3QdLLDkC/QrIZ8jhxBFMv4JO56SN2JMApyhUk
         xQqVy8YmoJSFyvBVvco81HcrqPzPvlpOM7/82W3Jb8KpWd0Qf9lrqE9mtUaO4VJqMqBt
         Uea5ME8ttOylMC3szt/ivV5e1JEAqip07RpdVRmlg9Q4tR9zZ7Luk6N52gTChppIGPiI
         pfQaL0C2dcspNWYL/q43I6ElkRr2o0iTtOU62cAkZC1mPwJWrv5alGsCq2hCRzvPd+nJ
         ELQu7TViSRX6kFOiiM3ob2GpeEEFK+4b2vXMYX26K0HS3GJxpMBmG0ivGzUDzU89i/54
         fRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSADmdbVCiNC9Ki2APyoC7YsMa+jSTxASJIEHNj3OrE=;
        b=QGxrip/DTJ13mm5Qax03s/UnyW92fMa04xNcFo8MDBOZTCYnKAKHFwnO+csklFeQ0F
         squuM5JkhCxg5x8qhywko6GLe/Nr3z0UNAApOgAWwuYK78ud8wcNPs+mEsTo4xeaUctN
         4cTIja/7n9MD3TSTt696sX79uV5cvqfowNRkYgA3CJctloYKp0lg8BVVJsAbDR/DDEIK
         31jTM/uDQtRukni8ujkN3Lu6brnQor/2kbOg+o6VZeBKzxSspPK2gc3YVpfHsKTWJoV3
         X+MtOUdKy6eqWgluwC8d5yQj4KHya1FVFsfRHwHYurL29Uv5t70tJXvKNb+ZJaksot/6
         s1yg==
X-Gm-Message-State: AOAM53202Xr8dBR3oHXAg5QMBnFZP6KAbWFFY7tcatXaawAxCYkXUbiu
        SydgZR6VnpfJmxfCLPonWWKm65eWK9JNU+poyeXS+dO+
X-Google-Smtp-Source: ABdhPJzlElZd2ZUFSF/N+LWoqsejHKX0eaBBqTxrY4sA2u2KWebztjrdl3lNddt/q/BEIn0NwutvVD3bQi+DCRbGc1E=
X-Received: by 2002:aca:3107:: with SMTP id x7mr3484039oix.17.1591284378286;
 Thu, 04 Jun 2020 08:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com> <BYAPR04MB49657DD3AC2B7E7F4496BF6486890@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49657DD3AC2B7E7F4496BF6486890@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 4 Jun 2020 08:26:07 -0700
Message-ID: <CAD+ocbzvhASrN+43B_9pH7rmvJKyOo2ZEZBgUsJY3rxR1Fx=QQ@mail.gmail.com>
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 4, 2020 at 12:10 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 6/3/20 10:45 PM, Harshad Shirwadkar wrote:
> > Make sure that user requested memory via BLKTRACESETUP is within
> > bounds. This can be easily exploited by setting really large values
> > for buf_size and buf_nr in BLKTRACESETUP ioctl.
> >
> > blktrace program has following hardcoded values for bufsize and bufnr:
> > BUF_SIZE=(512 * 1024)
> > BUF_NR=(4)
> >
> > We add buffer to this and define the upper bound to be as follows:
> > BUF_SIZE=(1024 * 1024)
> > BUF_NR=(16)
> >
> Aren't these values should be system dependent to start with?
> I wonder what are the side effects of having hard-coded values ?
Sure we can have system dependent bounds. But, the goal here is just
only to ensure that the caller doesn't call BLKTRACESETUP with
unreasonable values and potentially crash the kernel. Given that, do
we really need to have upper-bound to be system dependent? wouldn't a
hard-coded but reasonable upper-bound be sufficient? As of now
blktrace also uses hardcoded values.
> > This is very easy to exploit. Setting buf_size / buf_nr in userspace
> > program to big values make kernel go oom.  Verified that the fix makes
> > BLKTRACESETUP return -E2BIG if the buf_size * buf_nr crosses the upper
> > bound.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> >   include/uapi/linux/blktrace_api.h | 3 +++
> >   kernel/trace/blktrace.c           | 3 +++
> >   2 files changed, 6 insertions(+)
> >
> > diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
> > index 690621b610e5..4d9dc44a83f9 100644
> > --- a/include/uapi/linux/blktrace_api.h
> > +++ b/include/uapi/linux/blktrace_api.h
> > @@ -129,6 +129,9 @@ enum {
> >   };
> >
> >   #define BLKTRACE_BDEV_SIZE  32
> > +#define BLKTRACE_MAX_BUFSIZ  (1024 * 1024)
> > +#define BLKTRACE_MAX_BUFNR   16
> > +#define BLKTRACE_MAX_ALLOC   ((BLKTRACE_MAX_BUFNR) * (BLKTRACE_MAX_BUFNR))
> >
> This is an API change and should be reflected to kernel & userspace
> tools. One way of doing it is to remove BUF_SIZE and BUF_NR and sync
> kernel header with userspace blktrace_api.h.
Thanks, so we should make a change in userspace header file too.
> >   /*
> >    * User setup structure passed with BLKTRACESETUP
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
>
> On the other hand we can easily get rid of the kernel part by moving
> this check into user space tools, this will minimize the change diff and
> we will still have sane behavior.
>
> What about something like this (completely untested/not compiled) :-
>
> diff --git a/blktrace.c b/blktrace.c
> index d0d271f..d6a9f39 100644
> --- a/blktrace.c
> +++ b/blktrace.c
> @@ -2247,6 +2247,9 @@ static int handle_args(int argc, char *argv[])
>          if (net_mode == Net_client && net_setup_addr())
>                  return 1;
>
> +       /* Check for unsually large numbers for buffers */
> +       if (buf_size * buf_nr > BLKTRACE_MAX_ALLOC)
> +               return -E2BIG;
>          /*
>           * Set up for appropriate PFD handler based upon output name.
>           */
>
> >       if (!blk_debugfs_root)
> >               return -ENOENT;
> >
> >
The user-space fix would fix blktrace binary but it's still easy to
exploit this by writing a really quick program that calls
BLKTRACESETUP ioctl with unreasonably high values for buf_size and
buf_nr.

Thanks,
Harshad
>
