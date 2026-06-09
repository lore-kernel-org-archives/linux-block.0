Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B9408A39;
	Tue,  9 Jun 2026 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032461; cv=none; b=mNNIm0nmhg/mUDmeGswGiIzTudt6wR9sxkWWyLqtmwl924ctzP7bTzCyPTbJKtn60MHscECEePl3TbuTs6Qhwu+R3gqujn/YK7ZCGHaryzqiHn0wLGCYwaRn6gmTRB2EzPCt6MOio/It0s77zQPcI01mwR8oyUxtlH9ky8UlFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032461; c=relaxed/simple;
	bh=rKHqlbFiDQot+ZmlglcKCo/ua2u/3jUgradS2liawPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZiN5AgPvF9rx4jB/02bpegc3Y6cyKhQCNpMIg5yyiXR5po1vunz06YAMO2FNUR/oa0g0C6jedSBJXbRAvxc0OC7RlZFAdDcY59/LOwIAOdw7M1iA3ohC9vzXfmvZ7oQch20vgr6Sipp2GQERUUlFAjZwWQYVgdaA1Gvo0i0t+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK8qLP51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK8qLP51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48C11F00893;
	Tue,  9 Jun 2026 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032460;
	bh=aU3etQORaY46jYoSyqScYvf6b4+RP+R/4DsnBtOMojA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UK8qLP51dGiAHHqYJNrAAu4gqz9LbJnT1abn0iB1tN10CWSgMOXM2WHUkBuVqwprn
	 DAVdOdrbUNzNNmXxmIMyFVrnn7/AsWnCmjFeJpZjs/O2nRVbntEp81Z30KMiAZSAIB
	 998Hsvm0FhjYz2KnJlg9AvjGA1eBiiucYgpW8+K0xooG5sDie9pGXGGtVBTWdcY7KP
	 ZEmvHizkHOwxqG5BOIebpXaZe7OTSSOBKGfU6WH0jYzLTW4MUSt9B+B/XqjTaCuPr6
	 DWLt3B4V7u4OrSIqyhrvnRLh9YNFYfiWcbfHtfE9tAL/V2/28zcuCpeBxei5KXA47L
	 LjCTTS5k/lt4Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:58 +0200
Subject: [PATCH v2 19/83] block: rust: allow specifying home node when
 constructing `TagSet`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-19-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3058; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=rKHqlbFiDQot+ZmlglcKCo/ua2u/3jUgradS2liawPs=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTFc9bXf/EXOOGGprjUbeDTFs4TcTazosGSi
 AAATe1MXLSJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkxQAKCRD6UCkIqsW9
 0EwTEACc0x57IjxoSWw17YFWmZ1nV5wtXGPR5ov9KpAor1CoF8ZnBF3cyjr2dewCH7eSzjwEA9F
 Yfk+ESoiBRMnHdyje1lz3SCriO/4Vb8YConPJcu4AY8HUuhcepOJkl6VMLTYd33cAYVhIku7h+H
 OB1Emtf9lOVAMHkHFTftNCMu3+4MK8nUZQNf4mUXV3BpsyGGJ6CXdAj5gqA/osH2pwU/G4u4D5L
 A/GYIrZKUyrIvLkjSiDV29/5dBBin5+vDLhpUVY6X3OnhtToq3CnXEbje+rxGbCqLZ9VlB+lu1m
 CH/VEHjcI+V3Fb1lLBhpy7id7+DrNqJ24GdvMGVoy8XwfQpAFt7f0Q93gHdSPIFEmC51KHiYAgN
 YJgR2OZAWcpPmRTym9OGXl1cFRMUz37yjNyYJNUD+Ev9406YcJ126JM02/O/TfumwdIO4hSeEqm
 Iq6IihHZ9BYODl1oDDSKwtIaPmrss2DD9th4AsvlnaSSO4wxwRQJFOy7a2aZ2FMnGl81IuoXOpW
 V+uYlzSqrUX7DFW828I7UOUsYr/aFziabmI90FsDQ0V2yiiO0AQV1OqNv6F+9UKaMNCdMTUMoUu
 ZNkSD5gMmFewkyEHVpnbi45VlDgxxer+vQdKV26NDyRrNpM1at0y0DAiMwzbNp9OGZ2nYKU2vTv
 Zj7VqK0IxKW8Upw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a `numa_node` parameter to `TagSet::new` to specify the home NUMA
node for tag set allocations. This allows drivers to optimize memory
placement for NUMA systems.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs    | 11 ++++++++++-
 rust/kernel/block/mq.rs         |  5 ++++-
 rust/kernel/block/mq/tag_set.rs |  4 +++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 30de022146ec..6323327d4a5a 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -174,7 +174,16 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             mq::tag_set::Flags::default()
         };
 
-        let tagset = Arc::pin_init(TagSet::new(submit_queues, 256, 1, flags), GFP_KERNEL)?;
+        let tagset = Arc::pin_init(
+            TagSet::new(
+                submit_queues,
+                256,
+                1,
+                kernel::alloc::NumaNode::NO_NODE,
+                flags,
+            ),
+            GFP_KERNEL,
+        )?;
 
         let queue_data = Box::pin_init(
             pin_init!(QueueData {
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index e556b3bb1191..bac15b509d90 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -57,6 +57,7 @@
 //!
 //! ```rust
 //! use kernel::{
+//!     alloc::NumaNode,
 //!     block::mq::{self, *},
 //!     new_mutex,
 //!     prelude::*,
@@ -92,7 +93,9 @@
 //! }
 //!
 //! let tagset: Arc<TagSet<MyBlkDevice>> =
-//!     Arc::pin_init(TagSet::new(1, 256, 1, mq::tag_set::Flags::default()), GFP_KERNEL)?;
+//!     Arc::pin_init(
+//!         TagSet::new(1, 256, 1, NumaNode::NO_NODE, mq::tag_set::Flags::default()),
+//!         GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
 //!     .build(fmt!("myblk"), tagset, ())?;
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index 5b1a5bcc978d..d6d104adf4aa 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -7,6 +7,7 @@
 use core::pin::Pin;
 
 use crate::{
+    alloc::NumaNode,
     bindings,
     block::mq::{
         operations::OperationsVTable,
@@ -57,6 +58,7 @@ pub fn new(
         nr_hw_queues: u32,
         num_tags: u32,
         num_maps: u32,
+        numa_node: NumaNode,
         flags: Flags,
     ) -> impl PinInit<Self, error::Error> {
         let tag_set: bindings::blk_mq_tag_set = pin_init::zeroed();
@@ -67,7 +69,7 @@ pub fn new(
                     ops: OperationsVTable::<T>::build(),
                     nr_hw_queues,
                     timeout: 0, // 0 means default which is 30Hz in C
-                    numa_node: bindings::NUMA_NO_NODE,
+                    numa_node: numa_node.id(),
                     queue_depth: num_tags,
                     cmd_size,
                     flags: flags.into(),

-- 
2.51.2


