Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CE310771;
	Wed, 27 Aug 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298932; cv=pass; b=g36xiNy2oiW0daN6mQMV0oxXAixtZct5w+M0qu3xk90XoWKWyjVsb5wxRICWssuAfyWIKtx+ykGg9tqKxqw4wK5OyL/Pr9ZZcf2RHGVRMq3mPAXyPZ2Y7KQStcvUaO5vU13d3w9ZhzsMCfm3wEscl48m6axrZ8vTu0DIySnAWzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298932; c=relaxed/simple;
	bh=31hIjKQ/zjhu2n+CFFCFiGW6y+65cQUIGZzQqWnbY7I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=StrhlLRjZmVMuLQs4t1uPKJuUASXrSCiD7eistUhKB+OHZBG6EeJtedTsoX2UmS3zLQ5QweW50l1RzfjPanrzW3ypQvXV8VvCey4WP/Pq+qxsg9Vpul6meFnbidZ+O/zWk1O+eib3L5TtL54RWCmM7QnSQyK7a+mjDwjm7b0fxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=L05u85Bs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="L05u85Bs"
ARC-Seal: i=1; a=rsa-sha256; t=1756298906; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gZL9VUZa74/oP0SnAL2gTXAZzEBAp4+Yorvae7L0x+uT8lTPSOgS3OLT6lcYW70GpwlRZT3/Vm7W0u/lGwnxi9yUT696dvytEUqjeRdrjdH1AT/7jkLFoMSOLCtUmQz0kraf2Qt8gFOy4IWCSAd4LjkALSLluS9HJUdYm/3ApB4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756298906; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Gc191LuFU32lcvz2MnWXW9WYGgJS1pdEE7MQNrFuzAA=; 
	b=R/FHGXYkr/DHaOL5fJOX44/0CNWCMXokIOurbNnHYofHoTDpsTw42KpmU3Biuq1WcwP8MIQsDkL6uX2HccYtL2QskwZI4zIYAI8OUMQwipeHsBwnS9fvpZg/+nyT47+R0xiHAX4iyKUBTTEA02YxX6Z46aEy32oCRNDO2h0emPE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756298906;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Gc191LuFU32lcvz2MnWXW9WYGgJS1pdEE7MQNrFuzAA=;
	b=L05u85BszANqPlAVfgog0mBmGlHF5GJxfbuue9Kg76wClN9haTKPii45yreps5AF
	Hhxr1csqpRnwpgT2IXAUnMPUyXqReiox77GesocPv7BDKaefRVaBGzCoKJifrsC1RqD
	7AiHwE2oH94FOUk/zw4r8pMgTX4c446ErQh0p3Sc=
Received: by mx.zohomail.com with SMTPS id 1756298904105933.1929820169668;
	Wed, 27 Aug 2025 05:48:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5 02/18] rust: str: allow `str::Formatter` to format into
 `&mut [u8]`.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250815-rnull-up-v6-16-v5-2-581453124c15@kernel.org>
Date: Wed, 27 Aug 2025 09:48:08 -0300
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
 Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <15990453-889F-40C3-863D-DB41306E2A84@collabora.com>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
 <20250815-rnull-up-v6-16-v5-2-581453124c15@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Andreas,

> On 15 Aug 2025, at 04:30, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Improve `Formatter` so that it can write to an array or slice buffer.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/str.rs | 23 +++++++++++++++++------
> 1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 082790b7a621..76632da357a6 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -7,7 +7,10 @@
>     fmt::{self, Write},
>     prelude::*,
> };
> -use core::ops::{self, Deref, DerefMut, Index};
> +use core::{
> +    marker::PhantomData,
> +    ops::{self, Deref, DerefMut, Index},
> +};
>=20
> /// Byte string without UTF-8 validity guarantee.
> #[repr(transparent)]
> @@ -825,9 +828,9 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
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
> @@ -836,11 +839,19 @@ impl Formatter {
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
> +    pub(crate) fn new(buffer: &mut [u8]) -> Self {
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
> @@ -848,7 +859,7 @@ fn deref(&self) -> &Self::Target {
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

I gave my r-b on v3 for this patch IIRC. What happened?

=E2=80=94 Daniel=20

