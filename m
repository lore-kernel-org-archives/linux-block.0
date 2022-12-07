Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF94C63708
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 14:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLHOnp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 09:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiLHOnn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 09:43:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B791DFEA
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 06:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670510562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dC06rHD9795Mcwyf2BZrlXOuy21bGOSa5sAkC9Cuad8=;
        b=GZgk68YEluHKHfDlp+ThCw2YVCncIymLg7+Mtaizbygg2rv8BEqa9bSXekPhRYml4BCqfX
        5zGAcuK212yCF/QqAuMXawoG9GGeN8HJTbS9zixQpauUKsEjGG0srb9VbVpVdfUeVsBTi2
        kMUD0E/tdEEGfIpg1aRX40a82T+s7Hs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-fUuTU7TkNaqp4ocsryWSkQ-1; Thu, 08 Dec 2022 09:42:38 -0500
X-MC-Unique: fUuTU7TkNaqp4ocsryWSkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D132D3832781;
        Thu,  8 Dec 2022 14:42:37 +0000 (UTC)
Received: from localhost (unknown [10.39.194.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 504842166B26;
        Thu,  8 Dec 2022 14:42:37 +0000 (UTC)
Date:   Wed, 7 Dec 2022 17:05:06 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        hch@infradead.org, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio-blk: support completion batching for the IRQ
 path
Message-ID: <Y5EOEh2HYHqo+Sbh@fedora>
References: <20221206141125.93055-1-suwan.kim027@gmail.com>
 <20221206141125.93055-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hn7qBZnoP/ukmpt3"
Content-Disposition: inline
In-Reply-To: <20221206141125.93055-2-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--hn7qBZnoP/ukmpt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2022 at 11:11:25PM +0900, Suwan Kim wrote:
> This patch adds completion batching to the IRQ path. It reuses batch
> completion code of virtblk_poll(). It collects requests to io_comp_batch
> and processes them all at once. It can boost up the performance by 2%.
>=20
> To validate the performance improvement and stabilty, I did fio test with
> 4 vCPU VM and 12 vCPU VM respectively. Both VMs have 8GB ram and the same
> number of HW queues as vCPU.
> The fio cammad is as follows and I ran the fio 5 times and got IOPS avera=
ge.
> (io_uring, randread, direct=3D1, bs=3D512, iodepth=3D64 numjobs=3D2,4)
>=20
> Test result shows about 2% improvement.
>=20
>            4 vcpu VM       |   numjobs=3D2   |   numjobs=3D4
>       -----------------------------------------------------------
>         fio without patch  |  367.2K IOPS  |   397.6K IOPS
>       -----------------------------------------------------------
>         fio with patch     |  372.8K IOPS  |   407.7K IOPS
>=20
>            12 vcpu VM      |   numjobs=3D2   |   numjobs=3D4
>       -----------------------------------------------------------
>         fio without patch  |  363.6K IOPS  |   374.8K IOPS
>       -----------------------------------------------------------
>         fio with patch     |  373.8K IOPS  |   385.3K IOPS
>=20
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)

Cool, thanks for doing this!

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index cf64d256787e..48fcf745f007 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -272,6 +272,18 @@ static inline void virtblk_request_done(struct reque=
st *req)
>  	blk_mq_end_request(req, virtblk_result(vbr));
>  }
> =20
> +static void virtblk_complete_batch(struct io_comp_batch *iob)
> +{
> +	struct request *req;
> +
> +	rq_list_for_each(&iob->req_list, req) {
> +		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
> +		virtblk_cleanup_cmd(req);
> +		blk_mq_set_request_complete(req);
> +	}
> +	blk_mq_end_request_batch(iob);
> +}
> +
>  static void virtblk_done(struct virtqueue *vq)
>  {
>  	struct virtio_blk *vblk =3D vq->vdev->priv;
> @@ -280,6 +292,7 @@ static void virtblk_done(struct virtqueue *vq)
>  	struct virtblk_req *vbr;
>  	unsigned long flags;
>  	unsigned int len;
> +	DEFINE_IO_COMP_BATCH(iob);
> =20
>  	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
>  	do {
> @@ -287,7 +300,9 @@ static void virtblk_done(struct virtqueue *vq)
>  		while ((vbr =3D virtqueue_get_buf(vblk->vqs[qid].vq, &len)) !=3D NULL)=
 {
>  			struct request *req =3D blk_mq_rq_from_pdu(vbr);
> =20
> -			if (likely(!blk_should_fake_timeout(req->q)))
> +			if (likely(!blk_should_fake_timeout(req->q)) &&
> +				!blk_mq_add_to_batch(req, &iob, vbr->status,
> +							virtblk_complete_batch))
>  				blk_mq_complete_request(req);
>  			req_done =3D true;
>  		}
> @@ -295,9 +310,14 @@ static void virtblk_done(struct virtqueue *vq)
>  			break;
>  	} while (!virtqueue_enable_cb(vq));
> =20
> -	/* In case queue is stopped waiting for more buffers. */
> -	if (req_done)
> +	if (req_done) {
> +		if (!rq_list_empty(iob.req_list))
> +			virtblk_complete_batch(&iob);

A little optimization to avoid the indirect call: iob.complete(&iob) :).
Not sure if it's good style to do that but it works in this case because
we know it can only be virtblk_complete_batch().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hn7qBZnoP/ukmpt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmORDhIACgkQnKSrs4Gr
c8iy+ggAhIXNBcnfGowRN+/CxGfb7+omNJp6krM78eBlHR0VuOX++5xjK5gKV+Mn
p64DisOw1+U2GXz0YZee34jkFg6TH53Rj7cDvrDnbX92+DbrsSAmShmJLYr5vjNV
MDL0UyQjRq88MHA+zy5os5UJwWbuLR9roKNYgGHan5IdQ95mJQe5Uzp3899JtfKW
U7ZutEPl5sQFZCTE6XsfFOunqrsJ5Tq0RzRxU9rQCAjkqeDe409pwThYtyfkzCzy
C9BEMaFrnqYLlem4+e1qfpnHNmajy7PT3jAPZispvTcWUxm4fwGDrOl6Cbi31Wwh
kxtfd2gvYMcD+sbl/whExj2nSrb7qA==
=8GGk
-----END PGP SIGNATURE-----

--hn7qBZnoP/ukmpt3--

