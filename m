Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182D2FE575;
	Fri,  5 Jun 2026 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665355; cv=none; b=oYEOYPARPY5Vcu/ALuPNTuqmLi+VRBYy8GZTQr8CSIJNZIv02ef76A+6eIHxT2nRqpgU+5SmxeLbQx6zPtWXl0sNAQYjEO4qEKSx9w59EW5GTTKERXOfnMQYS9uvbr68CYTCGdnEcn37SwpGciS5C2kWPLgFNzhcK939HzLMiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665355; c=relaxed/simple;
	bh=4fP5SkhuoOgUv8D99eiYoqo4+5dwT+PPw8sBA3Xj7ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pv14lyVrpofKh2+icGDRvRCilZXg7EwA1hEqKFDCZckvmqymV/W0KqDvIYmd3Z7PXHcntvjMNbis95yXrHzNu0ZIUlb4v6hAUV+oqof5v3wKlDRzpW4tmyT9DMFRFsL6ARniimgnsENTj+AbZJ5aAShMb2rXJMGICAz+QZ2dXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E211ucRI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E211ucRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FBC1F00893;
	Fri,  5 Jun 2026 13:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780665352;
	bh=OSItYuhQFPcK0Qjbp19bHGpCChnr2K2mF0i3LQkF8B0=;
	h=From:Date:Subject:To:Cc;
	b=E211ucRIABviParjNcSDeTvMWc7DJqrmaLWunYJkNLIkfUBd4vns9MKk55esBV1RZ
	 +hGM0W22X+O3wxGOxDFBUpqnoYOgCAKK599GqtpzD0HTq93LXfNdRJnTDIc+E0+wCd
	 ya6xcJYa7RbiwzQrRXIUVOQzsmI8MIJ6cCdx8iKysx7O8OuGBnElvpmmKPfyUUALS5
	 th3zcNFmLbTP6C/Qs9SPsM+4BAglVWJ/gkfDxB6n1zlVwatFtHTqfdn5F/Wtx5SQ76
	 x/6FraRx3i53LJDTjByGmKyZjXjzmBL9heyg5H1vVvvjxt8Q1WHrQGmXobggT4RrZQ
	 iX7wJq4hRTlTw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 05 Jun 2026 15:15:40 +0200
Subject: [PATCH v2] configfs: rust: add an API for adding default groups
 from C
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-configfs-c-default-groups-v2-1-2e2e4919e402@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPvLImoC/42NQQ6CMBBFr0Jm7RhasEZX3sOwKO20NJKWTIFoC
 He3cgKX7yX//Q0ycaAM92oDpjXkkGIBearADDp6wmALg6ylqqW4oEnRBe8yGrTk9DLO6DktU8b
 e9rVuW9U0WkHZT0wuvI/2sys8hDwn/hxXq/jZf6qrQIF0U1erySnTqMeLONJ4Tuyh2/f9CxbwJ
 yzDAAAA
X-Change-ID: 20260215-configfs-c-default-groups-bdb0a44633a6
To: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7745; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=4fP5SkhuoOgUv8D99eiYoqo4+5dwT+PPw8sBA3Xj7ms=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIsv8MCqoWzmx5c53bthmeh8Yn5llqqfAWVxDA
 +5WWcXQx9KJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiLL/AAKCRD6UCkIqsW9
 0E4+EACaNUxZ+WhwLlbFje2boyiFkhLHhg5NA+QtylwiSIV2riNyXBSReXV9GcBoYZlOpJnL8Pz
 WR4OqKHui8N/IStzVyh/vOENhzUyqrwbS88tA7tF05wUo1UV5AQQ+/6NQtl64zzlYnMA9MhVN0F
 2X3WCnVjuzsQJwoaCRuznNUMWwjy0D7GmUNJQTDv9RZ2cpGaMDCrmMmlLSsr3VnrG1Ahd7Pd66j
 W7g4xQ5TseJ4RLjQB+rfds/UySDtO5XVX4I4R6oSHvHJGBmMVVfYkKPIb3EOfu7giYWxNIwyTQ+
 9jXwmPgSv+pws4a1sQTMbeEbjUK5QHqDmNio/cX4dvsVJ7mtD0Xqf3raIb22RJoZmodey+q2mCz
 p8SuPe3ohGRvFCLN41WRUAPYh1WnPjYLDwlAziWXqgwIWBbsmWShgssQ5lSdhVTo6dG7fQw6obV
 oSF4udOwGpHNVCPC0fpnh0hTFdX9ewrC/IvC09+05w3zxAgHEMkFb5NLhkWIpWR8HKKBZoMBofd
 aIq2eEQebIrhPWriRzOb/lPb+MIyKgpOzYnS1BYXbtmJ3eJ8uBz6TXyPWxg+Oe1SMfFmX7COMuZ
 F26fiQhmLBRPSJXjv3b7x4FVIACi7w8eQoY1uqeNKhwxnKe0hIzm+YBE0g6Q2GoB3zCOIOme/6b
 RtDCXfmfqr9HiPA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Some C subsystems provide a feature to add configfs default groups to the
