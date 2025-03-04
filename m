Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BE0276D3B;
	Tue,  4 Mar 2025 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128941; cv=none; b=pzlO5Br7ODdKB+aqzd5NPTCIpvDrGmBMhLC32jn5grs9J1U7hpoTI0yu/5kM2Z39CgloqKZAr6z465ecxJ84pnweXEcxbCKwwNBUGVZI+0uVHss+wO3m1HxGq1wMbHH7spU3QsueZJJKqGUeu1O9cdhxLT0Lhkk/gD1Rwu+oFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128941; c=relaxed/simple;
	bh=OzhAxJvzqAPprjmPo4ncefZhaOWH3cNU1YIdV16kJJA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtyDmhc8l+/dEPY+S53zAeViSZpwubQTAK/l0GQGZ8JCnT1CG04C/OEjoHBmfXRDmC0BGFp3i8M8jhR1fHCd4KPTaeg1zJ3LvZKwjzcetHdI7jodqGg22uCY9T00096kKVf2u/s9YghrZJCadincJiG8S3KFbq2DuE3Q9WM1fOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=f/pwDvKe; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="f/pwDvKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128930; x=1741388130;
	bh=hteH1YUNOelIYd+Dia9+hqyI6Irgbctlm52+5LLSxZk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=f/pwDvKeiDkdaS3EFSBUKDwWEFYgsBVrRADC8IugpBsSYS7H/b35ZgJfAColnmHRB
	 eESz0I8jNNQln1Y3tOJUbKj7bI+kol3A/lXndHAXC7PbSV8B3SnLqzLuKG2LMa3Svq
	 q+P8adYoIAOCkVKkD4Vastj3/ibaXdUeuJEQSmqDP/JRTOF7xWOG6uYkiC/2C7SO1I
	 zoxDgcDKuJw1A/8fAYkPrlOJj78wB/d2N1P0G/NKrHVrDbTSS1cVl7I2TpliGm94WH
	 muo0H6Am56fZKMUyh+nfLgnqgot2I6peluo1QFZTZg7X+JbUys07cKW8//V+Jfriuq
	 /ttrGUOYGdWVQ==
Date: Tue, 04 Mar 2025 22:55:21 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 15/22] rust: make pin-init its own crate
Message-ID: <20250304225245.2033120-16-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 39f56309c731647e75752cb6b7594b2e2e44e857
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rename relative paths inside of the crate to still refer to the same
items, also rename paths inside of the kernel crate and adjust the build
system to build the crate.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/Makefile                             |  12 +--
 rust/kernel/alloc/kbox.rs                 |   4 +-
 rust/kernel/block/mq/tag_set.rs           |   5 +-
 rust/kernel/driver.rs                     |   6 +-
 rust/kernel/init.rs                       |  22 +++--
 rust/kernel/lib.rs                        |  10 +-
 rust/kernel/list.rs                       |   2 +-
 rust/kernel/prelude.rs                    |   8 +-
 rust/kernel/sync/arc.rs                   |   7 +-
 rust/kernel/sync/condvar.rs               |   4 +-
 rust/kernel/sync/lock.rs                  |   4 +-
 rust/kernel/sync/lock/mutex.rs            |   2 +-
 rust/kernel/sync/lock/spinlock.rs         |   2 +-
 rust/kernel/types.rs                      |  10 +-
 rust/macros/helpers.rs                    |   4 +-
 rust/macros/lib.rs                        |  11 +--
 rust/macros/module.rs                     |   2 +-
 rust/macros/quote.rs                      |   1 +
 rust/pin-init/internal/src/_lib.rs        |   3 -
 rust/pin-init/internal/src/helpers.rs     |   2 +
 rust/pin-init/internal/src/lib.rs         |  16 ++++
 rust/pin-init/internal/src/pin_data.rs    |   4 +-
 rust/pin-init/internal/src/pinned_drop.rs |   4 +-
 rust/pin-init/internal/src/zeroable.rs    |   8 +-
 rust/pin-init/src/_lib.rs                 |   5 -
 rust/pin-init/src/lib.rs                  |  46 +++++----
 rust/pin-init/src/macros.rs               | 111 +++++++++++-----------
 scripts/generate_rust_analyzer.py         |   4 +-
 28 files changed, 166 insertions(+), 153 deletions(-)
 delete mode 100644 rust/pin-init/internal/src/_lib.rs
 delete mode 100644 rust/pin-init/src/_lib.rs

diff --git a/rust/Makefile b/rust/Makefile
index 90310f0620eb..e761a8cc3bd5 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -116,13 +116,13 @@ rustdoc-ffi: $(src)/ffi.rs rustdoc-core FORCE
 rustdoc-pin_init_internal: private rustdoc_host =3D yes
 rustdoc-pin_init_internal: private rustc_target_flags =3D --cfg kernel \
     --extern proc_macro --crate-type proc-macro
-rustdoc-pin_init_internal: $(src)/pin-init/internal/src/_lib.rs FORCE
+rustdoc-pin_init_internal: $(src)/pin-init/internal/src/lib.rs FORCE
 =09+$(call if_changed,rustdoc)
=20
 rustdoc-pin_init: private rustdoc_host =3D yes
 rustdoc-pin_init: private rustc_target_flags =3D --extern pin_init_interna=
l \
     --extern macros --extern alloc --cfg kernel --cfg feature=3D\"alloc\"
-rustdoc-pin_init: $(src)/pin-init/src/_lib.rs rustdoc-pin_init_internal \
+rustdoc-pin_init: $(src)/pin-init/src/lib.rs rustdoc-pin_init_internal \
     rustdoc-macros FORCE
 =09+$(call if_changed,rustdoc)
=20
@@ -158,12 +158,12 @@ rusttestlib-macros: $(src)/macros/lib.rs FORCE
 rusttestlib-pin_init_internal: private rustc_target_flags =3D --cfg kernel=
 \
     --extern proc_macro
 rusttestlib-pin_init_internal: private rustc_test_library_proc =3D yes
-rusttestlib-pin_init_internal: $(src)/pin-init/internal/src/_lib.rs FORCE
+rusttestlib-pin_init_internal: $(src)/pin-init/internal/src/lib.rs FORCE
 =09+$(call if_changed,rustc_test_library)
=20
 rusttestlib-pin_init: private rustc_target_flags =3D --extern pin_init_int=
ernal \
     --extern macros --cfg kernel
-rusttestlib-pin_init: $(src)/pin-init/src/_lib.rs rusttestlib-macros \
+rusttestlib-pin_init: $(src)/pin-init/src/lib.rs rusttestlib-macros \
     rusttestlib-pin_init_internal $(obj)/$(libpin_init_internal_name) FORC=
E
 =09+$(call if_changed,rustc_test_library)
=20
@@ -401,7 +401,7 @@ $(obj)/$(libmacros_name): $(src)/macros/lib.rs FORCE
 =09+$(call if_changed_dep,rustc_procmacro)
=20
 $(obj)/$(libpin_init_internal_name): private rustc_target_flags =3D --cfg =
