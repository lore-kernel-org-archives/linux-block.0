Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA34D4D2EDE;
	Tue,  9 Jun 2026 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032320; cv=none; b=bOrK8VJzW+mjeSNIXE0f/ZeEDms4UpVJEc1NSekNKKRj3huqWP6XcPU1VvVQuWZqkyGWjpmpdvQflJkEznavd2sxhU+uglJ9kM/nWjZb/nbr7IaafAf/9Q9AB63Cu9Hx/N3EQV36Pf+0OZiTQhYurNQRE23HA3sRnMK0cKlj0DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032320; c=relaxed/simple;
	bh=5tWrOfwAoTdtiugODrPJwqvRH5XTpwTVzL/RkoxFmKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4X/wvcMdLnhdJuMSkuUej6/SASkJdHMMaosgyx8ANo6mVmB0P/Jse3ZUHg9p4ygt29GlO/J5rjICEvFgrTPoNY9YD5tri5Rd+Ihr1xSSnuY367Gk6rxrIx8MhQQpislmjb8TUJc80jo+nutnsC2KCvux+3qMGhKRb2kRs5I6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbkJriII; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbkJriII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EE11F00898;
	Tue,  9 Jun 2026 19:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032318;
	bh=IkD0QE1JNG+5G4E9lQ6Nh6HgjvnmUhj4qhwVEK7b4Kw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HbkJriII3mozpClgOgi65m6h2a4N5QW7igQRqNhtcRg/1/9VCyekam92oxNs83Vv2
	 8ZvF5ZsjHQnVxNDCtEQdRGKyzgJ3/iPPhkHsDnJO+d61HEqeSOpIM+myPDxNVkTr+A
	 A5e2liydG4NK1SLts+w88+lMJ0AErM2/Q16rZP4xSQYJv0CKTs6i8cLvXKWT6uJYCR
	 eM5CSuk0AtUQk0qW2NMFSjq8VMNMyRNP/XsYZZKEME84eDwrVSf+OgloaEqROe8fah
	 gCpp5t3MPXJ+StljDASOVhFgkcGDd514WrNe5/cHXTO8/VK95jGEbXiwFKKzldxg/b
	 +92RzJ2tyv7ew==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:55 +0200
Subject: [PATCH v2 16/83] block: rnull: add memory backing
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-16-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9051; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=5tWrOfwAoTdtiugODrPJwqvRH5XTpwTVzL/RkoxFmKQ=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTDlpQLAb1Gdie0mQdmixKF/RmwXPiQ/Q1mE
 yviretqzF+JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkwwAKCRD6UCkIqsW9
 0E5BD/kBzAHZRaW7Q6j0G0U3xNqihtUwFAbCJwp+84ZCx2vnJuP6bH2v801ATOF/7Ik6Gips0mP
 +46GLnccPBOI5WabhrpnL2CZ2ZSDBbGUoOm2v2n8HsGRyh61KptIriN+blMlb9soc+VrzGNW1To
 g1B1kBaqYTeVEAPC8iJ5gYzcZTmEwNEIYkHEwT4DlU+OBQpA8/+2cMyJuWrIHXBKe3/z7LgcdnP
 VFkuPPsHkxklFDpZDCuCWYRH4wKwx4kn3XToD8jS7B4AFDlh4eDimVOzFOr33BnmbPceBK+zQon
 bBhjFJH4D6gbSmcZ/uCBYq1aPS4Vj3grlTBCX/KmBfBAY3+VJB5i4cuB/am8pIR+CF1J/8JbS6a
 SO10KADB1axzJrNZLOTOOKQpzRWNvqu7eFtAgdnxkeqaa4Wg4iyrJzvFJSSe1mDYzMYAj2WJOOj
 1uXy8L1k6bYhn16XKayO5bwak8fjQMHOpFUAj6HKxLIXMqRDx3emfaDqNTndTkKYQGaf+drMJh6
 xhn5HyA7xZdrkfBE5n/gQ9j37eojuawnQPcEiGQfIAWuBVX9aFgv/BT5u07a4pD+Z/CBrpOdpDr
 VTPbIr3B7RLh0Z/hJrmf31ZOEUxysfmNaWOSxYcaPC5gBdCXlYfbJjrWvId0h+DW6PVqkl9a0Pb
 cmr4YJ0LMImhP7w==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add memory backing to the rust null block driver. This implementation will
