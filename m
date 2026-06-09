Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DF41B7DE;
	Tue,  9 Jun 2026 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032614; cv=none; b=KsavlVBc0SClO3hMssCEIacuX66uEtEjQ3SxqEsVoHqYMN5QF3AQrc354tLkAmBUFwJIv0s8OtvKhoaxcA27aiWv5UBzPK6R8QDph1JZYU4W3P3bijIjMW4J24yK3UWmchr2dCeloj95ZJMyYi2S1Py4i7xmfdjCzWGKHVip4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032614; c=relaxed/simple;
	bh=54Ir0JYD9OtCshYrOmORT50bWLTfAnbAqnZGtUhdkb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0ZpNdmZG8Rx54RNcN/JwgPi8oIHT93EzF8G/9XqkFR3k3j1n9oxn69jOiOfe49aV4Ip9XFUabfLs5mfOJ5hi96R3hU/Cqv0m7fYvJczdUNr63rpw0wxlZcnY8X+uVYDf0iOEDAwAq0oiAs/r2Blhl6OV+v9djgD9RbzwWVAS1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5kDg10y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5kDg10y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4080F1F00893;
	Tue,  9 Jun 2026 19:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032611;
	bh=8+aQYbUEeB2wWpPE0Kkc70BP8QREHNkdbeNV0sZI8Ec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z5kDg10ySRIH6Q0XSS0fYiwMB7rfEZqjLr0pZXuQKgwYrtRtDBxYXz+EoYF1lDT0g
	 bBhAsKph9TgcjwJvCGSDRWQi+ZM6y552BlKZo9/8YJ8Xus9zz2ZSsT1UexUa17DlYt
	 DnhHjpwpBney5US//f3OmKEXSxHymYdD7W48VJGGEIKUmomoS7AWa79Ca5INnfTotX
	 7F0/K6ls6aIgmknUa/3Wgmm/Q4YzBG7qqHZNhvCFm0i/jKGzWME8stbCVMyLDfVLgn
	 eXLTg4ELCUYN6cYYudD6oBD5yFJcrWH+m89c5yFC5Iyiz4w9zoGEa1b+uyfPc0VjRZ
	 uWPO0F+lYFvFQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:32 +0200
Subject: [PATCH v2 53/83] block: rnull: add zoned storage support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-53-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=50709;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=54Ir0JYD9OtCshYrOmORT50bWLTfAnbAqnZGtUhdkb4=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTkR1oxAPh1bGbAiVeMf3iVb4oGeLtW2sIxJ
 zwsA89rwdaJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk5AAKCRD6UCkIqsW9
 0MqTD/4zxDaeSp+Xd66k1yvqUWvNcM0tZVeygkIgw58KFG8jojjGfNCSCXhbo5ifDqDrdJ7Mxzu
 0u/hSPiH1bvHlv8KZLmXM/Z13tazlOB8dfBtFLVgOhvbwNL96rz4oXlvN6tv04EnpW2fJEais0k
 IZh+WMealEw7YL9pZ3HPTWMHBczHKvMluEXI9b9CdvWWTdOajUC315rXB71yeu2P0r+g4nc+49M
 qyvHMcHSwrVdtfajbWq1ilMi/McEWnMwHQ+2fg80EzDqdVeNndv/R9xFPbnDChQ+rVQhR/eYnyC
 z5m4RxmXBUsGrjXxQ9phDcRhC3/KfZlkfIDAvCUj6ba89TomZ5J/nAb9L+kQvfTTszmQ2WVo9ep
 PnNFjkh/CueMwNCrnNvM8tUphBNbGcQIa7W/6+NWe1/QFFA55LtJ4Qrzq4/xeHCsOGEMu4vw11i
 9Vicnj1lMD3ohB2/0OhHU2+N+buOp+vmInvqsm5i3C1bYo63sYA4ygnT4sh0hscUDB6j251lqZh
 43bxdKXgtiDYd36696t93GIsySis+U7p6Gj82HX5xkxicmdmRyzWvGQtZ898ghDaeWgo125Yz/Y
 6J0GOCpnYemDh4vSv3cTdOeypMaGfTgpMfNdlearAunVw4z0NAjdU55twifJ83d+ldsS3SIfj6m
 1y02KxkZB/S8FDg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add zoned block device emulation to rnull. When enabled via the `zoned`
configfs attribute, the driver emulates a zoned storage device with
configurable zone size and zone count.

The implementation supports zone management operations including zone
reset, zone open, zone close, and zone finish. Zone write pointer
tracking is maintained for sequential write required zones.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs          |  67 +++-
 drivers/block/rnull/disk_storage.rs      |  34 +-
 drivers/block/rnull/disk_storage/page.rs |   4 +-
 drivers/block/rnull/rnull.rs             | 243 +++++++----
 drivers/block/rnull/util.rs              |  65 +++
 drivers/block/rnull/zoned.rs             | 663 +++++++++++++++++++++++++++++++
 6 files changed, 973 insertions(+), 103 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 8fa16dbc2a75..f866595a263c 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -80,7 +80,8 @@ impl AttributeOperations<0> for Config {
         let mut writer = kernel::str::Formatter::new(page);
         writer.write_str(
             "blocksize,size,rotational,irqmode,completion_nsec,memory_backed,\
-             submit_queues,use_per_node_hctx,discard,blocking,shared_tags\n",
+             submit_queues,use_per_node_hctx,discard,blocking,shared_tags,\
+             zoned,zone_size,zone_capacity\n",
         )?;
         Ok(writer.bytes_written())
     }
@@ -118,7 +119,14 @@ fn make_group(
                 mbps: 16,
                 blocking: 17,
                 shared_tags: 18,
-                hw_queue_depth: 19
+                hw_queue_depth: 19,
+                zoned: 20,
+                zone_size: 21,
+                zone_capacity: 22,
+                zone_nr_conv: 23,
+                zone_max_open: 24,
+                zone_max_active: 25,
+                zone_append_max_sectors: 26,
             ],
         };
 
@@ -145,16 +153,20 @@ fn make_group(
                     bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                     bad_blocks_once: false,
                     bad_blocks_partial_io: false,
-                    disk_storage: Arc::pin_init(
-                        DiskStorage::new(0, block_size as usize),
-                        GFP_KERNEL
-                    )?,
+                    disk_storage: Arc::pin_init(DiskStorage::new(0, block_size), GFP_KERNEL)?,
                     cache_size_mib: 0,
                     mbps: 0,
                     blocking: false,
                     shared_tags: false,
                     shared_tag_set: self.shared_tag_set.clone(),
                     hw_queue_depth: 64,
+                    zoned: false,
+                    zone_size_mib: 256,
+                    zone_capacity_mib: 0,
+                    zone_nr_conv: 0,
+                    zone_max_open: 0,
+                    zone_max_active: 0,
+                    zone_append_max_sectors: u32::MAX,
                 }),
             }),
             core::iter::empty(),
