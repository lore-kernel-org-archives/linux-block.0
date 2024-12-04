Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA4518FC83
	for <linux-block@vger.kernel.org>; Wed,  4 Dec 2024 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347922; cv=none; b=gxMPt+bZ7JQnFK/RJ9LQ+PkCNH8lEtEGKJb53batnqkkyVHm80JmJmaYElKz3CMx3Okp9SZCF4eOF38zkGnXf4W64UbqqGJZAoo3Sm1Hbu+1RUQDqRfY6L6+x1jrYQOrdvgmq48NUEctpxZ9wSPZ97g9+GnQoagiHBLyz7vG+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347922; c=relaxed/simple;
	bh=CKZ41b7anoIcewRlZGypq0WD1LM26YxEtKSCzP+mD+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHjOyauNHdzW1DVQddTwpjYyFlsIMrfE81DKBrxR2bm+8GeDJc6oob8/5IPEpjz6P6dVP+OkHhnE5dkCNNY2SjrfPnIzg2ncr6eHAS1RU+J0t4RjO668u9JWGCulGlZOcn/EdtF5MtkaBq3jEjyDpJM7Zs7KDAcNEhoiwWNNm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDSwgT0r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDSwgT0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733347919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=txF8K16b654IOGX6oIdHIrFapKIX2rqndCM20eru+gY=;
	b=EDSwgT0rkV27K55cNDNW2hCPwMLMZbQLfL1i+XvmlVStSyDnbudKr4Tv5fbjkY4GFJcVUZ
	7sAOn/X2ckW0IEPfxUMGYEnwf1g7zGXuxvvho1Ltmepa/y7vbJfxLe3+qhFGPLLxHE9UWs
	XStu0Rk8spnh4vTRxwHrSfh5CNLB7Zc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-tikMS4sJO3KpzdJgOBc1Jw-1; Wed,
 04 Dec 2024 16:31:56 -0500
X-MC-Unique: tikMS4sJO3KpzdJgOBc1Jw-1
X-Mimecast-MFC-AGG-ID: tikMS4sJO3KpzdJgOBc1Jw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A0441955D4C;
	Wed,  4 Dec 2024 21:31:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.246])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F160A1956094;
	Wed,  4 Dec 2024 21:31:52 +0000 (UTC)
Date: Wed, 4 Dec 2024 16:31:51 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Sun <yi.sun@unisoc.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] virtio-blk: don't keep queue frozen during system suspend
Message-ID: <20241204213151.GF48585@fedora>
References: <20241112125821.1475793-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wTmESElQuqfsdl3v"
Content-Disposition: inline
In-Reply-To: <20241112125821.1475793-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


--wTmESElQuqfsdl3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 08:58:21PM +0800, Ming Lei wrote:
> Commit 4ce6e2db00de ("virtio-blk: Ensure no requests in virtqueues before
> deleting vqs.") replaces queue quiesce with queue freeze in virtio-blk's
> PM callbacks. And the motivation is to drain inflight IOs before suspendi=
ng.
>=20
> block layer's queue freeze looks very handy, but it is also easy to cause
> deadlock, such as, any attempt to call into bio_queue_enter() may run into
> deadlock if the queue is frozen in current context. There are all kinds
> of ->suspend() called in suspend context, so keeping queue frozen in the
> whole suspend context isn't one good idea. And Marek reported lockdep
> warning[1] caused by virtio-blk's freeze queue in virtblk_freeze().
>=20
> [1] https://lore.kernel.org/linux-block/ca16370e-d646-4eee-b9cc-87277c89c=
43c@samsung.com/
>=20
> Given the motivation is to drain in-flight IOs, it can be done by calling
> freeze & unfreeze, meantime restore to previous behavior by keeping queue
> quiesced during suspend.
>=20
> Cc: Yi Sun <yi.sun@unisoc.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: virtualization@lists.linux.dev
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--wTmESElQuqfsdl3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdQykcACgkQnKSrs4Gr
c8iXYwf+OWXdBcGkOnMhvsirOA7ovep+560L0W8aeugZNMuas47ncyK7fR6Iez7E
A9TjS6w64YSx58/L9aM3Xl84xjuFkLKBhfrJ1lTzHB9MGN7iShw/NNxUfu0DCfxW
f8M81RpqIJxZ0I2lB0U4PBatQHaaF3QJbgwGvUwBJ+FLqrIysIWNmfpCxiMtvymo
mHLiZA53kcQH/vEAGLJpfjGOwj07Ph+9hsZzzvXrDEojSwRSa7Rk+rL3lFOsxI7y
p4ymE8TPNGAG+NPYzCurTABcADEXy2kuVP9mnl40ScGYEdvkgsx11OGFOisvKgtM
cTcuxFuXZLoaYvT0mLzpk1qaRmHK7w==
=PIaA
-----END PGP SIGNATURE-----

--wTmESElQuqfsdl3v--

