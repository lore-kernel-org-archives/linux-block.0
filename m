Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27111255E33;
	Wed, 19 Feb 2025 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004053; cv=none; b=nJItlsnHlolBU9YfbaPzrDqpZV/C54w1xSvCO8LIDmS7adYa9MpSi5eUdcVNMbcrcO24fz4OZGG2oUyyEWx06UqhqKooLs0UghEZ7bGikK4BFrXyPvQRyhkdsAELLLmqYbS8la9KmLLU1AVTL1m/xuGihVtpe4eLQ60KodZvjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004053; c=relaxed/simple;
	bh=uuxaA0G6AvhsM/dlN0tn/WqhHbkk7cb8NPQoka6G/wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTKoexb1IQgB85WC9xAuldFHvDi+uxyBE1xQi24ccvMzpdPI7B//TtKlSSPhDW9ZxuhguFzOWCXKDTfTUHsztGqQIX9Pp50GscIdRORxziqc4ufJsX6GO90lBHAdlIZtb4RpXpL6ORSakGFecgBoYLkrdhXZC/MMR9fxFyoO7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJEKuV3R; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJEKuV3R"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5461f2ca386so314396e87.1;
        Wed, 19 Feb 2025 14:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740004049; x=1740608849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpqP66NWlgamjSMzODA0iESe9VdTfgVBVKnr0zA03eI=;
        b=QJEKuV3RusjMgFR/vAC4tejeeQ7ud9scnYIzfaBdrco3x4/y9V2JBE7UN9vZaQgz4z
         8AkLY/ouHNY8pXYEt5kOvMBhfEMryxgKEHYMVH53P0XTQPRTxFfOWvZLvOtxOHTeF7st
         NQInThcHzJVQZQkIaUfbdFIuq6NMQP/vdMUC0XUIJekLx10BFKW6pU771HMTV1M11jtq
         6Fn5DcTBg74lnL3YsFpRCjQjMUnnq16uh7D+d9izC9W3Jn//1ETEx+4fRIXdLrlS5bv8
         9uQnYeidQOxg6K6rUJuYEI8Xdyn6ENxXaNIPMxM0JgE7vAyeRtTC6JXK5C+Xt36QEl61
         hdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740004049; x=1740608849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpqP66NWlgamjSMzODA0iESe9VdTfgVBVKnr0zA03eI=;
        b=jZ5gUh3rVVWre9iGwhsB3Y8oM2QECSXLGJgE5QhXnYIiSfGjJ4KAUk9JTgIsUwx8Bl
         qmYRaI5AFo3BNvOjHmGWoOeYewRPEiyon+27WFeF+S5DWL04yDil0Wy2jP5OiiMn/PBw
         MbIBIHRuczSl90Y8RjH+OJI6doA6Gwk8cd7cRafzkfeVCe2S+XGpG6AecT1eRC1THrzx
         p2Mi6VW+OxNub7z2XC5niWOqVvPVXk+hdRjzmS4szfvZeWE6niGnjVwyl9zkn3PVosST
         t0MH+gelGfjOzyOcP8rLFvWXetoqGQM+b+nq4qYcKttxqXMz6g0MJv4n/q/hoXMyD8Zh
         Ma+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwHLka+5EUabbKobgN84nyqmb4ynxyyKUJsrK5Q6DMKJGbyAGWaslE4RnRJx+wAmBZ7x+32WIcg37aTg==@vger.kernel.org, AJvYcCVqz1wsQQvBwAjZLsBmDiCwv9pn0K765Fgn38aQIiPxnezF2GA1TK/K33Ts0Us9gHRblDaJJwfbF3imljfp9Rk=@vger.kernel.org, AJvYcCX0FGNPk2X/CSJhNszLCJ3HZeNRQ1we28b6wPyd15JJWK9TbmsiTIUb5mKFxMhBacZiWsbP1kh2Z5vZUokM@vger.kernel.org
X-Gm-Message-State: AOJu0YxidwCV87zicPfH5uSC8zmXYOX7y+Ivx1WUGBJJ/NGmwWKJJtuF
	x7HA2RIA15JeqPETcn8h2ZCyb0IOwsyxGU/qfmnDy5q6aX1r+wFmm7SRGRNeShkTEgDBbGU7DKf
	0ouRNdheHN5MdE7KPeIZWApziXVk=
X-Gm-Gg: ASbGnctrzi+t5quhnBL0xMst94mtFxsxLRCsJlWbmR7jstkXwin8zNgTeSM2MTZNHar
	UdCranvwMucntD7if068racfwdDKSb91qn4oM+8rqJC+odJLnvA0kAu2yVXTEyUGDUy12Jme71o
	xKkepmkG5RKH50
