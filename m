Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B44CA277;
	Tue,  9 Jun 2026 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032270; cv=none; b=lOJg2IwSFbJTSA9gFTUhjLl4XzlyISb7rhjF6Jp2c88nlIbOowNennbZIi45Fff2kt708Ahu44Uzcw5JH396TruALbHqiOp8rxZchMeLkpmgP44YRF/wXeAd1rlpg57I3AoMoEcq/687Fe0Toq/olFkpfXI9w5XiicP1doZqg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032270; c=relaxed/simple;
	bh=xV+OONEs9Ld1Dxqfh4dzHUhstJCVgf4f6VVBNqpaotw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FkgvRLIQ2KR3hUruGjjiq2OOswIdqxVTw5ypTc9OyKamk1w6wkC5mLrjzz3FU5GLKTqLMUoGIRWY0NcvtIM5i7TknJ3KIfiAY/bjuJWoMzVEKDCmC4eT+Ikog/2zFVMNx7GVj/hNmvvOJuh7O0v8GO8mQ4YS0/YHfEMdVf+UqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuQYPx1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuQYPx1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38621F00893;
	Tue,  9 Jun 2026 19:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032268;
	bh=zLr5CLPfIXCjUx/yqmdeB165LH9EbFQ5aO9LrGL70xQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nuQYPx1PsxsnailNXG1ho0LHPrMkIZkpy4NqAJ2mJ3oDsasqR+f+Y45zebfqY0SKo
	 3MZHGKSdBGXJHJaC+DeBrNboCdqknkVI2VtYFqa5/1F8lKDhRK9SSHb7vnjQPLm9ZI
	 slMrD5cqEHyaCYtkuX0B0UI0kTPXkx9zdJ+Jte5HDuJAT9pDi0+/h/fe245OGiCrwr
	 nCUOYC1bPBh06pwygqjUYtGx6SoQxz7aQvswDE14j3GXQ7pIXsqRr5tEOY/9BYtax+
	 Cgb5SmQGjitdFRQKJsjXVePlqLAOy46TMhPF5WWytp/ZpDTcS62f6aZ/bmRawL5OWA
	 hMLzNU/zYF+Bg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:11 +0200
Subject: [PATCH v2 32/83] block: rnull: add partial I/O support for bad
 blocks
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-32-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9670; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=xV+OONEs9Ld1Dxqfh4dzHUhstJCVgf4f6VVBNqpaotw=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTREVg3urPjuSLlm/682SoGEi1sYXPkiTpgi
 iPWSVRqemCJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk0QAKCRD6UCkIqsW9
 0AwsD/0fOiEtoWSB/RGdXRgEjP+HqCgBV+3fN5unUlchYeBh/g7LbqhGVP3GBg5VFh2/9a6BxFf
 lU8h9LrhpM3DGOiGdDsM+6VVEBxn48QZmHRuVVnJNeOvaSdKM/XHwAHI2xU/Nc5t1eZaPEOLPXN
 OYnbe17eArn7XEOIkEw4Bw3YO7oh1yt1dYEdmbj/W5iHO6CoBkT3n6VSVQGmjUIsTotQPBlCTSX
 buTVNuq1/GDiG2L3YpRRoT1FubfStQzxixG65DvAlCewwKPdpTS4HZZLZrMuvQ8gCaqYb++ljXy
 YHB1wwwDB3pClCLJcW+cPEl27Ipasuz+ICo3dS52yYrPHnONAQLMvcuhUWeEliK3Dn/lL+X27g9
 xQZc5skJdlXcQ9k1OFinMN/JHkag2jqgJVI+jAIsiejYnasdJ/62JsUeh8S1VNghrsuA6lU+wpQ
 uS7ZpI84EjkmYE1bP4jZVc02AsvF7DcVO/FPTHi6jvVeBKgj5CUOumYcklayr3q+heTzta2jWY3
 QL8PUpNTIerN/kAAyEZo7bSS8d7sIcvviYI3TE/+VnhuFn3f8+nS2XN7zP6YnVqI2L6ea/QaOib
 4DI6hyKdSw45yjWQCl9BnJ77bDSF0Z3mN6gAn3X8jftuYNdLuuz2Rdx0+fF1wpQs6zc076Filsj
 dBauCb+4T77Pa/Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add bad_blocks_partial_io configuration option that allows partial I/O
