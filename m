Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE19417085C;
	Mon,  9 Sep 2024 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916684; cv=none; b=bplGWhzu0s01oW2VtvpCKFXhGUgv5A8PIC3Q6s5jklquHCrbzT/8XG3xZRFjnoPtlXPgemmKUm5UHYwKTSn3CNzSgVO6+JtaxFts78k3gUlQ0GMTvCYTvaixY6v1mxl/rjkrHYDMjHwdPJQsk2lhM8/fHdy5XVUR7K0an2Uw9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916684; c=relaxed/simple;
	bh=8dD8qWypGnCFacam4LF8FYB6oNE4Yete5auyayOtlj8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ggz2qC4972/WFNg8e4TsBN24JB7pOPJ/XbXdZm1QqtWi3M5CEVUQeJXLcU0JobGua7qDD04oX8XPDMPDELUlEhGEtxrzlqdyn2sdWiptUuzaUklvj70zWQ1uMS8QxiiHKhqo8X5Eu7tW+gQH9baL7MkcfRmA+OrE5mvr3g1yvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=W/8gJ34V; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="W/8gJ34V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725916679; x=1726175879;
	bh=mKJSL1WLkzQQfvSewxHUvxherY3mwVtPg6Pj0SUV9M0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W/8gJ34Vlduij03PSusMjXeyWnVjahDQTI4wSQVHNkFDDreSbda/3xMgKyX5H1zEq
	 g/hKMF7TeYEGxjpegxpuM8l+9l+pbFRWABasYYiO1oJh1BYCuW+T3Hv9fFJPxlAVC2
	 qvtGbgTwKmWkIXPHpBk8eygy9guKwoden/nwKKovkeBoBwLCNwhtrpr6zxAEmbWAmi
	 eJc1aknwFxj7nag1NsYQtgrd7oIAmce6u3Y77i0NxdWRvGLjC4SnmXnteIBMOSpOs5
	 O5iPfg+L/RYIpcQhbgb4atoC//aunM3O5AcwXT7UsARypyDJY88avMjdXZBH44up24
	 gyQai3zNi15tg==
Date: Mon, 09 Sep 2024 21:17:54 +0000
To: levymitchell0@gmail.com, Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rust: lockdep: Use Pin for all LockClassKey usages
Message-ID: <75b6167d-ed22-4c7f-b2a2-390d938a7f1a@proton.me>
In-Reply-To: <20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com>
References: <20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6689aa314c1e5f79ad7e9e9dcd6c667a849523dc
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.09.24 01:13, Mitchell Levy via B4 Relay wrote:
> From: Mitchell Levy <levymitchell0@gmail.com>
>=20
> The current LockClassKey API has soundness issues related to the use of
> dynamically allocated LockClassKeys. In particular, these keys can be
> used without being registered and don't have address stability.
>=20
> This fixes the issue by using Pin<&LockClassKey> and properly
> registering/deregistering the keys on init/drop.
>=20
> Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-1-nmi=
@metaspace.dk/
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
> This change is based on applying the linked patch to the top of
> rust-next.
>=20
> I'm sending this as an RFC because I'm not sure that using
> Pin<&'static LockClassKey> is appropriate as the parameter for, e.g.,
> Work::new. This should preclude using dynamically allocated
> LockClassKeys here, which might not be desirable. Unfortunately, using
> Pin<&'a LockClassKey> creates other headaches as the compiler then
> requires that T and PinImpl<Self> be bounded by 'a, which also seems
> undesirable. I would be especially interested in feedback/ideas along
> these lines.
> ---
>  rust/kernel/block/mq/gen_disk.rs |  2 +-
>  rust/kernel/sync.rs              | 30 +++++++++++++++++++++---------
>  rust/kernel/sync/condvar.rs      | 13 ++++++++-----
>  rust/kernel/sync/lock.rs         |  6 +++---
>  rust/kernel/workqueue.rs         |  6 +++---
>  5 files changed, 36 insertions(+), 21 deletions(-)