kernel
-$(obj)/$(libpin_init_internal_name): $(src)/pin-init/internal/src/_lib.rs =
FORCE
+$(obj)/$(libpin_init_internal_name): $(src)/pin-init/internal/src/lib.rs F=
ORCE
 =09+$(call if_changed_dep,rustc_procmacro)
=20
 quiet_cmd_rustc_library =3D $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QU=
IET)) L $@
@@ -486,7 +486,7 @@ $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs=
 $(obj)/core.o FORCE
 $(obj)/pin_init.o: private skip_gendwarfksyms =3D 1
 $(obj)/pin_init.o: private rustc_target_flags =3D --extern pin_init_intern=
al \
     --extern macros --cfg kernel
-$(obj)/pin_init.o: $(src)/pin-init/src/_lib.rs $(obj)/compiler_builtins.o =
\
+$(obj)/pin_init.o: $(src)/pin-init/src/lib.rs $(obj)/compiler_builtins.o \
     $(obj)/$(libpin_init_internal_name) $(obj)/$(libmacros_name) FORCE
 =09+$(call if_changed_rule,rustc_library)
=20
diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 07150c038e3f..e6200cd1d06d 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -15,9 +15,9 @@
 use core::ptr::NonNull;
 use core::result::Result;
=20
-use crate::init::{InPlaceWrite, Init, PinInit, ZeroableOption};
-use crate::init_ext::InPlaceInit;
+use crate::init::InPlaceInit;
 use crate::types::ForeignOwnable;
+use pin_init::{InPlaceWrite, Init, PinInit, ZeroableOption};
=20
 /// The kernel's [`Box`] type -- a heap allocation for a single value of t=
ype `T`.
 ///
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set=
.rs
index 00ddcc71dfa2..bcf4214ad149 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -10,12 +10,11 @@
     bindings,
     block::mq::{operations::OperationsVTable, request::RequestDataWrapper,=
 Operations},
     error,
-    prelude::PinInit,
-    try_pin_init,
+    prelude::try_pin_init,
     types::Opaque,
 };
 use core::{convert::TryInto, marker::PhantomData};
-use macros::{pin_data, pinned_drop};
+use pin_init::{pin_data, pinned_drop, PinInit};
=20
 /// A wrapper for the C `struct blk_mq_tag_set`.
 ///
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 2a16d5e64e6c..ec9166cedfa7 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -6,9 +6,9 @@
 //! register using the [`Registration`] class.
=20
 use crate::error::{Error, Result};
-use crate::{device, init::PinInit, of, str::CStr, try_pin_init, types::Opa=
que, ThisModule};
+use crate::{device, of, str::CStr, try_pin_init, types::Opaque, ThisModule=
};
 use core::pin::Pin;
-use macros::{pin_data, pinned_drop};
+use pin_init::{pin_data, pinned_drop, PinInit};
=20
 /// The [`RegistrationOps`] trait serves as generic interface for subsyste=
