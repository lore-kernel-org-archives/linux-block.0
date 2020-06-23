Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C74C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63518207D0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 17:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="hOY22Vo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbgFWRGE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732868AbgFWRGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 13:06:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C07C061755
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 10:06:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a1so8342052ejg.12
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMxT7cX2X2rczc7YLv40ENChlI/f1PdJoDYIHhDc298=;
        b=hOY22Vo9ltCw4cc9sz094t1VBD6gDr8/uBf6glEGxlZjBIVwvFYCM+QsI97CwV5bpD
         mgxH6jyII+OKssj9qvd+2mh5vqetjwQhscNYVBobKpR4UhP87WKZmVYrCB4/MryagjZr
         LxOTi2mW8s96U6HP2YPVyvSBXxyfQl1yur+mRRTp8P/JUk5gum2g/NElgGihotZThcy2
         cZ3TM3bE7zUQgP7yOMHnXu81pxLhwCdgf6PHT7+qGpLL1xVLHEGpfEjbBvYrvw5xB/Kn
         LCi5Xg+FUtjMzMWfM3sam3myp128BFOdkA6X8EpjQ0UcaUFefZLZ9pUCdI8+lchhpTLI
         yP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMxT7cX2X2rczc7YLv40ENChlI/f1PdJoDYIHhDc298=;
        b=s3uFcYVU+Nz6aqvrhkWgKVcLUergjNVfI9Uh8FBU5x1eBm0/W4wUG2EQG2ms89A7cf
         5L2Ny01EKg2OUAGJfFwPrTRBwWPfCV3WDtc3IZQyziMQ6JavB9p03PiDXxgy1DkmfUAd
         M/J6R2bzmWAEDRJRwn/FMwZOD/YOoXZY0wS5ZJsPh6pfbVMLQas8puDVdNDGQs6JICzx
         s5ttzTn6rlzKvclbh/Af5QC/UnfVWeAf0w8Uf1p0kMHy/mAZBY1ZpDHpZA+Harhbrhr9
         81h468HJ+gNb5/6oH7pvXD6nWbd9KUdPbs3CzdoPxaC0euxEpO+QcxRAeCa7HDgwlWUo
         8GPQ==
X-Gm-Message-State: AOAM5300vhvKc4wkB8Jz1HgeR79cHUUB6KRmHen0A/K02fdSCVEmu/E6
        QJwfvyGoSXoOAbtexe9UhW4UgG/pZgHrB9Ff/nHHmw==
X-Google-Smtp-Source: ABdhPJxhlyLlLEC19v3KYDdthGs/w3KYM9NA6wGXoX5kRl5bYCDFa6Ym6IMFXHONZ/H2nm2M2W/uiAaHlYjMhIBAWAE=
X-Received: by 2002:a17:906:edb3:: with SMTP id sa19mr14573113ejb.21.1592931962079;
 Tue, 23 Jun 2020 10:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
 <20200617112811.GL2383158@unreal> <20200617182046.GI6578@ziepe.ca>
 <20200617190756.GA2721989@unreal> <20200617192642.GL6578@ziepe.ca>
 <CAJpMwygeJ7uaNUKxhsF-bx=ufchkx7M6G0E237=-0C7GwJ3yog@mail.gmail.com>
 <CAJpMwyjJSu4exkTAoFLhY-ubzNQLp6nWqq83k6vWn1Uw3eaK_Q@mail.gmail.com>
 <CAJpMwygqz20=H7ovSL0nSWLbVpMv-KLOgYO=nRCLv==OC8sgHw@mail.gmail.com>
 <20200623121721.GZ6578@ziepe.ca> <CAJpMwyj_Fa6AhYXcGh4kS79Vd2Dy3N7B5-9XhKHn4qWDo-HVjw@mail.gmail.com>
 <20200623142400.GB6578@ziepe.ca>
