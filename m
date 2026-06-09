Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD614BCAA2;
	Tue,  9 Jun 2026 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032264; cv=none; b=n2ER+mqCC539XKwebZsHomOjZYUYsIJ0Vck+i8eCY/sf0/d70mvo9vKlwKKHOBDF2B0Ma7fix359wB7W7vYjoT2fEMyL6dmaSHXlumDGDEizFQH689N0j/BLuOEQdZj+kb++ie/6F2P/QpHKdMmJX56PR1j0aR6TPCa+S6xPnfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032264; c=relaxed/simple;
	bh=DINncKwSuL7mJVmDgVRSZcLatYZj5+iron/JtJAzd08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjAYIrgJ8+fVpTSnb1hjy3zPJekJZhg9GkS+a82unIBKspQ3Dn9l128S80ZiZYKvmZesVC+uHNrQZ9C2k8o8odSNCLZgFgPuY2alR39ZSnOkvC6tpPqtlisBOCId2W+RF8x2LmIZTb3QECWYHCLzqLlfLfnPpvnl+lqVlrENcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q00rT/I4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q00rT/I4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052B21F00898;
	Tue,  9 Jun 2026 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032263;
	bh=PS2VkUNd369JJf7ucum93WJqs0QoezRjkkbireGl6Qc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q00rT/I4IRrjIQkppmOTatg2ODde300ODDsVgZck3pnItEIKRYQ1fjMjWRjEg5jKy
	 hs3C97xkNLaYC8fB1xltqdWpZPJBIGJYQwDMx145u1ZoC66OHw/EGu2ety+Zo+vGVG
	 LMJX7ngWW36omMtZKnfh1rUf0IvCsxrNkHUyFe4CSWA6UaiSm71LhlbsDT3ULR1wcS
	 jOJxSN0qiMTrMLW1tOdtuDMxZEaTXDchUKarZTJbXn1eIMd2oD1SU3eXK6SZeDNrXN
	 yZ5+tUohuQp1vCZEjKKWBvGNmO4qTIHITHAQ3zvzW7Y2bItALkXpZxxt3QDUj0aNMw
	 XuqEs7rTXHwWw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:54 +0200
Subject: [PATCH v2 15/83] block: rust: add `TagSet` flags
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-15-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4659; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=DINncKwSuL7mJVmDgVRSZcLatYZj5+iron/JtJAzd08=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTCt2lO9pNrd9xgsB1ZZBoV+xLyOTEIyMITV
 qniUELa4O6JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkwgAKCRD6UCkIqsW9
 0KLZD/0QWgWovCM4gbcQhcPZLiCELO1QvVZhElbrfYyNm/BG39ys+cP95Ms0QeFoszLrvo2utWP
 o8jUQ7WsPfvhFyho27hGT8W3RxxdMzeZIaPeLI/ukpoxn6tQDbalVECoeMj7R6v7dHvIo+IvuI9
 n5gkRjBh18GmuOrb/w8TsnTU0dUTC1KDS7XhvmXJKzd935LFDwavGqrw5hOkl+t6ZdGPuyfbBbW
 tSP2xid/fY5AuWkDYzEmAKFu1v79Cvn+FPej52mDFLWvOmrUmSZtCtiWS9eXWxa+Xoad2qpMsPC
 gG9Rao+SSazio3jF/VfQW7HOyWgLQSn/WEtengNJTG9kVTuyckt0bISduRzdSDHVDX2zwKXG/Im
 BT8yi0IS37hL225IWmRukLCc5IeoWAPlrkuAmh0bck35x91bImVG0oTFkSp+0A+WWwQvXDCwg/+
 fsiFOI+m7ltGPF1R2XxCBpgHL7TUB2vNV63oGWHH+ZSjrA7cMmNvnxyOtIVEZjGvk7Mp8LeXr3B
 0u2BCV39WJ+D3wvhsuMIMluYRb2XBkQg4m4bgBhfvVc6ovo7+zhA5RCyzoySk03Ne2HGZYmZeL7
 R+tpuZ99WJc1Xj2RpK/MJUmYujM4yhf9RihfZfBtKXVzrZmpFMOZ9tHBDtFqfLUaddbf5i4WWAx
 9p4Xn7qvIOow7Iw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for `TagSet` flags by introducing a `Flags` type and adding
