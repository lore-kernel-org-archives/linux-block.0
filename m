Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA23370E5;
	Wed, 19 Nov 2025 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543444; cv=none; b=p2btn8S8q+gqfot8mDinmzbx3IvdTMY2MgCadV3+mMnKsVFt4EpQ6axVL6AwNMLwdKfIdw20/wlwGQrMVENU6V8gAhpYsW9PmMF1CM1aQgLRxLYoUkh8wf1PlXo4//h2Z1buNxlRkq8Xfy0beOPwn2HAnEvuAcpfY7N5Qv1sKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543444; c=relaxed/simple;
	bh=k8vxIaZNB28GwV9FFyLlRrwVE3g7CS9xIpLJM8MUS/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0Yfa3+P48Xl5zm4i0NQjYk2pRc0DrDX8viHq/cbFIe+9XL1xg/90HKdH/l3+IzgKi6x4lhl2Wza1P+MiYNg2l1Xgpb0rh084QcGtXgLGNjdED0rJKODuKWjYTxTqPdEwhWloPD53UjJGxzU5TE2nmYMCEgK73XLBcFwdYBGTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=RJRBSeAN; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="RJRBSeAN"
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0EDD71C01B5; Wed, 19 Nov 2025 10:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1763543438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aKoPdmFx5HfPn5TOgKRfoxKrS5WsoaWj58t/0pgywKo=;
	b=RJRBSeANYOBxvnqyHlD+I2v3IXaMwzRsxHvxBDiIjOvVpL1DzXXNzrkwtJ+Q8P4NOyNTyK
	n/XF3RNw+GNi85nHnzcSCQ4w1iD0HcWkVtaVFqB6B0c3aPBjTfKDEToY5eRn2690EjOa0S
	XxkmAA9DvUKolt0+Vi1UBNxKPsTd0/o=
Date: Wed, 19 Nov 2025 10:10:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Richard W.M. Jones" <rjones@redhat.com>, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, linux-mm@kvack.org
Cc: Eric Dumazet <edumazet@google.com>, Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
	Mike Christie <mchristi@redhat.com>,
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: Userland used in writeback path was Re: [PATCH] nbd: restrict
 sockets to TCP and UDP
Message-ID: <aR2JjR1yKHCCPalO@duo.ucw.cz>
References: <20250909132243.1327024-1-edumazet@google.com>
 <aRyzUc/WndKJBAz0@duo.ucw.cz>
 <20251118181623.GK1427@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aQHk9D/h+j/L8Oa2"
Content-Disposition: inline
In-Reply-To: <20251118181623.GK1427@redhat.com>


--aQHk9D/h+j/L8Oa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2025-11-18 18:16:23, Richard W.M. Jones wrote:
> On Tue, Nov 18, 2025 at 06:56:33PM +0100, Pavel Machek wrote:
> > Hi!
> >=20
> > > Recently, syzbot started to abuse NBD with all kinds of sockets.
> > >=20
> > > Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> > > made sure the socket supported a shutdown() method.
> > >=20
> > > Explicitely accept TCP and UNIX stream sockets.
> >=20
> > Note that running nbd server and client on same machine is not safe in
> > read-write mode. It may deadlock under low memory conditions.
> >=20
> > Thus I'm not sure if we should accept UNIX sockets.
>=20
> Both nbd-client and nbdkit have modes where they can mlock themselves
> into RAM.

kernel needs memory. It issues write-back to get some.
nbd-client does syscall. Maybe writing to storage?
That syscall does kmalloc().
That kmalloc now needs something like PF_MEMALLOC flag.

mlock() is not enough.

Best regards,
							Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--aQHk9D/h+j/L8Oa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaR2JjQAKCRAw5/Bqldv6
8nyLAJ0fg+14AbZ5oZZJCws638BzTfOy3ACfQZ9jf5rMfhYV1RriNRoroGv0JwI=
=eRuh
-----END PGP SIGNATURE-----

--aQHk9D/h+j/L8Oa2--
