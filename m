Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575425;
	b=fQMyLkXJdiL7WdMgcJDdoD/pFbsgoYKCGakDD7CidTcueIjmtRvya47VpQ2lbLrx76N3
	 zA1f98WeJpNufmFCIOrQIpANu3orADRLA1ZmIaFluvS0VtEhc5SWX57lj/5Y4gLf9WGAx
	 RJn/JSNa82QaF703SzJemzUMlru0t9JVLHmDFASVs4NadAdFDTRlVWpP11zwNjlwZ/P8o
	 a3Qgm36U54K51xVOMVQN18pxUP5o476wna0eX5plj1Etf2R596KhPrfwO+h27eaNRtMqn
	 HH1m/XrMNAMLsL8BhTFYiAY+rHqJBmiDKBgxsLdSAW+fTNMTkQOBCn07VGLBldbUhiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575425;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rSatr1ieHKE87/XpMgAxW5/kUn+S1P3koSEgCT2ETxc=;
	b=bf08JsJ8VA4lAfhvQOUQAIGz4n/5dmvx9jp9pFuW+tn9Un2EQYkUWUqN6hA0AMToP9QY
	 rUcmFw8VFsjav6ZiGmgsJ924IbxfF5Ald/dIt7oGi/l7klQUcbfmSe6x7rJ+DKbfklF4l
	 CFsPmxbO1cwhO/+32nhefLss0zwfyW7EE01jG5c942ZCFaHnjmIrcBlcGLO57RQXADd1k
	 Yb3PFOyBOPdCYjXi8yNI+DsBz3Ya5KONKT9GNngN5Qw5Cx8ROMpgRLCjQeFTHdRyqG0PW
	 R4F01AKC6WlGUQYCKJrcXRVzL3EWpMUw8mTVwxFwBzkoaFdhFXf9xrUGXrRkaUzRgwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGRtSqc1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE04606A32D;
	Fri, 13 Nov 2026 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGRtSqc1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97AB1F000C4;
	Fri, 13 Nov 2026 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575425;
	bh=rSatr1ieHKE87/XpMgAxW5/kUn+S1P3koSEgCT2ETxc=;
	h=From:Date:Subject:To:Cc;
	b=MGRtSqc1KHoM54dBIywg5qiYQsV6zZCtj4KoGqClBa0g8/DGQOwfpEK5j++q72pbV
	 PlDqyqSJOE3CY8irpieJuIp8XmmauVf6W4EQlX3ed/kGgnzmUIBZorxW52J37UKCXb
	 os9ek7E6W5a00U7dF6yepXCaUf3Ws0gvGUfXwgV3dSDS3TeNeVWyA5b81udTev2Pb0
	 UQxLVN1LuGjUm8uZU8i0bOl8w0Q0Gb/A7/qtUZpXwe31QO7/tmIsCqe7vOR/96+s8u
	 MR8ETrTFbnWRDxF/s8BKy9xroAnn1S2/oGs9SOvtZHzXbPtxeLwDTVbQX7OzV2PR80
	 qzAn8rFsyMrcw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 13 Nov 2026 14:09:56 +0100
Subject: [PATCH v4] configfs: rust: add an API for adding default groups
 from C
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-configfs-c-default-groups-v4-1-863963d3017c@kernel.org>
X-B4-Tracking: v=1; b=H4sIACMM92oC/43NwQ7CIAyA4VdZOIuBgiiefA/jAVnZiGYssBGN2
 bvLdtAYE2Nvf5N+fZCE0WMi++pBImaffOhKyFVFbGu6BqmvSxNgoBjwDbWhc75xiVpaozPjdaB
 NDGOf6Lk+MyOlEsIoUu77iM7fFvt4Kt36NIR4X15lPm//UTOnnKJW29qgU1aowwVjh9d1iA2Z2
 QxvSrGfFBQKEFBqrlEy+KLEi+JlflGiUAYt12KnYQv4QU3T9ATKgh0ZWQEAAA==
