Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4107D408A25;
	Tue,  9 Jun 2026 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032660; cv=none; b=LmdhQI2TGNuj5t67ZGhIc6fcOqHQtHdcUWwT10VM+DG7No4PsR7nS3P4+ZCdhQCAc9QZAXUKYgvHOMNNVjnA1rCjS4XIcSvSElXKubTCy43a8jdgMNTiS4OeAzoMu6UKJTvu3HdMKC90nlTOZE03f0/XFeGvPvlzWg6a9SvCwWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032660; c=relaxed/simple;
	bh=nWZZSuCE7eRuBTdr1Tw1jnn7BhOeTAryxo5+j0nH9IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u5y2v7dHD8q9PplomT4M+esTAOEBYZgnVmdSpGHq8VT34YWJYbyrJpwjvGR4HbLFE4ovaH9N5K0C9BWfljgE0gUnlaCzljqpO29s0uzU8y3+jdwGKsBljit3ZLyby11v/PqTXOsB5KO2OdSM2MfagaA2AHS605NXHLhzLlAG7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh4qFHgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh4qFHgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B2B1F00898;
	Tue,  9 Jun 2026 19:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032659;
	bh=F3cUw+ZLEEIEYCWFefqNhKQoFd9lfmv4Djxg5dSyh6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Yh4qFHgwl9dPDE+Dd804+hehfek3T3KktZ4KLW8E0ND8oPBDHwHPhZK4oxN4Jt9cG
	 EE0iARjt5TMMkCAoYKrdklnyXyi+i7wv319+qcsz6IBM0GK99bDE5MzRYlBgv1ZmO1
	 j1YuADV5qkveEai4nkTjSJI6iL0kWqkODtqVr6bj6SaJ5OgO6XjFXWcs6IohWfvxLU
	 ZGgYe2DY+DClniqoBYYOtq/3PZc7lpl6YRqYN7x2SQCCr3MdD8lyK9N5SABAnhEWVT
	 zKebynE+sZt7YwTmDKGLRm8D6GCuWXU+uqH+p6zleDLieCbFam4bWKcqtcX7DryVTn
	 YZ22OhmrgDUcQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:29 +0200
Subject: [PATCH v2 50/83] block: rust: move gendisk vtable construction to
 separate function
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-50-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5125; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=nWZZSuCE7eRuBTdr1Tw1jnn7BhOeTAryxo5+j0nH9IQ=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGThwYPLrFFscsf6EbG3+a5iaTayyAq94Nxgz
 iFI6puKAgmJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk4QAKCRD6UCkIqsW9
 0J3GD/9P/NG4qDSfiZLT6kaSKJVYbPTGQp/wYmerkXDHyXttYDguhsRf0Qbec3e33McsoMnGXdn
 FDVdkp9zxo2TQ9yg/KTko4Kfk/r8uOuKf8LQF1kLfAS7vV5Y5h0WHp/lN3VsGTMD0Oh1TQbr3+t
 mnOhDCph7RJk/hDPa+AQBTo+q6GWMOuATQ9WMJCDb2vmPNVP2y/kyfZTA5Y2RgjJqlGyrA4vkkI
 ibGl+WdC6oa+1nv9sGtlNBDUb76uMcDz8gwvNRtQTDW86JB+Dv5KrdWr/lPgAxgbB+ivkG1iAVl
 wnnitGsYMBoqLT8x53Cgd72es41XV/ZIxXrjHOOvvLrs14Iw3HFDrHQjP/qTdjoAkRfOydVsYT+
 XpiV4YZSkQbdfPIyraHZBqaWmWgb7CvprxvkSNSLJv0WheMyLt0kTBijoO26x7ogyYEEDNrh6Lz
 ZeICGdPddeacasO0sobyJl/FZ4AGx4OdqsBW586ctFoIwwQHQj0SgQKIlvI2IGMxME5pryXnvtT
 np0gGKYMTz63Nqy2l0eOyWgzxyPGL2b/5g6dKZJ2T56cWODWW/Gxnq9bBnVZH2i9JLWm1eB3uM9
 kZusZVyLHqvdEjAJRF5qvdnu67LxpdjEDeb+P8xy2g3S1+b+hYG8TGJ1bogFAC3hn2/3P4kwyMj
 0EgP1DUWmyYA8zg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Refactor the `GenDiskBuilder::build` method to move the `gendisk`