In-Reply-To: <20200623142400.GB6578@ziepe.ca>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Tue, 23 Jun 2020 17:05:51 +0530
Message-ID: <CAJpMwygDGpzmhzeYcy=14sBneSriBcRT6B2sO1rubkQLRKnOjA@mail.gmail.com>
Subject: Re: [PATCH] Delay the initialization of rnbd_server module to
 late_initcall level
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>, dledford@redhat.com,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 23, 2020 at 7:54 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jun 23, 2020 at 07:15:03PM +0530, Haris Iqbal wrote:
> > On Tue, Jun 23, 2020 at 5:47 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Jun 23, 2020 at 03:20:27PM +0530, Haris Iqbal wrote:
> > > > Hi Jason and Leon,
> > > >
> > > > Did you get a chance to look into my previous email?
> > >
> > > Was there a question?
> >
> > Multiple actually :)
> >
> > >
> > > Jason
> >
> > In response to your emails,
> >
> > > Somehow nvme-rdma works:
> >
> > I think that's because the callchain during the nvme_rdma_init_module
> > initialization stops at "nvmf_register_transport()". Here only the
> > "struct nvmf_transport_ops nvme_rdma_transport" is registered, which
> > contains the function "nvme_rdma_create_ctrl()". I tested this in my
> > local setup and during kernel boot, that's the extent of the
> > callchain.
> > The ".create_ctrl"; which now points to "nvme_rdma_create_ctrl()" is
> > called later from "nvmf_dev_write()". I am not sure when this is
> > called, probably when the "discover" happens from the client side or
> > during the server config.
> >
> > It seems that the "rdma_bind_addr()" is called by the nvme rdma
> > module; but during the following events
> > 1) When a discover happens from the client side. Call trace for that looks like,
> > [ 1098.409398] nvmf_dev_write
> > [ 1098.409403] nvmf_create_ctrl
> > [ 1098.414568] nvme_rdma_create_ctrl
> > [ 1098.415009] nvme_rdma_setup_ctrl
> > [ 1098.415010] nvme_rdma_configure_admin_queue
> > [ 1098.415010] nvme_rdma_alloc_queue
> > [ 1098.415032] rdma_resolve_addr
> > [ 1098.415032] cma_bind_addr
> > [ 1098.415033] rdma_bind_addr
> >
> > 2) When a connect happens from the client side. Call trace is the same
> > as above, plus "nvme_rdma_alloc_queue()" is called n number of times;
> > n being the number of IO queues being created.
> >
> > On the server side, when an nvmf port is enabled, that also triggers a
> > call to "rdma_bind_addr()", but that is not from the nvme rdma module.
> > may be nvme target rdma? (not sure).
> >
> > Does this make sense or am I missing something here?
>
> It make sense, delaying creating and CM ID's until user space starts
> will solve this init time problme

Right, and the patch is trying to achieve the delay by changing the
init level to "late_initcall()"

>
> >
> > > If the rdma_create_id() is not on a callchain from module_init then you don't have a problem.
> >
> > I am a little confused. I thought the problem occurs from a call to
> > either "rdma_resolve_addr()" which calls "rdma_bind_addr()",
> > or a direct call to "rdma_bind_addr()" as in rtrs case.
> > In both the cases, a call to "rdma_create_id()" is needed before this.
>
> Right rdma_create_id() must precede anything that has problems, and it
> should not be done from module_init.

I understand this, but I am not sure why that is; as in why it should
not be done from module_init?

Also, about one of your previous statements,

> It is not OK to create RDMA CM IDs outside
> a client - CM IDs are supposed to be cleaned up when the client is
> removed.
>
> Similarly they are supposed to be created from the client attachment.

This again is a little confusing to me, since what I've observed in
nvmt is, when a server port is created, the "rdma_bind_addr()"
function is called.
And this goes well with the server/target and client/initiator model,
where the server has to get ready and start listening before a client
can initiate a connection.
What am I missing here?

>
> Jason

-- 

Regards
-Haris
