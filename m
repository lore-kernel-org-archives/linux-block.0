Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA12E5D17;
	Sun, 15 Feb 2026 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199091; cv=none; b=hI3wvyY8A9oQj4ckoLqg/XOzHc5nkP8Tr80BdtWe6IBaIVCpOkngT1kV1H0WAjRSWaFPHXA7qJY1uCPPCpYmluAAO3sKHJyktez9BAb/0Opm/yeiv7zFHW4VDSXr7lWfsmbLHqxDIYo9/z/CZiiYM3TdALpDHQsuJ3N03oMZqTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199091; c=relaxed/simple;
	bh=KJozLO0lF2FpzqbaUJL2aSa4aBhSF0NKtk7cOClvuLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSq2yzWxmtRclToyo+jqL+NUrJOHwOUw/0oYi9ks58PY1t92uQl8zLwy+LKs3fl5L/wurfCC8NFtcErWg/3Y9UCixFDMhJ7t51doW6RzjnCz7Vxc3Z92I+LEGAcp6SUnWG2dXQomuoN7qZOkY40DwkcPFm78HJknqT5BzpUtRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+2PSU7K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+2PSU7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E54BC4CEF7;
	Sun, 15 Feb 2026 23:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199091;
	bh=KJozLO0lF2FpzqbaUJL2aSa4aBhSF0NKtk7cOClvuLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q+2PSU7KVK894R2Aztskm49ouQ07YfRkNT67DhLkNKw5XawmZyq6qySRtQpyy+saB
	 mVJCqCqdjTlB1y6P7X24Fu5LTd3da+95pdHalXDcprdYiTnIvLj5J/wxd8ekT5Ai5J
	 Wkjj9njcLJq4qDAQI+Fqc7ArOvP/CP44APlRwKETRtEI42nRovriFsRO1apokavlUs
	 Brt6wdP4c9BHfJ2wgp4LZXKhFO9fTadztmUrOIFg8FRrzweKW0Kn7rc4K6MmS84EaS
	 oKY3LNB4d5MPiSiqKEoWDT0oqp0SqaVrdyzpxexuhFsW7vuKq/n+4QLSpC+rfJZMVl
	 VFlIDixTWGJvA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:37 +0100
Subject: [PATCH 50/79] block: rust: add an abstraction for `struct
 blk_mq_queue_map`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-50-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7024; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=KJozLO0lF2FpzqbaUJL2aSa4aBhSF0NKtk7cOClvuLI=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhIw61luKCnzKfaISJJLxAq6+mHxPJwvpl1v
 iP3zQiPIySJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYSAAKCRDhuBo+eShj
 d26FD/4gfr3V2SAN/XvgmWVz1dCEbXu+WeUMPsAAH49GKVtWbtkIiO/6r31TsF16Sb536ocwLdH
 emuUJDlG0IWhGUn9Lz9qme/Hw7xd1SHBKuWDtnGXTbQA+8jva2+qeMC08WKSP0ygKCLVOPMfnjR
 Xbv4nOBDi7ElpZ+F6szkqSAPj3wz+fCy+TfpfB4WWZ2hzuoKkcn5Ei1lrvEysMSqg4AwP0VC8/s
 jTTrcisI392gezwBwij8jQ5Ji3VV+8NDAx4rNLM03hwnqzx7M+6T4rALLxTzW58HWlJjfijKF+G
 2+b+6BJn+Lfv3TAi1jWJvgidUL5xAE510CTbU0cSA6mUOvL/Ev2zVViOzI+qvENkta8PH3mAepe
 39OpQmA6i1/FKTsEITNCMz51/h8S6I/ua48TThZWl7F6GKVT6lVQj0nn5gZGM/sdfLPris2LhC9
 8VxcSXdoG9vr80uOhOLX3m57p78D70sxiEwpL7MrDBDNak7LU0OZxe/DJWvTkkDMmBsEUp2V478
 ZWfDU/N81fzpEWo0uvKPRGjIU12NYvlS7tIRVQwdSJUq2VWr8Lx6PJ2ZeWHSbyXJMcH4ACcoPLo
 8cWW1iXCBlTAEWGHLpiaU+L8M0k0LjLvPvRMKJDQW9xoxXvBIf8mfaAGGn8ZQ/cV77KB6TRL4sk
 PZfkxR9kYsQ6KXQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add the `QueueMap` and `QueueType` types as Rust abstractions for CPU
to hardware queue mappings. The `QueueMap` type wraps `struct
blk_mq_queue_map` and provides methods to set up the mapping between
CPUs and hardware queues.

`QueueType` represents the different queue types: default, read, and
poll queues.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq.rs            |  1 +
 rust/kernel/block/mq/operations.rs | 10 ++--
 rust/kernel/block/mq/tag_set.rs    | 96 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 057a5f366be3a..cd0bfbcbf317a 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -136,4 +136,5 @@
 pub use request::Request;
 pub use request::RequestTimerHandle;
 pub use request_queue::RequestQueue;
+pub use tag_set::QueueType;
 pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 017fad010d174..28dd4b28d203f 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -102,8 +102,8 @@ fn report_zones(
         Err(ENOTSUPP)
     }
 
-    /// Called by the kernel to map submission queues to CPU cores.
-    fn map_queues(_tag_set: &TagSet<Self>) {
+    /// Called by the kernel to map hardware queues to CPU cores.
+    fn map_queues(_tag_set: Pin<&mut TagSet<Self>>) {
         build_error!(crate::error::VTABLE_DEFAULT_ERROR)
     }
 }