completion when encountering bad blocks, rather than failing the entire
request.

When enabled, requests are truncated to stop before the first bad block
range, allowing the valid portion to be processed successfully. This
improves compatibility with applications that can handle partial
reads/writes.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |   5 ++
 drivers/block/rnull/rnull.rs    | 126 +++++++++++++++++++++++++++++-----------
 2 files changed, 97 insertions(+), 34 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 05229ba9173a..0e9fe8cdc07f 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -103,6 +103,7 @@ fn make_group(
                 no_sched:11,
                 badblocks: 12,
                 badblocks_once: 13,
+                badblocks_partial_io: 14,
             ],
         };
 
@@ -127,6 +128,7 @@ fn make_group(
                     no_sched: false,
                     bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                     bad_blocks_once: false,
+                    bad_blocks_partial_io: false,
                 }),
             }),
             core::iter::empty(),
@@ -198,6 +200,7 @@ struct DeviceConfigInner {
     no_sched: bool,
     bad_blocks: Arc<BadBlocks>,
     bad_blocks_once: bool,
+    bad_blocks_partial_io: bool,
 }
 
 #[vtable]
@@ -235,6 +238,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 no_sched: guard.no_sched,
                 bad_blocks: guard.bad_blocks.clone(),
                 bad_blocks_once: guard.bad_blocks_once,
+                bad_blocks_partial_io: guard.bad_blocks_partial_io,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -389,3 +393,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 }
 
 configfs_simple_bool_field!(DeviceConfig, 13, bad_blocks_once);
+configfs_simple_bool_field!(DeviceConfig, 14, bad_blocks_partial_io);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 5486eb6dd921..be0b4bd25e53 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -160,6 +160,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     no_sched: module_parameters::no_sched.value(),
                     bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                     bad_blocks_once: false,
+                    bad_blocks_partial_io: false,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -188,6 +189,7 @@ struct NullBlkOptions<'a> {
     no_sched: bool,
     bad_blocks: Arc<BadBlocks>,
     bad_blocks_once: bool,
+    bad_blocks_partial_io: bool,
 }
 struct NullBlkDevice;
 
@@ -207,6 +209,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             no_sched,
             bad_blocks,
             bad_blocks_once,
+            bad_blocks_partial_io,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -250,6 +253,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
                 block_size: block_size.into(),
                 bad_blocks,
                 bad_blocks_once,
+                bad_blocks_partial_io,
             }),
             GFP_KERNEL,
         )?;
