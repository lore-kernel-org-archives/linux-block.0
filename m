Return-Path: <SRS0=xcXT=PN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FAEC43387
	for <linux-block@archiver.kernel.org>; Sat,  5 Jan 2019 12:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD8C2087F
	for <linux-block@archiver.kernel.org>; Sat,  5 Jan 2019 12:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfAEMoT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Jan 2019 07:44:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37688 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAEMoS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Jan 2019 07:44:18 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so32476983oia.4
        for <linux-block@vger.kernel.org>; Sat, 05 Jan 2019 04:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=totbiRts4C2f0IhgT9gz/9Ze8dTYtFKUKJXfHXlzw0I=;
        b=jRtvICz91E4M+F45h8Z87ZVAWbzLCKPwxt8yj8RBlzhgVZbo4fEoj/6oiomGouTPCU
         2NfSJ1BiTz4xvW4zBzOp5749/3So04okJS5P44IsBY6sDzNTbnhJTzN1m7EPXAoh9ixr
         k/QpieG21F41f18hETh3aOOdZToH7PE+QsSXRv5BYgCod/BsQ+psCALg5NH5h0GfvGc1
         H6fIh4O3b/7Z9i6NFZz+pDTtZKWaiQzjPf0lu8xf5BwUXNTzUAVZ7Y5VrtTv1+/5+E4H
         S7Hn4i4jAakQujgoglWlD5DstXSSt+iGFTgo/r4gvgam0SRLSwLF5TCPm0hp8Cd/Afcv
         tSkw==
X-Gm-Message-State: AJcUuke4jE19Irw68sDBub0anIKsvTn1QllMJygn6ZdUgm1DRlUPUjlO
        bzWrv0Jz1yC3NSV2naoyr7Yo0VaKyZM0ZbEbw6W1uw==
X-Google-Smtp-Source: ALg8bN5KyY1OjrrEmvPZQN43pLtazqQELM5qKTGIuylerx/JcxzMhnqqoH+grdxLB+WM8jSy4gRB4woaonyYE0OAfYI=
X-Received: by 2002:a54:4382:: with SMTP id u2mr3217749oiv.262.1546692257791;
 Sat, 05 Jan 2019 04:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20190104170637.8218-1-jpittman@redhat.com> <1546638578.83374.6.camel@acm.org>
In-Reply-To: <1546638578.83374.6.camel@acm.org>
From:   John Pittman <jpittman@redhat.com>
Date:   Sat, 5 Jan 2019 07:44:07 -0500
Message-ID: <CA+RJvhy1tJ93g3Ne2D4RLFRF62nU5=dWvofZpmPUa0yZt0EFhQ@mail.gmail.com>
Subject: Re: [PATCH v2] null_blk: add zoned config support information
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, Bart, It occurred to me just now that on the pr_err() message,
"null_blk: CONFIG_BLK_DEV_ZONED not enabled" is a little better
than "CONFIG_BLK_DEV_ZONED not enabled".  It was my intent
to include that 'null_blk:', but it slipped my mind at the last moment.

On Fri, Jan 4, 2019 at 4:49 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Fri, 2019-01-04 at 12:06 -0500, John Pittman wrote:
> > If the kernel is built without CONFIG_BLK_DEV_ZONED, a modprobe
> > of the null_blk driver with zoned=1 fails with 'Invalid argument'.
> > This can be confusing to users, prompting a search as to why the
> > parameter is invalid. To assist in that search, add a bit more
> > information to the failure, additionally adding to the documentation
> > that CONFIG_BLK_DEV_ZONED is needed for zoned=1.
> >
> > Signed-off-by: John Pittman <jpittman@redhat.com>
> > ---
> >  Documentation/block/null_blk.txt | 3 ++-
> >  drivers/block/null_blk.h         | 1 +
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/block/null_blk.txt b/Documentation/block/null_blk.txt
> > index ea2dafe49ae8..4cad1024fff7 100644
> > --- a/Documentation/block/null_blk.txt
> > +++ b/Documentation/block/null_blk.txt
> > @@ -88,7 +88,8 @@ shared_tags=[0/1]: Default: 0
> >
> >  zoned=[0/1]: Default: 0
> >    0: Block device is exposed as a random-access block device.
> > -  1: Block device is exposed as a host-managed zoned block device.
> > +  1: Block device is exposed as a host-managed zoned block device. Requires
> > +     CONFIG_BLK_DEV_ZONED.
> >
> >  zone_size=[MB]: Default: 256
> >    Per zone size when exposed as a zoned block device. Must be a power of two.
> > diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
> > index b3df2793e7cd..cab4808f14bd 100644
> > --- a/drivers/block/null_blk.h
> > +++ b/drivers/block/null_blk.h
> > @@ -97,6 +97,7 @@ void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
> >  #else
> >  static inline int null_zone_init(struct nullb_device *dev)
> >  {
> > +     pr_err("CONFIG_BLK_DEV_ZONED not enabled\n");
> >       return -EINVAL;
> >  }
> >  static inline void null_zone_exit(struct nullb_device *dev) {}
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
