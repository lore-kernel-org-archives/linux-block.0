Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7014FC433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Mar 2022 02:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiCQCVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 22:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiCQCVf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 22:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71ECD1BE92
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 19:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647483619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPCfzxyjMhxLP4qSRwQ+hURc5goubZq4R+xZPtQNplE=;
        b=FZh+BFUO7Y9ZW6k1zK66mexuOBvAvp8u5RtYhqLoIK+dmTm8rraxj/QdjA6OLGlwBNE5qJ
        kv0DBo6XlO6dlM8W+WEfcq7YzLSBI1VgblRFkhuc3jHy8+ux4RZ7xhv4cDeIcY8cW9+nF5
        0GvrynipnkP1OxvGPGZobaw3nT+XwJg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-JBTwAllqNUu2MAteK9q4sw-1; Wed, 16 Mar 2022 22:20:18 -0400
X-MC-Unique: JBTwAllqNUu2MAteK9q4sw-1
Received: by mail-lj1-f200.google.com with SMTP id 185-20020a2e05c2000000b002463aff775aso1551739ljf.17
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 19:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nPCfzxyjMhxLP4qSRwQ+hURc5goubZq4R+xZPtQNplE=;
        b=M0mJjjSCAYjq/NMlNVK6tnt5ibX0psAj96vVQct63KrFY2TVtjAWaYWirPFfkj5uiW
         gYfxKA3XAy+PCJ9oy2oUYZjQjF/5jSW7mWRL1d8vpJ1Q+jGVMi2dGa7k4jloqCc7626o
         dbPxj/IcJMrp7+2xY/G+83W4cw8sE3IKf6gIgqTKbcDZuL5Uwx3CJNMMu2xk/1Bx5j/c
         DN3C71Ulb7rB8BA0WyUKbi3G2YJSqzTfrJahSEebykZFbCRf/eqo3/GdCAK98u5U4Mcz
         CCYgK+EGIZtz2rKrXRzsFg4lpHP7DchqqZYhMPqpRRyocpQcYRJ8kV1LL70DRwsK0R++
         k9eQ==
X-Gm-Message-State: AOAM532sSsOjVpFZgfm0iA+Jt9t3DmAApOmKhIVS4TXcijBnWGUVd8Ha
        +iUd7YafZ2AiQdPBQjJ6jXCNbBX12R+0noBK1pA0Qy/8GQQ+oWe7Dx2xLSXNNpNZfarfPNEqBYc
        AX6KC6ocPYYXZkm5qImGcXdAYroTf0cv99GLksUI=
X-Received: by 2002:a05:651c:b23:b0:247:ee17:e9ed with SMTP id b35-20020a05651c0b2300b00247ee17e9edmr1466185ljr.243.1647483616418;
        Wed, 16 Mar 2022 19:20:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBCg7wlhjy6Rcdi31sE5bb7ELPAmbhPDTsbU5Jc7PjWTT/34HozDuP3hNEXZTNkG2RGvy9B9CMVr5KB2Cun9k=
X-Received: by 2002:a05:651c:b23:b0:247:ee17:e9ed with SMTP id
 b35-20020a05651c0b2300b00247ee17e9edmr1466175ljr.243.1647483616214; Wed, 16
 Mar 2022 19:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com> <Yi82BL9KecQsVfgX@localhost.localdomain>
 <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
 <YjCmBkjgtQZffiXw@localhost.localdomain> <CACGkMEtxadf1+0Db06nE3SuQZhvyELq7ZwvKaH8x_utj91dRdg@mail.gmail.com>
 <YjIDIjUwuwkfRS2d@localhost.localdomain>
In-Reply-To: <YjIDIjUwuwkfRS2d@localhost.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 17 Mar 2022 10:20:05 +0800
Message-ID: <CACGkMEu8T8_9gJMGybMZVCT9zCrw+OaTtbhtvnUNUORNmYKw-A@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst <mst@redhat.com>, pbonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 16, 2022 at 11:33 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
>
> On Wed, Mar 16, 2022 at 10:02:13AM +0800, Jason Wang wrote:
> > On Tue, Mar 15, 2022 at 10:43 PM Suwan Kim <suwan.kim027@gmail.com> wro=
te:
> > >
> > > On Tue, Mar 15, 2022 at 04:59:23PM +0800, Jason Wang wrote:
> > > > On Mon, Mar 14, 2022 at 8:33 PM Suwan Kim <suwan.kim027@gmail.com> =
wrote:
> > > >
> > > > > On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
> > > > > >
> > > > > > =E5=9C=A8 2022/3/11 =E4=B8=8B=E5=8D=8811:28, Suwan Kim =E5=86=
=99=E9=81=93:
> > > > > > > diff --git a/include/uapi/linux/virtio_blk.h
> > > > > b/include/uapi/linux/virtio_blk.h
> > > > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > > > >      * deallocation of one or more of the sectors.
> > > > > > >      */
> > > > > > >     __u8 write_zeroes_may_unmap;
> > > > > > > +   __u8 unused1;
> > > > > > > -   __u8 unused1[3];
> > > > > > > +   __virtio16 num_poll_queues;
> > > > > > >   } __attribute__((packed));
> > > > > >
> > > > > >
> > > > > > This looks like a implementation specific (virtio-blk-pci) opti=
mization,
> > > > > how
> > > > > > about other implementation like vhost-user-blk?
> > > > >
> > > > > I didn=E2=80=99t consider vhost-user-blk yet. But does vhost-user=
-blk also
> > > > > use vritio_blk_config as kernel-qemu interface?
> > > > >
> > > >
> > > > Yes, but see below.
> > > >
> > > >
> > > > >
> > > > > Does vhost-user-blk need additional modification to support polli=
ng
> > > > > in kernel side?
> > > > >
> > > >
> > > >
> > > > No, but the issue is, things like polling looks not a good candidat=
e for
> > > > the attributes belonging to the device but the driver. So I have mo=
re
> > > > questions:
> > > >
> > > > 1) what does it really mean for hardware virtio block devices?
> > > > 2) Does driver polling help for the qemu implementation without pol=
ling?
> > > > 3) Using blk_config means we can only get the benefit from the new =
device
> > >
> > > 1) what does it really mean for hardware virtio block devices?
> > > 3) Using blk_config means we can only get the benefit from the new de=
vice
> > >
> > > This patch adds dedicated HW queue for polling purpose to virtio
> > > block device.
> > >
> > > So I think it can be a new hw feature. And it can be a new device
> > > that supports hw poll queue.
> >
> > One possible issue is that the "poll" looks more like a
> > software/driver concept other than the device/hardware.
> >
> > >
> > > BTW, I have other idea about it.
> > >
> > > How about adding =E2=80=9Cnum-poll-queues" property as a driver param=
eter
> > > like NVMe driver, not to QEMU virtio-blk-pci property?
> >
> > It should be fine, but we need to listen to others.
>
> To Michael, Stefan, Max
>
> How about using driver parameter instead of virio_blk_config?

I agree.

Thanks

>
> Regards,
> Suwan Kim
>

