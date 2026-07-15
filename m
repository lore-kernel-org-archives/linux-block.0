Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1925F32ABCD;
	Wed, 15 Jul 2026 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131335; cv=none; b=RqbBSJW/jRUcYGI9h8NJNHDJBJTX6gRAmYs9eelqD++4zE/hOuNmOx16WZB3RiBX3athK3OQ+s8R345gxqaKQ39Kgj851bLuO/xC8t6DbXmm72LYLeWUba1/8cbhu0HKMnRAe55bcB1UrBUvZM1cd9Ft4vZIbZGbExw7XdbUoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131335; c=relaxed/simple;
	bh=98RKyKaV2LduCo//Kgl/PRvsw8mI68exCDNmSvWmOIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd1HWCIT9m9kftR+f8eTAvNeUhL6UUuzb37UYwJtFVyq/4QfCdFNBTSSEYjtbrM4XjPW5+ni6eQqjKHut8ScA8t+gqwF8Y/KuCNwo2phnoIqiXCnAxDe4NysINVjmPM6/5MRmTpWHZ2qK2AgcQO1Z7PZCdsK4yObwstmY5k6CcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwNGJLsU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwNGJLsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A9C1F000E9;
	Wed, 15 Jul 2026 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784131333;
	bh=azKGq+Lnlr31pxajBrx9OCvGqEZYN4Rc7bzdJFFDzvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cwNGJLsUXdZFBZRSRkEgPwn87bibZHODmMgW/Nbm4Ex5kAD1Dl7Ka7lFazeyUQjmY
	 6jyp+94m0PAEYf8/69rEJGOZTaMfr+/XmNdVOx2w0ESdRCPAb/VN+tPz1toUAMKzEg
	 lAsN0WdVfMlr9qjhK+cbcZDcMmCDb1V4V3od7E+ByFv6MOwHPyeqp37WrNTSFgM3pK
	 32Ofn6k++ONaO4TLLRtCK2f3IX5oxLQnjIausshL9tb9+w2a7ds61NX53+E+RrUjGo
	 6jYZouLYPJaBSfq4CR/MT9uRgfgKRiRB9A2ymNq13fCUdL9ggglotQOKDzTg5nQ1AS
	 UmZXtqJyD1aqQ==
Date: Wed, 15 Jul 2026 17:02:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christoph Hellwig <hch@infradead.org>,
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-next@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [linux-next:master] [loop] d908729e74:
 stress-ng.umount.ops_per_sec 100.0% regression
Message-ID: <b7ef10a7-5c67-4172-9845-fe77db31629a@sirena.org.uk>
References: <202607151655.9d74999d-lkp@intel.com>
 <aleZammRRSVN4dl0@infradead.org>
 <4ea4703c-7385-4f75-aee2-f21a6c8cce82@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NGQ0ytg4Ru8r0nck"
Content-Disposition: inline
In-Reply-To: <4ea4703c-7385-4f75-aee2-f21a6c8cce82@I-love.SAKURA.ne.jp>
X-Cookie: "Speed is subsittute fo accurancy."


--NGQ0ytg4Ru8r0nck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2026 at 11:45:41PM +0900, Tetsuo Handa wrote:

> Then, can we please keep discussion on
> https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28 alive?
> I am asking Al Viro to reproduce xfs/259 problem, but it seems that
> Al is too busy to respond. I can drop this patch if somebody is
> interested in fixing this bug which became visible in 7.1. Current
> state is a result of insufficient interests/resources for debugging.

I would recommend a combination of having more patience and, if things
really do seem stuck (eg, after several reasonably spaced resends)
copying in Andrew Morton on any patches for other subsystems.  If the
other tree is pulled by someone else on it's way to Linus then whoever
pulls it might also be worth copying.  Andrew generally picks up patches
that are for things that don't have an obvious route to mainline or are
getting dropped on the floor for some reason.

--NGQ0ytg4Ru8r0nck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpXrwAACgkQJNaLcl1U
h9B8egf7BMIvRS4MEnppIuRB0dRtfonZZx7EVv3RLF1KS+BVsg7OWtlQJTUZo9gq
fqXTZ+pTNvG3JLHMwqX9wCpK0SUHtRkyraTTxpSKdLsr2rfkJhSHO9EBTCbVhsJR
zXBaFLeVk+YadntaAWQ1O0A01jrFFR/Bmt6hS0RQIr6jDe7qm3t6XAP0SvT65bmb
bXfgEpdVJCACbWH6zirmEhFJ2y7WIftKEFyplmPE8qE1VqwOCw6mw/1FoLLmlGvO
S6w8gbtEgggp7/lwWlpKmfi9RzfAibyR0+T8NdoUquKgl6yNLXvhgo/B3xXBxjzd
NkfYdAXEScMLNMWJHthitFAB0bG9CQ==
=Q9gO
-----END PGP SIGNATURE-----

--NGQ0ytg4Ru8r0nck--
