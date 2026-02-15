Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE02D8798;
	Sun, 15 Feb 2026 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198904; cv=none; b=pRAe6NEcMNKQ8+sbK0377jDMCyuPC6SJQXeFVjane2odvJpe2dt4n5F5TQLliIVB4qHOhF47fCiZ3kc/Y6KoVkt8vdafmyfBM38P8SlpIijYdnv2kmUlSORljiLORfTDqhzwh1oQbvhwlGE80r/0jVckNHYLcdlnnATWLi2MiLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198904; c=relaxed/simple;
	bh=L3XSJojS07YDYbfXfGO4e+2UgYlsugCATTWsJ+jV4ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGt17bZgTpRgan+RSCa9VzR5W+WDVKFBCGsegR2Qxge0rnx3I3vECAbS32i3F4PdBuBS+9S/qF2DuzJ32VGta86wvOXtMS/UiqYJ5h93Xypb2XzGUiL15QuU0hAa+mJkKugKbyO8zZD3BqGKYxNJ3E02+589ptxyotND/uRnuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igDz9M0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igDz9M0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CC8C19422;
	Sun, 15 Feb 2026 23:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198904;
	bh=L3XSJojS07YDYbfXfGO4e+2UgYlsugCATTWsJ+jV4ls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=igDz9M0vYhXKDIo+yjIsqqbNWXQbpqsH1646n5gEfRTWn8Uv/6oPPwENkcBFA55Js
	 Yr0nrwjfAB8HxMohbg7LqLtlgQLA8+e6HtRquFS4kPiJlF7RFlHKiRTGt+ztkne6YO
	 Jh8sDfztk1ShNdTtMjSBxXKPI8rWao8ch0oUtPz3PWZb5DURn7g/Yki0zNaHrFaCas
	 ghpIGP8JrPGVlo8a533fw6N8Ls3yF3hwsZXYPqKC0xoeC/w0r69OQMffkohJkFViUH
	 4YUPNO8RfaarEmlgXRTUL+MYhQ9esViCqspjjFM8Vfa/A22YGikB0srm7nMl8G+0us
	 E46u6vm1xhY2w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:07 +0100
Subject: [PATCH 20/79] block: rnull: add discard support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-20-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10018;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=L3XSJojS07YDYbfXfGO4e+2UgYlsugCATTWsJ+jV4ls=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgtUZ2EEiKlJcCmtv5PNpC9ErgLsmTBI2uRU
 9XxwKAejBGJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYLQAKCRDhuBo+eShj
 d8QpD/0aOYUEHA91S9PGUYMcbZUu6Nvel4/gIWiCvQFtcuJD+1ZAJOF+fOyT6RcBgie3kRaNwde
 WctVwIEmb5oeWENqVXTlE1YZ04r+TzBlvOfynxh4PxsHQUuQ5ra7xSIhW6zVg+qO3JwYxwcUO5+
 mcVfO7w+gIN2k/feuuEY5OkquTWlDDK0qPGkN34ax2LICaFohGgugLDlnj6U3ugj3P8Pc2W1vfh
 JfMsqBCMDGwUBHABeOj/ttTyxmwbwbqEn0RE1CUPH+sBU37he60j+TxXOMe5lhTRj+wJ7n/soeq
 S4I7P4heDFRKG7JJSYvEOLGgzGnPy/Vz340UWzhBjYKcpCQnuN7hNbkq3c/6I5Dj5qMe/pzrod5
 kkCsHYlLKQpqPU/REIZTagphKAtdAvF/16yoBmfj1RMNprpHqngs8sHwUSHKlsJzckOD/2plski
 Oeb3Z0XZiYjjs6O1SH+olc4NmLTjUaUSgIFoOzYK0WoRe44+DbOU5DIo+G/oOCxvKOSsn1Zm+pa
 0URrr/009mux/KXiFLAAiSDDLLJiwztoqYEFMTHevmVKsYPct57PMBX3NHiRU4dUeNU5o/AMgei
 kNxccWqgKS6jRkjBti5yxV7YLsIkNn8KJRLiCz5mNu9YXgOjiRZYWUNFfl4uSJPfpKhtD6DeRsP
 SnyxLPVhFvuKO3A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for discard operations to the rnull block driver:
- Add discard module parameter and configfs attribute.
- Set max_hw_discard_sectors when discard is enabled.
- Add sector occupancy tracking.
- Add discard handling that frees sectors and removes empty pages.
- Discard operations require memory backing to function.

