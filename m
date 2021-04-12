Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D13C4361B
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24D361243
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbhDLJS4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238263AbhDLJSC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618219063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rrspDyIR9SlZX9ZhWloHNFgAesVzZ+RgGXpC9yh6HuI=;
        b=MAFBcWVdfL7lTfxx0jFAihdyrwoCVK5seWVfqovsYu6Li+HhkArZd1Qe79XQ+4dVMkiLfy
        cFK7xELt/krVAFewxdLX29Y1F1rNl6MiRRxqRmFYlLhya1lTiHkITpiZIAS5eR2q0ojWtQ
        wGU5udPxJQdbSVthgGhvHV9/cNMAYJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-8QHHYLvFNsm9QXGrFy_x3Q-1; Mon, 12 Apr 2021 05:17:41 -0400
X-MC-Unique: 8QHHYLvFNsm9QXGrFy_x3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7266B801F98;
        Mon, 12 Apr 2021 09:17:40 +0000 (UTC)
Received: from localhost (ovpn-115-66.ams2.redhat.com [10.36.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40FCA6BC2E;
        Mon, 12 Apr 2021 09:17:35 +0000 (UTC)
Date:   Mon, 12 Apr 2021 10:17:35 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Enrico Granata <egranata@google.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        axboe@kernel.dk, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: Add support for lifetime feature
Message-ID: <YHQQL1OTOdnuOYUW@stefanha-x1.localdomain>
References: <20210330231602.1223216-1-egranata@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ODDWfFadttf77aj1"
Content-Disposition: inline
In-Reply-To: <20210330231602.1223216-1-egranata@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--ODDWfFadttf77aj1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 11:16:02PM +0000, Enrico Granata wrote:
> The VirtIO TC has adopted a new feature in virtio-blk enabling
> discovery of lifetime information.
>=20
> This commit adds support for the VIRTIO_BLK_T_LIFETIME command
> to the virtio_blk driver, and adds two new attributes to the
> sysfs entry for virtio_blk:
> * pre_eol_info
> * life_time
>=20
> which are defined in the same manner as the files of the same name
> for the eMMC driver, in line with the VirtIO specification.
>=20
> Signed-off-by: Enrico Granata <egranata@google.com>
> ---
>  drivers/block/virtio_blk.c      | 76 ++++++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_blk.h | 11 +++++
>  2 files changed, 86 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b9fa3ef5b57c..1fc0ec000b4f 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -246,7 +246,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_=
ctx *hctx,
>  		unmap =3D !(req->cmd_flags & REQ_NOUNMAP);
>  		break;
>  	case REQ_OP_DRV_IN:
> -		type =3D VIRTIO_BLK_T_GET_ID;
> +		type =3D vbr->out_hdr.type;

This patch changes the endianness of vbr->out_hdr.type from
virtio-endian to cpu endian before virtio_queue_rq. That is error-prone
because someone skimming through the code will see some accesses with
cpu_to_virtio32() and others without it. They would have to audit the
code carefully to understand what is going on.

The following is cleaner:

  case REQ_OP_DRV_IN:
      break; /* type already set for custom requests */
  ...
  if (req_op(req) !=3D REQ_OP_DRV_IN)
      vbr->out_hdr.type =3D cpu_to_virtio32(vblk->vdev, type);

Now vbr->out_hdr.type is virtio-endian everywhere. If we need to support
REQ_OP_DRV_OUT in the future it can use the same approach.

virtblk_get_id() and virtblk_get_lifetime() would be updated like this:

  vbreq->out_hdr.type =3D cpu_to_virtio32(VIRTIO_BLK_T_GET_*);

>  		break;
>  	default:
>  		WARN_ON_ONCE(1);
> @@ -310,11 +310,14 @@ static int virtblk_get_id(struct gendisk *disk, cha=
r *id_str)
>  	struct virtio_blk *vblk =3D disk->private_data;
>  	struct request_queue *q =3D vblk->disk->queue;
>  	struct request *req;
> +	struct virtblk_req *vbreq;

It's called vbr elsewhere in the driver. It would be nice to keep naming
consistent.

>  	int err;
> =20
>  	req =3D blk_get_request(q, REQ_OP_DRV_IN, 0);
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
> +	vbreq =3D blk_mq_rq_to_pdu(req);
> +	vbreq->out_hdr.type =3D VIRTIO_BLK_T_GET_ID;
> =20
>  	err =3D blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL=
);
>  	if (err)
> @@ -327,6 +330,34 @@ static int virtblk_get_id(struct gendisk *disk, char=
 *id_str)
>  	return err;
>  }
> =20
> +static int virtblk_get_lifetime(struct gendisk *disk, struct virtio_blk_=
lifetime *lifetime)
> +{
> +	struct virtio_blk *vblk =3D disk->private_data;
> +	struct request_queue *q =3D vblk->disk->queue;
> +	struct request *req;
> +	struct virtblk_req *vbreq;
> +	int err;
> +
> +	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
> +		return -EOPNOTSUPP;
> +
> +	req =3D blk_get_request(q, REQ_OP_DRV_IN, 0);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> +	vbreq =3D blk_mq_rq_to_pdu(req);
> +	vbreq->out_hdr.type =3D VIRTIO_BLK_T_GET_LIFETIME;
> +
> +	err =3D blk_rq_map_kern(q, req, lifetime, sizeof(*lifetime), GFP_KERNEL=
);
> +	if (err)
> +		goto out;
> +
> +	blk_execute_rq(vblk->disk, req, false);
> +	err =3D blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
> +out:
> +	blk_put_request(req);
> +	return err;
> +}
> +
>  static void virtblk_get(struct virtio_blk *vblk)
>  {
>  	refcount_inc(&vblk->refs);
> @@ -435,6 +466,46 @@ static ssize_t serial_show(struct device *dev,
> =20
>  static DEVICE_ATTR_RO(serial);
> =20
> +static ssize_t pre_eol_info_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct gendisk *disk =3D dev_to_disk(dev);
> +	struct virtio_blk_lifetime lft;
> +	int err;
> +
> +	/* sysfs gives us a PAGE_SIZE buffer */
> +	BUILD_BUG_ON(sizeof(lft) >=3D PAGE_SIZE);

Why is this necessary? In serial_show() it protects against a buffer
overflow. That's not the case here since sprintf() is used to write to
buf and the size of lft doesn't really matter.

--ODDWfFadttf77aj1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmB0EC0ACgkQnKSrs4Gr
c8glpwf7B5HPKz4lOmk9WcUcbbG+AtgIXqFv3X115vuKd+RJXNjmKjyB4Y2X4JuG
ZerW9cbiK5Cs4VcTvmKRw8L74XGynTSHJzumvLPNfFq8/GpJSLJntR1D9MngAwpp
TWAlN0f/Waz9jQ2cI+sGPcTK/uM22CJDbywJpBkKHnTKZKbBwp/ouxhRb7nmj2Oo
FfhoWdt665W+ZeKaSTMBigUSizMnscFtMa12nb2mNFXf7fyATETubpwLJAFWAVHH
bYMSlHDQ2cOl4mfrESqsVQroFY2u6/ReEddt4ez5UIA4gUtrcvOJpSI0rAUpuqZZ
x7y54k9wHMp13OSg+LYJ1iC6UEjz+Q==
=IM9I
-----END PGP SIGNATURE-----

--ODDWfFadttf77aj1--