X-Google-Smtp-Source: AGHT+IFYd0WxOth3Soo1AM5xnFH7hjAzKPV8nHVQ2FVRrG9DRAKKZ5s/W5Ifueor1bvoM4EiTl0pqK4Uk13L4M1rJog=
X-Received: by 2002:a05:6512:31d2:b0:545:2a96:34fc with SMTP id
 2adb3069b0e04-5452fe67dfamr8354642e87.31.1740004048753; Wed, 19 Feb 2025
 14:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219201602.1898383-1-gary@garyguo.net> <20250219201602.1898383-4-gary@garyguo.net>
In-Reply-To: <20250219201602.1898383-4-gary@garyguo.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Feb 2025 17:26:52 -0500
X-Gm-Features: AWEUYZmIa2HQuzFCzXR6Uu-xiFSZaw3ufv16hXIcgDpOJ1tIBiHbt84hXMjj6Lk
Message-ID: <CAJ-ks9=10h9ha403aqL20Yk+y0oXpgvR=hbxA2+6T_CvbXN2bA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] rust: block: convert `block::mq` to use `Refcount`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, 
	Francesco Zardi <frazar00@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:17=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
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
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/block/mq/operations.rs |  7 +--
>  rust/kernel/block/mq/request.rs    | 70 ++++++++++--------------------
>  rust/kernel/sync/refcount.rs       | 14 ++++++
>  3 files changed, 40 insertions(+), 51 deletions(-)
>
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/op=
erations.rs
> index 864ff379dc91..c399dcaa6740 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -10,9 +10,10 @@
>      block::mq::Request,
>      error::{from_result, Result},
>      prelude::*,
> +    sync::Refcount,
>      types::ARef,
>  };
> -use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::O=
rdering};
> +use core::marker::PhantomData;
>
>  /// Implement this trait to interface blk-mq as block devices.
>  ///
> @@ -78,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
>          let request =3D unsafe { &*(*bd).rq.cast::<Request<T>>() };
>
>          // One refcount for the ARef, one for being in flight
> -        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
> +        request.wrapper_ref().refcount().set(2);
>
>          // SAFETY:
>          //  - We own a refcount that we took above. We pass that to `ARe=
f`.
> @@ -187,7 +188,7 @@ impl<T: Operations> OperationsVTable<T> {
>
>              // SAFETY: The refcount field is allocated but not initializ=
ed, so
>              // it is valid for writes.
> -            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).writ=
e(AtomicU64::new(0)) };
> +            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).writ=
e(Refcount::new(0)) };

Could we just make the field pub and remove refcount_ptr? I believe a
few callers of `wrapper_ptr` could be replaced with `wrapper_ref`.

>
>              Ok(0)
>          })
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/reque=
st.rs
> index 7943f43b9575..7c782d70935e 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -8,12 +8,13 @@
>      bindings,
>      block::mq::Operations,
>      error::Result,
> +    sync::Refcount,
>      types::{ARef, AlwaysRefCounted, Opaque},
>  };
>  use core::{
>      marker::PhantomData,
>      ptr::{addr_of_mut, NonNull},
> -    sync::atomic::{AtomicU64, Ordering},
> +    sync::atomic::Ordering,
>  };
>
>  /// A wrapper around a blk-mq [`struct request`]. This represents an IO =
request.
> @@ -37,6 +38,9 @@
>  /// We need to track 3 and 4 to ensure that it is safe to end the reques=
t and hand
>  /// back ownership to the block layer.
>  ///
> +/// Note that driver can still obtain new `ARef` even if there is no `AR=
ef`s in existence by using

Is this missing an article? "The driver".

> +/// `tag_to_rq`, hence the need to distinct B and C.

s/distinct/distinguish/, I think.

> +///
>  /// The states are tracked through the private `refcount` field of
>  /// `RequestDataWrapper`. This structure lives in the private data area =
of the C
>  /// [`struct request`].
> @@ -98,13 +102,17 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Sel=
f>) {
>      ///
>      /// [`struct request`]: srctree/include/linux/blk-mq.h
>      fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, A=
Ref<Self>> {
> -        // We can race with `TagSet::tag_to_rq`
> -        if let Err(_old) =3D this.wrapper_ref().refcount().compare_excha=
nge(
> -            2,
> -            0,
> -            Ordering::Relaxed,
> -            Ordering::Relaxed,
> -        ) {
> +        // To hand back the ownership, we need the current refcount to b=
e 2.
> +        // Since we can race with `TagSet::tag_to_rq`, this needs to ato=
mically reduce
> +        // refcount to 0. `Refcount` does not provide a way to do this, =
so use the underlying
> +        // atomics directly.
> +        if this
> +            .wrapper_ref()
> +            .refcount()
> +            .as_atomic()
> +            .compare_exchange(2, 0, Ordering::Relaxed, Ordering::Relaxed=
)
> +            .is_err()

The previous `if let` was a bit more clear about what's being
discarded here (the previous value). This information is lost with
`is_err()`.

> +        {
>              return Err(this);
>          }
>
> @@ -168,13 +176,13 @@ pub(crate) struct RequestDataWrapper {
>      /// - 0: The request is owned by C block layer.
>      /// - 1: The request is owned by Rust abstractions but there are no =
[`ARef`] references to it.
>      /// - 2+: There are [`ARef`] references to the request.
> -    refcount: AtomicU64,
> +    refcount: Refcount,
>  }
>
>  impl RequestDataWrapper {
>      /// Return a reference to the refcount of the request that is embedd=
ing
>      /// `self`.
> -    pub(crate) fn refcount(&self) -> &AtomicU64 {
> +    pub(crate) fn refcount(&self) -> &Refcount {
>          &self.refcount
>      }
>
> @@ -184,7 +192,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
>      /// # Safety
>      ///
>      /// - `this` must point to a live allocation of at least the size of=
 `Self`.
> -    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64=
 {
> +    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut Refcount =
{
>          // SAFETY: Because of the safety requirements of this function, =
the
>          // field projection is safe.
>          unsafe { addr_of_mut!((*this).refcount) }
> @@ -200,47 +208,13 @@ unsafe impl<T: Operations> Send for Request<T> {}
>  // mutate `self` are internally synchronized`
>  unsafe impl<T: Operations> Sync for Request<T> {}
>
> -/// Store the result of `op(target.load())` in target, returning new val=
ue of
> -/// target.
> -fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64)=
 -> u64 {
> -    let old =3D target.fetch_update(Ordering::Relaxed, Ordering::Relaxed=
, |x| Some(op(x)));
> -
> -    // SAFETY: Because the operation passed to `fetch_update` above alwa=
ys
> -    // return `Some`, `old` will always be `Ok`.
> -    let old =3D unsafe { old.unwrap_unchecked() };
> -
> -    op(old)
> -}
> -
> -/// Store the result of `op(target.load)` in `target` if `target.load() =
!=3D
> -/// pred`, returning [`true`] if the target was updated.
> -fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64,=
 pred: u64) -> bool {
> -    target
> -        .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
> -            if x =3D=3D pred {
> -                None
> -            } else {
> -                Some(op(x))
> -            }
> -        })
> -        .is_ok()
> -}
> -
>  // SAFETY: All instances of `Request<T>` are reference counted. This
>  // implementation of `AlwaysRefCounted` ensure that increments to the re=
f count
>  // keeps the object alive in memory at least until a matching reference =
count
>  // decrement is executed.
>  unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
>      fn inc_ref(&self) {
> -        let refcount =3D &self.wrapper_ref().refcount();
> -
> -        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
> -        let updated =3D atomic_relaxed_op_unless(refcount, |x| x + 1, 0)=
;
> -
> -        #[cfg(CONFIG_DEBUG_MISC)]
> -        if !updated {
> -            panic!("Request refcount zero on clone")
> -        }
> +        self.wrapper_ref().refcount().inc();
>      }
>
>      unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
> @@ -252,10 +226,10 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
>          let refcount =3D unsafe { &*RequestDataWrapper::refcount_ptr(wra=
pper_ptr) };
>
>          #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
> -        let new_refcount =3D atomic_relaxed_op_return(refcount, |x| x - =
1);
> +        let is_zero =3D refcount.dec_and_test();

