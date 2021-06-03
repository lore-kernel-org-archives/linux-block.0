Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DFAC47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B537961208
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 15:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFCP0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 11:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229818AbhFCP0L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Jun 2021 11:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622733866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2dgSfYYpXwBodnxak+oieIso4PBe+1C5Rbth+oHRhQs=;
        b=Hc1dMyUNUIhGzZFoPZVLHBnU3Xgmisok4pQRNEu8a4UmRzutgXR+a7YcTKRoLlTjPsiCdI
        recXx5/J95Xr+0GVlpeOfCBidIyVj72giAqy3S4iHhGGxC96oqA83KOhnMNzphm0+n42dl
        +xQ/y9J6tcNDIBUHacBNm3bVg9RkOVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-u4Hqj26qNXKSNwFSaCxFJQ-1; Thu, 03 Jun 2021 11:24:25 -0400
X-MC-Unique: u4Hqj26qNXKSNwFSaCxFJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1149801817;
        Thu,  3 Jun 2021 15:24:23 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86BDD60C17;
        Thu,  3 Jun 2021 15:24:17 +0000 (UTC)
Date:   Thu, 3 Jun 2021 16:24:16 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <YLj0IN6rFuBMjzQQ@stefanha-x1.localdomain>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
 <eefac014-0361-b554-ffdc-2ce920810fa5@redhat.com>
 <YKy8Znh/MqHWSmON@stefanha-x1.localdomain>
 <c51191b8-d741-2abc-0446-8a139e2ea401@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vxiBSKnm2AIk6CUa"
Content-Disposition: inline
In-Reply-To: <c51191b8-d741-2abc-0446-8a139e2ea401@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--vxiBSKnm2AIk6CUa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 01:48:36PM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/5/25 =E4=B8=8B=E5=8D=884:59, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Tue, May 25, 2021 at 11:21:41AM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/5/20 =E4=B8=8B=E5=8D=8810:13, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
> > > > Request completion latency can be reduced by using polling instead =
of
> > > > irqs. Even Posted Interrupts or similar hardware support doesn't be=
at
> > > > polling. The reason is that disabling virtqueue notifications saves
> > > > critical-path CPU cycles on the host by skipping irq injection and =
in
> > > > the guest by skipping the irq handler. So let's add blk_mq_ops->pol=
l()
> > > > support to virtio_blk.
> > > >=20
> > > > The approach taken by this patch differs from the NVMe driver's
> > > > approach. NVMe dedicates hardware queues to polling and submits
> > > > REQ_HIPRI requests only on those queues. This patch does not require
> > > > exclusive polling queues for virtio_blk. Instead, it switches betwe=
en
> > > > irqs and polling when one or more REQ_HIPRI requests are in flight =
on a
> > > > virtqueue.
> > > >=20
> > > > This is possible because toggling virtqueue notifications is cheap =
even
> > > > while the virtqueue is running. NVMe cqs can't do this because irqs=
 are
> > > > only enabled/disabled at queue creation time.
> > > >=20
> > > > This toggling approach requires no configuration. There is no need =
to
> > > > dedicate queues ahead of time or to teach users and orchestration t=
ools
> > > > how to set up polling queues.
> > > >=20
> > > > Possible drawbacks of this approach:
> > > >=20
> > > > - Hardware virtio_blk implementations may find virtqueue_disable_cb=
()
> > > >     expensive since it requires DMA.
> > >=20
> > > Note that it's probably not related to the behavior of the driver but=
 the
> > > design of the event suppression mechanism.
> > >=20
> > > Device can choose to ignore the suppression flag and keep sending
> > > interrupts.
> > Yes, it's the design of the event suppression mechanism.
> >=20
> > If we use dedicated polling virtqueues then the hardware doesn't need to
> > check whether interrupts are enabled for each notification. However,
> > there's no mechanism to tell the device that virtqueue interrupts are
> > permanently disabled. This means that as of today, even dedicated
> > virtqueues cannot suppress interrupts without the device checking for
> > each notification.
>=20
>=20
> This can be detected via a transport specific way.
>=20
> E.g in the case of MSI, VIRTIO_MSI_NO_VECTOR could be a hint.

