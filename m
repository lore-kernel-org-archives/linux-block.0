Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91543214A84
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787466; cv=none; b=SXJU1LtLp334SCp0GxzPDpbFkx4kOxBLymuY7XglmKjN5UMlqupMANcV4Ffq3PEpHwS9R5gYbQ8e11DtPVQwy46+DOT2WX9toMkVBkxyWEMmENlRN/mILL+kWNbI/wAnf0Ox+SceIjhh0fK3hfwtE4cS+QpIXRdJYmvAi+bNc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787466; c=relaxed/simple;
	bh=G2BFvixwkMGuyat+ysHlR5LQgZOPVhcp+i/Lp4e/Q8k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoU6yHT2jWfwhgVcXnTm6H7vJiGqaHIHkggiaWhv4Vn0Kh89yHK6tZ41L8Bo434sBNXwVa/Kdw7u0kvXJfpyQNLU13Lj1akobpqqGG/I1NbqUg0zSGfoK+owGu+TaA78k57k+nK/5k24IZGPL1w/CV9nWSIQsQL6sK1/Cku5x5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DGkT/j2n; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DGkT/j2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1738787456; x=1739046656;
	bh=QcIutq2h8aMzJgTTWdf+LfKW/kL1qkzR7Y5jU05xCbs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DGkT/j2n9dxkboW5bhCoh7seMiNfmqzaoMYfNjmD4hdGKy5LQtYQ+92zwBD+9pIXe
	 yrdPFXn8uvdDJV12lL7UD8Aq6NQ4T9wbwTbxYqEG/I7WqeCRqqSjDCa3BfV2XJHsID
	 /tvrTiMASlO0ZEhlOp9HzVYfFyTR6Ur5BS9oqZpSkwGHdH47a72U0hXO/YhG6jNThM
	 400iqxQ/61n44R3fRgOqlVFy28bL4n9dS7qBlFAdpLPjnL8HG3BHqPG7124iQQTqyd
	 3BmQBzQp2OqTgq8JzeVnXmvP3I6JIKZ93BZt9EmsLY1d188UMZcJybkDF07Gb15TD7
	 Ta760h6ks45FQ==
Date: Wed, 05 Feb 2025 20:30:50 +0000
To: Mitchell Levy <levymitchell0@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: lockdep: Use Pin for all LockClassKey usages
Message-ID: <19dfbe36-237c-4da8-acfb-1d14069a8d1c@proton.me>
In-Reply-To: <20250205-rust-lockdep-v3-2-5313e83a0bef@gmail.com>
References: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com> <20250205-rust-lockdep-v3-2-5313e83a0bef@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0a471865454d10379c75b2737ae638194384f16f
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.02.25 20:59, Mitchell Levy wrote:
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 41dcddac69e2..119e5f569bdb 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -7,12 +7,9 @@
>=20
>  use super::LockClassKey;
>  use crate::{
> -    init::PinInit,
> -    pin_init,
> -    str::CStr,
> -    types::{NotThreadSafe, Opaque, ScopeGuard},
> +    init::PinInit, pin_init, str::CStr, types::NotThreadSafe, types::Opa=
que, types::ScopeGuard,
>  };
> -use core::{cell::UnsafeCell, marker::PhantomPinned};
> +use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
>  use macros::pin_data;
>=20
>  pub mod mutex;
> @@ -121,7 +118,7 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lo=
ck<T, B> {}
>=20
>  impl<T, B: Backend> Lock<T, B> {
>      /// Constructs a new lock initialiser.
> -    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) ->=
 impl PinInit<Self> {
> +    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey=
>) -> impl PinInit<Self> {

Static references do not need `Pin`, since `Pin::static_ref` [1] exists,
so you can just as well not add the `Pin` here and the other places
where you have `Pin<&'static T>`.

The reasoning is that since the data lives for `'static` at that
location, it will never move (since it is borrowed for `'static` after
all).

[1]: https://doc.rust-lang.org/std/pin/struct.Pin.html#method.static_ref

---
Cheers,
Benno

>          pin_init!(Self {
>              data: UnsafeCell::new(t),
>              _pin: PhantomPinned,
> diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/glob=
al.rs
> index 480ee724e3cc..d65f94b5caf2 100644
> --- a/rust/kernel/sync/lock/global.rs
> +++ b/rust/kernel/sync/lock/global.rs
> @@ -13,6 +13,7 @@
>  use core::{
>      cell::UnsafeCell,
>      marker::{PhantomData, PhantomPinned},
> +    pin::Pin,
>  };
>=20
>  /// Trait implemented for marker types for global locks.

