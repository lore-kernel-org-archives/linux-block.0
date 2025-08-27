Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8989302760;
	Wed, 27 Aug 2025 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302693; cv=pass; b=Q3XjQP3MSe+6GScPmsT/omrpMz1lLFk9S9MLBe9zbd5/bDYZA4yzzhWUqh9F/cGHXblX3WeP/ObNp1s8UHfoGP7L/6TDAetyYeLbVGKYnMuW7R1fdo+JBZURe/GrxxTQKg8mxDtDKDkxQG4bioyoDowfK9uop7HUs16WZzCQitU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302693; c=relaxed/simple;
	bh=dpx+34T0+fZYkD6nLJf/61+zs/Qi67xKeRs8hN0+VPA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JWnbPAD8zkZSgZGg/DAtzd1wfkoBOuA+zzEpsTnT1tVGokiJD4ChJ4rLuar6xXeIsywXGwymZejBt820IANrpfxMRNpyyvmPUxaArSjLFfnNH3LYtAmPybWhA4c9Cd9p1Rpm48UsIvWj0GpV+/8XWJAez2u0/2LBezVqqUzLFhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AHMcxDmJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AHMcxDmJ"
ARC-Seal: i=1; a=rsa-sha256; t=1756302673; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QAXGvRVHHe5QDnlNjnzorWJGhYtShm8DkXSQyeZgi8VlCUcwDkaDrvFiT2dCkka1oB2e+aDDn5HxVww+8ZUKvpbx9gTRwm8sgkq6Jl1gaQGDLG8viXWjtvJFsX78hlyob2pz2gCaFAbvUx/yoqnpaAKymW12kt3w2WWJOUjFmhM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756302673; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r87d2Cvfv+EDJTx1X2oLOP11FqHTagC0pyB7B8rLf/I=; 
	b=iLu3geV1YZ3/ECNE7c+DXKxRNhDFLDQbVLia+SKyuj0iRVGbsb9FFkySXwvoI3pSkdIwZj2Y8UvvgPbWzLIERnKqOKDYnaxYKiBUK6wPCeX3P3ufViFmGQThy9t651/po85ohg5uhfY6pOJX+hxx50GenLHyvcgxYOk8XwkTRIw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756302673;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=r87d2Cvfv+EDJTx1X2oLOP11FqHTagC0pyB7B8rLf/I=;
	b=AHMcxDmJW1Adv9BXTlQqPTy/OYKFc8fCJJKsAPuzX3Pkk81BMHG4OXozbgCwf4VD
	+nrlXcgD/8yIOkQRLRDzwbUKvd/Spbur0/9fvZXTo06ApV9LrChf4dxGr5tzgF3c0SS
	wHv/TnbMq9ybNjLB0MFEO/fH7cdriLpA+lTFxuzw=
Received: by mx.zohomail.com with SMTPS id 1756302671144595.2863081348415;
	Wed, 27 Aug 2025 06:51:11 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 09/18] rust: block: use `NullTerminatedFormatter`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-9-ec65006e2f07@kernel.org>
Date: Wed, 27 Aug 2025 10:50:55 -0300
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
Message-Id: <511180A3-DC0B-40B6-994E-AC8A7A7F6EF3@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-9-ec65006e2f07@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Use the new `NullTerminatedFormatter` to write the name of a `GenDisk` =
to
> the name buffer. This new formatter automatically adds a trailing null
> marker after the written characters, so we don't need to append that =
at the
> call site any longer.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/block/mq/gen_disk.rs   | 12 +++++++-----
> rust/kernel/block/mq/raw_writer.rs |  1 +
> rust/kernel/str.rs                 |  1 -
> 3 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/rust/kernel/block/mq/gen_disk.rs =
b/rust/kernel/block/mq/gen_disk.rs
> index 679ee1bb2195..20f1d46c774d 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -7,9 +7,11 @@
>=20
> use crate::{
>     bindings,
> -    block::mq::{raw_writer::RawWriter, Operations, TagSet},
> +    block::mq::{Operations, TagSet},
>     error::{self, from_err_ptr, Result},
> +    prelude::*,
>     static_lock_class,
> +    str::NullTerminatedFormatter,
>     sync::Arc,
> };
> use core::fmt::{self, Write};
> @@ -143,14 +145,14 @@ pub fn build<T: Operations>(
>         // SAFETY: `gendisk` is a valid pointer as we initialized it =
above
>         unsafe { (*gendisk).fops =3D &TABLE };
>=20
> -        let mut raw_writer =3D RawWriter::from_array(
> +        let mut writer =3D NullTerminatedFormatter::new(
>             // SAFETY: `gendisk` points to a valid and initialized =
instance. We
>             // have exclusive access, since the disk is not added to =
the VFS
>             // yet.
>             unsafe { &mut (*gendisk).disk_name },
> -        )?;
> -        raw_writer.write_fmt(name)?;
> -        raw_writer.write_char('\0')?;
> +        )
> +        .ok_or(EINVAL)?;
> +        writer.write_fmt(name)?;
>=20
>         // SAFETY: `gendisk` points to a valid and initialized =
instance of
>         // `struct gendisk`. `set_capacity` takes a lock to =
synchronize this
> diff --git a/rust/kernel/block/mq/raw_writer.rs =
b/rust/kernel/block/mq/raw_writer.rs
> index 7e2159e4f6a6..0aef55703e71 100644
> --- a/rust/kernel/block/mq/raw_writer.rs
> +++ b/rust/kernel/block/mq/raw_writer.rs
> @@ -24,6 +24,7 @@ fn new(buffer: &'a mut [u8]) -> =
Result<RawWriter<'a>> {
>         Ok(Self { buffer, pos: 0 })
>     }
>=20
> +    #[expect(dead_code)]
>     pub(crate) fn from_array<const N: usize>(
>         a: &'a mut [crate::ffi::c_char; N],
>     ) -> Result<RawWriter<'a>> {
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index b185262b4851..a3e34f566034 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -886,7 +886,6 @@ pub(crate) struct NullTerminatedFormatter<'a> {
>=20
> impl<'a> NullTerminatedFormatter<'a> {
>     /// Create a new [`Self`] instance.
> -    #[expect(dead_code)]
>     pub(crate) fn new(buffer: &'a mut [u8]) -> =
Option<NullTerminatedFormatter<'a>> {
>         *(buffer.first_mut()?) =3D 0;
>=20
>=20
> --=20
> 2.47.2
>=20
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
