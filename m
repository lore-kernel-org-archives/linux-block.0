Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E288C4CECE
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 15:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BFC214D9
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 15:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="IGSCo2C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfIPPjb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:39:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43279 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfIPPjb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 11:39:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id q17so34717978wrx.10
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2019 08:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JULfs9svFaoMLlqnfnlf/PZkcuYVpfT9JMFMjTQ8xQ=;
        b=IGSCo2C0xZzfeAGXGwF14VKmmrN2IZO+3/PbgepQfKsDEwkqVJiEtj5L/PVVSxxPyX
         hh38tKKckYMaurfXMwKMd75mffDveKHxoEj8iPa4et/j2apIBmcERa42THsE9W8YWb5Q
         1/gMf1ugk7jsX4hNy3X9JrhIOsgEge+tFQLOdaWgAFC05qoxbq3xurlXa4tBx6LA4Rl6
         s8mFgiBA0uLxHDA3Am2hkY0eHo2k3lIpo4N781UwqoHQUgbpELbloRfS5p/tdwzxkHY5
         EpYoBcIs0/Fya2+0YrBSw4sbiv5/6Y5hAUc8eO2XSg5fOsD9P1PAd+7O1AUEZinquJb5
         bgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JULfs9svFaoMLlqnfnlf/PZkcuYVpfT9JMFMjTQ8xQ=;
        b=tc1NPCsdEkSXBzoT2XbcBaV3ElfsiJ86KZA5jnh7xt7rTzHKt54j2jcwg79hIZyjwv
         k8GfY+BJ5AGT7qt0a8Y9zoFM+Zwgx2eh3ZW+izVom9EZpZPb9pdWHUx05mzg2FwIYDwD
         KSHRVSlWRBQz7z2TiV3SOmnWIWUN3BTrfhibDpnPQonU0cuqj78HIKl2nsJVxp8xPMuA
         axwyvWsm7svYnlSdAUWk7TkLMog/7JAnscxMGJfHzq862BhnaePsbbW8oFOvYe8PP6Io
         6EfOl5o45X2sUz1rX0UZbJO+Uexvq6yQDvcF/5hR0cBmach6aPKsKLZzR4CgI1tlUmOp
         mq0w==
X-Gm-Message-State: APjAAAXnFgacDGYMh+G5lB7cU56Mf7sunn0e2hrcJlhfEGAtV/V+Bw6F
        bQpVLMFy7NTbw+aQJFLt59lqConDl1EE+FnwPCqIag==
X-Google-Smtp-Source: APXvYqwtC2GlExTLOrFw2uMb5TCk7mEXbjsM+s2pa4DPjkdGx06/N/cE5iRlvBXMCKe52VwIlbSZfi2tYlEpPvq2Uxg=
X-Received: by 2002:adf:8444:: with SMTP id 62mr378401wrf.202.1568648369160;
 Mon, 16 Sep 2019 08:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org> <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
In-Reply-To: <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 16 Sep 2019 17:39:17 +0200
Message-ID: <CAMGffE=Vsbv5O7rCSq_ymA-UXPaSWT_bMfZ+AK-2f1Z=zMMtyQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

- Roman's pb emal address, it's no longer valid, will fix next round.


> >
> > > +static inline const char *ibnbd_io_mode_str(enum ibnbd_io_mode mode)
> > > +{
> > > +     switch (mode) {
> > > +     case IBNBD_FILEIO:
> > > +             return "fileio";
> > > +     case IBNBD_BLOCKIO:
> > > +             return "blockio";
> > > +     case IBNBD_AUTOIO:
> > > +             return "autoio";
> > > +     default:
> > > +             return "unknown";
> > > +     }
> > > +}
> > > +
> > > +static inline const char *ibnbd_access_mode_str(enum ibnbd_access_mode mode)
> > > +{
> > > +     switch (mode) {
> > > +     case IBNBD_ACCESS_RO:
> > > +             return "ro";
> > > +     case IBNBD_ACCESS_RW:
> > > +             return "rw";
> > > +     case IBNBD_ACCESS_MIGRATION:
> > > +             return "migration";
> > > +     default:
> > > +             return "unknown";
> > > +     }
> > > +}
> >
> > These two functions are not in the hot path and hence should not be
> > inline functions.
> Sounds reasonable, will remove the inline.
inline was added to fix the -Wunused-function warning  eg:

  CC [M]  /<<PKGBUILDDIR>>/ibnbd/ibnbd-clt.o
In file included from /<<PKGBUILDDIR>>/ibnbd/ibnbd-clt.h:34,
                 from /<<PKGBUILDDIR>>/ibnbd/ibnbd-clt.c:33:
/<<PKGBUILDDIR>>/ibnbd/ibnbd-proto.h:362:20: warning:
'ibnbd_access_mode_str' defined but not used [-Wunused-function]
 static const char *ibnbd_access_mode_str(enum ibnbd_access_mode mode)
                    ^~~~~~~~~~~~~~~~~~~~~
/<<PKGBUILDDIR>>/ibnbd/ibnbd-proto.h:348:20: warning:
'ibnbd_io_mode_str' defined but not used [-Wunused-function]
 static const char *ibnbd_io_mode_str(enum ibnbd_io_mode mode)

We have to move both functions to a separate header file if we really
want to do it.
The function is simple and small, if you insist, I will do it.

Thanks,
Jinpu
