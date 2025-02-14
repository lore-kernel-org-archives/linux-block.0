Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC96186E40;
	Fri, 14 Feb 2025 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528482; cv=none; b=NB5UG6Ah4kWeJlvbueR5DYk8sOHKziKcHgxlablmNmrms5mOo7TyaTjOyXtl6/EOD3rJOm/ekB/s6SXzbJj7vGZoBYJKds1npGjpYb+QK7BeODHUFaHGcET6hejehQT2OK/jXoBZNgN5OT6d/blll3zMfdVRaSTfPzWgxTipVXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528482; c=relaxed/simple;
	bh=98bEcXt55JROtyXwYi0Clj3GjYvpLWLviZsQlMud2Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTaTLpbdKjl8E5tq614BW7TcKINgIwQboYICe0EYWuX+Q1kfANCxDVdfbZmozzYuZy8B/YvBdgVicvV6O3XQnNQfrEeDOW5rrpXcocBz0PhFGFbQLR0UUaup70l7L6r3zi2z3D5WfkRrBOiL51NBxYpuVmR3ll+KBsKOeEzDJkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX8bqgGN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX8bqgGN"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c2a87378so26356575ad.1;
        Fri, 14 Feb 2025 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739528480; x=1740133280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98bEcXt55JROtyXwYi0Clj3GjYvpLWLviZsQlMud2Q8=;
        b=SX8bqgGN56Z0MHWh+OG0I9bDighbCK30hAr6QM6nxyQ0nF1etVNxWK0KkDZrJzfIqA
         kbFCic++Deg38CS5oX31bHxOI31Qwv6MiPNNzYXk9+IG6K2wCvs8GcTvXXooA5dy88jH
         WaQzhrEcu7+kNziOnkF/WeNUdmdsuR6yUAomnmicapLnp8Z6qa5fm53FOirh7sC4leeG
         N8fLticw7AquIVBsmMPRzvxADf3hVHyoa1Ab36ojyP6mCondaT1/rvZ7b3c9UsTDhUCh
         GSODj7NiJb84mW9Orz4xfEbm1StyhBmmUwFemxRZzkQvBa02snfbLXGAGXWQGy2Vglxn
         EvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528480; x=1740133280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98bEcXt55JROtyXwYi0Clj3GjYvpLWLviZsQlMud2Q8=;
        b=OK4DpqqDJ85CNv1WKPST3vXGwIFskH57tFfN/RB170CA4pXNAktLWXp8nJGiMAcq/A
         AfGelgxjY1emT71ojdibM0GmHDnyhLdT+uqIoKIC3YuJO/F7EIVNWxc8PXla65jXxB9U
         e25BrLHfnQGaPOf5sY9bEWkRH28uFz195lwL7/YUMmdiRjFlYXTx0HcpTD3KSnhdQItQ
         ig5PPBEjTrceR/mlsmkZngB3qauuwIidRHMlunzp4/8siidv6UMhyyUkipkz0GJqZ5Bv
         45H2lDvdXWDlQtL6TAwR0Y9lZBV4uxzlklbcB5mKYkWPKAwhlcNxlTU/sT7sCpnC4BBU
         EXig==
X-Forwarded-Encrypted: i=1; AJvYcCVFpt+AdBDn1aV64vw0PBfr7pQvNGPceea+BrQRY5Peo0x4FGP5kkZAUA9sVhL3/OdOr0RMmKXU0XBz+Thn@vger.kernel.org, AJvYcCWYwtIPqY7zTs0pFxqhUZnx10GZGWm/qsxO0O4HDsfzjrHsTOtii41JpfQEeQiT4pUpYnC2wlbqVYDpkg==@vger.kernel.org, AJvYcCXd/7kcmMWGo5BMywA+9HpMhwEJFZZ6YY6Q05ESJ84O2oLP10kXhAqEZ/iDguw1X/4JhBnLjuqPV2gP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Al9kKt0DPevF0ndypygZ0e804u6PjN0gzz52X13Z8EUOg7bh
	zmJiQTo/EGLtnsLN5HBQeuR3neVxRuzsJ46SjgraEL5fKDngTqIu