Should this call .dec() if not(CONFIG_DEBUG_MISC)?

>
>          #[cfg(CONFIG_DEBUG_MISC)]
> -        if new_refcount =3D=3D 0 {
> +        if is_zero {
>              panic!("Request reached refcount zero in Rust abstractions")=
;
>          }
>      }
> diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
> index a6a683f5d7b8..3d7a1ffb3a46 100644
> --- a/rust/kernel/sync/refcount.rs
> +++ b/rust/kernel/sync/refcount.rs
> @@ -4,6 +4,8 @@
>  //!
>  //! C header: [`include/linux/refcount.h`](srctree/include/linux/refcoun=
t.h)
>
> +use core::sync::atomic::AtomicI32;
> +
>  use crate::types::Opaque;
>
>  /// Atomic reference counter.
> @@ -30,6 +32,18 @@ fn as_ptr(&self) -> *mut bindings::refcount_t {
>          self.0.get()
>      }
>
> +    /// Get the underlying atomic counter that backs the refcount.
> +    ///
> +    /// NOTE: This will be changed to LKMM atomic in the future.
> +    #[inline]
> +    pub fn as_atomic(&self) -> &AtomicI32 {
> +        let ptr =3D self.0.get() as *const AtomicI32;

Prefer `.cast()` to raw pointer casting please.

> +        // SAFETY: `refcount_t` is a transparent wrapper of `atomic_t`, =
which is an atomic 32-bit
> +        // integer that is layout-wise compatible with `AtomicI32`. All =
values are valid for
> +        // `refcount_t`, despite some of the values are considered satur=
ated and "bad".

Grammer: s/are/being/.

Is there a citation you can link to here?

> +        unsafe { &*ptr }
> +    }
> +
>      /// Set a refcount's value.
>      #[inline]
>      pub fn set(&self, value: i32) {
> --
> 2.47.2
>
>
