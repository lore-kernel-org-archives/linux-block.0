Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182075;
	b=mJiIVFkZAdmhpwGLpFBuHcuv9pyx1CdC48eF3u0dOf6wBrya2DYqL6eXx41wfK+qGDJ4
	 yRHYUWUOYBVKMqoS1HfDk/QD8vrchxoEwMVKR8xqQtkU/NGeHV8gxMXeDotd8pyefhd93
	 ErJg6aB1zNNP7GMfKQQArxpdEnVl8jC8AGHm92tsyjfDgNZrnzZjiPMPbbGBTGD5xkz2L
	 +uMB0GoHiLcjRb24earNj5N7ta8mWLEs+2fZM/ZPj/aoKTbvX4P5ZIHFnFjgLhtv6Kql5
	 P1alJQZAb/CDHffHFnHqKWs5cX/yMifQcn3Nn5GPy617SLtfalWsLDW8P/YtLqIanMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182075;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=YW4oRhO1MuXRHyeWQ9Lx5ixnye7cuXD9in5rMS24y2A=;
	b=gTlPgdbzb/5Gfv3hXIbgMWvII/zu+pAm/Xy76ZXtUvQTQ1mL4q+xuUWvnEHfCkHDs8Ry
	 Y63Y8k0Fa/C7dA8o/6Tk8ITLnsBN+/91buxuB+aW6gvgopFJVcuBDGn9S++YE8A8HMqzq
	 S+vJ1sFsCF8Oy8CcFT4BpaiEBCYPE4F4LA/sTwN5a0ZrQfmNas9ojtLZ4SdlJPUisro2f
	 vsf4mAFw6OL5roNy/enfNivr55Zr45gq5ZHL1ZShQkrIUkhEexwxKafHC3HssxPe9rAeI
	 k0qyeqolbMfvftH9bUoqEWLOEe3HduLqfhl2iu3muqP9vngUlyu+s7866BrgJmpUmbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=hWh+t93A;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536D606A339
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 13:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A536D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=hWh+t93A
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1E6B1240101
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 14:41:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1795182067;
	bh=YW4oRhO1MuXRHyeWQ9Lx5ixnye7cuXD9in5rMS24y2A=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=hWh+t93AQ89D3y7Q9jrCyuBHB12xO/fjpp2KbQYXJeT2L3X6wH/D4DMbcDgYcqtgT
	 pePRFyBthjOtirmgOI5czcXW1Xr1VnxH6GfasweXjJm4J9Mm4Hw+mn7yRccYA1M89r
	 ckxYsVMo6pN37AZxMbKEL4i2LBGKnzK6/RJiaHheArZW644ZeQGqGoyhhM2h3T4JFH
	 Dk2Hxfv0uSl3GCmBxQb7acaV1ilGCR5zeH72IlA7Ii3mLlwUcevf0AERKWuKOWgNhS
	 bpETuEoWTvJyWgDofyUyxOmTRbCQ1514fODehAyVg1kPoYini/8kpChbhDu6bw685P
	 5EShivwIQiQoA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jWGgr36MZz6tyT;
	Fri, 20 Nov 2026 14:40:56 +0100 (CET)
Message-ID: <e4c77581b1c09f8e0c8be570283f653a2a7e2147.camel@posteo.de>
Subject: Re: [PATCH v22 4/5] rust: rename `AlwaysRefCounted` to `RefCounted`
From: Markus Probst <markus.probst@posteo.de>
To: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>,  Lorenzo Stoakes	 <ljs@kernel.org>, Vlastimil Babka
 <vbabka@kernel.org>, "Liam R. Howlett"	 <liam@infradead.org>, Uladzislau
 Rezki <urezki@gmail.com>, Miguel Ojeda	 <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron	 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl	 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Lyude Paul	
 <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Christian Brauner	 <brauner@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Dave Ertman	 <david.m.ertman@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore	 <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, David Airlie	 <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Alexander Viro	 <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Igor Korotin	 <igor.korotin@linux.dev>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon	 <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,  Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>,  Michal Wilczynski <m.wilczynski@samsung.com>,
 Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?ISO-8859-1?Q?Hellstr=F6m?=	 <thomas.hellstrom@linux.intel.com>,
 Johan Hovold <johan@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,  Dave Jiang
 <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed
 <saeedm@nvidia.com>,  Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 driver-core@lists.linux.dev, 	linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, 	dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, 	linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-serial@vger.kernel.org, Oliver
 Mangold	 <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>,
 Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>
