Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7534DA535;
	Fri,  5 Jun 2026 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661080; cv=none; b=T+SdkAs3n2goYJK0XKDFSHrp49bzeTj0WGf+xQrR0RSmkC6EkC4OeCMUEHJ0Gx+4ih+tIUffsCFmAbKtyn+zCZBil9XG50G92fQbgAdUoEMvFty4j0JiaGQennd6pKI/Ug0aX97hKT8T/zdoiWafg3V1JEB7XlNPvJ40pyZnD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661080; c=relaxed/simple;
	bh=CBugO4tBT4tJQHA8HIOOmL0b48mq9HwYuyuQPJ8V4eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjD9HIopg2yFzcGSRscaqvs4Hf2m8+QLSXbPTBO4qXa1EMhOw5kjFt7bUV/Kw3IlMHzBWfoPMexys5+3kuLrMxSqTvCamkRWOuwvzUKFznfeOaF8g8QEcwAW2eOiftBVXI3zK3JjZ5g/Om0esyat7aEUT6Tlmc0JPmJqn6dxaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIZb/SMN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIZb/SMN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F88D1F00893;
	Fri,  5 Jun 2026 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661078;
	bh=cN2I4cs/2c2NI326aH1UOb5eaKWyax4VWbE/kwBA7uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GIZb/SMNoti/2/xXzFzRffM4bNK3kBGZzB1b2teMeeUuzbqAmze6AEpfIIc+ddZI5
	 z7z909Q0LT94fu7uRxkh0BKSvOa2O3kF/Gj71UjgdERaBzPnX+03w+q3h8/BT48Pe5
	 LB2iMfmtn3hA7YA6+7UhGTSTfARzGpi/OuR9o5X6rHeKM6z2nSxHHYUnkDdmS5692z
	 26ZTamuzggw3mgC1NAL3MER2hdtexMKdMUfuMITqru061SDmb4zcr6Z/awS1LiBbRE
	 uwXFxaDxIFcNJZaXAfsD8EG52t/CCAmi0Pa3xTDuD6yZqEykj5pMtLR5jUNaPgCMzH
	 V4gUflPNPKKEA==
Date: Fri, 5 Jun 2026 13:04:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Miguel Ojeda <ojeda@kernel.org>, akpm@linux-foundation.org,
	axboe@kernel.dk, bvanassche@acm.org, dlemoal@kernel.org, hch@lst.de,
	hdanton@sina.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, tom.leiming@gmail.com, wqu@suse.com,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun@kernel.org>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] block: assign caller-specific lockdep class to
 disk->open_mutex
Message-ID: <4ffdbe16-61ab-47e8-b696-e2fcf9a26385@sirena.org.uk>
References: <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
 <20260604210704.41751-1-ojeda@kernel.org>
 <89f0f308-2ee7-4c68-b811-8132e5d88530@I-love.SAKURA.ne.jp>
 <CANiq72nGo=F5D7b7Hx8A1jfAJw_72Np+UpRWBRQoPLAE+RAPpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="StAMqoMBl4zgWmc9"
Content-Disposition: inline
In-Reply-To: <CANiq72nGo=F5D7b7Hx8A1jfAJw_72Np+UpRWBRQoPLAE+RAPpA@mail.gmail.com>
X-Cookie: Error in operator: add beer


--StAMqoMBl4zgWmc9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 01:02:59PM +0200, Miguel Ojeda wrote:
> On Fri, Jun 5, 2026 at 12:15=E2=80=AFPM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:

> > I am using my tree for allowing syzbot to test debug/experimental patch=
es in linux-next tree

> linux-next is only meant for patches that are already reviewed, tested
> and destined for the merge window.

> It is not meant for experimental patches, and adding those, especially
> this late in the kernel cycle, can break other people's CIs and
> systems at the worst possible time. If every maintainers put random
> patches in linux-next, then it would be unusable...

> (There are exceptions, of course, but only if people is aware and in
> agreement...)

In general the sort of testing that it's good for is "this needs more
exposure" sorts of things - things that look good locally but where
there's a wide variety of users or affected systems that might be
affected and where it's hard to judge the impact.

> > Do you see any technical problems except comment style problem?

> The above errors are already a technical problem -- they break the
> Clippy and docs build!

Oh, bah - something turned off RUST in allmodconfig again so we lost
coverage in -next, sorry about that.  I'll need to work something out to
make sure I notice that happening and can do something about it.  It's
kind of worrying that this keeps happening TBH, otherwise rust conflicts
are likely to result in broken builds.  The dependencies feel really
fraigle here.

> No, please drop it now -- the patch shouldn't have been applied to
> linux-next yet, since the maintainers didn't ack it (they just
> realized it exists...), it is not reviewed (apart from Sashiko), it is
> not tested enough (given the errors above) and not destined for the
> next merge window (for all the reasons before).

Had the rust builds been enabled for allmodconfig as I had expected the
tree would have been kept out of -next as a result of this.

--StAMqoMBl4zgWmc9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoiu08ACgkQJNaLcl1U
h9AjUAf+KvxHG2EpNg/5WRLFMD+usuVYU6396FrVd3qAnwYZHZ4NL8YKbVSH0xE0
BiOzCycX8KKLq55wHPy+v9DB1PUGCHhMHCXbcgMXWUtXNCKXlz3K8lH2btLADSkE
sS4Fh28CoDPhVREPITYhRb3QwRHtztwqcayblFxM3Epm3cEtJzET5qgFKbGtKbFq
arb2USdnn0IP5z6FhTxm4Joco+c6QSfHDCCbFXyFfKhIK4lpK0KhJBp675uFTkgH
RIkRTr6cKEc+yg7wi2koWA/g39rMQxEUHHqVRxu5lsHcXad4ctmFrvnuHP6HvYpP
V7DbGAnI18515PvWAvMPafYsIY11nQ==
=qEAs
-----END PGP SIGNATURE-----

--StAMqoMBl4zgWmc9--
