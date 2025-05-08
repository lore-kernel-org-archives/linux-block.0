Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA51E4BE
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736399; cv=none; b=PQMaaH6s6w8rTT9GBnX7x34BrYp4HS2+E9SfxOg9zeknVv8GZdJrZV/u4CotzEdtql/t0+x2tVQ2eWv5dZtDNmzi6OW4a/Vg4Flfaa2OWWZnFyE7pv5vKzQp2l7/9Z4WPhWqS+vyXfLekAXFpeMzfEnXbe0sFm8lfuvTdrAc390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736399; c=relaxed/simple;
	bh=2pxxVg6ucofHn2X624h2XN7Ow3CzaH9J+r52My7e+3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb9/Kr+BJqQewflenq8i0e9yGWPDnfZA44te/R9PdurdQ8tOODQDFY6+PzaO16fkRIFiN9NyRKQ0xq3v6PUfS5Ky+7TiwlL9Kc5Gpyzjx7SRzHBrGqvleh+OF2Tm88hedLkMhBJiWFsts2Mza+dPEsJZHYDrsgQIRzYxtBnoZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSmoWUL2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSmoWUL2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746736397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPjo1DnO8ulenSWBmnvj2r4RZVHNByjFyUW3rTAU7Tc=;
	b=VSmoWUL2Ere6/TyQRpjiVbKAH1p0JsWUQg+3jP5P7B/56K7n+3gWXOAceWmnfHYuL0bDmL
	iAw8XouSr7PafAvY/Q6KjHyT/ciUiTLU5GLFLouNaV/RIhyXGuNRlnsSe2vocbYP0QGHhl
	Wlu189f3WlzuMMjhQGEFbHqZUOP22ko=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-OXxvorqZPDqmqU4gSmQ10Q-1; Thu,
 08 May 2025 16:33:15 -0400
X-MC-Unique: OXxvorqZPDqmqU4gSmQ10Q-1
X-Mimecast-MFC-AGG-ID: OXxvorqZPDqmqU4gSmQ10Q_1746736394
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8483C1956078
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 20:33:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 230071953B85;
	Thu,  8 May 2025 20:33:13 +0000 (UTC)
Date: Thu, 8 May 2025 16:33:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [RFC 1/2] virtio_blk: add fua write support
Message-ID: <20250508203313.GA63568@fedora>
References: <20250508001951.421467-1-afaria@redhat.com>
 <20250508001951.421467-2-afaria@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W/nof75SiCfAtC1k"
Content-Disposition: inline
In-Reply-To: <20250508001951.421467-2-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


--W/nof75SiCfAtC1k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 01:19:50AM +0100, Alberto Faria wrote:
> Add the proposed VIRTIO_BLK_{F,T}_OUT_FUA uapi definitions and
> corresponding virtio-blk support.
>=20
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  drivers/block/virtio_blk.c      | 10 +++++++---
>  include/uapi/linux/virtio_blk.h |  4 ++++
>  2 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 7cffea01d868c..021f05c469c50 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -256,7 +256,8 @@ static blk_status_t virtblk_setup_cmd(struct virtio_d=
evice *vdev,
>  		sector =3D blk_rq_pos(req);
>  		break;
>  	case REQ_OP_WRITE:
> -		type =3D VIRTIO_BLK_T_OUT;
> +		type =3D req->cmd_flags & REQ_FUA ?
> +			VIRTIO_BLK_T_OUT_FUA : VIRTIO_BLK_T_OUT;
>  		sector =3D blk_rq_pos(req);
>  		break;
>  	case REQ_OP_FLUSH:
> @@ -1500,6 +1501,9 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	if (virtblk_get_cache_mode(vdev))
>  		lim.features |=3D BLK_FEAT_WRITE_CACHE;
> =20
> +	if (virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_OUT_FUA))
> +		lim.features |=3D BLK_FEAT_FUA;
> +
>  	vblk->disk =3D blk_mq_alloc_disk(&vblk->tag_set, &lim, vblk);
>  	if (IS_ERR(vblk->disk)) {
>  		err =3D PTR_ERR(vblk->disk);
> @@ -1650,7 +1654,7 @@ static unsigned int features_legacy[] =3D {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_OUT_FUA,

This is a new feature. Legacy VIRTIO devices don't support it.
VIRTIO_BLK_F_ZONED was not added to features_legacy[] when it was
introduced either.

>  }
>  ;
>  static unsigned int features[] =3D {
> @@ -1658,7 +1662,7 @@ static unsigned int features[] =3D {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED, VIRTIO_BLK_F_OUT_FUA,
>  };
> =20
>  static struct virtio_driver virtio_blk =3D {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_=
blk.h
> index 3744e4da1b2a7..52be7943f6b8d 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -42,6 +42,7 @@
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
>  #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
>  #define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
> +#define VIRTIO_BLK_F_OUT_FUA		18	/* FUA write is supported */
> =20
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> @@ -206,6 +207,9 @@ struct virtio_blk_config {
>  /* Reset All zones command */
>  #define VIRTIO_BLK_T_ZONE_RESET_ALL 26
> =20
> +/* FUA write command */
> +#define VIRTIO_BLK_T_OUT_FUA        27
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  /* Barrier before this op. */
>  #define VIRTIO_BLK_T_BARRIER	0x80000000
> --=20
> 2.49.0
>=20

--W/nof75SiCfAtC1k
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgdFQgACgkQnKSrs4Gr
c8jOKgf+JpY8Q3Zfe8vGbjf0hNMFhEavqjKl7TblOQJpWiI9LlpqVWpB+efW4lnr
m/WdXM+DJz5OUuSTUnEz66ayY7OPQeY5FuhcPuu7tCRvIBZu6wA72AWdEiyGUskS
z3e1JXJnsUPpFo7+BCBy2ueKvaBbHiAZGKNA/c1MHNLDb9eOif1vKj2IpYsJ8KJa
uVUHYbfkPOW6ZVoiPAuP14b3XMWdqZFR8YbayURw+eUOBy3V78q1qDWYa4qBuJ9G
gLfC1QUkceiNVclUNf7bydqqTcK3dGIST8x2RoM5GaTorq+/v6WJrReVfVZjKcxT
ibOpnq71Lbu8QmLa7jCcikgoKVymgQ==
=XSju
-----END PGP SIGNATURE-----

--W/nof75SiCfAtC1k--

