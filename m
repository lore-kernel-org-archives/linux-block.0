Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDCCD299;
	Fri,  7 Feb 2025 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887819; cv=none; b=dcjmiQqLDXB/Dk3+4V6wg4cYmbRZO8In372C5OCtnpTTc51rmgqyWuDjXm3cYP2y66q1hWTIot0/7cwoP+U5KGm5Tp69cpHuiC2EsAxsGcXI8khJBIG6NSZwVs36ywRduLgCtf09akV3LKXzH6Idn/EmGA+3hwZHV9LiUqYxY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887819; c=relaxed/simple;
	bh=MSBQ8GWnqbmkXkDJQH1fTfd8ljxtUT/P4BqezHpjyeA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvUapz3C8m7OgbvgrvsihSxVw41eXjSQLnoGsS5y40bguIljra9vjtOfeq2zI60l3OLcwsCsEimyWBgCoiNnlHa6795uCCUj/fIKU+sAL6YciAzmj/CaI9BlwW1BE3vI0ucUc/gGj1WMPIGCdi+QIiHbYFUJ0qzrHBEqei7y+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DAAmmzsU; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DAAmmzsU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1738887805; x=1739147005;
	bh=+Y17yiJKHXbqIJKjLYffT+nV6HQjYl3k7kgDM8kNNBE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DAAmmzsUhsgxUQje4qg9DrQub53aodQNzRZXxLSsX8E8J37eTISb97wKLPkWd2qUa
	 dkjt83wiQEBv+Fd/xOgYy1ZYAfM3x+8MgHrAv72xgD+DLP1hgkkksMcC8+Sfc1Gxld
	 yWGh9aIXFtAdAUjlnEjt4VS2Vtr4B5IGgsqQ8eKzGE1gSvG3Ds8dFlinAUN3Qn8NtR
	 AAkS7yaZp70LqCh8DAsL/RchjVV4IQ7/eijVxvC/UPVeZ/FZr4HsDxKmz5he3webkE
	 MIg8R2VteMaR75Hdmry5dLzOPatOhl6NHAt7V1qlohSxK+D8QO6dJiE+UBLczuxpAe
	 bXE5opynilM5w==
Date: Fri, 07 Feb 2025 00:23:21 +0000
To: Mitchell Levy <levymitchell0@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: lockdep: Remove support for dynamically allocated LockClassKeys
Message-ID: <a21084cc-84d7-473f-846b-9ca735cd8e34@proton.me>
In-Reply-To: <20250205-rust-lockdep-v3-1-5313e83a0bef@gmail.com>
References: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com> <20250205-rust-lockdep-v3-1-5313e83a0bef@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c4b077ab609d510ca1842e9ee98f1b607618ee1c
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.02.25 20:59, Mitchell Levy wrote:
> Currently, dynamically allocated LockCLassKeys can be used from the Rust
> side without having them registered. This is a soundness issue, so
> remove them.
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi=
@metaspace.dk/
> Cc: stable@vger.kernel.org
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  rust/kernel/sync.rs | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

