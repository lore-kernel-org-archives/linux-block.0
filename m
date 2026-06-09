Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD4D4EA37C;
	Tue,  9 Jun 2026 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032606; cv=none; b=jYgo+CG/ydg3K8IM8l9aiPVjWJs0fSWyGSDpNY+CgHTPtsHxYqQvoFW2tBj4fq2aN2S5+8HTe3QUf6vOLdgGhqzX89BJPPNrkuVw9aBJjV63gACfNU4CK8jLy4VAFMsakTZyOzX/Uq0gs6AbvEfvhaMDXO/c14JEx4PsbUTLR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032606; c=relaxed/simple;
	bh=qsUKYYdo8WvQ3OUet+Sg4krK1e3oT616Y3hnM04WUUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bboaW2N5wGxP2Trm72Cn5hLlH39TQR770AkMdHqaOPxcZZLMCjyb0YfqtO4NyyWUiIgXM24ChhFtzSFF1xGbqt+kKiSyOK19t0Uht6/cACBLKdIfJuWru0JN7FCcDMIKls+d8Jl4Jm83NWbbV3LCOVUTdO4aG+68aBBSHohSnhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3DogMGq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3DogMGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB021F00898;
	Tue,  9 Jun 2026 19:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032605;
	bh=GG7pmCmWFnp9jZvdbQDmbhPtuDfh4M2FF6gkwIDeo6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U3DogMGqDWWdylVM8ryJHz4W/HitJOCJjFjN9ZH1NIs6FFemXBoa14zSHP1SBJS9d
	 cr8IeXNqWGNOZROEB1cbSIInFGiOLLSSEN68l+yoclpfARRcmlqO6lCzpy0h7v/c0b
	 cBiVM7CKqTgNbNC+U2Iet4SwMLGTQkn9Kz8rwVPvttMAmL0qMZnUU8sV43ErrofAiB
	 AO8Oixsx47go3UAwuQOb8ZfV4Z/YdeHeIqntz2/3wuKqYwhCO5G1kBWZpv9o+YOj0J
	 f5CnzN4ANDC7Z7mOIYAOV5Hg3UqgfGlzD4y1OLIZMy3Q+Y+x5UHy+O+D8UhdUbkyZ6
	 Dnjg13bJGwE9w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:40 +0200
Subject: [PATCH v2 61/83] block: rust: add abstraction for block queue
 feature flags
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-61-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6514; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=qsUKYYdo8WvQ3OUet+Sg4krK1e3oT616Y3hnM04WUUw=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTrIKkFcKUQRufLll6LHGGeCFub5v0tIEjJD
 nrNF9QzWL6JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk6wAKCRD6UCkIqsW9
 0EMuD/9JZn80xXpH8G01ZlOumy1Qv9DSLMJusdiBBVjQ4ehhVnNNQmYZgMeaMJpmdfx2UMuji3w
 TagrVTOjw5j1cXfZM+Zv/AZ1HHhVcZ65ViBRMvvCPvPlE1yHkR1iKSNpO5uW+gQpb9cD0Pb6ub5
 5mJSkdY0d7CD1fuPmjcrxzXHsgDpYdI87HDz9o4EIITcmUsGxx1JdfCUUFDFuZxvp/o378UIifn
 x9QDj6kyvewr8pWnzSd6N76zEkV3X32H5NXb6HR8Fd5tFDU/h8MaS58JnPnZax4yTIKQ5MeR5+N
 0PFzibj8zOJdS1aYCLQaMFfpYurdIdV3AUFTDbrUv63pPp12ZBC8b3UxeJ84BzE0JNpe6dQnkQU
 IJaMBq2CLQc8y6JyHOgh/Lpek3O/eGkTCBaGnHSu9/XY+PP4AGAAzk8kJ9tN+ai+qe1uTKtfasZ
 lpFhvYqmO4E0k4y6p5fIoXP+2UxKXVfCltw+wFwotF+1/TDqIppkLoWuhS9ki6jZAHQZSwytYr6
 Zv3PCY9AZQzElEiylUsnQ/GNR6LWLT+I3VMDy4F5bVXJMQwu0ZMwJ/2lUnbNf6S+kigkovlQejB
 1y8cH6N/Xm3Y2jRqzUEj1BWOvtxsXXrwzdW6Lz2Ci6FPoIkTZvh8glP7lzEEypQPPmEgHZiUUGG
 ozwvqWcbh3qu60Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add the `Feature` enum and `Features` type as Rust abstractions for the
C `blk_features_t` bitfield. These types wrap the `BLK_FEAT_*` flags
and allow drivers to describe block device capabilities such as write
cache support, FUA, rotational media, and DAX.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/bindings/bindings_helper.h | 15 +++++++-
 rust/kernel/block/mq.rs         |  5 +++
 rust/kernel/block/mq/feature.rs | 76 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7acda3ae9725..af0330b9e491 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -119,7 +119,6 @@ const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
 const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
