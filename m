Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65162D7BF;
	Wed,  6 Aug 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754486193; cv=pass; b=SKu6E6EG1EfLjVl6cHvNu4JZcRuhPqoAdcSGeWFNMZJE5ZT32iNkhOtCjqAhloY3ycroc7JDhihBn4/C9k+nWgvojyn3Cj79vq1ghOw9Hy2MF3axFW7IYa81eIOSSKVzTlW92/OeKnR48aeDWqQA3hDj1zA66fnzZgxPzAD4se8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754486193; c=relaxed/simple;
	bh=ez37Ibbz5dtRuOcR/6LAaIgmyERaVqHwZ0Yy2TDMwwM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KzacCbNjkSpUusgd2KejzqsbKt9QasprvPRNNTTfs+3sc+fqmkLneT0GWFk/o/MsqtrxlKKdI7GIMuNHIdYLsQxwC0huXwH80YstLKjTosljsMbuFxb0ZpsLvs71v4qyHQoIG+yevFVuaRb7gXk6c0WFmp6F8M+IIpsIjDASRK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=g2jw1miM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="g2jw1miM"
ARC-Seal: i=1; a=rsa-sha256; t=1754486175; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fziszNXFr0YNOqbYjB5/gCcqFNi2aF8pw/2Tw8xoyP6Y8LUps/sHnybdVjJRtTPgNXU+vnu56RmFSj2R/K7/SzRervtyu02osnndCQdahhtwlQML7eqhVIxUDdpfU9Kdlns5KdaZoSsH1xHYcHSbLg8Vr1VBwVIcZ3bc4AaNgYs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754486175; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ugatb8Lju39e82m8xw2MzulazQ7H2RroEEK3NjtHRCg=; 
	b=Uq/Bm6R29D3l4QRcQebHRHr6zpMyEb/8qtlFEqWnhi8PrwFt0nK0V39AdBjCin01Y85hQvML+O+Y5INU+G3/dF8qLeNcFmIYHgqaXOGzkVpu8T+Q2qydxZ5eyiaUQglfghK8VZ76S1gv1Mv01XKZyZlu0c6eeQGpec+7jx4NKo4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754486174;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=ugatb8Lju39e82m8xw2MzulazQ7H2RroEEK3NjtHRCg=;
	b=g2jw1miMUICHe/FGYWo1qm4EuYwe/r76o17ZO16Dpd96BF1UY6nD298KMx4vUn1N
	BPO02GPSzvLGb0LauotT9lcoVVl56FCgxmWDLzcG+i6ObFh2wYkc4060cDEjGvwG9zo
	eQARTHPybTkBqcHnKmNariPnrYOB5PA1C8nL1HsU=
Received: by mx.zohomail.com with SMTPS id 1754486173123349.7910615471999;
	Wed, 6 Aug 2025 06:16:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 05/16] rust: str: introduce `NullTerminatedFormatter`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250711-rnull-up-v6-16-v3-5-3a262b4e2921@kernel.org>
Date: Wed, 6 Aug 2025 10:15:57 -0300
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
Message-Id: <D9A4DD7C-D9C2-4D91-B6C3-684BA1C100C0@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-5-3a262b4e2921@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Add `NullTerminatedFormatter`, a formatter that writes a null =
terminated
> string to an array or slice buffer. Because this type needs to manage =
the
> trailing null marker, the existing formatters cannot be used to =
implement
> this type.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/str.rs | 50 =
++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 50 insertions(+)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index b1bc584803b0..c58925438c6e 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -838,6 +838,56 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>     }
> }
>=20
> +/// A mutable reference to a byte buffer where a string can be =
written into.
> +///
> +/// The buffer will be automatically null terminated after the last =
written character.

Hmm, I suppose you want this to be the only null? See below.

> +///
> +/// # Invariants
> +///
> +/// `buffer` is always null terminated.
> +pub(crate) struct NullTerminatedFormatter<'a> {
> +    buffer: &'a mut [u8],
> +}
> +
> +impl<'a> NullTerminatedFormatter<'a> {
> +    /// Create a new [`Self`] instance.
> +    pub(crate) fn new(buffer: &'a mut [u8]) -> =
Option<NullTerminatedFormatter<'a>> {
> +        *(buffer.first_mut()?) =3D 0;
> +
> +        // INVARIANT: We null terminated the buffer above.
> +        Some(Self { buffer })
> +    }
> +
> +    #[expect(dead_code)]
> +    pub(crate) fn from_array<const N: usize>(
> +        buffer: &'a mut [crate::ffi::c_char; N],
> +    ) -> Option<NullTerminatedFormatter<'a>> {
> +        Self::new(buffer)
> +    }
> +}
> +
> +impl Write for NullTerminatedFormatter<'_> {
> +    fn write_str(&mut self, s: &str) -> fmt::Result {
> +        let bytes =3D s.as_bytes();
> +        let len =3D bytes.len();
> +
> +        // We want space for a null terminator. Buffer length is =
always at least 1, so no overflow.

Perhaps this should be a type invariant? I know this is a logical =
conclusion
from saying =E2=80=9Cbuffer is always NULL terminated=E2=80=9D, but =
it=E2=80=99s always
nice to be even more explicit.

> +        if len > self.buffer.len() - 1 {
> +            return Err(fmt::Error);
> +        }
> +
> +        let buffer =3D core::mem::take(&mut self.buffer);
> +        // We break the null termination invariant for a short while.
> +        buffer[..len].copy_from_slice(bytes);
> +        self.buffer =3D &mut buffer[len..];

As I said in my first comment, if you want this to be the only null, I
don=E2=80=99t think the copy above enforces it?

> +
> +        // INVARIANT: We null terminate the buffer.
> +        self.buffer[0] =3D 0;
> +
> +        Ok(())
> +    }
> +}
> +
> /// An owned string that is guaranteed to have exactly one `NUL` byte, =
which is at the end.
> ///
> /// Used for interoperability with kernel APIs that take C strings.
>=20
> --=20
> 2.47.2
>=20
>=20
>=20

=E2=80=94 Daniel=