configfs hierarchy of other drivers or subsystems. Rust abstractions for
these subsystems will want a way to add these default groups via the
configfs Rust API. So add infrastructure to make this possible.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v2:
- Drop the spurious `__` prefix on the symbol name of the
  `configfs_remove_default_groups` Rust helper (Alice).
- Wrap the body of `Group::new` in `pin_init::pin_init_scope` so that
  allocation failure from `KVec::push` is propagated with `?` instead
  of panicking via `unwrap` (Danilo).
- Only build configfs rust helpers when configfs is enabled.
- Link to v1: https://msgid.link/20260215-configfs-c-default-groups-v1-1-e967daef6c36@kernel.org

To: Andreas Hindborg <a.hindborg@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
To: Miguel Ojeda <ojeda@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Danilo Krummrich <dakr@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org
---
 drivers/block/rnull/configfs.rs |  1 +
 rust/helpers/configfs.c         | 20 +++++++++++++
 rust/helpers/helpers.c          |  1 +
 rust/kernel/configfs.rs         | 63 +++++++++++++++++++++++++++++++++--------
 samples/rust/rust_configfs.rs   |  8 +++++-
 5 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 7c2eb5c0b722..b165347e9413 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -76,6 +76,7 @@ fn make_group(
                     name: name.try_into()?,
                 }),
             }),
+            core::iter::empty(),
         ))
     }
 }
diff --git a/rust/helpers/configfs.c b/rust/helpers/configfs.c
new file mode 100644
index 000000000000..4c71c33211bf
--- /dev/null
+++ b/rust/helpers/configfs.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/configfs.h>
+
+#ifdef CONFIG_CONFIGFS_FS
+
+__rust_helper void
+rust_helper_configfs_add_default_group(struct config_group *new_group,
+				       struct config_group *group)
+{
+	configfs_add_default_group(new_group, group);
+}
+
+__rust_helper void
+rust_helper_configfs_remove_default_groups(struct config_group *group)
+{
+	configfs_remove_default_groups(group);
+}
+
+#endif
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 625921e27dfb..851dc77d76b1 100644
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
index 2339c6467325..8891fa491496 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -241,12 +241,22 @@ unsafe fn container_of(group: *const bindings::config_group) -> *const Self {
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
+        unsafe { bindings::configfs_remove_default_groups(self.group.get()) };
+    }
 }
 
 impl<Data> Group<Data> {
@@ -258,22 +268,51 @@ pub fn new(
         name: CString,
         item_type: &'static ItemType<Group<Data>, Data>,
         data: impl PinInit<Data, Error>,
+        default_groups: impl IntoIterator<Item = Arc<dyn CDefaultGroup>>,
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
+            let mut dg = KVec::new();
+            for group in default_groups {
+                dg.push(group, GFP_KERNEL)?;
+            }
+
+            Ok(try_pin_init!(Self {
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
+                        // SAFETY: We keep the default groups alive until `Self` is dropped.
+                        unsafe {
+                            bindings::configfs_add_default_group(default_group.group_ptr(), place)
+                        }
+                    }
+                    Ok(())
+                }),
+                data <- data,
+                default_groups: dg,
+            }))
         })
     }
 }
 
+/// A trait for default configfs groups added by C code.
+///
+/// Rust abstractions that work with C code that creates configfs groups can implement this trait to
+/// add the groups as default groups via the Rust configfs API.
+pub trait CDefaultGroup {
+    /// Return a raw pointer to the group definition.
+    fn group_ptr(&self) -> *mut bindings::config_group;
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
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260215-configfs-c-default-groups-bdb0a44633a6

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


