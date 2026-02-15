Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696429D281;
	Sun, 15 Feb 2026 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198855; cv=none; b=piJAuq65eKg0Lxx4a6JTN+obeSk2agUaBHk8oYJ/VoWtAy9csWSnY0+BbpJekGDTpWf/laR6cBYBHKzsZatvAqcH6yAQZNUDHc1nSG5xVOfzmJwF6B4sXMLJcGBfmHgUPWrftT5c/IMhI6jTpgNnJ6o08YHsFNhAf3pXgHmjYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198855; c=relaxed/simple;
	bh=j04tEwwzTSFcwGlD1L1D21qzMW+eJ7IZYJ1Q3R3ScW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgxYnDX1254ZC3C4P5ZXGlP2je3M2t1XSd9WJrZ4ocIleLky7gw2Ga49aqiBeNUSO4LKJCfo9VtSuFu5YoferkWwICzEcTVZzYgEi+NswtnrkB++PbCwfUc9kqj8h0WnJPhjZY8BjVe4wJFN6lzVSvbp4DnYsKwfzGWX1taU7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVgbK22N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVgbK22N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597C9C19422;
	Sun, 15 Feb 2026 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198854;
	bh=j04tEwwzTSFcwGlD1L1D21qzMW+eJ7IZYJ1Q3R3ScW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TVgbK22N5OZBZ4H9uWrbvjMR0p2Jqu3MgtDnuzJWNdhzuEOa64B9d56Owzub6w8F5
	 gtooH/HHmaLk8T6yD1W6jgt8Yj+d2FLEQLVMvaex5FkEXc38wrvpIqq734PL0vQNd1
	 366PBMxPx3XmGnrJ1HoTz57WKaiSfgbojXzVUIuuSmknUT+KiGGwzyJQehUIzZJFRQ
	 a0WE7AQ/EK8Pt2qzKBlsVRRPSiLpDW0j6/SEDBG0Ssy0sps09HZdFZLxhhRGCNRs6k
	 bikh96Yk/8ri49OgQ0OwlGG/fIHKJnwIZSCsuXBtoIWJXdOy2ZYtkYSJj6rhVf8i7x
	 OE56fJP9J/2wA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:18 +0100
Subject: [PATCH 31/79] block: rnull: add volatile cache emulation
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-31-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=33483;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=j04tEwwzTSFcwGlD1L1D21qzMW+eJ7IZYJ1Q3R3ScW4=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg3//wSiEJI3m5TrzNRjHawy887jrK3aePZj
 z+b9mjSOvmJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYNwAKCRDhuBo+eShj
 d81UD/9yrlUyrqQgg6aerlzax0c5mH2sKhm+TJwa8bt1PrrqNaC5kHcxNqyEhJJ9DufHHBQq6pR
 8BS12HhyFkMiq16M+X5CN+BcnlOeBTF4nGwcrxB2L1IKq44ADWzi4NERxbVpaAdORtWDpDxrO3i
 ZCquG43UejchUsx4KPcBY+KoSZAxdMXOu3L0zBrgmw1oEIbAQzyWR57Gma6VfsG3Iy/f6o9xOq3
 JEvva/hQCy79EyTZzLQNs08/ccuWwnsTqO4+VXMqiSBN8A+9LrzCKXEOLrO1foLV3UZZOe/thL4
 vepIDBp+w8/QYI53okog+68K0BjSYazQjw47lrkAqo7gFXpBYq25aDahUQI/aQDimStHXRtkhPh
 b1GPZjRLORVgnbuVkoXq0OXWyH9L0Uxj5Bnnxup+hfmIMgIevlxlsNCFUlqoRZrRs+SsXHpBTAR
 qHpuceqcY9kSJ91kA+dtwKa+hm6h9Y6E/EdLQT/5QxfkdyPkBNRq+TEKw2fhX7RanOxT2B5v7kD
 VQ0KFfU7vBs8B5NpND9YHLd60yCELpMUE3mojICRVpIDzBXy/ylBWJQZYH1Lv/NdzM5t3rhJtyk
 XEVNDcH/ZaMOlVqWJYBEEQtf53BtvUltCcDcwg/5BvZRGJ9pwhdnsKdHVcw2iPwhRYh+Wg0Qbwf
 KJEtCq8AfvRgkBg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add volatile cache emulation to rnull. When enabled via the
`cache_size_mib` configfs attribute, writes are first stored in a volatile
cache before being written back to the simulated non-volatile storage.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs          |  36 +++-
 drivers/block/rnull/disk_storage.rs      | 248 ++++++++++++++++++++++++
 drivers/block/rnull/disk_storage/page.rs |  75 ++++++++
 drivers/block/rnull/rnull.rs             | 316 ++++++++++++++++++-------------
 4 files changed, 538 insertions(+), 137 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index c08a3cbd66f18..d679f12ee6749 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use super::{
+    DiskStorage,
     NullBlkDevice,
     THIS_MODULE, //
 };
