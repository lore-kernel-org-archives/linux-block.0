Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65980C54EAA
	for <linux-block@archiver.kernel.org>; Fri, 27 Jan 2023 11:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjA0LMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 06:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjA0LMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 06:12:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB22E40BE8
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 03:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674817921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DHdIigeHoqEjPUOvZqjrQoWLn5deR3YQuYptQY45zS0=;
        b=FVb95kZWiQcDVnhXeFclelW/2wYWsw1qbWIxBJ7Nm0Ylcx5WV8TChArN6wfZyMAs3R5nHp
        iigUD+aDDpiGsqkMGs80f/YyKlcEk12N7Fxvw7FnCh19v3e5UdmqKDi3ubMexEzCjGv3RO
        VqKhBUL64HsdDoS2vU5+9mhqvqf0eVw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-LIXPv2GlOU22IOSHqvo3vw-1; Fri, 27 Jan 2023 06:11:57 -0500
X-MC-Unique: LIXPv2GlOU22IOSHqvo3vw-1
Received: by mail-ed1-f71.google.com with SMTP id h18-20020a05640250d200b0049e0e9382c2so3378943edb.13
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 03:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHdIigeHoqEjPUOvZqjrQoWLn5deR3YQuYptQY45zS0=;
        b=pJ39KbYLi3bNNk5+0Hz6Zl7faK+fMuahkPA6drEMgJ/b7lx4fHU2WV+3GNPbcbVasX
         tmfMMzMrNAHiduSdmeB3iVrAIGws61fUsUpIwpBSV4u4vbGx7dEl02e5Dl9T8+pHjmUi
         uFRbUPOkbUjy/RavNpLLwGrO4tnsCmok5w+NpVF0kPlFuPigXCtn8tLBdaM9Wxof81kQ
         Tbe3M6UscKVN14XO+KY8dOuubQhSKjyJPAat76TPq6u1e44vj90Zx3T1j+q5DarqF/x6
         J6BM5pqjyET8+OYGX4yQ5zbqFKuHA9OqNgv8M5UBBm9EdsTxPf2Adn/ug24fL43xMwaZ
         8BUg==
X-Gm-Message-State: AFqh2kpyP41bKpqKeDz9RyP1CKOwKm+bXCNp1me1dU5IkVPW+2Tjcyj1
        v+RouKVeMzFO0dWFx/6zA9W09wl+7Xd9ezb3OcGGLU06wKiCStBSfi4R3iIvuCxK1Nlym5aM5XL
        fhnbLIhVHqXh0VchE7gMlMGQ=
X-Received: by 2002:a17:907:9a09:b0:85d:3771:18b7 with SMTP id kr9-20020a1709079a0900b0085d377118b7mr42740076ejc.70.1674817915955;
        Fri, 27 Jan 2023 03:11:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsScJCcghnX87V9jwJo9iQJunv09UWVsejj9/e/mmA0Ci2VvxS4YOTGCYGulNVAT6QXBdRv0w==
X-Received: by 2002:a17:907:9a09:b0:85d:3771:18b7 with SMTP id kr9-20020a1709079a0900b0085d377118b7mr42740046ejc.70.1674817915717;
        Fri, 27 Jan 2023 03:11:55 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090668ce00b0084d3bf4498csm2082705ejr.140.2023.01.27.03.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:11:55 -0800 (PST)
Date:   Fri, 27 Jan 2023 06:11:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk, kraxel@redhat.com, david@redhat.com,
        ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, rusty@rustcorp.com.au,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
Message-ID: <20230127061055-mutt-send-email-mst@kernel.org>
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128042945-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128042945-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 28, 2022 at 05:14:44AM -0500, Michael S. Tsirkin wrote:
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
> into vq index and this resets the device as a side effect
> (we actually do this multiple times, what e.g. writes of MSI vector
>  after the 1st reset do I have no idea).
> 
> mmio ccw and modern pci don't.
> 
> Given this has been with us for a while I am inlined to look for
> a global solution rather than tweaking each driver.
> 
> Given many drivers are supposed to work on legacy too, we know del_vqs
> includes a reset for many of them. So I think I see a better way to do
> this:
> 
> Add virtio_reset_device_and_del_vqs()
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
> 
> 
> Quite a lot of core work here. Jason are you still looking into
> hardening?
> 

Li Zetao, Jason, any updates. You guys looking into this?


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

