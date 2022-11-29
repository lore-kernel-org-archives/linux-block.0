Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2827FC4321E
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 03:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiK2DiV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 22:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiK2DiU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 22:38:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270F24A9EC
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 19:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669693042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DjWTah+2EKxcXo7oWQgA5SpjVxywoPSBhBg+WInwWOQ=;
        b=gfa7O35WEZiNpPLNiD4W1HnSy6Ac64D4P4fMl/Zml/QvKCZHx3T30QQtfufXzIu/ho3wAe
        q6jyY2C2uqvfAzqFcl5RbguTZjKnPvk8lRhT82blzDNjRkUqrZ0CG5b8Kg/mNh76i0yuVX
        dkg4xJokGvxULV4qVbchNxdLn92bj3U=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-224-X81rdo-ZNC-hwkB30pc2hg-1; Mon, 28 Nov 2022 22:37:21 -0500
X-MC-Unique: X81rdo-ZNC-hwkB30pc2hg-1
Received: by mail-oo1-f71.google.com with SMTP id v16-20020a4a2450000000b004a0455483e1so1819911oov.16
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 19:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjWTah+2EKxcXo7oWQgA5SpjVxywoPSBhBg+WInwWOQ=;
        b=8ElFqOP27Zj3fVLdNo1nWVnnr9y5e8dH7rAHOEefGrchRnlrHXnfIf2Jqbo/59qf8j
         1j5TmC4+sI/YDJxn50SNIIZXcbl09mjVVNk8oH+sZ/dMQJYTKO/jhHB+mXpmgm+sFC6G
         2fuOn5fe6a2iL1hYprHMQR14ORF1EJOQ19yC7VBsTBAnqkZwYX97QBNpMRzKw5XxFYJw
         Opt5yetq9dZ+0ap6BDxX4jHD2bZoSBBnmHgHNiRGHPR+7J35WiXj7duW6AGWN1T5lCi0
         OmkKrTgPgOoOp1zYlc7SqJ4BkDstQmHahAGmu9bY7PCtzcJXpZURphY9gAU8vVxLGPOV
         nPSw==
X-Gm-Message-State: ANoB5pkR0ey/JGg5A9rlTGIP+xU0JKCmWBHZnqfJVQwEF4P9xaC8FkBY
        aD9Oaxlvt/XpOg139Ju0qEqmE6v+wEPkPlMq9KbAJ+NzHfAiT/aNLJ71oHmNotcO5B61i1/l4Hv
        A2Tzba72cTxtK5Bk6srqH0MswaX5QVx5leiVGkhk=
X-Received: by 2002:a9d:4f07:0:b0:66c:64d6:1bb4 with SMTP id d7-20020a9d4f07000000b0066c64d61bb4mr27085066otl.201.1669693040559;
        Mon, 28 Nov 2022 19:37:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6EmIDabO2AHcWjiaME3fUs69AGG9zkVypks4R3pv1UesNWwbFvYcjoNz9Z4Pyc98HwSff6j5CYa7YoG0PBT3E=
X-Received: by 2002:a9d:4f07:0:b0:66c:64d6:1bb4 with SMTP id
 d7-20020a9d4f07000000b0066c64d61bb4mr27085052otl.201.1669693040323; Mon, 28
 Nov 2022 19:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20221128021005.232105-1-lizetao1@huawei.com> <20221128042945-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221128042945-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 29 Nov 2022 11:37:09 +0800
Message-ID: <CACGkMEtuOk+wyCsvY0uayGAvy926G381PC-csoXVAwCfiKCZQw@mail.gmail.com>
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

On Mon, Nov 28, 2022 at 6:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Nov 28, 2022 at 10:10:01AM +0800, Li Zetao wrote:
> > This patchset fixes similar issue, the root cause of the
> > problem is that the virtqueues are not stopped on error
> > handling path.
>
> I've been thinking about this.
> Almost all drivers are affected.
>
> The reason really is that it used to be the right thing to do:
> On legacy pci del_vqs writes 0
> into vq index

into vq address actually?

> and this resets the device as a side effect

I think there's no guarantee for a device to do this.

> (we actually do this multiple times, what e.g. writes of MSI vector
>  after the 1st reset do I have no idea).
>
> mmio ccw and modern pci don't.
>
> Given this has been with us for a while I am inlined to look for
> a global solution rather than tweaking each driver.

But do we still need patches for -stable at least?

>
> Given many drivers are supposed to work on legacy too, we know del_vqs
> includes a reset for many of them. So I think I see a better way to do
> this:
>
> Add virtio_reset_device_and_del_vqs()

What's the difference with the current del_vqs method? Is this something like:

virtio_reset_device();
config->del_vqs();

>
> and convert all drivers to that.
>
> When doing this, we also need to/can fix a related problem (and related
> to the hardening that Jason Wang was looking into):
> virtio_reset_device is inherently racy: vq interrupts could
> be in flight when we do reset. We need to prevent handlers from firing in
> the window between reset and freeing the irq, so we should first
> free irqs and only then start changing the state by e.g.
> device reset.

Yes.

>
>
> Quite a lot of core work here. Jason are you still looking into
> hardening?

Yes, last time we've discussed a solution that depends on the first
kick to enable the interrupt handler. But after some thought, it seems
risky since there's no guarantee that the device work in this way.

One example is the current vhost_net, it doesn't wait for the kick to
process the rx packets. Any more thought on this?

Thanks


>
>
>
> > Li Zetao (4):
> >   9p: Fix probe failed when modprobe 9pnet_virtio
> >   virtio-mem: Fix probe failed when modprobe virtio_mem
> >   virtio-input: Fix probe failed when modprobe virtio_input
> >   virtio-blk: Fix probe failed when modprobe virtio_blk
> >
> >  drivers/block/virtio_blk.c    | 1 +
> >  drivers/virtio/virtio_input.c | 1 +
> >  drivers/virtio/virtio_mem.c   | 1 +
> >  net/9p/trans_virtio.c         | 1 +
> >  4 files changed, 4 insertions(+)
> >
> > --
> > 2.25.1
>

