Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A92BEC34;
	Sun, 15 Feb 2026 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199041; cv=none; b=c8zm/U3hcWxNrB2DkzhqWTlbOkGZJI2nqQa50NXZgoR40cKGBK5uite8skj1z3kcYxh95V2qwVIHhTDkXydbgItGBtdj2CO+APn7aC0poTTmeykySoDyhBaOuuTS9aaK2N/x9M6SWed6jXB4KhkhwVC13NyCxc05lHc0o6Nl4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199041; c=relaxed/simple;
	bh=3/is2sfDJmdRy9QPPG2gvTdPrheCZt7kkxfe/Rrhb04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWF3b6Pl7dM3a2SWavlP884LO1RtzQrS9Bg559mktgGYuyJrz2k99kY13W8yYObrnaQ+iBll5Zu3NuvUqTjcIHRr9yzMrePOYS18cpkTaEj8+56VtYbomOuz73Bs6M0h0CHaAZiFolShi77sdtNOMzJavmn6CIhV6zYh1TMuyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVqOk658; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVqOk658"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E13C4CEF7;
	Sun, 15 Feb 2026 23:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199041;
	bh=3/is2sfDJmdRy9QPPG2gvTdPrheCZt7kkxfe/Rrhb04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kVqOk658tO6pg8KYX7bNxxRB+cTHS2c50HdL/p1++R6v4GnH7HLRcxAuw8IA5riP7
	 3Jt4IDICWjq7yzM4n5QjAQ8/ig/OqXNTTM3n6zQ52XFn73acEKir+D+ouQNgzERc44
	 hVOEEdRJHUNE3P7LFU3s65wdgXswhaUvfHjfWnDpUAn6Le/wmlemPdd/nnmTq35F1E
	 ngL8/34WOhSc91d6R/xOShCJl4l6B/bPuHYyjs/qwtS4s8NbMHmI9wNTIYZPQyL0FA
	 TBQSbXL1sFUr2iAXfXoTHHxuhd044WD/AjNe8u0gs6QfQL1C1KR5W1W0ELiKWSUDaz
	 CyuLRbD8VyITw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:36:06 +0100
Subject: [PATCH 79/79] block: rnull: add zone offline and readonly configfs
 files
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-79-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15509;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=3/is2sfDJmdRy9QPPG2gvTdPrheCZt7kkxfe/Rrhb04=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhjWcIdNupHJZ+Z1Iqa1OXKENuLiidyv1T3i
 5O5U2MYdHyJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYYwAKCRDhuBo+eShj
 d8/3EACTdpRzmaQm8jpMo+udlUhbjmqYZQ1GbysxKSwhPMyLWPONRaDgmeKa2b3Rmbe0NV7Zo5Y
 rIwj38weF3m+Its2XgvUVrahJIiqFSk5NMNQ5HeI+0K+NAQKcKozx5TfEpepA5HdoeaGfJj8b+n
 JkMOaapjc3sNbmsXCjQPo2o2xg0NND5UUAxe0+z0OLn/Ye9inZkivJzED1jXQFs4c9Vkl47lRzo
 UTuKDsSk6spxKiGGbtP2JdlHXjRP8iShxxogibBxN3IWVkYmbyngRfTzgnok73Ozq59wTjYzE5S
 HsuPV36y7jZHTrwnsGiipOeQ0gF6r4E//T+uwJG2yMrszInghK6vLBdJK8TxhAdOwYdEnMdzeVN
 G/LxoYwndTaA4vOOMj8Rt6WWf1AGu3oV57dmJ56qet8F4ssTJnIira4KNF9WHsFYagJHmUzd5Oh
 RSUE1Rp/TBTf8aoBQF0i7uC52UL6SLWO3rPiVQGsidikcmpAHYYEAJSVa60nXzdkT8g8X5v0FWm
 ohKXpgLXGKlIdEgSnROrl/30yR+Gb0F8IO3ZIrmNkncT93pCGE4Cu6Lo6UhcQxzrs0ugJevxH02
 h7Qo6Le7yIoYIZLE0eldLg/PTtbB9il8DVQ5sVVDvI7EsI8f/hjx8XmZpUq/VA10kXbtI8Llr+i
 ZUv36CKP5YOWpDg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add configfs attributes for managing zone states in the rnull zoned
