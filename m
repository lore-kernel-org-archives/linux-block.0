Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D453F223DFF;
	Mon,  1 Sep 2025 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737641; cv=pass; b=rM/B6yKOxttXTj2oO+Q30S0nTNa7JhqZXrhdIcgt6Jvylk2hY7EZOFGrclYlucsVI+mo/bd1qIpxbS4MzP9GqszKg+seh8EeSWBOU1OcoH7XS7C6yPqng8LjgHQCWVoVI70b3dvaCpreicwJmrQ8C83N4+qLBwxMcu5IY8eyc/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737641; c=relaxed/simple;
	bh=VkF3mFyeQYzzBkD053RksWScWObs3Mf/d0Yz3sin1gQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ppkZqqww1VyQTK77UboSQhJ+ChlxzR+NsrdzMF2SMzgguO2L5OYafvl6cLQkPj4fh29HTX6zwcH8X+qH49C2ib4+7hhR852p6bkZ9Sk1bju+4dsPmOc7EPFqRz4Uqn6vrq+8cBnGv6E2PARJi2sStTdP5SZ+b/H5eBkvDUzIg5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XSliqd0u; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XSliqd0u"
ARC-Seal: i=1; a=rsa-sha256; t=1756737619; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Bj5zdtPq368dBT+rPmTMahcglDllNf0S36AuIc0aEBuwzbkf5YKACjnuQKPRRlpDxkfcdqlKbiGco1b0r4tgD2q54jpHfSJdqWtf1zLBTdIt9Kf8yATA2uQREJ9HX3Ex1OKZnX7uc1OMXxGlo8sdK8BMGQeCp6twtTUHDKDny5k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756737619; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vsyH3+I3gMBwgO8gidOB41GRKGanWU/9605BIKzf0hs=; 
	b=btaMInDTYjNIvzjKVAkOBYe28h7ausIFLTmRilsXbN8tgdBfw2P/U41A3XP6p0WA1JL1bJqgXB87yyVgBh7OGgAITTVellRCu+eli1Ja2iazJ+LZy7GTCX6kBfzQfmbV9xVZRIkH5jAhgGs1++g+w/jCsxa+e3p+T1ENGBY/JLw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756737619;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=vsyH3+I3gMBwgO8gidOB41GRKGanWU/9605BIKzf0hs=;
	b=XSliqd0ue5eoZIdyqmTP1raEpNsLOBHVCB12lz6m/XRX/o6uc0Ny7zeAhX0Hiz8Y
	jRT/CZFTo+Whpozsdmae5n3KUntSl4KowRNgzzLuPuWp4Jsjqa4/eQR7+wQCURnH81m
	CnAbSZXZ5Gu5hIelaym+3Ot5KtZKwtwUSq/dbuMw=
Received: by mx.zohomail.com with SMTPS id 1756737617388356.5060508240639;
	Mon, 1 Sep 2025 07:40:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 06/18] rust: str: add `bytes_to_bool` helper function
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-6-ec65006e2f07@kernel.org>
Date: Mon, 1 Sep 2025 11:40:01 -0300
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
Message-Id: <93C0C9AA-9CA9-4B0A-B7C8-654C75D1542C@collabora.com>
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

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