Date: Fri, 20 Nov 2026 13:41:05 +0000
In-Reply-To: <20261116-unique-ref-v22-4-12029383206d@kernel.org>
References: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
	 <20261116-unique-ref-v22-4-12029383206d@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-1bC6az0UrhT7nf2a398O"
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-1bC6az0UrhT7nf2a398O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-11-16 at 15:21 +0100, Andreas Hindborg wrote:
> From: Oliver Mangold <oliver.mangold@pm.me>
>=20
> There are types where it may both be reference counted in some cases and
> owned in others. For such types, obtaining an `ARef<T>` from a `&T` may b=
e
> unsound, as it allows creation of an `ARef<T>` from a `&Owned<T>`.
>=20
> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
> would require) and a marker trait to indicate that the `&T` -> `ARef<T>`
> conversion is sound for the type. A type that implements `Ownable` may
> only implement the marker trait if it allows an `ARef<T>` to exist
> together with an `Owned<T>`.
>=20
> - Rename `AlwaysRefCounted` to `RefCounted`.
> - Add a new unsafe trait `AlwaysRefCounted`.
> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>   `RefCounted` implementations. This leaves functionality of existing
>   implementers of `AlwaysRefCounted` intact.
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Updated commit message, rebased on v7.4-rc2, converted new
>   implementers, relaxed the `ForeignOwnable` bound for `ARef<T>`, updated
>   safety comments. ]
> Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org> # for pwm.rs

I haven't unterstood yet what use case this has, so I am trusting the
other ACKs here. Maybe a precise example would help?

For serdev:

Acked-by: Markus Probst <markus.probst@posteo.de>

Thanks
- Markus Probst

--=-1bC6az0UrhT7nf2a398O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmsATecbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSANQP/R1hB8C5F3mypETYwCgo
/31OX6ODiCHu568feU0OwqqnH1gKua6thOPxdUzO4oz9uHEvJOy9k0pAUuqhIoUR
cwWGFajvqbq0iEcbMMls3ezTo63QhALeYKpaK+p4wCU6HqazGDnsTiqXqIBnSMFF
/zhMCLHxApAYueLhRzmTe9z4DIEhOaUdcOowPIV35HlxhghSQZ/uaZclBwv6h+xn
PDpQAKnR2JxW4CcyT1Fm62hItTX+Djvef/Q6aac3xdMq1JSPlsbNUlThWsY+EjbX
eBTAO766WENw3Hw3SxnX/pcUQwUVsRa3bxxgBxSfwZtm6nSfhxmBzAHsiR7aA4wq
hrI46P32JW6WcL+jToQJC/QjQienV9rV/QTWrfp83Z59ce3lL43XtMlofu0EoK6W
IWoX/O4IoSM3YDlzHsSYGQR7KG+VGDXyJAb6HhVyNdMTiegz8UxWwYqGviS9mTON
a3YA8htdMngXmkwT5CQKhsNbS0sLqGb3nDrqmLV2hSDpjGkdUe86bahObcVCXonf
7Gdl1/15c46K0QRbEf7q5kgreejRoLqFdi2eyw406ruUxE7Bd71t9faF5zWzaJRK
ewr2s+IremZr522ABFhIX0SFkqu1sPzXqNLKXQa5fz5XxTh6jQziddGf3Q2z71dB
79I2PETkcl5NqkNBz+UkmsCH
=iSw7
-----END PGP SIGNATURE-----

--=-1bC6az0UrhT7nf2a398O--
