Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DD5C433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 12:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E875F60F45
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 12:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhJXMrg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 08:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230300AbhJXMrg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 08:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635079515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y9QAAqw9ceNxomDsGGw7PkXqCgBmalHaWqvG+gx+tb4=;
        b=Q+PeFi/zlf4Es2akz6ma0VLl/XyRWjDfsJI67kk5d4JpbIqOz+W47qFuz665EB2mGL9QyN
        J/PzeeVLLupU9My3uhWhC2UYQ6B5mDZgCLAU4Qpgzu0cLv7ovKQRCZ464aJSwIbG8VIqnr
        OPVjYBifyaVWxn6nDIFRu67dUHGjn0o=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-m1P_F_KoMHuNL0nMEsO73A-1; Sun, 24 Oct 2021 08:45:12 -0400
X-MC-Unique: m1P_F_KoMHuNL0nMEsO73A-1
Received: by mail-yb1-f200.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so13041950ybk.16
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 05:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9QAAqw9ceNxomDsGGw7PkXqCgBmalHaWqvG+gx+tb4=;
        b=04PPZrXDOceYpaZCD09JTkcPWhy7h98S+LXBlFvfKrMUeA+m/4tM5P+kXByjQEgdbp
         93J8r/bSW623II0zLj5UkHQYQEqJYqdPlavljJ9aRXKbg6eObIQaJlUL/qkgZIyOkuS6
         xI3vPT29/EEoqplFsIx5DoJtg0l/jdQgt9cf5D62WVuTEorEF7aTIr82xZYbqcguTHnM
         n8HiqrAx8o1Jo482edStHNkm5Gl6pBBhuz9mIFsrqbTlfiLOTHTNf6TjDSbmpLljSyGJ
         vhqhx1b2sns73IHJkOSjTqvJ/qK3VcqWhzilbjUY6tzRBEi2vfMibTKcwwLPh5rT+BXd
         AkRw==
X-Gm-Message-State: AOAM531/R3s55tnfhuCdZbF96uBwGQxzqi6D58+YduoaccB9asPnnrsJ
        /Qk6fEz4RsuHywJwDh/li9HtUoi/Ry0e5akW3Cj/BH6nAwaImpGAFTwf48Y/zbl4RrcjQRRtgEs
        e8phyaf5AuQgvqAmDaCLNxfqP/enJkrwHtZKT+ZQ=
X-Received: by 2002:a5b:18c:: with SMTP id r12mr11383247ybl.308.1635079511283;
        Sun, 24 Oct 2021 05:45:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiu6En93SunxkJogdjIhH/gG0a4xhHIvRsRFpqxGSEsHgg7aVC7beGaPzQiRQXCNEkqxEVguCmjRwtYWfRPhc=
X-Received: by 2002:a5b:18c:: with SMTP id r12mr11383240ybl.308.1635079511098;
 Sun, 24 Oct 2021 05:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211018024007.6014-1-yi.zhang@redhat.com> <YW8f0x0Qx+IWUMtt@relinquished.localdomain>
In-Reply-To: <YW8f0x0Qx+IWUMtt@relinquished.localdomain>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sun, 24 Oct 2021 20:44:59 +0800
Message-ID: <CAHj4cs9Br939iFYnnV+VU7UvYnu2K8__oXKbHLYnNvTxFvA2XA@mail.gmail.com>
Subject: Re: [PATCH blktests V2] tests/srp: fix module loading issue during
 srp tests
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 3:43 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Mon, Oct 18, 2021 at 10:40:07AM +0800, Yi Zhang wrote:
> > The ib_isert/ib_srpt modules will be automatically loaded after the first
> >  time rdma_rxe/siw setup, which will lead srp tests fail.
> >
> > $ modprobe rdma_rxe
> > $ echo eno1 >/sys/module/rdma_rxe/parameters/add
> > $ lsmod | grep -E "ib_srpt|iscsi_target_mod|ib_isert"
> > ib_srpt               167936  0
> > ib_isert              139264  0
> > iscsi_target_mod      843776  1 ib_isert
> > target_core_mod      1069056  3 iscsi_target_mod,ib_srpt,ib_isert
> > rdma_cm               315392  5 rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
> > ib_cm                 344064  2 rdma_cm,ib_srpt
> > ib_core              1101824  10 rdma_cm,rdma_rxe,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_isert,rdma_ucm,ib_uverbs,ib_cm
> >
> > $ ./check srp/001
> > srp/001 (Create and remove LUNs)                             [failed]
> >     runtime    ...  3.675s
> >     --- tests/srp/001.out     2021-10-13 01:18:50.846740093 -0400
> >     +++ /root/blktests/results/nodev/srp/001.out.bad  2021-10-14 03:24:18.593852208 -0400
> >     @@ -1,3 +1 @@
> >     -Configured SRP target driver
> >     -count_luns(): 3 <> 3
> >     -Passed
> >     +insmod: ERROR: could not insert module /lib/modules/5.15.0-rc5.fix+/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko: File exists
> > modprobe: FATAL: Module iscsi_target_mod is in use.
> >
> > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> > ---
> >  tests/srp/rc | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/srp/rc b/tests/srp/rc
> > index 7239d87..16638a4 100755
> > --- a/tests/srp/rc
> > +++ b/tests/srp/rc
> > @@ -497,7 +497,8 @@ start_lio_srpt() {
> >       if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
> >               opts+=("rdma_cm_port=${srp_rdma_cm_port}")
> >       fi
> > -     insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?
> > +     unload_module ib_srpt &&
> > +             insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?
>
> While we're here, can this just be modprobe ib_srpt instead of insmod?
>

Yeah, change to modprobe also works here, I've send V3 for it.

-- 
Best Regards,
  Yi Zhang