@@ -352,15 +356,66 @@ fn discard(tree: &XArray<TreeNode>, mut sector: u64, sectors: u64, block_size: u
 
     #[inline(never)]
     fn transfer(
-        command: bindings::req_op,
+        rq: &mut Owned<mq::Request<Self>>,
         tree: &XArray<TreeNode>,
-        sector: u64,
-        segment: Segment<'_>,
+        max_sectors: u32,
     ) -> Result {
-        match command {
-            bindings::req_op_REQ_OP_WRITE => Self::write(tree, sector, segment)?,
-            bindings::req_op_REQ_OP_READ => Self::read(tree, sector, segment)?,
-            _ => (),
+        let mut sector = rq.sector();
+        let max_end_sector = sector + <u32 as Into<u64>>::into(max_sectors);
+        let command = rq.command();
+
+        for bio in rq.bio_iter_mut() {
+            let segment_iter = bio.segment_iter();
+            for mut segment in segment_iter {
+                // Length might be limited by bad blocks.
+                let segment_length_sectors = segment.len() >> SECTOR_SHIFT;
+                let max_remaining_sectors = (max_end_sector - sector) as u32;
+                let length_sectors_allowed = segment_length_sectors.min(max_remaining_sectors);
+                segment.truncate(length_sectors_allowed << SECTOR_SHIFT);
+                match command {
+                    bindings::req_op_REQ_OP_WRITE => Self::write(tree, sector, segment)?,
+                    bindings::req_op_REQ_OP_READ => Self::read(tree, sector, segment)?,
+                    _ => (),
+                }
+                sector += u64::from(length_sectors_allowed);
+
+                if sector >= max_end_sector {
+                    return Ok(());
+                }
+            }
+        }
+        Ok(())
+    }
+
+    fn handle_bad_blocks(
+        rq: &mut Owned<mq::Request<Self>>,
+        queue_data: &QueueData,
+        sectors: &mut u32,
+    ) -> Result {
+        if queue_data.bad_blocks.enabled() {
+            let start = rq.sector();
+            let end = start + u64::from(*sectors);
+            match queue_data.bad_blocks.check(start..end) {
+                badblocks::BlockStatus::None => {}
+                badblocks::BlockStatus::Acknowledged(mut range)
+                | badblocks::BlockStatus::Unacknowledged(mut range) => {
+                    rq.data_ref().error.store(1, ordering::Relaxed);
+
+                    if queue_data.bad_blocks_once {
+                        queue_data.bad_blocks.set_good(range.clone())?;
+                    }
+
+                    if queue_data.bad_blocks_partial_io {
+                        let block_size_sectors = queue_data.block_size >> SECTOR_SHIFT;
+                        range.start = align_down(range.start, block_size_sectors);
+                        if start < range.start {
+                            *sectors = (range.start - start) as u32;
+                        }
+                    } else {
+                        *sectors = 0;
+                    }
+                }
+            };
         }
         Ok(())
     }
@@ -421,6 +476,7 @@ struct QueueData {
     block_size: u64,
     bad_blocks: Arc<BadBlocks>,
     bad_blocks_once: bool,
+    bad_blocks_partial_io: bool,
 }
 
 #[pin_data]
@@ -449,6 +505,30 @@ impl HasHrTimer<Self> for Pdu {
     }
 }
 
+fn is_power_of_two<T>(value: T) -> bool
+where
+    T: core::ops::Sub<T, Output = T>,
+    T: core::ops::BitAnd<Output = T>,
+    T: core::cmp::PartialOrd<T>,
+    T: Copy,
+    T: From<u8>,
+{
+    (value > 0u8.into()) && (value & (value - 1u8.into())) == 0u8.into()
+}
+
+fn align_down<T>(value: T, to: T) -> T
+where
+    T: core::ops::Sub<T, Output = T>,
+    T: core::ops::Not<Output = T>,
+    T: core::ops::BitAnd<Output = T>,
+    T: core::cmp::PartialOrd<T>,
+    T: Copy,
+    T: From<u8>,
+{
+    debug_assert!(is_power_of_two(to));
+    value & !(to - 1u8.into())
+}
+
 #[vtable]
 impl Operations for NullBlkDevice {
     type QueueData = Pin<KBox<QueueData>>;
@@ -467,40 +547,18 @@ fn queue_rq(
         mut rq: Owned<mq::Request<Self>>,
         _is_last: bool,
     ) -> Result {
-        if queue_data.bad_blocks.enabled() {
-            let start = rq.sector();
-            let end = start + u64::from(rq.sectors());
-            match queue_data.bad_blocks.check(start..end) {
-                badblocks::BlockStatus::None => {}
-                badblocks::BlockStatus::Acknowledged(range)
-                | badblocks::BlockStatus::Unacknowledged(range) => {
-                    rq.data_ref().error.store(1, ordering::Relaxed);
-                    if queue_data.bad_blocks_once {
-                        queue_data.bad_blocks.set_good(range)?;
-                    }
-                }
-            };
-        }
+        let mut sectors = rq.sectors();
 
-        // TODO: Skip IO if bad block.
+        Self::handle_bad_blocks(&mut rq, queue_data.get_ref(), &mut sectors)?;
 
         if queue_data.memory_backed {
             memalloc_scope!(let _noio: NoIo);
             let tree = &queue_data.tree;
-            let command = rq.command();
-            let mut sector = rq.sector();
 
-            if command == bindings::req_op_REQ_OP_DISCARD {
-                Self::discard(tree, sector, rq.sectors().into(), queue_data.block_size)?;
+            if rq.command() == bindings::req_op_REQ_OP_DISCARD {
+                Self::discard(tree, rq.sector(), sectors.into(), queue_data.block_size)?;
             } else {
-                for bio in rq.bio_iter_mut() {
-                    let segment_iter = bio.segment_iter();
-                    for segment in segment_iter {
-                        let length = segment.len();
-                        Self::transfer(command, tree, sector, segment)?;
-                        sector += u64::from(length) >> block::SECTOR_SHIFT;
-                    }
-                }
+                Self::transfer(&mut rq, tree, sectors)?;
             }
         }
 

-- 
2.51.2


