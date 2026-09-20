Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7F3C81AD;
	Sun, 20 Sep 2026 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789917512; cv=none; b=b6Ea5wF+kxj7G433F8cv7J10HTT8Ei+lVc2SOryByiUkfjYDTdW99zGXDGusQetgHLcZKryetpmxaFSm2ZFl4APF8XXt4+zR7/VGS7LWV7kR/mes/QyOUHmuj8exqJ2eBAnfVnJ9bSlr2mdMkbOR3nC+cqOlxC4h3XHL74uIwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789917512; c=relaxed/simple;
	bh=12QjNp3lRKMdu8yh581+R2UggZar/NP9OezRnofVn1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/UwTODNqfQHOQ9B8S5JW+tPkVLBNQb5ly3La+mdG5xbQlE7342Vi5Bvr1oclDxghrLs6JfkPR4MBI/mvhfkJ2vwlXIhRxIB0AGsgdSpXKKYehrLudtqK5MkE3sz4kEJ1O/lp7vEQxZvSku+hj00sEUM1BjeSM56EUH0LNqZrK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3lGKfAq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3lGKfAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEFC1F000FF;
	Sun, 20 Sep 2026 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789917510;
	bh=KN1PxVt32py2P1rQ21HpYvnBshMBVFUsroWO+DKFU5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H3lGKfAqKvLlRM91DcgNgYlhKsvcSzNVO4iYUhAtUI5c5WZcDzxwXRL01y6HW4vv1
	 MDWl3Yi8TsyghYdjSxCzJkq7tS3MH1oRdSKbwv2Jvqv8UefgPUmdnoyBXj+AIzdLcN
	 ovEY1fXWTbXvcyfK3rmVJz2MKP7fMa4Hqez8JavEbBpiXdxwfqSXxdTze8iiOyt2Mv
	 W6DfkfIOHLE/9xd9ix/SiF5I/kiR9SdvBaii5ZbYlEKKmOkqCZymS6P9aYUz3kS9W4
	 XuCMBKPZo+EN2sCPOKTUZenKWaZ4oI2Yh0ebn0Z938rhp27oXvcl/pm6fFjEIYtMmf
	 xgcgw0LQPvnTQ==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 6063C11D565A; Sun, 20 Sep 2026 16:18:27 +0100 (BST)
Date: Sun, 20 Sep 2026 17:18:27 +0200
From: Mark Brown <broonie@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tao Cui <cui.tao@linux.dev>, linux-next@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: next-20260917 and next-20260918: merge of the block tree breaks
 all zoned devices
Message-ID: <aq_5QycDLgQGCc86@sirena.org.uk>
References: <20260920125846.1806521-1-cui.tao@linux.dev>
 <20260920231226.771a0e21@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RGSZHC0sFjjE3Ujj"
Content-Disposition: inline
In-Reply-To: <20260920231226.771a0e21@canb.auug.org.au>
X-Cookie: Orders subject to approval.


--RGSZHC0sFjjE3Ujj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 20, 2026 at 11:12:26PM +1000, Stephen Rothwell wrote:
> On Sun, 20 Sep 2026 20:58:34 +0800 Tao Cui <cui.tao@linux.dev> wrote:

> I no longer run linux-next, please email Mark Brown (cc'd).

> [The rest kept for Mark's benefit]

Thanks.

> > I ran into this while testing a blk-iocost series of mine (charging
> > zone appends as writes) against a zoned null_blk: the device simply
> > does not show up, whether configured through module parameters or
> > configfs.  null_blk prints "using native zone append" and then
> > add_disk() fails silently with -ENODEV.

> > Taking the axboe side of the function makes nullb0 come back on
> > next-20260918 here (host-managed, chunk_sectors 131072), so it looks
> > like the merge should just have taken that side.

> > Same conflict, same bad outcome twice in a row now, so tomorrow's
> > merge may hit it again unless the block tree has moved on in this
> > area.

I did say when I did that merge that I had no confidence in it but
nobody responded.  Can you please send me a commit on top of current
-next which fixes up the resolution appropriately?  I can drop extra
fixups in relatively easily, it's probably safer to take something that
you have tested.

--RGSZHC0sFjjE3Ujj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqv+UIACgkQJNaLcl1U
h9DyFgf+IIzB3nY9QLEnndl26HLQyrITKDTW8PNfiugW1QmZfyqcj0ZCZf6QValm
EYz+6S1g3Tu5rXNTny/9dSLxFO0vkiJr3W6cmQFvVY+GgZqsQw43CfYh6k3CmLK8
KMpAvC5AF+lCUmYtc1Fkizd49u5SJ6wgDwG1DED43bFf0dQUHXVGQFJt+7NwXIU1
mc5CzozPF9iK1PHL3kjqMZd/KhD3BIxilRqoPu62NdVLw9WnpGkz+3/D+guQWiPV
7WQqreyFC1qyD6zvFEGe+bf2HlPlxy5Q6LVZvTHvf8J1HLM9xZPYZ2hIKMWFG/xW
9CiK50H5+NeoY42GW9LT2ywG5pq6iQ==
=tebV
-----END PGP SIGNATURE-----

--RGSZHC0sFjjE3Ujj--