+use core::fmt::Write;
 use kernel::{
     bindings,
     block::{
@@ -19,10 +21,7 @@
         AttributeOperations, //
     },
     configfs_attrs,
-    fmt::{
-        self,
-        Write as _, //
-    },
+    fmt,
     new_mutex,
     page::PAGE_SIZE,
     prelude::*,
@@ -105,17 +104,19 @@ fn make_group(
                 badblocks: 12,
                 badblocks_once: 13,
                 badblocks_partial_io: 14,
+                cache_size_mib: 15,
             ],
         };
 
+        let block_size = 4096;
         Ok(configfs::Group::new(
             name.try_into()?,
             item_type,
             // TODO: cannot coerce new_mutex!() to impl PinInit<_, Error>, so put mutex inside
-            try_pin_init!( DeviceConfig {
+            try_pin_init!(DeviceConfig {
                 data <- new_mutex!(DeviceConfigInner {
                     powered: false,
-                    block_size: 4096,
+                    block_size,
                     rotational: false,
                     disk: None,
                     capacity_mib: 4096,
@@ -130,6 +131,11 @@ fn make_group(
                     bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                     bad_blocks_once: false,
                     bad_blocks_partial_io: false,
+                    disk_storage: Arc::pin_init(
+                        DiskStorage::new(0, block_size as usize),
+                        GFP_KERNEL
+                    )?,
+                    cache_size_mib: 0,
                 }),
             }),
             core::iter::empty(),
@@ -192,6 +198,8 @@ struct DeviceConfigInner {
     bad_blocks: Arc<BadBlocks>,
     bad_blocks_once: bool,
     bad_blocks_partial_io: bool,
+    cache_size_mib: u64,
+    disk_storage: Arc<DiskStorage>,
 }
 
 #[vtable]
@@ -230,6 +238,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 bad_blocks: guard.bad_blocks.clone(),
                 bad_blocks_once: guard.bad_blocks_once,
                 bad_blocks_partial_io: guard.bad_blocks_partial_io,
+                storage: guard.disk_storage.clone(),
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -241,6 +250,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
     }
 }
 
+// DiskStorage::new(cache_size_mib << 20, block_size as usize),
 configfs_simple_field!(DeviceConfig, 1, block_size, u32, check GenDiskBuilder::validate_block_size);
 configfs_simple_bool_field!(DeviceConfig, 2, rotational);
 configfs_simple_field!(DeviceConfig, 3, capacity_mib, u64);
@@ -433,3 +443,17 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 
 configfs_simple_bool_field!(DeviceConfig, 13, bad_blocks_once);
 configfs_simple_bool_field!(DeviceConfig, 14, bad_blocks_partial_io);
+configfs_attribute!(DeviceConfig, 15,
+    show: |this, page| show_field(this.data.lock().cache_size_mib, page),
+    store: |this, page| store_with_power_check(this, page, |this, page| {
+        let text = core::str::from_utf8(page)?.trim();
+        let value = text.parse::<u64>().map_err(|_| EINVAL)?;
+        let mut guard = this.data.lock();
+        guard.disk_storage = Arc::pin_init(
+            DiskStorage::new(value, guard.block_size as usize),
+            GFP_KERNEL
+        )?;
+        guard.cache_size_mib = value;
+        Ok(())
+    })
+);
diff --git a/drivers/block/rnull/disk_storage.rs b/drivers/block/rnull/disk_storage.rs
new file mode 100644
index 0000000000000..8a8a90e1cf0bd
--- /dev/null
+++ b/drivers/block/rnull/disk_storage.rs
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HwQueueContext;
+use core::pin::Pin;
+use kernel::{
+    block,
+    new_spinlock,
+    new_xarray,
+    page::PAGE_SIZE,
+    prelude::*,
+    sync::{
+        atomic::{ordering, Atomic},
+        SpinLock, SpinLockGuard,
+    },
+    uapi::PAGE_SECTORS,
+    xarray::{
+        self,
+        XArray,
+        XArraySheaf, //
+    }, //
+};
+pub(crate) use page::NullBlockPage;
+
+mod page;
+
+#[pin_data]
+pub(crate) struct DiskStorage {
+    // TODO: Get rid of this pointer indirection.
+    #[pin]
+    trees: SpinLock<Pin<KBox<TreeContainer>>>,
+    cache_size: u64,
+    cache_size_used: Atomic<u64>,
+    next_flush_sector: Atomic<u64>,
+    block_size: usize,
+}
+
+impl DiskStorage {
+    pub(crate) fn new(cache_size: u64, block_size: usize) -> impl PinInit<Self, Error> {
+        try_pin_init!( Self {
+            // TODO: Get rid of the box
+            // https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/commit/?h=locking&id=a5d84cafb3e253a11d2e078902c5b090be2f4227
+            trees <- new_spinlock!(KBox::pin_init(TreeContainer::new(), GFP_KERNEL)?),
+            cache_size,
+            cache_size_used: Atomic::new(0),
+            next_flush_sector: Atomic::new(0),
+            block_size
+        })
+    }
+
+    pub(crate) fn access<'a, 'b, 'c>(
+        &'a self,
+        tree_guard: &'a mut SpinLockGuard<'b, Pin<KBox<TreeContainer>>>,
+        hw_data_guard: &'a mut SpinLockGuard<'b, HwQueueContext>,
+        sheaf: Option<XArraySheaf<'c>>,
+    ) -> DiskStorageAccess<'a, 'b, 'c> {
+        DiskStorageAccess::new(self, tree_guard, hw_data_guard, sheaf)
+    }
+
+    pub(crate) fn lock(&self) -> SpinLockGuard<'_, Pin<KBox<TreeContainer>>> {
+        self.trees.lock()
+    }
+}
+
+pub(crate) struct DiskStorageAccess<'a, 'b, 'c> {
+    cache_guard: xarray::Guard<'a, TreeNode>,
+    disk_guard: xarray::Guard<'a, TreeNode>,
+    hw_data_guard: &'a mut SpinLockGuard<'b, HwQueueContext>,
+    disk_storage: &'a DiskStorage,
+    pub(crate) sheaf: Option<XArraySheaf<'c>>,
+}
+
+impl<'a, 'b, 'c> DiskStorageAccess<'a, 'b, 'c> {
+    fn new(
+        disk_storage: &'a DiskStorage,
+        tree_guard: &'a mut SpinLockGuard<'b, Pin<KBox<TreeContainer>>>,
+        hw_data_guard: &'a mut SpinLockGuard<'b, HwQueueContext>,
+        sheaf: Option<XArraySheaf<'c>>,
+    ) -> Self {
+        Self {
+            cache_guard: tree_guard.cache_tree.lock(),
+            disk_guard: tree_guard.disk_tree.lock(),
+            hw_data_guard,
+            disk_storage,
+            sheaf,
+        }
+    }
+    fn to_index(sector: u64) -> usize {
+        (sector >> block::PAGE_SECTORS_SHIFT) as usize
+    }
+
+    fn to_sector(index: usize) -> u64 {
+        (index << block::PAGE_SECTORS_SHIFT) as u64
+    }
+
+    fn extract_cache_page(&mut self) -> Result<KBox<NullBlockPage>> {
+        let cache_entry = self
+            .cache_guard
+            .find_next_entry_circular(
+                self.disk_storage.next_flush_sector.load(ordering::Relaxed) as usize
+            )
+            .expect("Expected to find a page in the cache");
+
+        let index = cache_entry.index();
+
+        self.disk_storage
+            .next_flush_sector
+            .store(Self::to_sector(index).wrapping_add(1), ordering::Relaxed);
+
+        self.disk_storage.cache_size_used.store(
+            self.disk_storage.cache_size_used.load(ordering::Relaxed) - PAGE_SIZE as u64,
+            ordering::Relaxed,
+        );
+
+        let page = match self.disk_guard.entry(index) {
+            xarray::Entry::Vacant(disk_entry) => {
+                disk_entry
+                    .insert(cache_entry.remove(), self.sheaf.as_mut())
+                    .expect("Preload is set up to allow insert without failure");
+                self.hw_data_guard
+                    .page
+                    .take()
+                    .expect("Preload has allocated for us")
+            }
+            xarray::Entry::Occupied(mut disk_entry) => {
+                let mut page = if cache_entry.is_full() {
+                    disk_entry.insert(cache_entry.remove())
+                } else {
+                    let mut src = cache_entry;
+                    let mut offset = 0;
+                    for _ in 0..PAGE_SECTORS {
+                        src.page_mut().get_pin_mut().copy_to_page(
+                            disk_entry.page_mut().get_pin_mut(),
+                            offset,
+                            block::SECTOR_SIZE as usize,
+                        )?;
+                        offset += block::SECTOR_SIZE as usize;
+                    }
+                    src.remove()
+                };
+                page.reset();
+                page
+            }
+        };
+
+        Ok(page)
+    }
+
+    fn get_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
+        let index = Self::to_index(sector);
+
+        if self.cache_guard.contains_index(index) {
+            Ok(self.cache_guard.get_mut(index).expect("Index is present"))
+        } else {
+            let page = if self.disk_storage.cache_size_used.load(ordering::Relaxed)
+                < self.disk_storage.cache_size
+            {
+                self.hw_data_guard
+                    .page
+                    .take()
+                    .expect("Expected to have a page available")
+            } else {
+                self.extract_cache_page()?
+            };
+            Ok(self
+                .cache_guard
+                .insert_entry(index, page, self.sheaf.as_mut())
+                .expect("Should be able to insert")
+                .into_mut())
+        }
+    }
+
+    fn get_disk_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
+        let index = Self::to_index(sector);
+
+        let page = match self.disk_guard.entry(index) {
+            xarray::Entry::Vacant(e) => e.insert(
+                self.hw_data_guard
+                    .page
+                    .take()
+                    .expect("Expected page to be available"),
+                self.sheaf.as_mut(),
+            )?,
+            xarray::Entry::Occupied(e) => e.into_mut(),
+        };
+
+        Ok(page)
+    }
+
+    pub(crate) fn get_write_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
+        let page = if self.disk_storage.cache_size > 0 {
+            self.get_cache_page(sector)?
+        } else {
+            self.get_disk_page(sector)?
+        };
+
+        Ok(page)
+    }
+
+    pub(crate) fn get_read_page(&self, sector: u64) -> Option<&NullBlockPage> {
+        let index = Self::to_index(sector);
+        if self.disk_storage.cache_size > 0 {
+            self.cache_guard
+                .get(index)
+                .or_else(|| self.disk_guard.get(index))
+        } else {
+            self.disk_guard.get(index)
+        }
+    }
+
+    fn free_sector_tree(tree_access: &mut xarray::Guard<'_, TreeNode>, sector: u64) {
+        let index = Self::to_index(sector);
+        if let Some(page) = tree_access.get_mut(index) {
+            page.set_free(sector);
+
+            if page.is_empty() {
+                tree_access.remove(index);
+            }
+        }
+    }
+
+    pub(crate) fn free_sector(&mut self, sector: u64) {
+        if self.disk_storage.cache_size > 0 {
+            Self::free_sector_tree(&mut self.cache_guard, sector);
+        }
+
+        Self::free_sector_tree(&mut self.disk_guard, sector);
+    }
+}
+
+type Tree = XArray<TreeNode>;
+type TreeNode = KBox<NullBlockPage>;
+
+#[pin_data]
+pub(crate) struct TreeContainer {
+    #[pin]
+    disk_tree: Tree,
+    #[pin]
+    cache_tree: Tree,
+}
+
+impl TreeContainer {
+    fn new() -> impl PinInit<Self> {
+        pin_init!(TreeContainer {
+            disk_tree <- new_xarray!(xarray::AllocKind::Alloc),
+            cache_tree <- new_xarray!(xarray::AllocKind::Alloc),
+        })
+    }
+}
diff --git a/drivers/block/rnull/disk_storage/page.rs b/drivers/block/rnull/disk_storage/page.rs
new file mode 100644
index 0000000000000..c2e18502cbdda
--- /dev/null
+++ b/drivers/block/rnull/disk_storage/page.rs
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    block::{
+        SECTOR_MASK,
+        SECTOR_SHIFT, //
+    },
+    page::{
+        SafePage,
+        PAGE_SIZE, //
+    },
+    prelude::*,
+    types::Owned,
+    uapi::PAGE_SECTORS, //
+};
+
+const _CHEKC_STATUS_WIDTH: () = build_assert!((PAGE_SIZE >> SECTOR_SHIFT) <= 64);
+
+pub(crate) struct NullBlockPage {
+    page: Owned<SafePage>,
+    status: u64,
+    block_size: usize,
+}
+
+impl NullBlockPage {
+    pub(crate) fn new(block_size: usize) -> Result<KBox<Self>> {
+        Ok(KBox::new(
+            Self {
+                page: SafePage::alloc_page(GFP_NOIO | __GFP_ZERO)?,
+                status: 0,
+                block_size,
+            },
+            GFP_NOIO,
+        )?)
+    }
+
+    pub(crate) fn set_occupied(&mut self, sector: u64) {
+        let idx = sector & u64::from(SECTOR_MASK);
+        self.status |= 1 << idx;
+    }
+
+    pub(crate) fn set_free(&mut self, sector: u64) {
+        let idx = sector & u64::from(SECTOR_MASK);
+        self.status &= !(1 << idx);
+    }
+
+    pub(crate) fn is_empty(&self) -> bool {
+        self.status == 0
+    }
+
+    pub(crate) fn reset(&mut self) {
+        self.status = 0;
+    }
+
+    pub(crate) fn is_full(&self) -> bool {
+        let blocks_per_page = PAGE_SIZE >> self.block_size.trailing_zeros();
+        let shift = PAGE_SECTORS as usize / blocks_per_page;
+
+        for i in 0..blocks_per_page {
+            if self.status & (1 << (i * shift)) == 0 {
+                return false;
+            }
+        }
+
+        true
+    }
+
+    pub(crate) fn page_mut(&mut self) -> &mut Owned<SafePage> {
+        &mut self.page
+    }
+
+    pub(crate) fn page(&self) -> &Owned<SafePage> {
+        &self.page
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 4e226186d2f36..cca497aef40df 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -3,13 +3,22 @@
 //! This is a Rust implementation of the C null block driver.
 
 mod configfs;
+mod disk_storage;
 
 use configfs::IRQMode;
+use disk_storage::{
+    DiskStorage,
+    NullBlockPage,
+    TreeContainer, //
+};
 use kernel::{
     bindings,
     block::{
         self,
-        badblocks::{self, BadBlocks},
+        badblocks::{
+            self,
+            BadBlocks, //
+        },
         bio::Segment,
         mq::{
             self,
@@ -20,7 +29,7 @@
             Operations,
             TagSet, //
         },
-        SECTOR_MASK, SECTOR_SHIFT,
+        SECTOR_SHIFT,
     },
     error::{
         code,
@@ -28,11 +37,7 @@
     },
     ffi,
     new_mutex,
-    new_xarray,
-    page::{
-        SafePage,
-        PAGE_SIZE, //
-    },
+    new_spinlock,
     pr_info,
     prelude::*,
     str::CString,
@@ -41,9 +46,11 @@
         atomic::{
             ordering,
             Atomic, //
-        },
+        }, //
         Arc,
-        Mutex, //
+        Mutex,
+        SpinLock,
+        SpinLockGuard,
     },
     time::{
         hrtimer::{
@@ -58,7 +65,7 @@
         OwnableRefCounted,
         Owned, //
     },
-    xarray::XArray, //
+    xarray::XArraySheaf, //
 };
 use pin_init::PinInit;
 
@@ -148,9 +155,11 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                 } else {
                     *module_parameters::submit_queues.value()
                 };
