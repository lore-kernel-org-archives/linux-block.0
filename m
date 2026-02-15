Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533B530F533;
	Sun, 15 Feb 2026 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199096; cv=none; b=tNUaFVzN9Ki7kwV7OQNcc5eTW5UItNwZXXEKQ1h21hqi9/jT47tYISCYn2WsS1fOdHwu6i9KV52q8luuwY2jeJir2dSsIWK1x37/Gw1/muBuM+M0VRzpKFYuxfJFy9NRtAZqhVHWtaP1nb1Gqx5cpD3kq7BEyiRGjXBWSpkmMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199096; c=relaxed/simple;
	bh=Px3eI2zDMAVJLYyUnOivw8WZDG9ekgsY8W3TNggTDzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9YyHaBdZv1F8hDbPmrro7C0rwT+LGH4r6X4zqCoGp7Gsabx82jLXdb6wuQezlkuNXHKLe+QA1OOUfJXGCY+IAvnGI+uSuhzEL6NKktKWetqCV/Q6vZEz1/No85QOjUr+WEnzBZLFvIwogbCj2ZZtcT0dpP39aWPhgbuXKNrzZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh34cizW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh34cizW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8BAC4CEF7;
	Sun, 15 Feb 2026 23:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199096;
	bh=Px3eI2zDMAVJLYyUnOivw8WZDG9ekgsY8W3TNggTDzU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lh34cizW7d/gBLwSVeE4ys9vsfLxOpCx97lcyLN9wxX6puurpKIPB60ex0e5s2pek
	 YjX/ebbARJzLTG04MyEdPzMVV8Tgdw/dwPJGNal7y41AdpZ3PKjDvhcvhYMpTW0jkd
	 DNsXPxviMaBGEAsG/BzwPx7ZU5gUJR3UAZJxbJ9AW4wL4eL80+fsb0zBRIe6sprGiM
	 xnOJvxKjn+0I1dbfo5ntcXOhQvoEJVqfjDFDMFMoa+mzPsu78A9Plf5iKkq/s6Wl5C
	 sPHH3+IahusncPzCzzai6AmDK4+YLxoY0evmg5qON45mmAfw6IklPFobLgFDXdrtou
	 JOvITASMzTdng==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:34:59 +0100
Subject: [PATCH 12/79] block: rust: add `TagSet` flags
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-12-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4410; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Px3eI2zDMAVJLYyUnOivw8WZDG9ekgsY8W3TNggTDzU=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgmG/fV80AH9+jNFOPrjKBYXkqkQyBHVCZEq
 oBbsCPTrhOJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYJgAKCRDhuBo+eShj
 dy2UD/4oSy3vFK2Ftcro2uRPRmoKZLNWf32I0hhmtmP678KPwSICk/IrlxiYYhnymniK9BKQa5d
 5KcVEYOR1sET2O5Yl1YQ3LBgLxVdRTQck6w98SZBT5b14hXnnSDh7re/DfJMArLV+BYyzFYSdpu
 bVk3syb0ZLc9gMOdL+rNBTIYRFI/7O/LRceo3pTAanFs33idABcN2sTUhQE80/hS8KPUX822thb
 9rws+ncn3h0w6/xkR0jpPS30yjl9Cx3cjezlE3esWeVTVL6edNP4U9ohZSgS6VgTbrLxUdpse3i
 TOMvfF/K0ggKh1dZWgXkkGFTGUuTfCZUp4TY2HcLzJmZClMwf/zY6A1KwHRlkT/NaqhtZv2A1t0
 fA6HP6ysJx5YDnRpAtBNk0x0W0FpJzAmO2Jcvz9vWqbbQhVITHwUt/ghW3H4h8izrNl3tK17zYu
 LrEBWs0SgTmbXo1RLsY3+ylr9iT31SuEx1DcNL5ty/FR5C9Nq5kUkCvKkmnFxasoAJDtv7yd6n5
 lyL0SHlB0pJ87F6LAfBz15p7x0EJCK6FAs3aVO4/6dcrLKlaFFrySaEcuOP9+GASye/21wQEbFY
 EKKUhH2/Lxv/5WJI9obMOKll1+CvHy+r2jq+fweRjr+Vd1MEFg3gIEwGhenEY9K1ze9p2pLCVOZ
 BLLMwQb1LMThPfw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for `TagSet` flags by introducing a `Flags` type and adding
a flags parameter to `TagSet::new`. This allows configuring tagset
behavior such as blocking vs non-blocking operation.

The Flags type supports bitwise operations and provides values like
`Blocking` for common use cases. The module documentation example is
updated to demonstrate the new API.

For now, only a single flag is added.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs          |  5 ++++-
 rust/kernel/block/mq.rs               |  6 +++---
 rust/kernel/block/mq/tag_set.rs       |  7 ++++++-
 rust/kernel/block/mq/tag_set/flags.rs | 19 +++++++++++++++++++
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 55e56c39f1c2c..33c1144550a0e 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -130,7 +130,10 @@ fn new(
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
index 884bf18abbba5..76e790cdb1f8f 100644
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
 pub use request::Request;
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index 46481754b1335..af214f7dd0c10 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -16,6 +16,10 @@
 use core::{convert::TryInto, marker::PhantomData};
 use pin_init::{pin_data, pinned_drop, PinInit};
 
+mod flags;
+pub use flags::Flag;
+pub use flags::Flags;
+
 /// A wrapper for the C `struct blk_mq_tag_set`.
 ///
 /// `struct blk_mq_tag_set` contains a `struct list_head` and so must be pinned.
@@ -37,6 +41,7 @@ pub fn new(
         nr_hw_queues: u32,
         num_tags: u32,
         num_maps: u32,
+        flags: Flags,
     ) -> impl PinInit<Self, error::Error> {
         // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
         // all are allowed to be 0.
@@ -51,7 +56,7 @@ pub fn new(
                     numa_node: bindings::NUMA_NO_NODE,
                     queue_depth: num_tags,
                     cmd_size,
-                    flags: 0,
+                    flags: flags.into_inner(),
                     driver_data: core::ptr::null_mut::<crate::ffi::c_void>(),
                     nr_maps: num_maps,
                     ..tag_set
diff --git a/rust/kernel/block/mq/tag_set/flags.rs b/rust/kernel/block/mq/tag_set/flags.rs
new file mode 100644
index 0000000000000..768db938b9a95
--- /dev/null
+++ b/rust/kernel/block/mq/tag_set/flags.rs
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::prelude::*;
+
+impl_flags! {
+
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


