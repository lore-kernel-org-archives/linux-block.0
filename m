Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7BF3603E8
	for <linux-block@vger.kernel.org>; Fri, 19 Jun 2026 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860252; cv=none; b=eeAa2RnuvvcnmBxhsyhJlqqVxeO8l9Z07oaes+n9QxHsLXp243HIE7HNoINA60xxNfuflU2Phz4TTQ9l59jJjsBUAna+k5CIuV3MuqrgHKIbUHWdLMN9pKXr6ETt6l8rRCr12y9Xa39t3NhiqQh3IfmSDtRF6R2kqX6jhsyLByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860252; c=relaxed/simple;
	bh=RshchSFBgcRK69878p9jdKW4Auqu64vKx7/hADqlUJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gOjJFQY758cTnivipDj7g9P+txjF/pWAMMekLq+hw0rlvs7HM/+Wto0Ypmh3SHslz7oalHLpZbWwdJ9ML1R0cYsG22jpNEBjstzcv95j3xly0D+98CHpMdu/+8QAquV4mAcPAPNuPDJ2niFyDgbxsrK6UIrByAzs+1BiOEiO0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJkVxl5D; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJkVxl5D"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46255b269c2so1421948f8f.3
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2026 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781860248; x=1782465048; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VNiM+Mbgshf95K/t5PON/G7yr52Wr4iGLwkbNBlHbBU=;
        b=UJkVxl5DpkbP4zNDeyirUyOdZhtEkYkZIhsOVlPmL0bjG9Wj/59DPWfhFfnv/NfY1O
         v8OLxfB+hu94C3Xd6u+9WrGQij2cCp0yQMUBHvUh02QYnjU/RqkUaTRgKGfpWfWGW/z0
         Ox33jIc+p77V4UZ5TB7jN6dcBg/GMWBqNYSWAK23qt3ay33+SnsSreDFRhMtQQXX6Hqx
         7spLDN/InA7gfZ4pa+BuizsCuz0/yIZ527hfaiz/FZnJTRTzUSUAJtSFG9eq8w1PI0LB
         nnKyr4qoTO5gRXSvbEz6TDcteLQeyZ6XmC1zkvudkRCtjLmk/9KwCVRqSRMTFc0Jfn56
         C/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781860248; x=1782465048;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNiM+Mbgshf95K/t5PON/G7yr52Wr4iGLwkbNBlHbBU=;
        b=YCsFBGHlV5UpM7ELelxyLCmge8jWvo5LEmheuxIl9MiXAfZQI+DzZaNsfRQYkEhhwj
         QrIiCiCA7MIdHPiKJR1z4Sq6dgfqZiElzkGs/hrxahgmc+qaLKmapHTJxnZlFrM2V0rF
         uIjtpfdn9LP+q8wqwfOCuNQdfysE4GRTw1DU26MxWY1rZhm0xaNMDx8xrIUAYYESda72
         nxPcYcrz/ci7V3cqM1r6Qoh7cRnbEdkoBdYXyMRfMOi5DFS3ypnWatteZh1fKgLP9cYf
         adr8hKOleSEXseX2jbLwZqU7+6H/qRb0M5yLmNXxSgFqTDAnj3t7L55CPLhnV+e1z64S
         o2Vw==
X-Forwarded-Encrypted: i=1; AFNElJ+aJWmDpc74K1SaYb35K1kV4YH+jdjEXhHm5npEATq+jT/mCmICrCIwmPyzgj+gYuDHnW8+MPhRDt/peQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDltKbU3qTKgahnTyLdesNNi1IDx7pnbetKC0AMTFud53/caz
	HYTyp8g6KqtNnhujNNyNG7zGhQXcNdrP4h2lhGIPEdSDfAU6jBvvcdF5
X-Gm-Gg: AfdE7cnI+LNCAKGtwMkt4oeZcA0kXnQ8a0LoKBlua/AJvuLSXUm9M/VrTiWbhx2Z676
	Kmw+ZtWsKJrz+rIeKVzP/GlXQBcFiX7XUwp+T3jdiCHjX/+/pxVU657hPUzWpZp6Ftr3JqwAsPp
	Jn+VwXtmwgPFbB4euPxm8PBhE33eihs4gn7UD3yUklunRs0CIt3yWvBu6YnHpAJUKQeAEVn/7AM
	9zEZeX3WKUwrVDesF2SIF3ukyMb3tWgL3yB7+NHl4vZI5iNsVour1+nT2XVrUlFacxQ4cgdBJIs
	4GAdVNrMaWzXUJzA71Ka2r2ZvRlc152h9O0zEw7b325XPiRpATwkbBSf/o/qqQ/d784SVazNbkB
	oKSEOXEUvExPDTcFSYcHARdL7Gc9H7+U3psQkMbkAdIl8RkSFeTWcNtZ2WHgVKqbxVPRcWiL7p5
	G9gFS1Nx/4aNtJKhTix36U+IuMfkRaasltRsnxzMQG9VSRE3B1YVU=
