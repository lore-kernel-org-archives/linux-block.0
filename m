Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1073AE1BD;
	Mon, 21 Sep 2026 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979102; cv=none; b=OUm8KBKNUDvRRLB2vdln7bv6WOrRT23E+KPK0Gcf/4m1p2qIx1jJtWEYjEgB7ig8wfRGYzvMMt++NZnp/70aVlW9AMFv1oQgRD3UvY5lkJC+UDFxc2nkrUi5JLAGOAcM28uBHWlBDHfBBh+Ib3wu9sZ9XMQb1qWk3TSgwDS+kms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979102; c=relaxed/simple;
	bh=3t0e3F4VfslWuBdGcVFQ9hUz411uxVQF1KTgMoLo1JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltvjiypRYOIwdLVA4JYHCHtTuRqs37KVXLdxR8C0ag6Ne77c4/N9hD+BfpVBu4EK1o7L5xnh+dp/gdxcvLp6kYfa1GTPPX8/kHXTyI493NQDRxA4Dw9zlH9fVSPd2LuK4m8TDq3ZGyIS16OH8tUoizBHpfAu/ovs+fTgPP9A8x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLu7BZBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLu7BZBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3FA1F000FF;
	Mon, 21 Sep 2026 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979100;
	bh=xDdoMFVwkZuW5V48Pj4XfLchh/Rg4wCVY3CUXYAw3dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZLu7BZBzgbOtkBRYnS1jyz7lI68Te+SShWBVJmQ408j4cm2Un5eSZhZJY46quBPwq
	 WMd2zAybk8IZrd1TuYXNAyfyxQiQoVDVCUZVZKwTqraNDEMb2712W59NqEtk6VqHtz
	 YxcpgTr0PdGE7Ek3bKDzk7lxVzZOcOJ5UYMGXxIrM2xHODFXbV2wYt6L8X9MEcZUb3
	 0edk4OjL6Vec0pgNbiCVRj/8W1PUzSENzav88HRWaLFt71blacDltBd8CFFREfjDv/
	 xL6bJaHer/fpCVHZG6nuD1xReEn3SeAqXnMmDgjtkiEM/C6UfM3lOYnQV33BpU66VR
	 wOxfTMuC531QA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id E91BC1AC52F3; Mon, 21 Sep 2026 09:24:46 +0100 (BST)
Date: Mon, 21 Sep 2026 10:24:46 +0200
From: Mark Brown <broonie@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Tao Cui <cui.tao@linux.dev>, linux-next@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	cuitao@kylinos.cn
Subject: Re: next-20260917 and next-20260918: merge of the block tree breaks
 all zoned devices
Message-ID: <arDpzvyInLOK8MJv@sirena.co.uk>
References: <20260920125846.1806521-1-cui.tao@linux.dev>
 <20260920231226.771a0e21@canb.auug.org.au>
 <aq_5QycDLgQGCc86@sirena.org.uk>
 <d97685b3-f22c-4a27-a7d7-24b2ac7dfbe6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N14GSpgRFIvMtJQm"
Content-Disposition: inline
In-Reply-To: <d97685b3-f22c-4a27-a7d7-24b2ac7dfbe6@kernel.org>
X-Cookie: Too clever is dumb.


--N14GSpgRFIvMtJQm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2026 at 07:37:58AM +0900, Damien Le Moal wrote:
> On 9/21/26 00:18, Mark Brown wrote:

> > I did say when I did that merge that I had no confidence in it but
> > nobody responded.  Can you please send me a commit on top of current
> > -next which fixes up the resolution appropriately?  I can drop extra
> > fixups in relatively easily, it's probably safer to take something that
> > you have tested.

> My apologies for not replying, but I was traveling. I had looked at your
> resolution but only quickly and I did not notice the incorrect comparison
> causing the issue.

No worries, stuff happens - I was just surprised nobody complained about
the merge TBH.

> I am attaching a diff that cleans up the conflict resolution.

Thanks, that should appear in today's -next all being well.

--N14GSpgRFIvMtJQm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqw6c4ACgkQJNaLcl1U
h9CplAf/eIQ8mfAEfonr2Nm3JP5mKLLDAqCKMM/1CZOfX8TN8WtiZF2NX5wenGtG
5hEokmB96wvwYEAPJzIvRncGbZF2D6TYCBE2HgCQHVGv8B3x92AlAD0P84BHrr6+
emDw6o4BJxblut5W9CV8gFxIGoMoSepi87m9W/c6LW3aYQRcCdZ4JTTPdZO6U6Qt
nKktxnZWj6E/uVwNK88IpWMEUmiPB1f1k194qTK5wkIl60kZskNLrEa+pZZJplUi
ElqeYkuUbke7A1iF1tYpc94jAnw8Cdybh4jlLUanjq+ERmEkhllGn9jhBReQlQzc
xZHNS/Wz+hbYryqa6ZiJCiTVCeMoYQ==
=Xlur
-----END PGP SIGNATURE-----

--N14GSpgRFIvMtJQm--
