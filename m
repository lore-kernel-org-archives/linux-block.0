Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388C3009FA;
	Wed, 27 Aug 2025 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302424; cv=pass; b=cwZ3n5W/Kh8EgvX4qGZrE2+9fFYzBGKW1isG74Ed9md5ZvseVbazl1iOgkGAGVIsbj6rFpWiUctdB0HC//WlxkurEpurO+a3I5n/MpdLA81/YLYWrZ1zloDTMoHw5oLfMOKo3ir08M6plJ4LMKih1zvTmtqmuzra11Vd9ypAY2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302424; c=relaxed/simple;
	bh=4F4PSpfzqc4T3sl1FWdLl5F4O54g0Xgbs8dayq40s2k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ww2w7cYuOBtc+Lwb0QNzIZwOF7AqGEey4b/CSwkGo5PQdysYUTLaB3kRqu9XQZ/lsV2L0gCYstuUkDC83o3QhgU4lQ3opAqXqcHFRMfFJQqlAE9NRg3xTus1XEm3tA6Lqj+851ax0kxSV//WQZA+DAdih9IJCUN/gFH23Hk3pnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=C1+9CW5p; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="C1+9CW5p"
ARC-Seal: i=1; a=rsa-sha256; t=1756302399; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D/zawCSW5Xvy+e1Qi5+0Zh3LTohvB2uDyw3SRcnLfYOwfgiAniJdb1zbO5ix2b3Lesj67sTv0KN+YmYQJUwwVnp07/FV8OLcchgIRHqdeICWEJYC2ZhOyv5NmyHIEr3lngCIw1kR/kD9ohbpJ23ByMU9bcl572OgxGTxCsSyfMU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756302399; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z3hQA04U/NsIOTB7Ljgoe9/oGh3W8wlbOOT2f7+/2+s=; 
	b=O8fDZZKxGRr7i+mxUhWplOWxOJMQIVjMl44P5L0cz7JLsxe4iw8S3zv5yv21VDusYca7T08Y33aEPO8e9jvaEH1eQnA9ErThJrhonkbWlQBKFapfrmf55Kg+QgTJwNswjwTsdunB826tElFOyzuvzGFP7oqn/B+nd7Nz/KdG/2c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756302399;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=z3hQA04U/NsIOTB7Ljgoe9/oGh3W8wlbOOT2f7+/2+s=;
	b=C1+9CW5pT3qSVbF7XGhxN6gtZDzloNcg6g7kq7Zwod5jQQ+DnitiKLuJMhmTyrnf
	RZ0HShPHaSsYP+/GLaLLj2/HhyiuxPzx1NGuSRw/+NwTDhF+9BRd/yF48CS2psVRwaJ
	fWcsYhZaP7mLpw1+Uc1b/376jGNZEqUXEyR8+7r8=
Received: by mx.zohomail.com with SMTPS id 1756302395027874.0815258877969;
	Wed, 27 Aug 2025 06:46:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 06/18] rust: str: add `bytes_to_bool` helper function
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-6-ec65006e2f07@kernel.org>
Date: Wed, 27 Aug 2025 10:46:18 -0300
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
Message-Id: <60D09FDF-D1EB-46A0-8F76-13F98BE9C518@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-6-ec65006e2f07@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Add a convenience function to convert byte slices to boolean values by
> wrapping them in a null-terminated C string and delegating to the
> existing `kstrtobool` function. Only considers the first two bytes of
> the input slice, following the kernel's boolean parsing semantics.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/str.rs | 35 +++++++++++++++++++++++++++++------
> 1 file changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index d070c0bd86c3..b185262b4851 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -921,6 +921,20 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>     }
> }
>=20
> +/// # Safety
> +///
> +/// - `string` must point to a null terminated string that is valid =
for read.
> +unsafe fn kstrtobool_raw(string: *const u8) -> Result<bool> {
> +    let mut result: bool =3D false;
> +
> +    // SAFETY:
> +    // - By function safety requirement, `string` is a valid =
null-terminated string.
> +    // - `result` is a valid `bool` that we own.
> +    let ret =3D unsafe { bindings::kstrtobool(string, &mut result) };
> +
> +    kernel::error::to_result(ret).map(|()| result)
> +}
> +
> /// Convert common user inputs into boolean values using the kernel's =
`kstrtobool` function.
> ///
> /// This routine returns `Ok(bool)` if the first character is one of =
'YyTt1NnFf0', or
> @@ -968,13 +982,22 @@ fn write_str(&mut self, s: &str) -> fmt::Result =
{
> /// assert_eq!(kstrtobool(c_str!("2")), Err(EINVAL));
> /// ```
> pub fn kstrtobool(string: &CStr) -> Result<bool> {
> -    let mut result: bool =3D false;
> -
> -    // SAFETY: `string` is a valid null-terminated C string, and =
`result` is a valid
> -    // pointer to a bool that we own.
> -    let ret =3D unsafe { bindings::kstrtobool(string.as_char_ptr(), =
&mut result) };
> +    // SAFETY:
> +    // - The pointer returned by `CStr::as_char_ptr` is guaranteed to =
be
> +    //   null terminated.
> +    // - `string` is live and thus the string is valid for read.
> +    unsafe { kstrtobool_raw(string.as_char_ptr()) }
> +}
>=20
> -    kernel::error::to_result(ret).map(|()| result)
> +/// Convert `&[u8]` to `bool` by deferring to =
[`kernel::str::kstrtobool`].
> +///
> +/// Only considers at most the first two bytes of `bytes`.
> +pub fn kstrtobool_bytes(bytes: &[u8]) -> Result<bool> {
> +    // `ktostrbool` only considers the first two bytes of the input.
> +    let stack_string =3D [*bytes.first().unwrap_or(&0), =
*bytes.get(1).unwrap_or(&0), 0];

Can=E2=80=99t this be CStr::from_bytes_with_nul() ?

This means that kstrtobool_raw could take a &CStr directly and thus not =
be unsafe IIUC?

> +    // SAFETY: `stack_string` is null terminated and it is live on =
the stack so
> +    // it is valid for read.
> +    unsafe { kstrtobool_raw(stack_string.as_ptr()) }
> }
>=20
> /// An owned string that is guaranteed to have exactly one `NUL` byte, =
which is at the end.
>=20
> --=20
> 2.47.2
>=20
>=20
>=20


