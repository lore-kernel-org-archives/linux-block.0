Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83082E7F3A;
	Sun, 15 Feb 2026 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199031; cv=none; b=mTtmOl3ZMwawjQlrFZQDpbxEi9VfzrhD/PPWlJhd3FC9WQNhtPZD5j3LxSpyqYhlvZOS+oIvElZtjh6Eu254baGzmVAA0m60ugdyw2BdnvHosI2x9ze3bMbn5JC4gTstyx6Hbks3hTIqgQ4iwQf+6gx4yffSDnFAFdng4J3l2Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199031; c=relaxed/simple;
	bh=kRUjCKtoTGv3hT8Dyq+/AHzdexRsLl9w4VNxmn7tYGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P3xo2Ci2So+/Ck6krUTJMkzZgPspeGFtZJXWHDLMNbKhUPfxE6RVz6NixKpZwG4XOTWMCkjzFeKDPMBr2Fh0qOKr9Uc+JstpIfmJ89RAZKhp9vPAtj2tNSdO0QOyyDuh6QQ930hfc2GaNtNEZxuMBr2ITXrWwkrCpODl725s4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLiFV3Ln; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLiFV3Ln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F166C4CEF7;
	Sun, 15 Feb 2026 23:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199031;
	bh=kRUjCKtoTGv3hT8Dyq+/AHzdexRsLl9w4VNxmn7tYGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nLiFV3Ln/kAwVQ7jgAzUZt+QYD+bmIuFMsT+Yi1JtwFIAC4Lujy/4vUBPaUqsLg44
	 Pz5kKMHGBj4HSoM6TCWWWgcdWSlyV5siE4mMwFGwsawfIDi81j2DYEZsrE4SOW8Rdl
	 ppe7QzEeYHDnYcB99OkjNje7ruTXucVP2m+fbLKPcU+O1vOp7vsr6oUador9TD7ti0
	 bGP/7zKouCcCjV2LzilOwSYablNh8SiboQY5agiYoMXvp6KeR3QEY9vwL3IB3Z+zdb
	 LhX4QTTScID+Yo4Mu7zeL6I5tphcET+DJqzX7jvoaMwa5mj37bI/TCLaThjyrKluyT
	 WIWP+70m+b0Yg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:15 +0100
Subject: [PATCH 28/79] block: rnull: add partial I/O support for bad blocks
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-28-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10153;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=kRUjCKtoTGv3hT8Dyq+/AHzdexRsLl9w4VNxmn7tYGw=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg1reIhnxlHbTm+/U8X/ib+aOTFikBpNjyXx
 0q1mGQ6z6OJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYNQAKCRDhuBo+eShj
 dyK7EADGq2Yc0ZJAzDtZeBoR2EMzSt3mLhli34HJVUPQzCDsXSWLN9by/tgnavK/GIhYiLm8NbT
 TKEb3gE133xHSC+rJ9eBZPLMuDl3FAzvZo3Kr+jQNmHa9aBIccULynHVxfQMJyfAdtmK/fOLZV1
 MAcvY4iXxSDezJhmY8n3wYlux5RCjMpMgdrZonAnYinWmQ7OOaUMJQwtC5cI0JX1dOHpq5BIBLB
 6pDyObhtaC2k/70xjE5lg1t3BCNvGRMZYqOXpe7nqXgE5ad6XaMZd8ForSAMIUauJAS1gSwLH9a
 QxI59iQ8+X+Q4lFVcPdtr5orNUyY73x4nI7enf9Gj4pFU61AOahn49yDt79J7RHIWoQJsVdznAc
 waWHA973pU0gBLE7xefFVSKEpoPU7SHPdbtHFsIr/Jsyl3HtL/5D5ki3IxdkRFWg9muENuhF9La
 jkeWWtmv8ea992mOpNlsQJUdMW2J5TPSPNowJs3nbfDcSUnUJL6r5cMPymG9nAMHp0yZAvW5Vu3
 ByHMgLf3Jy1AxQZUloIQkxT10ERnBQiH3mvaDxhPrAynoJcLvRYtMHDdlWNerehpg8UR8gwGs3i
 pSz2BsirisJm7OvQrguGyGuM8GJTpPXGYTQAZh+jR/aaSwYaV1HpZ2M/20xcW+6rJSe+T6BBpnB
 hIlDtcIOxv/pL7Q==
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
 drivers/block/rnull/configfs.rs |  32 ++--------
 drivers/block/rnull/rnull.rs    | 125 ++++++++++++++++++++++++++++------------
 2 files changed, 95 insertions(+), 62 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index a39691b39e374..c08a3cbd66f18 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -104,6 +104,7 @@ fn make_group(
                 no_sched:11,
                 badblocks: 12,
                 badblocks_once: 13,
+                badblocks_partial_io: 14,
             ],
         };
 
