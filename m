Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D84D8DB1;
	Tue,  9 Jun 2026 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032625; cv=none; b=FkEJE6lQSeMZCFuMP07B5I97LbAFKSpDRauJ8J7feMTFN8Iw10kOTFpnmi/WjsmVl4d04gw2mNzXLirgdc7ShqfazFkcCttVZ890LaxeBMPzADLHCxJR/E4RDY3ChZbyhOu02KyzfvOg9w/J81g8gQrQvSv1MjpqNQYw5faXoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032625; c=relaxed/simple;
	bh=v0XQhwyOc620vsCHIPz3I6cOTlfWRB5GqFO9hLn8R5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1fOtyFsvv/U+cwcIW6tFu2ffiSWIRAr19q0VodBmyolh3CJ6/3sFQGKX5Qm+5zWT3zz4fSuD3Y+eiKVKXvZJ3q8j6jpjfyqTjCRGvJyHHmxXrS3Bk0KBZyXOZXIJVGihsEiBWQWVaCvepgLXqIJ6BgB0xOCuvGoS1yv2Nfh4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln4G1iif; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln4G1iif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387E71F0089A;
	Tue,  9 Jun 2026 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032623;
	bh=umeS9rSQGXG+kg9FrmoD3TXShidPIQhNP8+xWx74Hs8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ln4G1iifeGEWneCXz36TrX17jEw24VQfjkiYMflm5rTiRv+zy/knoxB8xHHVS5WE2
	 NHACg8+KORXckGrd+3swtQYGvjFt/Bun0rrRKsvOCwuLZ9vcsyn9SP8+f2zIQK+i14
	 gRL9NebxrpbEKYpduWvdDoEX4tayxg/lX5D5p55PgwFfsQabdy47tBoHDSLf12UFbY
	 SEfSN/O9lj/CTOlCQdRTxYgbzJYxIXcTnp9zV6MR9LyFJTYskw2lo3Hm3DmWxkG+fw
	 NvdaVeMUaefgcNsgT0DVQ60raX2nPJ0LhBGjHCM9V3nMt8FDGPJ1wWxlBraQ6HEkBD
	 0mKxdmgJ00z4A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:05 +0200
Subject: [PATCH v2 26/83] block: rust: change sector type from usize to u64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-26-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8857; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=v0XQhwyOc620vsCHIPz3I6cOTlfWRB5GqFO9hLn8R5k=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTMD0m8HIb02rdULtOHdHfQabhQNf3AvX2lP
 d4k2ie8Ml6JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkzAAKCRD6UCkIqsW9
 0DoXEACElQZIRs2ATiX3r5JUC1LZWpwkeycYVxgmZiH95ILTB6Vo8aNShxNEGxNIX6iLJyN8g3e
 /7+Zy/eDbFG0rdcuAmp4g2zxNhdMCkniFPEx4HueAgAsD5ODQdTD8gD7/+kSz4s7s8SopZEsq3j
 GDkOd0as0fJqfOscklxZ5+IzLMt1r+G4Ir/RMFzV/0c67wWdXDJQOF764/vzGab5ptBGvNpSiyk
 KTog832s4Sb5kVjc0fCU3W2JbZyvmYteFCxX/qdWFkHmNsAdmOMzBtS+Da3ka8yRck0BSlmOiC8
 sEpN364gTrW4uPxZNnUXGGHQ4z87EDUXbzIjikzmNqj9MwVEHBvqHD5EU6y4RLXpa4RohOR3oTc
 34UmtfhVsp/a2UgjKCkSyQNt8vlpC1Guh+Pj3/Hse6EnO/ZPudSgZuoaRLCiXQGcJ5im+ChuUbK
 Lv4kup8LjfrA6C0HIBuWQDQ7j+8RK0oSqu/lcH8g7ToP3yY9gNvOYUsEJwyANWdaY/QfwwMR/Af
 qYHmqO11qROCmvxB64tjPfaKuq8zsG9WWPKZdKnR0VWMNtAIztfuwXraXOQ8MmSllcaRTJ6dcxA
 JgyOpET+kgIEnvZfEK6vWb9G0iPTYsTfB3mXk3oreP58i5jXbXltXyJfMLRsMHq+oDaD+HedqIi
 xAa6WY4KstRaB2w==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Change the `sector()` and `sectors()` methods in `Request` to return
