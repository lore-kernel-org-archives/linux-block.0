Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF2382F0A;
	Wed, 15 Jul 2026 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127443; cv=none; b=nUKZYVd/DtM+gi7bw8qJikDAuTCVNA6pL/HeOCJdB/ldiAX6x7b1aUM8HWoKXom9I+ME4o4siYEHHL5u7wOdszSQ+ENLWfhfcR0nIgl6BStgjSaWa4yCyPGVa9xouawVgajBb6172Tl3m55rx8CfgdyV8JQP18NUYaUCEcRgXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127443; c=relaxed/simple;
	bh=fpVVhx81h2s1UsSJjEZoWFDD1JRSSMRf6Nk7om4/zg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNBFWhxNQis83b6mv2mdYtDnxnNnhqHDFkoH6MM9W577LBfjYK9WY06WAe63IghXAgTjfsTvDxtwuaeqwin2FUFcExkH+wp4wXKsIjBsFPDlh00PONsITykz7j53hbGfu7eNyyiLG4VYbw36drqM4NVwDoV/OHqa+eW6MivCu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPgqgGCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPgqgGCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4D11F000E9;
	Wed, 15 Jul 2026 14:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784127442;
	bh=1c5AJLtYF5/SQbYMe4Pa2IF7AV/XUJDgnKq06BMYfaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WPgqgGCUbAB0T/mYHUupdaUXguob44eHXjELbICZieOzH1eE8ht0kqJPpLtkxbOCo
	 oMd4dlL+tshEyEbm5qed6a7NmsqtzXQR1SskxrtnUgPrmYqflNsH2yY4DAjcNEn5b1
	 KHbK44EfYGAXwYzKj/JMSXf6PRgb3MeVZK4iGlxN+B83gRyR2AJGm1uljhRK9Y5/L2
	 tjTPhZBnOMYGYXz1AtC740X4vnWZweof5+wN0krPMVfSwljf8HI3X93qAGxFxYMsFs
	 nFmiJXxEIp78DRelbCF7yuBMvdisVA7bEOLf3oRD85Uhx0vt3d39Pvz6c7q3+bA9GO
	 I/6Cgpeesntkw==
Date: Wed, 15 Jul 2026 15:57:17 +0100
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
Message-ID: <c625eb50-e474-4966-bf3b-e83d7e7d1750@sirena.org.uk>
References: <202607151655.9d74999d-lkp@intel.com>
 <aleZammRRSVN4dl0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1AbFq2Rycslg0bHG"
Content-Disposition: inline
In-Reply-To: <aleZammRRSVN4dl0@infradead.org>
X-Cookie: "Speed is subsittute fo accurancy."


--1AbFq2Rycslg0bHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2026 at 07:30:02AM -0700, Christoph Hellwig wrote:

[Adding security maintainers for visibility.]

> It's also a patch that has never been added to the maintainer
> tree for goot reson. Tetsuo keeps doing this, so can we please
> stop including their trees in linux-next as there seems to be
> no other way to stop this?

Tetsuo, there was a discusion about this in the past month which seemed
to result in an agreement that you'd stop doing this and work more
closely with maintainers.  What's the story here?  It is getting to the
point where I think I have to do as Christoph suggests.  Looking at the
current contents of the tomoyo tree all I see is:

Tetsuo Handa (6):
      lib/Kconfig.debug: add CONFIG_DEBUG_AID_FOR_SYZBOT option
      net: update dev_put()/dev_hold() debugging
      net: add "struct dst_entry" debugging
      loop: Fix NULL pointer dereference in lo_rw_aio()
      kcov: fix data corruption and race conditions on PREEMPT_RT by moving saved remote state to task_struct
      apparmor: temporarily disable in syzbot kernels.

Absolutely none of which are obviously on topic for the tomoyo tree and
some of which are patches that people have previously raised concerns
with.  This is very disappointing to see.  I will check the status again
tomorrow but as things stand I think I need to drop the tomoyo
tree from -next.

To repeat the conclusion of the previous discussion you need to be
coordinating with the maintainers of other trees when adding changes for
their trees, and nobody should be adding changes not inteded for the
next merge window during the normal course of affairs.

--1AbFq2Rycslg0bHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpXn8wACgkQJNaLcl1U
h9Al7gf9FtU0x/iJcY9NLYNqWXEAr+VUCoFI2q8hM4aOJBEOxbN8/SsSAe4x5Ihv
AQ4yiVyPTtlYp3ZRqPxWURMbv6Y8oX+KXP0bmMJ55frIGHhZMWDIKsGdc9NAUXLW
6gCIIaXjg3MnBlnpNJs+w5O9yVfS4x4D3zJUsZ+48XO4KHqS7a+Fdwn4NjKgwp0o
pzjQq/L+R83+qrFRu54qilL9944nR+BnXu+CZtw0cjABe8bi+TpE9c8s4hxKtJdu
t09w4U/mMe2cuDpiACgFVFLIysTdE6iyo4jodQ6UAcdTGXVU9ctf72srJtnlbQyv
rNq20dGyIIVj49izqtjhEqecXZMoNw==
=9lZA
-----END PGP SIGNATURE-----

--1AbFq2Rycslg0bHG--
