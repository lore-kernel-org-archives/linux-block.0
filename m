Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F6C433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 08:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiC2IrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 04:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiC2IrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 04:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88F2536B48
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648543533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMgkTYZf/g0woPe8B780plgukc+vz+yUuXXC8TqXCcA=;
        b=GeNcty1KmKyy9DowQft5B9ABkVPFPihE5FisH54+sYsbQbjlz3GtWTOtbft8F9Dp7lKT54
        haSEdofARI5NTR4/wJdkGekBIHUHhjuwgT/sH5A5tnCX+mYf8mcbscv9HHAcvoSLhnxGh2
        iradbaEBA7+1XaJOZPPoSRIUd8iYDZo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-4oflrWbVOaKBM0S8CQKSBQ-1; Tue, 29 Mar 2022 04:45:31 -0400
X-MC-Unique: 4oflrWbVOaKBM0S8CQKSBQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7F571C168E4;
        Tue, 29 Mar 2022 08:45:30 +0000 (UTC)
Received: from localhost (unknown [10.39.195.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AE0D46A3AF;
        Tue, 29 Mar 2022 08:45:30 +0000 (UTC)
Date:   Tue, 29 Mar 2022 09:45:29 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <YkLHKXukyZd27ADE@stefanha-x1.localdomain>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-3-suwan.kim027@gmail.com>
 <YkG1HeQ8qu11KFnF@stefanha-x1.localdomain>
 <YkHZSV+USBSRPuTv@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mO5OVVo6Gt3wRhJH"
Content-Disposition: inline
In-Reply-To: <YkHZSV+USBSRPuTv@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--mO5OVVo6Gt3wRhJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2022 at 12:50:33AM +0900, Suwan Kim wrote:
> On Mon, Mar 28, 2022 at 02:16:13PM +0100, Stefan Hajnoczi wrote:
> > On Thu, Mar 24, 2022 at 11:04:50PM +0900, Suwan Kim wrote:
> > > +static void virtio_queue_rqs(struct request **rqlist)
> > > +{
> > > +	struct request *req, *next, *prev =3D NULL;
> > > +	struct request *requeue_list =3D NULL;
> > > +
> > > +	rq_list_for_each_safe(rqlist, req, next) {
> > > +		struct virtio_blk_vq *vq =3D req->mq_hctx->driver_data;
> > > +		unsigned long flags;
> > > +		bool kick;
> > > +
> > > +		if (!virtblk_prep_rq_batch(vq, req)) {
> > > +			rq_list_move(rqlist, &requeue_list, req, prev);
> > > +			req =3D prev;
> > > +
> > > +			if (!req)
> > > +				continue;
> > > +		}
> > > +
> > > +		if (!next || req->mq_hctx !=3D next->mq_hctx) {
> > > +			spin_lock_irqsave(&vq->lock, flags);
> >=20
> > Did you try calling virtblk_add_req() here to avoid acquiring and
> > releasing the lock multiple times? In other words, do virtblk_prep_rq()
> > but wait until we get here to do virtblk_add_req().
> >=20
> > I don't know if it has any measurable effect on performance or maybe the
> > code would become too complex, but I noticed that we're not fully
> > exploiting batching.
>=20
> I tried as you said. I called virtlblk_add_req() and added requests
> of rqlist to virtqueue in this if statement with holding the lock
> only once.
>=20
> I attach the code at the end of this mail.
> Please refer the code.
>=20
> But I didn't see improvement. It showed slightly worse performance
> than the current patch.

Okay, thanks for trying it!

> > > +			kick =3D virtqueue_kick_prepare(vq->vq);
> > > +			spin_unlock_irqrestore(&vq->lock, flags);
> > > +			if (kick)
> > > +				virtqueue_notify(vq->vq);
> > > +
> > > +			req->rq_next =3D NULL;
>=20
> Did you ask this part?
>=20
> > > +			*rqlist =3D next;
> > > +			prev =3D NULL;
> > > +		} else
> > > +			prev =3D req;
> >=20
> > What guarantees that req is still alive after we called
> > virtblk_add_req()? The device may have seen it and completed it already
> > by the time we get here.
>=20
> Isn't request completed after the kick?
>=20
> If you asked about "req->rq_next =3D NULL",
> I think it should be placed before
> "kick =3D virtqueue_kick_prepare(vq->vq);"
>=20
> -----------
> 	req->rq_next =3D NULL;
> 	kick =3D virtqueue_kick_prepare(vq->vq);
> 	spin_unlock_irqrestore(&vq->lock, flags);
> 	if (kick)
> 		virtqueue_notify(vq->vq);
> -----------

No, virtqueue_add_sgs() exposes vring descriptors to the device. The
device may process immediately. In other words, VIRTIO devices may poll
the vring instead of waiting for virtqueue_notify(). There is no
guarantee that the request is alive until virtqueue_notify() is called.

The code has to handle the case where the request is completed during
virtqueue_add_sgs().

Stefan

--mO5OVVo6Gt3wRhJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJCxykACgkQnKSrs4Gr
c8i6RggAyb2FEHMODJp1S34MXObUfuNkzJdnNuX2cn1Eh4CjmvTyHSPK/vSwqBF2
cLcDqG1Mdf8qzvtO2WQdrkvDzhyYZAM0C51cQu7m1UzZ7HMmSVZc6XNdKplKS7uZ
sWkGppbl43ng0Ts31FhSCE7tt5RbfQ1qZqdoCkDLl6oD4xAAP2/tJJy7iXaFdOoT
PYI2OWs3S2u2kCxJdJbHVlxMy4I+SIn9q/ZOzzgz4PI4xAQ316YlL99ciyIqIBaX
toE6eMSrkvyveT/O80M8OwwaVNkZR/EPZGNAWGwz6ZpmMIL33T+mRU3DOdC5ikLy
aqaIom1JtCx+gekwkhhfw4XHhlJPqQ==
=a5gB
-----END PGP SIGNATURE-----

--mO5OVVo6Gt3wRhJH--