The discard feature uses a bitmap to track which sectors in each page are
occupied, allowing cleanup of pages when they are empty.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  15 ++++++
 drivers/block/rnull/rnull.rs    | 115 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 116 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index fe00617d2b679..4ec9be440105d 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -94,6 +94,7 @@ fn make_group(
                 submit_queues: 7,
                 use_per_node_hctx: 8,
                 home_node: 9,
+                discard: 10,
             ],
         };
 
@@ -114,6 +115,7 @@ fn make_group(
                     memory_backed: false,
                     submit_queues: 1,
                     home_node: bindings::NUMA_NO_NODE,
+                    discard: false,
                 }),
             }),
             core::iter::empty(),
@@ -171,6 +173,7 @@ struct DeviceConfigInner {
     memory_backed: bool,
     submit_queues: u32,
     home_node: i32,
+    discard: bool,
 }
 
 #[vtable]
@@ -204,6 +207,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 memory_backed: guard.memory_backed,
                 submit_queues: guard.submit_queues,
                 home_node: guard.home_node,
+                discard: guard.discard,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -321,3 +325,14 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         }
     }
 );
+
+configfs_attribute!(DeviceConfig, 10,
+    show: |this, page| show_field(this.data.lock().discard, page),
+    store: |this, page| store_with_power_check(this, page, |this, page| {
+        if !this.data.lock().memory_backed {
+            return Err(EINVAL);
+        }
+        this.data.lock().discard = kstrtobool_bytes(page)?;
+        Ok(())
+    })
+);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index fb3ce272d5bec..d1fb5fbc0c0be 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -19,14 +19,19 @@
             Operations,
             TagSet, //
         },
+        SECTOR_MASK, SECTOR_SHIFT,
     },
     error::{
         code,
         Result, //
     },
+    ffi,
     new_mutex,
     new_xarray,
-    page::SafePage,
+    page::{
+        SafePage, //
+        PAGE_SIZE,
+    },
     pr_info,
     prelude::*,
     str::CString,
@@ -102,6 +107,11 @@
             default: -1,
             description: "Home node for the device. Default: -1 (no node)",
         },
+        discard: u8 {
+            default: 0,
+            description:
+            "Support discard operations (requires memory-backed null_blk device). Default: false",
+        },
     },
 }
 
@@ -139,6 +149,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     memory_backed: *module_parameters::memory_backed.value() != 0,
                     submit_queues,
                     home_node: *module_parameters::home_node.value(),
+                    discard: *module_parameters::discard.value() != 0,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -163,6 +174,7 @@ struct NullBlkOptions<'a> {
     memory_backed: bool,
     submit_queues: u32,
     home_node: i32,
+    discard: bool,
 }
 struct NullBlkDevice;
 
@@ -178,6 +190,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             memory_backed,
             submit_queues,
             home_node,
+            discard,
         } = options;
 
         let flags = if memory_backed {
@@ -201,22 +214,30 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
                 irq_mode,
                 completion_time,
                 memory_backed,
+                block_size: block_size as usize,
             }),
             GFP_KERNEL,
         )?;
 
-        gen_disk::GenDiskBuilder::new()
+        let mut builder = gen_disk::GenDiskBuilder::new()
             .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT))
             .logical_block_size(block_size)?
             .physical_block_size(block_size)?
-            .rotational(rotational)
-            .build(fmt!("{}", name.to_str()?), tagset, queue_data)
+            .rotational(rotational);
+
+        if memory_backed && discard {
+            builder = builder
+                // Max IO size is u32::MAX bytes
+                .max_hw_discard_sectors(ffi::c_uint::MAX >> block::SECTOR_SHIFT);
+        }
+
+        builder.build(fmt!("{}", name.to_str()?), tagset, queue_data)
     }
 
     #[inline(always)]
     fn write(tree: &Tree, mut sector: usize, mut segment: Segment<'_>) -> Result {
         while !segment.is_empty() {
-            let page = SafePage::alloc_page(GFP_NOIO)?;
+            let page = NullBlockPage::new()?;
             let mut tree = tree.lock();
 
             let page_idx = sector >> block::PAGE_SECTORS_SHIFT;
@@ -228,8 +249,10 @@ fn write(tree: &Tree, mut sector: usize, mut segment: Segment<'_>) -> Result {
                 tree.get_mut(page_idx).unwrap()
             };
 
+            page.set_occupied(sector);
             let page_offset = (sector & block::SECTOR_MASK as usize) << block::SECTOR_SHIFT;
-            sector += segment.copy_to_page(page, page_offset) >> block::SECTOR_SHIFT;
+            sector +=
+                segment.copy_to_page(page.page.get_pin_mut(), page_offset) >> block::SECTOR_SHIFT;
         }
         Ok(())
     }