@@ -408,9 +408,9 @@ impl<T: Operations> OperationsVTable<T> {
     /// must be a pointer to a valid and initialized `TagSet<T>`. The pointee
     /// must be valid for use as a reference at least the duration of this call.
     unsafe extern "C" fn map_queues_callback(tag_set: *mut bindings::blk_mq_tag_set) {
-        // SAFETY: The safety requirements of this function satiesfies the
-        // requirements of `TagSet::from_ptr`.
-        let tag_set = unsafe { TagSet::from_ptr(tag_set) };
+        // SAFETY: By C API contract `tag_set` is the tag set registered with the `GenDisk` created
+        // by `GenDiskBuilder`.
+        let tag_set = unsafe { TagSet::from_ptr_mut(tag_set) };
         T::map_queues(tag_set);
     }
 
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index 330ff28c91507..e6edc5bc39312 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -97,11 +97,46 @@ pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set {
     /// `ptr` must be a pointer to a valid and initialized `TagSet<T>`. There
     /// may be no other mutable references to the tag set. The pointee must be
     /// live and valid at least for the duration of the returned lifetime `'a`.
+    #[expect(dead_code)]
     pub(crate) unsafe fn from_ptr<'a>(ptr: *mut bindings::blk_mq_tag_set) -> &'a Self {
         // SAFETY: By the safety requirements of this function, `ptr` is valid
         // for use as a reference for the duration of `'a`.
         unsafe { &*(ptr.cast::<Self>()) }
     }
+
+    /// Create a `TagSet<T>` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a pointer to a valid and initialized `TagSet<T>`. There
+    /// may be no other mutable references to the tag set. The pointee must be
+    /// live and valid at least for the duration of the returned lifetime `'a`.
+    pub(crate) unsafe fn from_ptr_mut<'a>(ptr: *mut bindings::blk_mq_tag_set) -> Pin<&'a mut Self> {
+        // SAFETY: By function safety requirements, `ptr` is valid for use as a mutable reference.
+        let mref = unsafe { &mut *(ptr.cast::<Self>()) };
+
+        // SAFETY: We never move out of `mref`.
+        unsafe { Pin::new_unchecked(mref) }
+    }
+
+    /// Helper function to invoke a closure each hardware queue type supported.
+    ///
+    /// This function invokes `cb` for each variant of [`QueueType`] that this [`TagSet`] supports.
+    /// This is helpful for setting up CPU to hardware queue maps in the [`Operations::map_queues`]
+    /// callback.
+    pub fn update_maps(self: Pin<&mut Self>, mut cb: impl FnMut(QueueMap)) -> Result {
+        // SAFETY: By type invariant, `self.inner` is valid.
+        let nr_maps = unsafe { (*self.inner.get()).nr_maps };
+        for i in 0..nr_maps {
+            cb(QueueMap {
+                // SAFETY: By type invariant, `self.inner` is valid.
+                map: unsafe { &raw mut (*self.inner.get()).map[i as usize] },
+                kind: i.try_into()?,
+            });
+        }
+
+        Ok(())
+    }
 }
 
 #[pinned_drop]
@@ -125,3 +160,64 @@ unsafe impl<T: Operations> Sync for TagSet<T> {}
 
 // SAFETY: It is safe to share references to `TagSet` across thread boundaries.
 unsafe impl<T: Operations> Send for TagSet<T> {}
+
+/// A [`TagSet`] CPU to hardware queue mapping.
+///
+/// # Invariants
+///
+/// - `self.map` points to a valid `blk_mq_queue_map`
+pub struct QueueMap {
+    map: *mut bindings::blk_mq_queue_map,
+    kind: QueueType,
+}
+
+impl QueueMap {
+    /// Set the number of queues for this mapping kind.
+    pub fn set_queue_count(&mut self, nr_queues: u32) {
+        // SAFETY: By type invariant, `self.map` is valid.
+        unsafe { (*self.map).nr_queues = nr_queues }
+    }
+
+    /// First hardware queue to map this queue kind onto. Used by the PCIe NVMe driver to map each
+    /// hardware queue type ([`QueueType`]) onto a distinct set of hardware queues.
+    pub fn set_offset(&mut self, offset: u32) {
+        // SAFETY: By type invariant, `self.map` is valid.
+        unsafe { (*self.map).queue_offset = offset }
+    }
+
+    /// Effectuate the mapping described by [`Self`].
+    pub fn map_queues(&self) {
+        // SAFETY: By type invariant, `self.map` is valid.
+        unsafe { bindings::blk_mq_map_queues(self.map) }
+    }
+
+    /// Return the kind of this queue mapping.
+    pub fn kind(&self) -> QueueType {
+        self.kind
+    }
+}
+
+/// Type of hardware queue.
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[repr(u32)]
+pub enum QueueType {
+    /// All I/O not otherwise accounted for.
+    Default = bindings::hctx_type_HCTX_TYPE_DEFAULT,
+    /// Just for READ I/O.
+    Read = bindings::hctx_type_HCTX_TYPE_READ,
+    ///  Polled I/O of any kind.
+    Poll = bindings::hctx_type_HCTX_TYPE_POLL,
+}
+
+impl TryFrom<u32> for QueueType {
+    type Error = kernel::error::Error;
+
+    fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
+        match value {
+            bindings::hctx_type_HCTX_TYPE_DEFAULT => Ok(QueueType::Default),
+            bindings::hctx_type_HCTX_TYPE_READ => Ok(QueueType::Read),
+            bindings::hctx_type_HCTX_TYPE_POLL => Ok(QueueType::Poll),
+            _ => Err(kernel::error::code::EINVAL),
+        }
+    }
+}

-- 
2.51.2