ms (e.g., PCI, Platform,
 /// Amba, etc.) to provide the corresponding subsystem specific implementa=
tion to register /
@@ -114,7 +114,7 @@ struct DriverModule {
         impl $crate::InPlaceModule for DriverModule {
             fn init(
                 module: &'static $crate::ThisModule
-            ) -> impl $crate::init::PinInit<Self, $crate::error::Error> {
+            ) -> impl ::pin_init::PinInit<Self, $crate::error::Error> {
                 $crate::try_pin_init!(Self {
                     _driver <- $crate::driver::Registration::new(
                         <Self as $crate::ModuleMetadata>::NAME,
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index d8eb6d7873b7..32d6e4167650 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -23,7 +23,7 @@
 //!
 //! [`Opaque<T>`]: crate::types::Opaque
 //! [`Opaque::ffi_init`]: crate::types::Opaque::ffi_init
-//! [`pin_init!`]: crate::pin_init
+//! [`pin_init!`]: pin_init::pin_init
 //!
 //! # Examples
 //!
@@ -137,8 +137,8 @@
 use crate::{
     alloc::{AllocError, Flags},
     error::{self, Error},
-    init::{init_from_closure, pin_init_from_closure, Init, PinInit},
 };
+use pin_init::{init_from_closure, pin_init_from_closure, Init, PinInit};
=20
 /// Smart pointer that can initialize memory in-place.
 pub trait InPlaceInit<T>: Sized {
@@ -205,7 +205,8 @@ fn init<E>(init: impl Init<T, E>, flags: Flags) -> erro=
r::Result<Self>
 /// # Examples
 ///
 /// ```rust
-/// use kernel::{init::zeroed, error::Error};
+/// use kernel::error::Error;
+/// use pin_init::zeroed;
 /// struct BigBuf {
 ///     big: KBox<[u8; 1024 * 1024 * 1024]>,
 ///     small: [u8; 1024 * 1024],
@@ -222,7 +223,7 @@ fn init<E>(init: impl Init<T, E>, flags: Flags) -> erro=
r::Result<Self>
 /// ```
 ///
 /// [`Infallible`]: core::convert::Infallible
-/// [`init!`]: crate::init!
+/// [`init!`]: pin_init::init
 /// [`try_pin_init!`]: crate::try_pin_init!
 /// [`Error`]: crate::error::Error
 #[macro_export]
@@ -230,14 +231,14 @@ macro_rules! try_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::_try_init!($(&$this in)? $t $(::<$($generics),* $(,)?>)? {
+        ::pin_init::try_init!($(&$this in)? $t $(::<$($generics),* $(,)?>)=
? {
             $($fields)*
         }? $crate::error::Error)
     };
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }? $err:ty) =3D> {
-        $crate::_try_init!($(&$this in)? $t $(::<$($generics),* $(,)?>)? {
+        ::pin_init::try_init!($(&$this in)? $t $(::<$($generics),* $(,)?>)=
? {
             $($fields)*
         }? $err)
     };
@@ -262,7 +263,8 @@ macro_rules! try_init {
 ///
 /// ```rust
 /// # #![feature(new_uninit)]
-/// use kernel::{init::zeroed, error::Error};
+/// use kernel::error::Error;
+/// use pin_init::zeroed;
 /// #[pin_data]
 /// struct BigBuf {
 ///     big: KBox<[u8; 1024 * 1024 * 1024]>,
@@ -282,21 +284,21 @@ macro_rules! try_init {
 /// ```
 ///
 /// [`Infallible`]: core::convert::Infallible
-/// [`pin_init!`]: crate::pin_init
+/// [`pin_init!`]: pin_init::pin_init
 /// [`Error`]: crate::error::Error
 #[macro_export]
 macro_rules! try_pin_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::_try_pin_init!($(&$this in)? $t $(::<$($generics),* $(,)?>=
)? {
+        ::pin_init::try_pin_init!($(&$this in)? $t $(::<$($generics),* $(,=
)?>)? {
             $($fields)*
         }? $crate::error::Error)
     };
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }? $err:ty) =3D> {
-        $crate::_try_pin_init!($(&$this in)? $t $(::<$($generics),* $(,)?>=
)? {
+        ::pin_init::try_pin_init!($(&$this in)? $t $(::<$($generics),* $(,=
)?>)? {
             $($fields)*
         }? $err)
     };
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e3933f3dfc0b..c92497c7c655 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -50,11 +50,7 @@
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
 pub mod fs;
-#[path =3D "../pin-init/src/lib.rs"]
 pub mod init;
-// momentarily use the name `init_ext` and set the path manually
-#[path =3D "init.rs"]
-pub mod init_ext;
 pub mod io;
 pub mod ioctl;
 pub mod jump_label;
@@ -116,11 +112,11 @@ pub trait InPlaceModule: Sync + Send {
     /// Creates an initialiser for the module.
     ///
     /// It is called when the module is loaded.
-    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error=
::Error>;
+    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, e=
rror::Error>;
 }
=20
 impl<T: Module> InPlaceModule for T {
-    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error=
::Error> {
+    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, e=
rror::Error> {
         let initer =3D move |slot: *mut Self| {
             let m =3D <Self as Module>::init(module)?;
=20
@@ -130,7 +126,7 @@ fn init(module: &'static ThisModule) -> impl init::PinI=
nit<Self, error::Error> {
         };
=20
         // SAFETY: On success, `initer` always fully initialises an instan=
ce of `Self`.
-        unsafe { init::pin_init_from_closure(initer) }
+        unsafe { pin_init::pin_init_from_closure(initer) }
     }
 }
=20
diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index fb93330f4af4..717e98e71f65 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -4,12 +4,12 @@
=20
 //! A linked list implementation.
=20
-use crate::init::PinInit;
 use crate::sync::ArcBorrow;
 use crate::types::Opaque;
 use core::iter::{DoubleEndedIterator, FusedIterator};
 use core::marker::PhantomData;
 use core::ptr;
+use pin_init::PinInit;
=20
 mod impl_list_item_mod;
 pub use self::impl_list_item_mod::{
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 6b9e068b3710..7f55c13ed859 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -17,7 +17,9 @@
 pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec=
, Vec};
=20
 #[doc(no_inline)]
-pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
+pub use macros::{module, vtable};
+
+pub use pin_init::{init, pin_data, pin_init, pinned_drop, InPlaceWrite, In=
it, PinInit, Zeroable};
=20
 pub use super::{build_assert, build_error};
=20
@@ -28,7 +30,6 @@
 pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_info=
, dev_notice, dev_warn};
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr=
_notice, pr_warn};
=20
-pub use super::{init, pin_init};
 pub use super::{try_init, try_pin_init};
=20
 pub use super::static_assert;
@@ -37,7 +38,6 @@
=20
 pub use super::{str::CStr, ThisModule};
=20
-pub use super::init::{InPlaceWrite, Init, PinInit};
-pub use super::init_ext::InPlaceInit;
+pub use super::init::InPlaceInit;
=20
 pub use super::current;
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 31c26b692c6d..c64eac8b4235 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -19,8 +19,7 @@
 use crate::{
     alloc::{AllocError, Flags, KBox},
     bindings,
-    init::{self, InPlaceWrite, Init, PinInit},
-    init_ext::InPlaceInit,
+    init::InPlaceInit,
     try_init,
     types::{ForeignOwnable, Opaque},
 };
@@ -33,7 +32,7 @@
     pin::Pin,
     ptr::NonNull,
 };
-use macros::pin_data;
+use pin_init::{self, pin_data, InPlaceWrite, Init, PinInit};
=20
 mod std_vendor;
=20
@@ -738,7 +737,7 @@ pub fn new_uninit(flags: Flags) -> Result<UniqueArc<May=
beUninit<T>>, AllocError>
             try_init!(ArcInner {
                 // SAFETY: There are no safety requirements for this FFI c=
all.
                 refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) =
}),
-                data <- init::uninit::<T, AllocError>(),
+                data <- pin_init::uninit::<T, AllocError>(),
             }? AllocError),
             flags,
         )?;
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 5aa7fa7c7002..c2535db9e0f8 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -8,8 +8,6 @@
 use super::{lock::Backend, lock::Guard, LockClassKey};
 use crate::{
     ffi::{c_int, c_long},
-    init::PinInit,
-    pin_init,
     str::CStr,
     task::{MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNI=
NTERRUPTIBLE},
     time::Jiffies,
@@ -17,7 +15,7 @@
 };
 use core::marker::PhantomPinned;
 use core::ptr;
-use macros::pin_data;
+use pin_init::{pin_data, pin_init, PinInit};
=20
 /// Creates a [`CondVar`] initialiser with the given name and a newly-crea=
ted lock class.
 #[macro_export]
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index eb80048e0110..7f611b59ac57 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,13 +7,11 @@
=20
 use super::LockClassKey;
 use crate::{
-    init::PinInit,
-    pin_init,
     str::CStr,
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
 use core::{cell::UnsafeCell, marker::PhantomPinned};
-use macros::pin_data;
+use pin_init::{pin_data, pin_init, PinInit};
=20
 pub mod mutex;
 pub mod spinlock;
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.r=
s
index 70cadbc2e8e2..581cee7ab842 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -26,7 +26,7 @@ macro_rules! new_mutex {
 /// Since it may block, [`Mutex`] needs to be used with care in atomic con=
texts.
 ///
 /// Instances of [`Mutex`] need a lock class and to be pinned. The recomme=
nded way to create such
-/// instances is with the [`pin_init`](crate::pin_init) and [`new_mutex`] =
macros.
+/// instances is with the [`pin_init`](pin_init::pin_init) and [`new_mutex=
`] macros.
 ///
 /// # Examples
 ///
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spin=
lock.rs
index ab2f8d075311..d7be38ccbdc7 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -24,7 +24,7 @@ macro_rules! new_spinlock {
 /// unlocked, at which point another CPU will be allowed to make progress.
 ///
 /// Instances of [`SpinLock`] need a lock class and to be pinned. The reco=
mmended way to create such
-/// instances is with the [`pin_init`](crate::pin_init) and [`new_spinlock=
`] macros.
+/// instances is with the [`pin_init`](pin_init::pin_init) and [`new_spinl=
ock`] macros.
 ///
 /// # Examples
 ///
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9f75bd3866e8..a19828a5c206 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,7 +2,6 @@
=20
 //! Kernel types.
=20
-use crate::init::{self, PinInit, Zeroable};
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
@@ -10,6 +9,7 @@
     ops::{Deref, DerefMut},
     ptr::NonNull,
 };
+use pin_init::{PinInit, Zeroable};
=20
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
@@ -336,7 +336,7 @@ pub fn pin_init(slot: impl PinInit<T>) -> impl PinInit<=
Self> {
             //   - `ptr` is a valid pointer to uninitialized memory,
             //   - `slot` is not accessed on error; the call is infallible=
,
             //   - `slot` is pinned in memory.
-            let _ =3D unsafe { init::PinInit::<T>::__pinned_init(slot, ptr=
) };
+            let _ =3D unsafe { PinInit::<T>::__pinned_init(slot, ptr) };
         })
     }
=20
@@ -352,7 +352,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl=
 PinInit<Self> {
         // SAFETY: We contain a `MaybeUninit`, so it is OK for the `init_f=
unc` to not fully
         // initialize the `T`.
         unsafe {
-            init::pin_init_from_closure::<_, ::core::convert::Infallible>(=
move |slot| {
+            pin_init::pin_init_from_closure::<_, ::core::convert::Infallib=
le>(move |slot| {
                 init_func(Self::raw_get(slot));
                 Ok(())
             })
@@ -372,7 +372,9 @@ pub fn try_ffi_init<E>(
     ) -> impl PinInit<Self, E> {
         // SAFETY: We contain a `MaybeUninit`, so it is OK for the `init_f=
unc` to not fully
         // initialize the `T`.
-        unsafe { init::pin_init_from_closure::<_, E>(move |slot| init_func=
(Self::raw_get(slot))) }
+        unsafe {
+            pin_init::pin_init_from_closure::<_, E>(move |slot| init_func(=
Self::raw_get(slot)))
+        }
     }
=20
     /// Returns a raw pointer to the opaque data.
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index 8e07703fcc16..b2bdd4d8c958 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
=20
-use proc_macro::{token_stream, Group, TokenStream, TokenTree};
+use proc_macro::{token_stream, Group, TokenTree};
=20
 pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String>=
 {
     if let Some(TokenTree::Ident(ident)) =3D it.next() {
@@ -69,5 +69,3 @@ pub(crate) fn expect_end(it: &mut token_stream::IntoIter)=
 {
         panic!("Expected end");
     }
 }
-
-include!("../pin-init/internal/src/helpers.rs");
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 7ff82c82ce0c..8e116e266524 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -2,23 +2,20 @@
=20
 //! Crate for all kernel procedural macros.
=20
+#![feature(lint_reasons)]
+
 // When fixdep scans this, it will find this string `CONFIG_RUSTC_VERSION_=
TEXT`
 // and thus add a dependency on `include/config/RUSTC_VERSION_TEXT`, which=
 is
 // touched by Kconfig when the version string from the compiler changes.
=20
 #[macro_use]
+#[expect(unused_macros)]
 mod quote;
 mod concat_idents;
 mod helpers;
 mod module;
 mod paste;
-#[path =3D "../pin-init/internal/src/pin_data.rs"]
-mod pin_data;
-#[path =3D "../pin-init/internal/src/pinned_drop.rs"]
-mod pinned_drop;
 mod vtable;
-#[path =3D "../pin-init/internal/src/zeroable.rs"]
-mod zeroable;
=20
 use proc_macro::TokenStream;
=20
@@ -374,5 +371,3 @@ pub fn paste(input: TokenStream) -> TokenStream {
     paste::expand(&mut tokens);
     tokens.into_iter().collect()
 }
-
-include!("../pin-init/internal/src/lib.rs");
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index cdf94f4982df..bdd94c79b0d4 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -236,7 +236,7 @@ impl kernel::ModuleMetadata for {type_} {{
             mod __module_init {{
                 mod __module_init {{
                     use super::super::{type_};
-                    use kernel::init::PinInit;
+                    use pin_init::PinInit;
=20
                     /// The \"Rust loadable module\" mark.
                     //
diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index 33a199e4f176..11d241b85ac3 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -2,6 +2,7 @@
=20
 use proc_macro::{TokenStream, TokenTree};
=20
+#[allow(dead_code)]
 pub(crate) trait ToTokens {
     fn to_tokens(&self, tokens: &mut TokenStream);
 }
diff --git a/rust/pin-init/internal/src/_lib.rs b/rust/pin-init/internal/sr=
c/_lib.rs
deleted file mode 100644
index 0874cf04e4cb..000000000000
--- a/rust/pin-init/internal/src/_lib.rs
+++ /dev/null
@@ -1,3 +0,0 @@
-// SPDX-License-Identifier: Apache-2.0 OR MIT
-
-//! Will be removed in a future commit, only exists to prevent compilation=
 errors.
diff --git a/rust/pin-init/internal/src/helpers.rs b/rust/pin-init/internal=
/src/helpers.rs
index 2f4fc75c014e..78521ba19d0b 100644
--- a/rust/pin-init/internal/src/helpers.rs
+++ b/rust/pin-init/internal/src/helpers.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
=20
+use proc_macro::{TokenStream, TokenTree};
+
 /// Parsed generics.
 ///
 /// See the field documentation for an explanation what each of the fields=
 represents.
diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src=
/lib.rs
index 3146da5cc47c..c201b8a53915 100644
--- a/rust/pin-init/internal/src/lib.rs
+++ b/rust/pin-init/internal/src/lib.rs
@@ -4,6 +4,22 @@
 // and thus add a dependency on `include/config/RUSTC_VERSION_TEXT`, which=
 is
 // touched by Kconfig when the version string from the compiler changes.
=20
+//! `pin-init` proc macros.
+
+#![cfg_attr(not(RUSTC_LINT_REASONS_IS_STABLE), feature(lint_reasons))]
+
+use proc_macro::TokenStream;
+
+#[cfg(kernel)]
+#[path =3D "../../../macros/quote.rs"]
+#[macro_use]
+mod quote;
+
+mod helpers;
+mod pin_data;
+mod pinned_drop;
+mod zeroable;
+
 #[allow(missing_docs)]
 #[proc_macro_attribute]
 pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
diff --git a/rust/pin-init/internal/src/pin_data.rs b/rust/pin-init/interna=
l/src/pin_data.rs
index 1d4a3547c684..9b974498f4a8 100644
--- a/rust/pin-init/internal/src/pin_data.rs
+++ b/rust/pin-init/internal/src/pin_data.rs
@@ -5,7 +5,7 @@
=20
 pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStre=
am {
     // This proc-macro only does some pre-parsing and then delegates the a=
ctual parsing to
-    // `kernel::__pin_data!`.
+    // `pin_init::__pin_data!`.
=20
     let (
         Generics {
@@ -71,7 +71,7 @@ pub(crate) fn pin_data(args: TokenStream, input: TokenStr=
eam) -> TokenStream {
         .collect::<Vec<_>>();
     // This should be the body of the struct `{...}`.
     let last =3D rest.pop();
-    let mut quoted =3D quote!(::kernel::__pin_data! {
+    let mut quoted =3D quote!(::pin_init::__pin_data! {
         parse_input:
         @args(#args),
         @sig(#(#rest)*),
diff --git a/rust/pin-init/internal/src/pinned_drop.rs b/rust/pin-init/inte=
rnal/src/pinned_drop.rs
index 88fb72b20660..386f52f73c06 100644
--- a/rust/pin-init/internal/src/pinned_drop.rs
+++ b/rust/pin-init/internal/src/pinned_drop.rs
@@ -35,11 +35,11 @@ pub(crate) fn pinned_drop(_args: TokenStream, input: To=
kenStream) -> TokenStream
     let idx =3D pinned_drop_idx
         .unwrap_or_else(|| panic!("Expected an `impl` block implementing `=
PinnedDrop`."));
     // Fully qualify the `PinnedDrop`, as to avoid any tampering.
-    toks.splice(idx..idx, quote!(::kernel::init::));
+    toks.splice(idx..idx, quote!(::pin_init::));
     // Take the `{}` body and call the declarative macro.
     if let Some(TokenTree::Group(last)) =3D toks.pop() {
         let last =3D last.stream();
-        quote!(::kernel::__pinned_drop! {
+        quote!(::pin_init::__pinned_drop! {
             @impl_sig(#(#toks)*),
             @impl_body(#last),
         })
diff --git a/rust/pin-init/internal/src/zeroable.rs b/rust/pin-init/interna=
l/src/zeroable.rs
index cfee2cec18d5..0cf6732f27dc 100644
--- a/rust/pin-init/internal/src/zeroable.rs
+++ b/rust/pin-init/internal/src/zeroable.rs
@@ -27,7 +27,7 @@ pub(crate) fn derive(input: TokenStream) -> TokenStream {
             // If we find a `,`, then we have finished a generic/constant/=
lifetime parameter.
             TokenTree::Punct(p) if nested =3D=3D 0 && p.as_char() =3D=3D '=
,' =3D> {
                 if in_generic && !inserted {
-                    new_impl_generics.extend(quote! { : ::kernel::init::Ze=
roable });
+                    new_impl_generics.extend(quote! { : ::pin_init::Zeroab=
le });
                 }
                 in_generic =3D true;
                 inserted =3D false;
@@ -41,7 +41,7 @@ pub(crate) fn derive(input: TokenStream) -> TokenStream {
             TokenTree::Punct(p) if nested =3D=3D 0 && p.as_char() =3D=3D '=
:' =3D> {
                 new_impl_generics.push(tt);
                 if in_generic {
-                    new_impl_generics.extend(quote! { ::kernel::init::Zero=
able + });
+                    new_impl_generics.extend(quote! { ::pin_init::Zeroable=
 + });
                     inserted =3D true;
                 }
             }
@@ -59,10 +59,10 @@ pub(crate) fn derive(input: TokenStream) -> TokenStream=
 {
     }
     assert_eq!(nested, 0);
     if in_generic && !inserted {
-        new_impl_generics.extend(quote! { : ::kernel::init::Zeroable });
+        new_impl_generics.extend(quote! { : ::pin_init::Zeroable });
     }
     quote! {
-        ::kernel::__derive_zeroable!(
+        ::pin_init::__derive_zeroable!(
             parse_input:
                 @sig(#(#rest)*),
                 @impl_generics(#(#new_impl_generics)*),
diff --git a/rust/pin-init/src/_lib.rs b/rust/pin-init/src/_lib.rs
deleted file mode 100644
index e0918fd8e9e7..000000000000
--- a/rust/pin-init/src/_lib.rs
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: Apache-2.0 OR MIT
-
-//! Will be removed in a future commit, only exists to prevent compilation=
 errors.
-
-#![no_std]
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 29c0920d1bfe..55d8953620f0 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -209,9 +209,21 @@
 //! [`impl PinInit<Foo>`]: PinInit
 //! [`impl PinInit<T, E>`]: PinInit
 //! [`impl Init<T, E>`]: Init
-//! [`pin_data`]: ::macros::pin_data
+//! [`pin_data`]: crate::pin_data
 //! [`pin_init!`]: crate::pin_init!
=20
+#![cfg_attr(not(RUSTC_LINT_REASONS_IS_STABLE), feature(lint_reasons))]
+#![cfg_attr(
+    all(
+        any(feature =3D "alloc", feature =3D "std"),
+        not(RUSTC_NEW_UNINIT_IS_STABLE)
+    ),
+    feature(new_uninit)
+)]
+#![forbid(missing_docs, unsafe_op_in_unsafe_fn)]
+#![cfg_attr(not(feature =3D "std"), no_std)]
+#![cfg_attr(feature =3D "alloc", feature(allocator_api))]
+
 use core::{
     cell::UnsafeCell,
     convert::Infallible,
@@ -288,7 +300,7 @@
 /// ```
 ///
 /// [`pin_init!`]: crate::pin_init
-pub use ::macros::pin_data;
+pub use ::pin_init_internal::pin_data;
=20
 /// Used to implement `PinnedDrop` safely.
 ///
@@ -322,7 +334,7 @@
 ///     }
 /// }
 /// ```
-pub use ::macros::pinned_drop;
+pub use ::pin_init_internal::pinned_drop;
=20
 /// Derives the [`Zeroable`] trait for the given struct.
 ///
@@ -340,7 +352,7 @@
 ///     len: usize,
 /// }
 /// ```
-pub use ::macros::Zeroable;
+pub use ::pin_init_internal::Zeroable;
=20
 /// Initialize and pin a type directly on the stack.
 ///
@@ -385,8 +397,8 @@
 macro_rules! stack_pin_init {
     (let $var:ident $(: $t:ty)? =3D $val:expr) =3D> {
         let val =3D $val;
-        let mut $var =3D ::core::pin::pin!($crate::init::__internal::Stack=
Init$(::<$t>)?::uninit());
-        let mut $var =3D match $crate::init::__internal::StackInit::init($=
var, val) {
+        let mut $var =3D ::core::pin::pin!($crate::__internal::StackInit$(=
::<$t>)?::uninit());
+        let mut $var =3D match $crate::__internal::StackInit::init($var, v=
al) {
             Ok(res) =3D> res,
             Err(x) =3D> {
                 let x: ::core::convert::Infallible =3D x;
@@ -463,13 +475,13 @@ macro_rules! stack_pin_init {
 macro_rules! stack_try_pin_init {
     (let $var:ident $(: $t:ty)? =3D $val:expr) =3D> {
         let val =3D $val;
-        let mut $var =3D ::core::pin::pin!($crate::init::__internal::Stack=
Init$(::<$t>)?::uninit());
-        let mut $var =3D $crate::init::__internal::StackInit::init($var, v=
al);
+        let mut $var =3D ::core::pin::pin!($crate::__internal::StackInit$(=
::<$t>)?::uninit());
+        let mut $var =3D $crate::__internal::StackInit::init($var, val);
     };
     (let $var:ident $(: $t:ty)? =3D? $val:expr) =3D> {
         let val =3D $val;
-        let mut $var =3D ::core::pin::pin!($crate::init::__internal::Stack=
Init$(::<$t>)?::uninit());
-        let mut $var =3D $crate::init::__internal::StackInit::init($var, v=
al)?;
+        let mut $var =3D ::core::pin::pin!($crate::__internal::StackInit$(=
::<$t>)?::uninit());
+        let mut $var =3D $crate::__internal::StackInit::init($var, val)?;
     };
 }
=20
@@ -670,7 +682,7 @@ macro_rules! pin_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::_try_pin_init!($(&$this in)? $t $(::<$($generics),*>)? {
+        $crate::try_pin_init!($(&$this in)? $t $(::<$($generics),*>)? {
             $($fields)*
         }? ::core::convert::Infallible)
     };
@@ -716,7 +728,7 @@ macro_rules! pin_init {
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
-macro_rules! _try_pin_init {
+macro_rules! try_pin_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }? $err:ty) =3D> {
@@ -755,7 +767,7 @@ macro_rules! init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::_try_init!($(&$this in)? $t $(::<$($generics),*>)? {
+        $crate::try_init!($(&$this in)? $t $(::<$($generics),*>)? {
             $($fields)*
         }? ::core::convert::Infallible)
     }
@@ -798,7 +810,7 @@ macro_rules! init {
 // For a detailed example of how this macro works, see the module document=
ation of the hidden
 // module `__internal` inside of `init/__internal.rs`.
 #[macro_export]
-macro_rules! _try_init {
+macro_rules! try_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }? $err:ty) =3D> {
@@ -868,8 +880,8 @@ macro_rules! assert_pinned {
     ($ty:ty, $field:ident, $field_ty:ty, inline) =3D> {
         let _ =3D move |ptr: *mut $field_ty| {
             // SAFETY: This code is unreachable.
-            let data =3D unsafe { <$ty as $crate::init::__internal::HasPin=
Data>::__pin_data() };
-            let init =3D $crate::init::__internal::AlwaysFail::<$field_ty>=
::new();
+            let data =3D unsafe { <$ty as $crate::__internal::HasPinData>:=
:__pin_data() };
+            let init =3D $crate::__internal::AlwaysFail::<$field_ty>::new(=
);
             // SAFETY: This code is unreachable.
             unsafe { data.$field(ptr, init) }.ok();
         };
@@ -1262,7 +1274,7 @@ pub trait InPlaceWrite<T> {
 ///
 /// This trait must be implemented via the [`pinned_drop`] proc-macro attr=
ibute on the impl.
 ///
-/// [`pinned_drop`]: crate::macros::pinned_drop
+/// [`pinned_drop`]: crate::pinned_drop
 pub unsafe trait PinnedDrop: __internal::HasPinData {
     /// Executes the pinned destructor of this type.
     ///
diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index c45ad6af5ca0..d41c4f198c42 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -19,7 +19,7 @@
 //! We will look at the following example:
 //!
 //! ```rust,ignore
-//! # use kernel::init::*;
+//! # use pin_init::*;
 //! # use core::pin::Pin;
 //! #[pin_data]
 //! #[repr(C)]
@@ -75,7 +75,7 @@
 //! Here is the definition of `Bar` from our example:
 //!
 //! ```rust,ignore
-//! # use kernel::init::*;
+//! # use pin_init::*;
 //! #[pin_data]
 //! #[repr(C)]
 //! struct Bar<T> {
@@ -121,22 +121,22 @@
 //!             self,
 //!             slot: *mut T,
 //!             // Since `t` is `#[pin]`, this is `PinInit`.
-//!             init: impl ::kernel::init::PinInit<T, E>,
+//!             init: impl ::pin_init::PinInit<T, E>,
 //!         ) -> ::core::result::Result<(), E> {
-//!             unsafe { ::kernel::init::PinInit::__pinned_init(init, slot=
) }
+//!             unsafe { ::pin_init::PinInit::__pinned_init(init, slot) }
 //!         }
 //!         pub unsafe fn x<E>(
 //!             self,
 //!             slot: *mut usize,
 //!             // Since `x` is not `#[pin]`, this is `Init`.
-//!             init: impl ::kernel::init::Init<usize, E>,
+//!             init: impl ::pin_init::Init<usize, E>,
 //!         ) -> ::core::result::Result<(), E> {
-//!             unsafe { ::kernel::init::Init::__init(init, slot) }
+//!             unsafe { ::pin_init::Init::__init(init, slot) }
 //!         }
 //!     }
 //!     // Implement the internal `HasPinData` trait that associates `Bar`=
 with the pin-data struct
 //!     // that we constructed above.
-//!     unsafe impl<T> ::kernel::init::__internal::HasPinData for Bar<T> {
+//!     unsafe impl<T> ::pin_init::__internal::HasPinData for Bar<T> {
 //!         type PinData =3D __ThePinData<T>;
 //!         unsafe fn __pin_data() -> Self::PinData {
 //!             __ThePinData {
@@ -147,7 +147,7 @@
 //!     // Implement the internal `PinData` trait that marks the pin-data =
struct as a pin-data
 //!     // struct. This is important to ensure that no user can implement =
a rogue `__pin_data`
 //!     // function without using `unsafe`.
-//!     unsafe impl<T> ::kernel::init::__internal::PinData for __ThePinDat=
a<T> {
+//!     unsafe impl<T> ::pin_init::__internal::PinData for __ThePinData<T>=
 {
 //!         type Datee =3D Bar<T>;
 //!     }
 //!     // Now we only want to implement `Unpin` for `Bar` when every stru=
cturally pinned field is
@@ -191,7 +191,7 @@
 //!     #[expect(non_camel_case_types)]
 //!     trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
 //!     impl<
-//!         T: ::kernel::init::PinnedDrop,
+//!         T: ::pin_init::PinnedDrop,
 //!     > UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for T {}
 //!     impl<T> UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for B=
ar<T> {}
 //! };
@@ -227,11 +227,11 @@
 //!             // - we `use` the `HasPinData` trait in the block, it is o=
nly available in that
 //!             //   scope.
 //!             let data =3D unsafe {
-//!                 use ::kernel::init::__internal::HasPinData;
+//!                 use ::pin_init::__internal::HasPinData;
 //!                 Self::__pin_data()
 //!             };
 //!             // Ensure that `data` really is of type `PinData` and help=
 with type inference:
-//!             let init =3D ::kernel::init::__internal::PinData::make_clo=
sure::<
+//!             let init =3D ::pin_init::__internal::PinData::make_closure=
::<
 //!                 _,
 //!                 __InitOk,
 //!                 ::core::convert::Infallible,
@@ -262,7 +262,7 @@
 //!                     }
 //!                     // We again create a `DropGuard`.
 //!                     let __x_guard =3D unsafe {
-//!                         ::kernel::init::__internal::DropGuard::new(::c=
ore::addr_of_mut!((*slot).x))
+//!                         ::pin_init::__internal::DropGuard::new(::core:=
:addr_of_mut!((*slot).x))
 //!                     };
 //!                     // Since initialization has successfully completed=
, we can now forget
 //!                     // the guards. This is not `mem::forget`, since we=
 only have
@@ -303,7 +303,7 @@
 //!             };
 //!             // Construct the initializer.
 //!             let init =3D unsafe {
-//!                 ::kernel::init::pin_init_from_closure::<
+//!                 ::pin_init::pin_init_from_closure::<
 //!                     _,
 //!                     ::core::convert::Infallible,
 //!                 >(init)
@@ -350,19 +350,19 @@
 //!         unsafe fn b<E>(
 //!             self,
 //!             slot: *mut Bar<u32>,
-//!             init: impl ::kernel::init::PinInit<Bar<u32>, E>,
+//!             init: impl ::pin_init::PinInit<Bar<u32>, E>,
 //!         ) -> ::core::result::Result<(), E> {
-//!             unsafe { ::kernel::init::PinInit::__pinned_init(init, slot=
) }
+//!             unsafe { ::pin_init::PinInit::__pinned_init(init, slot) }
 //!         }
 //!         unsafe fn a<E>(
 //!             self,
 //!             slot: *mut usize,
-//!             init: impl ::kernel::init::Init<usize, E>,
+//!             init: impl ::pin_init::Init<usize, E>,
 //!         ) -> ::core::result::Result<(), E> {
-//!             unsafe { ::kernel::init::Init::__init(init, slot) }
+//!             unsafe { ::pin_init::Init::__init(init, slot) }
 //!         }
 //!     }
-//!     unsafe impl ::kernel::init::__internal::HasPinData for Foo {
+//!     unsafe impl ::pin_init::__internal::HasPinData for Foo {
 //!         type PinData =3D __ThePinData;
 //!         unsafe fn __pin_data() -> Self::PinData {
 //!             __ThePinData {
@@ -370,7 +370,7 @@
 //!             }
 //!         }
 //!     }
-//!     unsafe impl ::kernel::init::__internal::PinData for __ThePinData {
+//!     unsafe impl ::pin_init::__internal::PinData for __ThePinData {
 //!         type Datee =3D Foo;
 //!     }
 //!     #[allow(dead_code)]
@@ -394,8 +394,8 @@
 //!             let pinned =3D unsafe { ::core::pin::Pin::new_unchecked(se=
lf) };
 //!             // Create the unsafe token that proves that we are inside =
of a destructor, this
 //!             // type is only allowed to be created in a destructor.
-//!             let token =3D unsafe { ::kernel::init::__internal::OnlyCal=
lFromDrop::new() };
-//!             ::kernel::init::PinnedDrop::drop(pinned, token);
+//!             let token =3D unsafe { ::pin_init::__internal::OnlyCallFro=
mDrop::new() };
+//!             ::pin_init::PinnedDrop::drop(pinned, token);
 //!         }
 //!     }
 //! };
@@ -421,8 +421,8 @@
 //!
 //! ```rust,ignore
 //! // `unsafe`, full path and the token parameter are added, everything e=
lse stays the same.
-//! unsafe impl ::kernel::init::PinnedDrop for Foo {
-//!     fn drop(self: Pin<&mut Self>, _: ::kernel::init::__internal::OnlyC=
allFromDrop) {
+//! unsafe impl ::pin_init::PinnedDrop for Foo {
+//!     fn drop(self: Pin<&mut Self>, _: ::pin_init::__internal::OnlyCallF=
romDrop) {
 //!         pr_info!("{self:p} is getting dropped.");
 //!     }
 //! }
@@ -448,10 +448,10 @@
 //! let initializer =3D {
 //!     struct __InitOk;
 //!     let data =3D unsafe {
-//!         use ::kernel::init::__internal::HasPinData;
+//!         use ::pin_init::__internal::HasPinData;
 //!         Foo::__pin_data()
 //!     };
-//!     let init =3D ::kernel::init::__internal::PinData::make_closure::<
+//!     let init =3D ::pin_init::__internal::PinData::make_closure::<
 //!         _,
 //!         __InitOk,
 //!         ::core::convert::Infallible,
@@ -462,12 +462,12 @@
 //!                 unsafe { ::core::ptr::write(::core::addr_of_mut!((*slo=
t).a), a) };
 //!             }
 //!             let __a_guard =3D unsafe {
-//!                 ::kernel::init::__internal::DropGuard::new(::core::add=
r_of_mut!((*slot).a))
+//!                 ::pin_init::__internal::DropGuard::new(::core::addr_of=
_mut!((*slot).a))
 //!             };
 //!             let init =3D Bar::new(36);
 //!             unsafe { data.b(::core::addr_of_mut!((*slot).b), b)? };
 //!             let __b_guard =3D unsafe {
-//!                 ::kernel::init::__internal::DropGuard::new(::core::add=
r_of_mut!((*slot).b))
+//!                 ::pin_init::__internal::DropGuard::new(::core::addr_of=
_mut!((*slot).b))
 //!             };
 //!             ::core::mem::forget(__b_guard);
 //!             ::core::mem::forget(__a_guard);
@@ -492,13 +492,16 @@
 //!         init(slot).map(|__InitOk| ())
 //!     };
 //!     let init =3D unsafe {
-//!         ::kernel::init::pin_init_from_closure::<_, ::core::convert::In=
fallible>(init)
+//!         ::pin_init::pin_init_from_closure::<_, ::core::convert::Infall=
ible>(init)
 //!     };
 //!     init
 //! };
 //! ```
=20
+#[cfg(kernel)]
 pub use ::macros::paste;
+#[cfg(not(kernel))]
+pub use ::paste::paste;
=20
 /// Creates a `unsafe impl<...> PinnedDrop for $type` block.
 ///
@@ -519,7 +522,7 @@ fn drop($($sig:tt)*) {
         unsafe $($impl_sig)* {
             // Inherit all attributes and the type/ident tokens for the si=
gnature.
             $(#[$($attr)*])*
-            fn drop($($sig)*, _: $crate::init::__internal::OnlyCallFromDro=
p) {
+            fn drop($($sig)*, _: $crate::__internal::OnlyCallFromDrop) {
                 $($inner)*
             }
         }
@@ -865,7 +868,7 @@ impl<$($impl_generics)*> ::core::marker::Copy for __The=
PinData<$($ty_generics)*>
             // SAFETY: We have added the correct projection functions abov=
e to `__ThePinData` and
             // we also use the least restrictive generics possible.
             unsafe impl<$($impl_generics)*>
-                $crate::init::__internal::HasPinData for $name<$($ty_gener=
ics)*>
+                $crate::__internal::HasPinData for $name<$($ty_generics)*>
             where $($whr)*
             {
                 type PinData =3D __ThePinData<$($ty_generics)*>;
@@ -877,7 +880,7 @@ unsafe fn __pin_data() -> Self::PinData {
=20
             // SAFETY: TODO.
             unsafe impl<$($impl_generics)*>
-                $crate::init::__internal::PinData for __ThePinData<$($ty_g=
enerics)*>
+                $crate::__internal::PinData for __ThePinData<$($ty_generic=
s)*>
             where $($whr)*
             {
                 type Datee =3D $name<$($ty_generics)*>;
@@ -936,7 +939,7 @@ impl<$($impl_generics)*> MustNotImplDrop for $name<$($t=
y_generics)*>
         // `PinnedDrop` as the parameter to `#[pin_data]`.
         #[expect(non_camel_case_types)]
         trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
-        impl<T: $crate::init::PinnedDrop>
+        impl<T: $crate::PinnedDrop>
             UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for T {}
         impl<$($impl_generics)*>
             UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for $name=
<$($ty_generics)*>
@@ -959,8 +962,8 @@ fn drop(&mut self) {
                 let pinned =3D unsafe { ::core::pin::Pin::new_unchecked(se=
lf) };
                 // SAFETY: Since this is a drop function, we can create th=
is token to call the
                 // pinned destructor of this type.
-                let token =3D unsafe { $crate::init::__internal::OnlyCallF=
romDrop::new() };
-                $crate::init::PinnedDrop::drop(pinned, token);
+                let token =3D unsafe { $crate::__internal::OnlyCallFromDro=
p::new() };
+                $crate::PinnedDrop::drop(pinned, token);
             }
         }
     };
@@ -1000,10 +1003,10 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*=
>
                 $pvis unsafe fn $p_field<E>(
                     self,
                     slot: *mut $p_type,
-                    init: impl $crate::init::PinInit<$p_type, E>,
+                    init: impl $crate::PinInit<$p_type, E>,
                 ) -> ::core::result::Result<(), E> {
                     // SAFETY: TODO.
-                    unsafe { $crate::init::PinInit::__pinned_init(init, sl=
ot) }
+                    unsafe { $crate::PinInit::__pinned_init(init, slot) }
                 }
             )*
             $(
@@ -1011,10 +1014,10 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*=
>
                 $fvis unsafe fn $field<E>(
                     self,
                     slot: *mut $type,
-                    init: impl $crate::init::Init<$type, E>,
+                    init: impl $crate::Init<$type, E>,
                 ) -> ::core::result::Result<(), E> {
                     // SAFETY: TODO.
-                    unsafe { $crate::init::Init::__init(init, slot) }
+                    unsafe { $crate::Init::__init(init, slot) }
                 }
             )*
         }
@@ -1131,15 +1134,15 @@ macro_rules! __init_internal {
         //
         // SAFETY: TODO.
         let data =3D unsafe {
-            use $crate::init::__internal::$has_data;
+            use $crate::__internal::$has_data;
             // Here we abuse `paste!` to retokenize `$t`. Declarative macr=
os have some internal
             // information that is associated to already parsed fragments,=
 so a path fragment
             // cannot be used in this position. Doing the retokenization r=
esults in valid rust
             // code.
-            $crate::init::macros::paste!($t::$get_data())
+            $crate::macros::paste!($t::$get_data())
         };
         // Ensure that `data` really is of type `$data` and help with type=
 inference:
-        let init =3D $crate::init::__internal::$data::make_closure::<_, __=
InitOk, $err>(
+        let init =3D $crate::__internal::$data::make_closure::<_, __InitOk=
, $err>(
             data,
             move |slot| {
                 {
@@ -1149,7 +1152,7 @@ macro_rules! __init_internal {
                     // error when fields are missing (since they will be z=
eroed). We also have to
                     // check that the type actually implements `Zeroable`.
                     $({
-                        fn assert_zeroable<T: $crate::init::Zeroable>(_: *=
mut T) {}
+                        fn assert_zeroable<T: $crate::Zeroable>(_: *mut T)=
 {}
                         // Ensure that the struct is indeed `Zeroable`.
                         assert_zeroable(slot);
                         // SAFETY: The type implements `Zeroable` by the c=
heck above.
@@ -1186,7 +1189,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
             init(slot).map(|__InitOk| ())
         };
         // SAFETY: TODO.
-        let init =3D unsafe { $crate::init::$construct_closure::<_, $err>(=
init) };
+        let init =3D unsafe { $crate::$construct_closure::<_, $err>(init) =
};
         init
     }};
     (init_slot($($use_data:ident)?):
@@ -1217,10 +1220,10 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *m=
ut T) {}
         //
         // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
         // We use `paste!` to create new hygiene for `$field`.
-        $crate::init::macros::paste! {
+        $crate::macros::paste! {
             // SAFETY: We forget the guard later when initialization has s=
ucceeded.
             let [< __ $field _guard >] =3D unsafe {
-                $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
+                $crate::__internal::DropGuard::new(::core::ptr::addr_of_mu=
t!((*$slot).$field))
             };
=20
             $crate::__init_internal!(init_slot($use_data):
@@ -1243,15 +1246,15 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *m=
ut T) {}
         //
         // SAFETY: `slot` is valid, because we are inside of an initialize=
r closure, we
         // return when an error/panic occurs.
-        unsafe { $crate::init::Init::__init(init, ::core::ptr::addr_of_mut=
!((*$slot).$field))? };
+        unsafe { $crate::Init::__init(init, ::core::ptr::addr_of_mut!((*$s=
lot).$field))? };
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
         // We use `paste!` to create new hygiene for `$field`.
-        $crate::init::macros::paste! {
+        $crate::macros::paste! {
             // SAFETY: We forget the guard later when initialization has s=
ucceeded.
             let [< __ $field _guard >] =3D unsafe {
-                $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
+                $crate::__internal::DropGuard::new(::core::ptr::addr_of_mu=
t!((*$slot).$field))
             };
=20
             $crate::__init_internal!(init_slot():
@@ -1280,10 +1283,10 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *m=
ut T) {}
         //
         // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
         // We use `paste!` to create new hygiene for `$field`.
-        $crate::init::macros::paste! {
+        $crate::macros::paste! {
             // SAFETY: We forget the guard later when initialization has s=
ucceeded.
             let [< __ $field _guard >] =3D unsafe {
-                $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
+                $crate::__internal::DropGuard::new(::core::ptr::addr_of_mu=
t!((*$slot).$field))
             };
=20
             $crate::__init_internal!(init_slot($($use_data)?):
@@ -1317,7 +1320,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
             // information that is associated to already parsed fragments,=
 so a path fragment
             // cannot be used in this position. Doing the retokenization r=
esults in valid rust
             // code.
-            $crate::init::macros::paste!(
+            $crate::macros::paste!(
                 ::core::ptr::write($slot, $t {
                     $($acc)*
                     ..zeroed
@@ -1341,7 +1344,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
             // information that is associated to already parsed fragments,=
 so a path fragment
             // cannot be used in this position. Doing the retokenization r=
esults in valid rust
             // code.
-            $crate::init::macros::paste!(
+            $crate::macros::paste!(
                 ::core::ptr::write($slot, $t {
                     $($acc)*
                 });
@@ -1396,12 +1399,12 @@ macro_rules! __derive_zeroable {
     ) =3D> {
         // SAFETY: Every field type implements `Zeroable` and padding byte=
s may be zero.
         #[automatically_derived]
-        unsafe impl<$($impl_generics)*> $crate::init::Zeroable for $name<$=
($ty_generics)*>
+        unsafe impl<$($impl_generics)*> $crate::Zeroable for $name<$($ty_g=
enerics)*>
         where
             $($($whr)*)?
         {}
         const _: () =3D {
-            fn assert_zeroable<T: ?::core::marker::Sized + $crate::init::Z=
eroable>() {}
+            fn assert_zeroable<T: ?::core::marker::Sized + $crate::Zeroabl=
e>() {}
             fn ensure_zeroable<$($impl_generics)*>()
                 where $($($whr)*)?
             {
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_anal=
yzer.py
index a44a4475d11f..54228e87e577 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -95,7 +95,7 @@ def generate_crates(srctree, objtree, sysroot_src, extern=
al_src, cfgs):
=20
     append_crate(
         "pin_init_internal",
-        srctree / "rust" / "pin-init" / "internal" / "src" / "_lib.rs",
+        srctree / "rust" / "pin-init" / "internal" / "src" / "lib.rs",
         [],
         cfg=3D["kernel"],
         is_proc_macro=3DTrue,
@@ -103,7 +103,7 @@ def generate_crates(srctree, objtree, sysroot_src, exte=
rnal_src, cfgs):
=20
     append_crate(
         "pin_init",
-        srctree / "rust" / "pin-init" / "src" / "_lib.rs",
+        srctree / "rust" / "pin-init" / "src" / "lib.rs",
         ["core", "pin_init_internal", "macros"],
         cfg=3D["kernel"],
     )
--=20
2.47.2


