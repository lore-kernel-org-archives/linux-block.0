Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="hVm1G0Qb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EkU5HiM6"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5774510E4
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 05:25:45 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id EB0ED3200B9E;
	Wed, 29 Nov 2023 08:25:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 Nov 2023 08:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701264341; x=1701350741; bh=lD
	4Mj6HG3GJEvukoHp1v6pteGLKfRcK2BW2YvFth6Es=; b=hVm1G0Qbmibvon9FcJ
	vBRHlh+0ACW07M+z8m5dhaJE4/0xhab/XdFbnLGi/UNpgdZin9XZyhCZAW0kKKrS
	cPGOivz2l4WJyqtqcVpyzfX7Qs08dUnsMf2UupqfGkcjBU2ts2ogaXq20a9tzx63
	kEjoqZHtceueYB2/31VWGs+QUO58YbAPXn0ZBn/EDiOeIkZF6T5QGg/cx2cjGnoO
	96IDuPKLrFPUPRYxxbNKmF+vTSjyxstpUe4beA+sx1dAtZoG9bWuASttog3IP8wW
	RAcfduTJIPqhKPfnxB86IyzdC/Z5f/O8+WbIiVMYBGIp8F5GZmQwwhc4LhzDnqdj
	SN/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701264341; x=1701350741; bh=lD4Mj6HG3GJEv
	ukoHp1v6pteGLKfRcK2BW2YvFth6Es=; b=EkU5HiM6DUprb+5HI83BEYr1Dnwnr
	s63DRbEAY4jlY8bjh6QQjySSMdD5jph/pH64IzNRfWnkUHEX5y015Ubrgi2f7gjk
	uLNfkxUJSBWMluc6QaK86NPykkZcWtCYEhCKO3ql/3c9UioatCmrWvdYaMVT+ZwX
	YTVs+kSxOSwwRdYMUzfN2DnUYh1wsbHJ1l8DtQETn0gIrpPvw8Nco+Koxu+tqeQ7
	ks3K1azT1sqdSU1izBJ+xJS4APLwPBAkIZO6L1jvToUqrWKmYhtC3flYTiwgXxt/
	cA5KEVl3X6eb8BABqruBTi0aA5qNyk52jf98KRYabUty8nGuUBnq0kzDg==
X-ME-Sender: <xms:1TtnZfY8mfU961xuhV7RokBBjWGvqhcM9XCcntg6NiuXgBJizuwN4w>
    <xme:1TtnZeYUwg2yjSPoUIydOSdO2YAJukX16DljmAqqJGfLFgcEWDIl8xzlRembtaIst
    i4xJYvVabE4sj499A>
X-ME-Received: <xmr:1TtnZR_i0enzCb6dYeFkXTibCPeegIarTpIdBLot9rkPCtj7_decBnAmcBXJuzheOE9rEXQoyLRbke7NCikLuQx3vcDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefujghffffkgggtsehgtderredttddtnecuhfhrohhmpeetlhihshhs
    rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehhf
    dtffeuteeiffekjefggeegteekudeifeejueeiffdttdefvdfgveehtedukeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:1TtnZVqN_Lrfq0wcaLhvtVG_tyfV9br8WpnYpfv4XSiTY8y4GsLj_w>
    <xmx:1TtnZarPwhvaARCjKyR5qQbtH2t9GDUD-nfDwlwrKsK4Jxh53kOgpA>
    <xmx:1TtnZbTDIzYpNYlDIdCLcJnRoO3xGchpfOOiGcGGPWMgDTFuGnJ3tA>
    <xmx:1TtnZRSER5dKzRk2iJ6eiJg_Wo2aZUsgdf7h8FDdlpSkP-YFcr0vUw>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 08:25:40 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id D739661F2; Wed, 29 Nov 2023 14:25:38 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] loop/009: require --option of udevadm control
 command
In-Reply-To: <20231129113616.663934-1-shinichiro.kawasaki@wdc.com>
References: <20231129113616.663934-1-shinichiro.kawasaki@wdc.com>
Date: Wed, 29 Nov 2023 14:25:08 +0100
Message-ID: <87wmu0vgi3.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com> writes:

> The test case loop/009 calls udevadm control command with --ping option.
> When systemd version is prior to 241, udevadm control command does not
> support the option, and the test case fails. Check availability of the
> option to avoid the failure.
>
> Link: https://github.com/osandov/blktests/issues/129
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Alyssa Ross <hi@alyssa.is>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmVnO7QACgkQ+dvtSFmy
ccAmuA/6Azh2cNV5ZC9YRgoMlWwefCsPZgfwdxMlFfrarCrRivaOUY7QJvn7LKzx
7wFrhAT+D2lkyVlDR/72KLD3RSR/IYLuXe+0oMrGjm3GQuFWDI9V25PjpWe/dO5y
xTAQ7Ri31vai9Hk+F96gf6yEJFStmJPWM+tQW/xY2QU7zLPMNm5nU5moFyd8mEiR
Z/vNNuW4OO5xl4QDGa6JIVL4uz9XYw8Kgq0MCb3I3r1yghrpV+IMD7TKK5kDAGsq
uGqllMkCS3L6WHUjEmt9+B2rCZ8nfm/sgEDwRHMS+wYezsOlrBYtKPwhqJIc7sSw
vmTAi406coIC9lg97SEh58gkYK/d4hMT7grKlIWC5nJ6JGVZgdN0D6Eap1zKxF8m
JpRgustSIibJ2PZ1l031qiDH8wfv1TOzkDCP98BQs8hhUAH/6UOz8aKibSfUheRa
2iaNGlRN/6n9xZPEZ20h0v/m6jqzrT8xWDDPGR29TrIQUz3UOnEFNm87T1T5dX4e
rfIHG3SLrtquq1ZxVGPPgeQkyFQale43JLP0+D0PzY8jmqncnBMJ2+llztcVkd1U
DkLVUYffcKscE4vSvwSS0NphG4KXtSOluhX06AOUVFqjDUDCQTIDEibMR67xTjzc
0F7CilDquFO6ecTfvPZ3Ez4N+441gO8DubfpyjHfMrWtkPyyDd0=
=Y2zj
-----END PGP SIGNATURE-----
--=-=-=--