-const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_OK = BLK_STS_OK;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_NOTSUPP = BLK_STS_NOTSUPP;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_TIMEOUT = BLK_STS_TIMEOUT;
@@ -139,7 +138,21 @@ const blk_status_t RUST_CONST_HELPER_BLK_STS_ZONE_ACTIVE_RESOURCE = BLK_STS_ZONE
 const blk_status_t RUST_CONST_HELPER_BLK_STS_OFFLINE = BLK_STS_OFFLINE;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_DURATION_LIMIT = BLK_STS_DURATION_LIMIT;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_INVAL = BLK_STS_INVAL;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_WRITE_CACHE = BLK_FEAT_WRITE_CACHE;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_FUA = BLK_FEAT_FUA;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ADD_RANDOM = BLK_FEAT_ADD_RANDOM;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_IO_STAT = BLK_FEAT_IO_STAT;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_STABLE_WRITES = BLK_FEAT_STABLE_WRITES;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_SYNCHRONOUS = BLK_FEAT_SYNCHRONOUS;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_NOWAIT = BLK_FEAT_NOWAIT;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_DAX = BLK_FEAT_DAX;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_POLL = BLK_FEAT_POLL;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ZONED = BLK_FEAT_ZONED;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_PCI_P2PDMA = BLK_FEAT_PCI_P2PDMA;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_SKIP_TAGSET_QUIESCE = BLK_FEAT_SKIP_TAGSET_QUIESCE;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE = BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE;
+const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ATOMIC_WRITES = BLK_FEAT_ATOMIC_WRITES;
 const blk_opf_t RUST_CONST_HELPER_REQ_FAILFAST_DEV = REQ_FAILFAST_DEV;
 const blk_opf_t RUST_CONST_HELPER_REQ_FAILFAST_TRANSPORT = REQ_FAILFAST_TRANSPORT;
 const blk_opf_t RUST_CONST_HELPER_REQ_FAILFAST_DRIVER = REQ_FAILFAST_DRIVER;
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 9bad95d79230..7c346be843e1 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -125,12 +125,17 @@
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
 
+mod feature;
 pub mod gen_disk;
 mod operations;
 mod request;
 mod request_queue;
 pub mod tag_set;
 
+pub use feature::{
+    Feature,
+    Features, //
+};
 pub use operations::{
     IoCompletionBatch,
     Operations, //
diff --git a/rust/kernel/block/mq/feature.rs b/rust/kernel/block/mq/feature.rs
new file mode 100644
index 000000000000..015d7925d5f0
--- /dev/null
+++ b/rust/kernel/block/mq/feature.rs
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Block device feature flags.
+//!
+//! This module provides Rust abstractions for the C `blk_features_t` type and
+//! the associated `BLK_FEAT_*` flags defined in `include/linux/blkdev.h`.
+
+use crate::{
+    bindings,
+    impl_flags, //
+};
+
+impl_flags! {
+    /// A set of block device feature flags.
+    ///
+    /// This type wraps the C `blk_features_t` bitfield and represents a
+    /// combination of zero or more [`Feature`] flags. It is used to describe
+    /// the capabilities of a block device in [`struct queue_limits`].
+    ///
+    /// [`struct queue_limits`]: srctree/include/linux/blkdev.h
+    #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
+    pub struct Features(u32);
+
+    /// A block device feature flag.
+    ///
+    /// Each variant corresponds to a `BLK_FEAT_*` constant defined in
+    /// `include/linux/blkdev.h`. These flags describe individual capabilities
+    /// or properties of a block device.
+    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
+    pub enum Feature {
+        /// Supports a volatile write cache.
+        WriteCache = bindings::BLK_FEAT_WRITE_CACHE,
+
+        /// Supports passing on the FUA bit.
+        ForcedUnitAccess = bindings::BLK_FEAT_FUA,
+
+        /// Rotational device (hard drive or floppy).
+        Rotational = bindings::BLK_FEAT_ROTATIONAL,
+
+        /// Contributes to the random number pool.
+        AddRandom = bindings::BLK_FEAT_ADD_RANDOM,
+
+        /// Enables disk/partitions I/O accounting.
+        IoStat = bindings::BLK_FEAT_IO_STAT,
+
+        /// Don't modify data until writeback is done.
+        StableWrites = bindings::BLK_FEAT_STABLE_WRITES,
+
+        /// Always completes in submit context.
+        Synchronous = bindings::BLK_FEAT_SYNCHRONOUS,
+
+        /// Supports REQ_NOWAIT.
+        Nowait = bindings::BLK_FEAT_NOWAIT,
+
+        /// Supports DAX.
+        Dax = bindings::BLK_FEAT_DAX,
+
+        /// Supports I/O polling.
+        Poll = bindings::BLK_FEAT_POLL,
+
+        /// Is a zoned device.
+        Zoned = bindings::BLK_FEAT_ZONED,
+
+        /// Supports PCI(e) p2p requests.
+        PciP2Pdma = bindings::BLK_FEAT_PCI_P2PDMA,
+
+        /// Skips this queue in `blk_mq_(un)quiesce_tagset`.
+        SkipTagsetQuiesce = bindings::BLK_FEAT_SKIP_TAGSET_QUIESCE,
+
+        /// Undocumented magic for bcache.
+        RaidPartialStripesExpensive = bindings::BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE,
+
+        /// Atomic writes enabled.
+        AtomicWrites = bindings::BLK_FEAT_ATOMIC_WRITES,
+    }
+}

-- 
2.51.2


