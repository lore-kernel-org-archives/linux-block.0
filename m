Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7970298CDE;
	Wed, 27 Aug 2025 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302801; cv=pass; b=ELmSCtm/QfkyN+RQVhU0y54QX9mjh6DWROXxeWJBsfplSGvz3xHVdX6tbXsSnjbMKtRYHLMlbhtSkHxNbSnpY1mEjipnC24istRaowrgscly49n6c5epXb+Ome6LlawY4XurEzqzmRgMYJwrYfliGmBSvMRDJ2nHQBq/FVrygcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302801; c=relaxed/simple;
	bh=wnpU+f1L9coHOqkUD0aGHPKLSW2SjFkWcFMLJRu/Gc0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Rp8rj9aQoKk1sOZKmCETtfxFtUQ0JZ48VkHHeKlB1vRN2WJ7wouuyM4H16yDzRP1EyPeZbvPC7VwzpblZKWxprXx2tWVNHH57MV2w6rAK0bfKIRNpInJ1a+EYbzlte6OcsINMYlfnxThBcPnBrKBXJU+F+ga9v4rznSoJ/24aD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=IK/kLdx0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="IK/kLdx0"
ARC-Seal: i=1; a=rsa-sha256; t=1756302780; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k32J1mVBtlXB1Ou5i4XRCu9YUukMzyierH9VKCYymtpqk8wVG0rgCOEcpG0YYSclWel63jfCEBCLoMD+jTIkwS6GpJR5yQkg4yZKts4TGsAp+Sm1b1xur3fG4Le2G5sVl7rXyiSN1BOQdbs95CBazoy+HoLTsKwykHtTVeaeVtQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756302780; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=se/bIfy8ZaVRNckaW6+d8bZp+8ysR2qfgNezlpCAwWc=; 
	b=ZWGNqJc7p04vxlRJH3xCzl81/1y8bD8hPvhmHei7Pjfg+uYTydWaqKHNrEJ0RATTITq8lSnzEYNn2PIlGt6s7+ySbRDWxkmV4jfrf7Fjtj7Slap3D1ytIhXMCzkErgbVTVf8JqcDqngxj5Xnb9O5Ew2sxGEwTIVSz8cwca8PIaA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756302780;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=se/bIfy8ZaVRNckaW6+d8bZp+8ysR2qfgNezlpCAwWc=;
	b=IK/kLdx0lBzhpUgYbkcl7RHz8b8lB0eqESyMpPq7hPVGAN5aCs/ptYDD7Su4Jvqf
	vPPqy7USxabaO9clF0AvLJb7/LGQHprQkE/3gNZHm2BGluiu/KBAeRPWVUAlDq+/wCX
	qYpyI42it0NS/KLPIAyLwWLIZT3r0uw8yGWkaJrA=
Received: by mx.zohomail.com with SMTPS id 1756302776980149.67117861972497;
	Wed, 27 Aug 2025 06:52:56 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 12/18] rust: block: add block related constants
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-12-ec65006e2f07@kernel.org>
Date: Wed, 27 Aug 2025 10:52:40 -0300
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
Content-Transfer-Encoding: 7bit
Message-Id: <2D2AEDEC-A62F-463C-9119-5B3F1DB3E940@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-12-ec65006e2f07@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
> Add a few block subsystem constants to the rust `kernel::block` name space.
> This makes it easier to access the constants from rust code.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/block.rs | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
> 
> diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
> index 150f710efe5b..32c8d865afb6 100644
> --- a/rust/kernel/block.rs
> +++ b/rust/kernel/block.rs
> @@ -3,3 +3,16 @@
> //! Types for working with the block layer.
> 
> pub mod mq;
> +
> +/// Bit mask for masking out [`SECTOR_SIZE`].
> +pub const SECTOR_MASK: u32 = bindings::SECTOR_MASK;
> +
> +/// Sectors are size `1 << SECTOR_SHIFT`.
> +pub const SECTOR_SHIFT: u32 = bindings::SECTOR_SHIFT;
> +
> +/// Size of a sector.
> +pub const SECTOR_SIZE: u32 = bindings::SECTOR_SIZE;
> +
> +/// The difference between the size of a page and the size of a sector,
> +/// expressed as a power of two.
> +pub const PAGE_SECTORS_SHIFT: u32 = bindings::PAGE_SECTORS_SHIFT;
> 
> -- 
> 2.47.2
> 
> 
> 

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

