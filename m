Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46DA31A045;
	Sun, 20 Sep 2026 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909965; cv=none; b=ctGoCt0lngKxTe7fb9dsD+JXFl99U0byKND35u9TBfcaQPEUfgJh1FoVAoIaqydFmxI6b1JrxAYVouua86sbTZU22UWY6j49eoWpTlAYHwoFjyXJ2KhdHrg0x52ECjFheEz2ppC+Otdh9BT23vEB/AfsPEMIuCG2+XNcsUsdRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909965; c=relaxed/simple;
	bh=eDMI5Ku1H/ICGHVjdTySIeVCjxxQYch6/DXg1E0Ox1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWGz4yk7DAL3X9vypNWRyyRyUt87z+8cu9LG7Mio0OH5X5YyjpA5rlQrkUeKUy5kgFNB5V1RLFN3/wHx4rA8s7UQW09uGyp0rbusitqI+AQbaoW1nB/tiBx5TitMwy30j5b7Y00H0vGq5TPbZx3Duih5AQ/qCtMFrvxhsBgkZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DQ2H8v9F; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DQ2H8v9F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1789909929;
	bh=By7CwzjEKuoPxXJ29LeNnqaFT2rmfr7n3560XH0PorE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DQ2H8v9FwIRJR+CxHwYdJxr4SPzaQPc04V2zEUJep0JgST2APTgnSWGDDwsA4K617
	 AzkTMJW7n61be6GuH1dfOqfwJ8VxjlPTH3+9BA9OdkJJXnBtX2Z/6WVuZrn9+PpoQL
	 85Eg1wWuFh05BBHBc8waJ6d+EWyjRQvsc/UBE0nGzvJgqHjuCR4uypW9tMLS4hFy7l
	 P18eTT4nMSFiilKUPUJmy8kjuV+1UELTDGuIdliyTOARhGuDeNE5Mw0IjMgFPpU28X
	 8mFeNEA24qhQHYc9Pv4NluEPJTh4p8Qni9WMNG6rHkITNFfjlyVqcLYi27wqQ3h/FI
	 fHe3rJrljwFiA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hnmwl5VJvz4w1k;
	Sun, 20 Sep 2026 23:12:07 +1000 (AEST)
Date: Sun, 20 Sep 2026 23:12:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tao Cui <cui.tao@linux.dev>
Cc: linux-next@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Damien Le Moal
 <dlemoal@kernel.org>, linux-block@vger.kernel.org, cuitao@kylinos.cn, Mark
 Brown <broonie@kernel.org>
Subject: Re: next-20260917 and next-20260918: merge of the block tree breaks
 all zoned devices
Message-ID: <20260920231226.771a0e21@canb.auug.org.au>
In-Reply-To: <20260920125846.1806521-1-cui.tao@linux.dev>
References: <20260920125846.1806521-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R3TRsirW5mdUq_ZFzNgejzQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/R3TRsirW5mdUq_ZFzNgejzQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tao,

On Sun, 20 Sep 2026 20:58:34 +0800 Tao Cui <cui.tao@linux.dev> wrote:
>
> Hi Stephen,

I no longer run linux-next, please email Mark Brown (cc'd).

[The rest kept for Mark's benefit]

> I ran into this while testing a blk-iocost series of mine (charging
> zone appends as writes) against a zoned null_blk: the device simply
> does not show up, whether configured through module parameters or
> configfs.  null_blk prints "using native zone append" and then
> add_disk() fails silently with -ENODEV.
>=20
> My series only touches blk-iocost.c, and the failure reproduces on
> plain linux-next, so it is not mine.  Bisecting over the tags (qemu,
> "null_blk.zoned=3D1 null_blk.gb=3D1 null_blk.zone_size=3D64" on the comma=
nd
> line) narrows it down to one day:
>=20
>   next-20260916: nullb0 created, /sys/block/nullb0/queue/zoned =3D host-m=
anaged
>   next-20260917: no device, add_disk() fails
>   next-20260918: same failure
>=20
> The only blk-zoned.c changes between next-20260916 and next-20260917
> come in through the merge of the block tree, and next-20260918 repeats
> the same resolution in the same place:
>=20
>   66c8b6b56c09 ("Merge branch 'for-next' of .../axboe/linux.git", 2026-09=
-17)
>   a9ce2250a714 ("Merge branch 'for-next' of .../axboe/linux.git", 2026-09=
-18)
>=20
> As far as I can tell the resolved disk_revalidate_capacity() matches
> neither parent: it gains a
>=20
>   if (args->capacity >=3D args->nr_zones)
>=20
> check that compares a sector count against a zone count, with
> args->nr_zones still 0 on the first call, so it always trips and
> blk_revalidate_disk_zones() always returns -ENODEV.  The zone_sectors
> power-of-two check that both parents have is gone as well.  This hits
> every zoned device, not just null_blk.
>=20
> Taking the axboe side of the function makes nullb0 come back on
> next-20260918 here (host-managed, chunk_sectors 131072), so it looks
> like the merge should just have taken that side.
>=20
> Same conflict, same bad outcome twice in a row now, so tomorrow's
> merge may hit it again unless the block tree has moved on in this
> area.
>=20
> Regards,
> Tao
>=20

--=20
Cheers,
Stephen Rothwell

--Sig_/R3TRsirW5mdUq_ZFzNgejzQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmqv27oACgkQAVBC80lX
0Gz6awf7BN38hUqChpXUqxW3J1gLKOkkrAYOfnA8o1ydQwT/pyQfvAygYuP6/Dnu
gYpLJx2vB8citv2vakqdnJdaLJMlIcRWWsr/cm5jMNnPctjkEEh41EQ7f9QBmhL4
DDCCl0FZpz3OhoDfBF+Pq2yMt6kcovw7/V23YKYQWdLDk4M77o88O7X/eF7rHBLP
3ztPpT0JMiIQhLSDSMdEkRMKJAC7kwon1OP6BngUtAHk1ekg4YNB0uj2IivvuCSP
zmVAWqVfBAxLCFV0QrLe+DJD5WHAPWzSk+JBlJII2Fh2iZpRa03Xl2HRyUyPR4yO
yxCbLEZGo5c+WYMkEsTt05O255S1eA==
=9NOG
-----END PGP SIGNATURE-----

--Sig_/R3TRsirW5mdUq_ZFzNgejzQ--
