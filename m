Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DB41B7F3;
	Tue,  9 Jun 2026 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032618; cv=none; b=dJgZv/irUxJKsaG3efBzgrhByrbYMfFKAnuYMBv5BlXlqwmsR11GoROoW4y/sEzCeo9FnVFFLZay1jS+5aDL9tn5oUnJARmP90ZWdhFK2Vg2IHvX092wNIxoNbussB2YoJngYMR/Gu3sORh11DnBKZ6MNDeq5mnB2pU9IDA+nZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032618; c=relaxed/simple;
	bh=DDAoobr8iByPKaXTjyWraJH4CgIk1Bn8L7BjryKL7CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VctnlDkwQQvGhKVj1itV63FHlGgvbnlhdNYr+NdTBbC2CI1ygQaAWwaoeqrM+l0LDaHSJLnUomfpulDRumB0WGEwiZ1o3NdyKkpX5Xn5TSDd2BiK4P6tlgQD0DVbFEMnktz+uw45/DTePNJYNATTibU5Xmma8k8rCCbOj/7z4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grUeoCqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grUeoCqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548A91F00899;
	Tue,  9 Jun 2026 19:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032617;
	bh=bVoeMqM+4x+DRGTfgue4mO0tQcRwgKzm2C1LaDMHuSY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=grUeoCqFABZLR5KpiONwSvirHR19FPTkamv0cIZjpX0X/gJFsc6J8DAxT3mHYNz/s
	 K+WKEyBCxStr9qDhA4AKiYMvggcCNrO6v6UnzkrnISiu10rCWqg7to8tRjhM9xj6sV
	 K9lHLn35p3o/MFw0Y4A9fl00SQ/MEhLpXih7Ql/SZ9C6HEECFy8qB8GvXfD4NNW0av
	 pWuKNQL7J10m3WgHCKMGYvEPnvYbGDAT5pNK4j+B4GQs+PTiLLV5BFoTXxky0YD9Nc
	 oLgtUe6zgkWCwiq2YfUKd6hVyKuvs75kSN2ef1VTy7Bphc5TTpoQ+Hn5hxFQlX00K3
	 m+L/lnEHwqixQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:18 +0200
Subject: [PATCH v2 39/83] block: rust: add a request queue abstraction
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-39-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4451; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=DDAoobr8iByPKaXTjyWraJH4CgIk1Bn8L7BjryKL7CA=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTY5J/OppOq84fVsvUc70Gv8I7RWlb+IcQ5b
 n+xAAkuUZGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk2AAKCRD6UCkIqsW9
 0JAYD/wNyX5xXqqubNgadeKihqrsjtqz3ydvG9+mnr/DgIpKbh2MXJBs2ZbxSup1esNlSyz3azm
 wbRDBoj9rDXqvqzvH9ysMyCWYxS3Sn4rgwQZaXXCN42BtGM/DBDmIxsHTvAhY7J/zB/bouVZLzb
 q028kd3X0GCrSQCgfrEwBWMLLm24Bb4Slv5vBT5q2Deev7kRhBl0VCntwaRL1I1nCQB9oAMoarB
 1ZGFqBzMGTshGhaJhTyVdRB7f2ReA2hWS+hj/0TXTgCtrJ5S+i/mS8sOekEOl2hSM1bcpcJzSSV
 IyAyy3RQLQ74RYnO6a1kYNVLV2K+BEZcmwA/1BXTbgkS7DmmPvMf4ew5bf+UhaMIZ0dYmyPABrt
 0r1owc46JL1Q6OGsB26VudnHZc33zirn0gPeZLO/xJedrSMxEQNReQtBysGuDaH41D+niqYba0/
 1pp1sCDcdSVdoy8L9rJR3fHictVriecfMxz+zYIRPVFIUct3uOdV/WYdPmcVstBFfEEGSjnJ674
 qxsle7FItS1YuxIFTXLzHCD+mUXvetTRshMhcDzK7uvYW3ChfHzPU6Wzj5k5RhocqFYITVvY9R/
 xzww5zYaJaffKh/KubF/t3/ygNbCtd5r8Sg6PDQ6BWZkf+Ot3OkD6h/sAVanI5YNrKTJoFrg3Yi
 k4HtIwPlH1gz6aQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add the `RequestQueue` type as a Rust abstraction for `struct
request_queue`. This type provides methods to access the request queue
associated with a `GenDisk` or `Request`.

