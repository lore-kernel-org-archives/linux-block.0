Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA734F460;
	Wed, 27 Aug 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299458; cv=pass; b=c8PbPcNxIuLzaWCTbCUP6ESqNL0Zlk4GE/VbhahB2mhebZnJdPGKalFuxqxJERuWnajQTf+Xh5RBGX6CmQtpo/B1P1wwnxr9iPsACGxKOPIruFQ0iCHtpJwOxuRpR6mmpomz5CqehRM5AEVGLILldzV5BQtzL3b5/q3nl+2sz90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299458; c=relaxed/simple;
	bh=0tZwsEhvVfINeSrzNwAK20C21UhsIWH/xKwWkL2QV98=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UJmPsh5W6mAku+KTwARlrgseFEEcG1o6eL8n2nZQQsyv21iBohJyt6UgnM6k3xikTtYT88rWeFF/NhWjTVkZAjo5PIP8jqtsyzZt/4fWTt+n8VlIw6kCxGwZLDQdz+cP/pWLC0aWASO5kxwFhY0mDfg0w3VF5ByCKfTmglVXujk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=PfIJ3SQE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="PfIJ3SQE"
ARC-Seal: i=1; a=rsa-sha256; t=1756299438; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Yy9IJ7a0PxcctuHsQVaegohpte20rDHnIBj3HgOjcVZ9XxH+DP9TRv19yeXK5Z3PM5dxW7Vvv10gLQD8+3B4/Xm2KKdks0wWBLIX/XHyC5z+i9dExEcJfSerxLDWwjRFNz/yYIqdOAQqraHn+DJMqag+3vLoZs6tFZKtUgN9WHI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756299438; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jm/4Sf2MNGI+5Yud7iMXOIJgAR0oZfJOIBx4WQ6IQeY=; 
	b=gSPQQCabvc9vmoLqc6IaHnBuG6dh+gpfjm4aMQGxm08KhAb23hDHir2pwtXv3Ok9DkDXl3hknDVN1CD9e8CgDxxm0f877O4FTDF3FPFaFJnJ3G/8Hi2aG+Gz9CbbNkqwA3LU3zt5Ty8W50WiNjNr1c/BmqG8CN5xkINHpDA8DsE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756299438;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=jm/4Sf2MNGI+5Yud7iMXOIJgAR0oZfJOIBx4WQ6IQeY=;
	b=PfIJ3SQEMehAwHw9wOcxdRVpHaZ3r+zxlw8eCgjShzvNs84aoSi9jL8JQEr1g2PE
	DsVGK2a71mLATZpUw9PJxwkORGJSwoJDpJT5TYo41kDeIasTUsAo116d/RjSVPlEbZ8
	BEq7VSimCLv8w5VMLtJTaB5giJmhg76Ha6zAqCqk=
Received: by mx.zohomail.com with SMTPS id 17562994374067.121301397573006;
	Wed, 27 Aug 2025 05:57:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 03/18] rust: str: expose `str::{Formatter,
 RawFormatter}` publicly.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-3-ec65006e2f07@kernel.org>
Date: Wed, 27 Aug 2025 09:57:01 -0300
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
Message-Id: <9CF6F978-0D2C-4370-9F70-F52B2B42167E@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-3-ec65006e2f07@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> rnull is going to make use of `str::Formatter` and =
`str::RawFormatter`, so
> expose them with public visibility.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/str.rs | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 76632da357a6..46cdc85dad63 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -736,7 +736,7 @@ fn test_bstr_debug() -> Result {
> ///
> /// The memory region between `pos` (inclusive) and `end` (exclusive) =
is valid for writes if `pos`
> /// is less than `end`.
> -pub(crate) struct RawFormatter {
> +pub struct RawFormatter {
>     // Use `usize` to use `saturating_*` functions.
>     beg: usize,
>     pos: usize,
> @@ -794,7 +794,7 @@ pub(crate) fn pos(&self) -> *mut u8 {
>     }
>=20
>     /// Returns the number of bytes written to the formatter.
> -    pub(crate) fn bytes_written(&self) -> usize {
> +    pub fn bytes_written(&self) -> usize {
>         self.pos - self.beg
>     }
> }
> @@ -828,7 +828,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
> /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
> ///
> /// Fails if callers attempt to write more than will fit in the =
buffer.
> -pub(crate) struct Formatter<'a>(RawFormatter, PhantomData<&'a mut =
()>);
> +pub struct Formatter<'a>(RawFormatter, PhantomData<&'a mut ()>);
>=20
> impl Formatter<'_> {
>     /// Creates a new instance of [`Formatter`] with the given buffer.
> @@ -843,8 +843,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, =
len: usize) -> Self {
>     }
>=20
>     /// Create a new [`Self`] instance.
> -    #[expect(dead_code)]
> -    pub(crate) fn new(buffer: &mut [u8]) -> Self {
> +    pub fn new(buffer: &mut [u8]) -> Self {
>         // SAFETY: `buffer` is valid for writes for the entire length =
for
>         // the lifetime of `Self`.
>         unsafe { Formatter::from_buffer(buffer.as_mut_ptr(), =
buffer.len()) }
>=20
> --=20
> 2.47.2
>=20
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

