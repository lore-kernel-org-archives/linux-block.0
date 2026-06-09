Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855483E4513;
	Tue,  9 Jun 2026 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032414; cv=none; b=t19XL0Kl+E8Bv9E4RvVQ5WyJFOr8FdF9Uet2IIYrHosL2+n5AagrProsI04kipUxuududbiCbGeG3JpCmsWDmvaCagYIUubfE8hN5bN0/zKPbirg+9b1m5NlcDuPNirINLstXYnLmnmRDjtlY8FRF13NkU/TXvIGC+ZHMHUYO54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032414; c=relaxed/simple;
	bh=sJLbN5KEUkCPHK8xRsQjgnA4YwvknpnDUCxdTCWNd1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a05BMa2VUsdDHaDcF43bggGvWtxjNlYUXxrvfIYLrPj67bHMbb5OaFToN17c+LBSrHZ2oHlMkf20FCbjgnkTVvTLE6kouSa3hOAKkHCr6fJA77SZuGr3s9oPKl8qEbz0hjF3+7D0Y05JA+gMcxiYD2L/B5sxlcCxbcwVwetbSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG+ezTAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG+ezTAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3767A1F00893;
	Tue,  9 Jun 2026 19:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032413;
	bh=MQiHlNRAHcG0zCplCfubwH1heBFHeJMR1Ghfy65SyHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XG+ezTAn3i1xqHdZPtdFpCrSiMPocPWl4XuHVxwbumaNYCNa7ClDAIbBNh5b2lukE
	 misM/dXVckb5it86sWzB5ZkLc1PL+RWzMTweV01gvsSZS+q4jteYytyzA+i+pqRXsx
	 Tf0gjOwSp52RvKmCY+jaFJtXIToGzapEcixnTv1RbYIRIoEq2vAx+L20z85Qr/n15a
	 iIgy1waClKBNfPxwKazUMxsvlrexnBAL4byc9fhhLND8oE/V+i0DEqfQaVkTgYqdA4
	 BrQMNEi4z8izlVAE2/HEDB3oRSZrTpSn36RPtcad5hLtXw8UDinfZErDAsW8OJjrwf
	 mfa7UOUgqakpw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:12 +0200
Subject: [PATCH v2 33/83] block: rust: add `TagSet` private data support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-33-82c7404542e2@kernel.org>
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
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5734; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=3g5+YHpLQZtUQxpZtQ2/w4vImmZD3/qhcfuMUlvuqQc=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTSdtbD1l7vP9EyaG6jBiQ3jFqAW4K54QXX3
 hnEnGAciQqJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk0gAKCRD6UCkIqsW9
 0HJED/9N+0BqKQHS/fK1I2gbsYIMS8fTYQC9/oy1w2ldDx6XoxRqHv68II+u+A84sakszQZjrry
 nUk3j7FAqdeCks7LeDrW2U/w/cjCJVqJPU4uXR60K4xowPGgdiWvSBpjUw7+Zr8G5A+gjNbhoFR
 BNpthODIrjQsn4+AYmz8T1Az7y4r6jEQs7mKAjpHB2kaRIbEEy8Prxg4Yz91bDAzWD3K3A6XsW4
 +v3i+KskX2LGXBrdsTu51JDJ1vGhAXDS7XGUocRvpYmFzjUAGyUynZebFu9Bn5sMQQshgWtY0Bi
 CUE/+WvRAcMljkDv/ha8LtcMNgbECjUhzwEMYB/WcWAJ7em+2PW5bUSQVflvoLJD86cOH9xe/Kf
 4d491j0ovtSQ3eq7qp7/9i2qakGwACVppYf//cg68DAi+438MqhvsehwTzCo6B+oqRkS1QW63YW
 GK88ffUCkNnuEfZwlKVZbPY1wfRT5mSXvXqe1D2+b9ohflfK/QxjfenRsSgSlWYv+9Xrr86K0Oh
 vP73viiPWDBIfq56mCsGfJx/rKR0h8KVcJJbwyjb7M4jBBr1eEF4GFYB5NpIx1hjsjG0iUvPWLC
 c326mxqiqd6Rvk5LIUzUH5odg8ocrT79Vwe68mcQ2VYrJgBMs0YVPlkRKVnP7QKNIjvugXz0gLR
 0LRZdzS1Ak40/oQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Andreas Hindborg <a.hindborg@samsung.com>

C block device drivers can attach private data to a `struct
blk_mq_tag_set`. Add support for this feature for Rust block device
drivers via the `Operations::TagSetData` associated type.

