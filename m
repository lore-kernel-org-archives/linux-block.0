Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8063451C1
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782940; cv=none; b=HKAEAxpsZnobmrG93p969/05Dd76VVLOoeZjlFtcpnJ/9AlylnIPQQkLsaJ74/d+X7DUH/a5uJPj/5IYdxWjHF9FK2bAMsGPTMYtV9dycu9RjfnYoEkS6nOOLCajwOXhC/pYpsztKTn7wPC4G+VIsGTW7OvdKVVfecrJT10Dr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782940; c=relaxed/simple;
	bh=yczJ2fxM2hNtxOAcfXJvk9O8lJ/gfghHa0GtTxPLDdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5QQzDBvZyu/PaQOHWDf/jjLCpp+Tqk10I3RrV59jgaNuRLBhx/vaKpdEuGcgeJONDK5hNFRiAiRpF8Ex/kXUXII7wD77j5xA8YtfFXehM71aOxyQjiOiPCQjK0btuzPfKwPZEtrgM1wgKkPo3dwvuedgvAItNet+eqBlpmxqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE2IDlII; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE2IDlII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778782938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hnuOKoO4Rj3y/AAuBjBZlw+kEMkeQbUe3/L+uyAhULI=;
	b=JE2IDlIIr4T56tJf0bHa3hL1sUm8pSwASvCHFvgTg63+0piaqf+AJG0gKibvvVe42b6jnd
	Rqbl4Qejky02nVTzU62hgHFlEUbwxiSn9UHgRyJtWyMjydyDecUE+6EUkNeCKTbiSKb0xI
	dX5JOL/aASB6bGmDoTWOCJjv12Ns8z0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-oV8aE9ZSMF-uzN7zWE90Sw-1; Thu,
 14 May 2026 14:22:16 -0400
X-MC-Unique: oV8aE9ZSMF-uzN7zWE90Sw-1
X-Mimecast-MFC-AGG-ID: oV8aE9ZSMF-uzN7zWE90Sw_1778782935
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1920180075B
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 18:22:14 +0000 (UTC)
Received: from localhost (unknown [10.2.17.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 637551953947;
	Thu, 14 May 2026 18:22:14 +0000 (UTC)
Date: Thu, 14 May 2026 14:22:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: afaria@redhat.com, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH v2] virtio_blk: add fua write support
Message-ID: <20260514182213.GA1526622@fedora>
References: <20250508203313.GA63568@fedora>
 <20260512191808.45334-2-sansshar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RCN8P2X0jE5APs5u"
Content-Disposition: inline
In-Reply-To: <20260512191808.45334-2-sansshar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


--RCN8P2X0jE5APs5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 03:18:09PM -0400, Sana Sharma wrote:
> Continuing the work of Alberto Faria <afaria@redhat.com>
> this patch addresses the remaining feedback regarding removing
> VIRTIO_BLK_F_OUT_FUA from features_legacy[]
>=20
> Link: https://lore.kernel.org/linux-block/20250508001951.421467-1-afaria@=
redhat.com/
> Originally-by: Alberto Faria <afaria@redhat.com>
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> Signed-off-by: Sana Sharma <sansshar@redhat.com>
>=20
>=20
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, Sana!

Please squash your change into Alberto's commit, rebase against the
latest linux.git/master, test against a patched QEMU, and resend the
entire series once the VIRTIO spec change has been merged (the vote is
currently ongoing).

>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 5a6aa3dfb18a..aee2d503d6ef 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1665,7 +1665,7 @@ static unsigned int features_legacy[] =3D {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_OUT_FUA,
> +	VIRTIO_BLK_F_SECURE_ERASE,
>  }
>  ;
>  static unsigned int features[] =3D {
> --=20
> 2.54.0
>=20

--RCN8P2X0jE5APs5u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoGEtUACgkQnKSrs4Gr
c8g7/wf/YDl2SvoYwgkEsBqQ3imf4jODGOkG9akOW3Ln/SHWzJOcLsrVtT17FVid
j4T+N8kBil48AQUi1gci9IjlmU+Srb94FHDjRRF9XzVMyMuPHC96Eu/WZthwa/tc
rhilyd/N6nNUZv2aCSxWU30VIzupsNQC435/E7d+WxQ176XyM2qSlrobeaHXPXDc
ygxT/Bn19Z74DzGbzPrtoax3NfJVt1KrS4rYUVzI9EIjJL4/lks+Fhm1h/aHWnfq
yXuGrazF2+4+hHGpetPXCcDW1pbqNh9NLqRA414SLSIX0C4k6W9Zj3uZw/k/YRGA
7QFZPJH9wlyIdQjWqXd5tG4yzFiZIw==
=Kbk8
-----END PGP SIGNATURE-----

--RCN8P2X0jE5APs5u--

