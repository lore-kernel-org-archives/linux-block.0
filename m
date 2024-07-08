Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF721F95E
	for <linux-block@vger.kernel.org>; Mon,  8 Jul 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424718; cv=none; b=K79lRFbqOYxuNK0y0CGxjRUVxl/1BqqAvWx3cdoCrOx17SXxFWl83Un4pz8wiKjj6/yj+EUxq3Ep6Mc7hhl6fJ8A0ip3iEOvkZBVG4UCVTpHaGLFafBo8zR33yrcBgl6nTX/0UkFblFo3aapIhCuICGZP36s6uc4lVHHWaz3tc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424718; c=relaxed/simple;
	bh=CIpq+tHXooEAZzxw0fF4yhNIHvERWGGg1G8htwhDg8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBmyZsYCgtRXGZpJ7eEWdiC9zxR1Yb6mbFTRnoYQ/50Bs8uejJYWrfnsWADxh6VfS8rB4B71gd1/BJYMJewO3UqiNH+op0QYkp5f3+n1GwU0mJ8yCnVwSTnXx9DQf1LG2xUQSoSbleAcncT53f80g3LCNA1Gy3fEQ8JoUaQgwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwm48XPA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwm48XPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720424715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bQ6oO+NBE5KmHBrK1egMaXWpdDDzquNgOi2z2wMWGCY=;
	b=iwm48XPA6e3n/o/QyzvvHhFnYHD+sbcm7MZit+Uj0V691AraU3XkNhwjCVjZv6K48VUpyx
	tPOlPoHS+ILZCAD4fqyT7AJfJxHaX5VGaW/a7/CreKJpt9z7JMl1LOd2eWfVJj8mjIboSz
	PTsaeJmBFEPeOYwuUUq2JxCayA20KJo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-OMIDTzpzN0qtc5a682khwQ-1; Mon,
 08 Jul 2024 03:45:12 -0400
X-MC-Unique: OMIDTzpzN0qtc5a682khwQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A08481954229;
	Mon,  8 Jul 2024 07:45:09 +0000 (UTC)
Received: from localhost (unknown [10.39.192.131])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB4E119560AA;
	Mon,  8 Jul 2024 07:45:07 +0000 (UTC)
Date: Mon, 8 Jul 2024 09:45:06 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	pbonzini@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 4/5] virtio_blk: Don't bother validating blocksize
Message-ID: <20240708074506.GB38033@dynamic-pd01.res.v6.highway.a1.net>
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
 <20240705115127.3417539-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OkGs/uj0FPvoaRGC"
Content-Disposition: inline
In-Reply-To: <20240705115127.3417539-5-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


--OkGs/uj0FPvoaRGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 11:51:26AM +0000, John Garry wrote:
> The block queue limits validation does this for us now.
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/block/virtio_blk.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OkGs/uj0FPvoaRGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaLmQIACgkQnKSrs4Gr
c8hD7wgAmE3KWfwdfsZ1kkFHXdSkQnTns0LGYPW3TJVUFza6nLhXDjMDTnrcOqHv
M7V7FEEXj23V44hk/RTx5HmhyDTSCfbOEFi2gMaOlVcJZzNDcMrEEgEcMOrEapKd
imlRGIuR6WAC4jMsd8nJ/mjI1l/oNOdh7dibQnvCUQLSjv/Orr+pAAnlDrS6Lnkn
o9aI4PUAK+5yLET/h1gTnA4I78m/Im/tGUnZeLKv4tchMpk9LowGaEe8Bp5p7VqI
meQPYlhxU5jI/1atRzE29/ICNkoMrqetnEy3mwvxUDIg074Hk/JNszHBRESHpfsi
OApRPcfaygQyrjQtlVUye2lMvE8iJg==
=5G7c
-----END PGP SIGNATURE-----

--OkGs/uj0FPvoaRGC--

