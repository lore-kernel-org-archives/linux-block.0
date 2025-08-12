Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577722E11C3;
	Tue, 12 Aug 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986670; cv=none; b=kAqbidBG9YcHvwu4Qd8wDu81u8ljeaL7qSqxeWMfmEFoYTYbwwbxlZ0oG2+PWthqbW32zQz/wIawq4P9JyfmPgHtXU7gtHiGTNq04pKtOvNr2kBJtO99BJfzub3RspQeRVczJz6pXdl2olJJDZgubfFjXTiud1Vj8sKQL+/2rTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986670; c=relaxed/simple;
	bh=QinJxVobuywyLcFURbw2RZmaT7KGk4qObFDgu2BRbTA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pME1I2ShHWL6QmqdryhrngJ/k7W+jBVpQyD3ztBPq3jXYT7wRoRltiKxuJ77DEcd/LqFSG2P+d282vWjyAfyPrw1k1f9vJ+g/Oz36jXRWNtvvL4v+Wk19G1tDVV/X8HW0ogclu9XVYB6B08EndOIODvxj4D6QI1krXUO32uN2tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdxsiq/I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdxsiq/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F158C4CEF0;
	Tue, 12 Aug 2025 08:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986669;
	bh=QinJxVobuywyLcFURbw2RZmaT7KGk4qObFDgu2BRbTA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=pdxsiq/IchFyGONwW7oyBy1dFfkAylNiL/o9r35Q5BwitbkiuJkphL1ru+oZqq8Nu
	 d8Lgdk0mkWj93zG1QD4AtsoV57VnfvLNp+WdeRHDaVT1+oHrNYj0YTiRxqtlXBD/3Y
	 wp9IGcIUoYNMgD4be0MM2+GqXcVTto7autnhAuA0wgQPYs13InAhpr/k1qxPRrik1n
	 mpThczuoQu9aHnwknjbRBBKksxlvwJ21Ug+vqwddgRAmLa3VIRGYNYypGBEd5ja7eW
	 tg+xF0u0WvtuYS+0SiUtfq/k/DdLvnDmQGWLbj5R/llZkP1cZ+i1SCEkcxLlHiT0S/
	 rraG7M0VskdQg==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 10:17:44 +0200
Message-Id: <DC0AUNNAKGJI.4KX0TW6LG83Y@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, "David Gow" <davidgow@google.com>,
 <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] rust: block: convert `block::mq` to use
 `Refcount`
From: "Benno Lossin" <lossin@kernel.org>
To: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Tamir Duberstein" <tamird@gmail.com>, "Francesco
 Zardi" <frazar00@gmail.com>, "Antonio Hickey" <contact@antoniohickey.com>
X-Mailer: aerc 0.20.1
References: <20250723233312.3304339-1-gary@kernel.org>
 <20250723233312.3304339-5-gary@kernel.org>
In-Reply-To: <20250723233312.3304339-5-gary@kernel.org>

On Thu Jul 24, 2025 at 1:32 AM CEST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Currently there's a custom reference counting in `block::mq`, which uses
> `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
> architectures. We cannot just change it to use 32-bit atomics, because
> doing so will make it vulnerable to refcount overflow. So switch it to
> use the kernel refcount `kernel::sync::Refcount` instead.
>
> There is an operation needed by `block::mq`, atomically decreasing
> refcount from 2 to 0, which is not available through refcount.h, so
> I exposed `Refcount::as_atomic` which allows accessing the refcount
> directly.
>
> Tested-by: David Gow <davidgow@google.com>
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Benno Lossin <lossin@kernel.org>

> ---
>  rust/kernel/block/mq/operations.rs |  7 ++--
>  rust/kernel/block/mq/request.rs    | 63 ++++++++----------------------
>  rust/kernel/sync/refcount.rs       | 14 +++++++
>  3 files changed, 34 insertions(+), 50 deletions(-)

> diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
> index 3ff4585326b41..a9b24c6b2f8a7 100644
> --- a/rust/kernel/sync/refcount.rs
> +++ b/rust/kernel/sync/refcount.rs
> @@ -4,6 +4,8 @@
>  //!
>  //! C header: [`include/linux/refcount.h`](srctree/include/linux/refcoun=
t.h)
> =20
> +use core::sync::atomic::AtomicI32;
> +
>  use crate::build_assert;
>  use crate::types::Opaque;
> =20
> @@ -34,6 +36,18 @@ fn as_ptr(&self) -> *mut bindings::refcount_t {
>          self.0.get()
>      }
> =20
> +    /// Get the underlying atomic counter that backs the refcount.
> +    ///
> +    /// NOTE: This will be changed to LKMM atomic in the future.

Can we discourage using this function a bit more in the docs? At least
point people to try other ways before reaching for this, since it allows
overflowing & doesn't warn on saturate etc.

---
Cheers,
Benno

> +    #[inline]
> +    pub fn as_atomic(&self) -> &AtomicI32 {
> +        let ptr =3D self.0.get().cast();
> +        // SAFETY: `refcount_t` is a transparent wrapper of `atomic_t`, =
which is an atomic 32-bit
> +        // integer that is layout-wise compatible with `AtomicI32`. All =
values are valid for
> +        // `refcount_t`, despite some of the values being considered sat=
urated and "bad".
> +        unsafe { &*ptr }
> +    }
> +
>      /// Set a refcount's value.
>      #[inline]
>      pub fn set(&self, value: i32) {

