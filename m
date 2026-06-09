Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B9418AA5;
	Tue,  9 Jun 2026 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032589; cv=none; b=QuTmkE6MrCabK0i7FX4mBZ4T2NHEaT+MW/XpwVV6k91i3k1Kpx7/x3Zt2YvFOwb8M5WmBJDO0J8pQYmPzNDGXGJ43tvYXX34LqkRee/iQjaITfI2UgLA2jD7krWdfdfrfFLeUllFVgnEXe/GDpdhudyCLIslB0TCK8yNsBJFjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032589; c=relaxed/simple;
	bh=HRywcrCiLmX+1/nAPCLYKHPcnwsmzxh2+t1mg8Q6G+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVSx/a4FbB4kfGdd7ZH5kd6c9AWh/bnrng/vdvO8lybrSWioLMrId+tQ/bt3S9Pu/CMf9IJbFxvuROa5xLmqud4oRLRp5VhNR4lP20n5Gt2Zup+tLP0A29PZzqoMZO6kVw04pyF6St4o/xoF4debwol0HyXWm7uWTFNToBjkk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFDwz+8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFDwz+8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFB51F00893;
	Tue,  9 Jun 2026 19:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032587;
	bh=yzcaFz5Bg8WRjLkioMq8mphYDCXE2WyS5ZdwN19/ASA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XFDwz+8aG2tLl+iFwjOAOOHYcBryvvwr+IFisaQlHPfpRsG5dNB3iLsviMhu53KN9
	 NdYVfD70bTu+OG/owt1ThMpL8FgtCNSDbbuEdWmUq77hs8fKz2QzvskaH34YmtW6L8
	 CVe1yI1Kw0+az0cwWcIIpdcsfVemT3GUih9bEI8up6owif0+7w9mf3yxgODnRm1yHz
	 kjhkr/3VjszDPcFlj/DT8FVT7n319hcT4AcINP8xSqDlZiZs03cA8NHuB4zFbG4xX4
	 WH18+FMYpPdqqp6mF5e4CUdKpRvGLD58Nep2SP2hzDQDWXoI0szanzSxFxp38S+ylU
	 TfVsNQNdVwtEw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:06 +0200
Subject: [PATCH v2 27/83] block: rust: add `BadBlocks` for bad block
 tracking
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-27-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=30818;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=HRywcrCiLmX+1/nAPCLYKHPcnwsmzxh2+t1mg8Q6G+4=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTNs3/+5XGtdPDnxKPbZiO56hmUsKptMikhD
 qmcUMw6YlOJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkzQAKCRD6UCkIqsW9
 0LoSD/9ALSkvxB75gCzTGawPodKBjAfK+bzqj+DY8fSrlUepgNjmJz3IAbMY8MTF0wHhObGzqPm
 K3Co6lZwdOxjF2Us5M3kJtAcB5BLjy9UPF24F6hVaE81VoyAUQ5EkvaQBi5P+qbaUptY6w8+lOo
 QqUFkwl0sNfQF3n9DEZdUqG2kbpYWgbZKJclDQ/O7geo1H7d42Ejnav3PZqxulSA6eKUpifQSFL
 s+afvPXHVqji/yVS6V6/Rlqx+1pF0BJOxlIJZ9PhqVHfSY52LgKGvBjoTnyJthQEzkRloFbZFvD
 wwJD4IhWSoK5l6bcPN8m3j3PVj2lfLf9Ds4EoLz9ejgnb7b8aW3EG+3rUFtdd4HgIxQkSt6zd3P
 ZFbzCzSeyVl1Ls6cIPp12LPp3BU/RTT7Kts9ByXOawE8m72SMxr7aNz64Sybha2nyxH0Eo4lsoC
 pC0DrznNoILcB0swdoMPe6jXn1wtA2PnKBQ8y6YqwjakY1Gaiw/41fMKz6xfEC4ot/Bl6Bvfn2X
 /WWqXtNyp7hCeiwtRrQcR73m0QB21dwRhuUgkCKHbQG7unjx0C53ig3dl8hSr9O5XSY8aTyg2l2
 lC/fmtY8p/Kd6gwlSv8P2AM4T9S24g2xeNY4ELlQASJUcpIfBCLQNy9WU7lDpJ39amc/NeVE+iM
 7i/I01/K4LUJM5A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a safe Rust wrapper around the Linux kernel's badblocks infrastructure
