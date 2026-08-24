Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981E40DB29;
	Mon, 24 Aug 2026 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574375; cv=none; b=t6sLYmHu4nzQC2xLXANzZMM1ZBsKrBiKdtOzSPxfE83sna1WwI6SUfo7cs/+BQiP5HzuGKhRBYIK9ChBkY36H9jv00nmOICQwqvMBxfTjy16L8HLxaf4UasGLCIkZREjRMTGJeNZgATBZbCT+3cousKUIw74hP2DpyNt3+dwQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574375; c=relaxed/simple;
	bh=XprHHe3lQdZ/bHHkrfW5U843BNmtX6D0fOYV/cPGdkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDxfDluJo72vt3/Ah1pOS94Sy6vol7MntYGOfrfLq9WGSPKpE0Zf58aTXliSd+oByGc/9NdUxIPmOxIKmhPfOvJJQHf4h7l+xuWHvRe9i4XkzHv0S0D2BRblIIxLTIEQHUjuLhRwnHM0ejVbwoc2N6QDqLkzfI/cpq9eclev2JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwNPX2NR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwNPX2NR"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 874ED1F000E9;
	Mon, 24 Aug 2026 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787574374;
	bh=upukaXZkr84gwak4ggRO0ndAK9t7zaBT3owzkfM3Fdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PwNPX2NRFVN0Bz+S6KhhJDxiLSSZueaI23ct1PXVX8KFblpux4F/bG76u6TxrwCtv
	 UBlSiGxKVvBTRYKxoEml8G+yJNr5LUcxCVHAJkkApNdp1pLMOe/M1VjBTgCXwU7U6V
	 5IgTBRfAEyOLQqvyJJiMl62FQy0LIfHZ1uydX9Y4AhNiRmTr2057vOspY1cC7nY6+Q
	 qZ3KAqtRYMVxL80qEDUwO6SUdJGBXEpXuEZNK6b9Z8cRlU4tajvzt2DKIM8cr4Vboc
	 q/Ct4jN9XMSxR0SxukEoUtbJdV8txAyM9aXphiu3NaGi6TMPM5g8mGMXa0XMTMt2gj
	 F9NjqiDJeK5BA==
Date: Mon, 24 Aug 2026 14:26:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Lyude Paul <lyude@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-usb@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v20 5/8] rust: rename `AlwaysRefCounted` to `RefCounted`.
Message-ID: <aow36NjRc5Ig0hG8@monoceros>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-5-490735672187@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nwuv4cl3v42iarkt"
Content-Disposition: inline
In-Reply-To: <20260824-unique-ref-v20-5-490735672187@kernel.org>


--nwuv4cl3v42iarkt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v20 5/8] rust: rename `AlwaysRefCounted` to `RefCounted`.
MIME-Version: 1.0

Hello,

On Mon, Aug 24, 2026 at 01:17:57PM +0200, Andreas Hindborg wrote:
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 6c9d667009ef7..2d1cd74dd98e1 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -13,7 +13,11 @@
>      devres,
>      error::{self, to_result},
>      prelude::*,
> -    sync::aref::{ARef, AlwaysRefCounted},
> +    sync::aref::{
> +        ARef,
> +        AlwaysRefCounted,
> +        RefCounted, //
> +    },
>      types::Opaque, //
>  };
>  use core::{
> @@ -629,7 +633,7 @@ pub fn new<'a>(
>  }
> =20
>  // SAFETY: Implements refcounting for `Chip` using the embedded `struct =
device`.
> -unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
> +unsafe impl<T: PwmOps> RefCounted for Chip<T> {
>      #[inline]
>      fn inc_ref(&self) {
>          // SAFETY: `self.0.get()` points to a valid `pwm_chip` because `=
self` exists.
> @@ -647,6 +651,10 @@ unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
>      }
>  }
> =20
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `=
ARef<Chip<T>>` from a
> +// `&Chip<T>`.
> +unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {}
> +
>  // SAFETY: `Chip` is a wrapper around `*mut bindings::pwm_chip`. The und=
erlying C
>  // structure's state is managed and synchronized by the kernel's device =
model
>  // and PWM core locking mechanisms. Therefore, it is safe to move the `C=
hip`

I don't understand that, but if this is considered ok by the Rust folks,
I'm fine with merging it via their tree.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org> # for pwm.rs

Best regards
Uwe

--nwuv4cl3v42iarkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqMOGEACgkQj4D7WH0S
/k7Eqwf+MmntLyABjsJ6u3n0tfvFXtT43FkhKWBYTvfrSkkGSwvZSD/ZY5rm4TJa
bXNvGj/meY+tjoiL+lqEl91gKDUE91djmvVcfXDoceliQzIKh2cKRqYubSng7etR
4cjqGN+2sGoPMqw/DE4AHSt6FjN7PW9atWXCHSqgj1X59q+Il9zzPvJoUf5LoJGl
M03B0IF/eZP8vEHvwBR+bKlVqdJnU8LD7vn7fYKS9w8EcXVmRNet0ARjs8XnIUhd
mRyFbmkqewycYxQaQdFwYsqkvc+ZdQfjXofOkRIorYXk2OXiZy3oqy94wwwiGntm
xaLKESdeyy1mp9Q0CzYXHqcQr8nU5Q==
=h9TM
-----END PGP SIGNATURE-----

--nwuv4cl3v42iarkt--