X-Change-ID: 20260215-configfs-c-default-groups-bdb0a44633a6
To: Boqun Feng <boqun@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Breno Leitao <leitao@debian.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17395;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=jv9Dhb+kBgiV0Sv32GilwBRRbOoOn8lXnzpvPGV7Hig=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBq9wwmEXtuwbO4lH8j/lvR/ypLKMpB/1wm3RPlK
 qQzEBt7Zr2JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCavcMJgAKCRD6UCkIqsW9
 0KKOEACrog2HGcC/U1NZAkFjXX8Swo+mRl+8Ul6ASAZUbQRSIE8IsZZPvIq2JdC4EZP9g1Z/iPv
 cFKXAf8vBQSfXLsY/fnhohGl8BVFZ3ovxAMpp7PYxaPZEzA8ZvQxG/9ykTnxw5c1dOidEAGLQRn
 PGpko5CuG6iVOVJa0slSLS/9ZH5N25mNg712f0ay+C0pK25k27ZNdGUqj03k45uaOsYPjMvg211
 PYW6KlD/T2AlW7eAcQO0Okux+66PCHvO1XOemWH1UYh2/B+6eoXbUtxv/kMZu3HxxR9+rGo9MGP
 SxO+j2GCC0Z+lttN2WRJZP6Sm2ps0XjfqfthSsM/hn8kp8TmvYZlNJwDwBZgv3QeLebKrVmzJhy
 rJW7FaBc5CEAyxUEIfEECqsjibWOXfX9KL9NKqH09d071H9QKisMzCgsK+Y9CTdiDyfgvQG8i6x
 03Bk9ogLidM4cweh7kQGYZE/KJJ16+LGVVPax24/+uDqjzxyybBnnsaz+jIuPF52xwTD98r0VXU
 aPHt1sT+gnnj1rVSyWyHatfCy3JEm16WhTW20csV02QodNmjikrt7Z546wxwagX5aQcXUsfWwax
 7oQ34NHmrmIcrOt5ESoLk+qQ2iShqEhr9+BLFks4bPSK9NjcGyYVXz8mfzGHjwq88hvSVHBQT2p
 VCF60M7Ks/NTHQg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Some C subsystems provide a feature to add configfs default groups to the
configfs hierarchy of other drivers or subsystems. Rust abstractions for
these subsystems will want a way to add these default groups via the
configfs Rust API. So add infrastructure to make this possible.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v4:
- Fix the build for `CONFIG_CONFIGFS_FS=m`. The Rust module is built for
  both `y` and `m`, but the `#ifdef` guarding the helpers is only true for
  `y`, so the module was built without the helper it needs (Sashiko).
- Drop the helper for `configfs_remove_default_groups`. It is an exported
  function rather than a static inline, so Rust can call it directly, and a
  helper for it built into vmlinux would reference a symbol that lives in
  `configfs.ko` (Sashiko).
- Require `Send` and `Sync` for `CDefaultGroup` implementers. `Group`
  carries manual `Send` and `Sync` implementations that bypass the compiler
  check on the new `default_groups` field, so an implementer that is
  neither could be shared across threads through a `Group` (Sashiko).
- Mark the `UnattachedGroup` methods `#[inline]`, as `ListArc` does for its
  equivalents (Sashiko).
- Use the kernel vertical import layout for the `crate::alloc` imports
  (Sashiko).
- Link to v3: https://msgid.link/20261111-configfs-c-default-groups-v3-1-aec19389272e@kernel.org

Changes in v3:
- Acquire a reference on each default group before adding it to its parent
  group. `configfs_add_default_group` does not acquire one, but
  `configfs_remove_default_groups` releases one, so a default group reached
  a zero reference count when its parent was dropped, while the caller
  still owned it.
- Make `CDefaultGroup` an unsafe trait and document the requirements on
  implementers.
- Add `UnattachedGroup`, a token that grants permission to attach a group
  as a default group exactly once, and take that in `Group::new` instead of
  an `Arc`. A `struct config_group` is linked into its parent through a
  single `group_entry` field, so attaching one group to two parents would
  corrupt both lists. The token cannot be cloned and `Group::new` consumes
  it, so this is now rejected at compile time rather than left to the
  caller.
- Allocate the group in `UnattachedGroup::new`, so that uniqueness follows
  from construction. Obtain a handle to the group with `clone_arc` or
  `into_arc`, named after the `ListArc` accessors.
- Initialize `data` before `group` in `Group::new`, so that no fallible
  step runs after the default groups have been attached.
- Drop default groups from the list of unsupported features in the module
  documentation.
- Link to v2: https://msgid.link/20260605-configfs-c-default-groups-v2-1-2e2e4919e402@kernel.org

