Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12736372B23;
	Wed, 29 Apr 2026 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457874; cv=none; b=LDVrZpO9fWDsbB3c0LDGYj7PMQalW/tQ71wzCbdXLmDrAFkOCHRza9ARJsWzcBFw0yo28wnZoKdFT2kqAvFTu1+uiq3JYNGgESqoDItzPw/bBdBYZeLcMWK9JwK0UuwYVGWOC8QwkCWZ93ZT4BYDuNfp7/y6/92bJUWBQq+rl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457874; c=relaxed/simple;
	bh=euj0GFFfX029JIp1YaFzAhisS7FaUBdAQO8gFxFHvgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FoD66s9r0qiFXQ3Zy0N9rsuRTVdt1WrumCXN3IzkV8AzgqZNt5qROod/MB5kMFWsXFYvShbNjsMlRMhbvbTSDsLeKK1TqIhW/Xw2vN7jSnNsoP/773T90ujr5usLp8M+/uOl1L54c1wfbhl1woR+xk+y3wicmx9v6NBVcfK7G4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCgRxRyo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCgRxRyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BEEC19425;
	Wed, 29 Apr 2026 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777457873;
	bh=euj0GFFfX029JIp1YaFzAhisS7FaUBdAQO8gFxFHvgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MCgRxRyoHFLjt/vKtZh2Vno4YJeQGTV4FPzf0EPyHAyS0dGxqGpxQIYEMRMKCAe5x
	 XlVUzkFCOsYEpRCDcI9n2Ye6No29dSO7I9slwQJaU80GKbb8P6K/sNkT7jYAZWyhDE
	 06KZ++mjVW0i9Ur7M5v755rKe0bupl3l5asnoRgHSg+Z2d3SXfPO2QBgPDeN3DhizI
	 ZV49nJsM5SW5c84iHZ4z3WCl9G3rPKf3kWoGR1g6bA6mnFqv1pOtf2ZUamwYVLBEPe
	 q1YreGes+BiRgc5MKh7idSzUnX13Xhh48qkPNZvOxieFbNPeoLETJuiZfYpB3K5KBF
	 bMvp15zxBYLUg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Hsiu Che Yu <yu.whisper.personal@gmail.com>, Boqun Feng
 <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hsiu Che Yu <yu.whisper.personal@gmail.com>
Subject: Re: [PATCH] rust: block: fix comment referring to states by wrong
 labels
In-Reply-To: <20260428-fix-docs-mq-req-v1-1-260079853836@gmail.com>
References: <u8w2aT8RMDhNK-zCkHKofFcml9mE8ndgtCnpwTrMWy6Kby41yC9ODSFCSKRZF8QahViSy2ANwHyurTUyVlgroA==@protonmail.internalid>
 <20260428-fix-docs-mq-req-v1-1-260079853836@gmail.com>
Date: Wed, 29 Apr 2026 12:17:43 +0200
Message-ID: <87cxzioyt4.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

"Hsiu Che Yu" <yu.whisper.personal@gmail.com> writes:

> The comment in `Request` describing the four ownership states referred
> to states 2 and 3 as "B" and "C", which are inconsistent with the
> numbering scheme used throughout the same comment block.
>
> Update the labels to use "2" and "3" to match the existing numbered list.
>
> Fixes: a307bf1db5448 ("rust: block: convert `block::mq` to use `Refcount`")
> Signed-off-by: Hsiu Che Yu <yu.whisper.personal@gmail.com>
> ---
>  rust/kernel/block/mq/request.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index ce3e30c81cb5..75d3fdf896e0 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -39,7 +39,7 @@
>  /// back ownership to the block layer.
>  ///
>  /// Note that the driver can still obtain new `ARef` even if there is no `ARef`s in existence by
> -/// using `tag_to_rq`, hence the need to distinguish B and C.
> +/// using `tag_to_rq`, hence the need to distinguish 2 and 3.
>  ///
>  /// The states are tracked through the private `refcount` field of
>  /// `RequestDataWrapper`. This structure lives in the private data area of the C
>
> ---
> base-commit: b4e07588e743c989499ca24d49e752c074924a9a
> change-id: 20260428-fix-docs-mq-req-d2a0fe1b6471
>
> Best regards,
> --
> Hsiu Che Yu <yu.whisper.personal@gmail.com>

Thanks for the patch. Please be aware that this mistake is fixed in the
latest rust null block series [1]. Please take a look at that series if
you have more patches for the rust block subsystem queued.

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/rust-for-linux/20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org/