`u64` and `u32` respectively instead of `usize`. This matches the
underlying kernel types.

Update rnull driver to handle the new sector types with appropriate
casting throughout the read, write, and discard operations.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs    | 71 +++++++++++++++++++++++++----------------
 rust/kernel/block/mq/request.rs |  8 ++---
 2 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index cb5b642f68e5..73f14d6e379f 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -218,6 +218,13 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             kernel::alloc::NumaNode::new(home_node)?
         };
 
+        let capacity_sectors = capacity_mib << (20 - block::SECTOR_SHIFT);
+
+        // Prevent overflow in usize/u64 casts
+        if usize::BITS == 32 && capacity_sectors > u32::MAX.into() {
+            return Err(code::EINVAL);
+        }
+
         let tagset = Arc::pin_init(
             TagSet::new(submit_queues, 256, 1, numa_node, flags),
             GFP_KERNEL,
@@ -229,13 +236,13 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
                 irq_mode,
                 completion_time,
                 memory_backed,
-                block_size: block_size as usize,
+                block_size: block_size.into(),
             }),
             GFP_KERNEL,
         )?;
 
         let mut builder = gen_disk::GenDiskBuilder::new()
-            .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT))
+            .capacity_sectors(capacity_sectors)
             .logical_block_size(block_size)?
             .physical_block_size(block_size)?
             .rotational(rotational);
@@ -250,12 +257,13 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
     }
 
     #[inline(always)]