X-Gm-Gg: ASbGncs3hbDfOs5Jb/ba7OJKOKLQh8+CmqdD2d8lztAhhQ8853g/TfIVzamwD6hpHdV
	hjVapjIv1CmbMgpZ6qFDyEzMcyMBZzcLidYzfO1S8dOp/Le/zsGJH/aZRjUilSSpCCHOAOwdZXc
	31gI2D08DzT7iaDG7cXgY47yfbwrvwd5a9YsXt9HsH8/XYxOq0/QxxGqg0Qe9UWd1SsNZfz6/6o
	6wUn6Yjxpniouorybn+B2HoKUYseDd/zfAjjsrSICoG/fbyGu7d708EUKj1hP55pK/oM9V0uu9u
	aR1YbqqOOkNWUYo=
X-Google-Smtp-Source: AGHT+IG3+qZaSiHpaHbI9CGgZo0hVH86ou68xbLrXQUaLYwXucayzZThjm1qU61E9hPWS6jIb2pumg==
X-Received: by 2002:a17:902:f601:b0:21f:4144:a06f with SMTP id d9443c01a7336-220bbad659cmr159045815ad.13.1739528480240;
        Fri, 14 Feb 2025 02:21:20 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53674b1sm26272255ad.98.2025.02.14.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 02:21:19 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 46C2C41F5559; Fri, 14 Feb 2025 17:21:15 +0700 (WIB)
Date: Fri, 14 Feb 2025 17:21:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: David Reaver <me@davidreaver.com>, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Konstantin Khlebnikov <koct9i@gmail.com>,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: iostats: Rewrite intro, remove outdated formats
Message-ID: <Z68ZG3fhdZBO55BL@archie.me>
References: <0e8c8ead-423a-45f3-9e10-020334ef8907@infradead.org>
 <20250214051432.207630-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y5OXxCA580JKTHBE"
Content-Disposition: inline
In-Reply-To: <20250214051432.207630-1-me@davidreaver.com>


--y5OXxCA580JKTHBE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 09:14:30PM -0800, David Reaver wrote:
> The discussion of file formats for very old kernel versions obscured the
> key information in this document. Additionally, the introduction was
> missing a discussion of flush fields added in b6866318657 ("block: add
> iostat counters for flush requests") [1].
>=20
> Rewrite the introduction to discuss only the current kernel's disk I/O st=
at
> file formats. Also, clean up wording to be more concise.
>=20
> Link: https://lore.kernel.org/lkml/157433282607.7928.5202409984272248322.=
stgit@buzz/T/ [1]
>=20
> Signed-off-by: David Reaver <me@davidreaver.com>
> ---
>=20
> Thanks for the encouragement Randy. Here is a rewrite of the intro.
>=20
> This patch is mutually exclusive with the original patch I started this
> thread with. Let me know if I should submit it as a standalone thread.
> (I'm fairly new to contributing to the kernel.)

This is [PATCH v2] so the next version should be [PATCH v3] (sent as
separate thread).

> +All fields are cumulative, monotonic counters that start at zero at
> +boot, except for field 9, which resets to zero as I/Os complete. Other
> +fields only increase unless they overflow and wrap. Wrapping may occur
> +on long-running or high-load systems, so applications should handle this
> +properly. Field types are either 32-bit unsigned integers or unsigned
> +longs, which may be 32-bit or 64-bit depending on the architecture. As
> +long as observations are taken at reasonable intervals, wraparounds
> +should be rare.

So on x86_64 the field type is 32-bit-sized (u32) instead of u64, right?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--y5OXxCA580JKTHBE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ68ZFQAKCRD2uYlJVVFO
o1Q1AP95wTYuUIgYojC9SI7moGLvJ2f9NNWPcaSbEyTX4OiU8gEAk0iSZLlEHgq+
xnk3psu5TvFTUAuHWU9TjnngTW+bTgw=
=cw4e
-----END PGP SIGNATURE-----

--y5OXxCA580JKTHBE--
