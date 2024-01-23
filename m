Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F05F856
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019389; cv=none; b=ThFpDTh5oUGkz8RDCj2pk0fyEn41TiwI7b4XvHiWfFjYLKLFlGqvOL/qfHAq+GH0wab+UR4qAa9IqWTVkpBJu0REsAKtui0DnWVQlUCQ5PcxjUUPHGG1sB1ihqoAzeKdTLw0qVN0Px/Y5QCP4btZ8eMhkZpB20dxOnY4JZMPo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019389; c=relaxed/simple;
	bh=Fj62Bwi3DGd1EjyWqxR9D2cFSWSB7HzQaM5pnO92gqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiCpOGWPfWyEc661KbXEMNEyepjBHGBMoHvO5KEI/Mb9MrjkAG88TBkAeA5vR+tZ2wOfVFefViNywn8U52WcGjjAocgge6aXwlnufIVb1+USNApsCNUDzHGtMflK/lEk+KcdFVz8GR/m0C0Td1yL0XttmwEpjXExedEFzJk/+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYZsNeXJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYZsNeXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706019386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=75cy3zssEp2rPaNsGHCEEFCL2n3UbPgvrY96j6PBPS4=;
	b=CYZsNeXJkOkIwmyTSBZ2TrGP1XCnvvXbGSyZd8xjqpVrvOuWXElDMa2eyz+67eHH2os15A
	2WbNZzbv9w6mu0VLcbFCc1FuQuRDCtHh3PrEjLsmJKULL6Vp0nf9U3EJDqdnetf69ubezF
	dNQkuNygqB8XrrlPez6KpV8vZhgkLWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-IzDKtTLvPmqw7T0dUBtMOw-1; Tue, 23 Jan 2024 09:16:20 -0500
X-MC-Unique: IzDKtTLvPmqw7T0dUBtMOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ED2A10B726A;
	Tue, 23 Jan 2024 14:16:19 +0000 (UTC)
Received: from localhost (unknown [10.39.195.153])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 576D51C060B1;
	Tue, 23 Jan 2024 14:16:18 +0000 (UTC)
Date: Tue, 23 Jan 2024 09:16:16 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 11/15] virtio_blk: split virtblk_probe
Message-ID: <20240123141616.GB484337@fedora>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oB8a124sWRz1YLzS"
Content-Disposition: inline
In-Reply-To: <20240122173645.1686078-12-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


--oB8a124sWRz1YLzS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 06:36:41PM +0100, Christoph Hellwig wrote:
> Split out a virtblk_read_limits helper that just reads the various
> queue limits to separate it from the higher level probing logic.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 193 +++++++++++++++++++------------------
>  1 file changed, 101 insertions(+), 92 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oB8a124sWRz1YLzS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWvyjAACgkQnKSrs4Gr
c8ja0AgAq5E2zDmIm2JQLzkb1yOzqxsO4TvGEPTyDTa7GkumGdesCYk8VI2uzCz/
ek4tut3Sb1TPcr2R6zZBKLSpUMRxmURQC/Y66xLy/LTxy6HmGrcamEEQd5iMDbj0
nEv2cdvekh5L96K9+DRSceuZS0Kw7dXcL4tE2hKE6hov+OAXS3Kxqambvftg6IoF
Ksifm7JxGBuKx1s9CsTDUE3QF5oXL5jT969r1k/2l/jf3yS0QSH7sIbK1h4+MHSV
id47U0I3yANjqYGRpKXW23blqx64x1WIJB1vVs4jrtJdvJnPzb6Iy8XprQZJ5rWK
JHPKPsGnz/m7RTZaq2zfX+NygtBATg==
=4cBN
-----END PGP SIGNATURE-----

--oB8a124sWRz1YLzS--

