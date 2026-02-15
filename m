Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D010DEEC0;
	Sun, 15 Feb 2026 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198899; cv=none; b=rQPtRp0Xj/ySzZRlaYgx0zSePwHemPnm9d/NHvaBXsLRp7Sp9G7ReS/E/5Ph+Ybr8pTwk5gaTZfd7Qb19fXMkw50qhX0hRrRxBJnz34CY0nSj1FOsw/n760USF5ePoDfIY2RcPAo3PoMs0WJR2NJyTsBLQCbqUz0Ox8jL8jw2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198899; c=relaxed/simple;
	bh=D7D66X+gJAFczQNNgh5CL7i3hR5Izk7o4xJkF6qeolE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YizoMg+UtMMr2A2cp/XrAqbbkyLd8xGUNCyjgmQiPKZcAGaejHGrBDUIl0W0tZqEGNKhHCjDmCyWEOdMCXSeVf7QWjxQsWjFlQfVAAfX/R/oePJv9ZmmfhxZrdX8c086N/EpgJ0Dn8rjLdCw40dDOFmAToVkZ/g2X407zZoUyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiZ4uB0f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiZ4uB0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAE9C19422;
	Sun, 15 Feb 2026 23:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198899;
	bh=D7D66X+gJAFczQNNgh5CL7i3hR5Izk7o4xJkF6qeolE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UiZ4uB0ftkvcfsuyCpp2BCvenjYi5DGaspOgGnronBlOVcBlhMu3VmURoNZfYtac6
	 NiVhgllacLrufMvslVuIeJtia9BaGhvMckaBy1dQio2CVJkduOxjuE3e1T8E4Ta/f4
	 TRfsHSjnMU/MEQSjnHOJcXq5084eZ3b0clE7i1+35RFxHF5uz9mIa048JqptbMPHw3
	 4DT6C+6bjXQyEW30Mg5Lk+P+JPc652re0g//ypjmuHRJxOWNmXRHY8G8bHyGYyIWKB
	 2fdGqxMMxiolOCw+saPhkpaQ6eNcXg6+S0l9fEc4uncVsDSxrdk8gX2gR/ndqswy5v
	 7ez5UBte+KnjQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:16 +0100
Subject: [PATCH 29/79] block: rust: add `TagSet` private data support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-29-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5916; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=D7D66X+gJAFczQNNgh5CL7i3hR5Izk7o4xJkF6qeolE=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg2rFmUUi6LLaqQTrSP7Cjji5l3ptpVNJ3Mb
 1LLO0X1treJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYNgAKCRDhuBo+eShj
 d2x7EACrjvttPgu6cF9IkrYrF2Y2L7/35Z6wNExRAfCWDx4SrpD3/6Yne063iZ3oG/ih3R0obID
 qfp4ntGFuP3Z6/XfIV63okRkoTxcAw35XZg+kZuTy82328/rRgWZZsLUhCzPaTc3x2hU/06mgy3
 0qG/0aC23ua7hHWpnLQtJxqoAxLce8qX9KRb/3HrJtN74hV5ffluD6bcFTtBAkVMISJoXC+qefe
 29TQuTOpRbj0vQHXKZsbTXkj0XVdWfHd1cAfzpNRyi3rGkw+VDLDxYV5uDU0oJ/klMZAPCyF4FI
 V2MBB9AWE8449Mkh5qbEfw8/A68+Xd3rZ6a93K74icb2QnYf4g+aJm0GKvhgEwOz+Qe6LsD6ABe
 u5OgzcAomqzjOxMvd/MgqoW1bxnnupdUfdTyzSzujUjBKC1HVuBcRdupuN6PpW2VU6Vpa1ugb5y
 +65lOvPVgjVw2c6hEsZkSR1FULHvkbC714OwvUfo55pQolUV8vSt7Kjzl/TssRlXu8Wjkx7fx9Q
 WcxvPxxaSwcPexeGtoCF7BZ7F5Nh4FXQKCaReDSddZ3ioQTU8DNkmoeDzQ6CCGzJEeAfIRuUU2s
 mUD/Je4nqrrTVdvYB99b35nU+EQ/zBlzGjPcU26fzDxbCf3ozbpC/FKrL/PZsRtK9WQlOV4AZKi
 17jWogjukxsD0ZA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

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
 rust/kernel/block/mq/tag_set.rs    | 25 ++++++++++++++++++++-----
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 6691e5912c5c9..9e8d085924040 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -229,7 +229,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
         }
 
         let tagset = Arc::pin_init(
-            TagSet::new(submit_queues, 256, 1, home_node, flags),
+            TagSet::new(submit_queues, (), 256, 1, home_node, flags),
             GFP_KERNEL,
         )?;
 
@@ -505,6 +505,7 @@ fn align_down<T>(value: T, to: T) -> T
 impl Operations for NullBlkDevice {
     type QueueData = Pin<KBox<QueueData>>;
     type RequestData = Pdu;
+    type TagSetData = ();
 
     fn new_request_data() -> impl PinInit<Self::RequestData> {
         pin_init!(Pdu {
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index d3957f2fb1a66..415be31e9a777 100644
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
-//!         TagSet::new(1, 256, 1, bindings::NUMA_NO_NODE, mq::tag_set::Flags::default()),
-//!         GFP_KERNEL)?;
+//!         TagSet::new(1, (), 256, 1, bindings::NUMA_NO_NODE, mq::tag_set::Flags::default()),
+//!         GFP_KERNEL
+//!     )?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
 //!     .build(fmt!("myblk"), tagset, ())?;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index cd37b939bbf30..9aab6240428cc 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -44,6 +44,10 @@ pub trait Operations: Sized {
     /// the `GenDisk` associated with this `Operations` implementation.
     type QueueData: ForeignOwnable;
 
+    /// Data associated with a `TagSet`. This is stored as a pointer in `struct
+    /// blk_mq_tag_set`.
+    type TagSetData: ForeignOwnable;
+
     /// Called by the kernel to get an initializer for a `Pin<&mut RequestData>`.
     fn new_request_data() -> impl PinInit<Self::RequestData>;
 
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index e9b36d6329b9b..f18b51e5217fe 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -10,8 +10,8 @@
     bindings,
     block::mq::{operations::OperationsVTable, request::RequestDataWrapper, Operations},
     error::{self, Result},
-    prelude::try_pin_init,
-    types::Opaque,
+    try_pin_init,
+    types::{ForeignOwnable, Opaque},
 };
 use core::{convert::TryInto, marker::PhantomData};
 use pin_init::{pin_data, pinned_drop, PinInit};
@@ -39,6 +39,7 @@ impl<T: Operations> TagSet<T> {
     /// Try to create a new tag set
     pub fn new(
         nr_hw_queues: u32,
+        tagset_data: T::TagSetData,
         num_tags: u32,
         num_maps: u32,
         numa_node: i32,
@@ -58,7 +59,7 @@ pub fn new(
                     queue_depth: num_tags,
                     cmd_size,
                     flags: flags.into_inner(),
-                    driver_data: core::ptr::null_mut::<crate::ffi::c_void>(),
+                    driver_data: tagset_data.into_foreign(),
                     nr_maps: num_maps,
                     ..tag_set
                 }
@@ -71,7 +72,14 @@ pub fn new(
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
@@ -87,7 +95,14 @@ pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set {
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