When I try to build with LOCKDEP=3Dn, then I get this error:

    error[E0425]: cannot find function `lockdep_register_key` in crate `bin=
dings`
      --> rust/kernel/sync.rs:40:65
       |
    40 |             inner <- Opaque::ffi_init(|slot| unsafe { bindings::lo=
ckdep_register_key(slot) })
       |                                                                 ^^=
^^^^^^^^^^^^^^^^^^ not found in `bindings`
   =20
    error[E0425]: cannot find function `lockdep_unregister_key` in crate `b=
indings`
      --> rust/kernel/sync.rs:52:28
       |
    52 |         unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
       |

> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_=
disk.rs
> index 708125dce96a..706ac3c532d5 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -108,7 +108,7 @@ pub fn build<T: Operations>(
>                  tagset.raw_tag_set(),
>                  &mut lim,
>                  core::ptr::null_mut(),
> -                static_lock_class!().as_ptr(),
> +                static_lock_class!().get_ref().as_ptr(),

Why do we need the `get_ref()` calls? `Pin<&T>` implements
`Deref<Target =3D T>`, so I don't think that it is necessary to add the
`get_ref` calls.

>              )
>          })?;
>=20
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 0ab20975a3b5..c46a296cbe6d 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -5,6 +5,8 @@
>  //! This module contains the kernel APIs related to synchronisation that=
 have been ported or
