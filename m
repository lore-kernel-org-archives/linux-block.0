Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71EB30B9BE
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497720; cv=none; b=Rn/6RWksftqV+xO14mgGjPMbSBaGRDBSGhK2phjkEmZzlP1vmH2gkPgETlYsx3/Dew1tNqQHr4iN0EhiULaRCW4EFN/4ZCcZTQdD2ZlSwdtsJ5E/pVLjKRoeaPWfJAPuWM25yzvVD3felyg88ungTVio7oJ+iDk748TZkQD6uYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497720; c=relaxed/simple;
	bh=E2gedXa8RPvDIuGgbAJ2AbBt8r9o7NHF1gJHowLsZT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BriomAmx5t1o7hnZGdzeJZBuSWIuy2hCh5f0Am34FflEzLNUxAm5bjbrK7sLf5gvVMAhGx1+OTk6UM1hk0/oErDMBhPag0nUEo8nrWGRxsFjCCE/xd86ogNvmm/lZhCLgz5u7//nje1YO4hjycg9Ef3KJ2Jr1LMmdx7/oatzEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bbq7oeee; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bbq7oeee"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yq5T9jvrMp0bUSghu5umc9pYCIOmRrDKOTdNpR9Lqn4=; b=bbq7oeeeYLbJ//R8MlPrhaSMWA
	FN2LyZNdSI844grc5WWMC9OHEIy+yS0wheJg8ydJj+yHteNtaZVaRYhJ/+u/2zIAHGgd+fGGqcQjb
	vtfn5hKTI2vky5Ec5CI8r5/co+UMAEle0duSCGDUermLX5pQBsPtME2iQlsC4yKCULxrJVu5bGte0
	r2DFYkoaeK233YtVxKrEUmxFGjJDY5hOXFSeybDHnHqw2exIcGMn5RZFB3Fey+24ONRqmz9d8Driz
	AAoUPt+6xomoxl/oNxX+mdDcJwJx2ZjAWIiwq06GWO+enxFxqRTfagnipxFPgXzFRKXsI2nXAR1eU
	ExphoJ+A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <benh@debian.org>)
	id 1uX6Z2-009A7H-51; Wed, 02 Jul 2025 23:08:28 +0000
Message-ID: <e45a49a4e9656cf892e81cc12328b0983b4ef1da.camel@debian.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
From: Ben Hutchings <benh@debian.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
	1107479@bugs.debian.org, Roland Sommer <r.sommer@gmx.de>
Cc: Chris Hofstaedtler <zeha@debian.org>, linux-block@vger.kernel.org, Jens
 Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Salvatore Bonaccorso <carnil@debian.org>
Date: Thu, 03 Jul 2025 01:08:20 +0200
In-Reply-To: <r253lpckktygniuxobkvgozgoslccov6i5slr5lxa7oev6gtgy@ygqjea7c6xlm>
References: 
	<zdclth6piuowqyvx4bn6es5s3zzcwbs6h2hheuswosbn4wty5a@blhozid4bx6q>
	 <1MGQnP-1uY1yz0lQr-00EvjN@mail.gmx.net>
	 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
	 <fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r>
	 <whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
	 <1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
	 <iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
	 <1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>
	 <aif2stfl4o6unvjn7rqwbqam2v2ntr35ik5e24jdkwvixm3hj4@d3equy4z4xjk>
	 <1ML9yc-1uEpgp2oMs-00Se3k@mail.gmx.net>
	 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
	 <r253lpckktygniuxobkvgozgoslccov6i5slr5lxa7oev6gtgy@ygqjea7c6xlm>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-fZQJ67eJRUEZGuzERXWr"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh


--=-fZQJ67eJRUEZGuzERXWr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-06-29 at 12:26 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Roland,
>=20
> On Sun, Jun 29, 2025 at 11:46:00AM +0200, Roland Sommer wrote:
> > [correcting CC recipients]
>=20
> Huh, how did I manage that (rhetorical question)? Thanks
>=20
> > > Ahh, now that makes sense. pktsetup calls `/sbin/modprobe pktcdvd`
> > > explicitly, the blacklist entry doesn't help for that. Without the
> > > kernel module renamed, does the 2nd DVD-RAM result in the blocking
> > > behaviour?
> >=20
> > Yes.
>=20
> OK, that makes sense. So udev does in this order:
>=20
>  - auto-load the module (which is suppressed with the backlist entry)
>  - call blkid (which blocks if the module is loaded)
>  - call pktsetup (which loads the module even in presence of the
>    blacklist entry).
[...]

I tested with a CD-RW, and the behaviour was slightly different:

- Nothing automtically created a pktcdvd device, so blkid initially
worked with a CD-RW inserted and the pktcdvd modules loaded.
- After running pktsetup to create the block device /dev/pktcdvd/0,
blkid and any other program attempting to open that device hung.

My conslusion is that pktcdvd is eqaully broken for CD-RWs.

Ben.

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-fZQJ67eJRUEZGuzERXWr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhlu+QACgkQ57/I7JWG
EQmdDxAAxClLvO+E6qzWX746m4KYoYekREscmqWHjN9h+5Qk4AU4XOao/DcpTwFe
MFW6nIlmr+Yhzbnw4HDTYUMI8Okz8OHWr8wYPpDfPYiCOncX14NhBmM4orn7Css+
+Di0U8uIHsbI86gOwt05Bv1+0ZcS5tbCyUaaapdtg47HsfFzCGFpkXDjMiDebuT5
Tvg6BoeeW4vqvPuxWPB7J7WRrbI9m6TDe0w4Cjv7j1WdZyMLGRFVMwbjBdATMTr7
j4iArWgJVeZ7N0a4Jw6v1TQJe5eneQIdGNsgDAtIp9N3ETDWN9zZWsVHxAy9pkRz
g3OAnuxKvZ05tArADHHdW9yh37U1QBlUEEsUfnNbTDETsOUt4OpGNSf1sRiuCV1J
d0+IxvAmzkkhUlthKQ8OtTwHlyUl5heM9AQ2ZtAh6TyR/5iVk9RgHXpkdw9eQ5WB
LRpNqz998MazUTTfw7pXfVjYjMvItEsQPD+jPMwn2p7A9wxDe1JfrF2FjPRTGhqw
EqKaWhSpylc2gCXSh5cCfU3c7AluPK4nq41iYmqHHaER2G/apLU1hqBOL1AOKz+W
4o4VBj+d7lbvtnGbNp4gBS5ZGdSUmAk1al+chs86RDBD5lRpXlZ2pWamhhxd9Avi
Jic9wDwWM7loC1zzNdxVjTVwbxskxW+ZxiD7Q+LbaTVv0Z8kyJA=
=R8ni
-----END PGP SIGNATURE-----

--=-fZQJ67eJRUEZGuzERXWr--
