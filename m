Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AF72D7384
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808491; cv=none; b=nLEQjaXAtaHp+ahJ1qtdiG1nXnSGqmHGGklzW99H5P25ljBjiDXUzAq+RvkugPaSYtGL8AJUFmHA0pdCwMpe6s52gkVI353MdJYttSDoBzuYXMgnxO4dxnjzxr2l2DssNaDr1NaBFAOGgx0KlKw1BcffviWQVuY7HE1oVeaEnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808491; c=relaxed/simple;
	bh=UmuTYLvAzDr+vLpPyflFQIvrDRLfhTj1f41kcMTg+uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdxdPdYpghj30ynvznFWl4gniBQff8HWpN1mTV1ZM5h9AyQBslJxxjVtd8SFDKa2uPASwP3gyH+dYRsNMBYG9pEKFxgN4lQc4m17u5x5gw98r1I5Hg4mboaKnXjTJcehkPrMtbzmQigqZKVQa38hhqM+3M87TrJvGGgdcrbBjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUaXIHr8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUaXIHr8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765808489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uTsoWk0ElRS1vRwYsFSko8VYEIdzyDfF8CwchU0BT68=;
	b=OUaXIHr82ZKDgF3Wjw+E7j5YLhUiMFb+CREJ68KHgQziCtDlGOJL6AKJZcITiQn1afIbCK
	EeXVmu+H8PLFJqYoty34KW0bwGsFncqMUimnT0HCh3oDaHDWLw9sJIWHNJUFAxUpqUM8O1
	L2tONEP55SN9wf3x2p5WXuQuVCWTcQg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-sPTzDunvO4mPg5fFwdHhBw-1; Mon,
 15 Dec 2025 09:21:22 -0500
X-MC-Unique: sPTzDunvO4mPg5fFwdHhBw-1
X-Mimecast-MFC-AGG-ID: sPTzDunvO4mPg5fFwdHhBw_1765808481
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1DD81800630;
	Mon, 15 Dec 2025 14:21:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B7DF19560A7;
	Mon, 15 Dec 2025 14:21:19 +0000 (UTC)
Date: Mon, 15 Dec 2025 09:21:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: add allocation size check in blkdev_pr_read_keys()
Message-ID: <20251215142118.GA19970@fedora>
References: <20251212013510.3576091-1-kartikey406@gmail.com>
 <aTuzVdo8cuxXhUxB@infradead.org>
 <CADhLXY57aFmNB1v4TG2YxhOQL1+_02KkWpB3fEsn8t1GiFqdrg@mail.gmail.com>
 <aT-dxw-VSqXMQR_h@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VmLcsNsR3Gq5DC25"
Content-Disposition: inline
In-Reply-To: <aT-dxw-VSqXMQR_h@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--VmLcsNsR3Gq5DC25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 09:33:59PM -0800, Christoph Hellwig wrote:
> On Fri, Dec 12, 2025 at 08:17:43PM +0530, Deepanshu Kartikey wrote:
> > How about limiting num_keys to 64K (1u << 16)? In practice, PR keys
> > are used for shared storage coordination and typical deployments have
> > only a handful of hosts, so this should be more than enough for any
> > realistic use case.
> >=20
> > With a bounded num_keys, the SIZE_MAX check becomes unnecessary, so
> > I've removed it. Also switched to kvzalloc/kvfree to handle larger
> > allocations gracefully.
> >=20
> > Something like below:
> >=20
> > +/* Limit the number of keys to prevent excessive memory allocation */
> > +#define PR_KEYS_MAX_NUM (1u << 16)
>=20
> Looks reasonable to me.  Stefan?

Yes, that's good. Thanks for looking into this, Deepanshu.

Stefan

--VmLcsNsR3Gq5DC25
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlAGV4ACgkQnKSrs4Gr
c8iTWggAmu+Y8IVZxMRthrNbqr8ICIgiauoeHAslVz/zmBXyBfvGv/DF8+kVIk9G
RspPkgjy8LoSatjiajUFd1bgKKAKxlKAp8AkGOt0HsDmHMVT3uWZB8DedEHAYGlY
SPg9r7zQRZ/bJ0Xf5IU9fy6iQxVbyDi1XeDIQ2NzUxPqqmFnKx0SSVYG8kc9TjA6
bjYlOtVbKMNw4zdND52UiT1mMokObVZoTwLfZyITzTu+jxTNiLUo4ayIruoDAY3J
Ll/LdQUYIlttepYFbM9NnEoaUAMrK1ZphnUoPlKhHZ9ZsZe3TNx2Up28IaBJZ0EU
ELpiXn6/oKju8RhtFTMZPHl8oxUqSA==
=tpP2
-----END PGP SIGNATURE-----

--VmLcsNsR3Gq5DC25--

