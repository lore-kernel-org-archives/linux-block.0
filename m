Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF72C08C4;
	Sun, 15 Feb 2026 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199086; cv=none; b=oGplryiYUjOYotHp1j/z9bSONjhki7dTHRB8zIr9LWGo3otG7+/pA7HlummxJeRR4+U4BknQhs9T1WIcmDOyJvahkZ7zPti7j3GeGKmv+KVxfPcB4NRuCs0iTFHVue0xXhbQOwZi5ZvXXs86WYYX9Fm2RKU5k9V+tgvsy983g3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199086; c=relaxed/simple;
	bh=3rrDHSRDSri7M7s71IQjuy8vdWUBLRb6Dxl+38bP14w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rs/zFo1itKWnh7hNhkzD948c12243aMpXU8mGvGqjhIFl3HXjvOa3fZ7UwwGTLhvTswr64zRDY34Hf3Z+JFBrGg3StstMBxxmLvQ7dRnd0vTGzdvGV4rVy1VzKIXAnP6QJi/KxmR5lZq9YMA+6Z1gzp09SQkjugps6GFD2L9SyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az8alV7B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az8alV7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412F1C4CEF7;
	Sun, 15 Feb 2026 23:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199086;
	bh=3rrDHSRDSri7M7s71IQjuy8vdWUBLRb6Dxl+38bP14w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Az8alV7BraHRqfL7hqn1+NA0R7pNI58SQGJvj5divghBndBEdJ7+CWNP9YYTwuCvW
	 xnR+vaaQmP1sIsn8x8tjLpNvnDCbh56EmdBr9xaqP1yY5IQoHoFDgDz3r5JQEyRcqZ
	 XSeGPCJCBW3BEsaYvNBylzzVvEufatAxXeDpNIBCjdUounvU4KAEGOWq21FtrYyGqm
	 p/N1/k0Us5fBVlmokfwPcvqXqLxdiA6eqDwKxVlT6SCwd6XmlW+4782dpmicVQ6lp/
	 lbHcEgBGjOKlEpwOLg4XrnDQzzD+HSCKGcWy6uyuBekezyCnwiy5+VCdAFP7/5IsMZ
	 OxCBFb8nOKloQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:00 +0100
Subject: [PATCH 13/79] block: rnull: add memory backing
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-13-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9784; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=3rrDHSRDSri7M7s71IQjuy8vdWUBLRb6Dxl+38bP14w=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgnM2ycmnCqrRa591Gzsguln6y/lmOkye/8U
 u03WEeU+5iJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYJwAKCRDhuBo+eShj
 dzQDD/4+t9unn5Mhb8F+eGinmC5GX+e4Vgm8WLHicT77yJovXDieWRqEZcKzenYhQQpF44ENEuG
 5RUNKWiHM3Ld1h8Xfhrhn6KEMyfdJXRwRMLVtxqF29PL7pFggp3FrR1o4YC9j1Ohl3XUXCCBUMQ
 KjoN8T4omTMpp7P24ryCxPy9xhOPpZhZIGlQXkhbhCsjefas33oC9eUHu0B8E/XKuW06dOZ4ir+
 nZW1q0FvtPphCJ02Bfham9zg2LyAz3SZCnSMUaKXForaWUtnF/JJBrVNnEPxvk7oylk7/5lXDgr
 wgjrZ9chQDAEujX8ngpxIyNdKJunI6tUkr6PBJIJxbAZsLoqBZ/Sbtxee1g9KGqw4idw/MKU6bs
 cbu/ZoAjf970wlAdt/zgJNu3VRKt0JWQ90UuiHNwZSUyNiVLieslklWD+cr6EPQJHFAqS06xvK8
 S46rxQHj7DXbSZbYaRBaBsTCcGssCHJDwJIFgAOLt5NLs4UzK7RfNCTjTqSGP+ZBowoG0qsLCQo
 L//dMYspPRPLKIrl1S51xt42j1hdnbd/hGbDWnltSU3K2DCbVyoL0oBbD323LGMJDe3mZQpMID0
 ND4pY6RuGedkc/qQkHVe58XTsPKi7+MNoTd2F+u3n83cy9hhPVuJxS6KpYJUHFiHl2Pe/Mdjw2d
 /aEyUyu1Iq58/AA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add memory backing to the rust null block driver. This implementation will
always allocate a page on write, even though a page backing the written
sector is already allocated, in which case the page will be released again.
A later patch will fix this inefficiency.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  37 +++++++++++-
 drivers/block/rnull/rnull.rs    | 125 ++++++++++++++++++++++++++++++++++------
 2 files changed, 144 insertions(+), 18 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 7952f41f42bfd..b5dc30c5d3e20 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -59,7 +59,7 @@ impl AttributeOperations<0> for Config {
 
     fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         let mut writer = kernel::str::Formatter::new(page);
-        writer.write_str("blocksize,size,rotational,irqmode,completion_nsec\n")?;
+        writer.write_str("blocksize,size,rotational,irqmode,completion_nsec,memory_backed\n")?;
         Ok(writer.bytes_written())
     }
 }
@@ -83,6 +83,7 @@ fn make_group(
                 size: 3,
                 irqmode: 4,
                 completion_nsec: 5,
+                memory_backed: 6,
             ],
         };
 
