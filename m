Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5CE2BD5B0;
	Wed, 27 Aug 2025 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300282; cv=pass; b=YdfTmoBu4AGerFHPygiZsFiTvlLBrCPcUzqMcxasTUAtqr9KPsZE6xp6Qa3EFpK3j/v93hiF3rL1ba25dleuGb17xjiQpFm/GdaudxkWENKsFiJLZ/Fvz1FWSBkSqsVycZLocynl/6ACNGWg7drBCeHvJRSsr9pWPKVCTfkx0BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300282; c=relaxed/simple;
	bh=Yvmv4LbBWz5GniQhQN1h1ApaRtyRX5BoN3NMWW/xzwk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g7RkllFL0vfQjPQfdt6n8LzaXAEu65aKK/1+sGAikeWWqLmTMopydEgOA/MnPSRaqS7TMIHa3803rK7CUl3NAVxWsmLXJw4K/3/PcBRsrHXBKDE3K2oVNs0EOHYT37DF75+RH9Rm0LCDw9e5fWxGZB2OoMbUW6TOjZVgaEDVJAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=arVqRPe2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="arVqRPe2"
ARC-Seal: i=1; a=rsa-sha256; t=1756300260; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UlzUuCrKnOgVIkRfgBTpU9ZUn+PClJ7hsW0Rwx4mrCONVALOllpUe2DgJmG1AZhdarF4ThRKSgnoLHILI/xEilGMpUjWJw6OvDTRejUF+OgDIS8yQcAMIvAsfTNE6stcUVnXi8j3t/qOcYFbGIrZiUZ1M4aP7S5Ah7MmAImU1Gw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756300260; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HK0ZqpOuG/yp/CXp5WnROsRN8hQcZfbbwtHP9VHBdLU=; 
	b=kKYVZynYuYwH0ATJIQ3EJKriIVS4MGPnTZeO1e8PD1FqJBPKNv+pAjkHHZQk056dH7OwViK7UpnwDCtrHizBJnH+h7749GXcaVZA4mPcrUq8sueZAqy2G75L3BeLwHtO8uA2j7ggBqZbNoOg2rLbs7BsYf2ilckB4N6Txs+c0OE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756300260;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=HK0ZqpOuG/yp/CXp5WnROsRN8hQcZfbbwtHP9VHBdLU=;
	b=arVqRPe27KqFgAgW/mFu8S59xCGpz8nf+al9MJ7+2+nw1RHPyzXqqqrVCD9SfZy5
	7Zl5aswT6nS5qxZB1d6TrFLQjtdsRJOXGfnD3KWcRz1Q0ud1oMsICbDoyxt2UVfZFO8
	KvewZvGlpakCQeFZTbRV2X4I6Ayo3usZ5HpaU5P8=
Received: by mx.zohomail.com with SMTPS id 1756300258363744.5903240691605;
	Wed, 27 Aug 2025 06:10:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 05/18] rust: str: introduce `kstrtobool` function
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-5-ec65006e2f07@kernel.org>
Date: Wed, 27 Aug 2025 10:10:42 -0300
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
Message-Id: <A97ECEE6-25A7-45ED-8547-527AC4362BA6@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-5-ec65006e2f07@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Add a Rust wrapper for the kernel's `kstrtobool` function that =
converts
> common user inputs into boolean values.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/str.rs | 57 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 57 insertions(+)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index d8326f7bc9c1..d070c0bd86c3 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -4,6 +4,7 @@
>=20
> use crate::{
>     alloc::{flags::*, AllocError, KVec},
> +    error::Result,
>     fmt::{self, Write},
>     prelude::*,
> };
> @@ -920,6 +921,62 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>     }
> }
>=20
> +/// Convert common user inputs into boolean values using the kernel's =
`kstrtobool` function.
> +///
> +/// This routine returns `Ok(bool)` if the first character is one of =
'YyTt1NnFf0', or
> +/// \[oO\]\[NnFf\] for "on" and "off". Otherwise it will return =
`Err(EINVAL)`.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{c_str, str::kstrtobool};
> +///
> +/// // Lowercase
> +/// assert_eq!(kstrtobool(c_str!("true")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("tr")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("t")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("twrong")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("false")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("f")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("yes")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("no")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("on")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("off")), Ok(false));
> +///
> +/// // Camel case
> +/// assert_eq!(kstrtobool(c_str!("True")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("False")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("Yes")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("No")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("On")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("Off")), Ok(false));
> +///
> +/// // All caps
> +/// assert_eq!(kstrtobool(c_str!("TRUE")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("FALSE")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("YES")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("NO")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("ON")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("OFF")), Ok(false));
> +///
> +/// // Numeric
> +/// assert_eq!(kstrtobool(c_str!("1")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("0")), Ok(false));
> +///
> +/// // Invalid input
> +/// assert_eq!(kstrtobool(c_str!("invalid")), Err(EINVAL));
> +/// assert_eq!(kstrtobool(c_str!("2")), Err(EINVAL));
> +/// ```
> +pub fn kstrtobool(string: &CStr) -> Result<bool> {
> +    let mut result: bool =3D false;
> +
> +    // SAFETY: `string` is a valid null-terminated C string, and =
`result` is a valid
> +    // pointer to a bool that we own.
> +    let ret =3D unsafe { bindings::kstrtobool(string.as_char_ptr(), =
&mut result) };
> +
> +    kernel::error::to_result(ret).map(|()| result)
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

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