@@ -243,7 +266,7 @@ fn read(tree: &Tree, mut sector: usize, mut segment: Segment<'_>) -> Result {
 
             if let Some(page) = tree.get(idx) {
                 let page_offset = (sector & block::SECTOR_MASK as usize) << block::SECTOR_SHIFT;
-                sector += segment.copy_from_page(page, page_offset) >> block::SECTOR_SHIFT;
+                sector += segment.copy_from_page(&page.page, page_offset) >> block::SECTOR_SHIFT;
             } else {
                 sector += segment.zero_page() >> block::SECTOR_SHIFT;
             }
@@ -252,6 +275,32 @@ fn read(tree: &Tree, mut sector: usize, mut segment: Segment<'_>) -> Result {
         Ok(())
     }
 
+    fn discard(tree: &Tree, mut sector: usize, sectors: usize, block_size: usize) -> Result {
+        let mut remaining_bytes = sectors << SECTOR_SHIFT;
+        let mut tree = tree.lock();
+
+        while remaining_bytes > 0 {
+            let page_idx = sector >> block::PAGE_SECTORS_SHIFT;
+            let mut remove = false;
+            if let Some(page) = tree.get_mut(page_idx) {
+                page.set_free(sector);
+                if page.is_empty() {
+                    remove = true;
+                }
+            }
+
+            if remove {
+                drop(tree.remove(page_idx))
+            }
+
+            let processed = remaining_bytes.min(block_size);
+            sector += processed >> SECTOR_SHIFT;
+            remaining_bytes -= processed;
+        }
+
+        Ok(())
+    }
+
     #[inline(never)]
     fn transfer(
         command: bindings::req_op,
@@ -268,7 +317,40 @@ fn transfer(
     }
 }
 
-type TreeNode = Owned<SafePage>;
+const _CHEKC_STATUS_WIDTH: () = build_assert!((PAGE_SIZE >> SECTOR_SHIFT) <= 64);
+
+struct NullBlockPage {
+    page: Owned<SafePage>,
+    status: u64,
+}
+
+impl NullBlockPage {
+    fn new() -> Result<KBox<Self>> {
+        Ok(KBox::new(
+            Self {
+                page: SafePage::alloc_page(GFP_NOIO | __GFP_ZERO)?,
+                status: 0,
+            },
+            GFP_NOIO,
+        )?)
+    }
+
+    fn set_occupied(&mut self, sector: usize) {
+        let idx = sector & SECTOR_MASK as usize;
+        self.status |= 1 << idx;
+    }
+
+    fn set_free(&mut self, sector: usize) {
+        let idx = sector & SECTOR_MASK as usize;
+        self.status &= !(1 << idx);
+    }
+
+    fn is_empty(&self) -> bool {
+        self.status == 0
+    }
+}
+
+type TreeNode = KBox<NullBlockPage>;
 type Tree = XArray<TreeNode>;
 
 #[pin_data]
@@ -278,6 +360,7 @@ struct QueueData {
     irq_mode: IRQMode,
     completion_time: Delta,
     memory_backed: bool,
+    block_size: usize,
 }
 
 #[pin_data]
@@ -327,12 +410,16 @@ fn queue_rq(
             let command = rq.command();
             let mut sector = rq.sector();
 
-            for bio in rq.bio_iter_mut() {
-                let segment_iter = bio.segment_iter();
-                for segment in segment_iter {
-                    let length = segment.len();
-                    Self::transfer(command, tree, sector, segment)?;
-                    sector += length as usize >> block::SECTOR_SHIFT;
+            if command == bindings::req_op_REQ_OP_DISCARD {
+                Self::discard(tree, sector, rq.sectors(), queue_data.block_size)?;
+            } else {
+                for bio in rq.bio_iter_mut() {
+                    let segment_iter = bio.segment_iter();
+                    for segment in segment_iter {
+                        let length = segment.len();
+                        Self::transfer(command, tree, sector, segment)?;
+                        sector += length as usize >> block::SECTOR_SHIFT;
+                    }
                 }
             }
         }

-- 
2.51.2