>  //! wrapped for usage by Rust code in the kernel.
>=20
> +use crate::pin_init;
> +use crate::prelude::*;
>  use crate::types::Opaque;
>=20
>  mod arc;
> @@ -20,7 +22,11 @@
>=20
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_ke=
y`.
>  #[repr(transparent)]
> -pub struct LockClassKey(Opaque<bindings::lock_class_key>);
> +#[pin_data(PinnedDrop)]
> +pub struct LockClassKey {
> +    #[pin]
> +    inner: Opaque<bindings::lock_class_key>,
> +}
>=20
>  // SAFETY: `bindings::lock_class_key` is designed to be used concurrentl=
y from multiple threads and
>  // provides its own synchronization.
> @@ -28,18 +34,22 @@ unsafe impl Sync for LockClassKey {}
>=20
>  impl LockClassKey {
>      /// Creates a new lock class key.
> -    pub const fn new() -> Self {
> -        Self(Opaque::uninit())
> +    pub fn new_dynamic() -> impl PinInit<Self> {

Can you add some more documentation on this function? For example:
- directing people to use `static_lock_class!` if they only need a
  static key (AFAIK that is the common use-case).
- Also would be nice if we had an example here.
- I would change the first line to be "Creates a dynamic lock class
  key.".

> +        pin_init!(Self {
> +            // SAFETY: lockdep_register_key expects an uninitialized blo=
ck of memory
> +            inner <- Opaque::ffi_init(|slot| unsafe { bindings::lockdep_=
register_key(slot) })
> +        })
>      }
>=20
>      pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> -        self.0.get()
> +        self.inner.get()
>      }
>  }
>=20
> -impl Default for LockClassKey {
> -    fn default() -> Self {
> -        Self::new()
> +#[pinned_drop]
> +impl PinnedDrop for LockClassKey {
> +    fn drop(self: Pin<&mut Self>) {
> +        unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
>      }
>  }
>=20
> @@ -48,8 +58,10 @@ fn default() -> Self {
>  #[macro_export]
>  macro_rules! static_lock_class {
>      () =3D> {{
> -        static CLASS: $crate::sync::LockClassKey =3D $crate::sync::LockC=
lassKey::new();
> -        &CLASS
> +        static CLASS: $crate::sync::LockClassKey =3D unsafe {
> +            ::core::mem::MaybeUninit::uninit().assume_init()
> +        };
> +        $crate::prelude::Pin::static_ref(&CLASS)

Just to make sure we get it right this time, is this true: "static
`lock_class_key` values don't need to be initialized."?

>      }};
>  }
>=20
> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> index 2b306afbe56d..6c40b45e35cd 100644
> --- a/rust/kernel/sync/condvar.rs
> +++ b/rust/kernel/sync/condvar.rs
> @@ -14,9 +14,12 @@
>      time::Jiffies,
>      types::Opaque,
>  };
> -use core::ffi::{c_int, c_long};
> -use core::marker::PhantomPinned;
> -use core::ptr;
> +use core::{
> +    ffi::{c_int, c_long},
> +    marker::PhantomPinned,
> +    pin::Pin,
> +    ptr,
> +};
>  use macros::pin_data;
>=20
>  /// Creates a [`CondVar`] initialiser with the given name and a newly-cr=
eated lock class.
> @@ -102,13 +105,13 @@ unsafe impl Sync for CondVar {}
>=20
>  impl CondVar {
>      /// Constructs a new condvar initialiser.
> -    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl =
PinInit<Self> {
> +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> =
impl PinInit<Self> {
>          pin_init!(Self {
>              _pin: PhantomPinned,
>              // SAFETY: `slot` is valid while the closure is called and b=
oth `name` and `key` have
>              // static lifetimes so they live indefinitely.
>              wait_queue_head <- Opaque::ffi_init(|slot| unsafe {
> -                bindings::__init_waitqueue_head(slot, name.as_char_ptr()=
, key.as_ptr())
> +                bindings::__init_waitqueue_head(slot, name.as_char_ptr()=
, key.get_ref().as_ptr())
>              }),
>          })
>      }
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f6c34ca4d819..c6bdbb85a39c 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -7,7 +7,7 @@
>=20
>  use super::LockClassKey;
>  use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::Sc=
opeGuard};
> -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned}=
;
> +use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned,=
 pin::Pin};
>  use macros::pin_data;
>=20
>  pub mod mutex;
> @@ -106,14 +106,14 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for =
Lock<T, B> {}
>=20
>  impl<T, B: Backend> Lock<T, B> {
>      /// Constructs a new lock initialiser.
> -    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) ->=
 impl PinInit<Self> {
> +    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey=
>) -> impl PinInit<Self> {
>          pin_init!(Self {
>              data: UnsafeCell::new(t),
>              _pin: PhantomPinned,
>              // SAFETY: `slot` is valid while the closure is called and b=
oth `name` and `key` have
>              // static lifetimes so they live indefinitely.
>              state <- Opaque::ffi_init(|slot| unsafe {
> -                B::init(slot, name.as_char_ptr(), key.as_ptr())
> +                B::init(slot, name.as_char_ptr(), key.get_ref().as_ptr()=
)
>              }),
>          })
>      }
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 553a5cba2adc..eefc2b7b578c 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -367,9 +367,9 @@ impl<T: ?Sized, const ID: u64> Work<T, ID> {
>      /// Creates a new instance of [`Work`].
>      #[inline]
>      #[allow(clippy::new_ret_no_self)]
> -    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl =
PinInit<Self>
> +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> =
impl PinInit<Self>
>      where
> -        T: WorkItem<ID>,
> +        T: WorkItem<ID>

`rustfmt` re-adds the comma. It also formats other parts of your patch
differently. You can run it using the `rustfmt` target.

---
Cheers,
Benno

>      {
>          pin_init!(Self {
>              work <- Opaque::ffi_init(|slot| {
> @@ -381,7 +381,7 @@ pub fn new(name: &'static CStr, key: &'static LockCla=
ssKey) -> impl PinInit<Self
>                          Some(T::Pointer::run),
>                          false,
>                          name.as_char_ptr(),
> -                        key.as_ptr(),
> +                        key.get_ref().as_ptr(),
>                      )
>                  }
>              }),
>=20
> ---
> base-commit: 8edf38a534a38e5d78470a98d43454e3b73e307c
> change-id: 20240905-rust-lockdep-d3e30521c8ba
>=20
> Best regards,
> --
> Mitchell Levy <levymitchell0@gmail.com>
>=20
>=20

