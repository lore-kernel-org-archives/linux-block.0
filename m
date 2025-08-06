Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854E1E4AB;
	Wed,  6 Aug 2025 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754485557; cv=pass; b=M0oTumgt6r81fj67esihg0hRZ8BB8N2CK1VKJd3pNzEXw0RfKhvLKoRKP6im7zNE9CI5dmtpqKfA0x9WUgQk96ANKfHLlru06nM7zsG0BvmMX0wVBoctPU+SUNL7+4soiM69YB98PLM+dXCgiQX+n4KyZu2ekPWK8ip0dLlgxYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754485557; c=relaxed/simple;
	bh=KCi3QWUXdTFSX8eO5dvBRbPPiB+FxOKhdrzJ47NWJyM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Mxq25JC3mW1iDX17gy0APpUhLLdbECWrH+9tJ305ibpPTUtZvOJ2voBN3nkB2VH4PwJgUubYgkRI30NeMNiLGE9B2FBE6ETaERiXcotXyfqJwbwx5vTfruqoj6YOvcT+i/fPXBanwwgrI8TIPSvGTi4ouL8NFpYQ5TwaRGwg4SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=X2mPjNxH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="X2mPjNxH"
ARC-Seal: i=1; a=rsa-sha256; t=1754485539; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VuJ8LzEvSXcj2YseI/GgF9esaTPJECxyt6VF0fylyd6Enb0E3YLuh23ksr+7IM52t3b+06Ppk3SQfRjpR8+S26LCdMu+2EFxqFFlW1mqaS/3idAKWyaofLyw4ZF7tidtabQoR0wGR3lzY3HFlgJ/Y7v764MRrXR3PqsSN9L9uak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754485539; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/8UD+cB4J4VFNhxsPDFFhLfzWHUaeyWLBiVmS5SXZng=; 
	b=DZJiL25dWSHxlzOH/Ius/vpwJIhmhxtrb8QeiRoBif7eMg8VRZ1RG6vgl+jUg7X8rsV5hY7WnrgwZ3EtAgkF3AigzxTjD0MizBt9rP7q38EQ2k3VlT7ZoAv1QwAe7BzQOPrDCk2jWB5bbLRmlwLuYvN6Li8Yhk1CkOxdm4CwYps=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754485539;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=/8UD+cB4J4VFNhxsPDFFhLfzWHUaeyWLBiVmS5SXZng=;
	b=X2mPjNxHbdefisirHOyvHunleT8nM2isBGHU5cUxOanvYzuZBMSmBMw6mQznx+kc
	tdH8xbzqPCBunbUmMm2yp0TV9Dkm3A2LWBWYmAoFw42qn/1f2sqI6jT7ArY9GhNT1Df
	uXFUtjM7oKX6eiFvWO1UuOOb+RN3upPlm10u1uDo=
Received: by mx.zohomail.com with SMTPS id 1754485537501917.2930354698001;
	Wed, 6 Aug 2025 06:05:37 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 02/16] rust: str: allow `str::Formatter` to format into
 `&mut [u8]`.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250711-rnull-up-v6-16-v3-2-3a262b4e2921@kernel.org>
Date: Wed, 6 Aug 2025 10:05:22 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <37C6B308-202A-48A3-9DD2-5997E0EE73C1@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-2-3a262b4e2921@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Andreas,

> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Improve `Formatter` so that it can write to an array or slice buffer.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/str.rs | 19 ++++++++++++++-----
> 1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 488b0e97004e..41af456a46c8 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -6,6 +6,7 @@
> use crate::prelude::*;
> use core::{
>     fmt::{self, Write},
> +    marker::PhantomData,
>     ops::{self, Deref, DerefMut, Index},
> };
>=20
> @@ -794,9 +795,9 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
> /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
> ///
> /// Fails if callers attempt to write more than will fit in the =
buffer.
> -pub(crate) struct Formatter(RawFormatter);
> +pub(crate) struct Formatter<'a>(RawFormatter, PhantomData<&'a mut =
()>);
>=20
> -impl Formatter {
> +impl Formatter<'_> {
>     /// Creates a new instance of [`Formatter`] with the given buffer.
>     ///
>     /// # Safety
> @@ -805,11 +806,19 @@ impl Formatter {
>     /// for the lifetime of the returned [`Formatter`].
>     pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self =
{
>         // SAFETY: The safety requirements of this function satisfy =
those of the callee.
> -        Self(unsafe { RawFormatter::from_buffer(buf, len) })
> +        Self(unsafe { RawFormatter::from_buffer(buf, len) }, =
PhantomData)
> +    }
> +
> +    /// Create a new [`Self`] instance.
> +    #[expect(dead_code)]
> +    pub(crate) fn new<'a>(buffer: &'a mut [u8]) -> Formatter<'a> {

nit: the function above this one returns Self, and this one returns =
Formatter.
Perhaps this one should also return Self for consistency?
=20
> +        // SAFETY: `buffer` is valid for writes for the entire length =
for
> +        // the lifetime of `Self`.
> +        unsafe { Formatter::from_buffer(buffer.as_mut_ptr(), =
buffer.len()) }
>     }
> }
>=20
> -impl Deref for Formatter {
> +impl Deref for Formatter<'_> {
>     type Target =3D RawFormatter;
>=20
>     fn deref(&self) -> &Self::Target {
> @@ -817,7 +826,7 @@ fn deref(&self) -> &Self::Target {
>     }
> }
>=20
> -impl fmt::Write for Formatter {
> +impl fmt::Write for Formatter<'_> {
>     fn write_str(&mut self, s: &str) -> fmt::Result {
>         self.0.write_str(s)?;
>=20
>=20
> --=20
> 2.47.2
>=20
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

