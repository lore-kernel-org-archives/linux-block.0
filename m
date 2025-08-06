Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80B1E4AB;
	Wed,  6 Aug 2025 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754485613; cv=pass; b=YXFhkzbimOmM/rwsjAd471YcNFjYSisWr98vaJnx9BTtvdp/WV32bcm1mjxPDU5Cm2kd91o9X3ORQ7Q5HplUEzN1PWz0MrwzmWj23Gf2lD+ZHfU3LH6VfBdscsOWeCr7xK9c5gy6gHqMvA8KXSSApyn0JwjpPYhuIlc0OxKezXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754485613; c=relaxed/simple;
	bh=6IhePI+IFiouRipSNus/8WqKowyiO1DzlTwVjWHrK6E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=a3bQBOEAPsMa3pfDm/WFF5o3xdTukPa8ADqBbZK8BP/m7l+d8hLpztyNhtXorYllbl4f1+Uh2pKjRrRlvqKQNENIA8LRJeNb3HTgfCYZvzZ7+2BzUgCr022F3Dfr8dlBd7DlVn4klHGNMn4DbWwRzorNFf1QClWwHie+LBmx4RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=cXNuxtGF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="cXNuxtGF"
ARC-Seal: i=1; a=rsa-sha256; t=1754485596; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lIgZHxfpIUiAd/HnfH6hLdxN8S+JKhfhfcYrR1FIiWy5IHl2c9OzIdmfAegRVVOJDN13fJaA9W5J+mPIL9/461mudckLTjC8iQOgSlYV71ZyLV1NI4upOeCjCKUU6y/8UsG8+0PJDwMdK0cxL9j88sIRgCXfjdkEwRZjL9as15c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754485596; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2kUaFrxdjtaN0FnEJA8WppqfhgHnvcATlZ4I2Ib9ayE=; 
	b=fCgyD8KMJIm3SF62i5dPmsTJ0ewSoxx6ofBbz9AY1D0GtOxNY5vkZmlUbhRlru78SKanz1c0UnCpEntYvKArR+QP8ZmpZTeuAu8tjZ5H0a+ryKy8hNEEdbd2/p+GU3/6U4KepU+zIgSM/EGN/E+c8kMivg2Sikkc4chj9huqjlE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754485596;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=2kUaFrxdjtaN0FnEJA8WppqfhgHnvcATlZ4I2Ib9ayE=;
	b=cXNuxtGFGqss6PDlri0yDZYUAwemk+Zza//RLWHP83bCSe1AIRID1fpf2evd+ol+
	RufkvqCV5+W/koX0pVmmB938sau/qTzdFe8y7YRF4p+fpgXV2tqqKsOCPm4uPgQLqLu
	L71nNxh6eQGP2m2iHpjh5+8cJYfOXpW8FfwEPC3A=
Received: by mx.zohomail.com with SMTPS id 1754485594168972.8110487829066;
	Wed, 6 Aug 2025 06:06:34 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 03/16] rust: str: expose `str::Formatter::new`
 publicly.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250711-rnull-up-v6-16-v3-3-3a262b4e2921@kernel.org>
Date: Wed, 6 Aug 2025 10:06:20 -0300
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
Message-Id: <A831BC06-E4A2-4206-B231-12344E6CB4B6@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-3-3a262b4e2921@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> rnull is going to make use of `str::Formatter`, so expose it with =
public
> visibility.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/str.rs | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 41af456a46c8..28a6179385fc 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -703,7 +703,7 @@ fn test_bstr_debug() -> Result {
> ///
> /// The memory region between `pos` (inclusive) and `end` (exclusive) =
is valid for writes if `pos`
> /// is less than `end`.
> -pub(crate) struct RawFormatter {
> +pub struct RawFormatter {
>     // Use `usize` to use `saturating_*` functions.
>     beg: usize,
>     pos: usize,
> @@ -795,7 +795,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
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
> @@ -810,8 +810,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, =
len: usize) -> Self {
>     }
>=20
>     /// Create a new [`Self`] instance.
> -    #[expect(dead_code)]
> -    pub(crate) fn new<'a>(buffer: &'a mut [u8]) -> Formatter<'a> {
> +    pub fn new<'a>(buffer: &'a mut [u8]) -> Formatter<'a> {
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