Changes in v2:
- Drop the spurious `__` prefix on the symbol name of the
  `configfs_remove_default_groups` Rust helper (Alice).
- Wrap the body of `Group::new` in `pin_init::pin_init_scope` so that
  allocation failure from `KVec::push` is propagated with `?` instead
  of panicking via `unwrap` (Danilo).
- Only build configfs rust helpers when configfs is enabled.
- Link to v1: https://msgid.link/20260215-configfs-c-default-groups-v1-1-e967daef6c36@kernel.org
---
 drivers/block/rnull/configfs.rs |   1 +
 rust/helpers/configfs.c         |  10 ++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/configfs.rs         | 198 ++++++++++++++++++++++++++++++++++++----
 samples/rust/rust_configfs.rs   |   8 +-
 5 files changed, 201 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 34ef96fa125f..2f5b722927e0 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -88,6 +88,7 @@ fn make_group(
                     name: name.try_into()?,
                 }),
             }),
+            core::iter::empty(),
         ))
     }
 }
diff --git a/rust/helpers/configfs.c b/rust/helpers/configfs.c
new file mode 100644
index 000000000000..cda1551ab048
--- /dev/null
+++ b/rust/helpers/configfs.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/configfs.h>
+
+__rust_helper void
+rust_helper_configfs_add_default_group(struct config_group *new_group,
+				       struct config_group *group)
+{
+	configfs_add_default_group(new_group, group);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index d62c7be1ca7b..ab8d38b43117 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -51,6 +51,7 @@
 #include "build_bug.c"
 #include "clk.c"
 #include "completion.c"
+#include "configfs.c"
 #include "cpu.c"
 #include "cpufreq.c"
 #include "cpumask.c"
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index dbed72844b31..06a8adfef55f 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -11,7 +11,8 @@
 //! - Items. All group children are groups.
 //! - Symlink support.
 //! - `disconnect_notify` hook.
-//! - Default groups.
+//! - Default groups, except for groups allocated and initialized by C code. See
+//!   [`CDefaultGroup`] and [`UnattachedGroup`].
 //!
 //! See the [`rust_configfs.rs`] sample for a full example use of this module.
 //!
@@ -109,7 +110,10 @@
 //! [C documentation]: srctree/Documentation/filesystems/configfs.rst
 //! [`rust_configfs.rs`]: srctree/samples/rust/rust_configfs.rs
 
-use crate::alloc::flags;
+use crate::alloc::{
+    flags,
+    Flags, //
+};
 use crate::container_of;
 use crate::page::PAGE_SIZE;
 use crate::prelude::*;
@@ -242,19 +246,36 @@ unsafe fn container_of(group: *const bindings::config_group) -> *const Self {
 ///
 /// To add a subgroup to configfs, pass this type as `ctype` to
 /// [`crate::configfs_attrs`] when creating a group in [`GroupOperations::make_group`].
-#[pin_data]
+#[pin_data(PinnedDrop)]
 pub struct Group<Data> {
     #[pin]
     group: Opaque<bindings::config_group>,
     #[pin]
     data: Data,
+    default_groups: KVec<Arc<dyn CDefaultGroup>>,
+}
+
+#[pinned_drop]
+impl<Data> PinnedDrop for Group<Data> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: We have exclusive access to `self` and we know the default groups are alive
+        // because we reference them through `self.default_groups`.
+        //
+        // `configfs_remove_default_groups` releases one reference on each default group. That is
+        // the reference `Self::new` acquired before adding the group, so the references owned by
+        // the `Arc` values in `self.default_groups` are not affected. Those are released when the
+        // field is dropped, which happens after this function returns.
+        unsafe { bindings::configfs_remove_default_groups(self.group.get()) };
+    }
 }
 
-// SAFETY: We do not provide any operations on `Group`.
+// SAFETY: We do not provide any operations on `Group`, and `self.default_groups` only holds
+// values that are `Send` and `Sync`, because [`CDefaultGroup`] requires both.
 unsafe impl<Data> Sync for Group<Data> {}
 
 // SAFETY: Ownership of `Group` can safely be transferred to other threads if
