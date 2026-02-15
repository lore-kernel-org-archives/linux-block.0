Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D93033D8;
	Sun, 15 Feb 2026 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771187648; cv=none; b=AG80OAvvbwP+hhWb4ngwKIqpgfb1M1r3/z/jktzDxCr/zkhfKVL2edFFRWkglWlyWmpYiqFWhVrDxvXCeaKK2ki7yb3+miiW1dqoAl6iZVNPu9wK5sioxpu8vwHL1Ktr+I+64xkjrXywYNQJ7yMY1JAOkbngeu3bERn3gjrY8gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771187648; c=relaxed/simple;
	bh=kPkx+XLnnEICTvDYdgmZp891oWtR10FsHihH5ePtz5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XMSGd1ZSlcCjD64zg2vuzwbfB1aiylzRAxvQIA6XuPMnyuoZjMQ7Zu13aUTT9Pfy00EGBYwRt4CoDqvorxHW6cgznVJWT+Gosgu0770+898qgyDYXF3Nki2GbY+22VlJ6pFr0qW+zp+NVjO9OD6mu51eo3Qjjoe+7R0qA427+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKXdsfmQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKXdsfmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4E0C4CEF7;
	Sun, 15 Feb 2026 20:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771187647;
	bh=kPkx+XLnnEICTvDYdgmZp891oWtR10FsHihH5ePtz5U=;
	h=From:Date:Subject:To:Cc:From;
	b=hKXdsfmQS2ygvBqdSgITFv9KTonI6gHJYAE3uZL+wFoQjqYhb2LAfm2sVnsxL3WDZ
	 d/6dnbkRYpYMy/XDAA5vp6cokvYbuLmscWpZG1Ah1Bu3T3oFNS7fsokq09COtxikpB
	 Xz/ryi6e/XQuh5TcMMSW28h+F6ZewF6y+oigNUA2V9XUOKUTgY1K5oi0ixK12UUvvw
	 qaPlG0JsTKmYSpcD+JiHznfimjVNx1TzydWEICosObKq3a6qV7qwr+M0mnDgRe6fgV
	 JoKeHBf5ZOy17ms7w0BuKCveHbHMAfvQNSAxmJ4r8AU31ZpSsKQluzZXx0q7HkWWIQ
	 tMwVYT/5aJAkA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 15 Feb 2026 21:33:47 +0100
Subject: [PATCH] configfs: rust: add an API for adding default groups from
 C
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260215-configfs-c-default-groups-v1-1-e967daef6c36@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKotkmkC/x3MTQrDIBBA4avIrDugJnHRq5Qu/BnNQNHgNCEQc
 vdKl9/ivQuEOpPAU13Q6WDhVgfMQ0FcfS2EnIbBauu0NQvGVjOXLBgxUfb754ult30TDCloP89
 umryD0W+dMp//9+t93z+/UzK9awAAAA==
X-Change-ID: 20260215-configfs-c-default-groups-bdb0a44633a6
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Breno Leitao <leitao@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5733; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=kPkx+XLnnEICTvDYdgmZp891oWtR10FsHihH5ePtz5U=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpki2rc22Xg526E17P8XggB+tiQE/HNwmekN3wW
 ivbt9FsREyJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZItqwAKCRDhuBo+eShj
 dxAVEAChDY57aQjccAsf9b40HD44r2KSgKp6iA5HiN6i/O/efL2nYYW5feu0dU0ewKju/bAFv8n
 4An6Jg/ilNu/PiHu1waCHvxbEhVOMWXaFpM+jOByG8GMROWS6YuRYEqPsvUDJjVfTuZwwjaJ+6t
 GwGP9VOR/cksiMqHgQcE0KpaSDK0DB+bGVN1EcUCX0skcNptcDq7fuJJeueDus7rglYQo5YMnUV
 op2B3sN7udRTc9aQoPTjEsBTYke36MIYDP+xcJhJUMSSfWAepbYimu00WJa+2x5YPNRdrtwKhBY
 nAgtPkdNQ1tg5yVejVGSeGAV1WItH0Ircxzin71NX5J58UKA+2XvcXyFWEviXoh6O67X+n5G3nw
 oxNYDQCc6nrLx/C5ksN6RxqCiu2PfOABUypib+PsRJGT/SM8MfasJ0Dvf8ER6sGDajm5itc77xo
 pp2CzwUXGPmQyF9yqhxCqBSJ+fwQ6QPJTtwA/5MbWPHLDhYMvIyhFxaa00nl9wYvUllDna504gk
 g4vUmhEVNUKrKyvEPidFot83Kwr/91ndyMLv33wByxT3FsHDkeG9g+OE49dTKvJ83mgKrt5TKFM
 +4PVRq2B0vrzlk4uHZMM/bbFz7DZ4awWha25hReB2Vf9dPrC+2JbFrodSMKTBQXAP1Dp0Sf+NXB
 mQb0Tu+N/ynyHcw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Some C subsystems provide a feature to add configfs default groups to the
