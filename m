Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EDCC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 03:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5493D218A4
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 03:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV6C0hzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeLSDpU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:45:20 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:39592 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeLSDpU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 22:45:20 -0500
Received: by mail-wr1-f51.google.com with SMTP id t27so18006003wra.6
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 19:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Scjx9i/EH/DVgFudd6vyj6oaDo3mf9J+WY2oTgZwGF8=;
        b=cV6C0hzG8uIzlo9a/n5SvsfFeAW2mxMgYfmRSN5gZrDZrdgMVGwrQ7fho69Y62ka9R
         KqESwT6EeobWGwWR0rxAWG12moO6sKnxRSRsGC7LcfKQrPoMKyaRcO3hlLvVn0ES4VBN
         K7kS/23DeCSS2cwploRLxa5l5uyswG2a+YfO66kUtFkOoEVlxZGOo1xG7rJKFr/MSlfs
         G9NiQX8GQ3NtPZJk3KNtmr5Y8MlfEmt2BRCZGobwpPgwebcok26fTeEX835iJomFLBCP
         IMPGY6X+GCW2GILCpdq9HOEBws0TCQPnLds5AkDVc1oFyE1R98qLychMSp+uWz8Tf3Nq
         iLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Scjx9i/EH/DVgFudd6vyj6oaDo3mf9J+WY2oTgZwGF8=;
        b=Hx6VAzJXuPo7mWBaoY69xB/7BcmJvVQKmrMMt9qz5NwQ2iP41yVswZqrFQeIjD3duE
         /qtbY9Shy4U6YHVTkbz0ap0JOWCYDJINBFsmupP5lQylB6OpDd84EP4h5+T35Oij56bW
         aT4J+i5Xu5LsUZqnOvPP9zd6CFrGzaJeSRNjQNv06bgk8sJ5J/JVdTCIilH1+g6dbIwf
         LvFoJjRHS699j3lmBD/l50tlZp9HX1rlPSG7mP5JxCKJ91LZpolGS0JyC14ZfZVuBifp
         l/Z2j8CTidg82a2hsygpqIfW5+Hq9IQEgAVtO1K6h9K3w/eKeOKELzF/8nqoY+BIyenf
         sG8A==
X-Gm-Message-State: AA+aEWbfqeqoIORCUTiIMYpf6cpD0M8iH4gx+uOiiHFNHAFfqK1mus6N
        zc0Htwk/xWoZUdIs1M/gvS3tXa/Z2q5YWTVtvC8=
X-Google-Smtp-Source: AFSGD/X4DGCrnn8NAzKxePK0O0TrncgVUeUJbANtBJNUZIUmBO+/b8gsZAdD8VXS+tO2QBY3vy/F84bEe0uDQ7dC3Bo=
X-Received: by 2002:adf:ce02:: with SMTP id p2mr18297492wrn.185.1545191118349;
 Tue, 18 Dec 2018 19:45:18 -0800 (PST)
MIME-Version: 1.0
References: <E0E52FD0-1020-4F5B-9AC8-F48BDFE142C0@linaro.org> <4db2cb0f-e500-44da-e85d-ed417b74dae5@kernel.dk>
In-Reply-To: <4db2cb0f-e500-44da-e85d-ed417b74dae5@kernel.dk>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 19 Dec 2018 11:45:06 +0800
Message-ID: <CACVXFVML3ZJ0ezsRBC6T_6zbJHqXRFXVQJxVhsK9spKEfgKipQ@mail.gmail.com>
Subject: Re: confusion about nr of pending I/O requests
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 19, 2018 at 2:52 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/18/18 5:45 AM, Paolo Valente wrote:
> > Hi Jens,
> > sorry for the following silly question, but maybe you can solve very
> > quickly a doubt for which I'd spend much more time investigating.
> >
> > While doing some tests with scsi_debug, I've just seen that (at least)
> > with direct I/O, the maximum number of pending I/O requests (at least
> > in the I/O schedulers) is equal, unexpectedly, to the queue depth of
> > the drive and not to
> > /sys/block/<dev>/queue/nr_requests
> >
> > For example, after:
> >
> > sudo modprobe scsi_debug max_queue=4
> >
> > and with fio executed as follows:
> >
> > job: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=20
> >
> > I get this periodic trace, where four insertions are followed by four
> > completions, and so on, till the end of the I/O.  This trace is taken
> > with none, but the result is the same with bfq.
> >
> >              fio-20275 [001] d...  7560.655213:   8,48   I   R 281088 + 8 [fio]
> >              fio-20275 [001] d...  7560.655288:   8,48   I   R 281096 + 8 [fio]
> >              fio-20275 [001] d...  7560.655311:   8,48   I   R 281104 + 8 [fio]
> >              fio-20275 [001] d...  7560.655331:   8,48   I   R 281112 + 8 [fio]
> >           <idle>-0     [001] d.h.  7560.749868:   8,48   C   R 281088 + 8 [0]
> >           <idle>-0     [001] dNh.  7560.749912:   8,48   C   R 281096 + 8 [0]
> >           <idle>-0     [001] dNh.  7560.749928:   8,48   C   R 281104 + 8 [0]
> >           <idle>-0     [001] dNh.  7560.749934:   8,48   C   R 281112 + 8 [0]
> >              fio-20275 [001] d...  7560.750023:   8,48   I   R 281120 + 8 [fio]
> >              fio-20275 [001] d...  7560.750196:   8,48   I   R 281128 + 8 [fio]
> >              fio-20275 [001] d...  7560.750229:   8,48   I   R 281136 + 8 [fio]
> >              fio-20275 [001] d...  7560.750250:   8,48   I   R 281144 + 8 [fio]
> >           <idle>-0     [001] d.h.  7560.842510:   8,48   C   R 281120 + 8 [0]
> >           <idle>-0     [001] dNh.  7560.842551:   8,48   C   R 281128 + 8 [0]
> >           <idle>-0     [001] dNh.  7560.842556:   8,48   C   R 281136 + 8 [0]
> >           <idle>-0     [001] dNh.  7560.842562:   8,48   C   R 281144 + 8 [0]
> >
> > Shouldn't the total number of pending requests reach
> > /sys/block/<dev>/queue/nr_requests ?
> >
> > The latter is of course equal to 8.
>
> With a scheduler, the depth is what the scheduler provides. You cannot
> exceed the hardware queue depth in any situation. You just have 8
> requests available for scheduling, with a max of 4 being inflight on
> the device side.
>
> If both were 4, for instance, then you would have nothing to schedule
> with, as all of them could reside on the hardware side. That's why
> the scheduler defaults to twice the hardware queue depth.

The default twice to hw queue depth might not be reasonable for multi LUN.

Maybe it should be set twice of sdev->queue_depth for SCSI or
hw queue depth/hctx->nr_active.  But either way may become complicated
because both can be adjusted runtime.

Thanks,
Ming Lei