+
+                let block_size = *module_parameters::bs.value();
                 let disk = NullBlkDevice::new(NullBlkOptions {
                     name: &name,
-                    block_size: *module_parameters::bs.value(),
+                    block_size,
                     rotational: *module_parameters::rotational.value() != 0,
                     capacity_mib: *module_parameters::gb.value() * 1024,
                     irq_mode: (*module_parameters::irqmode.value()).try_into()?,
@@ -163,6 +172,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                     bad_blocks_once: false,
                     bad_blocks_partial_io: false,
+                    storage: Arc::pin_init(DiskStorage::new(0, block_size as usize), GFP_KERNEL)?,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -192,8 +202,20 @@ struct NullBlkOptions<'a> {
     bad_blocks: Arc<BadBlocks>,
     bad_blocks_once: bool,
     bad_blocks_partial_io: bool,
+    storage: Arc<DiskStorage>,
+}
+
+#[pin_data]
+struct NullBlkDevice {
+    storage: Arc<DiskStorage>,
+    irq_mode: IRQMode,
+    completion_time: Delta,
+    memory_backed: bool,
+    block_size: usize,
+    bad_blocks: Arc<BadBlocks>,
+    bad_blocks_once: bool,
+    bad_blocks_partial_io: bool,
 }
-struct NullBlkDevice;
 
 impl NullBlkDevice {
     fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
@@ -212,10 +234,14 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             bad_blocks,
             bad_blocks_once,
             bad_blocks_partial_io,
+            storage,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
 
+        // TODO: lim.features |= BLK_FEAT_WRITE_CACHE;
+        // if (dev->fua)
+        // 	lim.features |= BLK_FEAT_FUA;
         if memory_backed {
             flags |= mq::tag_set::Flag::Blocking;
         }
@@ -233,13 +259,13 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             GFP_KERNEL,
         )?;
 
-        let queue_data = Box::pin_init(
-            pin_init!(QueueData {
-                tree <- new_xarray!(kernel::xarray::AllocKind::Alloc),
+        let queue_data = Box::try_pin_init(
+            try_pin_init!(Self {
+                storage,
                 irq_mode,
                 completion_time,
                 memory_backed,
-                block_size: block_size.into(),
+                block_size: block_size as usize,
                 bad_blocks,
                 bad_blocks_once,
                 bad_blocks_partial_io,
@@ -262,68 +288,133 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
         builder.build(fmt!("{}", name.to_str()?), tagset, queue_data)
     }
 
+    fn sheaf_size() -> usize {
+        2 * ((usize::BITS as usize / bindings::XA_CHUNK_SHIFT)
+            + if (usize::BITS as usize % bindings::XA_CHUNK_SHIFT) == 0 {
+                0
+            } else {
+                1
+            })
+    }
+
+    fn preload<'b, 'c>(
+        tree_guard: &'b mut SpinLockGuard<'c, Pin<KBox<TreeContainer>>>,
+        hw_data_guard: &'b mut SpinLockGuard<'c, HwQueueContext>,
+        block_size: usize,
+    ) -> Result {
+        if hw_data_guard.page.is_none() {
+            hw_data_guard.page =
+                Some(tree_guard.do_unlocked(|| {
+                    hw_data_guard.do_unlocked(|| NullBlockPage::new(block_size))
+                })?);
+        }
+
+        Ok(())
+    }
+
     #[inline(always)]
-    fn write(tree: &Tree, mut sector: u64, mut segment: Segment<'_>) -> Result {
+    fn write<'a, 'b, 'c>(
+        &'a self,
+        tree_guard: &'b mut SpinLockGuard<'c, Pin<KBox<TreeContainer>>>,
+        hw_data_guard: &'b mut SpinLockGuard<'c, HwQueueContext>,
+        mut sector: u64,
+        mut segment: Segment<'_>,
+    ) -> Result {
+        let mut sheaf: Option<XArraySheaf<'_>> = None;
+
         while !segment.is_empty() {
-            let page = NullBlockPage::new()?;
-            let mut tree = tree.lock();
+            Self::preload(tree_guard, hw_data_guard, self.block_size)?;
 
-            let page_idx = sector >> block::PAGE_SECTORS_SHIFT;
+            match &mut sheaf {
+                Some(sheaf) => {
+                    tree_guard.do_unlocked(|| {
+                        hw_data_guard.do_unlocked(|| sheaf.refill(GFP_KERNEL, Self::sheaf_size()))
+                    })?;
+                }
+                None => {
+                    let _ = sheaf.insert(
+                        kernel::xarray::xarray_kmem_cache()
+                            .sheaf(Self::sheaf_size(), GFP_NOWAIT)
+                            .or(tree_guard.do_unlocked(|| {
+                                hw_data_guard.do_unlocked(|| -> Result<_> {
+                                    kernel::xarray::xarray_kmem_cache()
+                                        .sheaf(Self::sheaf_size(), GFP_KERNEL)
+                                })
+                            }))?,
+                    );
+                }
+            }
 
-            let page = if let Some(page) = tree.get_mut(page_idx as usize) {
-                page
-            } else {
-                tree.store(page_idx as usize, page, GFP_NOIO)?;
-                tree.get_mut(page_idx as usize).unwrap()
-            };
+            let mut access = self.storage.access(tree_guard, hw_data_guard, sheaf);
 
+            let page = access.get_write_page(sector)?;
             page.set_occupied(sector);
             let page_offset = (sector & u64::from(block::SECTOR_MASK)) << block::SECTOR_SHIFT;
-            sector += segment.copy_to_page(page.page.get_pin_mut(), page_offset as usize) as u64
+
+            sector += segment.copy_to_page(page.page_mut().get_pin_mut(), page_offset as usize)
+                as u64
                 >> block::SECTOR_SHIFT;
+
+            sheaf = access.sheaf;
+        }
+
+        if let Some(sheaf) = sheaf {
+            tree_guard.do_unlocked(|| {
+                hw_data_guard.do_unlocked(|| {
+                    sheaf.return_refill(GFP_KERNEL);
+                })
+            });
         }
+
         Ok(())
     }
 
     #[inline(always)]
-    fn read(tree: &Tree, mut sector: u64, mut segment: Segment<'_>) -> Result {
-        let tree = tree.lock();
+    fn read<'a, 'b, 'c>(
+        &'a self,
+        tree_guard: &'b mut SpinLockGuard<'c, Pin<KBox<TreeContainer>>>,
+        hw_data_guard: &'b mut SpinLockGuard<'c, HwQueueContext>,
+        mut sector: u64,
+        mut segment: Segment<'_>,
+    ) -> Result {
+        let access = self.storage.access(tree_guard, hw_data_guard, None);
 
         while !segment.is_empty() {
-            let idx = sector >> block::PAGE_SECTORS_SHIFT;
-
-            if let Some(page) = tree.get(idx as usize) {
-                let page_offset = (sector & u64::from(block::SECTOR_MASK)) << block::SECTOR_SHIFT;
-                sector += segment.copy_from_page(&page.page, page_offset as usize) as u64
-                    >> block::SECTOR_SHIFT;
-            } else {
-                sector += segment.zero_page() as u64 >> block::SECTOR_SHIFT;
+            let page = access.get_read_page(sector);
+
+            match page {
+                Some(page) => {
+                    let page_offset =
+                        (sector & u64::from(block::SECTOR_MASK)) << block::SECTOR_SHIFT;
+                    sector += segment.copy_from_page(page.page(), page_offset as usize) as u64
+                        >> block::SECTOR_SHIFT;
+                }
+                None => sector += segment.zero_page() as u64 >> block::SECTOR_SHIFT,
             }
         }
 
         Ok(())
     }
 
-    fn discard(tree: &Tree, mut sector: u64, sectors: u64, block_size: u64) -> Result {
-        let mut remaining_bytes = sectors << SECTOR_SHIFT;
-        let mut tree = tree.lock();
+    fn discard(
+        &self,
+        hw_data: &Pin<&SpinLock<HwQueueContext>>,
+        mut sector: u64,
+        sectors: u32,
+    ) -> Result {
+        let mut tree_guard = self.storage.lock();
+        let mut hw_data_guard = hw_data.lock();
 
-        while remaining_bytes > 0 {
-            let page_idx = sector >> block::PAGE_SECTORS_SHIFT;
-            let mut remove = false;
-            if let Some(page) = tree.get_mut(page_idx as usize) {
-                page.set_free(sector);
-                if page.is_empty() {
-                    remove = true;
-                }
-            }
+        let mut access = self
+            .storage
+            .access(&mut tree_guard, &mut hw_data_guard, None);
 
-            if remove {
-                drop(tree.remove(page_idx as usize))
-            }
+        let mut remaining_bytes = (sectors as usize) << SECTOR_SHIFT;
 
-            let processed = remaining_bytes.min(block_size);
-            sector += processed >> SECTOR_SHIFT;
+        while remaining_bytes > 0 {
+            access.free_sector(sector);
+            let processed = remaining_bytes.min(self.block_size);
+            sector += (processed >> SECTOR_SHIFT) as u64;
             remaining_bytes -= processed;
         }
 
@@ -331,21 +422,34 @@ fn discard(tree: &Tree, mut sector: u64, sectors: u64, block_size: u64) -> Resul
     }
 
     #[inline(never)]
-    fn transfer(rq: &mut Owned<mq::Request<Self>>, tree: &Tree, sectors: u32) -> Result {
+    fn transfer(
+        &self,
+        hw_data: &Pin<&SpinLock<HwQueueContext>>,
+        rq: &mut Owned<mq::Request<Self>>,
+        sectors: u32,
+    ) -> Result {
         let mut sector = rq.sector();
         let end_sector = sector + <u32 as Into<u64>>::into(sectors);
         let command = rq.command();
 
+        // TODO: Use `PerCpu` to get rid of this lock
+        let mut hw_data_guard = hw_data.lock();
+        let mut tree_guard = self.storage.lock();
+
         for bio in rq.bio_iter_mut() {
             let segment_iter = bio.segment_iter();
             for segment in segment_iter {
                 // Length might be limited by bad blocks.
                 let length = segment
                     .len()
-                    .min((sector - end_sector) as u32 >> SECTOR_SHIFT);
+                    .min((end_sector - sector) as u32 >> SECTOR_SHIFT);
                 match command {
-                    bindings::req_op_REQ_OP_WRITE => Self::write(tree, sector, segment)?,
-                    bindings::req_op_REQ_OP_READ => Self::read(tree, sector, segment)?,
+                    bindings::req_op_REQ_OP_WRITE => {
+                        self.write(&mut tree_guard, &mut hw_data_guard, sector, segment)?
+                    }
+                    bindings::req_op_REQ_OP_READ => {
+                        self.read(&mut tree_guard, &mut hw_data_guard, sector, segment)?
+                    }
                     _ => (),
                 }
                 sector += u64::from(length) >> SECTOR_SHIFT;
@@ -355,29 +459,26 @@ fn transfer(rq: &mut Owned<mq::Request<Self>>, tree: &Tree, sectors: u32) -> Res
                 }
             }
         }
+
         Ok(())
     }
 
-    fn handle_bad_blocks(
-        rq: &mut Owned<mq::Request<Self>>,
-        queue_data: &QueueData,
-        sectors: &mut u32,
-    ) -> Result {
-        if queue_data.bad_blocks.enabled() {
+    fn handle_bad_blocks(&self, rq: &mut Owned<mq::Request<Self>>, sectors: &mut u32) -> Result {
+        if self.bad_blocks.enabled() {
             let start = rq.sector();
             let end = start + u64::from(*sectors);
-            match queue_data.bad_blocks.check(start..end) {
+            match self.bad_blocks.check(start..end) {
                 badblocks::BlockStatus::None => {}
                 badblocks::BlockStatus::Acknowledged(mut range)
                 | badblocks::BlockStatus::Unacknowledged(mut range) => {
                     rq.data_ref().error.store(1, ordering::Relaxed);
 
-                    if queue_data.bad_blocks_once {
-                        queue_data.bad_blocks.set_good(range.clone())?;
+                    if self.bad_blocks_once {
+                        self.bad_blocks.set_good(range.clone())?;
                     }
 
-                    if queue_data.bad_blocks_partial_io {
-                        let block_size_sectors = queue_data.block_size >> SECTOR_SHIFT;
+                    if self.bad_blocks_partial_io {
+                        let block_size_sectors = (self.block_size >> SECTOR_SHIFT) as u64;
                         range.start = align_down(range.start, block_size_sectors);
                         if start < range.start {
                             *sectors = (range.start - start) as u32;
@@ -402,53 +503,8 @@ fn end_request(rq: Owned<mq::Request<Self>>) {
     }
 }
 
-const _CHEKC_STATUS_WIDTH: () = build_assert!((PAGE_SIZE >> SECTOR_SHIFT) <= 64);
-
-struct NullBlockPage {
-    page: Owned<SafePage>,
-    status: u64,
-}
-
-impl NullBlockPage {
-    fn new() -> Result<KBox<Self>> {
-        Ok(KBox::new(
-            Self {
-                page: SafePage::alloc_page(GFP_NOIO | __GFP_ZERO)?,
-                status: 0,
-            },
-            GFP_NOIO,
-        )?)
-    }
-
-    fn set_occupied(&mut self, sector: u64) {
-        let idx = sector & u64::from(SECTOR_MASK);
-        self.status |= 1 << idx;
-    }
-
-    fn set_free(&mut self, sector: u64) {
-        let idx = sector & u64::from(SECTOR_MASK);
-        self.status &= !(1 << idx);
-    }
-
-    fn is_empty(&self) -> bool {
-        self.status == 0
-    }
-}
-
-type TreeNode = KBox<NullBlockPage>;
-type Tree = XArray<TreeNode>;
-
-#[pin_data]
-struct QueueData {
-    #[pin]
-    tree: Tree,
-    irq_mode: IRQMode,
-    completion_time: Delta,
-    memory_backed: bool,
-    block_size: u64,
-    bad_blocks: Arc<BadBlocks>,
-    bad_blocks_once: bool,
-    bad_blocks_partial_io: bool,
+struct HwQueueContext {
+    page: Option<KBox<disk_storage::NullBlockPage>>,
 }
 
 #[pin_data]
@@ -503,10 +559,10 @@ fn align_down<T>(value: T, to: T) -> T
 
 #[vtable]
 impl Operations for NullBlkDevice {
-    type QueueData = Pin<KBox<QueueData>>;
+    type QueueData = Pin<KBox<Self>>;
     type RequestData = Pdu;
     type TagSetData = ();
-    type HwData = ();
+    type HwData = Pin<KBox<SpinLock<HwQueueContext>>>;
 
     fn new_request_data() -> impl PinInit<Self::RequestData> {
         pin_init!(Pdu {
@@ -517,41 +573,39 @@ fn new_request_data() -> impl PinInit<Self::RequestData> {
 
     #[inline(always)]
     fn queue_rq(
-        _hw_data: (),
-        queue_data: Pin<&QueueData>,
+        hw_data: Pin<&SpinLock<HwQueueContext>>,
+        this: Pin<&Self>,
         mut rq: Owned<mq::Request<Self>>,
         _is_last: bool,
     ) -> Result {
         let mut sectors = rq.sectors();
 
-        Self::handle_bad_blocks(&mut rq, queue_data.get_ref(), &mut sectors)?;
-
-        if queue_data.memory_backed {
-            let tree = &queue_data.tree;
+        Self::handle_bad_blocks(this.get_ref(), &mut rq, &mut sectors)?;
 
+        if this.memory_backed {
             if rq.command() == bindings::req_op_REQ_OP_DISCARD {
-                Self::discard(tree, rq.sector(), sectors.into(), queue_data.block_size)?;
+                this.discard(&hw_data, rq.sector(), sectors)?;
             } else {
-                Self::transfer(&mut rq, tree, sectors)?;
+                this.transfer(&hw_data, &mut rq, sectors)?;
             }
         }
 
-        match queue_data.irq_mode {
+        match this.irq_mode {
             IRQMode::None => Self::end_request(rq),
             IRQMode::Soft => mq::Request::complete(rq.into()),
             IRQMode::Timer => {
                 OwnableRefCounted::into_shared(rq)
-                    .start(queue_data.completion_time)
+                    .start(this.completion_time)
                     .dismiss();
             }
         }
         Ok(())
     }
 
-    fn commit_rqs(_hw_data: (), _queue_data: Pin<&QueueData>) {}
+    fn commit_rqs(_hw_data: Pin<&SpinLock<HwQueueContext>>, _queue_data: Pin<&Self>) {}
 
-    fn init_hctx(_tagset_data: (), _hctx_idx: u32) -> Result {
-        Ok(())
+    fn init_hctx(_tagset_data: (), _hctx_idx: u32) -> Result<Self::HwData> {
+        KBox::pin_init(new_spinlock!(HwQueueContext { page: None }), GFP_KERNEL)
     }
 
     fn complete(rq: ARef<mq::Request<Self>>) {

-- 
2.51.2


