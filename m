Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8C2C3B1BF
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 19:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5790722314
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 19:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCTWvjx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbgBNTmq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:42:46 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:38449 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387571AbgBNTmp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 14:42:45 -0500
Received: by mail-io1-f41.google.com with SMTP id s24so11790432iog.5
        for <linux-block@vger.kernel.org>; Fri, 14 Feb 2020 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9lKhkJG1SEh5Pys1eJu5aR0S9IH7RxfHuDYsnTzNDA=;
        b=sCTWvjx2wV809VMBb9QOcB5aTNrexqJYXfMwhaj8TNiZaYHGj3Cku8IlFZlzZLzMx+
         KC/uNSbltbfBGBDMRsOyCwJ8MOpO4sgY8WvLRN7/LupfUwsxtlh05QAdR5NHjYMk0/vs
         FZB4pl+coQmXuz1rvUe+oxNMHgPlVoYzF0dikvn9LvkXj8h7LCUovEY1J0ffH+oMScfl
         5xm03TRLOumre+BfWxQxQu13kXse3Y5lE4AkaT4SMi3FYq9wEGnp52/IjX0Q2r8oztE4
         yzH8J1NOISdtLh+gegj6HQqwBpzoLx3drwY9mV4emNa1ABjS72La8yzj+Hty1rrJIv2Z
         yLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9lKhkJG1SEh5Pys1eJu5aR0S9IH7RxfHuDYsnTzNDA=;
        b=iMStzcb1/o4Ap+d+xdCYuNvhqToM/UR/Ajvg8R9OqTqtyrIY6mWVPUdqElno/7GOgw
         gqLZfx369mt6UqXXmpHXJ3MVCeJyefR9p6vt/gYPs/WQx1A+Idfza3xFIDIaH+xTNlrV
         XRq4RYopiou/J2kruske/bOUMC6z+xMs5AmaA0J2cKhIFEWNe3GhJ4S/4RzjbnZRavcu
         P1TJOo6LW46A++NAE83RJzLOafb82usez/nC7To75iKBWB0ZK3MOaNoAKuBjnViwjErc
         O4GV0hb+MAl7JS8esiVYUEsDUkuKU3uNca9Loie57ZGpK+8kIXjNH1QwnvGnkR4odZxL
         j2Xg==
X-Gm-Message-State: APjAAAWVjUbtnketHP749IO9Gy1fl7quxU0Ti0znTCOkAsOT8TR+ogSr
        FEuI8O5Bx0TFLSr13IYxx/8njWf0NHo9lmCkWlUTQw==
X-Google-Smtp-Source: APXvYqzwDLvXH5bSFR1jXSTBdiYIoEzZ+RWU82vPHCAkkWx5s2exQ3ptCOmxaAr0D2vmJBobgrzDAkDCEjmxp8TzinY=
X-Received: by 2002:a6b:108:: with SMTP id 8mr3690162iob.70.1581709363693;
 Fri, 14 Feb 2020 11:42:43 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200213082643.GB9144@ming.t460p> <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
 <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
 <de7b841c-a195-1b1e-eb60-02cbd6ba4e0a@acm.org> <CACVXFVP114+QBhw1bXqwgKRw_s4tBM_ZkuvjdXEU7nwkbJuH1Q@mail.gmail.com>
In-Reply-To: <CACVXFVP114+QBhw1bXqwgKRw_s4tBM_ZkuvjdXEU7nwkbJuH1Q@mail.gmail.com>
From:   Salman Qazi <sqazi@google.com>
Date:   Fri, 14 Feb 2020 11:42:32 -0800
Message-ID: <CAKUOC8Xss0YPefhKfwBiBar-7QQ=QrVh3d_8NBfidCCxUuxcgg@mail.gmail.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 14, 2020 at 1:23 AM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Fri, Feb 14, 2020 at 1:50 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 2020-02-13 11:21, Salman Qazi wrote:
> > > AFAICT, This is not actually sufficient, because the issuer of the bio
> > > is waiting for the entire bio, regardless of how it is split later.
> > > But, also there isn't a good mapping between the size of the secure
> > > discard and how long it will take.  If given the geometry of a flash
> > > device, it is not hard to construct a scenario where a relatively
> > > small secure discard (few thousand sectors) will take a very long time
> > > (multiple seconds).
> > >
> > > Having said that, I don't like neutering the hung task timer either.
> >
> > Hi Salman,
> >
> > How about modifying the block layer such that completions of bio
> > fragments are considered as task activity? I think that bio splitting is
> > rare enough for such a change not to affect performance of the hot path.
>
> Are you sure that the task hung warning won't be triggered in case of
> non-splitting?

I demonstrated a few emails ago that it doesn't take a very large
secure discard command to trigger this.  So, I am sceptical that we
will be able to use splitting to solve this.

>
> >
> > How about setting max_discard_segments such that a discard always
> > completes in less than half the hung task timeout? This may make
> > discards a bit slower for one particular block driver but I think that's
> > better than hung task complaints.
>
> I am afraid you can't find a golden setting max_discard_segments working
> for every drivers. Even it is found, the performance  may have been affected.
>
> So just wondering why not take the simple approach used in blk_execute_rq()?

My colleague Gwendal pointed out another issue which I had missed:
secure discard is an exclusive command: it monopolizes the device.
Even if we fix this via your approach, it will show up somewhere else,
because other operations to the drive will not make progress for that
length of time.

For Chromium OS purposes, if we had a blank slate, this is how I would solve it:

* Under the assumption that the truly sensitive data is not very big:
    * Keep secure data on a separate partition to make sure that those
LBAs have controlled history
    * Treat the files in that partition as immutable (i.e. no
overwriting the contents of the file without first secure erasing the
existing contents).
    * By never letting more than one version of the file accumulate,
we can guarantee that the secure erase will always be fast for
moderate sized files.

But for all the existing machines with keys on them, we will need to
do something else.



>
> Thanks,
> Ming Lei
