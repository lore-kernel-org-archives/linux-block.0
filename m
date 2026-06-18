Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B03FBEC1
	for <linux-block@vger.kernel.org>; Thu, 18 Jun 2026 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795912; cv=none; b=fABr7efuomZnW88T5E9yMFVzSgc1WYitNtcpwLqntb3dAVPN1HLqtVftCrBksaBn+HXQT0atSMRdREWHM4E6OQ2fMA9Akkad5Ttd8sR8B9coM3YsXDAAKE0cJvBUc/XGPtqlC/vaaNO9HMJKCT/pvyB67VejX84JcUMOEH+JNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795912; c=relaxed/simple;
	bh=T6e3Dtj8es1yv+34gkq8YtTTLgmLZiAloALgWSMx/CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH25ngaBDdH5e6i/44/HDOY+2P2ry+coj5oD/bw23VoVNAOYI6eXLwXtrPPQRn98i2b+Wi0SIydxLDNyhe4fRZ+hqDHDMt4L5CELLCdFIgJ6k56xgw2GIuex3F0aEbfmQObtnknaM90jdJUAn+2pNeouQLesEhAl7uU1F5Uq9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCG8Xs3L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCG8Xs3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781795910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DP4ziwGQLOjJKH5/Lc1liZFeK+aChFv9NBQLRhK1qTQ=;
	b=fCG8Xs3L5aJ9B9B+7P/ItjchXWDXycg/XZC2G93P09LCl2Xtjmuwn2DK78tYSm9kHctWgV
	76umev0Rsd+LrBcpCY2oRNGIvxuq2U+iMVAgzf+vbQHBPxOWi+pXzZCFofaSsxp6MEInid
	h3t1lTinlVB3lzSRnyW7stXTHjUeiHg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-0T0zfxnHM2OUHfqyUe5Y5g-1; Thu,
 18 Jun 2026 11:18:23 -0400
X-MC-Unique: 0T0zfxnHM2OUHfqyUe5Y5g-1
X-Mimecast-MFC-AGG-ID: 0T0zfxnHM2OUHfqyUe5Y5g_1781795902
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4BC81956044;
	Thu, 18 Jun 2026 15:18:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B80A51688;
	Thu, 18 Jun 2026 15:18:20 +0000 (UTC)
Date: Thu, 18 Jun 2026 11:18:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Dmitry Fomichev <dmitry.fomichev@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: use little-endian types for the zoned fields
Message-ID: <20260618151819.GE720244@fedora>
References: <20260617151727.4071754-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xi9JoAb3EvV3+jv4"
Content-Disposition: inline
In-Reply-To: <20260617151727.4071754-1-michael.bommarito@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95


--Xi9JoAb3EvV3+jv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 11:17:27AM -0400, Michael Bommarito wrote:
> The zoned block-device fields in the virtio-blk header are typed
> __virtio{32,64}, so their endianness follows VIRTIO_F_VERSION_1. The
> zoned feature is only defined for VIRTIO 1.x devices, and the virtio
> specification defines all of its fields as little-endian. Commit
> b16a1756c716 ("virtio_blk: mark all zone fields LE") tagged them
> __le* for exactly this reason, but commit f1ba4e674feb ("virtio-blk:
> fix to match virtio spec") re-applied the reviewed version of the
> original zoned series -- which predated b16a1756 -- and silently
> restored the __virtio* typing together with the matching
> virtio*_to_cpu() / virtio_cread() accessors in the driver.
>=20
> Restore the little-endian typing for the zoned configuration-space
> characteristics, the zone descriptor, the zone report header and the
> ZONE_APPEND in-header sector, and read them with le*_to_cpu() and
> virtio_cread_le() to match.
>=20
> There is no functional change on any spec-compliant device: zoned
> requires VIRTIO_F_VERSION_1, and for a VERSION_1 device
> virtio*_to_cpu() is identical to le*_to_cpu(). The change makes the
> uapi types describe the actual wire format and removes a latent
> endianness mismatch for a (non-conformant) legacy device on a
> big-endian guest.
>=20
> Fixes: f1ba4e674feb ("virtio-blk: fix to match virtio spec")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Testing:
>  - Builds with no new warnings; sparse endian-clean (C=3D2,
>    __CHECK_ENDIAN__, CONFIG_BLK_DEV_ZONED=3Dy) both before and after.
>  - Booted under QEMU with a host-managed zoned device exposed through
>    virtio-blk. Zone revalidation, blkzone report and a sequential
>    write / write-pointer check return correct values; blktests zbd
>    device tests 001-006 (sysfs+ioctl, report zone, reset, write split,
>    write ordering, revalidate) pass, with results identical before and
>    after this change -- expected, since on a VIRTIO_F_VERSION_1 device
>    virtio*_to_cpu() =3D=3D le*_to_cpu().
>=20
>  drivers/block/virtio_blk.c      | 38 +++++++++++++++------------------
>  include/uapi/linux/virtio_blk.h | 18 ++++++++--------
>  2 files changed, 26 insertions(+), 30 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Xi9JoAb3EvV3+jv4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo0DDsACgkQnKSrs4Gr
c8j/EAgAr80DBNieX3WvHS/s0zrKr1w9FdI4/FlZ7/xFGPdBq6LZTj9qqrjNRjf1
gKM1ZrZLpZ1W/4zVcF9/m1k6/79Cmc4zIr0rqyPPwp+vtznahCY6+zKfmO09c1ON
TxEzZTWVYLP8GZDUl/SPqU0Ee1u3gvX8UNGQszU9+tiZLUpARt72+kShEGWaXl1/
MO4J0/85z+dR4vAco/H91DMCYcZr4HZXaBIHKUxmSgbFFKQtg8mKcVCFRa2HW/w7
WEJ2dS1Pw6A4Pr3kraEEmEBTGkFWKN2ENSpx1GH2nOA/cBhYWxCOQe+y4nQ/vL6+
heoVRRlh9RIAGp2JBIhadWiNKs/w4g==
=x/xX
-----END PGP SIGNATURE-----

--Xi9JoAb3EvV3+jv4--

