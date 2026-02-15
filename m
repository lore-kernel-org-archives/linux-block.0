Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343B62E7F08;
	Sun, 15 Feb 2026 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199166; cv=none; b=rjUABgVl8xkTMl9XjVhUseHQeyjgxktrS7gq00gNQLQlfifZ7/54LahoiktFhjYdKRF7tdEosB6lB3XcwYcvxU9mPDP1GgL0kk7/EKLGz2U7ani9fs/St5VMDcBTooO15REpgpROJ0D05tFMPpnDcJ+5wX2RZ1zix6cMFbXFBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199166; c=relaxed/simple;
	bh=d7t58iATi7q3gu1CIeU43zy0p2OHAVGfrGhGT4Ou8wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6zzJTRLvOOsVAiV4dMakQs019jEX2CmnNoh0f2dfL6Hr0wB/bjHIN0VAl18yJN3WPSJwb9zzUFEvZ8YrXeX2bkiXkeA6D+0tDTU7vEfo5ClzpUvyKF0SI7RkBIFKZEZWjj2mtqkA6vJKKenK1CztQO7oW4n1ZfjmA6OPuK3O3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNs6Vzaa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNs6Vzaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E2AC4CEF7;
	Sun, 15 Feb 2026 23:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199165;
	bh=d7t58iATi7q3gu1CIeU43zy0p2OHAVGfrGhGT4Ou8wc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QNs6VzaaFLyKJhPXIQdsggC53pnifRgZLsxpkhFb6o286GjvGptAscqI/NtLH4UYr
	 GHHIL0PB8AEJlm67qADR7pm/UBa7E0bZzBoUNgOqp4xbvzqwsuxhz71wZZNsTjkzEv
	 qZjhXahjBCpB/FpSb0UQ6MzlZlxn4sp2JXCs0HfuCB/DzujSn3grK08XZuukB3Aa3M
	 jQH5oO1urrpJ8uljWOOpTS4v1DGLqpvDOqOZJ9DGyFILQpbihqdtGRIJDzNYtuPYOz
	 HDZqZdm8rooc8Rn+WGJA5t8O24GN3LBZTW+ZuCPrTEN8gjmzETH6w4bNwK05GEFX9C
	 qqrAm6/aciFBQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:10 +0100
Subject: [PATCH 23/79] block: rust: change sector type from usize to u64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-23-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7730; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=d7t58iATi7q3gu1CIeU43zy0p2OHAVGfrGhGT4Ou8wc=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgwpp8ZG5eDYSzUchwIhxResrdcGVcsXmZyl
 g7CFHdwpJmJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYMAAKCRDhuBo+eShj
 dxV/D/kBcn108tJZUmshMYdi+NPSO3TZh9Irp94K2/f4Qe38WzevDLs2Aru5wDcx8XvSPqD3LeM
 uo18tQAhdWdBSigEK4JNxHJD8Bt5v/b8/9YnvxODXyMENZPx+mAY0YrDK8lM9/I7jHNgKqTAqGQ
 nsT2nJLfAYDtLhsZQ5SCxOZqtSF7KNCgYZkeuV5Bfk9kUIWIy8xeNVXyHlNvMjktBXNDpMHmpni
 mJZrAZonvjhSEaxiKJh6EYphfIptIDQUzKk/6scxinpgUaK+fvQPcoajU86eTPNtZU89htVKkIx
 9pQ/YBWCI3tI2r4ESji3ikU8uMgMZzmtGgxBWg85GsMHEi4J5cB8vo1s9bfa5a54Hg/37Ck8jL0
 V0lPA+79zKDGxaPs2ncIF+D5Bfk2uZxS+UqMTwf1QIEwfIzpUOnGGEVrTaq7n+p/XKvO7O6Jg9D
 UMnR2toQqstUM1xH79NAOukAp9569AqZuiFEtDONgJwVBzeA6/NoYp3YMHgIJ/cj+2x9Hg5lupa
 OBYvCYQeaRmbkHvFNJMMiMAWxcB/zL+Wcg4M3MsqW2bTApybWA5+mNHwxt6Z1ZGLAVsYyF/G1iv
 LZE0+bKDZTUws8BP8Ks2D7QhClalfiwAT9M0jDRaQm8+sZ6kBMyWpJ3YVCPS+CTjQi8xRvLaAh8
 +X0suhCT07dImyg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Change the `sector()` and `sectors()` methods in `Request` to return
`u64` and `u32` respectively instead of `usize`. This matches the
underlying kernel types.

Update rnull driver to handle the new sector types with appropriate
casting throughout the read, write, and discard operations.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs    | 49 +++++++++++++++++++++--------------------
 rust/kernel/block/mq/request.rs |  8 +++----
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 9a301b06fc5e0..b0008e2f9c398 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -225,7 +225,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
                 irq_mode,
                 completion_time,
                 memory_backed,
-                block_size: block_size as usize,
+                block_size: block_size.into(),
             }),
             GFP_KERNEL,
         )?;
@@ -246,54 +246,55 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
     }
 
     #[inline(always)]