always allocate a page on write, even though a page backing the written
sector is already allocated, in which case the page will be released again.
A later patch will fix this inefficiency.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |   8 ++-
 drivers/block/rnull/rnull.rs    | 126 ++++++++++++++++++++++++++++++++++------
 2 files changed, 116 insertions(+), 18 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 83b474f6da60..8daf2ca409ba 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -60,7 +60,7 @@ impl AttributeOperations<0> for Config {
 
     fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         let mut writer = kernel::str::Formatter::new(page);
-        writer.write_str("blocksize,size,rotational,irqmode,completion_nsec\n")?;
+        writer.write_str("blocksize,size,rotational,irqmode,completion_nsec,memory_backed\n")?;
         Ok(writer.bytes_written())
     }
 }
@@ -84,6 +84,7 @@ fn make_group(
                 size: 3,
                 irqmode: 4,
                 completion_nsec: 5,
+                memory_backed: 6,
             ],
         };
 
@@ -101,6 +102,7 @@ fn make_group(
                     irq_mode: IRQMode::None,
                     completion_time: time::Delta::ZERO,
                     name: name.try_into()?,
+                    memory_backed: false,
                 }),
             }),
             core::iter::empty(),
@@ -165,6 +167,7 @@ struct DeviceConfigInner {
     irq_mode: IRQMode,
     completion_time: time::Delta,
     disk: Option<GenDisk<NullBlkDevice>>,
+    memory_backed: bool,
 }
 
 #[vtable]
@@ -195,6 +198,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 guard.capacity_mib,
                 guard.irq_mode,
                 guard.completion_time,
+                guard.memory_backed,
             )?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -226,3 +230,5 @@ fn from_str(s: &str) -> Result<Self> {
         value.try_into()
     }
 }
+
+configfs_simple_bool_field!(DeviceConfig, 6, memory_backed);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 746ddadd11f0..8e4d2b270bcf 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -6,8 +6,10 @@
 
 use configfs::IRQMode;
 use kernel::{
+    bindings,
     block::{
         self,
+        bio::Segment,
         mq::{
             self,
             gen_disk::{
@@ -19,15 +21,12 @@
         },
     },
     error::Result,
-    new_mutex,
+    memalloc_scope, new_mutex, new_xarray,
+    page::SafePage,
     pr_info,
     prelude::*,
     str::CString,
-    sync::{
-        aref::ARef,
-        Arc,
-        Mutex, //
-    },
+    sync::{aref::ARef, Arc, Mutex},
     time::{
         hrtimer::{
             HrTimerCallback,
@@ -40,7 +39,8 @@
     types::{
         OwnableRefCounted,
         Owned, //
-    }, //
+    },
+    xarray::XArray,
 };
 
 module! {
@@ -74,6 +74,10 @@
             default: 10_000,
             description:  "Time in ns to complete a request in hardware. Default: 10,000ns",
         },
+        memory_backed: bool {
+            default: false,
+            description: "Create a memory-backed block device.",
+        },
     },
 }
 
@@ -103,6 +107,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     module_parameters::gb.value() * 1024,
                     module_parameters::irqmode.value().try_into()?,
                     Delta::from_nanos(completion_time),
