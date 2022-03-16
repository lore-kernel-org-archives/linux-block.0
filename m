Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2971C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 02:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245465AbiCPCDm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 22:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiCPCDl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 22:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95A285C865
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 19:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647396147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o37LbVxFoFTbHwgohf/LnM2c2D+jii/VdcCnff+u9NU=;
        b=h0/JBzYp/4gSm3cHZyF11qZl8MaEdtSF0uVFpMMiHTgs5JvRj9JQg+x3e1Zh1pF9hMiUvP
        90M7fUdbDW+SUgKdTzipsMNdWbXSppLWu0razWFEk9h9rYz79JJ7MXPvGqkSd8TyVXDPVC
        M3qcDOcxxK673e0OVTGMWOOK2eVg3/A=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-AokoUK4SO5SgHhdfL0eg3w-1; Tue, 15 Mar 2022 22:02:25 -0400
X-MC-Unique: AokoUK4SO5SgHhdfL0eg3w-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-2dbfe49a4aaso7307967b3.5
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 19:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o37LbVxFoFTbHwgohf/LnM2c2D+jii/VdcCnff+u9NU=;
        b=VuGqkz7m7idxS5riF3/oEgyMNq7K6Dq6zP5jstUscRDxa+6LaIuKNJGeX/D7QYtkm6
         oByx66ogy8jzJBYilugohD9VVUgB3rzwEW50mtcgLOa2e2msJ2Ey2PMsaIV3fTWY6EQO
         JasLHI43efh0z2lJ3nLSLl90Wsmx8NeTRrtGMFaADcJ9QMW7zklM16zu71UclwTZVX5f
         9ecSvQKbSkJn8tsDZ8QpCJAI8s3CER6dJFZa66cdbOH/xz54j6xB/XMoPH/2hhTbFUOE
         YuH92ncCOWZe1hxwS1pYzHreSXwnIfHIcX7Opf5k/eNGcGtPdpx0uej43vqt9zpiuiAp
         PXxg==
X-Gm-Message-State: AOAM5334EY6QmCq1Z9EgY1KdZ2SnXT0AkUfTdil4OOFnowifPn3Gv43i
        ifN7O7PiPAETT1RJLI3QMztijxDzVInnsDftrnOsBXKgDdRJHzMWpMDEHS6YOF6E5DXQ91yd1Z2
        rUDBuYnZvmdxvYlVh2EkqxwpbXg0Knl1ZOQSFzMk=
X-Received: by 2002:a81:d50c:0:b0:2e5:8836:fd3c with SMTP id i12-20020a81d50c000000b002e58836fd3cmr6662127ywj.152.1647396144899;
        Tue, 15 Mar 2022 19:02:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKFPpjUd1sLV1ynNZptANCctqBe8rTJFe/lMdb+mkXy5jBmNpVPspV5AMEWkK64Xzzx1M5KEbv0HsCX/fYCl4=
X-Received: by 2002:a81:d50c:0:b0:2e5:8836:fd3c with SMTP id
 i12-20020a81d50c000000b002e58836fd3cmr6662108ywj.152.1647396144685; Tue, 15
 Mar 2022 19:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com> <Yi82BL9KecQsVfgX@localhost.localdomain>
 <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com> <YjCmBkjgtQZffiXw@localhost.localdomain>
In-Reply-To: <YjCmBkjgtQZffiXw@localhost.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 16 Mar 2022 10:02:13 +0800
Message-ID: <CACGkMEtxadf1+0Db06nE3SuQZhvyELq7ZwvKaH8x_utj91dRdg@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst <mst@redhat.com>, pbonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 10:43 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
>
> On Tue, Mar 15, 2022 at 04:59:23PM +0800, Jason Wang wrote:
> > On Mon, Mar 14, 2022 at 8:33 PM Suwan Kim <suwan.kim027@gmail.com> wrot=
e:
> >
> > > On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
> > > >
> > > > =E5=9C=A8 2022/3/11 =E4=B8=8B=E5=8D=8811:28, Suwan Kim =E5=86=99=E9=
=81=93:
> > > > > diff --git a/include/uapi/linux/virtio_blk.h
> > > b/include/uapi/linux/virtio_blk.h
> > > > > index d888f013d9ff..3fcaf937afe1 100644
> > > > > --- a/include/uapi/linux/virtio_blk.h
> > > > > +++ b/include/uapi/linux/virtio_blk.h
> > > > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > > > >      * deallocation of one or more of the sectors.
> > > > >      */
> > > > >     __u8 write_zeroes_may_unmap;
> > > > > +   __u8 unused1;
> > > > > -   __u8 unused1[3];
> > > > > +   __virtio16 num_poll_queues;
> > > > >   } __attribute__((packed));
> > > >
> > > >
> > > > This looks like a implementation specific (virtio-blk-pci) optimiza=
tion,
> > > how
> > > > about other implementation like vhost-user-blk?
> > >
> > > I didn=E2=80=99t consider vhost-user-blk yet. But does vhost-user-blk=
 also
> > > use vritio_blk_config as kernel-qemu interface?
> > >
> >
> > Yes, but see below.
> >
> >
> > >
> > > Does vhost-user-blk need additional modification to support polling
> > > in kernel side?
> > >
> >
> >
> > No, but the issue is, things like polling looks not a good candidate fo=
r
> > the attributes belonging to the device but the driver. So I have more
> > questions:
> >
> > 1) what does it really mean for hardware virtio block devices?
> > 2) Does driver polling help for the qemu implementation without polling=
?
> > 3) Using blk_config means we can only get the benefit from the new devi=
ce
>
> 1) what does it really mean for hardware virtio block devices?
> 3) Using blk_config means we can only get the benefit from the new device
>
> This patch adds dedicated HW queue for polling purpose to virtio
> block device.
>
> So I think it can be a new hw feature. And it can be a new device
> that supports hw poll queue.

One possible issue is that the "poll" looks more like a
software/driver concept other than the device/hardware.

>
> BTW, I have other idea about it.
>
> How about adding =E2=80=9Cnum-poll-queues" property as a driver parameter
> like NVMe driver, not to QEMU virtio-blk-pci property?

It should be fine, but we need to listen to others.

>
> If then, we don=E2=80=99t need to modify virtio_blk_config.
> And we can apply the polling feature only to virtio-blk-pci.
> But can QEMU pass =E2=80=9Cnum-poll-queues" to virtio-blk driver param?

As Michael said we can leave this to guest kernel / administrator.

>
>
>
> 2) Does driver polling help for the qemu implementation without polling?
>
> Sorry, I didn't understand your question. Could you please explain more a=
bout?

I mean does the polling work for the ordinary qemu block device
without busy polling?

Thanks

>
> Regards,
> Suwan Kim
>