configfs hierarchy of other drivers or subsystems. Rust abstractions for
these subsystems will want a way to add these default groups via the
configfs Rust API. So add infrastructure to make this possible.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  1 +
 rust/helpers/configfs.c         | 16 ++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 rust/kernel/configfs.rs         | 33 ++++++++++++++++++++++++++++++++-
 samples/rust/rust_configfs.rs   |  8 +++++++-
 5 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 6713a6d92391d..ea38b27a9011c 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -78,6 +78,7 @@ fn make_group(
                     name: name.try_into()?,
                 }),
             }),
+            core::iter::empty(),
         ))
     }
 }
diff --git a/rust/helpers/configfs.c b/rust/helpers/configfs.c
new file mode 100644
index 0000000000000..7cec8ffcb093d
--- /dev/null
+++ b/rust/helpers/configfs.c
@@ -0,0 +1,16 @@
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
+
+__rust_helper void
+__rust_helper_configfs_remove_default_groups(struct config_group *group)
+{
+	configfs_remove_default_groups(group);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 79c72762ad9c4..613b41e8b781c 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -19,6 +19,7 @@
 #include "build_bug.c"
 #include "clk.c"
 #include "completion.c"
+#include "configfs.c"
 #include "cpu.c"
 #include "cpufreq.c"
 #include "cpumask.c"
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 466fb7f407628..705f1647269d9 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -242,12 +242,22 @@ unsafe fn container_of(group: *const bindings::config_group) -> *const Self {
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
@@ -259,7 +269,13 @@ pub fn new(
         name: CString,
         item_type: &'static ItemType<Group<Data>, Data>,
         data: impl PinInit<Data, Error>,
+        default_groups: impl IntoIterator<Item = Arc<dyn CDefaultGroup>>,
     ) -> impl PinInit<Self, Error> {
+        let mut dg = KVec::new();
+        for group in default_groups {
+            dg.push(group, GFP_KERNEL).unwrap();
+        }
+
         try_pin_init!(Self {
             group <- pin_init::init_zeroed().chain(|v: &mut Opaque<bindings::config_group>| {
                 let place = v.get();
@@ -268,13 +284,28 @@ pub fn new(
                 unsafe {
                     bindings::config_group_init_type_name(place, name.cast(), item_type.as_ptr())
                 };
+
+                for default_group in &dg {
+                    // SAFETY: We keep the default groups alive until `Self` is dropped.
+                    unsafe { bindings::configfs_add_default_group(default_group.group_ptr(), place) }
+                }
                 Ok(())
             }),
             data <- data,
+            default_groups: dg,
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
index 0ccc7553ef395..c65dda8bfacd2 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -84,7 +84,12 @@ fn make_group(&self, name: &CStr) -> Result<impl PinInit<configfs::Group<Child>,
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
 
@@ -153,6 +158,7 @@ fn make_group(&self, name: &CStr) -> Result<impl PinInit<configfs::Group<GrandCh
             name.try_into()?,
             tpe,
             GrandChild::new(),
+            core::iter::empty(),
         ))
     }
 }

---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260215-configfs-c-default-groups-bdb0a44633a6

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


