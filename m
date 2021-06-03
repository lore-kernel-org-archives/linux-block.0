Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67612C47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 15:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44237613E9
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 15:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhFCPOF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 11:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231768AbhFCPOE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Jun 2021 11:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622733139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aspJS5aAFAxTpv9L4o0wqmYtlBbE09BO7N3NtCpNCdo=;
        b=H2oKVem2jc/7dVTdJS+HxQjFcVlnYg/NWmlxY4tsduKKPhdf+Cvpj18hxBaQuF5q1QRxWw
        xRVLlOloiE7lvfVX2yaZcpUFzW1UY/LwsMpAmq5DER+UlZPbHcRl73KYgLPJRp/y7lyt3f
        mu+N8NUN7j4OkztfhNKoXGGeJCJeahc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-xmQ1entOM2udCAnwjIJrBA-1; Thu, 03 Jun 2021 11:12:18 -0400
X-MC-Unique: xmQ1entOM2udCAnwjIJrBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B9F6101371E;
        Thu,  3 Jun 2021 15:12:17 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3ABFA5D743;
        Thu,  3 Jun 2021 15:12:06 +0000 (UTC)
Date:   Thu, 3 Jun 2021 16:12:05 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <YLjxRcFN2G98mwH5@stefanha-x1.localdomain>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
 <YK8Ho3mC117M8GXS@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kr/3Sj2ADIR3Iave"
Content-Disposition: inline
In-Reply-To: <YK8Ho3mC117M8GXS@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--kr/3Sj2ADIR3Iave
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 10:44:51AM +0800, Ming Lei wrote:
> On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
> > Request completion latency can be reduced by using polling instead of
> > irqs. Even Posted Interrupts or similar hardware support doesn't beat
> > polling. The reason is that disabling virtqueue notifications saves
> > critical-path CPU cycles on the host by skipping irq injection and in
> > the guest by skipping the irq handler. So let's add blk_mq_ops->poll()
> > support to virtio_blk.
> >=20
> > The approach taken by this patch differs from the NVMe driver's
> > approach. NVMe dedicates hardware queues to polling and submits
> > REQ_HIPRI requests only on those queues. This patch does not require
> > exclusive polling queues for virtio_blk. Instead, it switches between
> > irqs and polling when one or more REQ_HIPRI requests are in flight on a
> > virtqueue.
> >=20
> > This is possible because toggling virtqueue notifications is cheap even
> > while the virtqueue is running. NVMe cqs can't do this because irqs are
> > only enabled/disabled at queue creation time.
> >=20
> > This toggling approach requires no configuration. There is no need to
> > dedicate queues ahead of time or to teach users and orchestration tools
> > how to set up polling queues.
>=20
> This approach looks good, and very neat thanks per-vq lock.
>=20
> BTW, is there any virt-exit saved by disabling vq interrupt? I understand
> there isn't since virt-exit may only be involved in remote completion
> via sending IPI.

This patch doesn't eliminate vmexits. QEMU already has virtqueue polling
code that disables the vq notification (the virtio-pci hardware register
write that causes a vmexit).

However, when both the guest
driver and the emulated device are polling then there are no vmexits or
interrupt injections with this patch.

> >=20
> > Possible drawbacks of this approach:
> >=20
> > - Hardware virtio_blk implementations may find virtqueue_disable_cb()
> >   expensive since it requires DMA. If such devices become popular then
>=20
> You mean the hardware need to consider order between DMA completion and
> interrupt notify? But it is disabling notify, guest just calls
> virtqueue_get_buf() to see if there is buffer available, if not, it will =
be
> polled again.

Software devices have cheap access to guest RAM for looking at the
virtqueue_disable_cb() state before injecting an irq. Hardware devices
need to perform a DMA transaction to read that state. They have to do
this every time they want to raise an irq because the guest driver may
have changed the value.

I'm not sure if the DMA overhead is acceptable. This problem is not
introduced by this patch, it's a VIRTIO spec design issue.

I was trying to express that dedicated polling queues would avoid the
DMA since the device knows that irqs are never needed for this virtqueue.

>=20
> >   the virtio_blk driver could use a similar approach to NVMe when
> >   VIRTIO_F_ACCESS_PLATFORM is detected in the future.
> >=20
> > - If a blk_poll() thread is descheduled it not only hurts polling
> >   performance but also delays completion of non-REQ_HIPRI requests on
> >   that virtqueue since vq notifications are disabled.
> >=20
> > Performance:
> >=20
> > - Benchmark: fio ioengine=3Dpvsync2 numjobs=3D4 direct=3D1
> > - Guest: 4 vCPUs with one virtio-blk device (4 virtqueues)
>=20
> 4 jobs can consume up all 4 vCPUs. Just run a quick fio test with
> 'ioengine=3Dio_uring --numjobs=3D1' on single vq, and IOPS can be improved
> by ~20%(hipri=3D1 vs hipri=3D0) with the 3 patches, and the virtio-blk is
> still backed on NVMe SSD.

Nice, thank you for sharing the data!

Stefan

--kr/3Sj2ADIR3Iave
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC48UUACgkQnKSrs4Gr
c8jDcgf/SCLpDI/0kZeWjUgSOeCyvc3c097zlWxfUqfprecYQPSpuCQxFSTubjSG
ursFNJ8GRKer5KhjBfLh4Kb/b8cacI8tsya4mr01zBNzKynkb5/bAyVuxAcy8pTs
nZdb9b9CW/KVaR/0+Qb2xueVvu8C01tZM3zbeVvG/XWfnizumhByygPmhKt9DqOn
Z+NzjHAeN3yOBr/75Pn8P3qidJJftZjr2Wsc/X7j7pQEIzfchMbyGw82rmSp5tve
C6JGzkoB/9DCQkSGdNNZ3sd0W+eEbW3jsmCWCfnshZsxkNP4jFmR7wXfCbdqztYO
AGz+6MxiBIgOZtYvYgrulV8LC0WSJg==
=IbZ3
-----END PGP SIGNATURE-----

--kr/3Sj2ADIR3Iave--