@@ -100,6 +101,7 @@ fn make_group(
                     irq_mode: IRQMode::None,
                     completion_time: time::Delta::ZERO,
                     name: name.try_into()?,
+                    memory_backed: false,
                 }),
             }),
             core::iter::empty(),
@@ -154,6 +156,7 @@ struct DeviceConfigInner {
     irq_mode: IRQMode,
     completion_time: time::Delta,
     disk: Option<GenDisk<NullBlkDevice>>,
+    memory_backed: bool,
 }
 
 #[vtable]
@@ -184,6 +187,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 guard.capacity_mib,
                 guard.irq_mode,
                 guard.completion_time,
+                guard.memory_backed,
             )?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -209,3 +213,34 @@ fn from_str(s: &str) -> Result<Self> {
         value.try_into()
     }
 }
+
+#[vtable]
+impl configfs::AttributeOperations<6> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::Formatter::new(page);
+
+        if this.data.lock().memory_backed {
+            writer.write_fmt(fmt!("1\n"))?;
+        } else {
+            writer.write_fmt(fmt!("0\n"))?;
+        }
+
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        if this.data.lock().powered {
+            return Err(EBUSY);
+        }
+
+        this.data.lock().memory_backed = core::str::from_utf8(page)?
+            .trim()
+            .parse::<u8>()
+            .map_err(|_| kernel::error::code::EINVAL)?
+            != 0;
+
+        Ok(())
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 33c1144550a0e..a1156a368c467 100644
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
+    new_mutex, new_xarray,
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
 use pin_init::PinInit;
 
@@ -76,6 +76,10 @@
             default: 10_000,
             description:  "Time in ns to complete a request in hardware. Default: 10,000ns",
         },
+        memory_backed: u8 {
+            default: 0,
+            description: "Create a memory-backed block device. 0-false, 1-true. Default: 0",
+        },
     },
 }
 
@@ -105,6 +109,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     *module_parameters::gb.value() * 1024,
                     (*module_parameters::irqmode.value()).try_into()?,
                     Delta::from_nanos(completion_time),
+                    *module_parameters::memory_backed.value() != 0,
                 )?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -129,17 +134,23 @@ fn new(
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
 
@@ -150,11 +161,72 @@ fn new(
             .rotational(rotational)
             .build(fmt!("{}", name.to_str()?), tagset, queue_data)
     }
+
+    #[inline(always)]
+    fn write(tree: &Tree, mut sector: usize, mut segment: Segment<'_>) -> Result {
+        while !segment.is_empty() {
+            let page = SafePage::alloc_page(GFP_NOIO)?;
+            let mut tree = tree.lock();
+
+            let page_idx = sector >> block::PAGE_SECTORS_SHIFT;
+
+            let page = if let Some(page) = tree.get_mut(page_idx) {
+                page
+            } else {
+                tree.store(page_idx, page, GFP_NOIO)?;
+                tree.get_mut(page_idx).unwrap()
+            };
+
+            let page_offset = (sector & block::SECTOR_MASK as usize) << block::SECTOR_SHIFT;
+            sector += segment.copy_to_page(page, page_offset) >> block::SECTOR_SHIFT;
+        }
+        Ok(())
+    }
+
+    #[inline(always)]
+    fn read(tree: &Tree, mut sector: usize, mut segment: Segment<'_>) -> Result {
+        let tree = tree.lock();
+
+        while !segment.is_empty() {
+            let idx = sector >> block::PAGE_SECTORS_SHIFT;
+
+            if let Some(page) = tree.get(idx) {
+                let page_offset = (sector & block::SECTOR_MASK as usize) << block::SECTOR_SHIFT;
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
+        tree: &Tree,
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
+type Tree = XArray<TreeNode>;
+
+#[pin_data]
 struct QueueData {
+    #[pin]
+    tree: Tree,
     irq_mode: IRQMode,
     completion_time: Delta,
+    memory_backed: bool,
 }
 
 #[pin_data]
@@ -184,7 +256,7 @@ impl HasHrTimer<Self> for Pdu {
 
 #[vtable]
 impl Operations for NullBlkDevice {
-    type QueueData = KBox<QueueData>;
+    type QueueData = Pin<KBox<QueueData>>;
     type RequestData = Pdu;
 
     fn new_request_data() -> impl PinInit<Self::RequestData> {
@@ -194,7 +266,26 @@ fn new_request_data() -> impl PinInit<Self::RequestData> {
     }
 
     #[inline(always)]
-    fn queue_rq(queue_data: &QueueData, rq: Owned<mq::Request<Self>>, _is_last: bool) -> Result {
+    fn queue_rq(
+        queue_data: Pin<&QueueData>,
+        mut rq: Owned<mq::Request<Self>>,
+        _is_last: bool,
+    ) -> Result {
+        if queue_data.memory_backed {
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
@@ -207,7 +298,7 @@ fn queue_rq(queue_data: &QueueData, rq: Owned<mq::Request<Self>>, _is_last: bool
         Ok(())
     }
 
-    fn commit_rqs(_queue_data: &QueueData) {}
+    fn commit_rqs(_queue_data: Pin<&QueueData>) {}
 
     fn complete(rq: ARef<mq::Request<Self>>) {
         OwnableRefCounted::try_from_shared(rq)

-- 
2.51.2


