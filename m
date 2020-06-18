Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D999C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 07:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7ED21532
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 07:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="T9tcIiaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgFRHP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgFRHPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 03:15:25 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B052C061755
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 00:15:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l12so5258675ejn.10
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 00:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tmh04dD341/4y/Q6EOkdu66A1LqqXnqRiut/2G8UYas=;
        b=T9tcIiazvXOIzaWbeWAkuWgpEgvx/IgnpjJzNuBfJpOE4i9qArcEH9IsBxJaG2XQwV
         BORjKTU3K3br1VcHBJTuWXsQpmi667sT08+aAhWHyyvieM3L5D1XfSV2CuL3RLg+20Sc
         fZ5pBWkOL7ozyH8oUWw0uL5TI2YvhjDr1bwLvPVlYG5FGAWL/1nOOHqV22aMqnnHt5vz
         YV1iWoo0qs0ozwEJOIBxjUIgc9Dtv1Qa+8tBmzLmDfvZFQCYB/18JKn+Rb4QShbfOoZD
         EsAFEv0tgGXhI4gESnQh+iNRzZDQaqVJjnIaKHqSqc1GLDKKeJG+VkXlcGB7phTeZWYr
         g75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tmh04dD341/4y/Q6EOkdu66A1LqqXnqRiut/2G8UYas=;
        b=lHPX3TATMRy5InhStI8OZPJteHaxg/RYloT1d4s2isqykMvYCJfn8jM5Jbh9JjiwLS
         zHPTtO8vm0FMHJuYM6aQqETeMbOHp5T/7OKQ/5FPVeHsECLiEFQS0kbcvP8XiahIph0r
         6zNS7sGVFhxUVC4dAUNO8eu5OdcBeAw/hOWKBHmKqYNbWlERM36I0MjHkwxtMHYAbKpm
         6NWVWeukfWAcXeYBoTov6OckBGb1XjbY14vKopirzVhzE70pc2qpwPOfiogceMtSUPPh
         1IAWTmRiGR+YqPyOXzlat+vXLQ//p0Nw/hpkYSN5akn/zDYdNzf/fBbQvnzcKZERiTAf
         I+uw==
X-Gm-Message-State: AOAM532N8Ej1FN+tmKFsuV1RrTeFRdoYogcb+JmrmPgxJr0wP/BlCaXi
        1wZAtvEyevd2+G+q1CFgoKlHyhZQUBKarr6V+c9BgwkmHhL/NQ==
X-Google-Smtp-Source: ABdhPJwqXBbLFNwiqirZz4Yo7tTmOFl33ltJt3uENJjGedlgB/bXJhjJ7nVoxpId2lUkStS4UQ33XMZ+Pl9w5UdsQbw=
X-Received: by 2002:a17:906:7103:: with SMTP id x3mr2507724ejj.363.1592464523567;
 Thu, 18 Jun 2020 00:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
 <20200617112811.GL2383158@unreal> <20200617182046.GI6578@ziepe.ca>
 <20200617190756.GA2721989@unreal> <20200617192642.GL6578@ziepe.ca>
In-Reply-To: <20200617192642.GL6578@ziepe.ca>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Thu, 18 Jun 2020 07:15:12 +0530
Message-ID: <CAJpMwygeJ7uaNUKxhsF-bx=ufchkx7M6G0E237=-0C7GwJ3yog@mail.gmail.com>
Subject: Re: [PATCH] Delay the initialization of rnbd_server module to
 late_initcall level
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>, dledford@redhat.com,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(Apologies for multiple emails. Was having trouble with an extension,
cause of which emails did not get delivered to the mailing list.
Resolved now.)

> Somehow nvme-rdma works:

I think that's because the callchain during the nvme_rdma_init_module
initialization stops at "nvmf_register_transport()". Here only the
"struct nvmf_transport_ops nvme_rdma_transport" is registered, which
contains the function "nvme_rdma_create_ctrl()". I tested this in my
local setup and during kernel boot, that's the extent of the
callchain.
The ".create_ctrl"; which now points to "nvme_rdma_create_ctrl()" is
called later from "nvmf_dev_write()". I am not sure when this is
called, probably when the "discover" happens from the client side or
during the server config. I am trying to test this to confirm, will
send more details once I am done.
Am I missing something here?