block device emulation. The `zone_offline` and `zone_readonly`
attributes allow setting specific zones to offline or read-only states,
which is useful for testing how applications handle degraded zones.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs     | 80 +++++++++++++++++++++++++++++++++++
 drivers/block/rnull/disk_storage.rs | 59 +++++++++++++-------------
 drivers/block/rnull/rnull.rs        |  2 +-
 drivers/block/rnull/zoned.rs        | 83 ++++++++++++++++++++++++++-----------
 4 files changed, 168 insertions(+), 56 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 395da68d96dc6..1c0d95ded7e9f 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -125,6 +125,8 @@ fn make_group(
                 max_sectors: 29,
                 virt_boundary: 30,
                 shared_tag_bitmap: 31,
+                zone_offline: 32,
+                zone_readonly: 33,
             ],
         };
 
@@ -639,3 +641,81 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 configfs_simple_field!(DeviceConfig, 29, max_sectors, u32);
 configfs_simple_bool_field!(DeviceConfig, 30, virt_boundary);
 configfs_simple_bool_field!(DeviceConfig, 31, shared_tag_bitmap);
+
+#[cfg(CONFIG_BLK_DEV_ZONED)]
+fn set_zone_condition(
+    this: &DeviceConfig,
+    sector: u64,
+    cb: impl FnOnce(
+        &crate::zoned::ZoneOptions,
+        &DiskStorage,
+        &mut crate::zoned::ZoneDescriptor,
+    ) -> Result,
+) -> Result {
+    use crate::zoned::ZoneType;
+    let data_guard = this.data.lock();
+    let null_disk = data_guard.disk.as_ref().ok_or(EBUSY)?.queue_data();
+    let storage = &null_disk.storage;
+    let zone_options = &null_disk.zoned;
+    zone_options.enabled.then_some(()).ok_or(EINVAL)?;
+    let mut zone = zone_options.zone(sector)?.lock();
+
+    if zone.kind == ZoneType::Conventional {
+        return Err(EINVAL);
+    }
+
+    cb(zone_options, storage, &mut zone)
+}
+
+#[cfg(CONFIG_BLK_DEV_ZONED)]
+configfs_attribute!(
+    DeviceConfig,
+    32,
+    show: |_this, _page| Ok(0),
+    store: |this,page| {
+        let text = core::str::from_utf8(page)?.trim();
+        let sector = text.parse().map_err(|_| EINVAL)?;
+
+        set_zone_condition(this, sector, |zone_options, storage, zone| {
+            zone_options.offline_zone(storage, zone)
+        })?;
+        Ok(())
+    },
+);
+
+#[cfg(CONFIG_BLK_DEV_ZONED)]
+configfs_attribute!(
+    DeviceConfig,
+    33,
+    show: |_this, _page| Ok(0),
+    store: |this,page| {
+        let text = core::str::from_utf8(page)?.trim();
+        let sector = text.parse().map_err(|_| EINVAL)?;
+
+        set_zone_condition(this, sector, |zone_options, storage, zone| {
+            zone_options.read_only_zone(storage, zone)
+        })?;
+
+        Ok(())
+    },
+);
+
+#[cfg(not(CONFIG_BLK_DEV_ZONED))]
+configfs_attribute!(
+    DeviceConfig,
+    32,
+    show: |this, page| {Ok(0)},
+    store: |this,page| {
+        Err(ENOTSUPP)
+    },
+);
+
+#[cfg(not(CONFIG_BLK_DEV_ZONED))]
+configfs_attribute!(
+    DeviceConfig,
+    33,
+    show: |this, page| {Ok(0)},
+    store: |this,page| {
+        Err(ENOTSUPP)
+    },
+);
diff --git a/drivers/block/rnull/disk_storage.rs b/drivers/block/rnull/disk_storage.rs
index d9f2703957fc0..802e9534ca2a5 100644
--- a/drivers/block/rnull/disk_storage.rs
+++ b/drivers/block/rnull/disk_storage.rs
@@ -65,27 +65,45 @@ pub(crate) fn lock(&self) -> SpinLockGuard<'_, Pin<KBox<TreeContainer>>> {
         self.trees.lock()
     }
 
