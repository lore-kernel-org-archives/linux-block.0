Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76AD2DB7A1;
	Sun, 15 Feb 2026 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198948; cv=none; b=fw4UuYJXUi/vTXe2ka78E8Kc8L/j/TBHIvUTEz/U8A8Iqft9lIflmwStWtWAynlbHpXEz1A0sWxpGriBUWHXaeOI1VWf1vHUCwvvudxzpWuGihForHMUJ8ic3YmnBk8T3stoqd4q+ghs5NIosIMEbpwYR25oCbD/Xw6zpRzGwS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198948; c=relaxed/simple;
	bh=3w4qnZwh2+aU+MMv2rWpFqX4lbRY4HhOYDulfwtiM5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDgOHnlFkMRwm+lWePLO7NKB86bCUfvXrOo1PE8QWJeRnvdDwqU2ZARR2JA2+8L2CWF77YCcR+50zoCrNikkW1KJeuYr6CtppFdAWQSyeOSOmrK4LjSbcGfBQ6kOVu/mz1WuGLbd7rKXe4Wiq3/m7Gz0PJajADKNukB5LzX9olo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcNBsaOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcNBsaOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A372C4CEF7;
	Sun, 15 Feb 2026 23:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198948;
	bh=3w4qnZwh2+aU+MMv2rWpFqX4lbRY4HhOYDulfwtiM5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hcNBsaOUM934DH9Bn9Bt2eXMRFTjwTsogGjvGEoqIobTgU/yhXBgCW+djhbrod562
	 cotXZxz70B7WGOdbqDoyoRkCajfzwkKHrLswK0I/GXkWYW4EAy8zdjNCRojo+4EBSY
	 nMI9JFDO46qVxu0S0dJJH0Wk0E3pZEummL/3uZeM9ieDl3tYUqxpYL2ZVOqr4nRqAE
	 tvhlweYgaY5yXc+hpVGVN2U3k6cBwCQeYgYUGrpD6WkagJZO/ZPv69kh/TrThfiw93
	 dswZKTI/pyRE6JxRKOToSWKg4PXwe4oOhhIOuPFELLh0429JTk6gL6qhOmPrOcMX3l
	 fxW8qyqfqpbBQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:03 +0100
Subject: [PATCH 16/79] block: rust: allow specifying home node when
 constructing `TagSet`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-16-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2776; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=3w4qnZwh2+aU+MMv2rWpFqX4lbRY4HhOYDulfwtiM5M=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgq/QYUe8bZ2utIQqjhHTdAHO+CoJMp7AuDq
 tKoe/uOJg6JAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYKgAKCRDhuBo+eShj
 d07ND/9tv906O8JV5IQLXSRDJsUM5zCW6KhC6KwqGSY4R86jRB+711HKXUg03JJQDCLhm5B1odN
 g5QNE1tI6Keo/Rlim+cgJ4C0MTNOFejGDuccLgjBur1v1qbhRtouw6LvcJhG8troiQXNaLo95Sh
 N4YJ1E0nvmwmxrrI/LnQZNCgwmyEzkipgRoWL3ii5hAa6JVBiuZFlheUXC9yUId42wJVfQrbyPG
 YcbY0u8K1j+ejkox7kq83opF2JANf984yHH5OC3PxPRrdXygZKUqKIKRG3Y7Z9MKfC11FHSzfXD
 bltiQQFd0bBP81hoCG2rNMg3gbY95zq8MxhhGVpndJA8yI6K0KkwuJv2Jp6lsrVOyLkBoJs24/4
 8BFVbkxpRuoQv6ll/Bx+0XCfRq/COAOYxmIX60aqJ2M8q38PqYxCIB65sUizUlj2PN/+QCruQwR
 HInNKE7a+lLXj8GN7lo3X2z+jCyhoz1bebAowt6EWF6qWXD/n52dwMSpc2WBW2IMC53VYLHNopE
 xH2efg0tHDD8dX8CtvqT6ryGyT6oLFHGZB0OE2bnCSQuiS3iAJe0g/akikOI/b3ae1yLKsx99aL
 B5mslJIRkZyXSkcCXEy36iRF+6W26ki8gRLBy37mk0RcC39eLJZ4qPtzM8027gJ4xsyoEe5tHyT
 T5x6R19UphlS3XQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a `numa_node` parameter to `TagSet::new` to specify the home NUMA
node for tag set allocations. This allows drivers to optimize memory
placement for NUMA systems.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs    | 5 ++++-
 rust/kernel/block/mq.rs         | 5 ++++-
 rust/kernel/block/mq/tag_set.rs | 3 ++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 990dfcf95c9de..278f75d886fd9 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -176,7 +176,10 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             mq::tag_set::Flags::default()
         };
 
-        let tagset = Arc::pin_init(TagSet::new(submit_queues, 256, 1, flags), GFP_KERNEL)?;
+        let tagset = Arc::pin_init(
+            TagSet::new(submit_queues, 256, 1, bindings::NUMA_NO_NODE, flags),
+            GFP_KERNEL,
+        )?;
 
         let queue_data = Box::pin_init(
             pin_init!(QueueData {
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 76e790cdb1f8f..d3957f2fb1a66 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -57,6 +57,7 @@
 //!
 //! ```rust
 //! use kernel::{
+//!     bindings,
 //!     block::mq::{self, *},
 //!     new_mutex,
 //!     prelude::*,
@@ -92,7 +93,9 @@
 //! }
 //!
 //! let tagset: Arc<TagSet<MyBlkDevice>> =
-//!     Arc::pin_init(TagSet::new(1, 256, 1, mq::tag_set::Flags::default()), GFP_KERNEL)?;
+//!     Arc::pin_init(
+//!         TagSet::new(1, 256, 1, bindings::NUMA_NO_NODE, mq::tag_set::Flags::default()),
+//!         GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
 //!     .build(fmt!("myblk"), tagset, ())?;
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index af214f7dd0c10..e9b36d6329b9b 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -41,6 +41,7 @@ pub fn new(
         nr_hw_queues: u32,
         num_tags: u32,
         num_maps: u32,
+        numa_node: i32,
         flags: Flags,
     ) -> impl PinInit<Self, error::Error> {
         // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
@@ -53,7 +54,7 @@ pub fn new(
                     ops: OperationsVTable::<T>::build(),
                     nr_hw_queues,
                     timeout: 0, // 0 means default which is 30Hz in C
-                    numa_node: bindings::NUMA_NO_NODE,
+                    numa_node,
                     queue_depth: num_tags,
                     cmd_size,
                     flags: flags.into_inner(),

-- 
2.51.2


