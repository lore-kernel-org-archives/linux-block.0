Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87740C433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbiC1NSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243071AbiC1NR7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 09:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE3F62714F
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648473377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80jZIITs+99nIoEveepu0l/LxeyCPVpi03G8CUsNTF0=;
        b=YIKvqf2pCHdLw7UyRK/nm6xE9cp77UEsScqVB7syeHIgBcp0f4p0zhk1jpYn+imduqA6z4
        9PO5HJf5RmchuO5VGZD5eCPItcRfrQc/TdV75JbzIQ4T2HB6h0Ac+yY8T+vIfoyjQHDlml
        fYFJV0oQxzD9PiSwGrJSQwSo36ENNHg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-WQeC-oFANLeuMdV0xtN-Yg-1; Mon, 28 Mar 2022 09:16:15 -0400
X-MC-Unique: WQeC-oFANLeuMdV0xtN-Yg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95A011C01E84;
        Mon, 28 Mar 2022 13:16:14 +0000 (UTC)
Received: from localhost (unknown [10.39.193.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 425C7401E4E;
        Mon, 28 Mar 2022 13:16:14 +0000 (UTC)
Date:   Mon, 28 Mar 2022 14:16:13 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <YkG1HeQ8qu11KFnF@stefanha-x1.localdomain>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-3-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aukWC0QEceelRlMd"
Content-Disposition: inline
In-Reply-To: <20220324140450.33148-3-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--aukWC0QEceelRlMd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 24, 2022 at 11:04:50PM +0900, Suwan Kim wrote:
> @@ -367,6 +381,66 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw=
_ctx *hctx,
>  	return BLK_STS_OK;
>  }
> =20
> +static bool virtblk_prep_rq_batch(struct virtio_blk_vq *vq, struct reque=
st *req)
> +{
> +	struct virtio_blk *vblk =3D req->mq_hctx->queue->queuedata;
> +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(req);
> +	unsigned long flags;
> +	int num, err;
> +
> +	req->mq_hctx->tags->rqs[req->tag] =3D req;
> +
> +	if (virtblk_prep_rq(req->mq_hctx, vblk, req, vbr, &num) !=3D BLK_STS_OK)
> +		return false;
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +	err =3D virtblk_add_req(vq->vq, vbr, vbr->sg_table.sgl, num);
> +	if (err) {
> +		spin_unlock_irqrestore(&vq->lock, flags);
> +		virtblk_unmap_data(req, vbr);
> +		virtblk_cleanup_cmd(req);
> +		return false;
> +	}
> +	spin_unlock_irqrestore(&vq->lock, flags);

Simplification:

  spin_lock_irqsave(&vq->lock, flags);
  err =3D virtblk_add_req(vq->vq, vbr, vbr->sg_table.sgl, num);
  spin_unlock_irqrestore(&vq->lock, flags);
  if (err) {
      virtblk_unmap_data(req, vbr);
      virtblk_cleanup_cmd(req);
      return false;
  }

> +
> +	return true;
> +}
> +
> +static void virtio_queue_rqs(struct request **rqlist)
> +{
> +	struct request *req, *next, *prev =3D NULL;
> +	struct request *requeue_list =3D NULL;
> +
> +	rq_list_for_each_safe(rqlist, req, next) {
> +		struct virtio_blk_vq *vq =3D req->mq_hctx->driver_data;
> +		unsigned long flags;
> +		bool kick;
> +
> +		if (!virtblk_prep_rq_batch(vq, req)) {
> +			rq_list_move(rqlist, &requeue_list, req, prev);
> +			req =3D prev;
> +
> +			if (!req)
> +				continue;
> +		}
> +
> +		if (!next || req->mq_hctx !=3D next->mq_hctx) {
> +			spin_lock_irqsave(&vq->lock, flags);

Did you try calling virtblk_add_req() here to avoid acquiring and
releasing the lock multiple times? In other words, do virtblk_prep_rq()
but wait until we get here to do virtblk_add_req().

I don't know if it has any measurable effect on performance or maybe the
code would become too complex, but I noticed that we're not fully
exploiting batching.

> +			kick =3D virtqueue_kick_prepare(vq->vq);
> +			spin_unlock_irqrestore(&vq->lock, flags);
> +			if (kick)
> +				virtqueue_notify(vq->vq);
> +
> +			req->rq_next =3D NULL;
> +			*rqlist =3D next;
> +			prev =3D NULL;
> +		} else
> +			prev =3D req;

What guarantees that req is still alive after we called
virtblk_add_req()? The device may have seen it and completed it already
by the time we get here.

--aukWC0QEceelRlMd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJBtR0ACgkQnKSrs4Gr
c8iSGgf7BNTuMPGJKEJL5YvuaSkP9tkxRu0Ox0PHhKsi+lLc4MBCXoZOlKP1tN0W
8kxLoGTXs973GnjvVeOGSesENUrAmNDp/T0yoGpqR+ViuerbqVHA+vJgQ1/CNqKz
/cNbrskA1tmIe8X0Y6Mbdw15mAgIFlWu9Ngcw40Gkn/n2plb5xqUNfkPB7osOGr1
sHhWE1PybsAFc82p4rzHEWukkRXFPQz7BPjgpKHorScjzSOPlkeVXDB+UHFgp3d1
zGE1aUHq9EN23Lefb8nCOEVE8HVZ5GEX3bdKpDO/tGdzMHXgcIi+sxCjFtb7dalV
jNcujLPscSGe1HDWTbeiwuKuvUbaag==
=sF01
-----END PGP SIGNATURE-----

--aukWC0QEceelRlMd--

