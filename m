Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA384EA37B;
	Tue,  9 Jun 2026 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032380; cv=none; b=UkBSZN8zicKF/gOB1VRpGYYllezF9cLdcwQXzCj5EE0sQAV3KPzlWWF2+unvukCni5xbPuwLfgQDczjZWjZangh/ConKgn1+Iks8V43qquoucZcf/3NxTNINLZpB/orRsV7l+3tjBdy9xIlptbxc1Cv5/TiNB2khV7Bq1ia/Grg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032380; c=relaxed/simple;
	bh=T3pkCjSoqlz/5eAmoml0zuQJKOlZemt616lr74wbC6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FuOtRjKbMAHsUpi9/H6ewYOFTYXMBavEuITna+94yG3iTsYgPVxh6pTc5uXnhm7Fe8VcxU59YkFT4uk5B5X8kezUNiDrOf4u6teMncwJ4keTgUnvagzL+wwORGbYAP27lUja+YNfHDAiA9eqW2kCjfQ8jd4n1vup8s+oz2rSYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/lEsSss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/lEsSss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E301F00893;
	Tue,  9 Jun 2026 19:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032379;
	bh=as5ubVXy9pDah6a38S1Rm853FewwW17NrvS6Iq2Oams=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=H/lEsSssWyII8rY8RleQpGtSmi85awUyW7eU8iflg601qoIsT4qvYikr89gNkQ9En
	 kpHtW+3/uHGG0TQLBmeLNw4LNRWw9HxF1h1SsrzJVmefWnkA0GJBdqgBqcSDdifXK+
	 BJ3OGGtsAmojbqYNtD2QRYQoxG2VwRH3b5UaRJp6C1csUcgiQ42EG3BcXVWWfwxJIe
	 BmF2GyFgl5qXK0j/NGKK8XWulaEixftONEsoWE9ClN+AXkmLxtx7Pfx3/ejBB3vDxX
	 tneJSr04kv1HM5s95zRZlMrMR7bhLMt3o5nGzJpRo1QEht8RBBtk504u3WHLdFQf6g
	 4U6JzxI2Ar/Jg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:09:02 +0200
Subject: [PATCH v2 83/83] block: rnull: add zone offline and readonly
 configfs files
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-83-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15517;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=T3pkCjSoqlz/5eAmoml0zuQJKOlZemt616lr74wbC6g=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT/2B21XD7rkanWLOYqJi6E0g5N/32wBgJiA
 UCG8Z2zaGOJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk/wAKCRD6UCkIqsW9
 0A+vD/4/R6jsny4DtPvTLS1Zr0bhgTMsff+cmB0ZHGOBF9MtJTa/RQYLe0TMvKsNc/IkT+Kgmvm
 A5i9CAXdoH9F+qJN5qNlaD2zK7Z1OuHFiEP//e3oPSP6dML1WQDU+tQL/podg/speszIl1GvbcY
 BvDSKpJuEWoNNjKCqTRjJD8LNKMNjTrags41FXp45aiVXyDpR6c3e7nOgjOBHbxMNSnL3D9aEzr
 zXaxnRtik7GXFMqqggZ9npK1ksk33uqIBLNVWz9TTnlwt7lPph4vfOjBreeKPI5slUKaXv0dOb1
 9LBh+pu4tvgbpXJoC1qxZv51uD1g3fP6nXyxBZL5iSLBJGNBRUy8ytmLuAToScyG+NMXMSQymn7
 L/1gju6Hg7GQWX1PDXvkGpFZhYwZcgq8uH59xstBP80I79wcq3bWBqBbobtIKsfMCEsFxt23ylr
 JaOG1XYJ0t89feKumt9mtu32Eavil0dSQG2KICfpsAUhDEQFIR4BoiwlMxmOgnO3AMEyWmLupe8
 3Mp4lwR3QoWLERLfx1owl6xHJKDTNyjY+IaccJTfGP0cK2ONl56Fe4s26NwF/CwXoKD18W8zbtJ
 pGeyYuKoT6AppvcmtiANY3tEOldxVP9uH5e8HeoYdl4NnQnS8v35lObymH6iOA+ZUtPAhdPWaC0
 B5YQyVZzCWRu3zQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add configfs attributes for managing zone states in the rnull zoned
block device emulation. The `zone_offline` and `zone_readonly`
attributes allow setting specific zones to offline or read-only states,
which is useful for testing how applications handle degraded zones.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs     | 76 +++++++++++++++++++++++++++++++++
 drivers/block/rnull/disk_storage.rs | 59 +++++++++++++-------------
 drivers/block/rnull/rnull.rs        |  2 +-
 drivers/block/rnull/zoned.rs        | 83 ++++++++++++++++++++++++++-----------
 4 files changed, 164 insertions(+), 56 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 1bab38c55698..43d01b419579 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -135,6 +135,8 @@ fn make_group(
                 max_sectors: 29,
                 virt_boundary: 30,
                 shared_tag_bitmap: 31,
+                zone_offline: 32,
+                zone_readonly: 33,
             ],
         };
 
