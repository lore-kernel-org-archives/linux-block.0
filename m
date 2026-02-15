Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1672DEA75;
	Sun, 15 Feb 2026 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199006; cv=none; b=Ox79QtOY8VyGhLFMzhD9f8xRjFP6vfJm0cYtRQ97TLXm66rOXLvSYmgvfgfvm+/sN7K6ZEv6DjK8D1C5KCSaFKmAl+F2I7ZOcBu2vU2gvqfmo0CHsG36LtDklOQJyw72+L3Bhe4PHNbx8SHGHYf89EjWhp/aCTFvHdJ0AeOFt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199006; c=relaxed/simple;
	bh=GOcUVkfhEDgQ6ums41j+Tcm2cMd8mS+PY9bUD8N/Dz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSBSUWbjutHp82c9DUNUW2tw5z1k12iojr9iI8aHVgJSxznODvYQYe7LRTQ5+ja0vjrmbj97sylJltY3PHgYNFDYDjdwk8tAsU/f8/dhzvvmTteyG48mYwFC1h0BJD67ZMBoZjzw6ZjYrbyh7nboGBoLZIbtXMbyNjij5zFua5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEh1yGSV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEh1yGSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868A8C4CEF7;
	Sun, 15 Feb 2026 23:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199006;
	bh=GOcUVkfhEDgQ6ums41j+Tcm2cMd8mS+PY9bUD8N/Dz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CEh1yGSV4a2uzg4l1d8GdZvR6yZGxx7P7Qp19et8nDKk87JP6n/W2djZHGYWtxMjg
	 xw+EaAHFULi6Ck4l0KLmPK8pBNcVTQ1HM1Ab5oGi/gq2AUEr7zkVw2ZhQ9LYOXu0VD
	 kjsv2DUxGLa+M7WN+pzvKRqMI9CY7cBRPjqpNc5ntnQ78nmbXR0hVh7VIm7/rVO0IR
	 1gZwASzgkhoLJTgr/yss18vkijvUai4uQBP52xl7Q8Qv/G7i4FQ4fEay4vViDKa44J
	 L1C5fkCHhFRhJrLwQgyWqtt3jiRYxaHp2A6yB3a2ZGwnM/vgcWwnbtp14j/EEFdhvo
	 /KtnHR0r+p0ew==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:22 +0100
Subject: [PATCH 35/79] block: rust: add a request queue abstraction
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-35-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4571; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=GOcUVkfhEDgQ6ums41j+Tcm2cMd8mS+PY9bUD8N/Dz4=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg7bfZv+rauUSPeVBEpQwOIbacR5CrbTYZXo
 PobSHvGjUuJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYOwAKCRDhuBo+eShj
 d3NJEACHSSyaGc+RMfkrlUmWfU1AtFHObfNulQGbxBg6L2E1hcP0cdHbohuIIy2z9/jsqfse9qF
 FbfpGQewVILxCWZezHYlNWhoF9B3ljJCtWHX8p45y9jpY/cfFzWD0gHqfw0LkgDUlDWuTlWeIwP
 7QO4vFDpWeLnyP9BzQbomsIqrMFPk+E8LBE9PPp5B4303uUZ6smVXwjzO+IPqoyHiAwlcg6DYPp
 FRevzPnyuGu4QJ87rYrEiItLuVPx0hMrFZ1gTa+dUVUll6pT7CndefvgPnodZIE+aTLBtkOtC26
 ibv92WGg+ijvchbPSJEr6o19Dk7D5ZPfWkowuIHQQaaHHax1wi3P0c8mHMWWqFN9XkTZJlwDIuh
 ysBlapM5bvHDWwaUzfDgKgfAwYeZtUypFUvuiSCI2V9fB1wf827jlp2KACfjODUJBdmthe7Psyb
 qsbnFaoexmSUli3fc3O40lsjpMXXTYdzipL5J1IGaa9pxVoPszg8ktZ3op6kHZrGnvzpc7BoB3G
 Gp6f5u5qfIuqZDYil4kPxy4jHyvUQ+RmN5spsToBgI5vanTJ+p1ezvCzG856V59k5Gkp06R79vL
 7YVT/u4ZZRUkUdezMF26/PyB62LyLS3JL3Oc+RBGEZvLcpUzM8KApphdSE/Fme9GLs806hbi5KL
 kalmWM7O0IJ19/w==
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
 rust/kernel/block/mq/gen_disk.rs      |  8 ++++-
 rust/kernel/block/mq/request_queue.rs | 57 +++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index ab493bd91af4c..a898dda2635e5 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -127,10 +127,12 @@
 pub mod gen_disk;
 mod operations;
 mod request;
+mod request_queue;
 pub mod tag_set;
 
 pub use operations::Operations;
 pub use request::IdleRequest;
 pub use request::Request;
 pub use request::RequestTimerHandle;
+pub use request_queue::RequestQueue;
 pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 8d39bb70725b0..8a22767f1b916 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -7,7 +7,7 @@
 
 use crate::{
     bindings,
-    block::mq::{Operations, TagSet},
+    block::mq::{Operations, RequestQueue, TagSet},
     error::{self, from_err_ptr, Result},
     fmt::{self, Write},
     prelude::*,
@@ -240,6 +240,12 @@ impl<T: Operations> GenDisk<T> {
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
index 0000000000000..7d846ea423730
--- /dev/null
+++ b/rust/kernel/block/mq/request_queue.rs
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::Operations;
+use crate::types::{ForeignOwnable, Opaque};
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