-    pub(crate) fn discard(
-        &self,
-        hw_data: &Pin<&SpinLock<HwQueueContext>>,
-        mut sector: u64,
-        sectors: u32,
-    ) {
-        let mut tree_guard = self.lock();
-        let mut hw_data_guard = hw_data.lock();
-
-        let mut access = self.access(&mut tree_guard, &mut hw_data_guard, None);
+    pub(crate) fn discard(&self, mut sector: u64, sectors: u32) {
+        let tree_guard = self.lock();
+        let mut cache_guard = tree_guard.cache_tree.lock();
+        let mut disk_guard = tree_guard.cache_tree.lock();
 
         let mut remaining_bytes = sectors_to_bytes(sectors);
 
         while remaining_bytes > 0 {
-            access.free_sector(sector);
+            self.free_sector(&mut cache_guard, &mut disk_guard, sector);
             let processed = remaining_bytes.min(self.block_size);
             sector += Into::<u64>::into(bytes_to_sectors(processed));
             remaining_bytes -= processed;
         }
     }
 
+    fn free_sector_tree(tree_access: &mut xarray::Guard<'_, TreeNode>, sector: u64) {
+        let index = DiskStorageAccess::to_index(sector);
+        if let Some(page) = tree_access.get_mut(index) {
+            page.set_free(sector);
+
+            if page.is_empty() {
+                tree_access.remove(index);
+            }
+        }
+    }
+
+    pub(crate) fn free_sector<'a>(
+        &self,
+        cache_guard: &mut xarray::Guard<'a, TreeNode>,
+        disk_guard: &mut xarray::Guard<'a, TreeNode>,
+        sector: u64,
+    ) {
+        if self.cache_size > 0 {
+            Self::free_sector_tree(cache_guard, sector);
+        }
+
+        Self::free_sector_tree(disk_guard, sector);
+    }
+
     pub(crate) fn flush(&self, hw_data: &Pin<&SpinLock<HwQueueContext>>) {
         let mut tree_guard = self.lock();
         let mut hw_data_guard = hw_data.lock();
@@ -262,25 +280,6 @@ pub(crate) fn get_read_page(&self, sector: u64) -> Option<&NullBlockPage> {
             self.disk_guard.get(index)
         }
     }
