Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E3C47084
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C66613F7
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhEYJBC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 05:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231184AbhEYJBC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 05:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621933172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XXenCqETpb2RlyNBZ4FMXd5sgQb4F7cjovB7dQEodrE=;
        b=B3k31oRhcdypv9cx2+erPI31VAL9q0MZssGU4xwg9uoM+7iaEPSIZzO4BA7U3LMpJHHygs
        3VCnbw9x4YuS8BOC04+10RQ5qWjwoVCAuxLypuwjU+YtPjZVzHkj8cbmjwFAY/Yysr+uH/
        as+cHzRAS3JMfxD8kpSEu/vouZ0sdQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-nd6P3C9rNq-ygIYqC8kzXQ-1; Tue, 25 May 2021 04:59:28 -0400
X-MC-Unique: nd6P3C9rNq-ygIYqC8kzXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41F061009446;
        Tue, 25 May 2021 08:59:27 +0000 (UTC)
Received: from localhost (ovpn-115-80.ams2.redhat.com [10.36.115.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCD8910023AC;
        Tue, 25 May 2021 08:59:19 +0000 (UTC)
Date:   Tue, 25 May 2021 09:59:18 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <YKy8Znh/MqHWSmON@stefanha-x1.localdomain>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
 <eefac014-0361-b554-ffdc-2ce920810fa5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GGAVikb14LUB3vAD"
Content-Disposition: inline
In-Reply-To: <eefac014-0361-b554-ffdc-2ce920810fa5@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--GGAVikb14LUB3vAD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 11:21:41AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/5/20 =E4=B8=8B=E5=8D=8810:13, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
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
> >=20
> > Possible drawbacks of this approach:
> >=20
> > - Hardware virtio_blk implementations may find virtqueue_disable_cb()
> >    expensive since it requires DMA.
>=20
>=20
> Note that it's probably not related to the behavior of the driver but the
> design of the event suppression mechanism.
>=20
> Device can choose to ignore the suppression flag and keep sending
> interrupts.

Yes, it's the design of the event suppression mechanism.

If we use dedicated polling virtqueues then the hardware doesn't need to
check whether interrupts are enabled for each notification. However,
there's no mechanism to tell the device that virtqueue interrupts are
permanently disabled. This means that as of today, even dedicated
virtqueues cannot suppress interrupts without the device checking for
each notification.

> >   If such devices become popular then
> >    the virtio_blk driver could use a similar approach to NVMe when
> >    VIRTIO_F_ACCESS_PLATFORM is detected in the future.
> >=20
> > - If a blk_poll() thread is descheduled it not only hurts polling
> >    performance but also delays completion of non-REQ_HIPRI requests on
> >    that virtqueue since vq notifications are disabled.
>=20
>=20
> Can we poll only when only high pri requests are pending?

Yes, that's what this patch does.

> If the backend is a remote one, I think the polling may cause more cpu
> cycles.

Right, but polling is only done when userspace sets the RWF_HIPRI
request flag. Most applications don't support it and for those that do
it's probably an option that the user needs to enable explicitly.

Stefan

> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index fc0fb1dcd399..f0243dcd745a 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -29,6 +29,16 @@ static struct workqueue_struct *virtblk_wq;
> >   struct virtio_blk_vq {
> >   	struct virtqueue *vq;
> >   	spinlock_t lock;
> > +
> > +	/* Number of non-REQ_HIPRI requests in flight. Protected by lock. */
> > +	unsigned int num_lopri;
> > +
> > +	/* Number of REQ_HIPRI requests in flight. Protected by lock. */
> > +	unsigned int num_hipri;
> > +
> > +	/* Are vq notifications enabled? Protected by lock. */
> > +	bool cb_enabled;
>=20
>=20
> We had event_flag_shadow, is it sufficient to introduce a new helper
> virtqueue_cb_is_enabled()?

Yes, I'll try that in the next revision.

> > +
> >   	char name[VQ_NAME_LEN];
> >   } ____cacheline_aligned_in_smp;
> > @@ -171,33 +181,67 @@ static inline void virtblk_request_done(struct re=
quest *req)
> >   	blk_mq_end_request(req, virtblk_result(vbr));
> >   }
> > -static void virtblk_done(struct virtqueue *vq)
> > +/* Returns true if one or more requests completed */
> > +static bool virtblk_complete_requests(struct virtqueue *vq)
> >   {
> >   	struct virtio_blk *vblk =3D vq->vdev->priv;
> >   	struct virtio_blk_vq *vbq =3D &vblk->vqs[vq->index];
> >   	bool req_done =3D false;
> > +	bool last_hipri_done =3D false;
> >   	struct virtblk_req *vbr;
> >   	unsigned long flags;
> >   	unsigned int len;
> >   	spin_lock_irqsave(&vbq->lock, flags);
> > +
> >   	do {
> > -		virtqueue_disable_cb(vq);
> > +		if (vbq->cb_enabled)
> > +			virtqueue_disable_cb(vq);
> >   		while ((vbr =3D virtqueue_get_buf(vq, &len)) !=3D NULL) {
> >   			struct request *req =3D blk_mq_rq_from_pdu(vbr);
> > +			if (req->cmd_flags & REQ_HIPRI) {
> > +				if (--vbq->num_hipri =3D=3D 0)
> > +					last_hipri_done =3D true;
> > +			} else
> > +				vbq->num_lopri--;
> > +
> >   			if (likely(!blk_should_fake_timeout(req->q)))
> >   				blk_mq_complete_request(req);
> >   			req_done =3D true;
> >   		}
> >   		if (unlikely(virtqueue_is_broken(vq)))
> >   			break;
> > -	} while (!virtqueue_enable_cb(vq));
> > +
> > +		/* Enable vq notifications if non-polled requests remain */
> > +		if (last_hipri_done && vbq->num_lopri > 0) {
> > +			last_hipri_done =3D false;
> > +			vbq->cb_enabled =3D true;
> > +		}
> > +	} while (vbq->cb_enabled && !virtqueue_enable_cb(vq));
> >   	/* In case queue is stopped waiting for more buffers. */
> >   	if (req_done)
> >   		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> >   	spin_unlock_irqrestore(&vbq->lock, flags);
> > +
> > +	return req_done;
> > +}
> > +
> > +static int virtblk_poll(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	struct virtio_blk *vblk =3D hctx->queue->queuedata;
> > +	struct virtqueue *vq =3D vblk->vqs[hctx->queue_num].vq;
> > +
> > +	if (!virtqueue_more_used(vq))
>=20
>=20
> I'm not familiar with block polling but what happens if a buffer is made
> available after virtqueue_more_used() returns false here?

Can you explain the scenario, I'm not sure I understand? "buffer is made=20
available" -> are you thinking about additional requests being submitted
by the driver or an in-flight request being marked used by the device?

Stefan

--GGAVikb14LUB3vAD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCsvGYACgkQnKSrs4Gr
c8gvIwf/dkaMys4a6Kfqzdx7Pvmvw2BGcTZFfqK5FbgvYv8M+3aGZnU2qzdXrFPt
RKHGmU2FpekVV/t4NySPajwBsglNuNYuO+9TYjl6hkKR9SM3Z+p4mr+8xoQ8QPsg
uW2VVWpOssrHp5/gar9+Bs8yrDYlmx27CNHJU/Qv9V3C+Ff6zdpeoiyP3N68Cf+K
VlPpsdkA0MYJQyYuvq3tf2J7d+Y+qMWeJ+VJJ8bRp+DcMULp3HDcfzytZxvX3r4a
ekWSM5XSvxAjqi7fWDCREy+snm0ys0svKPEABYKn+Iyz/h+cYhdF2FaksBOw/wRv
kGgurxPcrMtSfsTEIhyqvvoTqQjJnA==
=Wmed
-----END PGP SIGNATURE-----

--GGAVikb14LUB3vAD--