vtable construction into a separate helper function. This prepares for
adding zoned block device support which requires conditional vtable
setup.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs  |  5 ++-
 rust/kernel/block/mq/gen_disk.rs | 67 +++++++++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 2dfc87dff66a..8fa16dbc2a75 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -290,7 +290,10 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
     }
 }
 
-configfs_simple_field!(DeviceConfig, 1, block_size, u32, check GenDiskBuilder::validate_block_size);
+configfs_simple_field!(DeviceConfig, 1,
+                       block_size, u32,
+                       check GenDiskBuilder::<NullBlkDevice>::validate_block_size
+);
 configfs_simple_bool_field!(DeviceConfig, 2, rotational);
 configfs_simple_field!(DeviceConfig, 3, capacity_mib, u64);
 configfs_simple_field!(DeviceConfig, 4, irq_mode, IRQMode);
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 49ce5ac4774d..79a67b545eca 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -34,20 +34,24 @@
         ScopeGuard, //
     },
 };
-use core::ptr::NonNull;
+use core::{
+    marker::PhantomData,
+    ptr::NonNull, //
+};
 
 /// A builder for [`GenDisk`].
 ///
 /// Use this struct to configure and add new [`GenDisk`] to the VFS.
-pub struct GenDiskBuilder {
+pub struct GenDiskBuilder<T> {
     rotational: bool,
     logical_block_size: u32,
     physical_block_size: u32,
     capacity_sectors: u64,
     max_hw_discard_sectors: u32,
+    _p: PhantomData<T>,
 }
 
-impl Default for GenDiskBuilder {
+impl<T> Default for GenDiskBuilder<T> {
     fn default() -> Self {
         Self {
             rotational: false,
@@ -55,11 +59,12 @@ fn default() -> Self {
             physical_block_size: bindings::PAGE_SIZE as u32,
             capacity_sectors: 0,
             max_hw_discard_sectors: 0,
+            _p: PhantomData,
         }
     }
 }
 
-impl GenDiskBuilder {
+impl<T: Operations> GenDiskBuilder<T> {
     /// Create a new instance.
     pub fn new() -> Self {
         Self::default()
@@ -126,7 +131,7 @@ pub fn max_hw_discard_sectors(mut self, max_hw_discard_sectors: u32) -> Self {
     }
 
     /// Build a new `GenDisk` and add it to the VFS.
-    pub fn build<T: Operations>(
+    pub fn build(
         self,
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
@@ -157,30 +162,8 @@ pub fn build<T: Operations>(
             )
         })?;
 
-        const TABLE: bindings::block_device_operations = bindings::block_device_operations {
-            submit_bio: None,
-            open: None,
-            release: None,
-            ioctl: None,
-            compat_ioctl: None,
-            check_events: None,
-            unlock_native_capacity: None,
-            getgeo: None,
-            set_read_only: None,
-            swap_slot_free_notify: None,
-            report_zones: None,
-            devnode: None,
-            alternative_gpt_sector: None,
-            get_unique_id: None,
-            // TODO: Set to `THIS_MODULE`.
-            owner: core::ptr::null_mut(),
-            pr_ops: core::ptr::null_mut(),
-            free_disk: None,
-            poll_bio: None,
-        };
-
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
-        unsafe { (*gendisk).fops = &TABLE };
+        unsafe { (*gendisk).fops = Self::build_vtable() };
 
         let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
@@ -233,6 +216,34 @@ pub fn build<T: Operations>(
 
         Ok(disk.into())
     }
+
+    const VTABLE: bindings::block_device_operations = bindings::block_device_operations {
+        submit_bio: None,
+        open: None,
+        release: None,
+        ioctl: None,
+        compat_ioctl: None,
+        check_events: None,
+        unlock_native_capacity: None,
+        getgeo: None,
+        set_read_only: None,
+        swap_slot_free_notify: None,
+        report_zones: None,
+        devnode: None,
+        alternative_gpt_sector: None,
+        get_unique_id: None,
+        // TODO: Set to THIS_MODULE. Waiting for const_refs_to_static feature to
+        // be merged (unstable in rustc 1.78 which is staged for linux 6.10)
+        // <https://github.com/rust-lang/rust/issues/119618>
+        owner: core::ptr::null_mut(),
+        pr_ops: core::ptr::null_mut(),
+        free_disk: None,
+        poll_bio: None,
+    };
+
+    pub(crate) const fn build_vtable() -> &'static bindings::block_device_operations {
+        &Self::VTABLE
+    }
 }
 
 /// A generic block device.

-- 
2.51.2