@@ -627,3 +629,77 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
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
+    show: |_this, _page| Ok(0),
+    store: |_this, _page| Err(ENOTSUPP),
+);
+
+#[cfg(not(CONFIG_BLK_DEV_ZONED))]
+configfs_attribute!(
+    DeviceConfig,
+    33,
+    show: |_this, _page| Ok(0),
+    store: |_this, _page| Err(ENOTSUPP),
+);
diff --git a/drivers/block/rnull/disk_storage.rs b/drivers/block/rnull/disk_storage.rs
index 6797b7996da3..879dd5d96e65 100644
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
@@ -286,25 +304,6 @@ pub(crate) fn get_read_page(&self, sector: u64) -> Option<&NullBlockPage> {
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
 
 type TreeNode = KBox<NullBlockPage>;
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 81f9e2d03f31..b6371fe4ebeb 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -798,7 +798,7 @@ fn handle_regular_command(
         if self.memory_backed {
             memalloc_scope!(let _noio: NoIo);
             if rq.command() == mq::Command::Discard {
-                self.storage.discard(hw_data, rq.sector(), sectors);
+                self.storage.discard(rq.sector(), sectors);
             } else {
                 self.transfer(hw_data, rq, rq.command(), sectors)?;
             }
diff --git a/drivers/block/rnull/zoned.rs b/drivers/block/rnull/zoned.rs
index 808449cc49e1..cf0eb5d31840 100644
--- a/drivers/block/rnull/zoned.rs
+++ b/drivers/block/rnull/zoned.rs
@@ -179,7 +179,7 @@ pub(crate) fn handle_zoned_command(
         match rq.command() {
             ZoneAppend | Write => self.zoned_write(hw_data, rq)?,
             ZoneReset | ZoneResetAll | ZoneOpen | ZoneClose | ZoneFinish => {
-                self.zone_management(hw_data, rq)?
+                self.zone_management(rq)?
             }
             _ => self.zoned_read(hw_data, rq)?,
         }
@@ -187,18 +187,14 @@ pub(crate) fn handle_zoned_command(
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
 
@@ -214,10 +210,10 @@ fn zone_management(
 
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
@@ -283,7 +279,7 @@ fn zoned_write(
             if self.zoned.use_accounting() {
                 let mut accounting = self.zoned.accounting.lock();
                 self.zoned
-                    .check_zone_resources(&mut accounting, &mut zone, rq.sector())?;
+                    .check_zone_resources(&mut accounting, &mut zone)?;
 
                 if zone.condition == ZoneCondition::Closed {
                     accounting.closed -= 1;
@@ -367,7 +363,7 @@ fn zone_no(&self, sector: u64) -> usize {
         (sector >> self.size_sectors.ilog2()) as usize
     }
 
-    fn zone(&self, sector: u64) -> Result<&Mutex<ZoneDescriptor>> {
+    pub(crate) fn zone(&self, sector: u64) -> Result<&Mutex<ZoneDescriptor>> {
         self.zones.get(self.zone_no(sector)).ok_or(EINVAL)
     }
 
@@ -420,7 +416,7 @@ fn try_close_implicit_open_zone(&self, accounting: &mut ZoneAccounting, sector:
         Err(EINVAL)
     }
 
-    fn open_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
+    fn open_zone(&self, zone: &mut ZoneDescriptor) -> Result {
         if zone.kind == ZoneType::Conventional {
             return Err(EINVAL);
         }
@@ -436,13 +432,13 @@ fn open_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
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
@@ -459,14 +455,13 @@ fn check_zone_resources(
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
@@ -535,7 +530,7 @@ fn close_zone(&self, zone: &mut ZoneDescriptor) -> Result {
         Ok(())
     }
 
-    fn finish_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
+    fn finish_zone(&self, zone: &mut ZoneDescriptor) -> Result {
         if zone.kind == ZoneType::Conventional {
             return Err(EINVAL);
         }
@@ -547,12 +542,12 @@ fn finish_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
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
@@ -568,7 +563,6 @@ fn finish_zone(&self, zone: &mut ZoneDescriptor, sector: u64) -> Result {
     fn reset_zone(
         &self,
         storage: &crate::disk_storage::DiskStorage,
-        hw_data: &Pin<&SpinLock<HwQueueContext>>,
         zone: &mut ZoneDescriptor,
     ) -> Result {
         if zone.kind == ZoneType::Conventional {
@@ -591,16 +585,55 @@ fn reset_zone(
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
@@ -628,7 +661,7 @@ fn check_bounds_read(&self, sector: u64, sectors: u32) -> Result {
 
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 #[repr(u32)]
-enum ZoneType {
+pub(crate) enum ZoneType {
     Conventional = bindings::blk_zone_type_BLK_ZONE_TYPE_CONVENTIONAL,
     SequentialWriteRequired = bindings::blk_zone_type_BLK_ZONE_TYPE_SEQWRITE_REQ,
     #[expect(dead_code)]

-- 
2.51.2