+                    module_parameters::memory_backed.value(),
                 )?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -127,17 +132,23 @@ fn new(
         capacity_mib: u64,
         irq_mode: IRQMode,
         completion_time: Delta,
+        memory_backed: bool,
     ) -> Result<GenDisk<Self>> {
-        let tagset = Arc::pin_init(
-            TagSet::new(1, 256, 1, mq::tag_set::Flags::default()),
-            GFP_KERNEL,
-        )?;
+        let flags = if memory_backed {
+            mq::tag_set::Flag::Blocking.into()
+        } else {
+            mq::tag_set::Flags::default()
+        };
+
+        let tagset = Arc::pin_init(TagSet::new(1, 256, 1, flags), GFP_KERNEL)?;
 
-        let queue_data = Box::new(
-            QueueData {
+        let queue_data = Box::pin_init(
+            pin_init!(QueueData {
+                tree <- new_xarray!(kernel::xarray::AllocKind::Alloc),
                 irq_mode,
                 completion_time,
-            },
+                memory_backed,
+            }),
             GFP_KERNEL,
         )?;
 
@@ -148,11 +159,72 @@ fn new(
             .rotational(rotational)
             .build(fmt!("{}", name.to_str()?), tagset, queue_data)
     }
+
+    #[inline(always)]
+    fn write(tree: &XArray<TreeNode>, mut sector: usize, mut segment: Segment<'_>) -> Result {
+        while !segment.is_empty() {
+            let page = SafePage::alloc_page(GFP_KERNEL)?;
+            let mut tree = tree.lock();
+
+            let page_idx = sector >> block::PAGE_SECTORS_SHIFT;
+
+            let page = if let Some(page) = tree.get_mut(page_idx) {
+                page
+            } else {
+                tree.store(page_idx, page, GFP_KERNEL)?;
+                tree.get_mut(page_idx).unwrap()
+            };
+
+            let page_offset = (sector & block::PAGE_SECTOR_MASK as usize) << block::SECTOR_SHIFT;
+            sector += segment.copy_to_page(page, page_offset) >> block::SECTOR_SHIFT;
+        }
+        Ok(())
+    }
+
+    #[inline(always)]
+    fn read(tree: &XArray<TreeNode>, mut sector: usize, mut segment: Segment<'_>) -> Result {
+        let tree = tree.lock();
+
+        while !segment.is_empty() {
+            let idx = sector >> block::PAGE_SECTORS_SHIFT;
+
+            if let Some(page) = tree.get(idx) {
+                let page_offset =
+                    (sector & block::PAGE_SECTOR_MASK as usize) << block::SECTOR_SHIFT;
+                sector += segment.copy_from_page(page, page_offset) >> block::SECTOR_SHIFT;
+            } else {
+                sector += segment.zero_page() >> block::SECTOR_SHIFT;
+            }
+        }
+
+        Ok(())
+    }
+
+    #[inline(never)]
+    fn transfer(
+        command: bindings::req_op,
+        tree: &XArray<TreeNode>,
+        sector: usize,
+        segment: Segment<'_>,
+    ) -> Result {
+        match command {
+            bindings::req_op_REQ_OP_WRITE => Self::write(tree, sector, segment)?,
+            bindings::req_op_REQ_OP_READ => Self::read(tree, sector, segment)?,
+            _ => (),
+        }
+        Ok(())
+    }
 }
 
+type TreeNode = Owned<SafePage>;
+
+#[pin_data]
 struct QueueData {
+    #[pin]
+    tree: XArray<TreeNode>,
     irq_mode: IRQMode,
     completion_time: Delta,
+    memory_backed: bool,
 }
 
 #[pin_data]
@@ -182,7 +254,7 @@ impl HasHrTimer<Self> for Pdu {
 
 #[vtable]
 impl Operations for NullBlkDevice {
-    type QueueData = KBox<QueueData>;
+    type QueueData = Pin<KBox<QueueData>>;
     type RequestData = Pdu;
 
     fn new_request_data() -> impl PinInit<Self::RequestData> {
@@ -192,7 +264,27 @@ fn new_request_data() -> impl PinInit<Self::RequestData> {
     }
 
     #[inline(always)]
-    fn queue_rq(queue_data: &QueueData, rq: Owned<mq::Request<Self>>, _is_last: bool) -> Result {
+    fn queue_rq(
+        queue_data: Pin<&QueueData>,
+        mut rq: Owned<mq::Request<Self>>,
+        _is_last: bool,
+    ) -> Result {
+        if queue_data.memory_backed {
+            memalloc_scope!(let _noio: NoIo);
+            let tree = &queue_data.tree;
+            let command = rq.command();
+            let mut sector = rq.sector();
+
+            for bio in rq.bio_iter_mut() {
+                let segment_iter = bio.segment_iter();
+                for segment in segment_iter {
+                    let length = segment.len();
+                    Self::transfer(command, tree, sector, segment)?;
+                    sector += length as usize >> block::SECTOR_SHIFT;
+                }
+            }
+        }
+
         match queue_data.irq_mode {
             IRQMode::None => rq.end_ok(),
             IRQMode::Soft => mq::Request::complete(rq.into()),
@@ -205,7 +297,7 @@ fn queue_rq(queue_data: &QueueData, rq: Owned<mq::Request<Self>>, _is_last: bool
         Ok(())
     }
 
-    fn commit_rqs(_queue_data: &QueueData) {}
+    fn commit_rqs(_queue_data: Pin<&QueueData>) {}
 
     fn complete(rq: ARef<mq::Request<Self>>) {
         OwnableRefCounted::try_from_shared(rq)

-- 
2.51.2


