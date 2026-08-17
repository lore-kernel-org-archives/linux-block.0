Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F344C653
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987693; cv=none; b=R8I4uUnwnzfJI1BF16qA1MzXmpvJdXSBXNE/Iwmbvdez11KhYW8YM5YqUfOQ2z8DzR/JdbRbiFlOHMRFgTRgHGkttHoAhc8HvDSMAYajrPsFF+wwPSngeMSWsm6BFdu+aIN/9/kkWF96BeYN1oczD37jz9pSAVejxAdyx6geD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987693; c=relaxed/simple;
	bh=OdeU3ce18ZetF4Dgh53a7lETscVexz/Bp58q007VBo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSMELIUV/9HQOYOmEE5Cp/BEBeJ5nI5hcddf+I9eVCF8uLr467DUmwTZTJKSCi/FtWAZ8Yqy6ewhw86S5Y7l4NunNIzyxCRbGjU6qftxDsL6gt7TLFPpCXCtMSbhm1WchE7LhT1Hs/uRm/r/+UecxPR1SA+s9yD7wX6HigqoiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Duiq23IO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Duiq23IO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786987690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D8q81bopirThmGxLw3FO0NJQz6gjYWsr65dJqT6SQKE=;
	b=Duiq23IOWrJncg/tKO8kCU7yuqkeq0GPCKkzV6/zwO871W015QQnM4hwqxN9QJMta89zfl
	dF74WarlVMNysQICwTNwloenlvR/MLWDL/bA2obBhkRyjKwd9y8PdHq/xmGOJgL1j/ktKk
	VY/ko8T9QL/AYJVLe9skPRIDO3elTyQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-knqcmVYSM0Sf3nlAk-6RGw-1; Mon,
 17 Aug 2026 13:28:07 -0400
X-MC-Unique: knqcmVYSM0Sf3nlAk-6RGw-1
X-Mimecast-MFC-AGG-ID: knqcmVYSM0Sf3nlAk-6RGw_1786987685
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFCF81800637;
	Mon, 17 Aug 2026 17:28:04 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6190A180034C;
	Mon, 17 Aug 2026 17:28:03 +0000 (UTC)
Date: Mon, 17 Aug 2026 13:28:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sergii Ushakov <sergiiushakov@google.com>
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: clamp max_segments when indirect
 descriptors are disabled
Message-ID: <20260817172802.GD143460@fedora>
References: <20260814105954.4060627-1-sergiiushakov@google.com>
 <20260817134202.160669-1-sergiiushakov@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EtHHhRnyb/gUXRoi"
Content-Disposition: inline
In-Reply-To: <20260817134202.160669-1-sergiiushakov@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

--EtHHhRnyb/gUXRoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 03:42:02PM +0200, Sergii Ushakov wrote:
> When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
> scatter-gather segment in a request must consume a physical slot in
> the virtqueue ring.
>=20
> If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
> virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
> defaults max_segments to BLK_MAX_SEGMENTS (1024). When a multi-page
> compound bio arrives from the page cache, virtqueue_add_split() rejects
> the request with -ENOSPC and triggers:
>=20
>   WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
>   WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
>=20
> This permanently wedges the blk-mq queue and blocks all subsequent disk
> I/O in uninterruptible sleep (D state).
>=20
> Automatically clamp sg_elems to (ring_size - 2) when indirect
> descriptors are disabled.
>=20
> Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>
> ---
> v1 -> v2:
> - Drop max_segments module parameter and rely solely on automatic clamping
>   when indirect descriptors are disabled (suggested by Christoph Hellwig).
> - Guard (ring_size - 2) calculation with ring_size > 2 to prevent underfl=
ow.
> - Update commit description accordingly.
>=20
>  drivers/block/virtio_blk.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EtHHhRnyb/gUXRoi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqDRKIACgkQnKSrs4Gr
c8j88gf/Sw0C0gWMfRiNdoiWekEA9OgWGflcucM8bR9ada3wuc3yiLwvsQtyft06
p6OOINs4QC/eGZimiVd6paoj0qOcaJOjx4xjyz44uHbpwlAVJhBtwDU/r3Ti7Y5/
pUAY+LQ+jUcVJshQizkXJbXGrO9T/vOoUwJRWLSiK4s2vApbaj1Ub7kHfcNPyg0E
u0Z+ZtmVd9hoGpC37LV7Aur6P8NHXailJ7r7wj+wlr8OH5WgmY0QqkM1hlohQjna
RW62m7FQLgLZcbPXoHC3Musrnya0fZTKQOxpnLKePNMBp1IMoqICTfVwSoWlHedz
VbZU+RZSlWJvDS6haBKLDXCzCMd5lg==
=iyx9
-----END PGP SIGNATURE-----

--EtHHhRnyb/gUXRoi--

