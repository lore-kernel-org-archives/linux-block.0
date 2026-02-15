Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345DD30BBAE;
	Sun, 15 Feb 2026 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199101; cv=none; b=eBqcGRFsG4sQnHFGl2kUB7w/RRftpaeYLYk5r39kILTyxjZSYhdKGq8RmU2Csxf3l/xQkiWRq42j9MU+0hqJxETeG4Ta1eQYpTawGhk/WtKxF52Dglf+6kB63xVjpnWuifJvBm8eGSPDOtWdx+mCSWI82XCX5Z+KU73fTWz1BH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199101; c=relaxed/simple;
	bh=GKW86kl+p+OYSwPf2Q41uaeBW8CpLNtmUrapwK7eNLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cW6Hhy7ghFkrtSbb1WzQ4rNJePeTwYZAc3mkLXJ3pmc/CIc7yhe972qL8VNCYP5emGNEE+0ubpeiKbWLkSOqNuBWMJuBCpCwj+T+99sKYz2MRFl9CebsmqXSbSobghZnktyW3kPwn2TQAn5qDsrBtCl/skFVGDOyGuZm+OUEFAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1auz/5i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1auz/5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD2BC4CEF7;
	Sun, 15 Feb 2026 23:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199101;
	bh=GKW86kl+p+OYSwPf2Q41uaeBW8CpLNtmUrapwK7eNLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h1auz/5iRD896cAXZlpHR+dDUEYCUYbZsj1fP3hBtQQzpz9B9cop2T0CTRCeiWlh2
	 s4/rS0fdDTV+lx4uRgfCELY/PxZUTSr4/pR7/WjlKCxEniFHNFoZY+egEQRsGC1BhN
	 6LutD8eT+I7lepVZCB+CKaSCo+78K3+FZInA842/v1H5babY27xW+ymrTouYTZsYFw
	 gKccYcmwjjc/HZ9pbmmkqm4+l3mA9JVGowdU48IG0K8UhNBh9CQJrg1o8pxnR/q0ZB
	 f0WTIsyja+tR07ChjAN6VRS/IDLFvdQljKX5ZrXTF5QA3Hn/nJebLHHK9OL9lAUkPS
	 olq/lZs3NEzUA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:33 +0100
Subject: [PATCH 46/79] block: rust: move gendisk vtable construction to
 separate function
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-46-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5340; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=GKW86kl+p+OYSwPf2Q41uaeBW8CpLNtmUrapwK7eNLU=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhFsomGNwQiKqCjwEzFCcRjle0tp7r1mEuBz
 PnfAoH6wiSJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYRQAKCRDhuBo+eShj
 d/nNEACRmzsCoK43XTYTgBY9N9dFJ5DpDKa32BQG4qau8nxvTPXcN7Tm1y7kgYUafBtt9fSDNnO
 nJvRlCSsXQ2XqmZzUhlywwUrmfqqQV/67m6LCTdre7MLyfOpPM79MuAofV4LymRfqnMuhwX35bo
 /nuJ6oDU5LEj1O0jnZSwxFHquBg/o7g/KAmSitrKqdjKuu1gWlZxTG+qAUj6efPjfOEzXwkvV0i
 lWda+EkMTJl6SK3eq+6ymSY4adKHrtTYqoCgINxS4uAXxLXwV/19Zb663PJhFESxCmSJimNzt4g
 AGsJbVd718TSMKQZWr9ZI7yB7Y9+ptrmSiY7pHwzCwhZJsexQZ1TAKTPN2d2L9hyEsDyKwkdyJH
 7pSOWLOuGEDH4ZnXL+kfA2vy8gJ/7b4zUyGeQCgTvEWWL9a0AaKbacyM+wU2TFrcF0LhvzIEbRV
 CUFhDEGmRxmvaqnmmN6jCgO9zEIgGrV2kophX22Pzy639HDEjtWoU3XJWw1UydyDhiBKyP6Sfgh
 oUXsg68nFb/MckFOA1p8PrbjI5Tx4udUny7Ap0uIctqGN+AG1Bk9tQwx1TsQy3pBNuFffC7OrDq
 6Ec4pqI/CyuVhXnpb007xuCJYDoa679rMhRKEOHkcBzuZT+7j9SEMtn5qt8F9IUXGzX+BbI7+nB
 feQtdV6gwpBTHQg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Refactor the `GenDiskBuilder::build` method to move the `gendisk`
vtable construction into a separate helper function. This prepares for
adding zoned block device support which requires conditional vtable
setup.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs  |  5 ++-
 rust/kernel/block/mq/gen_disk.rs | 66 ++++++++++++++++++++++------------------
 2 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 90f2ecb454285..5dfe7b48af63b 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -266,7 +266,10 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
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
index fbda2f572e17f..eb980079530bd 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -17,20 +17,21 @@
     sync::{Arc, UniqueArc},
     types::{ForeignOwnable, ScopeGuard},
 };
-use core::ptr::NonNull;
+use core::{marker::PhantomData, ptr::NonNull};
 
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
@@ -38,11 +39,12 @@ fn default() -> Self {
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
@@ -109,7 +111,7 @@ pub fn max_hw_discard_sectors(mut self, max_hw_discard_sectors: u32) -> Self {
     }
 
     /// Build a new `GenDisk` and add it to the VFS.
-    pub fn build<T: Operations>(
+    pub fn build(
         self,
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
@@ -141,32 +143,8 @@ pub fn build<T: Operations>(
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
-            // TODO: Set to THIS_MODULE. Waiting for const_refs_to_static feature to
-            // be merged (unstable in rustc 1.78 which is staged for linux 6.10)
-            // <https://github.com/rust-lang/rust/issues/119618>
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
@@ -219,6 +197,34 @@ pub fn build<T: Operations>(
 
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