-// its data can be transferred as well.
+// its data can be transferred as well. The same holds for `self.default_groups`, because
+// [`CDefaultGroup`] requires `Send`.
 unsafe impl<Data: Send> Send for Group<Data> {}
 
 impl<Data> Group<Data> {
@@ -262,26 +283,171 @@ impl<Data> Group<Data> {
     ///
     /// When instantiated, the group will appear as a directory with the name
     /// given by `name` and it will contain attributes specified by `item_type`.
+    ///
+    /// Each element of `default_groups` is added as a default group of the new group and will
+    /// appear as a subdirectory of it.
     pub fn new(
         name: CString,
         item_type: &'static ItemType<Group<Data>, Data>,
         data: impl PinInit<Data, Error>,
+        default_groups: impl IntoIterator<Item = UnattachedGroup<dyn CDefaultGroup>>,
     ) -> impl PinInit<Self, Error> {
-        try_pin_init!(Self {
-            group <- pin_init::init_zeroed().chain(|v: &mut Opaque<bindings::config_group>| {
-                let place = v.get();
-                let name = name.to_bytes_with_nul().as_ptr();
-                // SAFETY: It is safe to initialize a group once it has been zeroed.
-                unsafe {
-                    bindings::config_group_init_type_name(place, name.cast(), item_type.as_ptr())
-                };
-                Ok(())
-            }),
-            data <- data,
+        pin_init::pin_init_scope(move || {
+            // Transition the permission tokens into `Arc`s.
+            let mut dg: KVec<Arc<dyn CDefaultGroup>> = KVec::new();
+            for group in default_groups {
+                dg.push(group.into_arc(), GFP_KERNEL)?;
+            }
+
+            Ok(try_pin_init!(Self {
+                // `data` is initialized first because it is the only fallible step. Nothing may
+                // fail after the default groups below have been added to `group`, because the
+                // references acquired for them are only released by the
+                // `configfs_remove_default_groups` call in `PinnedDrop`, which does not run if
+                // initialization fails.
+                data <- data,
+                group <- pin_init::init_zeroed().chain(|v: &mut Opaque<bindings::config_group>| {
+                    let place = v.get();
+                    let name = name.to_bytes_with_nul().as_ptr();
+                    // SAFETY: It is safe to initialize a group once it has been zeroed.
+                    unsafe {
+                        bindings::config_group_init_type_name(
+                            place,
+                            name.cast(),
+                            item_type.as_ptr(),
+                        )
+                    };
+
+                    for default_group in &dg {
+                        let child = default_group.group_ptr();
+
+                        // `configfs_add_default_group` does not acquire a reference on the group
+                        // it adds, but `configfs_remove_default_groups` releases one. Acquire the
+                        // reference that the removal in `PinnedDrop` will release, so that the
+                        // reference owned by `default_group` stays intact.
+                        //
+                        // SAFETY: By the safety requirements of `CDefaultGroup`, `child` points to
+                        // an initialized `struct config_group`, and it stays live because
+                        // `default_group` keeps it alive.
+                        unsafe { bindings::config_item_get(&raw mut (*child).cg_item) };
+
+                        // SAFETY: As above, `child` points to an initialized
+                        // `struct config_group` that stays live until `Self` is dropped, because
+                        // `dg` is a field of `Self`.
+                        //
+                        // `child` is not already a default group of any group: each element of
+                        // `dg` came from an `UnattachedGroup` consumed above, whose type
+                        // invariants say so, and the only way to attach a group is to pass such a
+                        // token to this function, so nothing can have attached it in between.
+                        unsafe { bindings::configfs_add_default_group(child, place) }
+                    }
+                    Ok(())
+                }),
+                default_groups: dg,
+            }))
         })
     }
 }
 
+/// A trait for default configfs groups added by C code.
+///
+/// Rust abstractions that work with C code that creates configfs groups can implement this trait to
+/// add the groups as default groups via the Rust configfs API.
+///
+/// Note that implementing this trait is not by itself enough to add a group as a default group of a
+/// [`Group`]. Construct the implementer with [`UnattachedGroup::new`] and pass the resulting
+/// [`UnattachedGroup`] to [`Group::new`].
+///
+/// # Safety
+///
+/// Implementers must ensure that:
+///
+/// - [`CDefaultGroup::group_ptr`] returns a pointer to a `struct config_group` that has been
+///   initialized by `config_group_init_type_name`, or by a C function that calls it.
+/// - Every call to [`CDefaultGroup::group_ptr`] on the same value returns the same pointer.
+/// - The pointee stays live, initialized and in place for as long as `self` is live.
+/// - The reference on the embedded `struct config_item` that was acquired when the group was
+///   initialized is owned by `self` and is released when `self` is dropped.
+/// - The implementer never adds the group as a default group of any group itself. Only
+///   [`Group::new`] may do that.
+pub unsafe trait CDefaultGroup: Send + Sync {
+    /// Return a raw pointer to the group definition.
+    fn group_ptr(&self) -> *mut bindings::config_group;
+}
+
+/// A group that is not yet attached as a default group of a [`Group`].
+///
+/// This type is a token that grants permission to attach a group once. It cannot be cloned, and
+/// [`Group::new`] consumes it, so a group cannot be attached twice. Use
+/// [`UnattachedGroup::clone_arc`] to obtain a handle to the group, which can be cloned freely but
+/// cannot be used to attach the group.
+///
+/// [`Group::new`] takes an `UnattachedGroup<dyn CDefaultGroup>`, so that one [`Group`] can have
+/// default groups of different types. An `UnattachedGroup<T>` coerces to that type.
+///
+/// # Invariants
+///
+/// The `struct config_group` returned by [`CDefaultGroup::group_ptr`] on `self.0` is not a default
+/// group of any group.
+#[repr(transparent)]
+#[derive(core::marker::CoercePointee)]
+pub struct UnattachedGroup<T: ?Sized>(Arc<T>);
+
+impl<T: CDefaultGroup + 'static> UnattachedGroup<T> {
+    /// Create a group that can be attached as a default group of a [`Group`].
+    ///
+    /// The returned value grants permission to attach the group to exactly one [`Group`] via
+    /// [`Group::new`]. Use [`UnattachedGroup::clone_arc`] to obtain a handle to the group itself.
+    #[inline]
+    pub fn new<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        let group = Arc::pin_init(init, flags)?;
+
+        // INVARIANT: `group` was just created and this function holds the only reference to it, so
+        // by the safety requirements of `CDefaultGroup` the group it wraps is not a default group
+        // of any group. The reference on the embedded `struct config_item` is owned by the group
+        // itself, also by the safety requirements of `CDefaultGroup`.
+        //
+        // SAFETY: Same as above.
+        Ok(unsafe { Self::from_arc(group) })
+    }
+
+    /// Create an [`UnattachedGroup`] from an existing [`Arc`].
+    ///
+    /// # Safety
+    ///
+    /// The `struct config_group` returned by `group.group_ptr()` must not be a default group of any
+    /// group.
+    #[inline]
+    unsafe fn from_arc(group: Arc<T>) -> Self {
+        // INVARIANT: By the safety requirements of this function, the group is not a default group
+        // of any group.
+        Self(group)
+    }
+}
+
+impl<T: CDefaultGroup + ?Sized> UnattachedGroup<T> {
+    /// Clone an [`UnattachedGroup`] into an [`Arc`].
+    ///
+    /// The returned [`Arc`] can be cloned, and it keeps the group alive independently of the
+    /// [`Group`] that the group is attached to. It cannot be used to attach the group.
+    #[inline]
+    pub fn clone_arc(&self) -> Arc<T> {
+        self.0.clone()
+    }
+
+    /// Convert an [`UnattachedGroup`] into an [`Arc`].
+    ///
+    /// This gives up the permission to attach the group, so the group can no longer be attached as
+    /// a default group of a [`Group`].
+    #[inline]
+    pub fn into_arc(self) -> Arc<T> {
+        self.0
+    }
+}
+
 // SAFETY: `Group<Data>` embeds a field of type `bindings::config_group`
 // within the `group` field.
 unsafe impl<Data> HasGroup<Data> for Group<Data> {
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index a1bd9db6010d..ada378bc331b 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -83,7 +83,12 @@ fn make_group(&self, name: &CStr) -> Result<impl PinInit<configfs::Group<Child>,
             ],
         };
 
-        Ok(configfs::Group::new(name.try_into()?, tpe, Child::new()))
+        Ok(configfs::Group::new(
+            name.try_into()?,
+            tpe,
+            Child::new(),
+            core::iter::empty(),
+        ))
     }
 }
 
@@ -152,6 +157,7 @@ fn make_group(&self, name: &CStr) -> Result<impl PinInit<configfs::Group<GrandCh
             name.try_into()?,
             tpe,
             GrandChild::new(),
+            core::iter::empty(),
         ))
     }
 }

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260215-configfs-c-default-groups-bdb0a44633a6

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


