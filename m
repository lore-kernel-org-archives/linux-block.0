Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE723BC668;
	Fri, 10 Apr 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812132; cv=none; b=lWLavrcD805yaNnU70gdo+rnB6nf6fWMHkEks+f85VPkKjHiwxNdOJnld9MLO7r3GzYdBmK68x2AiWmu7eIDVdNqtN7OUmwQtTNGykkA172iV5Vor0P5EtUM7jawPTuOvCZv7uDz4jnofIGcm6swN0mruMhp9Q8mKWuPKkxjilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812132; c=relaxed/simple;
	bh=PmhWeZLS481wEXTWogitiKqTwhPAt11iFQvzkJeosls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=je4RJpHgWu4okN34HTcCOViOfNVs6epn7ipI49pSUdXQySF4ZZ8W94bMmw5oKmW5ebLY6rQZuefYKxWOvVJ48S+/bEVns1meL6TKRCVzu/d9N3T6ofb6TgQLiW+tYWmWAD75eLaulufEc8Xv0Yis7/yt2VuiwZ6sCgdkKnNV9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=d/PRtd0B; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="d/PRtd0B"
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a3dd6905;
	Fri, 10 Apr 2026 17:08:36 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: axboe@kernel.dk,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bjorn3_gh@protonmail.com,
	aliceryhl@google.com,
	lossin@kernel.org,
	boqun@kernel.org,
	dakr@kernel.org,
	gary@garyguo.net,
	sunke@kylinos.cn,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] rust: block: mq: safely expose TagSet flags
Date: Fri, 10 Apr 2026 05:08:28 -0400
Message-Id: <20260410090829.1409430-2-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410090829.1409430-1-wenzhaoliao@ruc.edu.cn>
References: <20260410090829.1409430-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d76a67e7103a2kunme6cebcccb9cec
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTh5KVkgdGEwdGEIaHkNCS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=d/PRtd0B1b/JNyZBcXhla/FYbGru8K4jCiF+ASAOjJ5pyDg5pyVP1Cp11wzK/VpAadZlKTQRLKF83EyQh2lSnAWymIGgl749MfXOBY3O5aN38awaZiR5/T4mxObCqaCk/8SOdZNlLb8vJ09AOaOae9TZTjtVnTWl+9KsBnb/Br8=; s=default; c=relaxed/relaxed; d=ruc.edu.cn; v=1;
	bh=lNW+7HqbMiGNbMJW0a11VasGyhtLCGI/ZmYr0PMpO/I=;
	h=date:mime-version:subject:message-id:from;

TagSet::new() currently hardcodes blk_mq_tag_set.flags to 0.

That prevents Rust block drivers from declaring blk-mq queue flags.

Introduce TagSetFlags as a typed wrapper for BLK_MQ_F_* bits.

Add TagSet::new_with_flags() so drivers can pass flags explicitly.

Keep TagSet::new() as a compatibility wrapper using empty flags.

Re-export TagSetFlags from kernel::block::mq for driver imports.

Build-tested with LLVM=-15 in an out-of-tree rust-next build.

Validation includes vmlinux and drivers/block/rnull/rnull_mod.ko.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 rust/kernel/block/mq.rs         |  2 +-
 rust/kernel/block/mq/tag_set.rs | 86 ++++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 1fd0d54dd549..799afdf36539 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -100,4 +100,4 @@
 
 pub use operations::Operations;
 pub use request::Request;
-pub use tag_set::TagSet;
+pub use tag_set::{TagSet, TagSetFlags};
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index dae9df408a86..72d9bce5b11f 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -16,6 +16,80 @@
 use core::{convert::TryInto, marker::PhantomData};
 use pin_init::{pin_data, pinned_drop, PinInit};
 
+/// Flags that control blk-mq tag set behavior.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+#[derive(Clone, Copy, PartialEq, Eq)]
+pub struct TagSetFlags(u32);
+
+impl TagSetFlags {
+    /// Returns an empty instance where no flags are set.
+    pub const fn empty() -> Self {
+        Self(0)
+    }
+
+    /// Register as a blocking blk-mq driver device.
+    pub const BLOCKING: Self = Self::new(bindings::BLK_MQ_F_BLOCKING as u32);
+
+    /// Use an underlying blk-mq device for completing I/O.
+    pub const STACKING: Self = Self::new(bindings::BLK_MQ_F_STACKING as u32);
+
+    /// Share hardware contexts between tags.
+    pub const TAG_HCTX_SHARED: Self = Self::new(bindings::BLK_MQ_F_TAG_HCTX_SHARED as u32);
+
+    /// Allocate tags on a round-robin basis.
+    pub const TAG_RR: Self = Self::new(bindings::BLK_MQ_F_TAG_RR as u32);
+
+    /// Disable the I/O scheduler by default.
+    pub const NO_SCHED_BY_DEFAULT: Self =
+        Self::new(bindings::BLK_MQ_F_NO_SCHED_BY_DEFAULT as u32);
+
+    /// Check whether `flags` is contained in `self`.
+    pub fn contains(self, flags: Self) -> bool {
+        (self & flags) == flags
+    }
+
+    pub(crate) const fn as_raw(self) -> u32 {
+        self.0
+    }
+
+    const fn all_bits() -> u32 {
+        Self::BLOCKING.0
+            | Self::STACKING.0
+            | Self::TAG_HCTX_SHARED.0
+            | Self::TAG_RR.0
+            | Self::NO_SCHED_BY_DEFAULT.0
+    }
+
+    const fn new(value: u32) -> Self {
+        Self(value)
+    }
+}
+
+impl core::ops::BitOr for TagSetFlags {
+    type Output = Self;
+
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for TagSetFlags {
+    type Output = Self;
+
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for TagSetFlags {
+    type Output = Self;
+
+    fn not(self) -> Self::Output {
+        Self(!self.0 & Self::all_bits())
+    }
+}
+
 /// A wrapper for the C `struct blk_mq_tag_set`.
 ///
 /// `struct blk_mq_tag_set` contains a `struct list_head` and so must be pinned.
@@ -37,6 +111,16 @@ pub fn new(
         nr_hw_queues: u32,
         num_tags: u32,
         num_maps: u32,
+    ) -> impl PinInit<Self, error::Error> {
+        Self::new_with_flags(nr_hw_queues, num_tags, num_maps, TagSetFlags::empty())
+    }
+
+    /// Try to create a new tag set with the given blk-mq flags.
+    pub fn new_with_flags(
+        nr_hw_queues: u32,
+        num_tags: u32,
+        num_maps: u32,
+        flags: TagSetFlags,
     ) -> impl PinInit<Self, error::Error> {
         let tag_set: bindings::blk_mq_tag_set = pin_init::zeroed();
         let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper>()
@@ -49,7 +133,7 @@ pub fn new(
                     numa_node: bindings::NUMA_NO_NODE,
                     queue_depth: num_tags,
                     cmd_size,
-                    flags: 0,
+                    flags: flags.as_raw(),
                     driver_data: core::ptr::null_mut::<crate::ffi::c_void>(),
                     nr_maps: num_maps,
                     ..tag_set
-- 
2.34.1