a flags parameter to `TagSet::new`. This allows configuring tagset
behavior such as blocking vs non-blocking operation.

The Flags type supports bitwise operations and provides values like
`Blocking` for common use cases. The module documentation example is
updated to demonstrate the new API.

For now, only a single flag is added.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs          |  5 ++++-
 rust/kernel/block/mq.rs               |  6 +++---
 rust/kernel/block/mq/tag_set.rs       | 13 ++++++++++---
 rust/kernel/block/mq/tag_set/flags.rs | 21 +++++++++++++++++++++
 4 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 3e7a47e6d0e5..746ddadd11f0 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -128,7 +128,10 @@ fn new(
         irq_mode: IRQMode,
         completion_time: Delta,
     ) -> Result<GenDisk<Self>> {
-        let tagset = Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
+        let tagset = Arc::pin_init(
+            TagSet::new(1, 256, 1, mq::tag_set::Flags::default()),
+            GFP_KERNEL,
+        )?;
 
         let queue_data = Box::new(
             QueueData {
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 23660817df29..e556b3bb1191 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -57,7 +57,7 @@
 //!
 //! ```rust
 //! use kernel::{
-//!     block::mq::*,
+//!     block::mq::{self, *},
 //!     new_mutex,
 //!     prelude::*,
 //!     sync::{aref::ARef, Arc, Mutex},
@@ -92,7 +92,7 @@
 //! }
 //!
 //! let tagset: Arc<TagSet<MyBlkDevice>> =
-//!     Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
+//!     Arc::pin_init(TagSet::new(1, 256, 1, mq::tag_set::Flags::default()), GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
 //!     .build(fmt!("myblk"), tagset, ())?;
@@ -103,7 +103,7 @@
 pub mod gen_disk;
 mod operations;
 mod request;
-mod tag_set;
+pub mod tag_set;
 
 pub use operations::Operations;
 pub use request::{
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index ec5cac48b83f..5b1a5bcc978d 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -17,7 +17,7 @@
         self,
         Result, //
     },
-    prelude::try_pin_init,
+    prelude::*,
     types::Opaque,
 };
 use core::{
@@ -30,6 +30,12 @@
     PinInit, //
 };
 
+mod flags;
+pub use flags::{
+    Flag,
+    Flags, //
+};
+
 /// A wrapper for the C `struct blk_mq_tag_set`.
 ///
 /// `struct blk_mq_tag_set` contains a `struct list_head` and so must be pinned.
@@ -51,6 +57,7 @@ pub fn new(
         nr_hw_queues: u32,
         num_tags: u32,
         num_maps: u32,
+        flags: Flags,
     ) -> impl PinInit<Self, error::Error> {
         let tag_set: bindings::blk_mq_tag_set = pin_init::zeroed();
         let tag_set: Result<_> = size_of::<RequestDataWrapper<T>>()
@@ -63,8 +70,8 @@ pub fn new(
                     numa_node: bindings::NUMA_NO_NODE,
                     queue_depth: num_tags,
                     cmd_size,
-                    flags: 0,
-                    driver_data: core::ptr::null_mut::<crate::ffi::c_void>(),
+                    flags: flags.into(),
+                    driver_data: core::ptr::null_mut::<c_void>(),
                     nr_maps: num_maps,
                     ..tag_set
                 }
diff --git a/rust/kernel/block/mq/tag_set/flags.rs b/rust/kernel/block/mq/tag_set/flags.rs
new file mode 100644
index 000000000000..b7eaccd200a2
--- /dev/null
+++ b/rust/kernel/block/mq/tag_set/flags.rs
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use crate::{
+    bindings,
+    impl_flags, //
+};
+
+impl_flags! {
+    /// Flags to be used when creating [`super::TagSet`] objects.
+    #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
+    pub struct Flags(u32);
+
+    /// Allowed values for [`Flags`].
+    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
+    pub enum Flag {
+        /// Indicate that the queues associated with this tag set might sleep when
+        /// processing IO. When this flag is not set, IO is processed in atomic
+        /// context. When this flag is set, IO is processed in process context.
+        Blocking = bindings::BLK_MQ_F_BLOCKING,
+    }
+}

-- 
2.51.2