Nice idea :). Then there would be no need for changes to the hardware
interface. IRQ-less virtqueues is could still be mentioned explicitly in
the VIRTIO spec so that driver/device authors are aware of the
VIRTIO_MSI_NO_VECTOR trick.

> > > > +static int virtblk_poll(struct blk_mq_hw_ctx *hctx)
> > > > +{
> > > > +	struct virtio_blk *vblk =3D hctx->queue->queuedata;
> > > > +	struct virtqueue *vq =3D vblk->vqs[hctx->queue_num].vq;
> > > > +
> > > > +	if (!virtqueue_more_used(vq))
> > >=20
> > > I'm not familiar with block polling but what happens if a buffer is m=
ade
> > > available after virtqueue_more_used() returns false here?
> > Can you explain the scenario, I'm not sure I understand? "buffer is made
> > available" -> are you thinking about additional requests being submitted
> > by the driver or an in-flight request being marked used by the device?
>=20
>=20
> Something like that:
>=20
> 1) requests are submitted
> 2) poll but virtqueue_more_used() return false
> 3) device make buffer used
>=20
> In this case, will poll() be triggered again by somebody else? (I think
> interrupt is disabled here).

Yes. An example blk_poll() user is
fs/block_dev.c:__blkdev_direct_IO_simple():

  qc =3D submit_bio(&bio);
  for (;;) {
      set_current_state(TASK_UNINTERRUPTIBLE);
      if (!READ_ONCE(bio.bi_private))
          break;
      if (!(iocb->ki_flags & IOCB_HIPRI) ||
          !blk_poll(bdev_get_queue(bdev), qc, true))
          blk_io_schedule();
  }

That's the infinite loop. The block layer implements the generic portion
of blk_poll(). blk_poll() calls mq_ops->poll() (virtblk_poll()).

So in general the polling loop will keep iterating, but there are
exceptions:
1. need_resched() causes blk_poll() to return 0 and blk_io_schedule()
   will be called.
2. blk-mq has a fancier io_poll algorithm that estimates I/O time and
   sleeps until the expected completion time to save CPU cycles. I
   haven't looked into detail at this one.

Both these cases affect existing mq_ops->poll() implementations (e.g.
NVMe). What's new in this patch series is that virtio-blk could have
non-polling requests on the virtqueue which now has irqs disabled. So we
could wait for them.

I think there's an easy solution for this: don't disable virtqueue irqs
when there are non-REQ_HIPRI requests in flight. The disadvantage is
that we'll keep irqs disable in more situations so the performance
improvement may not apply in some configurations.

Stefan

--vxiBSKnm2AIk6CUa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC49CAACgkQnKSrs4Gr
c8g9SggApFtVeNv8a9846y9j4yHxsw8MKkrLJR8eFajwxJYH9o4S5y1rW1nKURxn
0QI9IlDe3z/jkcaeidvP1JaiEPpDweEOuJ5R/TTRfixSMCjR5kY9+A2AOh8gHOx6
sIejzjF0BeUcD8hZzTT/tWDXRojxCcZM+NMrf4nefzOjNkOh3tCXPTm0Ov6wX34I
TlAI/I1DFtGx92j3tqcgJmQpie48arGTLPX6qSrWABM7IG5bcJK8tnbwkp2AKAZX
xJcNTADB0vygduI+33Ttv35gDy11zOoe9RaKdBmpJzhNTm77glSlXWMupe2b5uo+
/iPZIP3AZMMrehTbSpFricIMzMBSPQ==
=reHh
-----END PGP SIGNATURE-----

--vxiBSKnm2AIk6CUa--