X-Received: by 2002:adf:f5c3:0:b0:460:3234:77d2 with SMTP id ffacd0b85a97d-46502badfe5mr3528600f8f.40.1781860247458;
        Fri, 19 Jun 2026 02:10:47 -0700 (PDT)
Received: from [192.168.6.4] ([195.100.225.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-465059e721fsm6754472f8f.0.2026.06.19.02.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:10:46 -0700 (PDT)
From: Malte Wechter <maltewechter@gmail.com>
Date: Fri, 19 Jun 2026 11:10:43 +0200
Subject: [PATCH v4] rust: configfs: add procedural macro for declaring
 configfs attributes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-syn-v4-1-207c39504c1e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13NQQ6CMBCF4auYrq3pTKEFV97DuICxhSZCTWuIh
 HB3Cy4Ulm+S75+JRROciex8mFgwg4vO92lkxwOjtuobw909bYYClchAc/K9dY2NPI49hxKM0CC
 FQM0SeQZj3XvNXW9pty6+fBjX+gDL9RvKUWxDA3DgivK6EFVJxuKl6Sr3OJHv2BIa8IeVkDuMC
 VOdF1lREqpM77H8w4A7LBOWWKKtKSeSm8/zPH8AW3vPWyIBAAA=
X-Change-ID: 20260417-configfs-syn-191e07130027
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-modules@vger.kernel.org, 
 Malte Wechter <maltewechter@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781860245; l=32626;
 i=maltewechter@gmail.com; s=20260417; h=from:subject:message-id;
 bh=RshchSFBgcRK69878p9jdKW4Auqu64vKx7/hADqlUJ4=;
 b=tqteMb0a4RVKpBxxyVRNTFRNBiGDOsmewzWNWKyeDoc8fXW7nkrJ4Hb0+tEYXnco0lZxUPm4y
 cbBVAq7jQ7vDfX58WS/3+sGKgBE1EvoIH1crmE62NcOMB+ctWuxiUpz
X-Developer-Key: i=maltewechter@gmail.com; a=ed25519;
 pk=07WplWXZnwyLTMZOHNCIGcpoEutcMXU/JDY6f9VtxSY=

Implement `configfs_attrs!` as a procedural macro using `syn`, this
improves readability and maintainability. Remove the old macro and
replace all uses with the new macro. Add the new macro implementation
file to MAINTAINERS.

Signed-off-by: Malte Wechter <maltewechter@gmail.com>
---
Changes in v4:
- Update link path to configfs_attr macro in configfs.rs
- Fix doc strings for configfs_attr in macros/lib.rs
- Fix doc strings for parse_ordered_fields in macros/helpers.rs
- Update title prefix to `rust: configfs:`
- Link to v3: https://lore.kernel.org/r/20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com

Changes in v3:
- Remove 'make_static_ident' function, make names for static variables simpler
- Move 'parse_ordered_fields' macro from module.rs into helpers
- Use 'parse_ordered_fields' macro for parsing instead of doing it ad-hoc
- Link to v2: https://lore.kernel.org/r/20260603-configfs-syn-v2-1-cb58489c2647@gmail.com

Changes in v2:
- Add a try_parse helper function to macros/helpers.rs
- Fix bug where 'child' configuration gets dropped if trailing comma is missing (sashiko)
- Link to v1: https://lore.kernel.org/r/20260520-configfs-syn-v1-1-6c5b80a9cef2@gmail.com
---
 MAINTAINERS                     |   1 +
 drivers/block/rnull/configfs.rs |   2 +-
 rust/kernel/configfs.rs         | 263 +---------------------------------------
 rust/macros/configfs_attrs.rs   | 135 +++++++++++++++++++++
 rust/macros/helpers.rs          | 139 +++++++++++++++++++++
 rust/macros/lib.rs              |  87 +++++++++++++
 rust/macros/module.rs           | 137 ---------------------
 samples/rust/rust_configfs.rs   |   2 +-
 8 files changed, 370 insertions(+), 396 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..45f7a1ec93b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6464,6 +6464,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git config
 F:	fs/configfs/
 F:	include/linux/configfs.h
 F:	rust/kernel/configfs.rs
+F:	rust/macros/configfs_attrs.rs
 F:	samples/configfs/
 F:	samples/rust/rust_configfs.rs
 
diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 7c2eb5c0b722..f28ec69d7984 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -4,8 +4,8 @@
 use kernel::{
     block::mq::gen_disk::{GenDisk, GenDiskBuilder},
     configfs::{self, AttributeOperations},
-    configfs_attrs,
     fmt::{self, Write as _},
+    macros::configfs_attrs,
     new_mutex,
     page::PAGE_SIZE,
     prelude::*,
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2339c6467325..a8995a418136 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -21,7 +21,7 @@
 //!
 //! ```ignore
 //! use kernel::alloc::flags;
-//! use kernel::configfs_attrs;
+//! use macros::configfs_attrs;
 //! use kernel::configfs;
 //! use kernel::new_mutex;
 //! use kernel::page::PAGE_SIZE;
@@ -240,7 +240,7 @@ unsafe fn container_of(group: *const bindings::config_group) -> *const Self {
 /// A configfs group.
 ///
 /// To add a subgroup to configfs, pass this type as `ctype` to
-/// [`crate::configfs_attrs`] when creating a group in [`GroupOperations::make_group`].
+/// [`macros::configfs_attrs`] when creating a group in [`GroupOperations::make_group`].
 #[pin_data]
 pub struct Group<Data> {
     #[pin]
@@ -637,7 +637,7 @@ pub const fn new(name: &'static CStr) -> Self {
 /// implement `HasGroup<Data>`. The trait must be implemented once for each
 /// attribute of the group. The constant type parameter `ID` maps the
 /// implementation to a specific `Attribute`. `ID` must be passed when declaring
-/// attributes via the [`kernel::configfs_attrs`] macro, to tie
+/// attributes via the [`macros::configfs_attrs`] macro, to tie
 /// `AttributeOperations` implementations to concrete named attributes.
 #[vtable]
 pub trait AttributeOperations<const ID: u64 = 0> {
@@ -669,13 +669,13 @@ fn store(_data: &Self::Data, _page: &[u8]) -> Result {
 /// This type is used to construct a new [`ItemType`]. It represents a list of
 /// [`Attribute`] that will appear in the directory representing a [`Group`].
 /// Users should not directly instantiate this type, rather they should use the
-/// [`kernel::configfs_attrs`] macro to declare a static set of attributes for a
+/// [`macros::configfs_attrs`] macro to declare a static set of attributes for a
 /// group.
 ///
 /// # Note
 ///
 /// Instances of this type are constructed statically at compile by the
-/// [`kernel::configfs_attrs`] macro.
+/// [`macros::configfs_attrs`] macro.
 #[repr(transparent)]
 pub struct AttributeList<const N: usize, Data>(
     /// Null terminated Array of pointers to [`Attribute`]. The type is [`c_void`]
@@ -724,7 +724,7 @@ impl<const N: usize, Data> AttributeList<N, Data> {
 /// [`Subsystem`].
 ///
 /// Users should not directly instantiate objects of this type. Rather, they
-/// should use the [`kernel::configfs_attrs`] macro to statically declare the
+/// should use the [`macros::configfs_attrs`] macro to statically declare the
 /// shape of a [`Group`] or [`Subsystem`].
 #[pin_data]
 pub struct ItemType<Container, Data> {
@@ -791,254 +791,3 @@ fn as_ptr(&self) -> *const bindings::config_item_type {
         self.item_type.get()
     }
 }
-
-/// Define a list of configfs attributes statically.
-///
-/// Invoking the macro in the following manner:
-///
-/// ```ignore
-/// let item_type = configfs_attrs! {
-///     container: configfs::Subsystem<Configuration>,
-///     data: Configuration,
-///     child: Child,
-///     attributes: [
-///         message: 0,
-///         bar: 1,
-///     ],
-/// };
-/// ```
-///
-/// Expands the following output:
-///
-/// ```ignore
-/// let item_type = {
-///     static CONFIGURATION_MESSAGE_ATTR: kernel::configfs::Attribute<
-///         0,
-///         Configuration,
-///         Configuration,
-///     > = unsafe {
-///         kernel::configfs::Attribute::new({
-///             const S: &str = "message\u{0}";
-///             const C: &kernel::str::CStr = match kernel::str::CStr::from_bytes_with_nul(
-///                 S.as_bytes()
-///             ) {
-///                 Ok(v) => v,
-///                 Err(_) => {
-///                     core::panicking::panic_fmt(core::const_format_args!(
-///                         "string contains interior NUL"
-///                     ));
-///                 }
-///             };
-///             C
-///         })
-///     };
-///
-///     static CONFIGURATION_BAR_ATTR: kernel::configfs::Attribute<
-///             1,
-///             Configuration,
-///             Configuration
-///     > = unsafe {
-///         kernel::configfs::Attribute::new({
-///             const S: &str = "bar\u{0}";
-///             const C: &kernel::str::CStr = match kernel::str::CStr::from_bytes_with_nul(
-///                 S.as_bytes()
-///             ) {
-///                 Ok(v) => v,
-///                 Err(_) => {
-///                     core::panicking::panic_fmt(core::const_format_args!(
-///                         "string contains interior NUL"
-///                     ));
-///                 }
-///             };
-///             C
-///         })
-///     };
-///
-///     const N: usize = (1usize + (1usize + 0usize)) + 1usize;
-///
-///     static CONFIGURATION_ATTRS: kernel::configfs::AttributeList<N, Configuration> =
-///         unsafe { kernel::configfs::AttributeList::new() };
-///
-///     {
-///         const N: usize = 0usize;
-///         unsafe { CONFIGURATION_ATTRS.add::<N, 0, _>(&CONFIGURATION_MESSAGE_ATTR) };
-///     }
-///
-///     {
-///         const N: usize = (1usize + 0usize);
-///         unsafe { CONFIGURATION_ATTRS.add::<N, 1, _>(&CONFIGURATION_BAR_ATTR) };
-///     }
-///
-///     static CONFIGURATION_TPE:
-///       kernel::configfs::ItemType<configfs::Subsystem<Configuration> ,Configuration>
-///         = kernel::configfs::ItemType::<
-///                 configfs::Subsystem<Configuration>,
-///                 Configuration
-///                 >::new_with_child_ctor::<N,Child>(
-///             &THIS_MODULE,
-///             &CONFIGURATION_ATTRS
-///         );
-///
-///     &CONFIGURATION_TPE
-/// }
-/// ```
-#[macro_export]
-macro_rules! configfs_attrs {
-    (
-        container: $container:ty,
-        data: $data:ty,
-        attributes: [
-            $($name:ident: $attr:literal),* $(,)?
-        ] $(,)?
-    ) => {
-        $crate::configfs_attrs!(
-            count:
-            @container($container),
-            @data($data),
-            @child(),
-            @no_child(x),
-            @attrs($($name $attr)*),
-            @eat($($name $attr,)*),
-            @assign(),
-            @cnt(0usize),
-        )
-    };
-    (
-        container: $container:ty,
-        data: $data:ty,
-        child: $child:ty,
-        attributes: [
-            $($name:ident: $attr:literal),* $(,)?
-        ] $(,)?
-    ) => {
-        $crate::configfs_attrs!(
-            count:
-            @container($container),
-            @data($data),
-            @child($child),
-            @no_child(),
-            @attrs($($name $attr)*),
-            @eat($($name $attr,)*),
-            @assign(),
-            @cnt(0usize),
-        )
-    };
-    (count:
-     @container($container:ty),
-     @data($data:ty),
-     @child($($child:ty)?),
-     @no_child($($no_child:ident)?),
-     @attrs($($aname:ident $aattr:literal)*),
-     @eat($name:ident $attr:literal, $($rname:ident $rattr:literal,)*),
-     @assign($($assign:block)*),
-     @cnt($cnt:expr),
-    ) => {
-        $crate::configfs_attrs!(
-            count:
-            @container($container),
-            @data($data),
-            @child($($child)?),
-            @no_child($($no_child)?),
-            @attrs($($aname $aattr)*),
-            @eat($($rname $rattr,)*),
-            @assign($($assign)* {
-                const N: usize = $cnt;
-                // The following macro text expands to a call to `Attribute::add`.
-
-                // SAFETY: By design of this macro, the name of the variable we
-                // invoke the `add` method on below, is not visible outside of
-                // the macro expansion. The macro does not operate concurrently
-                // on this variable, and thus we have exclusive access to the
-                // variable.
-                unsafe {
-                    $crate::macros::paste!(
-                        [< $data:upper _ATTRS >]
-                            .add::<N, $attr, _>(&[< $data:upper _ $name:upper _ATTR >])
-                    )
-                };
-            }),
-            @cnt(1usize + $cnt),
-        )
-    };
-    (count:
-     @container($container:ty),
-     @data($data:ty),
-     @child($($child:ty)?),
-     @no_child($($no_child:ident)?),
-     @attrs($($aname:ident $aattr:literal)*),
-     @eat(),
-     @assign($($assign:block)*),
-     @cnt($cnt:expr),
-    ) =>
-    {
-        $crate::configfs_attrs!(
-            final:
-            @container($container),
-            @data($data),
-            @child($($child)?),
-            @no_child($($no_child)?),
-            @attrs($($aname $aattr)*),
-            @assign($($assign)*),
-            @cnt($cnt),
-        )
-    };
-    (final:
-     @container($container:ty),
-     @data($data:ty),
-     @child($($child:ty)?),
-     @no_child($($no_child:ident)?),
-     @attrs($($name:ident $attr:literal)*),
-     @assign($($assign:block)*),
-     @cnt($cnt:expr),
-    ) =>
-    {
-        $crate::macros::paste!{
-            {
-                $(
-                    // SAFETY: We are expanding `configfs_attrs`.
-                    static [< $data:upper _ $name:upper _ATTR >]:
-                        $crate::configfs::Attribute<$attr, $data, $data> =
-                            unsafe {
-                                $crate::configfs::Attribute::new(
-                                    $crate::c_str!(::core::stringify!($name)),
-                                )
-                            };
-                )*
-
-
-                // We need space for a null terminator.
-                const N: usize = $cnt + 1usize;
-
-                // SAFETY: We are expanding `configfs_attrs`.
-                static [< $data:upper _ATTRS >]:
-                $crate::configfs::AttributeList<N, $data> =
-                    unsafe { $crate::configfs::AttributeList::new() };
-
-                $($assign)*
-
-                $(
-                    const [<$no_child:upper>]: bool = true;
-
-                    static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
-                        $crate::configfs::ItemType::<$container, $data>::new::<N>(
-                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
-                        );
-                )?
-
-                $(
-                    static [< $data:upper _TPE >]:
-                        $crate::configfs::ItemType<$container, $data>  =
-                            $crate::configfs::ItemType::<$container, $data>::
-                            new_with_child_ctor::<N, $child>(
-                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
-                            );
-                )?
-
-                & [< $data:upper _TPE >]
-            }
-        }
-    };
-
-}
-
-pub use crate::configfs_attrs;
diff --git a/rust/macros/configfs_attrs.rs b/rust/macros/configfs_attrs.rs
new file mode 100644
index 000000000000..81037bc38188
--- /dev/null
+++ b/rust/macros/configfs_attrs.rs
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use quote::{
+    format_ident,
+    quote, //
+};
+
+use syn::{
+    bracketed,
+    ext::IdentExt,
+    parse::{
+        Parse,
+        ParseStream, //
+    },
+    punctuated::Punctuated,
+    spanned::Spanned,
+    Error,
+    Ident,
+    LitInt,
+    Token,
+    Type, //
+};
+
+use crate::helpers::parse_ordered_fields;
+
+pub(crate) struct ConfigfsAttrs {
+    container: Type,
+    data: Type,
+    child: Option<Type>,
+    attributes: Vec<(Ident, LitInt)>,
+}
+
+fn parse_attribute_field(stream: ParseStream<'_>) -> syn::Result<(Ident, LitInt)> {
+    let id = stream.parse::<syn::Ident>()?;
+    let _colon = stream.parse::<Token![:]>()?;
+    let v = stream.parse::<LitInt>()?;
+    Ok((id, v))
+}
+
+fn parse_attributes(stream: ParseStream<'_>) -> syn::Result<Vec<(Ident, LitInt)>> {
+    let attr_stream;
+    let _bracket = bracketed!(attr_stream in stream);
+    let attributes = Punctuated::<(Ident, LitInt), Token![,]>::parse_terminated_with(
+        &attr_stream,
+        parse_attribute_field,
+    )?;
+    Ok(attributes.into_iter().collect::<Vec<_>>())
+}
+
+impl Parse for ConfigfsAttrs {
+    fn parse(input: ParseStream<'_>) -> syn::Result<Self> {
+        parse_ordered_fields!(
+            from input;
+            container [required] => (input.parse::<Type>())?,
+            data [required] => (input.parse::<Type>())?,
+            child => (input.parse::<Type>())?,
+            attributes [required] => parse_attributes(input)?,
+        );
+
+        Ok(ConfigfsAttrs {
+            container,
+            data,
+            child,
+            attributes,
+        })
+    }
+}
+
+pub(crate) fn configfs_attrs(cfs_attrs: ConfigfsAttrs) -> proc_macro2::TokenStream {
+    let (container_ty, data_ty) = (&cfs_attrs.container, &cfs_attrs.data);
+
+    let data_tp_ident = Ident::new("DATA_TPE", cfs_attrs.data.span());
+    let data_attr_ident = Ident::new("DATA_ATTR_LIST", cfs_attrs.data.span());
+
+    let n = cfs_attrs.attributes.len() + 1;
+
+    let attr_list = quote! {
+        static #data_attr_ident: kernel::configfs::AttributeList<#n, #data_ty> =
+            // SAFETY: We are expanding `configfs_attrs`.
+            unsafe { kernel::configfs::AttributeList::new() };
+    };
+
+    let mut attrs = Vec::new();
+    for (attr_idx, (name, id)) in cfs_attrs.attributes.iter().enumerate() {
+        let name_with_attr = format_ident!("{}_ATTR_{}", name.to_string().to_uppercase(), attr_idx);
+
+        let id: u64 = match id.base10_parse::<u64>() {
+            Ok(v) => v,
+            Err(_) => {
+                return syn::Error::new(id.span(), "Could not parse attribute ID as a u64")
+                    .to_compile_error();
+            }
+        };
+
+        attrs.push(quote! {
+        static #name_with_attr: kernel::configfs::Attribute<#id, #data_ty, #data_ty> =
+            // SAFETY: We are expanding `configfs_attrs`.
+            unsafe {
+              kernel::configfs::Attribute::new(kernel::c_str!(::core::stringify!(#name)))
+            };
+
+          // SAFETY: By design of this macro, the name of the variable we
+          // invoke the `add` method on below, is not visible outside of
+          // the macro expansion. The macro does not operate concurrently
+          // on this variable, and thus we have exclusive access to the
+          // variable.
+          unsafe { #data_attr_ident.add::<#attr_idx, #id, _>(&#name_with_attr) }
+        });
+    }
+
+    let has_child_code = if let Some(child) = cfs_attrs.child {
+        quote! { new_with_child_ctor::<#n, #child>}
+    } else {
+        quote! { new::<#n> }
+    };
+
+    let data_type = quote! {
+        {
+            static #data_tp_ident:
+            kernel::configfs::ItemType<#container_ty, #data_ty> =
+                kernel::configfs::ItemType::<#container_ty, #data_ty>::#has_child_code(
+                    &THIS_MODULE, &#data_attr_ident
+                );
+            &#data_tp_ident
+        }
+    };
+
+    quote! {
+        {
+            #attr_list
+            #(#attrs)*
+            #data_type
+        }
+    }
+}
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index d18fbf4daa0a..305dcbddf797 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -58,3 +58,142 @@ pub(crate) fn file() -> String {
 pub(crate) fn gather_cfg_attrs(attr: &[Attribute]) -> impl Iterator<Item = &Attribute> + '_ {
     attr.iter().filter(|a| a.path().is_ident("cfg"))
 }
+
+/// Parse fields that are required to use a specific order.
+///
+/// As fields must follow a specific order, we *could* just parse fields one by one by peeking.
+/// However the error message generated when implementing that way is not very friendly.
+///
+/// So instead we parse fields in an arbitrary order, but only enforce the ordering after parsing,
+/// and if the wrong order is used, the proper order is communicated to the user with error message.
+///
+/// Usage looks like this:
+/// ```ignore
+/// parse_ordered_fields! {
+///     from input;
+///
+///     // This will extract `foo: <field>` into a variable named `foo`.
+///     // The variable will have type `Option<_>`.
+///     foo => <expression that parses the field>,
+///
+///     // If you need the variable name to be different than the key name.
+///     // This extracts `baz: <field>` into a variable named `bar`.
+///     // You might want this if `baz` is a keyword.
+///     baz as bar => <expression that parse the field>,
+///
+///     // You can mark a key as required, and the variable will no longer be `Option`.
+///     // foobar will be of type `Expr` instead of `Option<Expr>`.
+///     foobar [required] => input.parse::<Expr>()?,
+/// }
+/// ```
+macro_rules! parse_ordered_fields {
+    (@gen
+        [$input:expr]
+        [$([$name:ident; $key:ident; $parser:expr])*]
+        [$([$req_name:ident; $req_key:ident])*]
+    ) => {
+        $(let mut $name = None;)*
+
+        const EXPECTED_KEYS: &[&str] = &[$(stringify!($key),)*];
+        const REQUIRED_KEYS: &[&str] = &[$(stringify!($req_key),)*];
+
+        let span = $input.span();
+        let mut seen_keys = Vec::new();
+
+        while !$input.is_empty() {
+            let key = $input.call(Ident::parse_any)?;
+
+            if seen_keys.contains(&key) {
+                Err(Error::new_spanned(
+                    &key,
+                    format!(r#"duplicated key "{key}". Keys can only be specified once."#),
+                ))?
+            }
+
+            $input.parse::<Token![:]>()?;
+
+            match &*key.to_string() {
+                $(
+                    stringify!($key) => $name = Some($parser),
+                )*
+                _ => {
+                    Err(Error::new_spanned(
+                        &key,
+                        format!(r#"unknown key "{key}". Valid keys are: {EXPECTED_KEYS:?}."#),
+                    ))?
+                }
+            }
+
+            $input.parse::<Token![,]>()?;
+            seen_keys.push(key);
+        }
+
+        for key in REQUIRED_KEYS {
+            if !seen_keys.iter().any(|e| e == key) {
+                Err(Error::new(span, format!(r#"missing required key "{key}""#)))?
+            }
+        }
+
+        let mut ordered_keys: Vec<&str> = Vec::new();
+        for key in EXPECTED_KEYS {
+            if seen_keys.iter().any(|e| e == key) {
+                ordered_keys.push(key);
+            }
+        }
+
+        if seen_keys != ordered_keys {
+            Err(Error::new(
+                span,
+                format!(r#"keys are not ordered as expected. Order them like: {ordered_keys:?}."#),
+            ))?
+        }
+
+        $(let $req_name = $req_name.expect("required field");)*
+    };
+
+    // Handle required fields.
+    (@gen
+        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
+        $key:ident as $name:ident [required] => $parser:expr,
+        $($rest:tt)*
+    ) => {
+        parse_ordered_fields!(
+            @gen [$input] [$($tok)* [$name; $key; $parser]] [$($req)* [$name; $key]] $($rest)*
+        )
+    };
+    (@gen
+        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
+        $name:ident [required] => $parser:expr,
+        $($rest:tt)*
+    ) => {
+        parse_ordered_fields!(
+            @gen [$input] [$($tok)* [$name; $name; $parser]] [$($req)* [$name; $name]] $($rest)*
+        )
+    };
+
+    // Handle optional fields.
+    (@gen
+        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
+        $key:ident as $name:ident => $parser:expr,
+        $($rest:tt)*
+    ) => {
+        parse_ordered_fields!(
+            @gen [$input] [$($tok)* [$name; $key; $parser]] [$($req)*] $($rest)*
+        )
+    };
+    (@gen
+        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
+        $name:ident => $parser:expr,
+        $($rest:tt)*
+    ) => {
+        parse_ordered_fields!(
+            @gen [$input] [$($tok)* [$name; $name; $parser]] [$($req)*] $($rest)*
+        )
+    };
+
+    (from $input:expr; $($tok:tt)*) => {
+        parse_ordered_fields!(@gen [$input] [] [] $($tok)*)
+    }
+}
+
+pub(crate) use parse_ordered_fields;
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 2cfd59e0f9e7..ebb41e80ecc7 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -15,6 +15,8 @@
 #![cfg_attr(not(CONFIG_RUSTC_HAS_SPAN_FILE), feature(proc_macro_span))]
 
 mod concat_idents;
+#[cfg(CONFIG_CONFIGFS_FS)]
+mod configfs_attrs;
 mod export;
 mod fmt;
 mod helpers;
@@ -489,3 +491,88 @@ pub fn kunit_tests(attr: TokenStream, input: TokenStream) -> TokenStream {
         .unwrap_or_else(|e| e.into_compile_error())
         .into()
 }
+
+/// Define a list of configfs attributes statically.
+///
+/// # Examples
+///
+/// ```ignore
+/// let item_type = configfs_attrs! {
+///     container: configfs::Subsystem<Configuration>,
+///     data: Configuration,
+///     child: Child,
+///     attributes: [
+///         message: 0,
+///         bar: 1,
+///     ],
+/// };
+/// ```
+///
+/// Expands the following output:
+///
+/// ```ignore
+/// let item_type = {
+///         static DATA_ATTR_LIST: kernel::configfs::AttributeList<
+///             3usize,
+///             Configuration,
+///         > = unsafe { kernel::configfs::AttributeList::new() };
+///         static MESSAGE_ATTR_0: kernel::configfs::Attribute<
+///             0u64,
+///             Configuration,
+///             Configuration,
+///         > = unsafe {
+///             kernel::configfs::Attribute::new({
+///                 const S: &str = "message\u{0}";
+///                 const C: &kernel::str::CStr = match kernel::str::CStr::from_bytes_with_nul(
+///                     S.as_bytes(),
+///                 ) {
+///                     Ok(v) => v,
+///                     Err(_) => {
+///                         ::core::panicking::panic_fmt(
+///                             format_args!("string contains interior NUL"),
+///                         );
+///                     }
+///                 };
+///                 C
+///             })
+///         };
+///         unsafe { DATA_ATTR_LIST.add::<0usize, 0u64, _>(&MESSAGE_ATTR_0) }
+///         static BAR_ATTR_1: kernel::configfs::Attribute<
+///             1u64,
+///             Configuration,
+///             Configuration,
+///         > = unsafe {
+///             kernel::configfs::Attribute::new({
+///                 const S: &str = "bar\u{0}";
+///                 const C: &kernel::str::CStr = match kernel::str::CStr::from_bytes_with_nul(
+///                     S.as_bytes(),
+///                 ) {
+///                     Ok(v) => v,
+///                     Err(_) => {
+///                         ::core::panicking::panic_fmt(
+///                             format_args!("string contains interior NUL"),
+///                         );
+///                     }
+///                 };
+///                 C
+///             })
+///         };
+///         unsafe { DATA_ATTR_LIST.add::<1usize, 1u64, _>(&BAR_ATTR_1) }
+///         {
+///             static DATA_TPE: kernel::configfs::ItemType<
+///                 Subsystem<Configuration>,
+///                 Configuration,
+///             > = kernel::configfs::ItemType::<
+///                 Subsystem<Configuration>,
+///                 Configuration,
+///             >::new_with_child_ctor::<3usize, Child>(&THIS_MODULE, &DATA_ATTR_LIST);
+///             &DATA_TPE
+///         }
+///     };
+/// ```
+#[cfg(CONFIG_CONFIGFS_FS)]
+#[proc_macro]
+pub fn configfs_attrs(input: TokenStream) -> TokenStream {
+    configfs_attrs::configfs_attrs(parse_macro_input!(input as configfs_attrs::ConfigfsAttrs))
+        .into()
+}
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 06c18e207508..7ff6ad09b1a2 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -196,143 +196,6 @@ fn param_ops_path(param_type: &str) -> Path {
     }
 }
 
-/// Parse fields that are required to use a specific order.
-///
-/// As fields must follow a specific order, we *could* just parse fields one by one by peeking.
-/// However the error message generated when implementing that way is not very friendly.
-///
-/// So instead we parse fields in an arbitrary order, but only enforce the ordering after parsing,
-/// and if the wrong order is used, the proper order is communicated to the user with error message.
-///
-/// Usage looks like this:
-/// ```ignore
-/// parse_ordered_fields! {
-///     from input;
-///
-///     // This will extract "foo: <field>" into a variable named "foo".
-///     // The variable will have type `Option<_>`.
-///     foo => <expression that parses the field>,
-///
-///     // If you need the variable name to be different than the key name.
-///     // This extracts "baz: <field>" into a variable named "bar".
-///     // You might want this if "baz" is a keyword.
-///     baz as bar => <expression that parse the field>,
-///
-///     // You can mark a key as required, and the variable will no longer be `Option`.
-///     // foobar will be of type `Expr` instead of `Option<Expr>`.
-///     foobar [required] => input.parse::<Expr>()?,
-/// }
-/// ```
-macro_rules! parse_ordered_fields {
-    (@gen
-        [$input:expr]
-        [$([$name:ident; $key:ident; $parser:expr])*]
-        [$([$req_name:ident; $req_key:ident])*]
-    ) => {
-        $(let mut $name = None;)*
-
-        const EXPECTED_KEYS: &[&str] = &[$(stringify!($key),)*];
-        const REQUIRED_KEYS: &[&str] = &[$(stringify!($req_key),)*];
-
-        let span = $input.span();
-        let mut seen_keys = Vec::new();
-
-        while !$input.is_empty() {
-            let key = $input.call(Ident::parse_any)?;
-
-            if seen_keys.contains(&key) {
-                Err(Error::new_spanned(
-                    &key,
-                    format!(r#"duplicated key "{key}". Keys can only be specified once."#),
-                ))?
-            }
-
-            $input.parse::<Token![:]>()?;
-
-            match &*key.to_string() {
-                $(
-                    stringify!($key) => $name = Some($parser),
-                )*
-                _ => {
-                    Err(Error::new_spanned(
-                        &key,
-                        format!(r#"unknown key "{key}". Valid keys are: {EXPECTED_KEYS:?}."#),
-                    ))?
-                }
-            }
-
-            $input.parse::<Token![,]>()?;
-            seen_keys.push(key);
-        }
-
-        for key in REQUIRED_KEYS {
-            if !seen_keys.iter().any(|e| e == key) {
-                Err(Error::new(span, format!(r#"missing required key "{key}""#)))?
-            }
-        }
-
-        let mut ordered_keys: Vec<&str> = Vec::new();
-        for key in EXPECTED_KEYS {
-            if seen_keys.iter().any(|e| e == key) {
-                ordered_keys.push(key);
-            }
-        }
-
-        if seen_keys != ordered_keys {
-            Err(Error::new(
-                span,
-                format!(r#"keys are not ordered as expected. Order them like: {ordered_keys:?}."#),
-            ))?
-        }
-
-        $(let $req_name = $req_name.expect("required field");)*
-    };
-
-    // Handle required fields.
-    (@gen
-        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
-        $key:ident as $name:ident [required] => $parser:expr,
-        $($rest:tt)*
-    ) => {
-        parse_ordered_fields!(
-            @gen [$input] [$($tok)* [$name; $key; $parser]] [$($req)* [$name; $key]] $($rest)*
-        )
-    };
-    (@gen
-        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
-        $name:ident [required] => $parser:expr,
-        $($rest:tt)*
-    ) => {
-        parse_ordered_fields!(
-            @gen [$input] [$($tok)* [$name; $name; $parser]] [$($req)* [$name; $name]] $($rest)*
-        )
-    };
-
-    // Handle optional fields.
-    (@gen
-        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
-        $key:ident as $name:ident => $parser:expr,
-        $($rest:tt)*
-    ) => {
-        parse_ordered_fields!(
-            @gen [$input] [$($tok)* [$name; $key; $parser]] [$($req)*] $($rest)*
-        )
-    };
-    (@gen
-        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
-        $name:ident => $parser:expr,
-        $($rest:tt)*
-    ) => {
-        parse_ordered_fields!(
-            @gen [$input] [$($tok)* [$name; $name; $parser]] [$($req)*] $($rest)*
-        )
-    };
-
-    (from $input:expr; $($tok:tt)*) => {
-        parse_ordered_fields!(@gen [$input] [] [] $($tok)*)
-    }
-}
-
 struct Parameter {
     name: Ident,
     ptype: Ident,
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index a1bd9db6010d..876462f7789d 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -4,7 +4,7 @@
 
 use kernel::alloc::flags;
 use kernel::configfs;
-use kernel::configfs::configfs_attrs;
+use kernel::macros::configfs_attrs;
 use kernel::new_mutex;
 use kernel::page::PAGE_SIZE;
 use kernel::prelude::*;

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260417-configfs-syn-191e07130027

Best regards,
-- 
Malte Wechter <maltewechter@gmail.com>

