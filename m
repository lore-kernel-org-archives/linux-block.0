Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A937F756
	for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667815; cv=none; b=Mw8uKKYAUrFY6nQkmnX3bdoosvpraJAFkhXZP0cUwL7xp0Ap2T94pdv5x1ZvnSeLtfb4Ua18stODA53K2B4rhYKEgVo8zMgxjsS3Q2wkwZXKA22gXqrc3YkoiBdkq6sl62S0j4GtKshYETy6OM65QqpjFAw5fiXqRlyWxkGl/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667815; c=relaxed/simple;
	bh=qnf3n9wyxlChcCU/YLKs0a5UVUATRTgA0H0pegWNekk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RFmTpI9UoelEGdR8jTOTdbrb2474zDo5w4EQ7PqDa8H9BYfQwrGZYepg3a8swylVEMGzl27CggQPUiBq9hOAnffxqi1O7VV6SWrfPP9wFsyEbpI8I+Hp68VMwBZysWniPLcJI9tUdhYGz8oNRRxvB0vFDQU/cMwcPyEMt4t9Dpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=gwFJZhJ/; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gwFJZhJ/"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4CD6E240109
	for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 23:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1791667805;
	bh=FIZTJarmEMl9c5iXOULTJ42/zJwSg63EOt6lkAAMvq0=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=gwFJZhJ/TLw8VA/OIcE96irCASguD4uxDlrUu3bMA6g2iSLfLRQlAai3Oeym0YI9G
	 0huqcrwysUEVvb3ImBycSpcdKvjdN+cj48jkcplSGWk4tLVMWrHBQTpE5nhZH/sQ8r
	 90NXoeSRCFGdGiGiUTm2tdfKDj1wHROepFZoKUb5nPUaLlfugwQ3JjwQ3oq3Z54a41
	 usJMYeTVSqjtLavs/W2Th9+BKXpTQUGX1YCD1wppPaSFaVVjUslUBQ3tyXuotJX8O0
	 WaqYv0h+wYvYWJgWSb02TGVHJ4Pld3gZIL0kEAEwgqHu6vSiYNY8hHRDRgv0vH9Y7R
	 t9qXFW5NUj8gw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j2H225HY9z9rxG;
	Sat, 10 Oct 2026 23:30:02 +0200 (CEST)
Message-ID: <19c329dfc42ac74b8ca7ce9a4b0f3f58b5a57fec.camel@posteo.de>
Subject: Re: [PATCH 3/4] rust: serdev: use DropGuard
From: Markus Probst <markus.probst@posteo.de>
To: Mohamed Osama <mohamed.osama189110@gmail.com>, ojeda@kernel.org
Cc: boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, 	dakr@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, 	acourbot@nvidia.com, work@onurozkan.dev,
 longman@redhat.com, lyude@redhat.com, 	linux-block@vger.kernel.org,
 linux-serial@vger.kernel.org, 	rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 21:30:04 +0000
In-Reply-To: <20260927104528.103881-4-mohamed.osama189110@gmail.com>
References: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
	 <20260927104528.103881-4-mohamed.osama189110@gmail.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-simdDc3OGeSWpjkCLlpO"
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-simdDc3OGeSWpjkCLlpO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-09-27 at 13:45 +0300, Mohamed Osama wrote:
> Replace the ScopeGuard usage in the serial device bus implementation
> with DropGuard.
>=20
> Use DropGuard::dismiss() when ownership of the private data needs to be
> transferred without running the cleanup callback.
>=20
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>
> ---
>  rust/kernel/serdev.rs | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d..dd43b159b461 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -13,6 +13,7 @@
>          to_result,
>          VTABLE_DEFAULT_ERROR, //
>      },
> +    mem::DropGuard,
>      new_mutex,
>      of,
>      prelude::*,
> @@ -21,10 +22,7 @@
>          Mutex, //
>      },
>      time::Jiffies,
> -    types::{
> -        Opaque,
> -        ScopeGuard, //
> -    }, //
> +    types::Opaque, //
>  };
> =20
>  use core::{
> @@ -174,7 +172,7 @@ extern "C" fn probe_callback(sdev: *mut bindings::ser=
dev_device) -> kernel::ffi:
>              }))?;
>              // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
>              let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::=
<PrivateData<'_, T>>() };
> -            let private_data =3D ScopeGuard::new_with_data(private_data,=
 |_| {
> +            let private_data =3D DropGuard::new(private_data, |_| {
>                  // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
>                  drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData=
<'_, T>>() });
>              });
> @@ -204,7 +202,7 @@ extern "C" fn probe_callback(sdev: *mut bindings::ser=
dev_device) -> kernel::ffi:
>              drop(active);
> =20
>              result.map(|()| {
> -                private_data.dismiss();
> +                DropGuard::dismiss(private_data);
>                  0
>              })
>          })
I am surprised to not find myself on CC. I only look loosly on the
linux-serial mailing list, so please add me to CC.

This patch will be redundant once
https://lore.kernel.org/linux-serial/20260930-rust_serdev_probe_refactor-v3=
-4-d1b6e77135e0@posteo.de/
get merged. Not sure if it gets merged this cycle though.

Also I am not sure on which base this should be applied to?
Applying to v7.3-rc6 or next-20261009 fails.

Thanks
- Markus Probst





--=-simdDc3OGeSWpjkCLlpO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrKrlUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS4QoQAJ/QIogQcyaZzAXoAcVG
uUr3FbSLJeeTiJho9T4R7my8eKqZeyC4WlraQenkU2KKqciJEfZ+ZMl3UV4Xb2e9
fjIUTk5PqLxmadXMCzd0MefixlOerMba2FoFvsym9KB716cC5ngZNxvzbOqlIPAj
wePO/PztJPG8eFO4G7/odXdWnoDglVlzkBmzZpvSLhghYQaijqzqU8HPYpAetBtB
vX17Kz5t7ScSwOviW8pW0Gx2xBTrVomZ7R4R+b7S1cwXcTI6qkOi/FFA12jkeyEb
wqBTXUFkeWEH4y9/AOagc4HC/ct9ufs8ghS/7FdDsCVrP2mid8265OoGowiXMMUJ
dU64Te2FOsTD9+EnRHPjich5ynSCFCjY2q/+AjMDG+mPkMffo4J8txJNLZi7jd3N
mco2MDNhnLgQvDQBcJL5HQC/NY78ZmaQFLoagFN2767oQhDRpmHShs+8JG3ZvjrY
L2dg3kcqh6YJ4Jsn6mlTktg6dHEMwfE1v+H+LUpiCbeJxyZNPhj2J+H0rNqV8IbW
gNIPY3jXl1AEreUZJ6/wbLNXJ3rRE7HRILS88Yecd3k0msNkNWoWrTrzYhpba8OK
tU7Cz79z2xcusa7vpPsNH8gnvoEdbgdDuueprNyY9DgttjJtaeXUwNYL6QciSKZF
uVQ6CNbQ4vhjPdo+kCmpJbLW
=n5QZ
-----END PGP SIGNATURE-----

--=-simdDc3OGeSWpjkCLlpO--
