Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E882D876F;
	Tue, 18 Nov 2025 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489169; cv=none; b=ePOFkL6YiDvOG92kl8JrrKewKf52aJjUf4grUm3pecFDBg3E5dtlvrUy0l8biNtYn5++8EQ20t9j8J/8sWWACZCZ1V+L3hkjrVnno4+ljvfavJ4SQUVY+nLP4Sgqye8f3Tcr76LptXQcYiUiTDSgv5x2XzgCBAi26Prgc+yee4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489169; c=relaxed/simple;
	bh=7k7sv/IgF0IVHrWcT/mvhIV0fNBMwMFgPnNI42cYxj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfB0qSBHIK02ZPCpGhgeExldSL1cL+tn0tKdqfDtXeC9ZlPnJs4SEPgmiF0ehJ0yEu0rV8BIzEDiB+2r5+Mq9o9oUYqh23kV/ArpfYQQMDIV0jJNxYhr1cfEsF2HIOXIeVeDWtiseXZClsqfVJH72xnwh0E2tvJtI1Z/EMOamd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=MH7Enokq; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="MH7Enokq"
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F07181C008F; Tue, 18 Nov 2025 18:56:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1763488596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B60GSdZ3ZLwb5RwYNK/6Y5TS9j/ssMyxcD+Zg0X+hcU=;
	b=MH7EnokquyyfGAXphMgN/Lf+iik76ecs1OcyItQ/M/IZNygyROV13ScCkDIrq2mAuBC93D
	AOItBqWS9ZKj8iWtIrZ7AD3cCOzH3uQG49erotfHR/N5F8UTpQavtMWhD/7/9XbuUUf4un
	cwVcIdqh0AmD76zrXoWN7+SYDY2ZnUc=
Date: Tue, 18 Nov 2025 18:56:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Eric Dumazet <edumazet@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
	Mike Christie <mchristi@redhat.com>,
	"Richard W.M. Jones" <rjones@redhat.com>,
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
Message-ID: <aRyzUc/WndKJBAz0@duo.ucw.cz>
References: <20250909132243.1327024-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K4L5bQUTPLUWipwC"
Content-Disposition: inline
In-Reply-To: <20250909132243.1327024-1-edumazet@google.com>


--K4L5bQUTPLUWipwC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Recently, syzbot started to abuse NBD with all kinds of sockets.
>=20
> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> made sure the socket supported a shutdown() method.
>=20
> Explicitely accept TCP and UNIX stream sockets.

Note that running nbd server and client on same machine is not safe in
read-write mode. It may deadlock under low memory conditions.

Thus I'm not sure if we should accept UNIX sockets.

Best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--K4L5bQUTPLUWipwC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaRyzUQAKCRAw5/Bqldv6
8tyOAKCF3uzSNUZFstOM2a3oNq/GuSt5dACgvt2eK+xctfVYARwjKgQ5MLSpl+U=
=Jlm+
-----END PGP SIGNATURE-----

--K4L5bQUTPLUWipwC--