The private data is passed to `TagSet::new` and is stored in the
`driver_data` field of the underlying `struct blk_mq_tag_set`. It is
released when the `TagSet` is dropped.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs       |  3 ++-
 rust/kernel/block/mq.rs            |  6 ++++--
 rust/kernel/block/mq/operations.rs |  4 ++++
 rust/kernel/block/mq/tag_set.rs    | 26 ++++++++++++++++++++++----
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index be0b4bd25e53..ad26a4a8dbbe 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -240,7 +240,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
         }
 
         let tagset = Arc::pin_init(
-            TagSet::new(submit_queues, 256, 1, numa_node, flags),
+            TagSet::new(submit_queues, (), 256, 1, numa_node, flags),
             GFP_KERNEL,
         )?;
 
@@ -533,6 +533,7 @@ fn align_down<T>(value: T, to: T) -> T
 impl Operations for NullBlkDevice {
     type QueueData = Pin<KBox<QueueData>>;
     type RequestData = Pdu;
+    type TagSetData = ();
 
     fn new_request_data() -> impl PinInit<Self::RequestData> {
         pin_init!(Pdu {
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index bac15b509d90..28cee0d60846 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -71,6 +71,7 @@
 //! impl Operations for MyBlkDevice {
 //!     type RequestData = ();
 //!     type QueueData = ();
+//!     type TagSetData = ();
 //!
 //!     fn new_request_data(
 //!     ) -> impl PinInit<()> {
@@ -94,8 +95,9 @@
 //!
 //! let tagset: Arc<TagSet<MyBlkDevice>> =
 //!     Arc::pin_init(
-//!         TagSet::new(1, 256, 1, NumaNode::NO_NODE, mq::tag_set::Flags::default()),
-//!         GFP_KERNEL)?;
+//!         TagSet::new(1, (), 256, 1, NumaNode::NO_NODE, mq::tag_set::Flags::default()),
+//!         GFP_KERNEL
+//!     )?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
 //!     .build(fmt!("myblk"), tagset, ())?;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index c49ca2e8bbb2..093bb21fa1b2 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -63,6 +63,10 @@ pub trait Operations: Sized {
     /// the `GenDisk` associated with this `Operations` implementation.
     type QueueData: ForeignOwnable + Sync;
 
+    /// Data associated with a `TagSet`. This is stored as a pointer in `struct
+    /// blk_mq_tag_set`.
+    type TagSetData: ForeignOwnable + Sync;
+
     /// Called by the kernel to get an initializer for a `Pin<&mut RequestData>`.
     fn new_request_data() -> impl PinInit<Self::RequestData>;
 
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index d6d104adf4aa..bfb8f8af4ee1 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -19,7 +19,10 @@
         Result, //
     },
     prelude::*,
-    types::Opaque,
+    types::{
+        ForeignOwnable,
+        Opaque, //
+    },
 };
 use core::{
     convert::TryInto,
@@ -56,6 +59,7 @@ impl<T: Operations> TagSet<T> {
     /// Try to create a new tag set
     pub fn new(
         nr_hw_queues: u32,
+        tagset_data: T::TagSetData,
         num_tags: u32,
         num_maps: u32,
         numa_node: NumaNode,
@@ -73,7 +77,7 @@ pub fn new(
                     queue_depth: num_tags,
                     cmd_size,
                     flags: flags.into(),
-                    driver_data: core::ptr::null_mut::<c_void>(),
+                    driver_data: tagset_data.into_foreign(),
                     nr_maps: num_maps,
                     ..tag_set
                 }
@@ -86,7 +90,14 @@ pub fn new(
                 // SAFETY: we do not move out of `tag_set`.
                 let tag_set: &mut Opaque<_> = unsafe { Pin::get_unchecked_mut(tag_set) };
                 // SAFETY: `tag_set` is a reference to an initialized `blk_mq_tag_set`.
-                error::to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())})
+                let status = error::to_result(
+                    unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())}
+                );
+                if status.is_err() {
+                    // SAFETY: We created `driver_data` above with `into_foreign`
+                    unsafe { T::TagSetData::from_foreign((*tag_set.get()).driver_data) };
+                }
+                status
             }),
             _p: PhantomData,
         })
@@ -102,7 +113,14 @@ pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set {
 impl<T: Operations> PinnedDrop for TagSet<T> {
     fn drop(self: Pin<&mut Self>) {
         // SAFETY: By type invariant `inner` is valid and has been properly
-        // initialized during construction.
+        // initialised during construction.
+        let tagset_data = unsafe { (*self.inner.get()).driver_data };
+
+        // SAFETY: `inner` is valid and has been properly initialised during construction.
         unsafe { bindings::blk_mq_free_tag_set(self.inner.get()) };
+
+        // SAFETY: `tagset_data` was created by a call to
+        // `ForeignOwnable::into_foreign` in `TagSet::try_new()`
+        unsafe { T::TagSetData::from_foreign(tagset_data) };
     }
 }

-- 
2.51.2


