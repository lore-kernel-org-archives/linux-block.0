Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2375F3B14C0;
	Fri,  5 Jun 2026 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664604; cv=none; b=fZyD3HJ8im5dOAaZd6631Ql9xhBJE7rUlTSt9qOD6FBNQbo6i95xrTEggSX1in3B0OsGevS4GonUt/6fUebzH6i+T2Dfx8tq6uThpaZ/DLR4pVzBna44snPBitpfboYiSrOqZtNZUsQKWNw1fLmHuvxS6qCziCAtkvpYd41gVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664604; c=relaxed/simple;
	bh=lVjmYJAafcfNRTJdBqdjJ7O56bNKya2KV9tVeNTbUmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rprDIVCikQ4eznl2aEmPsy9V4+nPQPbfRBtpn64CbvTUhFqaUitsm2ZNGNk/VI6ivHO6ZFuKdx2exFGFdUH/XWqNwUPxQJrejVstbzCEZecWpkbXgkrso1WU6ee9qVslR8nK7erQzqQ4V+qRUKuy6BixRGXx9QhYgL4TWbOnA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do7oqJ9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do7oqJ9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC6B1F00893;
	Fri,  5 Jun 2026 13:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780664602;
	bh=UBr/1zPj5DyYo4cmDts4CxkrR2KDbHvoTJb1mnqCGK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=do7oqJ9bmL0jyi/BSyTxK5f3Ms8VqnLZiLtgoUDXZcApW0jVGoF/OltF9RBghk2KA
	 GDN/gubiYlPyzA+JRh+ivITZYUUIZwgsNJAEsVHybE+8DLZQlt5adPVJJixlMdp/p2
	 dXNTDv6QybUPav/jR8pl/zA0pkacdcc1KikOL1K6HwthyTMub5cQa0VmGiCeQjLnNG
	 5d9+04I7lIbKSMyPEAnTFOqhc56TuODpP/MpuNXtlzx1Qb4IKykD3kV3zRqM1RAFLD
	 wn16eu5fGXsiimzuCnCSscJEav7dpBFjI0Y4+5jP9bFlJIjbob1zMWigiFJUK1UEjy
	 9gDLFK2P3/fAw==
Date: Fri, 5 Jun 2026 14:03:16 +0100
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
Message-ID: <14686d75-c481-42ba-bbcf-94a4423aeb42@sirena.org.uk>
References: <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
 <20260604210704.41751-1-ojeda@kernel.org>
 <89f0f308-2ee7-4c68-b811-8132e5d88530@I-love.SAKURA.ne.jp>
 <CANiq72nGo=F5D7b7Hx8A1jfAJw_72Np+UpRWBRQoPLAE+RAPpA@mail.gmail.com>
 <4ffdbe16-61ab-47e8-b696-e2fcf9a26385@sirena.org.uk>
 <CANiq72nKDpzd9BTPfQ-NhWgcTgWdE=spED_n-idv1Jnekdo=Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q7w0dM811B4jc7oX"
Content-Disposition: inline
In-Reply-To: <CANiq72nKDpzd9BTPfQ-NhWgcTgWdE=spED_n-idv1Jnekdo=Fw@mail.gmail.com>
X-Cookie: Error in operator: add beer


--q7w0dM811B4jc7oX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 02:40:24PM +0200, Miguel Ojeda wrote:

Copying in Kees and Gustavo due to a rust/randstruct interaction in
-next.

> I Cc'd you since I was wondering if your new `LLVM=3D1` build should
> have caught it (I thought the GCC one wouldn't, since my understanding
> is that we lost that last week due to the KASAN+RUST patch).

Yes, you did loose it so I swapped to LLVM=3D1 in order to try to keep
coverage.  I didn't specifically verify that it worked though, I only
noticed that change as I'd been enabling rust for KUnit and that flags
any missing Kconfig symbol.

> And, yeah, it is fragile... It is quite a complicated set of Kconfig
> relationships, so years ago I also ended up in the same situation and
> early on decided to add an explicit grep for `CONFIG_RUST=3Dy` and
> certain other bits that I wanted to ensure are in place after the
> config phase.

It looks like the breakage is due to 'depends on !RANDSTRUCT' because
clang supports randstruct and allmodconfig defaults that to
RANDSTRUCT_FULL.  The fact that rust depends on !RANDSTRUCT but
randstruct doesn't care about rust means that randstruct wins.  I've got
to say rust coverage seems more important than randstruct coverage for
-next, others might have different opinions though!

> For you and those building with Rust enabled it would be great to
> notice when it gets disabled by mistake, but I am not sure if most
> maintainers (i.e. those without a Rust toolchain but using
> `all*config` routinely) will appreciate it (or rather, tolerate it...
> :).

I guess there's a difference between !RUST_IS_AVAILABLE and
RUST_IS_AVAILABLE && !RUST which is interesting here. =20

I know other people have been caught out by silently not having rust
coverage in their CI.

--q7w0dM811B4jc7oX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoiyRMACgkQJNaLcl1U
h9D8CQf/WpDfeh2TJR2gE7fYiC4pNWeGRiipEcxppGbs7b/pH+fV5WZDGC7mPzas
4crdh7SZHGnGyqQuNZGX6j+eHvk6gPojdz+D59VPoet0ko3jEKPFDR2E2+PRIMqq
JOBjEjTCB7fHMPAJ9JoXvCFREwGlymZMBiyoYwMtNSdOir3oV4ambOO4ym4A4j7k
nV5maj2FFyAb38Ln0gvqqAupyeHDhltc3++zDo1MZTCxzGbTcrVocQvoVJR72VTa
+ZTC0LGct0Du36MGZi015kGlML6WME+/pq9FtrXhoxi6tJcIASOl+WzeToUfbM7y
FZUeHv0iKx/Ih7muojld2FDepUG8+w==
=zoZf
-----END PGP SIGNATURE-----

--q7w0dM811B4jc7oX--
