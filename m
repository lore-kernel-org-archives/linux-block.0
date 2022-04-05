Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14748C433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 07:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiDEH2o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiDEH2l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 03:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C9AB3969F
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649143600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DtRKacOwwOeXGaBsH2DzeX8idyChR5dRn3lTIEka55E=;
        b=AbWhSaod2NFOP7Fir1HQwzbXdm34CBgT8BLiPesheD9dQh3SETY/r77HVrYe90zbdQ3zJm
        zBKAhZxFStT/Wb3Nui014Ua7h/HTO6Dm92ggKo28AmUFkWt+RBpdMrc6eq+f47dLmOSzPe
        xL+BH79/mEpd28F0FmSLsjM1EvgzMqY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-qtmh9eRYPSGpAzNM5esJfg-1; Tue, 05 Apr 2022 03:26:36 -0400
X-MC-Unique: qtmh9eRYPSGpAzNM5esJfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A17D7185A794;
        Tue,  5 Apr 2022 07:26:35 +0000 (UTC)
Received: from localhost (unknown [10.39.193.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 383D440E84E0;
        Tue,  5 Apr 2022 07:26:35 +0000 (UTC)
Date:   Tue, 5 Apr 2022 08:26:34 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 1/2] virtio-blk: support polling I/O
Message-ID: <YkvvKr9nCfza5KRa@stefanha-x1.localdomain>
References: <20220405053122.77626-1-suwan.kim027@gmail.com>
 <20220405053122.77626-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Jp8XQicBu+MZNkcI"
Content-Disposition: inline
In-Reply-To: <20220405053122.77626-2-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Jp8XQicBu+MZNkcI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 05, 2022 at 02:31:21PM +0900, Suwan Kim wrote:
> +static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch=
 *iob)
> +{
> +	struct virtio_blk *vblk =3D hctx->queue->queuedata;
> +	struct virtio_blk_vq *vq =3D hctx->driver_data;
> +	struct virtblk_req *vbr;
> +	bool req_done =3D false;
> +	unsigned long flags;
> +	unsigned int len;
> +	int found =3D 0;
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +
> +	while ((vbr =3D virtqueue_get_buf(vq->vq, &len)) !=3D NULL) {
> +		struct request *req =3D blk_mq_rq_from_pdu(vbr);
> =20
> -	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
> -					vblk->vdev, 0);
> +		found++;
> +		if (!blk_mq_add_to_batch(req, iob, vbr->status,
> +						virtblk_complete_batch))
> +			blk_mq_complete_request(req);
> +		req_done =3D true;
> +	}
> +
> +	if (req_done)

Minor nit: req_done can be replaced with found > 0.

> +		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> +
> +	spin_unlock_irqrestore(&vq->lock, flags);
> +
> +	return found;
> +}

--Jp8XQicBu+MZNkcI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJL7yoACgkQnKSrs4Gr
c8jUsgf2JdI3U+9wOFUIjYhSgc6aLyfvp5Z/e/qlArMH91NRMqQYPdhVExmmJTsw
RTcidyru8K34V0PxslJOl1hqOQrO3GsIZ3x2H2uq00lc8rySclyLgWsToUst3Pew
Lc7DML09u6E/OaGBGhN7HY30kJlpE0oCdjDvmn7OdfA6i/fsFj8Ca8QlZARDuOGG
zcTvw97nbRJimZ76xnd9ApOrdjyk1s6d3RtbXfoehpL11UM7HDEWm45C5wAy6W0n
Dy3zYnG3j0BVhU+2Z48rZ+vUxZ6m7NhystgCiMYd4TqD0Z5kssY8jp7T1mpjSPre
hyns9kyCB1Aqx5fekBeHVDwfLh+T
=2Ve7
-----END PGP SIGNATURE-----

--Jp8XQicBu+MZNkcI--