to track and manage defective sectors on block devices. The BadBlocks type
provides methods to:

- Mark sectors as bad or good (set_bad/set_good)
- Check if sector ranges contain bad blocks (check)
- Automatically handle memory management with PinnedDrop

The implementation includes comprehensive documentation with examples for
block device drivers that need to avoid known bad sectors to maintain
data integrity. Bad blocks information is used by device drivers,
filesystem layers, and device management tools.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/block.rs            |   1 +
 rust/kernel/block/badblocks.rs  | 716 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 718 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index b1fb3afee4ca..eaf05d60dda9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -38,6 +38,7 @@
 #include <drm/drm_ioctl.h>
 #include <kunit/test.h>
 #include <linux/auxiliary_bus.h>
+#include <linux/badblocks.h>
 #include <linux/bitmap.h>
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index eb512dad031b..96e48a2e6116 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -2,6 +2,7 @@
 
 //! Types for working with the block layer.
 
+pub mod badblocks;
 pub mod bio;
 pub mod mq;
 
diff --git a/rust/kernel/block/badblocks.rs b/rust/kernel/block/badblocks.rs
new file mode 100644
index 000000000000..0aab661ed7be
--- /dev/null
+++ b/rust/kernel/block/badblocks.rs
@@ -0,0 +1,716 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bad blocks tracking for block devices.
+//!
+//! This module provides a safe Rust wrapper around the badblocks
+//! infrastructure, which is used to track and manage bad sectors on block
+//! devices. Bad blocks are sectors that cannot reliably store data and should
+//! be avoided during I/O operations.
+//!
+//! C header: [`include/linux/fault-inject.h`](srctree/include/linux/fault-inject.h).
+
+use core::ops::{
+    Range,
+    RangeBounds, //
+};
+
+use crate::{
+    error::to_result,
+    page::PAGE_SIZE,
+    prelude::*,
+    sync::atomic::{
+        ordering,
+        Atomic, //
+    },
+    types::Opaque,
+};
+use pin_init::{
+    pin_data,
+    PinInit, //
+};
+
+/// A bad blocks tracker for managing defective sectors on a block device.
+///
+/// `BadBlocks` provides functionality to mark sectors as bad and check if
+/// ranges contain bad blocks. This is useful for some classes of drivers to
+/// maintain data integrity by avoiding known bad sectors.
+///
+/// # Storage Format
+///
+/// Bad blocks are stored in a compact format where each 64-bit entry contains:
+/// - **Sector offset** (54 bits): Starting sector of the bad range
+/// - **Length** (9 bits): Number of sectors (1-512) in the bad range
+/// - **Acknowledged flag** (1 bit): Whether the bad blocks have been acknowledged
+///
+/// The bad blocks tracker uses exactly one page ([`PAGE_SIZE`]) of memory to store
+/// bad block entries. This allows tracking up to `PAGE_SIZE/8` bad block ranges
+/// (typically 512 ranges on systems with 4KB pages).
+///
+/// # Locking
+///
+/// Operations on the structure is internally synchronized by a seqlock.
+///
+/// # Examples
+///
+/// Basic usage:
+///
+/// ```rust
+/// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+/// # use kernel::prelude::*;
+/// // Create a new bad blocks tracker
+/// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+///
+/// // Mark sectors 100-109 as bad (unacknowledged)
+/// bad_blocks.set_bad(100..110, false)?;
+///
+/// // Check if sector range 95-104 contains bad blocks
+/// match bad_blocks.check(95..105) {
+///     BlockStatus::None => pr_info!("No bad blocks found"),
+///     BlockStatus::Acknowledged(range) => pr_warn!("Acknowledged bad blocks: {:?}", range),
+///     BlockStatus::Unacknowledged(range) => pr_err!("Unacknowledged bad blocks: {:?}", range),
+/// }
+/// # Ok::<(), kernel::error::Error>(())
+/// ```
+/// # Invariants
+///
+/// - `self.blocks` is a valid `bindings::badblocks` struct.
+#[pin_data(PinnedDrop)]
+pub struct BadBlocks {
+    #[pin]
+    blocks: Opaque<bindings::badblocks>,
+}
+
+impl BadBlocks {
+    /// Creates a new bad blocks tracker.
+    ///
+    /// Initializes an empty bad blocks tracker that can manage defective sectors
+    /// on a block device. The tracker starts with no bad blocks recorded and
+    /// allocates a single page for storing bad block entries.
+    ///
+    /// # Returns
+    ///
+    /// Returns a [`PinInit`] that can be used to initialize a [`BadBlocks`] instance.
+    /// Initialization may fail with `ENOMEM` if memory allocation fails.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+    /// # use kernel::prelude::*;
+    /// // Create and initialize a bad blocks tracker
+    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+    ///
+    /// // The tracker is ready to use with no bad blocks initially
+    /// match bad_blocks.check(0..100) {
+    ///     BlockStatus::None => pr_info!("No bad blocks found initially"),
+    ///     _ => unreachable!(),
+    /// }
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    pub fn new(enable: bool) -> impl PinInit<Self, Error> {
+        // INVARIANT: We initialize `self.blocks` below. If initialization fails, an error is
+        // returned.
+        try_pin_init!(Self {
+            blocks <- Opaque::try_ffi_init(|slot| {
+                // SAFETY: `slot` is a valid pointer to uninitialized memory
+                // allocated by the Opaque type. `badblocks_init` is safe to
+                // call with uninitialized memory.
+                to_result(unsafe { bindings::badblocks_init(slot, enable.into()) })
+            }),
+        })
+    }
+
+    fn shift_ref(&self) -> &Atomic<c_int> {
+        // SAFETY: By type invariant self.blocks is valid.
+        let ptr = unsafe { &raw const (*self.blocks.get()).shift };
+        // SAFETY: `shift` is only written by C code using atomic operations after initialization.
+        unsafe { Atomic::from_ptr(ptr.cast_mut().cast()) }
+    }
+
+    /// Enables the bad blocks tracker if it was previously disabled.
+    ///
+    /// Attempts to enable bad block tracking by transitioning the tracker from
+    /// a disabled state to an enabled state.
+    ///
+    /// # Behavior
+    ///
+    /// - If the tracker is disabled, it will be enabled.
+    /// - If the tracker is already enabled, this operation has no effect.
+    /// - The operation is atomic and thread-safe.
+    ///
+    /// # Usage
+    ///
+    /// Bad blocks trackers can be created in a disabled state and enabled later
+    /// when needed. This is useful for conditional bad block tracking or for
+    /// deferring activation until the device is fully initialized.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::BadBlocks;
+    /// # use kernel::prelude::*;
+    /// // Create a disabled bad blocks tracker
+    /// let bad_blocks = KBox::pin_init(BadBlocks::new(false), GFP_KERNEL)?;
+    /// assert!(!bad_blocks.enabled());
+    ///
+    /// // Enable it when needed
+    /// bad_blocks.enable();
+    /// assert!(bad_blocks.enabled());
+    ///
+    /// // Subsequent enable calls have no effect
+    /// bad_blocks.enable();
+    /// assert!(bad_blocks.enabled());
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    pub fn enable(&self) {
+        let _ = self.shift_ref().cmpxchg(-1, 0, ordering::Relaxed);
+    }
+
+    /// Checks whether the bad blocks tracker is currently enabled.
+    ///
+    /// Returns `true` if bad block tracking is active, `false` if it is disabled.
+    /// When disabled, the tracker will not perform bad block checks or operations.
+    ///
+    /// # Thread Safety
+    ///
+    /// This method is thread-safe and uses atomic operations to check the
+    /// tracker's state without requiring external synchronization.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::BadBlocks;
+    /// # use kernel::prelude::*;
+    /// // Create an enabled tracker
+    /// let enabled_tracker = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+    /// assert!(enabled_tracker.enabled());
+    ///
+    /// // Create a disabled tracker
+    /// let disabled_tracker = KBox::pin_init(BadBlocks::new(false), GFP_KERNEL)?;
+    /// assert!(!disabled_tracker.enabled());
+    ///
+    /// // Enable and verify
+    /// disabled_tracker.enable();
+    /// assert!(disabled_tracker.enabled());
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    pub fn enabled(&self) -> bool {
+        self.shift_ref().load(ordering::Relaxed) >= 0
+    }
+
+    /// Marks a range of sectors as bad.
+    ///
+    /// Records a contiguous range of sectors as defective in the bad blocks tracker.
+    /// Bad sectors should be avoided during I/O operations to prevent data corruption.
+    /// The implementation may merge, split, or extend existing ranges as needed.
+    ///
+    /// # Parameters
+    ///
+    /// - `range` - The range of sectors to mark as bad. Each individual range is limited to 512
+    ///   sectors maximum by the underlying implementation.
+    /// - `acknowledged` - Whether the bad blocks have been acknowledged to be bad. Acknowledged bad
+    ///   blocks may be handled differently by some subsystems.
+    ///
+    /// # Acknowledgment Semantics
+    ///
+    /// - **Unacknowledged** (`acknowledged = false`): Newly discovered bad blocks that
+    ///   need attention. These are often treated as errors by upper layers.
+    /// - **Acknowledged** (`acknowledged = true`): Blocks that have been confirmed bad. These may
+    ///   be should be handled by remapping.
+    ///
+    /// # Range Management
+    ///
+    /// The implementation automatically:
+    /// - **Merges** adjacent or overlapping ranges with the same acknowledgment status
+    /// - **Splits** ranges when acknowledgment status differs
+    /// - **Extends** existing ranges when new bad blocks are adjacent
+    /// - **Limits** individual ranges to 512 sectors maximum (BB_MAX_LEN)
+    ///
+    /// Please see [C documentation] for details.
+    ///
+    /// # Performance
+    ///
+    /// Executes in O(n) time where n is number of entries in the bad block table.
+    ///
+    /// # Returns
+    ///
+    /// * `Ok(())` - Bad blocks were successfully recorded
+    /// * `Err(ENOMEM)` - Insufficient space in bad blocks table (table full)
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+    /// # use kernel::prelude::*;
+    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+    ///
+    /// // Mark sectors 1000-1009 as bad (unacknowledged)
+    /// bad_blocks.set_bad(1000..1010, false)?;
+    ///
+    /// // Mark a single sector as bad and acknowledged
+    /// bad_blocks.set_bad(2000..2001, true)?;
+    ///
+    /// // Verify the bad blocks are recorded
+    /// assert!(matches!(bad_blocks.check(1000..1010), BlockStatus::Unacknowledged(_)));
+    /// assert!(matches!(bad_blocks.check(2000..2001), BlockStatus::Acknowledged(_)));
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    ///
+    /// Range merging behavior:
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+    /// # use kernel::prelude::*;
+    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+    ///
+    /// // Add adjacent ranges with same acknowledgment status
+    /// bad_blocks.set_bad(100..105, false)?;  // Sectors 100-104
+    /// bad_blocks.set_bad(105..108, false)?;  // Sectors 105-107
+    ///
+    /// // These will be merged into a single range 100-107
+    /// match bad_blocks.check(100..108) {
+    ///     BlockStatus::Unacknowledged(range) => {
+    ///         assert_eq!(range.start, 100);
+    ///         assert_eq!(range.end, 108);
+    ///     },
+    ///     _ => panic!("Expected unacknowledged bad blocks"),
+    /// }
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    ///
+    /// Handling acknowledgment conflicts:
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+    /// # use kernel::prelude::*;
+    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+    ///
+    /// // Mark range as unacknowledged
+    /// bad_blocks.set_bad(200..210, false)?;
+    ///
+    /// // Acknowledge part of the range (will split)
+    /// bad_blocks.set_bad(205..208, true)?;
+    ///
+    /// // Now we have: unack[200-204], ack[205-207], unack[208-209]
+    /// assert!(matches!(bad_blocks.check(200..205), BlockStatus::Unacknowledged(_)));
+    /// assert!(matches!(bad_blocks.check(205..208), BlockStatus::Acknowledged(_)));
+    /// assert!(matches!(bad_blocks.check(208..210), BlockStatus::Unacknowledged(_)));
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    ///
+    /// [C documentation]: srctree/block/badblocks.c
+    pub fn set_bad(&self, range: impl RangeBounds<u64>, acknowledged: bool) -> Result {
+        let range = Self::range(range);
+
+        // SAFETY: By type invariant `self.blocks` is valid. The C function
+        // `badblocks_set` handles synchronization internally.
+        let status = unsafe {
+            bindings::badblocks_set(
+                self.blocks.get(),
+                range.start,
+                range.end - range.start,
+                if acknowledged { 1 } else { 0 },
+            )
+        };
+
+        if status {
+            Ok(())
+        } else {
+            Err(ENOMEM)
+        }
+    }
+
+    /// Marks a range of sectors as good.
+    ///
+    /// Removes a contiguous range of sectors from the bad blocks tracker,
+    /// indicating that these sectors are now reliable for I/O operations.
+    /// This is typically used after bad sectors have been repaired, remapped,
+    /// or determined to be false positives.
+    ///
+    /// # Parameters
+    ///
+    /// - `range` - The range of sectors to mark as good.
+    ///
+    /// # Behavior
+    ///
+    /// The implementation handles various scenarios automatically:
+    /// - **Complete removal**: If the range exactly matches a bad block range, it's removed
+    ///   entirely.
+    /// - **Partial removal**: If the range partially overlaps, the bad block range is split or
+    ///   trimmed.
+    /// - **No effect**: If the range doesn't overlap any bad blocks, the operation succeeds without
+    ///   changes.
+    /// - **Range splitting**: If the cleared range is in the middle of a bad block range, it may
+    ///   split the range in two.
+    ///
+    /// # Performance
+    ///
+    /// Executes in O(n) time where n is the number of entries in the bad blocks table.
+    ///
+    /// # Returns
+    ///
+    /// * `Ok(())` - Sectors were successfully marked as good (or were already good)
+    /// * `Err(EINVAL)` - Operation failed (typically due to table constraints)
+    ///
+    /// # Examples
+    ///
+    /// Basic usage after repair:
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+    /// # use kernel::prelude::*;
+    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+    ///
+    /// // Mark some sectors as bad initially
+    /// bad_blocks.set_bad(100..110, false)?;
+    /// assert!(matches!(bad_blocks.check(100..110), BlockStatus::Unacknowledged(_)));
+    ///
+    /// // After successful repair, mark them as good
+    /// bad_blocks.set_good(100..110)?;
+    /// assert!(matches!(bad_blocks.check(100..110), BlockStatus::None));
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    ///
+    /// Partial clearing:
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+    /// # use kernel::prelude::*;
+    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+    ///
+    /// // Mark a large range as bad
+    /// bad_blocks.set_bad(200..220, false)?;
+    ///
+    /// // Clear only the middle portion
+    /// bad_blocks.set_good(205..215)?; // Clear sectors 205-214
+    ///
+    /// // Now we have bad blocks at the edges: 200-204 and 215-219
+    /// assert!(matches!(bad_blocks.check(200..205), BlockStatus::Unacknowledged(_)));
+    /// assert!(matches!(bad_blocks.check(205..215), BlockStatus::None));
+    /// assert!(matches!(bad_blocks.check(215..220), BlockStatus::Unacknowledged(_)));
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    ///
+    /// Safe clearing of potentially good sectors:
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+    /// # use kernel::prelude::*;
+    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+    ///
+    /// // It's safe to clear sectors that were never marked as bad
+    /// bad_blocks.set_good(1000..1100)?; // No-op, but succeeds
+    /// assert!(matches!(bad_blocks.check(1000..1100), BlockStatus::None));
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    pub fn set_good(&self, range: impl RangeBounds<u64>) -> Result {
+        let range = Self::range(range);
+        // SAFETY: By type invariant `self.blocks` is valid. The C function
+        // `badblocks_clear` handles synchronization internally.
+        unsafe {
+            bindings::badblocks_clear(self.blocks.get(), range.start, range.end - range.start)
+        }
+        .then_some(())
+        .ok_or(EINVAL)
+    }
+
+    // Transform a `RangeBounds` to start included end excluded range.
+    fn range(range: impl RangeBounds<u64>) -> Range<u64> {
+        let start = match range.start_bound() {
+            core::ops::Bound::Included(start) => *start,
+            core::ops::Bound::Excluded(start) => start + 1,
+            core::ops::Bound::Unbounded => u64::MIN,
+        };
+
+        let end = match range.end_bound() {
+            core::ops::Bound::Included(end) => end + 1,
+            core::ops::Bound::Excluded(end) => *end,
+            core::ops::Bound::Unbounded => u64::MAX,
+        };
+
+        start..end
+    }
+
+    /// Checks if a range of sectors contains any bad blocks.
+    ///
+    /// Examines the specified sector range to determine if it contains any sectors
+    /// that have been marked as bad. This is typically called before performing I/O
+    /// operations to avoid accessing defective sectors. The check uses seqlocks to
+    /// ensure consistent reads even under concurrent modifications.
+    ///
+    /// # Parameters
+    ///
+    /// - `range` - The range of sectors to check (supports any type implementing
+    ///   `RangeBounds<u64>`).
+    ///
+    /// # Returns
+    ///
+    /// Returns a [`BlockStatus`] indicating the state of the checked range:
+    ///
+    /// - `BlockStatus::None` - No bad blocks found in the specified range.
+    /// - `BlockStatus::Acknowledged(range)` - Contains acknowledged bad blocks.
+    /// - `BlockStatus::Unacknowledged(range)` - Contains unacknowledged bad blocks.
+    ///
+    /// The returned range indicates the **first bad block range** encountered that
+    /// overlaps with the checked area. If multiple separate bad ranges exist, only
+    /// the first is reported.
+    ///
+    /// # Performance
+    ///
+    /// The check operation uses binary search on the sorted bad blocks table,
+    /// providing O(log n) lookup time where n is the number of bad block ranges.
+    ///
+    /// # Examples
+    ///
+    /// Basic checking:
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+    /// # use kernel::prelude::*;
+    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+    ///
+    /// // Initially no bad blocks
+    /// assert!(matches!(bad_blocks.check(0..1000), BlockStatus::None));
+    ///
+    /// // Mark some sectors as bad
+    /// bad_blocks.set_bad(100..110, false)?;
+    ///
+    /// // Check various ranges
+    /// match bad_blocks.check(90..120) {
+    ///     BlockStatus::Unacknowledged(range) => {
+    ///         assert_eq!(range.start, 100);
+    ///         assert_eq!(range.end, 110);
+    ///         pr_warn!("Found unacknowledged bad blocks: {}-{}", range.start, range.end - 1);
+    ///     },
+    ///     _ => panic!("Expected bad blocks"),
+    /// }
+    ///
+    /// // Check range that doesn't overlap
+    /// assert!(matches!(bad_blocks.check(0..50), BlockStatus::None));
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    ///
+    /// Handling different acknowledgment states:
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+    /// # use kernel::prelude::*;
+    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+    ///
+    /// // Add both acknowledged and unacknowledged bad blocks
+    /// bad_blocks.set_bad(100..105, true)?;   // Acknowledged
+    /// bad_blocks.set_bad(200..205, false)?;  // Unacknowledged
+    ///
+    /// match bad_blocks.check(95..105) {
+    ///     BlockStatus::Acknowledged(range) => {
+    ///         pr_info!("Acknowledged bad blocks found, can potentially remap: {:?}", range);
+    ///         // Continue with remapping logic
+    ///     },
+    ///     BlockStatus::Unacknowledged(range) => {
+    ///         pr_err!("Unacknowledged bad blocks found, requires attention: {:?}", range);
+    ///         // Handle as error condition
+    ///     },
+    ///     BlockStatus::None => {
+    ///         // Safe to proceed with I/O
+    ///     },
+    /// }
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    ///
+    /// Safe I/O operation pattern:
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+    /// # use kernel::prelude::*;
+    /// # use core::ops::RangeBounds;
+    /// # fn perform_sector_read(range: impl RangeBounds<u64>) -> Result<()> { Ok(()) }
+    /// fn safe_read_sectors(
+    ///     bad_blocks: &BadBlocks,
+    ///     range: impl RangeBounds<u64> + Clone
+    /// ) -> Result<()> {
+    ///     // Check for bad blocks before attempting I/O
+    ///     match bad_blocks.check(range.clone()) {
+    ///         BlockStatus::None => {
+    ///             // Safe to proceed with I/O operation - convert range to
+    ///             // start/count for legacy function.
+    ///             perform_sector_read(range)
+    ///         },
+    ///         BlockStatus::Acknowledged(range) => {
+    ///             pr_warn!("I/O intersects acknowledged bad blocks: {:?}", range);
+    ///             // Potentially remap or skip bad sectors
+    ///             Err(EIO)
+    ///         },
+    ///         BlockStatus::Unacknowledged(range) => {
+    ///             pr_err!("I/O intersects unacknowledged bad blocks: {:?}", range);
+    ///             // Treat as serious error
+    ///             Err(EIO)
+    ///         },
+    ///     }
+    /// }
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    pub fn check(&self, range: impl RangeBounds<u64>) -> BlockStatus {
+        let mut first_bad = 0;
+        let mut bad_count = 0;
+        let range = Self::range(range);
+
+        // SAFETY: By type invariant `self.blocks` is valid. `first_bad` and
+        // `bad_count` are valid mutable references The C function
+        // `badblocks_check` handles synchronization internally.
+        let ret = unsafe {
+            bindings::badblocks_check(
+                self.blocks.get(),
+                range.start,
+                range.end - range.start,
+                &mut first_bad,
+                &mut bad_count,
+            )
+        };
+
+        match ret {
+            0 => BlockStatus::None,
+            1 => BlockStatus::Acknowledged(first_bad..first_bad + bad_count),
+            -1 => BlockStatus::Unacknowledged(first_bad..first_bad + bad_count),
+            _ => {
+                debug_assert!(false, "Illegal return value from `badblocks_check`");
+                BlockStatus::None
+            }
+        }
+    }
+
+    /// Formats bad blocks information into a human-readable string.
+    ///
+    /// Exports the current bad blocks table to a text representation suitable
+    /// for display via sysfs. The output format shows each bad block range
+    /// with sector numbers and acknowledgment status.
+    ///
+    /// # Parameters
+    ///
+    /// - `page` - A page-sized buffer to write the formatted output into.
+    /// - `show_unacknowledged` - Whether to include unacknowledged bad blocks in output.
+    ///   - `true`: Shows both acknowledged and unacknowledged bad blocks
+    ///   - `false`: Shows only acknowledged bad blocks
+    ///
+    /// # Output Format
+    ///
+    /// The output consists of space-separated entries, each representing a bad block range:
+    /// - Format: `start_sector length [acknowledgment_status]`
+    /// - Acknowledged blocks: Just sector and length (e.g., "100 10")
+    /// - Unacknowledged blocks: Sector, length, and "u" suffix (e.g., "200 5 u")
+    ///
+    /// # Returns
+    ///
+    /// Returns the number of bytes written to the buffer, or a negative value on error.
+    /// The returned length can be used to extract the valid portion of the buffer.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```rust
+    /// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+    /// # use kernel::prelude::*;
+    /// # use kernel::page::PAGE_SIZE;
+    /// let bad_blocks = KBox::pin_init(BadBlocks::new(true), GFP_KERNEL)?;
+    /// let mut page = [0u8; PAGE_SIZE];
+    ///
+    /// // Add some bad blocks
+    /// bad_blocks.set_bad(100..110, true)?;   // Acknowledged
+    /// bad_blocks.set_bad(200..205, false)?;   // Unacknowledged
+    ///
+    /// // Show all bad blocks (including unacknowledged)
+    /// let len = bad_blocks.show(&mut page, true);
+    /// if len > 0 {
+    ///     let output = core::str::from_utf8(&page[..len as usize]).unwrap_or("<invalid utf8>");
+    ///     pr_info!("Bad blocks: {}", output);
+    ///     // Output might be: "100 10 200 5 u"
+    /// }
+    /// # Ok::<(), kernel::error::Error>(())
+    /// ```
+    pub fn show(&self, page: &mut [u8; PAGE_SIZE], show_unacknowledged: bool) -> isize {
+        // SAFETY: By type invariant `self.blocks` is valid. The C function
+        // `badblocks_show` handles synchronization internally.
+        // `page.as_mut_ptr()` returns a valid pointer to a PAGE_SIZE buffer.
+        // The C function will not write beyond the provided buffer size.
+        unsafe {
+            bindings::badblocks_show(
+                self.blocks.get(),
+                page.as_mut_ptr(),
+                if show_unacknowledged { 1 } else { 0 },
+            )
+        }
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for BadBlocks {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: We do not move out of `self` before it is dropped.
+        let this = unsafe { self.get_unchecked_mut() };
+        // SAFETY: By type invariant `this.blocks` is valid. `badblocks_exit` is
+        // safe to call during destruction and will properly clean up allocated
+        // resources.
+        unsafe { bindings::badblocks_exit(this.blocks.get()) };
+    }
+}
+
+// SAFETY: `BadBlocks` can be safely dropped from other threads.
+unsafe impl Send for BadBlocks {}
+
+// SAFETY: All `BadBlocks` methods use internal synchronization.
+unsafe impl Sync for BadBlocks {}
+
+/// Status of a sector range after checking for bad blocks.
+///
+/// This enum represents the result of checking a sector range against the bad blocks
+/// table. It distinguishes between ranges with no bad blocks, ranges with acknowledged
+/// bad blocks, and ranges with unacknowledged bad blocks.
+///
+/// # Examples
+///
+/// ```rust
+/// # use kernel::block::badblocks::{BadBlocks, BlockStatus};
+/// # use kernel::prelude::*;
+/// # use core::ops::{Range, RangeBounds};
+/// # fn perform_io(range: impl RangeBounds<u64>) -> Result<()> { Ok(()) }
+/// # fn remap_and_retry(io_range: impl RangeBounds<u64>, bad_range: Range<u64>)
+/// #     -> Result<()> { Ok(()) }
+/// fn handle_io_request(bad_blocks: &BadBlocks, range: impl RangeBounds<u64> + Clone)
+///   -> Result<()>
+/// {
+///     match bad_blocks.check(range.clone()) {
+///         BlockStatus::None => {
+///             // Safe to proceed with I/O - convert range to start/count for legacy function
+///             perform_io(range)
+///         },
+///         BlockStatus::Acknowledged(bad_range) => {
+///             pr_warn!("I/O overlaps acknowledged bad blocks: {:?}", bad_range);
+///             // Attempt remapping or alternative strategy
+///             remap_and_retry(range, bad_range)
+///         },
+///         BlockStatus::Unacknowledged(bad_range) => {
+///             pr_err!("I/O overlaps unacknowledged bad blocks: {:?}", bad_range);
+///             // Treat as serious error
+///             Err(EIO)
+///         },
+///     }
+/// }
+/// # Ok::<(), kernel::error::Error>(())
+/// ```
+#[derive(Debug, Clone, PartialEq, Eq)]
+pub enum BlockStatus {
+    /// No bad blocks found in the checked range.
+    None,
+    /// The range contains acknowledged bad blocks.
+    ///
+    /// The contained range represents the first bad block
+    /// range encountered.
+    Acknowledged(Range<u64>),
+    /// The range contains unacknowledged bad blocks that need attention.
+    ///
+    /// The contained range represents the boundaries of the first bad block
+    /// range encountered.
+    Unacknowledged(Range<u64>),
+}

-- 
2.51.2