@@ -128,6 +129,7 @@ fn make_group(
                     no_sched: false,
                     bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                     bad_blocks_once: false,
+                    bad_blocks_partial_io: false,
                 }),
             }),
             core::iter::empty(),
@@ -189,6 +191,7 @@ struct DeviceConfigInner {
     no_sched: bool,
     bad_blocks: Arc<BadBlocks>,
     bad_blocks_once: bool,
+    bad_blocks_partial_io: bool,
 }
 
 #[vtable]
@@ -226,6 +229,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 no_sched: guard.no_sched,
                 bad_blocks: guard.bad_blocks.clone(),
                 bad_blocks_once: guard.bad_blocks_once,
+                bad_blocks_partial_io: guard.bad_blocks_partial_io,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -427,29 +431,5 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
     }
 }
 
-#[vtable]
-impl configfs::AttributeOperations<13> for DeviceConfig {
-    type Data = DeviceConfig;
-
-    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
-        let mut writer = kernel::str::Formatter::new(page);
-
-        if this.data.lock().bad_blocks_once {
-            writer.write_str("1\n")?;
-        } else {
-            writer.write_str("0\n")?;
-        }
-
-        Ok(writer.bytes_written())
-    }
-
-    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
-            return Err(EBUSY);
-        }
-
-        this.data.lock().bad_blocks_once = kstrtobool_bytes(page)?;
-
-        Ok(())
-    }
-}
+configfs_simple_bool_field!(DeviceConfig, 13, bad_blocks_once);
+configfs_simple_bool_field!(DeviceConfig, 14, bad_blocks_partial_io);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0f569c5b65f77..6691e5912c5c9 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -162,6 +162,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     no_sched: *module_parameters::no_sched.value() != 0,
                     bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                     bad_blocks_once: false,
+                    bad_blocks_partial_io: false,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -190,6 +191,7 @@ struct NullBlkOptions<'a> {
     no_sched: bool,
     bad_blocks: Arc<BadBlocks>,
     bad_blocks_once: bool,
+    bad_blocks_partial_io: bool,
 }
 struct NullBlkDevice;
 
@@ -209,6 +211,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             no_sched,
             bad_blocks,
             bad_blocks_once,
+            bad_blocks_partial_io,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -239,6 +242,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
                 block_size: block_size.into(),
                 bad_blocks,
                 bad_blocks_once,
+                bad_blocks_partial_io,
             }),
             GFP_KERNEL,
         )?;
@@ -327,16 +331,62 @@ fn discard(tree: &Tree, mut sector: u64, sectors: u64, block_size: u64) -> Resul
     }
 
     #[inline(never)]
-    fn transfer(
-        command: bindings::req_op,
-        tree: &Tree,
-        sector: u64,
-        segment: Segment<'_>,
+    fn transfer(rq: &mut Owned<mq::Request<Self>>, tree: &Tree, sectors: u32) -> Result {
+        let mut sector = rq.sector();
+        let end_sector = sector + <u32 as Into<u64>>::into(sectors);
+        let command = rq.command();
+
+        for bio in rq.bio_iter_mut() {
+            let segment_iter = bio.segment_iter();
+            for segment in segment_iter {
+                // Length might be limited by bad blocks.
+                let length = segment
+                    .len()
+                    .min((sector - end_sector) as u32 >> SECTOR_SHIFT);
+                match command {
+                    bindings::req_op_REQ_OP_WRITE => Self::write(tree, sector, segment)?,
+                    bindings::req_op_REQ_OP_READ => Self::read(tree, sector, segment)?,
+                    _ => (),
+                }
+                sector += u64::from(length) >> SECTOR_SHIFT;
+
+                if sector >= end_sector {
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
     ) -> Result {
-        match command {
-            bindings::req_op_REQ_OP_WRITE => Self::write(tree, sector, segment)?,
-            bindings::req_op_REQ_OP_READ => Self::read(tree, sector, segment)?,
-            _ => (),
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
@@ -398,6 +448,7 @@ struct QueueData {
     block_size: u64,
     bad_blocks: Arc<BadBlocks>,
     bad_blocks_once: bool,
+    bad_blocks_partial_io: bool,
 }
 
 #[pin_data]
@@ -426,6 +477,30 @@ impl HasHrTimer<Self> for Pdu {
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
@@ -444,39 +519,17 @@ fn queue_rq(
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