The abstraction exposes queue-related functionality needed by block
device drivers.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq.rs               |  2 ++
 rust/kernel/block/mq/gen_disk.rs      |  7 ++++
 rust/kernel/block/mq/request_queue.rs | 60 +++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 77e3593e8626..e89eb394001f 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -127,6 +127,7 @@
 pub mod gen_disk;
 mod operations;
 mod request;
+mod request_queue;
 pub mod tag_set;
 
 pub use operations::Operations;
@@ -135,4 +136,5 @@
     Request,
     RequestTimerHandle, //
 };
+pub use request_queue::RequestQueue;
 pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index f51bccb0d2ef..6ba8d88f63a9 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -9,6 +9,7 @@
     bindings,
     block::mq::{
         Operations,
+        RequestQueue,
         TagSet, //
     },
     error::{
@@ -253,6 +254,12 @@ impl<T: Operations> GenDisk<T> {
     pub fn get_ref(&self) -> Arc<Revocable<GenDiskRef<T>>> {
         self.backref.clone()
     }
+
+    /// Get the [`RequestQueue`] associated with this [`GenDisk`].
+    pub fn queue(&self) -> &RequestQueue<T> {
+        // SAFETY: By type invariant, self is a valid gendisk.
+        unsafe { RequestQueue::from_raw((*self.gendisk).queue) }
+    }
 }
 
 // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
diff --git a/rust/kernel/block/mq/request_queue.rs b/rust/kernel/block/mq/request_queue.rs
new file mode 100644
index 000000000000..45fb55b1a310
--- /dev/null
+++ b/rust/kernel/block/mq/request_queue.rs
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::Operations;
+use crate::types::{
+    ForeignOwnable,
+    Opaque, //
+};
+use core::marker::PhantomData;
+
+/// A structure describing the queues associated with a block device.
+///
+/// Owned by a [`GenDisk`].
+///
+/// # Invariants
+///
+/// - `self.0` is a valid `bindings::request_queue`.
+/// - `self.0.queuedata` is a valid `T::QueueData`.
+#[repr(transparent)]
+pub struct RequestQueue<T>(Opaque<bindings::request_queue>, PhantomData<T>);
+
+impl<T> RequestQueue<T>
+where
+    T: Operations,
+{
+    /// Create a [`RequestQueue`] from a raw `bindings::request_queue` pointer
+    ///
+    /// # Safety
+    ///
+    /// - `ptr` must be valid for use as a reference for the duration of `'a`.
+    /// - `ptr` must have been initialized as part of [`GenDiskBuilder::build`].
+    pub(crate) unsafe fn from_raw<'a>(ptr: *const bindings::request_queue) -> &'a Self {
+        // INVARIANT:
+        // - By function safety requirements, `ptr` is a valid `request_queue`.
+        // - By function safety requirement `ptr` was initialized by [`GenDiskBuilder::build`], and
+        //   thus `queuedata` was set to point to a valid `T::QueueData`.
+        //
+        // SAFETY: By function safety requirements `ptr` is valid for use as a reference.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Get the driver private data associated with this [`RequestQueue`].
+    pub fn queue_data(&self) -> <T::QueueData as ForeignOwnable>::Borrowed<'_> {
+        // SAFETY: By type invariant, `queuedata` is a valid `T::QueueData`.
+        unsafe { T::QueueData::borrow((*self.0.get()).queuedata) }
+    }
+
+    /// Stop all hardware queues of this [`RequestQueue`].
+    pub fn stop_hw_queues(&self) {
+        // SAFETY: By type invariant, `self.0` is a valid `request_queue`.
+        unsafe { bindings::blk_mq_stop_hw_queues(self.0.get()) }
+    }
+
+    /// Start all hardware queues of this [`RequestQueue`].
+    ///
+    /// This function will mark the queues as ready and if necessary, schedule the queues to run.
+    pub fn start_stopped_hw_queues_async(&self) {
+        // SAFETY: By type invariant, `self.0` is a valid `request_queue`.
+        unsafe { bindings::blk_mq_start_stopped_hw_queues(self.0.get(), true) }
+    }
+}

-- 
2.51.2


