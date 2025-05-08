Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61641E4BE
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736491; cv=none; b=Y228CrbevV2NSuQVZ0M778gHUI/t4Nf56B6y3LqruXxH+jsq9hBrT+3sWLAF/u0thIpuwC2jzfS/+bSIY/xxFPppG0FRTBPKwE8BXS3F7geUdlrnc7Am57Ez5kbxCJsIsfkzfPqKk6dEXuCDkFbBjWEh5y8obKZmoy6Xq6Poi+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736491; c=relaxed/simple;
	bh=b14bnvnMSL7EIp+F6vVtj72Wd7mxL4hLAT5cYFXG8/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5/qPW9/yIj80nElyi51f2jtl6NzkM6Lqx7hGiM3BTnA8DruL2o3+PWg2kXKjJisXGktL1L9AMTIC/49ewkQgPuIW8X35ukl3jjtZ/eLaYCpKEloxPIAIsk/ZzCE3Bps99844Aphe8IG3+0l2yPkXz9f/kV3LT4etHIwlZOHKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJ11TlYc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJ11TlYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746736485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/PeUOM0a7VEtjts0jUZZtBmahW0Dt4o+ddVzOKi39E=;
	b=BJ11TlYc9F7XH3M9Q1dQDRt8LgiYztnDSLK/iIvWebPeMdwqhm6B8Nl39vdMFpoqZ0Sr6q
	e/rhbuk1XHVxnr0hzsVOhIX1dckCYrwLOaYisdLnONZhQyrND+hHmGQFWVySraun8pkCWi
	eYW3W7spL+urAuqQFN5/E9x/9Xw481E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-Xv85KHT2OgaE_Mu57yNG9w-1; Thu,
 08 May 2025 16:34:44 -0400
X-MC-Unique: Xv85KHT2OgaE_Mu57yNG9w-1
X-Mimecast-MFC-AGG-ID: Xv85KHT2OgaE_Mu57yNG9w_1746736483
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C238195608E
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 20:34:43 +0000 (UTC)
Received: from localhost (unknown [10.2.16.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C675318003FC;
	Thu,  8 May 2025 20:34:42 +0000 (UTC)
Date: Thu, 8 May 2025 16:34:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [RFC 2/2] vdpa_sim_blk: add support for fua write commands
Message-ID: <20250508203441.GB63568@fedora>
References: <20250508001951.421467-1-afaria@redhat.com>
 <20250508001951.421467-3-afaria@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w32g57vw010zhI4t"
Content-Disposition: inline
In-Reply-To: <20250508001951.421467-3-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


--w32g57vw010zhI4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 01:19:51AM +0100, Alberto Faria wrote:
> Expose VIRTIO_BLK_F_OUT_FUA to drivers. The simulator is a ramdisk, so
> it handles VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_OUT_FUA in the same way.
>=20
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--w32g57vw010zhI4t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgdFWEACgkQnKSrs4Gr
c8jDdggAmlc21JxehZsnxB+KdNsKPgfa+o+WGExSdcuhrxz2GK1bQQYS42iXp1mf
2Fza8RyDRtjeKNrT8RFT8BU65sqP+dgdhTeALmLAXj+K9wATk+Oi8t9KSbjpDUMr
I9JycGLCdVswA3nr96+W6IrT1O9ojkM1WZe5i2KGikE0C2FhTwKDiVlC8wT0H9Ba
woN3bQQSoURvPlGxhQQSda/lsU/VouoezOU7zVwChzZlYx1Osj1VspcVm81neykV
II3x/OHNGkQsvjO0i1N1DW5Edzf0K4J6Y0cQOClgkj2mRm+4vP4LaX89qHYSfJfU
dN9hUfKFX+SYQSPwNWtJwB5m39+M4g==
=AixW
-----END PGP SIGNATURE-----

--w32g57vw010zhI4t--