-    fn write(tree: &XArray<TreeNode>, mut sector: usize, mut segment: Segment<'_>) -> Result {
+    fn write(tree: &XArray<TreeNode>, mut sector: u64, mut segment: Segment<'_>) -> Result {
         while !segment.is_empty() {
             let page = NullBlockPage::new()?;
             let mut tree = tree.lock();
 
-            let page_idx = sector >> block::PAGE_SECTORS_SHIFT;
+            // CAST: Device size limited during setup to (2^32)-1 on 32 bit systems.
+            let page_idx = (sector >> block::PAGE_SECTORS_SHIFT) as usize;
 
             let page = if let Some(page) = tree.get_mut(page_idx) {
                 page
@@ -265,43 +273,50 @@ fn write(tree: &XArray<TreeNode>, mut sector: usize, mut segment: Segment<'_>) -
             };
 
             page.set_occupied(sector);
-            let page_offset = (sector & block::PAGE_SECTOR_MASK as usize) << block::SECTOR_SHIFT;
-            sector +=
-                segment.copy_to_page(page.page.as_pin_mut(), page_offset) >> block::SECTOR_SHIFT;
+
+            // CAST: Page offset always fits in 32 bits.
+            let page_offset =
+                ((sector & u64::from(block::PAGE_SECTOR_MASK)) << block::SECTOR_SHIFT) as usize;
+
+            // CAST: Casting from `usize` to `u64` never overflows.
+            sector += segment.copy_to_page(page.page.as_pin_mut(), page_offset) as u64
+                >> block::SECTOR_SHIFT;
         }
         Ok(())
     }
 
     #[inline(always)]
-    fn read(tree: &XArray<TreeNode>, mut sector: usize, mut segment: Segment<'_>) -> Result {
+    fn read(tree: &XArray<TreeNode>, mut sector: u64, mut segment: Segment<'_>) -> Result {
         let tree = tree.lock();
 
         while !segment.is_empty() {
-            let idx = sector >> block::PAGE_SECTORS_SHIFT;
+            // CAST: Device size limited during setup to (2^32)-1 on 32 bit systems.
+            let page_idx = (sector >> block::PAGE_SECTORS_SHIFT) as usize;
 
-            if let Some(page) = tree.get(idx) {
+            if let Some(page) = tree.get(page_idx) {
+                // CAST: Page offset always fits in 32 bits.
                 let page_offset =
-                    (sector & block::PAGE_SECTOR_MASK as usize) << block::SECTOR_SHIFT;
-                sector += segment.copy_from_page(&page.page, page_offset) >> block::SECTOR_SHIFT;
+                    ((sector & u64::from(block::PAGE_SECTOR_MASK)) << block::SECTOR_SHIFT) as usize;
+
+                // CAST: Casting from `usize` to `u64` never overflows.
+                sector +=
+                    segment.copy_from_page(&page.page, page_offset) as u64 >> block::SECTOR_SHIFT;
             } else {
-                sector += segment.zero_page() >> block::SECTOR_SHIFT;
+                // CAST: Casting from `usize` to `u64` never overflows.
+                sector += segment.zero_page() as u64 >> block::SECTOR_SHIFT;
             }
         }
 
         Ok(())
     }
 
-    fn discard(
-        tree: &XArray<TreeNode>,
-        mut sector: usize,
-        sectors: usize,
-        block_size: usize,
-    ) -> Result {
+    fn discard(tree: &XArray<TreeNode>, mut sector: u64, sectors: u64, block_size: u64) -> Result {
         let mut remaining_bytes = sectors << SECTOR_SHIFT;
         let mut tree = tree.lock();
 
         while remaining_bytes > 0 {
-            let page_idx = sector >> block::PAGE_SECTORS_SHIFT;
+            // CAST: Device size limited during setup to (2^32)-1 on 32 bit systems.
+            let page_idx = (sector >> block::PAGE_SECTORS_SHIFT) as usize;
             let mut remove = false;
             if let Some(page) = tree.get_mut(page_idx) {
                 page.set_free(sector);
@@ -326,7 +341,7 @@ fn discard(
     fn transfer(
         command: bindings::req_op,
         tree: &XArray<TreeNode>,
-        sector: usize,
+        sector: u64,
         segment: Segment<'_>,
     ) -> Result {
         match command {
@@ -356,13 +371,13 @@ fn new() -> Result<KBox<Self>> {
         )?)
     }
 
-    fn set_occupied(&mut self, sector: usize) {
-        let idx = sector & PAGE_SECTOR_MASK as usize;
+    fn set_occupied(&mut self, sector: u64) {
+        let idx = sector & u64::from(PAGE_SECTOR_MASK);
         self.status |= 1 << idx;
     }
 
-    fn set_free(&mut self, sector: usize) {
-        let idx = sector & PAGE_SECTOR_MASK as usize;
+    fn set_free(&mut self, sector: u64) {
+        let idx = sector & u64::from(PAGE_SECTOR_MASK);
         self.status &= !(1 << idx);
     }
 
@@ -380,7 +395,7 @@ struct QueueData {
     irq_mode: IRQMode,
     completion_time: Delta,
     memory_backed: bool,
-    block_size: usize,
+    block_size: u64,
 }
 
 #[pin_data]
@@ -432,14 +447,14 @@ fn queue_rq(
             let mut sector = rq.sector();
 
             if command == bindings::req_op_REQ_OP_DISCARD {
-                Self::discard(tree, sector, rq.sectors(), queue_data.block_size)?;
+                Self::discard(tree, sector, rq.sectors().into(), queue_data.block_size)?;
             } else {
                 for bio in rq.bio_iter_mut() {
                     let segment_iter = bio.segment_iter();
                     for segment in segment_iter {
                         let length = segment.len();
                         Self::transfer(command, tree, sector, segment)?;
-                        sector += length as usize >> block::SECTOR_SHIFT;
+                        sector += u64::from(length) >> block::SECTOR_SHIFT;
                     }
                 }
             }
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 54fe580b7b42..9e176f015ab8 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -178,16 +178,16 @@ pub fn bio_iter_mut<'a>(self: &'a mut Owned<Self>) -> BioIterator<'a> {
 
     /// Get the target sector for the request.
     #[inline(always)]
-    pub fn sector(&self) -> usize {
+    pub fn sector(&self) -> u64 {
         // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
-        unsafe { (*self.0.get()).__sector as usize }
+        unsafe { (*self.0.get()).__sector }
     }
 
     /// Get the size of the request in number of sectors.
     #[inline(always)]
-    pub fn sectors(&self) -> usize {
+    pub fn sectors(&self) -> u32 {
         // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
-        (unsafe { (*self.0.get()).__data_len as usize }) >> crate::block::SECTOR_SHIFT
+        (unsafe { (*self.0.get()).__data_len }) >> crate::block::SECTOR_SHIFT
     }
 
     /// Return a pointer to the [`RequestDataWrapper`] stored in the private area

-- 
2.51.2


