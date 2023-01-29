Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674CCC05027
	for <linux-block@archiver.kernel.org>; Sun, 29 Jan 2023 05:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjA2Fvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Jan 2023 00:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjA2Fvb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Jan 2023 00:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909C521A05
        for <linux-block@vger.kernel.org>; Sat, 28 Jan 2023 21:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674971443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ESfJeO4v/Sc9kZuGNKusexDTFykbAPKz0X+uhnEfDU=;
        b=MLV/P/Rdubq5VcL7aPcEpSPNS8/P6co70ymJohI84/ffAPeYeKeI+9TvQ+faXRDdtoW8Le
        OlV4y0hJC0PqYecotHk+uRu3b3vxP5pqsX8XsAV5Mr+a7k2RRupJ1Ijfn03khcJEZTxtKr
        uAOMlzf6WN4AraIQeg4sRxoYxJUYYeI=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-gRhEWoLCMYK41M1cgd06YQ-1; Sun, 29 Jan 2023 00:50:41 -0500
X-MC-Unique: gRhEWoLCMYK41M1cgd06YQ-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-16364c64654so2331549fac.10
        for <linux-block@vger.kernel.org>; Sat, 28 Jan 2023 21:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ESfJeO4v/Sc9kZuGNKusexDTFykbAPKz0X+uhnEfDU=;
        b=Ymaht4Jna2UPqPngvdrX5fNQGyGq11DbWlLWt+TApozbHo9gu8UvJGmcummxW+W9ai
         yuVgtdk4VJjHhweRBis6GdDAgEpr1LQ923gcQli8wlEecGXnlnsUKtORit4asxQ+OQrC
         TM+ss5+3dU+b1eHoA392juV6YEWqF07i8ltB8AQvTNU9+kIK/NzpKkd+Nr5cI5DWo9oa
         qOk805NcSxR8z6yOBADGxjRoO0KrI5UJBpjULScKfCiYDidRaO4BOdM8NkhzCHFC3AiE
         vEDFagpQtCLQIyTrD0AJFN2QIbOTilGv94vfXKYiDfaIbqH2tabH6gEru922MkFqLqGt
         n5dw==
X-Gm-Message-State: AO0yUKXly/LWFu9Y652DnyBsSP1k2u7l8I/VhNFhooFnKnYFYWNWBpU6
        CwO5I4zSKeljYMi9urXmPdAQ96Uhq6rocGP+KgL4zPytTU+/3gDra70v7mmTIpOMxMerBPRgC+P
        uhQn2wzs8x/ab3905lEJDcUJgSUcRMqJOHo+4o/E=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id k30-20020a056870959e00b001639ceaeea7mr115404oao.35.1674971440496;
        Sat, 28 Jan 2023 21:50:40 -0800 (PST)
X-Google-Smtp-Source: AK7set+UoO/1kphXCPY28/DKX9hwQUG6JjAGE74TUF7dLTKDNr1tk08D4Bhi3bKgLWdo5+0Rqlh3eus5Dyvey48IMPg=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr115403oao.35.1674971440262; Sat, 28 Jan
 2023 21:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20221128021005.232105-1-lizetao1@huawei.com> <20221128042945-mutt-send-email-mst@kernel.org>
 <20230127061055-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230127061055-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Sun, 29 Jan 2023 13:50:29 +0800
Message-ID: <CACGkMEszd0O-juD93nMQEmOA0w+rq_pE-je5xj+XkMc7nwUR4w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Li Zetao <lizetao1@huawei.com>, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk, kraxel@redhat.com,
        david@redhat.com, ericvh@gmail.com, lucho@ionkov.net,
        asmadeus@codewreck.org, linux_oss@crudebyte.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, rusty@rustcorp.com.au,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 27, 2023 at 7:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Nov 28, 2022 at 05:14:44AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Nov 28, 2022 at 10:10:01AM +0800, Li Zetao wrote:
> > > This patchset fixes similar issue, the root cause of the
> > > problem is that the virtqueues are not stopped on error
> > > handling path.
> >
> > I've been thinking about this.
> > Almost all drivers are affected.
> >
> > The reason really is that it used to be the right thing to do:
> > On legacy pci del_vqs writes 0
> > into vq index and this resets the device as a side effect
> > (we actually do this multiple times, what e.g. writes of MSI vector
> >  after the 1st reset do I have no idea).
> >
> > mmio ccw and modern pci don't.
> >
> > Given this has been with us for a while I am inlined to look for
> > a global solution rather than tweaking each driver.
> >
> > Given many drivers are supposed to work on legacy too, we know del_vqs
> > includes a reset for many of them. So I think I see a better way to do
> > this:
> >
> > Add virtio_reset_device_and_del_vqs()
> >
> > and convert all drivers to that.
> >
> > When doing this, we also need to/can fix a related problem (and related
> > to the hardening that Jason Wang was looking into):
> > virtio_reset_device is inherently racy: vq interrupts could
> > be in flight when we do reset. We need to prevent handlers from firing in
> > the window between reset and freeing the irq, so we should first
> > free irqs and only then start changing the state by e.g.
> > device reset.
> >
> >
> > Quite a lot of core work here. Jason are you still looking into
> > hardening?
> >
>
> Li Zetao, Jason, any updates. You guys looking into this?

At least I will continue the work of IRQ hardening. And this work
could be done on top.

Thanks

>
>
> >
> > > Li Zetao (4):
> > >   9p: Fix probe failed when modprobe 9pnet_virtio
> > >   virtio-mem: Fix probe failed when modprobe virtio_mem
> > >   virtio-input: Fix probe failed when modprobe virtio_input
> > >   virtio-blk: Fix probe failed when modprobe virtio_blk
> > >
> > >  drivers/block/virtio_blk.c    | 1 +
> > >  drivers/virtio/virtio_input.c | 1 +
> > >  drivers/virtio/virtio_mem.c   | 1 +
> > >  net/9p/trans_virtio.c         | 1 +
> > >  4 files changed, 4 insertions(+)
> > >
> > > --
> > > 2.25.1
>

