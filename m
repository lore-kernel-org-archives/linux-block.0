Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E716CC433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 17:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4ED4207D8
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 17:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVOKZwsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgFERkE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgFERkE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jun 2020 13:40:04 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1468C08C5C2
        for <linux-block@vger.kernel.org>; Fri,  5 Jun 2020 10:40:03 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g5so8240239otg.6
        for <linux-block@vger.kernel.org>; Fri, 05 Jun 2020 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8LpJH5l0FEnENUAUaf/xS7bThxuxgq6D0hnx/N+MHg=;
        b=DVOKZwsxZHOv0fV9Uur2bilytCWQagSIWC8n+6VKPOG2MO+Rp/y4LvxWTjC2MRT6ac
         kgTmB08hqwRyrWvLMRTc4kPiWBqU3kMrKI8you6uDFPy3kEzcP+dUkwhYiqMYAErwqpc
         jheIc/nx0N7v9X6xGgw1PuUiKQ094oxsTF+E2HLKdEN9ydw/IKQXbc3zCRrmJndKYUuT
         fwBXCsIq2Skfwd3PL+ORjm4CC7PIevLtcNWjXJSPSaXdyK9nTZNeFV9habO47OjafajP
         8C7shVcMydctPihHxS5HIQKum60gHqYkyivaktOI1bmi+AqgqMwY76D2Ge30qQFjwxWw
         9a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8LpJH5l0FEnENUAUaf/xS7bThxuxgq6D0hnx/N+MHg=;
        b=swFUJkeXOUMKTtYTLu8Qde/H+KURPpbsGy7ixqEAfCiOg4dsVffWNuW2NqZjSuygAQ
         yhGW6hwg+6ssuSJBRqNeTu7YXHUsi7sFKLytnhLEfExKFAW196qQR69Q21fMVhZcy5T/
         X/VuoAGDJy8atUanuITOPbW2NO2aXeLo1FWX/oyF4pdSZujSXaG6YfTVyBYngPnkIvw1
         631QAT6jzQzuKt/HcUCTcMN65dMEPQwBg5GAFXCQ0pCVm4eTuW0zenU8A4Hys7fZbQnG
         iKKsbhfN+5KIpcqiAAuXTOlbu5xoLwPiQ1yLu44lIwpHO+FNWVA9Z47CZgt+18uZM22a
         6Kqg==
X-Gm-Message-State: AOAM533WQEL9ueXWxPMROFEJPWhqD2hKZ1pmE+0xncKqUjHCPw9W1Nk2
        dJojVEGPncR8iqKLAKD6zXXKBpGcpl/73qEoyjEWv9M3H/E=
X-Google-Smtp-Source: ABdhPJxMgivedrmx7iB5S5v9/JFwlX2QEeQP+08DSjHK9BYZuLRqXRFbPipwRNnh5zxccZRL9cM86Tt7LU9UXyfq2oA=
X-Received: by 2002:a9d:145:: with SMTP id 63mr6139046otu.141.1591378802951;
 Fri, 05 Jun 2020 10:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
 <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org> <CAD+ocbzdh0eq+wBQ-DqUUw_Gvwc0xv-FbBUNS0aZfpn+eToUEg@mail.gmail.com>
 <8787ab94-4573-56d4-2e59-0adbaa979c4f@acm.org>
