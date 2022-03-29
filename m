Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3031C433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 15:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiC2PDi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbiC2PDh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 11:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B61F18C0D0
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648566113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pIutobmb1Oh0Fq+keGUHgYMqeEREu5ZEoVnmeF2bJ6c=;
        b=UypohMZ2b7nhY8Gem9dtsLhUuVKHf6KKUPgWhhZtKMEMxr0UPqwbW48ew+pjWe6LHgRk/o
        jBhkgh53Mmfq79yQAi7jvqa1BdZQlaBD2NQEw/twlHa3cRIO4uRW5ETLcs+Te79KHrraYD
        1lGmdtKa/yW8e62/pu+WoIS9XGFifA8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-Uv5hux6DOWSeT1cCcZSszw-1; Tue, 29 Mar 2022 11:01:48 -0400
X-MC-Unique: Uv5hux6DOWSeT1cCcZSszw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1681638009F7;
        Tue, 29 Mar 2022 15:01:48 +0000 (UTC)
Received: from localhost (unknown [10.39.195.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1D901400C2B;
        Tue, 29 Mar 2022 15:01:47 +0000 (UTC)
Date:   Tue, 29 Mar 2022 16:01:46 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <YkMfWoA8gjH7fdGU@stefanha-x1.localdomain>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-3-suwan.kim027@gmail.com>
 <YkG1HeQ8qu11KFnF@stefanha-x1.localdomain>
 <YkHZSV+USBSRPuTv@localhost.localdomain>
 <YkLHKXukyZd27ADE@stefanha-x1.localdomain>
 <YkMOIBhpODZNLhnZ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YOjScdvHCkt30mxs"
Content-Disposition: inline
In-Reply-To: <YkMOIBhpODZNLhnZ@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--YOjScdvHCkt30mxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2022 at 10:48:16PM +0900, Suwan Kim wrote:
> On Tue, Mar 29, 2022 at 09:45:29AM +0100, Stefan Hajnoczi wrote:
> > On Tue, Mar 29, 2022 at 12:50:33AM +0900, Suwan Kim wrote:
> > > On Mon, Mar 28, 2022 at 02:16:13PM +0100, Stefan Hajnoczi wrote:
> > > > On Thu, Mar 24, 2022 at 11:04:50PM +0900, Suwan Kim wrote:
> > > > > +static void virtio_queue_rqs(struct request **rqlist)
> > > > > +{
> > > > > +	struct request *req, *next, *prev =3D NULL;
> > > > > +	struct request *requeue_list =3D NULL;
> > > > > +
> > > > > +	rq_list_for_each_safe(rqlist, req, next) {
> > > > > +		struct virtio_blk_vq *vq =3D req->mq_hctx->driver_data;
> > > > > +		unsigned long flags;
> > > > > +		bool kick;
> > > > > +
> > > > > +		if (!virtblk_prep_rq_batch(vq, req)) {
> > > > > +			rq_list_move(rqlist, &requeue_list, req, prev);
> > > > > +			req =3D prev;
> > > > > +
> > > > > +			if (!req)
> > > > > +				continue;
> > > > > +		}
> > > > > +
> > > > > +		if (!next || req->mq_hctx !=3D next->mq_hctx) {
> > > > > +			spin_lock_irqsave(&vq->lock, flags);
> > > >=20
> > > > Did you try calling virtblk_add_req() here to avoid acquiring and
> > > > releasing the lock multiple times? In other words, do virtblk_prep_=
rq()
> > > > but wait until we get here to do virtblk_add_req().
> > > >=20
> > > > I don't know if it has any measurable effect on performance or mayb=
e the
> > > > code would become too complex, but I noticed that we're not fully
> > > > exploiting batching.
> > >=20
> > > I tried as you said. I called virtlblk_add_req() and added requests
> > > of rqlist to virtqueue in this if statement with holding the lock
> > > only once.
> > >=20
> > > I attach the code at the end of this mail.
> > > Please refer the code.
> > >=20
> > > But I didn't see improvement. It showed slightly worse performance
> > > than the current patch.
> >=20
> > Okay, thanks for trying it!
> >=20
> > > > > +			kick =3D virtqueue_kick_prepare(vq->vq);
> > > > > +			spin_unlock_irqrestore(&vq->lock, flags);
> > > > > +			if (kick)
> > > > > +				virtqueue_notify(vq->vq);
> > > > > +
> > > > > +			req->rq_next =3D NULL;
> > >=20
> > > Did you ask this part?
> > >=20
> > > > > +			*rqlist =3D next;
> > > > > +			prev =3D NULL;
> > > > > +		} else
> > > > > +			prev =3D req;
> > > >=20
> > > > What guarantees that req is still alive after we called
> > > > virtblk_add_req()? The device may have seen it and completed it alr=
eady
> > > > by the time we get here.
> > >=20
> > > Isn't request completed after the kick?
> > >=20
> > > If you asked about "req->rq_next =3D NULL",
> > > I think it should be placed before
> > > "kick =3D virtqueue_kick_prepare(vq->vq);"
> > >=20
> > > -----------
> > > 	req->rq_next =3D NULL;
> > > 	kick =3D virtqueue_kick_prepare(vq->vq);
> > > 	spin_unlock_irqrestore(&vq->lock, flags);
> > > 	if (kick)
> > > 		virtqueue_notify(vq->vq);
> > > -----------
> >=20
> > No, virtqueue_add_sgs() exposes vring descriptors to the device. The
> > device may process immediately. In other words, VIRTIO devices may poll
> > the vring instead of waiting for virtqueue_notify(). There is no
> > guarantee that the request is alive until virtqueue_notify() is called.
> >=20
> > The code has to handle the case where the request is completed during
> > virtqueue_add_sgs().
>=20
> Thanks for the explanation.
>=20
> We should not use req again after virtblk_add_req().
> I understand...
>=20
> Then, as you commented in previous mail, is it ok that we do
> virtblk_add_req() in "if (!next || req->mq_hctx !=3D next->mq_hctx)"
> statement to avoid use req again after virtblk_add_req() as below code?
>=20
> In this code, It adds reqs to virtqueue in batch just before
> virtqueue_notify(), and it doesn't use req again after calling
> virtblk_add_req().
>=20
> If it is fine, I will try it again.
> This code is slightly different from the code I sent in previous mail.
>=20
> ---
> static void virtio_queue_rqs(struct request **rqlist)
> ...
> 	rq_list_for_each_safe(rqlist, req, next) {
> ...
> 		if (!next || req->mq_hctx !=3D next->mq_hctx) {
> 			// Cut the list at current req
> 			req->rq_next =3D NULL;
> 			// Add req list to virtqueue in batch with holding lock once
> 			kick =3D virtblk_add_req_batch(vq, rqlist, &requeue_list);
> 			if (kick)
> 				virtqueue_notify(vq->vq);
>=20
> 			// setup new req list. Don't use previous req again.
> 			*rqlist =3D next;
> 			prev =3D NULL;
> ...

Yes, that sounds good.

(I noticed struct request has a reference count so that might be a way
to keep requests alive, if necessary, but I haven't investigated. See
req_ref_put_and_test() though it's not used by block drivers and maybe
virtio-blk shouldn't mess with it either.)

Stefan

--YOjScdvHCkt30mxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJDH1oACgkQnKSrs4Gr
c8gyCQgAhlDOyy6quMeV4IoKyAdS2M33Fc18Lj4PgLMmY806ojzb7THZSH29585O
v62IJ2HRFzgCJokQgNshQNiSBE2gcUX6f2rQt5hQZxDNTY/aeUyLcUknJzSeQIPM
kNO9GBqLy6Roch+J4bENNISJ/ejOQIbFx7qxLB0wAwzEmTUJURHCyh0g8GYoyser
cOcDPUEfo4CkVXaSlhD1K7E2+vfkW1EdcAb+nh8+4k/l1UtwDhqwfJTY2PDO6820
6OYOwY9ZfGyfKe9s1FxP0xpRpaIwlBC/KjFUE/loeaRkU9yrc+vPhAKij2wrzQ9G
TvlXzaeSZCnfhSIc9RioKeagE4LcRQ==
=zWYp
-----END PGP SIGNATURE-----

--YOjScdvHCkt30mxs--

