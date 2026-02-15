Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105312D97A6;
	Sun, 15 Feb 2026 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198934; cv=none; b=pvFxRjcFNB92UMelEZNGEUzplMXkuK36v18RL09mOiZhC9m7BVssCYi5g5Bcjm1DbDGirzqHgMqhBG1XPWwoABX/2uwPQU3m5y9fb7xE2TLlsYZcdYiCGM6h9u6cOk+tveXEeZwp795Ykp0qRzgGFSaKZEF+cEuKmjohJ2pTvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198934; c=relaxed/simple;
	bh=h7+bon01UENFNoUz8aPGZ7HCRgNi5L5RQlf/Y/C7XMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gtds3KrHqSEnlY2bN2sbSrRR2mMKpkEhPnepHG9m+DZCWRgWv+0lZpamRTSwFogaJ36IgdaOBljniaF2uGAdVyZXoXAf4McmeHIaqpqbpd+/v2oN5rYwp4ST2NyUuUr3Jd0Re2vaCKGo/hOQse63A/p7T9MOwAYluUzauxfJShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTB2Bv0h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTB2Bv0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C44C4CEF7;
	Sun, 15 Feb 2026 23:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198933;
	bh=h7+bon01UENFNoUz8aPGZ7HCRgNi5L5RQlf/Y/C7XMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oTB2Bv0htB2pXAXWaZJsudOqYB2WyHJ74Zz2aeHIU3yDKemx2JWmtEf8wyTL84VPL
	 dRyIkzzyIQsjYHgWBkoHd+YUny96mtkaUBkrhDyVio9zCC3+WSHffWQWsoh+MRjLR4
	 bg3kzp8VNT1qSq6rw75xhyP7k88bU+LbVBNEW7s4bwqJHBotNK2ZiaYPz8yGfEmds9
	 ZK8r9TrjOvywsNIBH6jnlG7LlQ0At0/TFSeIJpR0Nat1vbvJemEV4/tbyOKw7hfnQN
	 aasdUQPnAkxUS3HqfhHpzAi3DeHoci8f1DnQyHxbxxSnFRtTkO2Kq/BWB8VuVHL3dK
	 OrIlFBmjm6eSA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:43 +0100
Subject: [PATCH 56/79] block: rust: add abstraction for block queue feature
 flags
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-56-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6502; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=h7+bon01UENFNoUz8aPGZ7HCRgNi5L5RQlf/Y/C7XMA=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhOREpIyxuvj/IBFaVKOjzP6Ic55E0Q/l0dW
 MIwADOZnFeJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYTgAKCRDhuBo+eShj
 d9hoEACpVmpgtnsKcpDvuhvuAPuxqSo5potehm+47IVnGk8liQen6kvUYVGj8MBJ92nUu9SvxuY
 dtoaM8jPnSp4ocwYgA4nowinOfRuNy7oBVWt8HmD0WQtFC6AKb6bJZotCcb7PmpeJF0YPu6kyOI
 WUC5JGi3URjTb1Qq7MbfGjXXvvHIqlZT+MuxDboD/0EBn5EJl+EjKjNVYVS9TeA2aq6Q/f03h7z
 3xP1Mjrbmj9sXhwYAy6T+wfbC2GrTbcjw/Hob5FFXb297vFUX7d++uNTazraLYmpfi99JcjltAi
 0wbe28Jp6hJE9zeqOlufQLn/x3MPMl8Kn+00raZObBz06TiRKXSgOj1Gt5Yri6PznQjjR+ITxXE
 3GQeznd6Xd/BLpDQSfNfR/RBxAAkoWf3jfpj4tblQFH3K84gvr7jxwWH2+/qEuXVqmLVgwR/+hB
 DtwffWbgsHjVSLjItvZuQ3wkWAF1SqLhG+JOkgAU/tP+/uhNCVRLcccxnSsy6xhIlxVpisfG8HZ
 0n95Sh6IL2L43khIYnpYfNVuFkCnzD+7AYxe0SgMd9/eAytq1ETsaNMG+6WWQFAo6vqmvjrQ8JE
 zCpkPZGushAyWA5FLbU0pLekebqK9U98u4uomQZtHfd73cUHlCwIf8lM+PtZTtmEZ9nRrXliYZs
 yYj1lSCT2uPCd7w==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add the `Feature` enum and `Features` type as Rust abstractions for the
C `blk_features_t` bitfield. These types wrap the `BLK_FEAT_*` flags
and allow drivers to describe block device capabilities such as write
cache support, FUA, rotational media, and DAX.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/bindings/bindings_helper.h | 15 ++++++++-
 rust/kernel/block/mq.rs         |  2 ++
 rust/kernel/block/mq/feature.rs | 73 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index b8c2f3eadc730..209c53443e9cb 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -113,7 +113,6 @@ const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
 const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
-const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_OK = BLK_STS_OK;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_NOTSUPP = BLK_STS_NOTSUPP;
 const blk_status_t RUST_CONST_HELPER_BLK_STS_TIMEOUT = BLK_STS_TIMEOUT;
@@ -133,7 +132,21 @@ const blk_status_t RUST_CONST_HELPER_BLK_STS_ZONE_ACTIVE_RESOURCE = BLK_STS_ZONE
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
index 5a1c8e914bb9e..b36112f7b22b9 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -125,12 +125,14 @@
 //! # Ok::<(), kernel::error::Error>(())
 //! ```
 
+mod feature;
 pub mod gen_disk;
 mod operations;
 mod request;
 mod request_queue;
 pub mod tag_set;
 
+pub use feature::{Feature, Features};
 pub use operations::IoCompletionBatch;
 pub use operations::Operations;
 pub use request::Command;
diff --git a/rust/kernel/block/mq/feature.rs b/rust/kernel/block/mq/feature.rs
new file mode 100644
index 0000000000000..6c9f098e10c55
--- /dev/null
+++ b/rust/kernel/block/mq/feature.rs
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Block device feature flags.
+//!
+//! This module provides Rust abstractions for the C `blk_features_t` type and
+//! the associated `BLK_FEAT_*` flags defined in `include/linux/blkdev.h`.
+
+use kernel::prelude::*;
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