-
-    fn free_sector_tree(tree_access: &mut xarray::Guard<'_, TreeNode>, sector: u64) {
-        let index = Self::to_index(sector);
-        if let Some(page) = tree_access.get_mut(index) {
-            page.set_free(sector);
-
-            if page.is_empty() {
-                tree_access.remove(index);
-            }
-        }
-    }
-
-    pub(crate) fn free_sector(&mut self, sector: u64) {
-        if self.disk_storage.cache_size > 0 {
-            Self::free_sector_tree(&mut self.cache_guard, sector);
-        }
-
-        Self::free_sector_tree(&mut self.disk_guard, sector);
-    }
 }
 
 type Tree = XArray<TreeNode>;
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 5bf965908ef63..91f8636d74cca 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -739,7 +739,7 @@ fn handle_regular_command(
 
         if self.memory_backed {
             if rq.command() == mq::Command::Discard {
-                self.storage.discard(hw_data, rq.sector(), sectors);
+                self.storage.discard(rq.sector(), sectors);
             } else {
                 self.transfer(hw_data, rq, rq.command(), sectors)?;
             }
diff --git a/drivers/block/rnull/zoned.rs b/drivers/block/rnull/zoned.rs
index 0f15f4cc4e5c3..3b8ebf5449a8d 100644
--- a/drivers/block/rnull/zoned.rs
+++ b/drivers/block/rnull/zoned.rs
@@ -178,7 +178,7 @@ pub(crate) fn handle_zoned_command(
         match rq.command() {
             ZoneAppend | Write => self.zoned_write(hw_data, rq)?,
             ZoneReset | ZoneResetAll | ZoneOpen | ZoneClose | ZoneFinish => {
-                self.zone_management(hw_data, rq)?
+                self.zone_management(rq)?
             }
             _ => self.zoned_read(hw_data, rq)?,
         }
@@ -186,18 +186,14 @@ pub(crate) fn handle_zoned_command(
         Ok(())
     }
 
-    fn zone_management(
-        &self,
-        hw_data: &Pin<&SpinLock<HwQueueContext>>,
-        rq: &mut Owned<mq::Request<Self>>,
-    ) -> Result {
+    fn zone_management(&self, rq: &mut Owned<mq::Request<Self>>) -> Result {
         if rq.command() == mq::Command::ZoneResetAll {
             for zone in self.zoned.zones_iter() {
                 let mut zone = zone.lock();
                 use ZoneCondition::*;
                 match zone.condition {
                     Empty | ReadOnly | Offline => continue,
-                    _ => self.zoned.reset_zone(&self.storage, hw_data, &mut zone)?,
+                    _ => self.zoned.reset_zone(&self.storage, &mut zone)?,
                 }
             }
 
@@ -213,10 +209,10 @@ fn zone_management(
 
         use mq::Command::*;
         match rq.command() {
-            ZoneOpen => self.zoned.open_zone(&mut zone, rq.sector()),
+            ZoneOpen => self.zoned.open_zone(&mut zone),
             ZoneClose => self.zoned.close_zone(&mut zone),
-            ZoneReset => self.zoned.reset_zone(&self.storage, hw_data, &mut zone),
-            ZoneFinish => self.zoned.finish_zone(&mut zone, rq.sector()),
+            ZoneReset => self.zoned.reset_zone(&self.storage, &mut zone),
+            ZoneFinish => self.zoned.finish_zone(&mut zone),
             _ => Err(EIO),
         }
     }
@@ -282,7 +278,7 @@ fn zoned_write(
             if self.zoned.use_accounting() {
                 let mut accounting = self.zoned.accounting.lock();
                 self.zoned
-                    .check_zone_resources(&mut accounting, &mut zone, rq.sector())?;
+                    .check_zone_resources(&mut accounting, &mut zone)?;
 
                 if zone.condition == ZoneCondition::Closed {
                     accounting.closed -= 1;
@@ -365,7 +361,7 @@ fn zone_no(&self, sector: u64) -> usize {
         (sector >> self.size_sectors.ilog2()) as usize
     }
 
-    fn zone(&self, sector: u64) -> Result<&Mutex<ZoneDescriptor>> {
+    pub(crate) fn zone(&self, sector: u64) -> Result<&Mutex<ZoneDescriptor>> {
         self.zones.get(self.zone_no(sector)).ok_or(EINVAL)
     }
 
@@ -418,7 +414,7 @@ fn try_close_implicit_open_zone(&self, accounting: &mut ZoneAccounting, sector:
         Err(EINVAL)
     }
 
-    fn open_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
+    fn open_zone(&self, zone: &mut ZoneDescriptor) -> Result {
         if zone.kind == ZoneType::Conventional {
             return Err(EINVAL);
         }
@@ -434,13 +430,13 @@ fn open_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
             let mut accounting = self.accounting.lock();
             match zone.condition {
                 Empty => {
-                    self.check_zone_resources(&mut accounting, zone, sector)?;
+                    self.check_zone_resources(&mut accounting, zone)?;
                 }
                 ImplicitOpen => {
                     accounting.implicit_open -= 1;
                 }
                 Closed => {
-                    self.check_zone_resources(&mut accounting, zone, sector)?;
+                    self.check_zone_resources(&mut accounting, zone)?;
                     accounting.closed -= 1;
                 }
                 _ => (),
@@ -457,14 +453,13 @@ fn check_zone_resources(
         &self,
         accounting: &mut ZoneAccounting,
         zone: &mut ZoneDescriptor,
-        sector: u64,
     ) -> Result {
         match zone.condition {
             ZoneCondition::Empty => {
                 self.check_active_zones(accounting)?;
-                self.check_open_zones(accounting, sector)
+                self.check_open_zones(accounting, zone.start_sector)
             }
-            ZoneCondition::Closed => self.check_open_zones(accounting, sector),
+            ZoneCondition::Closed => self.check_open_zones(accounting, zone.start_sector),
             _ => Err(EIO),
         }
     }
@@ -533,7 +528,7 @@ fn close_zone(&self, zone: &mut ZoneDescriptor) -> Result {
         Ok(())
     }
 
-    fn finish_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
+    fn finish_zone(&self, zone: &mut ZoneDescriptor) -> Result {
         if zone.kind == ZoneType::Conventional {
             return Err(EINVAL);
         }
@@ -545,12 +540,12 @@ fn finish_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
             match zone.condition {
                 Full => return Ok(()),
                 Empty => {
-                    self.check_zone_resources(&mut accounting, zone, sector)?;
+                    self.check_zone_resources(&mut accounting, zone)?;
                 }
                 ImplicitOpen => accounting.implicit_open -= 1,
                 ExplicitOpen => accounting.explicit_open -= 1,
                 Closed => {
-                    self.check_zone_resources(&mut accounting, zone, sector)?;
+                    self.check_zone_resources(&mut accounting, zone)?;
                     accounting.closed -= 1;
                 }
                 _ => return Err(EIO),
@@ -566,7 +561,6 @@ fn finish_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
     fn reset_zone(
         &self,
         storage: &crate::disk_storage::DiskStorage,
-        hw_data: &Pin<&SpinLock<HwQueueContext>>,
         zone: &mut ZoneDescriptor,
     ) -> Result {
         if zone.kind == ZoneType::Conventional {
@@ -589,16 +583,55 @@ fn reset_zone(
         zone.condition = ZoneCondition::Empty;
         zone.write_pointer = zone.start_sector;
 
-        storage.discard(hw_data, zone.start_sector, zone.size_sectors);
+        storage.discard(zone.start_sector, zone.size_sectors);
+
+        Ok(())
+    }
+
+    fn set_zone_condition(
+        &self,
+        storage: &crate::disk_storage::DiskStorage,
+        zone: &mut ZoneDescriptor,
+        condition: ZoneCondition,
+    ) -> Result {
+        if zone.condition == condition {
+            zone.condition = ZoneCondition::Empty;
+            zone.write_pointer = zone.start_sector;
+            storage.discard(zone.start_sector, zone.size_sectors);
+        } else {
+            if matches!(
+                zone.condition,
+                ZoneCondition::ReadOnly | ZoneCondition::Offline
+            ) {
+                self.finish_zone(zone)?;
+            }
 
+            zone.condition = ZoneCondition::Offline;
+            zone.write_pointer = u64::MAX;
+        }
         Ok(())
     }
+    pub(crate) fn offline_zone(
+        &self,
+        storage: &crate::disk_storage::DiskStorage,
+        zone: &mut ZoneDescriptor,
+    ) -> Result {
+        self.set_zone_condition(storage, zone, ZoneCondition::Offline)
+    }
+
+    pub(crate) fn read_only_zone(
+        &self,
+        storage: &crate::disk_storage::DiskStorage,
+        zone: &mut ZoneDescriptor,
+    ) -> Result {
+        self.set_zone_condition(storage, zone, ZoneCondition::ReadOnly)
+    }
 }
 
 pub(crate) struct ZoneDescriptor {
     start_sector: u64,
     size_sectors: u32,
-    kind: ZoneType,
+    pub(crate) kind: ZoneType,
     capacity_sectors: u32,
     write_pointer: u64,
     condition: ZoneCondition,
@@ -626,7 +659,7 @@ fn check_bounds_read(&self, sector: u64, sectors: u32) -> Result {
 
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 #[repr(u32)]
-enum ZoneType {
+pub(crate) enum ZoneType {
     Conventional = bindings::blk_zone_type_BLK_ZONE_TYPE_CONVENTIONAL,
     SequentialWriteRequired = bindings::blk_zone_type_BLK_ZONE_TYPE_SEQWRITE_REQ,
     #[expect(dead_code)]

-- 
2.51.2


