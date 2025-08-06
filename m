Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A55829C33F;
	Wed,  6 Aug 2025 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501273; cv=pass; b=nIB+9LwoPYOnjBx/VKPZ0wYtNwpiTCr1uYQR0whn4F78AJ+PSblqle7BKq86RvbM3EAo4fQonFnaFjd6UhHVIqjl1MZoXQKfxvbUKooTSj8vwGPUZWOrHbbGt7vyVcQwq4n8Nn3tfO6V5DqmtbIUAH3oUkymCMDSdsrX5WOtgKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501273; c=relaxed/simple;
	bh=AiDW2IByVRQaIFxwRX9AJSLG80KNm0g/2Us9YzkfDh0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Z/FPwf2FSTeE0JrQJPmUkE77L+tlIjoRNwFHgRAOwz/TmcEJxKJwQD2Lj0nKz/cl1mw1p77T5zbJSFBnKs0UwkRm3kUz9vEnn4MSX5rscIatDK7DFCFPvyI+zn3+j1NEtRqbVJRINPsS2nLuGYyV15v1AC8KeLTI+Y/5lGLt6qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Ym4t3AXx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ym4t3AXx"
ARC-Seal: i=1; a=rsa-sha256; t=1754501256; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=II/aM85UGjvH361g1lFby19/7Seyj9xDjmm4V4j8aXSPv35kuoZpImP45iM2OqjVixPGtPHOg2Rwqz7sPezbaroNYVrj+UwOgL3iewlU4zDmpsFpgiCQZXXnzCfRVjs0tggwo/nVid4bZ3fcokx3/t1M0ZQVgygc/5X2o85oVcQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754501256; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AiDW2IByVRQaIFxwRX9AJSLG80KNm0g/2Us9YzkfDh0=; 
	b=BH6aOCA6L7T9xEDfYgCVwxArrwMr94ypRYXhow77GsQS4brdXScjGIpXkR1uOLGTUuoz7U53h9uT7WqFxs+GWfG5Rzz1LP+P/YvUENm37nn2bbB1IdbzFrnrWe4NlSZicKEiL4wEWlUwAIaahwt3RhS9F9VVquOttzOUoz1GFhE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754501256;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=AiDW2IByVRQaIFxwRX9AJSLG80KNm0g/2Us9YzkfDh0=;
	b=Ym4t3AXxPjUGoCmjGZyvbtffrBYBU200lXhFXTIO1IVsT/ifmepdYRjZUCNYRnhy
	mI9bLr6sufqqF1YLljU/EnS+pbmGQ8EvRzE0ofhdkJcXKDQdgrxfCg5dpQc3qCxn6VS
	8aVkK5iOw5alg+lmuj6YoxwGV2CedQnghVnVC0pk=
Received: by mx.zohomail.com with SMTPS id 1754501254280353.52511468314515;
	Wed, 6 Aug 2025 10:27:34 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 10/16] rust: block: add block related constants
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250711-rnull-up-v6-16-v3-10-3a262b4e2921@kernel.org>
Date: Wed, 6 Aug 2025 14:27:19 -0300
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
Message-Id: <8CD9F17A-0F1C-4EDC-A63D-F6A0EAC75F35@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-10-3a262b4e2921@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Add a few block subsystem constants to the rust `kernel::block` name =
space.
> This makes it easier to access the constants from rust code.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/block.rs | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>=20
> diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
> index 150f710efe5b..7461adf4d7e0 100644
> --- a/rust/kernel/block.rs
> +++ b/rust/kernel/block.rs
> @@ -3,3 +3,15 @@
> //! Types for working with the block layer.
>=20
> pub mod mq;
> +
> +/// Bit mask for masking out [`SECTOR_SIZE`]

Missing period.

> +pub const SECTOR_MASK: u32 =3D bindings::SECTOR_MASK;
> +
> +/// Sectors are size `1 << SECTOR_SHIFT`.
> +pub const SECTOR_SHIFT: u32 =3D bindings::SECTOR_SHIFT;
> +
> +/// Size of a sector.
> +pub const SECTOR_SIZE: u32 =3D bindings::SECTOR_SIZE;
> +
> +/// Power of two difference in size of a page and size of a sector.

A bit hard to parse this.

Maybe =E2=80=9CThe difference between the size of a page and the size of =
a sector,
expressed as a power of two=E2=80=9D ?

> +pub const PAGE_SECTORS_SHIFT: u32 =3D bindings::PAGE_SECTORS_SHIFT;
>=20
> --=20
> 2.47.2
>=20
>=20
>=20


 let sector: usize =3D something;
 let page_offset =3D (sector & block::SECTOR_MASK as usize) << =
block::SECTOR_SHIFT;


Wait, the parenthesis evaluate to usize, and the shift is a u32. How =
does this compile?

=E2=80=94 Daniel