> If the rdma_create_id() is not on a callchain from module_init then you don't have a problem.

I am a little confused. I thought the problem occurs from a call to
either "rdma_resolve_addr()" which calls "rdma_bind_addr()",
or a direct call to "rdma_bind_addr()" as in rtrs case.
In both the cases, a call to "rdma_create_id()" is needed before this.


> Similarly they are supposed to be created from the client attachment.
I am a beginner in terms of concepts here. Did you mean when a client
tries to establish the first connection to an rdma server?


On Thu, Jun 18, 2020 at 12:56 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 17, 2020 at 10:07:56PM +0300, Leon Romanovsky wrote:
> > On Wed, Jun 17, 2020 at 03:20:46PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jun 17, 2020 at 02:28:11PM +0300, Leon Romanovsky wrote:
> > > > On Wed, Jun 17, 2020 at 04:07:32PM +0530, haris.iqbal@cloud.ionos.com wrote:
> > > > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > >
> > > > > Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> > > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > >
> > > > > The rnbd_server module's communication manager initialization depends on the
> > > > > registration of the "network namespace subsystem" of the RDMA CM agent module.
> > > > > As such, when the kernel is configured to load the rnbd_server and the RDMA
> > > > > cma module during initialization; and if the rnbd_server module is initialized
> > > > > before RDMA cma module, a null ptr dereference occurs during the RDMA bind
> > > > > operation.
> > > > > This patch delays the initialization of the rnbd_server module to the
> > > > > late_initcall level, since RDMA cma module uses module_init which puts it into
> > > > > the device_initcall level.
> > > > >  drivers/block/rnbd/rnbd-srv.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> > > > > index 86e61523907b..213df05e5994 100644
> > > > > +++ b/drivers/block/rnbd/rnbd-srv.c
> > > > > @@ -840,5 +840,5 @@ static void __exit rnbd_srv_cleanup_module(void)
> > > > >         rnbd_srv_destroy_sysfs_files();
> > > > >  }
> > > > >
> > > > > -module_init(rnbd_srv_init_module);
> > > > > +late_initcall(rnbd_srv_init_module);
> > > >
> > > > I don't think that this is correct change. Somehow nvme-rdma works:
> > > > module_init(nvme_rdma_init_module);
> > > > -> nvme_rdma_init_module
> > > >  -> nvmf_register_transport(&nvme_rdma_transport);
> > > >   -> nvme_rdma_create_ctrl
> > > >    -> nvme_rdma_setup_ctrl
> > > >     -> nvme_rdma_configure_admin_queue
> > > >      -> nvme_rdma_alloc_queue
> > > >       -> rdma_create_id
> > >
> > > If it does work, it is by luck.
> >
> > I didn't check every ULP, but it seems that all ULPs use the same
> > module_init.
> >
> > >
> > > Keep in mind all this only matters for kernels without modules.
> >
> > Can it be related to the fact that other ULPs call to ib_register_client()
> > before calling to rdma-cm? RNBD does not have such call.
>
> If the rdma_create_id() is not on a callchain from module_init then
> you don't have a problem.
>
> nvme has a bug here, IIRC. It is not OK to create RDMA CM IDs outside
> a client - CM IDs are supposed to be cleaned up when the client is
> removed.
>
> Similarly they are supposed to be created from the client attachment.
>
> Though listening CM IDs unbound to any device may change that
> slightly, I think it is probably best practice to create the listening
> ID only if a client is bound.
>
> Most probably that is the best way to fix rnbd
>
> > I'm not proposing this, but just loudly wondering, do we really need rdma-cm
> > as a separate module? Can we bring it to be part of ib_core?
>
> No idea.. It doesn't help this situation at least
>
> Jason



-- 

Regards
-Haris
