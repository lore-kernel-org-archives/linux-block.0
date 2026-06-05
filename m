Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB33E4C95;
	Fri,  5 Jun 2026 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671866; cv=none; b=LDdN3aTRwAaFjXpmenf6GjCUY6B2AOMxEY1eg6YNmYhO/nMva9kspouyI5eI7UDZKMp8rGEUcUiAa0IAt1QyJ59duZTow6FSDpu2t5akO7FiZ1ZDUJUdyp014xVgq4+7uBsY245UPXN1HuinKiM0jx26eVU1uxxslEcQRhSnkkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671866; c=relaxed/simple;
	bh=ryEMFUEaDchoUXL0sJSdp7brVE0ylu17SgmpfZaRkCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkTDGqLuRhrluEwaEIeTvILUHcIEnR1eYy5n//5th/D/P4VMcrdWZDKaGMqteHFUsKWwnSHgbkY4N1huNpqgsctueGRTDWyOU+Wno2/r9739GHIaxzfi2YG1FrHrG1hpwHEyAuBuQicL43KeHi2FsVTPpi2YOlDe6/8SBT7yy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR3FXAZG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR3FXAZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793121F00893;
	Fri,  5 Jun 2026 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780671865;
	bh=lIhieuhZySU37udxDs0PTOiey7L7Gigisq55o3Bj1Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FR3FXAZGI4dJit3dCnF2sGmEPpGMbZc27B68chKM4spY+lHSTZgeCAsYgLkl4RfIm
	 hb9avy1MgjvPuG8qJeij02l5C+F6c1x9RlCZQDic6WpTSU7fSfSHb4BxCGTXx4NrfT
	 M2D7f8yPK1QG1En8WId5tcTgZk+i9MN3x8fUo4d1tbuWR0tYiuUoqz1rPLJ5yGNKk6
	 9cuLOP1NprTCRawjnzBds2/k9jSnHPCdNe/b1pLHFxMnN0oCw9uxDfHRUbCe/66kxf
	 M4qiimfe372F6zdBSLcTgA7jUW4Pgn0Yd666L3DVoamw6mlD/1c/E2LDs8BFO4Y8W+
	 tZD6Lm3MJ1m+g==
Date: Fri, 5 Jun 2026 16:04:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Miguel Ojeda <ojeda@kernel.org>, akpm@linux-foundation.org,
	axboe@kernel.dk, bvanassche@acm.org, dlemoal@kernel.org, hch@lst.de,
	hdanton@sina.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, tom.leiming@gmail.com, wqu@suse.com,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Boqun Feng <boqun@kernel.org>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] block: assign caller-specific lockdep class to
 disk->open_mutex
Message-ID: <1fa6ec8e-59d7-4a53-a241-d55dd3cc0201@sirena.org.uk>
References: <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
 <20260604210704.41751-1-ojeda@kernel.org>
 <89f0f308-2ee7-4c68-b811-8132e5d88530@I-love.SAKURA.ne.jp>
 <CANiq72nGo=F5D7b7Hx8A1jfAJw_72Np+UpRWBRQoPLAE+RAPpA@mail.gmail.com>
 <4ffdbe16-61ab-47e8-b696-e2fcf9a26385@sirena.org.uk>
 <CANiq72nKDpzd9BTPfQ-NhWgcTgWdE=spED_n-idv1Jnekdo=Fw@mail.gmail.com>
 <14686d75-c481-42ba-bbcf-94a4423aeb42@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dnUsds8CTTCUrlnd"
Content-Disposition: inline
In-Reply-To: <14686d75-c481-42ba-bbcf-94a4423aeb42@sirena.org.uk>
X-Cookie: Error in operator: add beer


--dnUsds8CTTCUrlnd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 02:03:22PM +0100, Mark Brown wrote:
> On Fri, Jun 05, 2026 at 02:40:24PM +0200, Miguel Ojeda wrote:

> > And, yeah, it is fragile... It is quite a complicated set of Kconfig
> > relationships, so years ago I also ended up in the same situation and
> > early on decided to add an explicit grep for `CONFIG_RUST=3Dy` and
> > certain other bits that I wanted to ensure are in place after the
> > config phase.
>=20
> It looks like the breakage is due to 'depends on !RANDSTRUCT' because
> clang supports randstruct and allmodconfig defaults that to
> RANDSTRUCT_FULL.  The fact that rust depends on !RANDSTRUCT but
> randstruct doesn't care about rust means that randstruct wins.  I've got
> to say rust coverage seems more important than randstruct coverage for
> -next, others might have different opinions though!

I think I've got a fix which isn't too bad, I'll post it later today.

--dnUsds8CTTCUrlnd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoi5XEACgkQJNaLcl1U
h9AucAf/TCMResngU+anrz1HMlh9vr5GbohV9uhqNg37kWM2TRzaCvfjbGd/Res/
YRQ/3GHvrcCF/C3IbDozk+XIEubjr/73Ysmt/Eq1uTqdLtLukVD2X44JOu2cNETn
rMNxdiMLAl3A17q7mIWykLcobPy85TOayI5+egcmvSsjBTq/AK2nxOYbnt0Z4huq
Ak+Fx6hYr6HXEI9s4hn1kIamqbLTkv0Uk9/zAybx7Y/9TOioeVOXujJ7tRkOERBQ
uY8/YQzWfxVFZ/F73ovRwEgvub2lIXWfGOe6p7eUo8ePaWqW5pmTgPkioB55sKqn
gDbzdWwgnbY0YPv2cZ5IK1AYNdXFzA==
=UZU3
-----END PGP SIGNATURE-----

--dnUsds8CTTCUrlnd--