In-Reply-To: <8787ab94-4573-56d4-2e59-0adbaa979c4f@acm.org>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 5 Jun 2020 10:39:51 -0700
Message-ID: <CAD+ocbz+p9Yp5+JxQOUJJExVZeWRKQybn8wi0O23dYH30bUdvA@mail.gmail.com>
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 5, 2020 at 6:43 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-06-04 22:02, harshad shirwadkar wrote:
> > Hi Bart,
> >
> > On Thu, Jun 4, 2020 at 9:31 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >>
> >> On 2020-06-03 22:44, Harshad Shirwadkar wrote:
> >>> Make sure that user requested memory via BLKTRACESETUP is within
> >>> bounds. This can be easily exploited by setting really large values
> >>> for buf_size and buf_nr in BLKTRACESETUP ioctl.
> >>>
> >>> blktrace program has following hardcoded values for bufsize and bufnr:
> >>> BUF_SIZE=(512 * 1024)
> >>> BUF_NR=(4)
> >>
> >> Where is the code that imposes these limits? I haven't found it. Did I
> >> perhaps overlook something?
> >
> > From what I understand, these are not limits. These are hardcoded
> > values used by blktrace userspace when it calls BLKTRACESETUP ioctl.
> > Inside the kernel, before this patch there is no checking in the linux
> > kernel.
>
> Please do not move limits from userspace tools into the kernel. Doing so
> would break other user space software (not sure if there is any) that
> uses the same ioctl but different limits.
Ack.
>
> >>> diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
> >>> index 690621b610e5..4d9dc44a83f9 100644
> >>> --- a/include/uapi/linux/blktrace_api.h
> >>> +++ b/include/uapi/linux/blktrace_api.h
> >>> @@ -129,6 +129,9 @@ enum {
> >>>  };
> >>>
> >>>  #define BLKTRACE_BDEV_SIZE   32
> >>> +#define BLKTRACE_MAX_BUFSIZ  (1024 * 1024)
> >>> +#define BLKTRACE_MAX_BUFNR   16
> >>> +#define BLKTRACE_MAX_ALLOC   ((BLKTRACE_MAX_BUFNR) * (BLKTRACE_MAX_BUFNR))
> >>
> >> Adding these constants to the user space API is a very inflexible
> >> approach. There must be better approaches to export constants like these
> >> to user space, e.g. through sysfs attributes.
> >>
> >> It probably will be easier to get a patch like this one upstream if the
> >> uapi headers are not modified.
> >
> > Thanks, makes sense. I'll do this in the V2. If we do that, we still
> > need to define the default values for these limits. Do the values
> > chosen for MAX_BUFSIZE and MAX_ALLOC look reasonable?
>
> We typically do not implement arbitrary limits in the kernel. So I'd
> prefer not to introduce any artificial limits.
I see. But my worry is that if we don't check for bounds in the kernel
in this case, a non-root user who has access to any block device (even
a simple loop device) can make the kernel go out of memory.
---
...
int main(int argc, char *argv[])
{
        struct blk_user_trace_setup buts;
        int fd;
        int ret;

        fd = open(argv[1], O_RDONLY|O_NONBLOCK);

        memset(&buts, 0, sizeof(buts));
        buts.buf_size = ~0;
        buts.buf_nr = 1;
        buts.act_mask = 65535;
        return ioctl(fd, BLKTRACESETUP, &buts);
}
---

I understand that introducing artificial hard-coded limits is probably
not the best approach. However, not having a reasonable sanity
checking on the IOCTL arguments, especially when the IOCTL itself
doesn't require any special capability checks and the kernel uses
those arguments almost as-is for allocating memory seems like a
vulnerability that attackers can exploit.

>
> >>
> >>>  /*
> >>>   * User setup structure passed with BLKTRACESETUP
> >>> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> >>> index ea47f2084087..b3b0a8164c05 100644
> >>> --- a/kernel/trace/blktrace.c
> >>> +++ b/kernel/trace/blktrace.c
> >>> @@ -482,6 +482,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> >>>       if (!buts->buf_size || !buts->buf_nr)
> >>>               return -EINVAL;
> >>>
> >>> +     if (buts->buf_size * buts->buf_nr > BLKTRACE_MAX_ALLOC)
> >>> +             return -E2BIG;
> >>> +
> >>>       if (!blk_debugfs_root)
> >>>               return -ENOENT;
> >>
> >> Where do the overflow(s) happen if buts->buf_size and buts->buf_nr are
> >> large? Is the following code from relay_open() the only code that can
> >> overflow?
> >>
> >>         chan->alloc_size = PAGE_ALIGN(subbuf_size * n_subbufs);
> >
> > Good catch, I'm not sure if the overflows are checked for, but I maybe
> > wrong. Given the possibility of overflows, perhaps we should be
> > checking for individual upper bounds instead of the product?
>
> How about using check_mul_overflow() to catch overflows of this
> multiplication? There may be other statements that need protection
> against overflow.

Makes sense. I can add that check.

Thanks,
Harshad.

>
> Thanks,
>
> Bart.