-    fn write(tree: &Tree, mut sector: usize, mut segment: Segment<'_>) -> Result {
+    fn write(tree: &Tree, mut sector: u64, mut segment: Segment<'_>) -> Result {
         while !segment.is_empty() {
             let page = NullBlockPage::new()?;
             let mut tree = tree.lock();
 
             let page_idx = sector >> block::PAGE_SECTORS_SHIFT;
 
-            let page = if let Some(page) = tree.get_mut(page_idx) {
+            let page = if let Some(page) = tree.get_mut(page_idx as usize) {
                 page
             } else {
-                tree.store(page_idx, page, GFP_NOIO)?;
-                tree.get_mut(page_idx).unwrap()
+                tree.store(page_idx as usize, page, GFP_NOIO)?;
+                tree.get_mut(page_idx as usize).unwrap()
             };
 
             page.set_occupied(sector);
-            let page_offset = (sector & block::SECTOR_MASK as usize) << block::SECTOR_SHIFT;
-            sector +=
-                segment.copy_to_page(page.page.get_pin_mut(), page_offset) >> block::SECTOR_SHIFT;
+            let page_offset = (sector & u64::from(block::SECTOR_MASK)) << block::SECTOR_SHIFT;
+            sector += segment.copy_to_page(page.page.get_pin_mut(), page_offset as usize) as u64
+                >> block::SECTOR_SHIFT;
         }
         Ok(())
     }
 
     #[inline(always)]
-    fn read(tree: &Tree, mut sector: usize, mut segment: Segment<'_>) -> Result {
+    fn read(tree: &Tree, mut sector: u64, mut segment: Segment<'_>) -> Result {
         let tree = tree.lock();
 
         while !segment.is_empty() {
             let idx = sector >> block::PAGE_SECTORS_SHIFT;
 
-            if let Some(page) = tree.get(idx) {
-                let page_offset = (sector & block::SECTOR_MASK as usize) << block::SECTOR_SHIFT;
-                sector += segment.copy_from_page(&page.page, page_offset) >> block::SECTOR_SHIFT;
+            if let Some(page) = tree.get(idx as usize) {
+                let page_offset = (sector & u64::from(block::SECTOR_MASK)) << block::SECTOR_SHIFT;
+                sector += segment.copy_from_page(&page.page, page_offset as usize) as u64
+                    >> block::SECTOR_SHIFT;
             } else {
-                sector += segment.zero_page() >> block::SECTOR_SHIFT;
+                sector += segment.zero_page() as u64 >> block::SECTOR_SHIFT;
             }
         }
 
         Ok(())
     }
 
-    fn discard(tree: &Tree, mut sector: usize, sectors: usize, block_size: usize) -> Result {
+    fn discard(tree: &Tree, mut sector: u64, sectors: u64, block_size: u64) -> Result {
         let mut remaining_bytes = sectors << SECTOR_SHIFT;
         let mut tree = tree.lock();
 
         while remaining_bytes > 0 {
             let page_idx = sector >> block::PAGE_SECTORS_SHIFT;
             let mut remove = false;
-            if let Some(page) = tree.get_mut(page_idx) {
+            if let Some(page) = tree.get_mut(page_idx as usize) {
                 page.set_free(sector);
                 if page.is_empty() {
                     remove = true;
@@ -301,7 +302,7 @@ fn discard(tree: &Tree, mut sector: usize, sectors: usize, block_size: usize) ->
             }
 
             if remove {
-                drop(tree.remove(page_idx))
+                drop(tree.remove(page_idx as usize))
             }
 
             let processed = remaining_bytes.min(block_size);
@@ -316,7 +317,7 @@ fn discard(tree: &Tree, mut sector: usize, sectors: usize, block_size: usize) ->
     fn transfer(
         command: bindings::req_op,
         tree: &Tree,
-        sector: usize,
+        sector: u64,
         segment: Segment<'_>,
     ) -> Result {
         match command {
@@ -346,13 +347,13 @@ fn new() -> Result<KBox<Self>> {
         )?)
     }
 
-    fn set_occupied(&mut self, sector: usize) {
-        let idx = sector & SECTOR_MASK as usize;
+    fn set_occupied(&mut self, sector: u64) {
+        let idx = sector & u64::from(SECTOR_MASK);
         self.status |= 1 << idx;
     }
 
-    fn set_free(&mut self, sector: usize) {
-        let idx = sector & SECTOR_MASK as usize;
+    fn set_free(&mut self, sector: u64) {
+        let idx = sector & u64::from(SECTOR_MASK);
         self.status &= !(1 << idx);
     }
 
@@ -371,7 +372,7 @@ struct QueueData {
     irq_mode: IRQMode,
     completion_time: Delta,
     memory_backed: bool,
-    block_size: usize,
+    block_size: u64,
 }
 
 #[pin_data]
@@ -422,14 +423,14 @@ fn queue_rq(
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
index 9d11ae5651983..8fe7e126c522a 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -139,16 +139,16 @@ pub fn bio_iter_mut<'a>(self: &'a mut Owned<Self>) -> BioIterator<'a> {
 
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


