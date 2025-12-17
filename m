Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A2392FFF
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980325; cv=none; b=gNgSYKnNxYcKigo+adb3VjXSD3TxTDc+IvdHJ90rrt7PAWyEOwyxsCZPZKFxt0kKtODMmOp5lDi0B8EbdvluTHDJQFYQmHiQSKD8I5IgYbHLjuVMXI3fdIoAEBkaWzhvtibXDNVbrqCS79Afb3HhqT5ccWCH5S23oX44+TMEJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980325; c=relaxed/simple;
	bh=1LR2Ujfhe6jFIjkL7kGsca95ukR54NpAhGZRKS/DAY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du7qdBWDSd7znSr+kXIJepUjxk803d3pCa7Fw0hqk/6lgX7urJJ1+lbHR8oJctzqHlOO0mmE9GEAlWf9pNHX+jj1a98i3wUnge52NqtpVLeVZiW/K/uzOjJLovikyoBDEFvYiY+LF+3V8NlLqd7cQisSI6JN2sarAi5qq4XzNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRRElG7w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRRElG7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765980322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IHWBc1PN61J99zIOiaQbTsRXyNeM+VNsVpnaPMecQ4Y=;
	b=iRRElG7wJ0hOUxklNDPXG7uHvmeGIU775DIVSjazIe9WbMnkfWUkCWZ4ojxcygWaP/gI2v
	eoj7fVKA8K8Xa67cGQoW7vYT7kVgH0fPoUaFSSZ4llGuucFZPH/ZUiU4EZAEcfAgwswCZd
	JGmKlvh8lVNsU54YEj89xssAfmUJ4Jo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436--oRjutbQMj2KrwhzoCqjEg-1; Wed,
 17 Dec 2025 09:05:16 -0500
X-MC-Unique: -oRjutbQMj2KrwhzoCqjEg-1
X-Mimecast-MFC-AGG-ID: -oRjutbQMj2KrwhzoCqjEg_1765980315
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A9F31800625;
	Wed, 17 Dec 2025 14:05:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.25])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5793F1800576;
	Wed, 17 Dec 2025 14:05:14 +0000 (UTC)
Date: Wed, 17 Dec 2025 09:05:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, hare@suse.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] block: add allocation size check in
 blkdev_pr_read_keys()
Message-ID: <20251217140513.GA43988@fedora>
References: <20251217014712.35771-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LFeN67QYCM/eG8Zh"
Content-Disposition: inline
In-Reply-To: <20251217014712.35771-1-kartikey406@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


--LFeN67QYCM/eG8Zh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 07:17:12AM +0530, Deepanshu Kartikey wrote:
> blkdev_pr_read_keys() takes num_keys from userspace and uses it to
> calculate the allocation size for keys_info via struct_size(). While
> there is a check for SIZE_MAX (integer overflow), there is no upper
> bound validation on the allocation size itself.
>=20
> A malicious or buggy userspace can pass a large num_keys value that
> doesn't trigger overflow but still results in an excessive allocation
> attempt, causing a warning in the page allocator when the order exceeds
> MAX_PAGE_ORDER.
>=20
> Fix this by introducing PR_KEYS_MAX to limit the number of keys to
> a sane value. This makes the SIZE_MAX check redundant, so remove it.
> Also switch to kvzalloc/kvfree to handle larger allocations gracefully.
>=20
> Fixes: 22a1ffea5f80 ("block: add IOC_PR_READ_KEYS ioctl")
> Tested-by: syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
> Reported-by: syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D660d079d90f8a1baf54d
> Link: https://lore.kernel.org/all/20251212013510.3576091-1-kartikey406@gm=
ail.com/T/ [v1]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v3:
>   - Renamed PR_KEYS_MAX_NUM to PR_KEYS_MAX
>   - Moved define to include/uapi/linux/pr.h
> v2:
>   - Added PR_KEYS_MAX_NUM (64K) limit instead of checking KMALLOC_MAX_SIZE
>   - Removed redundant SIZE_MAX check
>   - Switched to kvzalloc/kvfree
> ---
>  block/ioctl.c           | 9 +++++----
>  include/uapi/linux/pr.h | 2 ++
>  2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LFeN67QYCM/eG8Zh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlCuJkACgkQnKSrs4Gr
c8iYMAf/d2XXjKSTkke+lSDqsahv3Vcdyi/6yRDNUFRnoia/uGiRmxAHMOUNqNJI
Tj6LtqFIYjtxc9fBgOK9YbjCnsvHvq51D7x+xOvHQ9PyBdYTsvT4NQF/WxLawLxV
eOWxJSYINOo/Wr3WPepp++FiixtqkqN5P/LzqrWQXv1eq0Kood2GbHxDEn5Sn7tF
ODl4mvMGnDnXmCahTjSxGj5b3vOv3iWtnDaDb9+EogarjebwipPAEPImEdANXpIr
DjZVMezM+aA3q3kYmkdrXMEHhst+NbWJNZpcNP/yIMaMmz8LWBtbSk9HANu/MHG1
e0QOlXhZpfGW6ziHoApI2L1Y6OjLaQ==
=Hpzm
-----END PGP SIGNATURE-----

--LFeN67QYCM/eG8Zh--