@@ -234,6 +246,13 @@ struct DeviceConfigInner {
     shared_tags: bool,
     shared_tag_set: Arc<TagSet<NullBlkDevice>>,
     hw_queue_depth: u32,
+    zoned: bool,
+    zone_size_mib: u32,
+    zone_capacity_mib: u32,
+    zone_nr_conv: u32,
+    zone_max_open: u32,
+    zone_max_active: u32,
+    zone_append_max_sectors: u32,
 }
 
 #[vtable]
@@ -257,11 +276,24 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         let mut guard = this.data.lock();
 
         if !guard.powered && power_op {
+            // We protect zone state with a mutex, so we require blocking queues for zone emulation.
+            if guard.shared_tags && guard.zoned {
+                if !guard
+                    .shared_tag_set
+                    .flags()
+                    .contains(kernel::block::mq::tag_set::Flag::Blocking)
+                {
+                    return Err(EINVAL);
+                }
+            } else if guard.zoned && !guard.blocking {
+                return Err(EINVAL);
+            }
+
             guard.disk = Some(NullBlkDevice::new(crate::NullBlkOptions {
                 name: &guard.name,
-                block_size: guard.block_size,
+                block_size_bytes: guard.block_size,
                 rotational: guard.rotational,
-                capacity_mib: guard.capacity_mib,
+                device_capacity_mib: guard.capacity_mib,
                 irq_mode: guard.irq_mode,
                 completion_time: guard.completion_time,
                 discard: guard.discard,
@@ -279,6 +311,13 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                     no_sched: guard.no_sched,
                     hw_queue_depth: guard.hw_queue_depth,
                 },
+                zoned: guard.zoned,
+                zone_size_mib: guard.zone_size_mib,
+                zone_capacity_mib: guard.zone_capacity_mib,
+                zone_nr_conv: guard.zone_nr_conv,
+                zone_max_open: guard.zone_max_open,
+                zone_max_active: guard.zone_max_active,
+                zone_append_max_sectors: guard.zone_append_max_sectors,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -442,10 +481,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
     store: |this, page| store_with_power_check(this, page, |data, page| {
         let text = core::str::from_utf8(page)?.trim();
         let value = text.parse::<u64>().map_err(|_| EINVAL)?;
-        data.disk_storage = Arc::pin_init(
-            DiskStorage::new(value, data.block_size as usize),
-            GFP_KERNEL
-        )?;
+        data.disk_storage = Arc::pin_init(DiskStorage::new(value, data.block_size), GFP_KERNEL)?;
         data.cache_size_mib = value;
         Ok(())
     })
@@ -455,3 +491,10 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 configfs_simple_bool_field!(DeviceConfig, 17, blocking);
 configfs_simple_bool_field!(DeviceConfig, 18, shared_tags);
 configfs_simple_field!(DeviceConfig, 19, hw_queue_depth, u32);
+configfs_simple_bool_field!(DeviceConfig, 20, zoned);
+configfs_simple_field!(DeviceConfig, 21, zone_size_mib, u32);
+configfs_simple_field!(DeviceConfig, 22, zone_capacity_mib, u32);
+configfs_simple_field!(DeviceConfig, 23, zone_nr_conv, u32);
+configfs_simple_field!(DeviceConfig, 24, zone_max_open, u32);
+configfs_simple_field!(DeviceConfig, 25, zone_max_active, u32);
+configfs_simple_field!(DeviceConfig, 26, zone_append_max_sectors, u32);
diff --git a/drivers/block/rnull/disk_storage.rs b/drivers/block/rnull/disk_storage.rs
index b8fef411fffe..82de1f656f68 100644
--- a/drivers/block/rnull/disk_storage.rs
+++ b/drivers/block/rnull/disk_storage.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use super::HwQueueContext;
+use crate::util::*;
 use core::pin::Pin;
 use kernel::{
     block,
@@ -9,8 +10,12 @@
     page::PAGE_SIZE,
     prelude::*,
     sync::{
-        atomic::{ordering, Atomic},
-        SpinLock, SpinLockGuard,
+        atomic::{
+            ordering,
+            Atomic, //
+        },
+        SpinLock,
+        SpinLockGuard, //
     },
     uapi::PAGE_SECTORS,
     xarray::{
@@ -31,11 +36,11 @@ pub(crate) struct DiskStorage {
     cache_size: u64,
     cache_size_used: Atomic<u64>,
     next_flush_sector: Atomic<u64>,
-    block_size: usize,
+    block_size: u32,
 }
 
 impl DiskStorage {
-    pub(crate) fn new(cache_size: u64, block_size: usize) -> impl PinInit<Self, Error> {
+    pub(crate) fn new(cache_size: u64, block_size: u32) -> impl PinInit<Self, Error> {
         try_pin_init!( Self {
             // TODO: Get rid of the box
             // https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/commit/?h=locking&id=a5d84cafb3e253a11d2e078902c5b090be2f4227
@@ -59,6 +64,27 @@ pub(crate) fn access<'a, 'b, 'c>(
     pub(crate) fn lock(&self) -> SpinLockGuard<'_, Pin<KBox<TreeContainer>>> {
         self.trees.lock()
     }
+
+    pub(crate) fn discard(
+        &self,
+        hw_data: &Pin<&SpinLock<HwQueueContext>>,
+        mut sector: u64,
+        sectors: u32,
+    ) {
+        let mut tree_guard = self.lock();
+        let mut hw_data_guard = hw_data.lock();
+
+        let mut access = self.access(&mut tree_guard, &mut hw_data_guard, None);
+
+        let mut remaining_bytes = sectors_to_bytes(sectors);
+
+        while remaining_bytes > 0 {
+            access.free_sector(sector);
+            let processed = remaining_bytes.min(self.block_size);
+            sector += Into::<u64>::into(bytes_to_sectors(processed));
+            remaining_bytes -= processed;
+        }
+    }
 }
 
 pub(crate) struct DiskStorageAccess<'a, 'b, 'c> {
diff --git a/drivers/block/rnull/disk_storage/page.rs b/drivers/block/rnull/disk_storage/page.rs
index bc78973ad5d4..88dc9a2476bd 100644
--- a/drivers/block/rnull/disk_storage/page.rs
+++ b/drivers/block/rnull/disk_storage/page.rs
@@ -20,11 +20,11 @@
 pub(crate) struct NullBlockPage {
     page: Owned<SafePage>,
     status: u64,
-    block_size: usize,
+    block_size: u32,
 }
 
 impl NullBlockPage {
-    pub(crate) fn new(block_size: usize) -> Result<KBox<Self>> {
+    pub(crate) fn new(block_size: u32) -> Result<KBox<Self>> {
         memalloc_scope!(let _noio: NoIo);
         Ok(KBox::new(
             Self {
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 5ec17a2674b7..6fb307e33263 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -2,8 +2,13 @@
 
 //! This is a Rust implementation of the C null block driver.
 
+#![recursion_limit = "256"]
+
 mod configfs;
 mod disk_storage;
+mod util;
+#[cfg(CONFIG_BLK_DEV_ZONED)]
+mod zoned;
 
 use configfs::IRQMode;
 use disk_storage::{
@@ -77,6 +82,7 @@
     },
     xarray::XArraySheaf, //
 };
+use util::*;
 
 module! {
     type: NullBlkModule,
@@ -151,6 +157,35 @@
             default: 64,
             description:  "Queue depth for each hardware queue. Default: 64",
         },
+        zoned: bool {
+            default: false,
+            description: "Make device as a host-managed zoned block device.",
+        },
+        zone_size: u32 {
+            default: 256,
+            description:
+            "Zone size in MB when block device is zoned. Must be power-of-two: Default: 256",
+        },
+        zone_capacity: u32 {
+            default: 0,
+            description: "Zone capacity in MB when block device is zoned. Can be less than or equal to zone size. Default: Zone size",
+        },
+        zone_nr_conv: u32 {
+            default: 0,
+            description: "Number of conventional zones when block device is zoned. Default: 0",
+        },
+        zone_max_open: u32 {
+            default: 0,
+            description: "Maximum number of open zones when block device is zoned. Default: 0 (no limit)",
+        },
+        zone_max_active: u32 {
+            default: 0,
+            description: "Maximum number of active zones when block device is zoned. Default: 0 (no limit)",
+        },
+        zone_append_max_sectors: u32 {
+            default: 0,
+            description: "Maximum size of a zone append command (in 512B sectors). Specify 0 for no zone append.",
+        },
     },
 }
 
@@ -195,16 +230,16 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                 let block_size = module_parameters::bs.value();
                 let disk = NullBlkDevice::new(NullBlkOptions {
                     name: &name,
-                    block_size,
+                    block_size_bytes: block_size,
                     rotational: module_parameters::rotational.value(),
-                    capacity_mib: module_parameters::gb.value() * 1024,
+                    device_capacity_mib: module_parameters::gb.value() * 1024,
                     irq_mode: module_parameters::irqmode.value().try_into()?,
                     completion_time: Delta::from_nanos(completion_time),
                     discard: module_parameters::discard.value(),
                     bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                     bad_blocks_once: false,
                     bad_blocks_partial_io: false,
-                    storage: Arc::pin_init(DiskStorage::new(0, block_size as usize), GFP_KERNEL)?,
+                    storage: Arc::pin_init(DiskStorage::new(0, block_size), GFP_KERNEL)?,
                     bandwidth_limit: u64::from(module_parameters::mbps.value()) * 2u64.pow(20),
                     shared_tag_set: module_parameters::shared_tags
                         .value()
@@ -217,6 +252,13 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                         no_sched,
                         hw_queue_depth,
                     },
+                    zoned: module_parameters::zoned.value(),
+                    zone_size_mib: module_parameters::zone_size.value(),
+                    zone_capacity_mib: module_parameters::zone_capacity.value(),
+                    zone_nr_conv: module_parameters::zone_nr_conv.value(),
+                    zone_max_open: module_parameters::zone_max_open.value(),
+                    zone_max_active: module_parameters::zone_max_active.value(),
+                    zone_append_max_sectors: module_parameters::zone_append_max_sectors.value(),
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -231,9 +273,9 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
 
 struct NullBlkOptions<'a> {
     name: &'a CStr,
-    block_size: u32,
+    block_size_bytes: u32,
     rotational: bool,
-    capacity_mib: u64,
+    device_capacity_mib: u64,
     irq_mode: IRQMode,
     completion_time: Delta,
     discard: bool,
@@ -244,6 +286,19 @@ struct NullBlkOptions<'a> {
     bandwidth_limit: u64,
     shared_tag_set: Option<Arc<TagSet<NullBlkDevice>>>,
     tag_set: TagSetOptions,
+    zoned: bool,
+    #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(dead_code))]
+    zone_size_mib: u32,
+    #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(dead_code))]
+    zone_capacity_mib: u32,
+    #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(dead_code))]
+    zone_nr_conv: u32,
+    #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(dead_code))]
+    zone_max_open: u32,
+    #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(dead_code))]
+    zone_max_active: u32,
+    #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(dead_code))]
+    zone_append_max_sectors: u32,
 }
 
 #[pin_data]
@@ -252,7 +307,7 @@ struct NullBlkDevice {
     irq_mode: IRQMode,
     completion_time: Delta,
     memory_backed: bool,
-    block_size: usize,
+    block_size_bytes: u32,
     bad_blocks: Arc<BadBlocks>,
     bad_blocks_once: bool,
     bad_blocks_partial_io: bool,
@@ -263,6 +318,9 @@ struct NullBlkDevice {
     #[pin]
     bandwidth_timer_handle: SpinLock<Option<ArcHrTimerHandle<Self>>>,
     disk: SetOnce<Arc<Revocable<GenDiskRef<Self>>>>,
+    #[cfg(CONFIG_BLK_DEV_ZONED)]
+    #[pin]
+    zoned: zoned::ZoneOptions,
 }
 
 struct TagSetOptions {
@@ -314,9 +372,9 @@ fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
     fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
         let NullBlkOptions {
             name,
-            block_size,
+            block_size_bytes,
             rotational,
-            capacity_mib,
+            device_capacity_mib,
             irq_mode,
             completion_time,
             discard,
@@ -327,6 +385,19 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             bandwidth_limit,
             shared_tag_set,
             tag_set,
+            zoned,
+            #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(unused_variables))]
+            zone_size_mib,
+            #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(unused_variables))]
+            zone_capacity_mib,
+            #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(unused_variables))]
+            zone_nr_conv,
+            #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(unused_variables))]
+            zone_max_open,
+            #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(unused_variables))]
+            zone_max_active,
+            #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(unused_variables))]
+            zone_append_max_sectors,
         } = options;
 
         let memory_backed = tag_set.memory_backed;
@@ -337,10 +408,10 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             Self::build_tag_set(tag_set)?
         };
 
-        let capacity_sectors = capacity_mib << (20 - block::SECTOR_SHIFT);
+        let device_capacity_sectors = mib_to_sectors(device_capacity_mib);
 
         // Prevent overflow in usize/u64 casts
-        if usize::BITS == 32 && capacity_sectors > u32::MAX.into() {
+        if usize::BITS == 32 && device_capacity_sectors > u32::MAX.into() {
             return Err(code::EINVAL);
         }
 
@@ -350,7 +421,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
                 irq_mode,
                 completion_time,
                 memory_backed,
-                block_size: block_size as usize,
+                block_size_bytes,
                 bad_blocks,
                 bad_blocks_once,
                 bad_blocks_partial_io,
@@ -359,17 +430,42 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
                 bandwidth_bytes: Atomic::new(0),
                 bandwidth_timer_handle <- new_spinlock!(None),
                 disk: SetOnce::new(),
+                #[cfg(CONFIG_BLK_DEV_ZONED)]
+                zoned <- zoned::ZoneOptions::new(zoned::ZoneOptionsArgs {
+                    enable: zoned,
+                    device_capacity_mib,
+                    block_size_bytes: *block_size_bytes,
+                    zone_size_mib,
+                    zone_capacity_mib,
+                    zone_nr_conv,
+                    zone_max_open,
+                    zone_max_active,
+                    zone_append_max_sectors,
+                })?,
             }),
             GFP_KERNEL,
         )?;
 
         let mut builder = gen_disk::GenDiskBuilder::new()
-            .capacity_sectors(capacity_sectors)
-            .logical_block_size(block_size)?
-            .physical_block_size(block_size)?
+            .capacity_sectors(device_capacity_sectors)
+            .logical_block_size(block_size_bytes)?
+            .physical_block_size(block_size_bytes)?
             .rotational(rotational);
 
-        if memory_backed && discard {
+        #[cfg(CONFIG_BLK_DEV_ZONED)]
+        {
+            builder = builder
+                .zoned(zoned)
+                .zone_size(queue_data.zoned.size_sectors)
+                .zone_append_max(zone_append_max_sectors);
+        }
+
+        if !cfg!(CONFIG_BLK_DEV_ZONED) && zoned {
+            return Err(ENOTSUPP);
+        }
+
+        // TODO: Warn on invalid discard configuration (zoned, memory)
+        if memory_backed && discard && !zoned {
             builder = builder
                 // Max IO size is u32::MAX bytes
                 .max_hw_discard_sectors(ffi::c_uint::MAX >> block::SECTOR_SHIFT);
@@ -393,7 +489,7 @@ fn sheaf_size() -> usize {
     fn preload<'b, 'c>(
         tree_guard: &'b mut SpinLockGuard<'c, Pin<KBox<TreeContainer>>>,
         hw_data_guard: &'b mut SpinLockGuard<'c, HwQueueContext>,
-        block_size: usize,
+        block_size_bytes: u32,
         sheaf: &'b mut Option<XArraySheaf<'c>>,
     ) -> Result {
         match sheaf {
@@ -418,10 +514,9 @@ fn preload<'b, 'c>(
 
         // Another thread may get the lock after we allocate. If this happens, retry.
         while hw_data_guard.page.is_none() {
-            hw_data_guard.page =
-                Some(tree_guard.do_unlocked(|| {
-                    hw_data_guard.do_unlocked(|| NullBlockPage::new(block_size))
-                })?);
+            hw_data_guard.page = Some(tree_guard.do_unlocked(|| {
+                hw_data_guard.do_unlocked(|| NullBlockPage::new(block_size_bytes))
+            })?);
         }
 
         Ok(())
@@ -438,7 +533,7 @@ fn write<'a, 'b, 'c>(
         let mut sheaf: Option<XArraySheaf<'_>> = None;
 
         while !segment.is_empty() {
-            Self::preload(tree_guard, hw_data_guard, self.block_size, &mut sheaf)?;
+            Self::preload(tree_guard, hw_data_guard, self.block_size_bytes, &mut sheaf)?;
 
             let mut access = self.storage.access(tree_guard, hw_data_guard, sheaf);
 
@@ -491,48 +586,23 @@ fn read<'a, 'b, 'c>(
                         >> block::SECTOR_SHIFT;
                 }
                 // CAST: Casting from `usize` to `u64` never overflows.
-                None => sector += segment.zero_page() as u64 >> block::SECTOR_SHIFT,
+                None => sector += bytes_to_sectors(segment.zero_page() as u64),
             }
         }
 
         Ok(())
     }
 
-    fn discard(
-        &self,
-        hw_data: &Pin<&SpinLock<HwQueueContext>>,
-        mut sector: u64,
-        sectors: u32,
-    ) -> Result {
-        let mut tree_guard = self.storage.lock();
-        let mut hw_data_guard = hw_data.lock();
-
-        let mut access = self
-            .storage
-            .access(&mut tree_guard, &mut hw_data_guard, None);
-
-        let mut remaining_bytes = (sectors as usize) << SECTOR_SHIFT;
-
-        while remaining_bytes > 0 {
-            access.free_sector(sector);
-            let processed = remaining_bytes.min(self.block_size);
-            sector += (processed >> SECTOR_SHIFT) as u64;
-            remaining_bytes -= processed;
-        }
-
-        Ok(())
-    }
-
     #[inline(never)]
     fn transfer(
         &self,
         hw_data: &Pin<&SpinLock<HwQueueContext>>,
         rq: &mut Owned<mq::Request<Self>>,
+        command: mq::Command,
         max_sectors: u32,
     ) -> Result {
         let mut sector = rq.sector();
         let max_end_sector = sector + <u32 as Into<u64>>::into(max_sectors);
-        let command = rq.command();
 
         // TODO: Use `PerCpu` to get rid of this lock
         let mut hw_data_guard = hw_data.lock();
@@ -566,6 +636,27 @@ fn transfer(
         Ok(())
     }
 
+    fn handle_regular_command(
+        &self,
+        hw_data: &Pin<&SpinLock<HwQueueContext>>,
+        rq: &mut Owned<mq::Request<Self>>,
+    ) -> Result {
+        let mut sectors = rq.sectors();
+
+        self.handle_bad_blocks(rq, &mut sectors)?;
+
+        if self.memory_backed {
+            memalloc_scope!(let _noio: NoIo);
+            if rq.command() == mq::Command::Discard {
+                self.storage.discard(hw_data, rq.sector(), sectors);
+            } else {
+                self.transfer(hw_data, rq, rq.command(), sectors)?;
+            }
+        }
+
+        Ok(())
+    }
+
     fn handle_bad_blocks(&self, rq: &mut Owned<mq::Request<Self>>, sectors: &mut u32) -> Result {
         if self.bad_blocks.enabled() {
             let start = rq.sector();
@@ -581,7 +672,7 @@ fn handle_bad_blocks(&self, rq: &mut Owned<mq::Request<Self>>, sectors: &mut u32
                     }
 
                     if self.bad_blocks_partial_io {
-                        let block_size_sectors = (self.block_size >> SECTOR_SHIFT) as u64;
+                        let block_size_sectors = u64::from(bytes_to_sectors(self.block_size_bytes));
                         range.start = align_down(range.start, block_size_sectors);
                         if start < range.start {
                             *sectors = (range.start - start) as u32;
@@ -666,30 +757,6 @@ impl HasHrTimer<Self> for Pdu {
     }
 }
 
-fn is_power_of_two<T>(value: T) -> bool
-where
-    T: core::ops::Sub<T, Output = T>,
-    T: core::ops::BitAnd<Output = T>,
-    T: core::cmp::PartialOrd<T>,
-    T: Copy,
-    T: From<u8>,
-{
-    (value > 0u8.into()) && (value & (value - 1u8.into())) == 0u8.into()
-}
-
-fn align_down<T>(value: T, to: T) -> T
-where
-    T: core::ops::Sub<T, Output = T>,
-    T: core::ops::Not<Output = T>,
-    T: core::ops::BitAnd<Output = T>,
-    T: core::cmp::PartialOrd<T>,
-    T: Copy,
-    T: From<u8>,
-{
-    debug_assert!(is_power_of_two(to));
-    value & !(to - 1u8.into())
-}
-
 #[vtable]
 impl Operations for NullBlkDevice {
     type QueueData = Arc<Self>;
@@ -711,8 +778,6 @@ fn queue_rq(
         rq: Owned<mq::IdleRequest<Self>>,
         _is_last: bool,
     ) -> BlkResult {
-        let mut sectors = rq.sectors();
-
         if this.bandwidth_limit != 0 {
             if !this.bandwidth_timer.active() {
                 drop(this.bandwidth_timer_handle.lock().take());
@@ -738,18 +803,16 @@ fn queue_rq(
 
         let mut rq = rq.start();
 
-        use core::ops::Deref;
-        Self::handle_bad_blocks(this.deref(), &mut rq, &mut sectors)?;
-
-        if this.memory_backed {
-            memalloc_scope!(let _noio: NoIo);
-            if rq.command() == mq::Command::Discard {
-                this.discard(&hw_data, rq.sector(), sectors)?;
-            } else {
-                this.transfer(&hw_data, &mut rq, sectors)?;
-            }
+        #[cfg(CONFIG_BLK_DEV_ZONED)]
+        if this.zoned.enabled {
+            this.handle_zoned_command(&hw_data, &mut rq)?;
+        } else {
+            this.handle_regular_command(&hw_data, &mut rq)?;
         }
 
+        #[cfg(not(CONFIG_BLK_DEV_ZONED))]
+        this.handle_regular_command(&hw_data, &mut rq)?;
+
         match this.irq_mode {
             IRQMode::None => Self::end_request(rq),
             IRQMode::Soft => mq::Request::complete(rq.into()),
@@ -775,4 +838,14 @@ fn complete(rq: ARef<mq::Request<Self>>) {
                 .expect("Failed to complete request"),
         )
     }
+
+    #[cfg(CONFIG_BLK_DEV_ZONED)]
+    fn report_zones(
+        disk: &GenDiskRef<Self>,
+        sector: u64,
+        nr_zones: u32,
+        callback: impl Fn(&bindings::blk_zone, u32) -> Result,
+    ) -> Result<u32> {
+        Self::report_zones_internal(disk, sector, nr_zones, callback)
+    }
 }
diff --git a/drivers/block/rnull/util.rs b/drivers/block/rnull/util.rs
new file mode 100644
index 000000000000..044926c8e284
--- /dev/null
+++ b/drivers/block/rnull/util.rs
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Return true if `value` is a power of two.
+pub(crate) fn is_power_of_two<T>(value: T) -> bool
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
+// Round `value` down to the next multiple of `to`, which must be a power of
+// two.
+pub(crate) fn align_down<T>(value: T, to: T) -> T
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
+// Round `value` up to the next multiple of `to`, which must be a power of two.
+#[cfg(CONFIG_BLK_DEV_ZONED)]
+pub(crate) fn align_up<T>(value: T, to: T) -> T
+where
+    T: core::ops::Sub<T, Output = T>,
+    T: core::ops::Add<T, Output = T>,
+    T: core::ops::BitAnd<Output = T>,
+    T: core::ops::BitOr<Output = T>,
+    T: core::cmp::PartialOrd<T>,
+    T: Copy,
+    T: From<u8>,
+{
+    debug_assert!(is_power_of_two(to));
+    ((value - 1u8.into()) | (to - 1u8.into())) + 1u8.into()
+}
+
+pub(crate) fn mib_to_sectors<T>(mib: T) -> T
+where
+    T: core::ops::Shl<u32, Output = T>,
+{
+    mib << (20 - kernel::block::SECTOR_SHIFT)
+}
+
+pub(crate) fn sectors_to_bytes<T>(sectors: T) -> T
+where
+    T: core::ops::Shl<u32, Output = T>,
+{
+    sectors << kernel::block::SECTOR_SHIFT
+}
+
+pub(crate) fn bytes_to_sectors<T>(bytes: T) -> T
+where
+    T: core::ops::Shl<u32, Output = T>,
+{
+    bytes << kernel::block::SECTOR_SHIFT
+}
diff --git a/drivers/block/rnull/zoned.rs b/drivers/block/rnull/zoned.rs
new file mode 100644
index 000000000000..808449cc49e1
--- /dev/null
+++ b/drivers/block/rnull/zoned.rs
@@ -0,0 +1,663 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use crate::{
+    util::*,
+    HwQueueContext, //
+};
+use kernel::{
+    bindings,
+    block::mq::{
+        self,
+        gen_disk::GenDiskRef, //
+    },
+    memalloc_scope,
+    new_mutex,
+    new_spinlock,
+    prelude::*,
+    sync::Mutex,
+    sync::SpinLock,
+    types::Owned, //
+};
+
+pub(crate) struct ZoneOptionsArgs {
+    pub(crate) enable: bool,
+    pub(crate) device_capacity_mib: u64,
+    pub(crate) block_size_bytes: u32,
+    pub(crate) zone_size_mib: u32,
+    pub(crate) zone_capacity_mib: u32,
+    pub(crate) zone_nr_conv: u32,
+    pub(crate) zone_max_open: u32,
+    pub(crate) zone_max_active: u32,
+    pub(crate) zone_append_max_sectors: u32,
+}
+
+#[pin_data]
+pub(crate) struct ZoneOptions {
+    pub(crate) enabled: bool,
+    zones: Pin<KBox<[Mutex<ZoneDescriptor>]>>,
+    conventional_count: u32,
+    pub(crate) size_sectors: u32,
+    append_max_sectors: u32,
+    max_open: u32,
+    max_active: u32,
+    #[pin]
+    accounting: SpinLock<ZoneAccounting>,
+}
+
+impl ZoneOptions {
+    pub(crate) fn new(args: ZoneOptionsArgs) -> Result<impl PinInit<Self, Error>> {
+        let ZoneOptionsArgs {
+            enable,
+            device_capacity_mib,
+            block_size_bytes,
+            zone_size_mib,
+            zone_capacity_mib,
+            mut zone_nr_conv,
+            mut zone_max_open,
+            mut zone_max_active,
+            zone_append_max_sectors,
+        } = args;
+
+        if !is_power_of_two(zone_size_mib) {
+            return Err(EINVAL);
+        }
+
+        if zone_capacity_mib > zone_size_mib {
+            return Err(EINVAL);
+        }
+
+        let zone_size_sectors = mib_to_sectors(zone_size_mib);
+        let device_capacity_sectors = mib_to_sectors(device_capacity_mib);
+        let zone_capacity_sectors = mib_to_sectors(zone_capacity_mib);
+        let zone_count: u32 = (align_up(device_capacity_sectors, zone_size_sectors.into())
+            >> zone_size_sectors.ilog2())
+        .try_into()?;
+
+        if zone_nr_conv >= zone_count {
+            zone_nr_conv = zone_count - 1;
+            pr_info!("changed the number of conventional zones to {zone_nr_conv}\n");
+        }
+
+        let zone_append_max_sectors =
+            align_down(zone_append_max_sectors, bytes_to_sectors(block_size_bytes))
+                .min(zone_capacity_sectors);
+
+        let seq_zone_count = zone_count - zone_nr_conv;
+
+        if zone_max_active >= seq_zone_count {
+            zone_max_active = 0;
+            pr_info!("zone_max_active limit disabled, limit >= zone count\n");
+        }
+
+        if zone_max_active != 0 && zone_max_open > zone_max_active {
+            zone_max_open = zone_max_active;
+            pr_info!("changed the maximum number of open zones to {zone_max_open}\n");
+        } else if zone_max_open >= seq_zone_count {
+            zone_max_open = 0;
+            pr_info!("zone_max_open limit disabled, limit >= zone count\n");
+        }
+
+        Ok(try_pin_init!(Self {
+            enabled: enable,
+            zones: init_zone_descriptors(
+                zone_size_sectors,
+                zone_capacity_sectors,
+                zone_count,
+                zone_nr_conv,
+            )?,
+            size_sectors: zone_size_sectors,
+            append_max_sectors: zone_append_max_sectors,
+            max_open: zone_max_open,
+            max_active: zone_max_active,
+            accounting <- new_spinlock!(ZoneAccounting {
+                implicit_open: 0,
+                explicit_open: 0,
+                closed: 0,
+                start_zone: zone_nr_conv,
+            }),
+            conventional_count: zone_nr_conv,
+        }))
+    }
+}
+
+struct ZoneAccounting {
+    implicit_open: u32,
+    explicit_open: u32,
+    closed: u32,
+    start_zone: u32,
+}
+
+pub(crate) fn init_zone_descriptors(
+    zone_size_sectors: u32,
+    zone_capacity_sectors: u32,
+    zone_count: u32,
+    zone_nr_conv: u32,
+) -> Result<Pin<KBox<[Mutex<ZoneDescriptor>]>>> {
+    let zone_capacity_sectors = if zone_capacity_sectors == 0 {
+        zone_size_sectors
+    } else {
+        zone_capacity_sectors
+    };
+
+    KBox::pin_slice(
+        |i| {
+            let sector = i as u64 * Into::<u64>::into(zone_size_sectors);
+            new_mutex!(
+                if i < zone_nr_conv.try_into().expect("Fewer than 2^32 zones") {
+                    ZoneDescriptor {
+                        start_sector: sector,
+                        size_sectors: zone_size_sectors,
+                        capacity_sectors: zone_size_sectors,
+                        kind: ZoneType::Conventional,
+                        write_pointer: sector + Into::<u64>::into(zone_size_sectors),
+                        condition: ZoneCondition::NoWritePointer,
+                    }
+                } else {
+                    ZoneDescriptor {
+                        start_sector: sector,
+                        size_sectors: zone_size_sectors,
+                        capacity_sectors: zone_capacity_sectors,
+                        kind: ZoneType::SequentialWriteRequired,
+                        write_pointer: sector,
+                        condition: ZoneCondition::Empty,
+                    }
+                }
+            )
+        },
+        zone_count as usize,
+        GFP_KERNEL,
+    )
+}
+
+impl super::NullBlkDevice {
+    pub(crate) fn handle_zoned_command(
+        &self,
+        hw_data: &Pin<&SpinLock<HwQueueContext>>,
+        rq: &mut Owned<mq::Request<Self>>,
+    ) -> Result {
+        use mq::Command::*;
+        match rq.command() {
+            ZoneAppend | Write => self.zoned_write(hw_data, rq)?,
+            ZoneReset | ZoneResetAll | ZoneOpen | ZoneClose | ZoneFinish => {
+                self.zone_management(hw_data, rq)?
+            }
+            _ => self.zoned_read(hw_data, rq)?,
+        }
+
+        Ok(())
+    }
+
+    fn zone_management(
+        &self,
+        hw_data: &Pin<&SpinLock<HwQueueContext>>,
+        rq: &mut Owned<mq::Request<Self>>,
+    ) -> Result {
+        if rq.command() == mq::Command::ZoneResetAll {
+            for zone in self.zoned.zones_iter() {
+                let mut zone = zone.lock();
+                use ZoneCondition::*;
+                match zone.condition {
+                    Empty | ReadOnly | Offline => continue,
+                    _ => self.zoned.reset_zone(&self.storage, hw_data, &mut zone)?,
+                }
+            }
+
+            return Ok(());
+        }
+
+        let zone = self.zoned.zone(rq.sector())?;
+        let mut zone = zone.lock();
+
+        if zone.condition == ZoneCondition::ReadOnly || zone.condition == ZoneCondition::Offline {
+            return Err(EIO);
+        }
+
+        use mq::Command::*;
+        match rq.command() {
+            ZoneOpen => self.zoned.open_zone(&mut zone, rq.sector()),
+            ZoneClose => self.zoned.close_zone(&mut zone),
+            ZoneReset => self.zoned.reset_zone(&self.storage, hw_data, &mut zone),
+            ZoneFinish => self.zoned.finish_zone(&mut zone, rq.sector()),
+            _ => Err(EIO),
+        }
+    }
+
+    fn zoned_read(
+        &self,
+        hw_data: &Pin<&SpinLock<HwQueueContext>>,
+        rq: &mut Owned<mq::Request<Self>>,
+    ) -> Result {
+        let zone = self.zoned.zone(rq.sector())?;
+        let zone = zone.lock();
+        if zone.condition == ZoneCondition::Offline {
+            return Err(EINVAL);
+        }
+
+        zone.check_bounds_read(rq.sector(), rq.sectors())?;
+
+        self.handle_regular_command(hw_data, rq)
+    }
+
+    fn zoned_write(
+        &self,
+        hw_data: &Pin<&SpinLock<HwQueueContext>>,
+        rq: &mut Owned<mq::Request<Self>>,
+    ) -> Result {
+        let zone = self.zoned.zone(rq.sector())?;
+        let mut zone = zone.lock();
+        let append: bool = rq.command() == mq::Command::ZoneAppend;
+
+        if zone.kind == ZoneType::Conventional {
+            if append {
+                return Err(EINVAL);
+            }
+
+            // NOTE: C driver does not check bounds on write.
+            zone.check_bounds_write(rq.sector(), rq.sectors())?;
+
+            let mut sectors = rq.sectors();
+            self.handle_bad_blocks(rq, &mut sectors)?;
+            return self.transfer(hw_data, rq, rq.command(), sectors);
+        }
+
+        // Check zoned write fits within zone
+        if zone.write_pointer + Into::<u64>::into(rq.sectors())
+            > zone.start_sector + Into::<u64>::into(zone.capacity_sectors)
+        {
+            return Err(EINVAL);
+        }
+
+        if append {
+            if self.zoned.append_max_sectors == 0 {
+                return Err(EINVAL);
+            }
+            rq.as_pin_mut().set_sector(zone.write_pointer);
+        }
+
+        // Check write pointer alignment
+        if !append && rq.sector() != zone.write_pointer {
+            return Err(EINVAL);
+        }
+
+        if zone.condition == ZoneCondition::Closed || zone.condition == ZoneCondition::Empty {
+            if self.zoned.use_accounting() {
+                let mut accounting = self.zoned.accounting.lock();
+                self.zoned
+                    .check_zone_resources(&mut accounting, &mut zone, rq.sector())?;
+
+                if zone.condition == ZoneCondition::Closed {
+                    accounting.closed -= 1;
+                    accounting.implicit_open += 1;
+                } else if zone.condition == ZoneCondition::Empty {
+                    accounting.implicit_open += 1;
+                }
+            }
+
+            zone.condition = ZoneCondition::ImplicitOpen;
+        }
+
+        let mut sectors = rq.sectors();
+        self.handle_bad_blocks(rq, &mut sectors)?;
+
+        if self.memory_backed {
+            memalloc_scope!(let _noio: NoIo);
+            self.transfer(hw_data, rq, mq::Command::Write, sectors)?;
+        }
+
+        zone.write_pointer += Into::<u64>::into(sectors);
+        if zone.write_pointer == zone.start_sector + Into::<u64>::into(zone.capacity_sectors) {
+            if self.zoned.use_accounting() {
+                let mut accounting = self.zoned.accounting.lock();
+
+                if zone.condition == ZoneCondition::ExplicitOpen {
+                    accounting.explicit_open -= 1;
+                } else if zone.condition == ZoneCondition::ImplicitOpen {
+                    accounting.implicit_open -= 1;
+                }
+            }
+
+            zone.condition = ZoneCondition::Full;
+        }
+
+        Ok(())
+    }
+
+    pub(crate) fn report_zones_internal(
+        disk: &GenDiskRef<Self>,
+        sector: u64,
+        nr_zones: u32,
+        callback: impl Fn(&bindings::blk_zone, u32) -> Result,
+    ) -> Result<u32> {
+        let device = disk.queue_data();
+        let first_zone = sector >> device.zoned.size_sectors.ilog2();
+
+        let mut count = 0;
+
+        for (i, zone) in device
+            .zoned
+            .zones
+            .split_at(first_zone as usize)
+            .1
+            .iter()
+            .take(nr_zones as usize)
+            .enumerate()
+        {
+            let zone = zone.lock();
+            let descriptor = bindings::blk_zone {
+                start: zone.start_sector,
+                len: zone.size_sectors.into(),
+                wp: zone.write_pointer,
+                capacity: zone.capacity_sectors.into(),
+                type_: zone.kind as u8,
+                cond: zone.condition as u8,
+                ..bindings::blk_zone::zeroed()
+            };
+            drop(zone);
+            callback(&descriptor, i as u32)?;
+
+            count += 1;
+        }
+
+        Ok(count)
+    }
+}
+
+impl ZoneOptions {
+    fn zone_no(&self, sector: u64) -> usize {
+        (sector >> self.size_sectors.ilog2()) as usize
+    }
+
+    fn zone(&self, sector: u64) -> Result<&Mutex<ZoneDescriptor>> {
+        self.zones.get(self.zone_no(sector)).ok_or(EINVAL)
+    }
+
+    fn zones_iter(&self) -> impl Iterator<Item = &Mutex<ZoneDescriptor>> {
+        self.zones.iter()
+    }
+
+    fn use_accounting(&self) -> bool {
+        self.max_active != 0 || self.max_open != 0
+    }
+
+    fn try_close_implicit_open_zone(&self, accounting: &mut ZoneAccounting, sector: u64) -> Result {
+        let skip = self.zone_no(sector) as u32;
+
+        let it = Iterator::chain(
+            self.zones[(accounting.start_zone as usize)..]
+                .iter()
+                .enumerate()
+                .map(|(i, z)| (i + accounting.start_zone as usize, z)),
+            self.zones[(self.conventional_count as usize)..(accounting.start_zone as usize)]
+                .iter()
+                .enumerate()
+                .map(|(i, z)| (i + self.conventional_count as usize, z)),
+        )
+        .filter(|(i, _)| *i != skip as usize);
+
+        for (index, zone) in it {
+            let mut zone = zone.lock();
+            if zone.condition == ZoneCondition::ImplicitOpen {
+                accounting.implicit_open -= 1;
+
+                let index_u32: u32 = index.try_into()?;
+                let next_zone: u32 = index_u32 + 1;
+                accounting.start_zone = if next_zone == self.zones.len().try_into()? {
+                    self.conventional_count
+                } else {
+                    next_zone
+                };
+
+                if zone.write_pointer == zone.start_sector {
+                    zone.condition = ZoneCondition::Empty;
+                } else {
+                    zone.condition = ZoneCondition::Closed;
+                    accounting.closed += 1;
+                }
+                return Ok(());
+            }
+        }
+
+        Err(EINVAL)
+    }
+
+    fn open_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
+        if zone.kind == ZoneType::Conventional {
+            return Err(EINVAL);
+        }
+
+        use ZoneCondition::*;
+        match zone.condition {
+            ExplicitOpen => return Ok(()),
+            Empty | ImplicitOpen | Closed => (),
+            _ => return Err(EIO),
+        }
+
+        if self.use_accounting() {
+            let mut accounting = self.accounting.lock();
+            match zone.condition {
+                Empty => {
+                    self.check_zone_resources(&mut accounting, zone, sector)?;
+                }
+                ImplicitOpen => {
+                    accounting.implicit_open -= 1;
+                }
+                Closed => {
+                    self.check_zone_resources(&mut accounting, zone, sector)?;
+                    accounting.closed -= 1;
+                }
+                _ => (),
+            }
+
+            accounting.explicit_open += 1;
+        }
+
+        zone.condition = ExplicitOpen;
+        Ok(())
+    }
+
+    fn check_zone_resources(
+        &self,
+        accounting: &mut ZoneAccounting,
+        zone: &mut ZoneDescriptor,
+        sector: u64,
+    ) -> Result {
+        match zone.condition {
+            ZoneCondition::Empty => {
+                self.check_active_zones(accounting)?;
+                self.check_open_zones(accounting, sector)
+            }
+            ZoneCondition::Closed => self.check_open_zones(accounting, sector),
+            _ => Err(EIO),
+        }
+    }
+
+    fn check_open_zones(&self, accounting: &mut ZoneAccounting, sector: u64) -> Result {
+        if self.max_open == 0 {
+            return Ok(());
+        }
+
+        if self.max_open > accounting.explicit_open + accounting.implicit_open {
+            return Ok(());
+        }
+
+        if accounting.implicit_open > 0 {
+            self.check_active_zones(accounting)?;
+            return self.try_close_implicit_open_zone(accounting, sector);
+        }
+
+        Err(EBUSY)
+    }
+
+    fn check_active_zones(&self, accounting: &mut ZoneAccounting) -> Result {
+        if self.max_active == 0 {
+            return Ok(());
+        }
+
+        if self.max_active > accounting.implicit_open + accounting.explicit_open + accounting.closed
+        {
+            return Ok(());
+        }
+
+        Err(EBUSY)
+    }
+
+    fn close_zone(&self, zone: &mut ZoneDescriptor) -> Result {
+        if zone.kind == ZoneType::Conventional {
+            return Err(EINVAL);
+        }
+
+        use ZoneCondition::*;
+        match zone.condition {
+            Closed => return Ok(()),
+            ImplicitOpen | ExplicitOpen => (),
+            _ => return Err(EIO),
+        }
+
+        if self.use_accounting() {
+            let mut accounting = self.accounting.lock();
+            match zone.condition {
+                ImplicitOpen => accounting.implicit_open -= 1,
+                ExplicitOpen => accounting.explicit_open -= 1,
+                _ => (),
+            }
+
+            if zone.write_pointer > zone.start_sector {
+                accounting.closed += 1;
+            }
+        }
+
+        if zone.write_pointer == zone.start_sector {
+            zone.condition = Empty;
+        } else {
+            zone.condition = Closed;
+        }
+
+        Ok(())
+    }
+
+    fn finish_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
+        if zone.kind == ZoneType::Conventional {
+            return Err(EINVAL);
+        }
+
+        if self.use_accounting() {
+            let mut accounting = self.accounting.lock();
+
+            use ZoneCondition::*;
+            match zone.condition {
+                Full => return Ok(()),
+                Empty => {
+                    self.check_zone_resources(&mut accounting, zone, sector)?;
+                }
+                ImplicitOpen => accounting.implicit_open -= 1,
+                ExplicitOpen => accounting.explicit_open -= 1,
+                Closed => {
+                    self.check_zone_resources(&mut accounting, zone, sector)?;
+                    accounting.closed -= 1;
+                }
+                _ => return Err(EIO),
+            }
+        }
+
+        zone.condition = ZoneCondition::Full;
+        zone.write_pointer = zone.start_sector + Into::<u64>::into(zone.size_sectors);
+
+        Ok(())
+    }
+
+    fn reset_zone(
+        &self,
+        storage: &crate::disk_storage::DiskStorage,
+        hw_data: &Pin<&SpinLock<HwQueueContext>>,
+        zone: &mut ZoneDescriptor,
+    ) -> Result {
+        if zone.kind == ZoneType::Conventional {
+            return Err(EINVAL);
+        }
+
+        if self.use_accounting() {
+            let mut accounting = self.accounting.lock();
+
+            use ZoneCondition::*;
+            match zone.condition {
+                ImplicitOpen => accounting.implicit_open -= 1,
+                ExplicitOpen => accounting.explicit_open -= 1,
+                Closed => accounting.closed -= 1,
+                Empty | Full => (),
+                _ => return Err(EIO),
+            }
+        }
+
+        zone.condition = ZoneCondition::Empty;
+        zone.write_pointer = zone.start_sector;
+
+        storage.discard(hw_data, zone.start_sector, zone.size_sectors);
+
+        Ok(())
+    }
+}
+
+pub(crate) struct ZoneDescriptor {
+    start_sector: u64,
+    size_sectors: u32,
+    kind: ZoneType,
+    capacity_sectors: u32,
+    write_pointer: u64,
+    condition: ZoneCondition,
+}
+
+impl ZoneDescriptor {
+    fn check_bounds_write(&self, sector: u64, sectors: u32) -> Result {
+        if sector + Into::<u64>::into(sectors)
+            > self.start_sector + Into::<u64>::into(self.capacity_sectors)
+        {
+            Err(EIO)
+        } else {
+            Ok(())
+        }
+    }
+
+    fn check_bounds_read(&self, sector: u64, sectors: u32) -> Result {
+        if sector + Into::<u64>::into(sectors) > self.write_pointer {
+            Err(EIO)
+        } else {
+            Ok(())
+        }
+    }
+}
+
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+#[repr(u32)]
+enum ZoneType {
+    Conventional = bindings::blk_zone_type_BLK_ZONE_TYPE_CONVENTIONAL,
+    SequentialWriteRequired = bindings::blk_zone_type_BLK_ZONE_TYPE_SEQWRITE_REQ,
+    #[expect(dead_code)]
+    SequentialWritePreferred = bindings::blk_zone_type_BLK_ZONE_TYPE_SEQWRITE_PREF,
+}
+
+impl ZoneType {
+    #[expect(dead_code)]
+    fn as_raw(self) -> u32 {
+        self as u32
+    }
+}
+
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+#[repr(u32)]
+enum ZoneCondition {
+    NoWritePointer = bindings::blk_zone_cond_BLK_ZONE_COND_NOT_WP,
+    Empty = bindings::blk_zone_cond_BLK_ZONE_COND_EMPTY,
+    ImplicitOpen = bindings::blk_zone_cond_BLK_ZONE_COND_IMP_OPEN,
+    ExplicitOpen = bindings::blk_zone_cond_BLK_ZONE_COND_EXP_OPEN,
+    Closed = bindings::blk_zone_cond_BLK_ZONE_COND_CLOSED,
+    Full = bindings::blk_zone_cond_BLK_ZONE_COND_FULL,
+    ReadOnly = bindings::blk_zone_cond_BLK_ZONE_COND_READONLY,
+    Offline = bindings::blk_zone_cond_BLK_ZONE_COND_OFFLINE,
+}
+
+impl ZoneCondition {
+    #[expect(dead_code)]
+    fn as_raw(self) -> u32 {
+        self as u32
+    }
+}

-- 
2.51.2


