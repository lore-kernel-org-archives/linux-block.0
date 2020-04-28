Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345A0C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 12:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F9952075E
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 12:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="WpdqH2v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD1Mll (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726544AbgD1Mll (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 08:41:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C37C03C1A9
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 05:41:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n4so17094042ejs.11
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jb9elzh/74ZWm4bFfjq7/QUpnKgP6S86qUXhjXdPl8=;
        b=WpdqH2v/MZNbC1y2LwFDPVj6TJ8XVB8xtVoaSjQGJjuuIts2SvG/F1aCWEsMgZNz5V
         b8DiEjUBpMGtx9ZZ383qetmnIgvNvrB+SikeXNDp7lsxjyJlhoSEbJRj9vxeKb1NCZWP
         dESZdJFqkC0j6aCmKbtHVRMoZASgG4GTN2qfuvSHwNZis3DNMjshfxvnjgO1KiQHtpCE
         pJzmoHcmgfAtzMcTfD/p28CIl76uMkp/9LQP+ThqL2EI1y90zMeul+C9USJ1pS9wHiPb
         uIVe8riqcxOCdzmI1/tmJD6yWKjsHem5M9pl92ecTHEEZS091dKHfxJYYCpeUVwvanSU
         IMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jb9elzh/74ZWm4bFfjq7/QUpnKgP6S86qUXhjXdPl8=;
        b=dZm8WY/+nYeByyz2olBd05I0W8BAWQE2OzMtpXx9nUOXbm8u+0O98O8hSMwkVzwFj0
         lxCoZC2q9Pq4EHgtkWr0xFRV0uyh/FPnDr/ZUbmpaUd1WgKypmKs8eZqgpyol4v5FOMy
         RGX/pPINMrk/W06MhZMC4+aJ7GmJ4/iBe7rOnj+V797zIUPkAQI1y5raVCF/8Re4d6pu
         zxpMiFogytscM9QiwBG9F47cBZAzDcUgeKRc4BMGB2T4Qtncoy0r6RXUaHTB91MVkQ4d
         TrJGqJ8tTGMCcqCmVYD7wEQivcOQmWR66vtz4yR5ue3VlE/0TdpzsUZOEhYAECfCyjck
         zUbg==
X-Gm-Message-State: AGi0PuaoaBLBI6p8qVY7yEXakF5m2IJIPRmgoI+9oLZTQy4s+O/50KYr
        iOUGeCXwNM/5R4T+G/J+cJbxMU0N89pKOjKUyEW3cQ==
X-Google-Smtp-Source: APiQypIt5QxH0bocTs9uxDt53Avl+v2Af4RfA+4Dq3POVZYa8RWwnjwHZjjbmBgwTmnGmeTVQr7ZOmZVgX1p+JMfxH0=
X-Received: by 2002:a17:906:9494:: with SMTP id t20mr23467353ejx.51.1588077699476;
 Tue, 28 Apr 2020 05:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <CAMGffE=R2zaL6Ao3gZ_XvKPvG0YX5bmo18o3cJ_SLBEjZ0Mv_g@mail.gmail.com> <20200428123151.GS26002@ziepe.ca>
In-Reply-To: <20200428123151.GS26002@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 28 Apr 2020 14:41:28 +0200
Message-ID: <CAMGffEkEQ37bbG5BFixnESor8kjyLkEu4jC99a5g=xiCkyXECw@mail.gmail.com>
Subject: Re: [PATCH v12 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        linux-block@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 2:31 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sat, Apr 25, 2020 at 10:31:55AM +0200, Jinpu Wang wrote:
>
> > >  create mode 100644 Documentation/ABI/testing/sysfs-block-rnbd
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-client
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-server
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-client
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-server
> > >  create mode 100644 drivers/block/rnbd/Kconfig
> > >  create mode 100644 drivers/block/rnbd/Makefile
> > >  create mode 100644 drivers/block/rnbd/README
> > >  create mode 100644 drivers/block/rnbd/rnbd-clt-sysfs.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-clt.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-clt.h
> > >  create mode 100644 drivers/block/rnbd/rnbd-common.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-log.h
> > >  create mode 100644 drivers/block/rnbd/rnbd-proto.h
> > >  create mode 100644 drivers/block/rnbd/rnbd-srv-dev.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-srv-dev.h
> > >  create mode 100644 drivers/block/rnbd/rnbd-srv-sysfs.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-srv.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-srv.h
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/Kconfig
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/Makefile
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/README
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.h
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-log.h
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.h
> > >
> > >
> > Hi Jason, hi Leon, hi Doug, hi all,
> >
> > We now have Reviewed-by for RNBD part from Bart (Thanks again), Do you
> > have new comments regarding RTRS, should we send another round to do a
> > rebase to latest rc?
>
> We'd need an ack from Jens before the block stuff could go through the
> RDMA tree
>
> Jason
Hi Jason
Thanks for reply.

Hi Jens,

Could you give your ack so Jason could take RNBD/RTRS through RDMA
tree, Jason mentioned in the past, we should get it ready at around
rc4ish,  so we still can get about 2 weeks of little bug fixes from
all the cross-arch compilation if any.

Thanks!
