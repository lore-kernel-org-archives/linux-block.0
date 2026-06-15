Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7B3FD978
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535185; cv=none; b=IPm6+Ojp1uSPP98tNtZMSsxebYYiLaQXWVx8QlsqPOQG72sme4TfwHrHuz8jRxX/He313rCO3Luvrb7iMEaKvIZlSCV2dzerAiWMOOwJPkTkEjta8KCNQKaAV9AXZjBYepn76/ZScDMfmlkNpTmT+KfGjX12QvYzNnUKVoPewdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535185; c=relaxed/simple;
	bh=FufpY6m8LYjL6hzb1N0QB92mo8HHNnJndS3rAEcI+nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcSwAvJI71B+dVNgbqAv0VrzXLuWFr+j/QVPcXW9swcfYqW0VcUHQu3dpGw5cUwIYttSKn+BG64sLd9KvHBlqOtEbT5ElY+F+TXjuw5VVirO38h8bmUz4pSa6fVtm+RIRFxPNibGDPiiSMLm1toTj7vt8ESDR07v6IsOQxMHNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U65493Wg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U65493Wg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781535183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D2U/rVXVdMp49YF1Mi2vsTuL7+1i+LvINM+38VWReC0=;
	b=U65493Wg5+fKfh+xnTryJhAqSUDVnFWQQVcJALxO2SuSGcWXjmIsqGVlm6mWhgu9QFFPPa
	IN8ZG6q18uheo6jk8GPtfei9STHgdy/hy5SUAWgCypHt1humdi3JI5ki2bhOiMpELfu6Ip
	XDnzjmvKM4BBZw1lG+ehZ+EXUhVSkPk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-2MkfMIgzO42hbt2o6bB03g-1; Mon,
 15 Jun 2026 10:52:59 -0400
X-MC-Unique: 2MkfMIgzO42hbt2o6bB03g-1
X-Mimecast-MFC-AGG-ID: 2MkfMIgzO42hbt2o6bB03g_1781535177
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74F8F1800581;
	Mon, 15 Jun 2026 14:52:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DBA719541B2;
	Mon, 15 Jun 2026 14:52:54 +0000 (UTC)
Date: Mon, 15 Jun 2026 10:52:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, pbonzini@redhat.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v1 0/2] virtio: PCI ERS permanent failure teardown for
 virtio-blk
Message-ID: <20260615145253.GA448916@fedora>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rDjPuhbpsEQh05PT"
Content-Disposition: inline
In-Reply-To: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


--rDjPuhbpsEQh05PT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 10:00:00AM +0800, Xixin Liu wrote:
> Hi,
>=20
> This series adds proper PCI AER error recovery handling for virtio-pci and
> completes virtio-blk teardown when ERS reports pci_channel_io_perm_failur=
e.

CCing Parav because he previously looked at surprise removal:
https://lore.kernel.org/virtualization/20250822091706.21170-1-parav@nvidia.=
com/

>=20
> virtio-pci only registered reset_prepare/reset_done.  The recovery core
> treats devices without error_detected as NO_AER_DRIVER and does not
> deliver perm_failure to the driver after a failed recovery.  When bus
> reset fails (reproduced on QEMU with DLLLA not set within 100 ms after
> secondary bus reset), virtio-blk disks stay live even though virtqueues
> may already have been torn down during the frozen phase.
>=20
> Patch 1 registers error_detected (frozen quiesce + perm_failure notify).
> Patch 2 calls the virtio driver shutdown hook from virtio-pci on
> perm_failure, implements virtio-blk shutdown with blk_mark_disk_dead(),
> and fail-fast guards in virtio_queue_rq.
>=20
> Thanks,
> Xixin Liu
>=20
> ---
>=20
> Xixin Liu (2):
>   virtio-pci: add error_detected for PCI AER recovery
>   virtio-blk: mark disk dead on ERS permanent failure
>=20
>  drivers/block/virtio_blk.c         | 39 +++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_pci_common.c | 47 ++++++++++++++++++++++++++++++++=
++
>  2 files changed, 85 insertions(+)
>=20
> --=20
> 2.43.0
>=20

--rDjPuhbpsEQh05PT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmowEcUACgkQnKSrs4Gr
c8i72AgApJ/ZOOsKjhY+6etWszyoXg4UHVtUMfpo9KefImYgFeCUbW4oryCmQwPU
jYsDMDkgj6aZVYgeIEoMUMJaUQRO0ZhPska/ce2nttNr+/uMEtSmCqPVDV0Yk1Wl
qOmtu2NAR/5kRRdA795tGCfmRm0FyFnZqR+ZuRnuJqzMvgS4uB087kEUqwd7X1KE
kWtf+tbt9UwshgXtaT/yJGH3oH8s5l9PVWJGpzOXJN30xBvS4I7zGtnFG0jGba5c
H695VZfVJlFYyMERJRkJxnaesIYG9vuOESzacM8GHwm9dosyYfbNWhX4RHy3nBPP
QGsCvLuNxwzdrUXH1L/IeCYTx/f9Fg==
=zDKi
-----END PGP SIGNATURE-----

--rDjPuhbpsEQh05PT--

