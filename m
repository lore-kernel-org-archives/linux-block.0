Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0041DDFF;
	Thu, 16 Jul 2026 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204205; cv=none; b=d+sVFun6zQrPSp9hfUwipLn+T+PvnwskLqp225CJSqbD1Rx6OU6uRJJIyrum2ZSf4q0crKRG6Bn7Fv9tCTgD7Dw/kX2STRLmYPvIAPgtaCAbx4RqHDuJ9nVJrYHnGdrcxYTvGAeEVnL/c9x+N2ZL7sf9Udpbq20K+9gC+/YmIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204205; c=relaxed/simple;
	bh=RHnoUoVVBRHznZDjfg7p1zoSY/QFz6KSM7e+8oRx5t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+h6qKBQhqG5/BSeEV/kS/bHC8nWGE6D/B8UUCMxsXb+XcjSImJrTklLmCyK6MtvgXrMJRDGXn2X1NoGWQunGFEb/X0FQS1gxcS8HIq8X/Y3EU2Qy/UDeXlfTCHP/1X31ZV/RAlBKKdZ3JaKT4THvvic/v2MaYa5gavRS+SdNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7b+FEw5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7b+FEw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C0B1F000E9;
	Thu, 16 Jul 2026 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784204185;
	bh=OeY/RrnCDHeRA7waqEnCw2zQoIH3AdOyPp5nJdiYRUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C7b+FEw5oW4E/09NAyQh5OGXjrU634n8rTS8NN5msWGpky97UJYzngQcko/OfNo9H
	 7MZyCCbaIAEGufoCKyGKIjODfzlMsW6yt1g2rulcjLtl/rlVAWIZvwKTeNC+JssUnT
	 h0sqMU+7U4g/0sB2w7zjoXg/pFB/PDoIK9T1YUmtoKmfe7eqCmB8I3S+/aPXATfKeG
	 Q0NNVAWvcK4Qb3QqYudhggsIgxEsf4dd96OQMfBo4oGCVxr7U+aCYGKtWv4gAU0MoG
	 vCJ3RW6mMd6zZyJ8g79AMwBGhcKW6h/QF6tRBGeSR4F59aqJEEUZzRmlPWM1cCLhEL
	 D+Z/FYd0Zuvbg==
Date: Thu, 16 Jul 2026 13:16:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-next@vger.kernel.org,
	axboe@kernel.dk, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [linux-next:master] [loop]  d908729e74:
 stress-ng.umount.ops_per_sec 100.0% regression
Message-ID: <e75c9a7c-77dd-47aa-949f-27a937a64760@sirena.org.uk>
References: <202607151655.9d74999d-lkp@intel.com>
 <aleZammRRSVN4dl0@infradead.org>
 <c625eb50-e474-4966-bf3b-e83d7e7d1750@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="61mQimz+8MzkIz9g"
Content-Disposition: inline
In-Reply-To: <c625eb50-e474-4966-bf3b-e83d7e7d1750@sirena.org.uk>
X-Cookie: Celebrity voices impersonated.


--61mQimz+8MzkIz9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2026 at 03:57:22PM +0100, Mark Brown wrote:
> On Wed, Jul 15, 2026 at 07:30:02AM -0700, Christoph Hellwig wrote:

> point where I think I have to do as Christoph suggests.  Looking at the
> current contents of the tomoyo tree all I see is:

> Tetsuo Handa (6):
>       lib/Kconfig.debug: add CONFIG_DEBUG_AID_FOR_SYZBOT option
>       net: update dev_put()/dev_hold() debugging
>       net: add "struct dst_entry" debugging
>       loop: Fix NULL pointer dereference in lo_rw_aio()
>       kcov: fix data corruption and race conditions on PREEMPT_RT by moving saved remote state to task_struct
>       apparmor: temporarily disable in syzbot kernels.

> Absolutely none of which are obviously on topic for the tomoyo tree and
> some of which are patches that people have previously raised concerns
> with.  This is very disappointing to see.  I will check the status again
> tomorrow but as things stand I think I need to drop the tomoyo
> tree from -next.

Looking today I see that all these patches were dropped from the tree so
I've left tomoyo in place, thanks for taking care of this Tetsuo.

--61mQimz+8MzkIz9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpYy5IACgkQJNaLcl1U
h9AWbwf+LalYQS/hl3QxwcQit0fMn8PF/NHQ2mK5pM/8LWvNLQG5laomGTUjblwJ
CrmU/rP6ODlTiWwPTv5M3t+9lJXtjjrd0d2tOD6IKPZsUmqJzriYVDUpbZW9M/aW
QD9EkvubuFJW0chc/XHOoK9ciQJSH1kZnThLARHVmqn0A+bBbsw4el4Q1ZNjZ+f9
Gkrlg66MqX56yPsCkTsX5xjCWwQEqpyM3z1y11H0ZRd5hIFbZohHw5FuQSl3BD2H
fpuicDvOkg3m1R35bDOuJzoXC/7aB//qf+TL3OsB+o0glhrTD8+BOEdZvwJhNzSK
wJUkwaQ+vjLP0iumFcjOzHRtsr5DFw==
=DFfZ
-----END PGP SIGNATURE-----

--61mQimz+8MzkIz9g--
