Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895C47ECFC
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105060; cv=none; b=V2PY/0WVfm6yLKg9oZ9+VQsS76AXi2bE9ltAzKi2tlI7ggxQstptJLmDBg7RQTMp/7vAL/6N80s4e5m+F6W+gFHUeLJ7nzxQSXsHEzE1kGc9afFwAfgUM3Bkfy6HK9SJeI3UWc6h5Ztubp11T7DD37u3RrfuYFIfE3F+MACNNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105060; c=relaxed/simple;
	bh=uUna96neAYdrwlMS63X3C+CTf4BDX3r65PLkw4quS9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qswbtzc4PQon9Nem/OX1XIZnuDLMP4w5b78KRNUgPJLUFNxDizkRtEewy9tdOUEzXBwVyL7UbO1eEkvrUSupMXCPf+d8G3Srgv6X6Ylkg+r/gqGOSCJW9WZzwgIghuwew8oscjV3WzExd4jvsEar0+uOL1pbp9c1si6Qm785gDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQjNhQYz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQjNhQYz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790105058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwfa5smc2ZZIQpnxxfe+O7vU/pYeae0uutTFsADnlEc=;
	b=KQjNhQYzoPRP5ONi2q/w11v1hkz94EySfh3zwc7BCAFHPAlnv03I5jseyNSIal2Ffzv0nH
	N+TilCAe8fiQJdzhVdBOLDGsIVLdfnHJCEQikUkRiqtypYB3/zTAEoiJSGv+lHE+iRrqMj
	gOWNZ/dWbyOw30OViS5ZlRji641k2w8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-j6T_4-WnO96OoQsyyPO0qQ-1; Tue,
 22 Sep 2026 15:24:14 -0400
X-MC-Unique: j6T_4-WnO96OoQsyyPO0qQ-1
X-Mimecast-MFC-AGG-ID: j6T_4-WnO96OoQsyyPO0qQ_1790105053
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 415561954B2A;
	Tue, 22 Sep 2026 19:24:12 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D7813000223;
	Tue, 22 Sep 2026 19:24:11 +0000 (UTC)
Date: Tue, 22 Sep 2026 15:24:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Dmitry Fomichev <dmitry.fomichev@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: set the zone write granularity
Message-ID: <20260922192410.GG340123@fedora>
References: <20260918140641.2031075-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xiVVAVPPob9tau7m"
Content-Disposition: inline
In-Reply-To: <20260918140641.2031075-2-cassel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

--xiVVAVPPob9tau7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 04:06:42PM +0200, Niklas Cassel wrote:
> virtblk_read_zoned_limits() reads the write granularity that the device
> reports in virtio_blk_zoned_characteristics and assigns it to the
> physical block size and to io_min, but never to the limit that is named
> after it. queue_limits.zone_write_granularity is left at zero, so
> blk_validate_zoned_limits() raises it to the logical block size:
>=20
> 	if (lim->zone_write_granularity < lim->logical_block_size)
> 		lim->zone_write_granularity =3D lim->logical_block_size;
>=20
> A device that reports a granularity coarser than its logical block size,
> which is what the field exists to express, therefore has it silently
> reduced. A 512e host managed disk passed through to a guest reports a
> logical block size of 512 and a write granularity of 4096, and the guest
> ends up with a zone write granularity of 512.
>=20
> bio_split_alignment() returns lim->zone_write_granularity if it is non-ze=
ro
> and bio_split_io_at() may split a bio with as per bio_split_alignment().
> This can real to the write getting rejected by the host drive, as the wri=
te
> is not aligned to the physical block size.
>=20
> zonefs also takes its block size from bdev_zone_write_granularity(), so it
> would incorrectly use 512 on a disk that requires 4096.
>=20
> sd_zbc_read_zones() sets the limit from the physical block size for the
> same reason. NVMe ZNS and null_blk leave it unset, but the fallback
> gives the right answer for them, as their write granularity is the
> logical block size. virtio carries a separate value that may exceed it.
>=20
> Set the zone write granularity from the value that the device reports.
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/block/virtio_blk.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xiVVAVPPob9tau7m
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqy1doACgkQnKSrs4Gr
c8j+qwf/ZW3Nq9ZOZPKrLxH/wfFMoYzzyFc4yNmu5aM1t5mB6dNLD9VL1HTeifIT
UK8mX0RsoLl4gAgSjgD2hBLKw10qUoVY1nHqNDeWLCkdoMlnwxHiWBJ9D9lwUJ49
RrV9T/DEQewfpnAusXzDDpsrCniXdE7Gwn+2n12Fkz3pR69zZMAEECYHol0Qr1IR
lVBaSh/1jeJo3/KmuHTt2yNs4xGAlyoYiwfQSrrrO+GkjJTTEwu45sQdtOpTL3b0
OEXTRCnkBMAhScw+jHNxPYlYXn6CstZzqK1DgyPgPInJp/V/M0CoQa6a9vASlYVl
rnVh8YeLMaT42w/nKypeNkrMZGk0bA==
=EZ15
-----END PGP SIGNATURE-----

--xiVVAVPPob9tau7m--

