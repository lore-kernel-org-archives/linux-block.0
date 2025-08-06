Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFA938FB9;
	Wed,  6 Aug 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754486736; cv=pass; b=Ya8JWlblSe61hGpskKgL6VFjNCY3DhF9YJyPjBMMeK1jSrB1xJnwO4MDsygridfxEVdgEaGVjeh35HOnVQ/T4XQKyDtLj4/bg3vEcOcsh6n+jmpPAxG2mKiahLJ6aVmhPG9/+kz6WyTl31teS9E4QM36szCZ5Vl+2p6xJ35ZBgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754486736; c=relaxed/simple;
	bh=vAeKaPEXvcDqf61rNHSQ9ZM38yO9ECSL+nekoCHhAJc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VNUcBoT9Yx3/EJ3ROAF12+1v7XiffUwaT/DJ4JBPxb1UkAV2INfxB8/CCQbgDJqlwEe/osQVG2MUkOPoM58jHGZO01dDg+/IZ7h3WszI8DHSSg0LlP/CtMXS2Qt1uRhllps/sulL4n7YUIm0vP97P1DEWuG6+mZZjr+IB53MyzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=SOqopnT8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="SOqopnT8"
ARC-Seal: i=1; a=rsa-sha256; t=1754486719; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZQuDF8px7NB9KWIOu2w3QFGEImOYx5uhTyG7uuoz2ziZTu4XRsi8i/H9iwJeUrrIJodfl7PY8tgvPAEpmRzbuzVRCW9D/o2F+WccMuc5QoRW49UhbuEc8sGWeY1RJtLryXj3c728KY432grJNNI41s56F1cSmahrZ/EH/qvtLY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754486719; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rbN3opuwJukBcj9/ZRoP78wqC7nPDjMjgfVcpb6PIks=; 
	b=Ye4dUbKXnReLecbyEGdmo6hOcXEBNMWFWUgRNmba1fCoLeF1aa45bQVghf42yfqEMyqQNrC++i/BUpYqf2lD0213Uz4Oqv/jePhPeyMu5n/a50CZ3SJDGjTjcqaFzGvHKO6IwpiJ70YsyPE2A0fv5bshCWgSvTR9bKCXmfAGHac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754486719;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=rbN3opuwJukBcj9/ZRoP78wqC7nPDjMjgfVcpb6PIks=;
	b=SOqopnT88cA0ZrEL+ICf8s/fVe9wQ/b3uKK74662FAEG+2Bs+J+W+6E/UoA7hb12
	w/yuUvv6X2IGFrFpMq2yEGgW1F2UcAHyScbnMHvGsT5cAdn/AgXMD8s+8sGl3QLIG9J
	JPgpge0zOYlq4Ovz+Xn3/ED99mhUFo4msYzdquhI=
Received: by mx.zohomail.com with SMTPS id 1754486716196557.3989243653147;
	Wed, 6 Aug 2025 06:25:16 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 08/16] rust: block: remove `RawWriter`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250711-rnull-up-v6-16-v3-8-3a262b4e2921@kernel.org>
Date: Wed, 6 Aug 2025 10:25:02 -0300
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
Message-Id: <844D39CF-647A-45BA-A940-072DAEB911E0@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-8-3a262b4e2921@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> `RawWriter` is now dead code, so remove it.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/block/mq.rs            |  1 -
> rust/kernel/block/mq/raw_writer.rs | 56 =
--------------------------------------
> 2 files changed, 57 deletions(-)
>=20
> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
> index fb0f393c1cea..faa3ccb5a49a 100644
> --- a/rust/kernel/block/mq.rs
> +++ b/rust/kernel/block/mq.rs
> @@ -89,7 +89,6 @@
>=20
> pub mod gen_disk;
> mod operations;
> -mod raw_writer;
> mod request;
> mod tag_set;
>=20
> diff --git a/rust/kernel/block/mq/raw_writer.rs =
b/rust/kernel/block/mq/raw_writer.rs
> deleted file mode 100644
> index 0aef55703e71..000000000000
> --- a/rust/kernel/block/mq/raw_writer.rs
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -use core::fmt::{self, Write};
> -
> -use crate::error::Result;
> -use crate::prelude::EINVAL;
> -
> -/// A mutable reference to a byte buffer where a string can be =
written into.
> -///
> -/// # Invariants
> -///
> -/// `buffer` is always null terminated.
> -pub(crate) struct RawWriter<'a> {
> -    buffer: &'a mut [u8],
> -    pos: usize,
> -}
> -
> -impl<'a> RawWriter<'a> {
> -    /// Create a new `RawWriter` instance.
> -    fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
> -        *(buffer.last_mut().ok_or(EINVAL)?) =3D 0;
> -
> -        // INVARIANT: We null terminated the buffer above.
> -        Ok(Self { buffer, pos: 0 })
> -    }
> -
> -    #[expect(dead_code)]
> -    pub(crate) fn from_array<const N: usize>(
> -        a: &'a mut [crate::ffi::c_char; N],
> -    ) -> Result<RawWriter<'a>> {
> -        Self::new(
> -            // SAFETY: the buffer of `a` is valid for read and write =
as `u8` for
> -            // at least `N` bytes.
> -            unsafe { =
core::slice::from_raw_parts_mut(a.as_mut_ptr().cast::<u8>(), N) },
> -        )
> -    }
> -}
> -
> -impl Write for RawWriter<'_> {
> -    fn write_str(&mut self, s: &str) -> fmt::Result {
> -        let bytes =3D s.as_bytes();
> -        let len =3D bytes.len();
> -
> -        // We do not want to overwrite our null terminator
> -        if self.pos + len > self.buffer.len() - 1 {
> -            return Err(fmt::Error);
> -        }
> -
> -        // INVARIANT: We are not overwriting the last byte
> -        self.buffer[self.pos..self.pos + len].copy_from_slice(bytes);
> -
> -        self.pos +=3D len;
> -
> -        Ok(())
> -    }
> -}
>=20
> --=20
> 2.47.2
>=20
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
