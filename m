Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F22D8DD0;
	Sun, 15 Feb 2026 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199012; cv=none; b=nArPrvpbe883Aebn6Hc5Q/Pdyg1ZGJtK3gJ3pTjW4yPNsQbVUxJY/t4ndgOMrx5dgUSh8UBIivmLuuy7WmB48PhUVG4SXAt0l426xfCa7+kJXERPzgwr7GmS0dmAzLfDenJ7czLZOt+jOXiaroue4K2RcE+OF8yZ1xcDp3gxcFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199012; c=relaxed/simple;
	bh=jfRXWUNk+a84/VFBlikmsBdhxWC79AwOFf4nhCfPiOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tNd+Q7OntBYGuFSAbGNqa75O2E75uzPSX7Jz70Uco5tFbKwsaYJVS0faj9k+1ead1ty/SxvDVuMgwh7zIXN+BzRUnW79g/aF4J7fZxh6e2LBek382Wvo9ZkarvMq79LWVqgM7sEngwTgy6fpe+nXFLDCZUbLK5w8iWkU25mh0qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npESETd7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npESETd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64296C4CEF7;
	Sun, 15 Feb 2026 23:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199011;
	bh=jfRXWUNk+a84/VFBlikmsBdhxWC79AwOFf4nhCfPiOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=npESETd7O67DGpYTFb+rL0kbo7BEENUW+9w/BOwekeMkm/SeaN6IXItm7GNjmx7rU
	 T+3+UMgYxtJ6Rc7gv2A+jVkgv6e6hrVbz+2aJIMwNokUqC9WoBl8QES1BFWRNYiZPe
	 sCQ5QCeBYNoiq+3cgbcdrRkavuzL0Yg91OOukbFMeMV/r+0yGvOYYTCV4d32QRLqhg
	 XlvU+Q/ghPOi5IHqTMauyeIjpD6gc39IC0A4SalYLvUKpoDxAshOY/pyVCiVYhLKWo
	 xjV07/Ips5/X4yaVzMRaQ5AXPPClGjxRniU5UqIoU3HPwLow4i6Nvi97fuGNWgHVP3
	 4VxaEdCNrJt7w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:46 +0100
Subject: [PATCH 59/79] block: rnull: add fua support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-59-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9832; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=jfRXWUNk+a84/VFBlikmsBdhxWC79AwOFf4nhCfPiOU=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhQw8ujMRzJ2p7zri55eyF3Vun8A9xlTHqMH
 W4XsuY97jKJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYUAAKCRDhuBo+eShj
 dwRcD/96n9UXQln5dGJXotiIswWxCKKyjRXNXiBY86eVdj6gn4Xiy5I01AeeK36jbyoEBeL9QFN
 flAgUj2rf5gSBGnHBJQQ7J5hfKiTja+/SYdAmNHbBP8PRyPg9/ObY9yw6bNkWQGCKInATEZ65NW
 arfHYoM7gbAQ18Sf8nGSraizH2JsSShewdCNu/gcepSwAK9WdjfNx3WoIpRysBfFmkVFDZZzo+L
 2ShgSOQcbYl8lrZSlLOyLD82C3YV87MRnmUJHYr3JYFLOkd34XJ3vWUlikUF8UnkbUR1040gaXR
 tkgKJFbJHn4h5Sp28jW4Ee7AD5Av6dkdpG3FuULVw7QzGlFbOVmyiTYM4zNStl931JtvlyxrWny
 eh0LFTcHlHuzmtcfzZ7Ii3XjbnJ00U0TBwilbM3bLQZUkS5K0WmPJ4cthZcnpPbZJXDOhePWXMz
 nX+R3tST92NvHt/AFcRLFWVjo0HXZYKhDMtDvPNVReDSEDLA6JivAlYbxeqWELq5xXocWusfDKt
 6fLfNGWrW6IYdR6XHP1CXJ5G9z/0ubrFHudCn+i0+YOzLfOLcpE9c2AhpRlsEVXkKEJdyL1Bhq4
 D0JonGantAlFjNUmhkILwWwqz3cmiB/hp5YKE2FGwvMwrDOwA+OUNK8xWL7UPZ0AH9iv3TtUrVN
 saiqiguw56uGiwQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add Forced Unit Access (FUA) support to rnull. When enabled via the `fua`
configfs attribute, the driver advertises FUA capability and handles FUA
requests by bypassing the volatile cache in the write path.

FUA support requires memory backing and write cache to be enabled.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs          |  5 ++++
 drivers/block/rnull/disk_storage.rs      | 22 +++++++++++++---
 drivers/block/rnull/disk_storage/page.rs |  1 +
 drivers/block/rnull/rnull.rs             | 45 ++++++++++++++++++++++++--------
 4 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index e134e21a6b564..816c057f130fc 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -118,6 +118,7 @@ fn make_group(
                 zone_max_active: 25,
                 zone_append_max_sectors: 26,
                 poll_queues: 27,
+                fua: 28,
             ],
         };
 
@@ -158,6 +159,7 @@ fn make_group(
                     zone_max_active: 0,
                     zone_append_max_sectors: u32::MAX,
                     poll_queues: 0,
+                    fua: true,
                 }),
             }),
             core::iter::empty(),
@@ -234,6 +236,7 @@ struct DeviceConfigInner {
     zone_max_active: u32,
     zone_append_max_sectors: u32,
     poll_queues: u32,
+    fua: bool,
 }
 
 #[vtable]
@@ -285,6 +288,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 zone_max_active: guard.zone_max_active,
                 zone_append_max_sectors: guard.zone_append_max_sectors,
                 poll_queues: guard.poll_queues,
+                forced_unit_access: guard.fua,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -527,3 +531,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         }
     }
 );
+configfs_simple_bool_field!(DeviceConfig, 28, fua);
diff --git a/drivers/block/rnull/disk_storage.rs b/drivers/block/rnull/disk_storage.rs
index a613ed5223ba7..b2b5eaa783cdc 100644
--- a/drivers/block/rnull/disk_storage.rs
+++ b/drivers/block/rnull/disk_storage.rs
@@ -92,6 +92,10 @@ pub(crate) fn flush(&self, hw_data: &Pin<&SpinLock<HwQueueContext>>) -> Result {
         let mut access = self.access(&mut tree_guard, &mut hw_data_guard, None);
         access.flush()
     }
+
+    pub(crate) fn cache_enabled(&self) -> bool {
+        self.cache_size > 0
+    }
 }
 
 pub(crate) struct DiskStorageAccess<'a, 'b, 'c> {
@@ -190,7 +194,7 @@ fn flush(&mut self) -> Result {
         Ok(())
     }
 
-    fn get_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
+    fn get_or_alloc_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
         let index = Self::to_index(sector);
 
         if self.cache_guard.contains_index(index) {
@@ -215,6 +219,12 @@ fn get_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
         }
     }
 
+    pub(crate) fn get_cache_page(&mut self, sector: u64) -> Option<&mut NullBlockPage> {
+        let index = Self::to_index(sector);
+
+        self.cache_guard.get_mut(index)
+    }
+
     fn get_disk_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
         let index = Self::to_index(sector);
 
@@ -232,9 +242,13 @@ fn get_disk_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
         Ok(page)
     }
 
-    pub(crate) fn get_write_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
-        let page = if self.disk_storage.cache_size > 0 {
-            self.get_cache_page(sector)?
+    pub(crate) fn get_write_page(
+        &mut self,
+        sector: u64,
+        bypass_cache: bool,
+    ) -> Result<&mut NullBlockPage> {
+        let page = if self.disk_storage.cache_size > 0 && !bypass_cache {
+            self.get_or_alloc_cache_page(sector)?
         } else {
             self.get_disk_page(sector)?
         };
diff --git a/drivers/block/rnull/disk_storage/page.rs b/drivers/block/rnull/disk_storage/page.rs
index a34fe0762724d..728073d5dd23d 100644
--- a/drivers/block/rnull/disk_storage/page.rs
+++ b/drivers/block/rnull/disk_storage/page.rs
@@ -14,6 +14,7 @@
     uapi::PAGE_SECTORS, //
 };
 
+// TODO: Use rust bitmap
 const _CHEKC_STATUS_WIDTH: () = build_assert!((PAGE_SIZE >> SECTOR_SHIFT) <= 64);
 
 pub(crate) struct NullBlockPage {
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 4870aa3b7a53e..3b7edfe7efe44 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -193,6 +193,10 @@
             default: 0,
             description: "Number of IOPOLL submission queues.",
         },
+        fua: u8 {
+            default: 1,
+            description: "Enable/disable FUA support when cache_size is used. Default: 1 (true)",
+        },
     },
 }
 
@@ -250,6 +254,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     zone_max_active: *module_parameters::zone_max_active.value(),
                     zone_append_max_sectors: *module_parameters::zone_append_max_sectors.value(),
                     poll_queues: *module_parameters::poll_queues.value(),
+                    forced_unit_access: *module_parameters::fua.value() != 0,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -298,6 +303,7 @@ struct NullBlkOptions<'a> {
     #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), expect(unused_variables))]
     zone_append_max_sectors: u32,
     poll_queues: u32,
+    forced_unit_access: bool,
 }
 
 static SHARED_TAG_SET: SetOnce<Arc<TagSet<NullBlkDevice>>> = SetOnce::new();
@@ -356,13 +362,11 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             zone_max_active,
             zone_append_max_sectors,
             poll_queues,
+            forced_unit_access,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
 
-        // TODO: lim.features |= BLK_FEAT_WRITE_CACHE;
-        // if (dev->fua)
-        // 	lim.features |= BLK_FEAT_FUA;
         if blocking || memory_backed {
             flags |= mq::tag_set::Flag::Blocking;
         }
@@ -404,9 +408,10 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
 
         let device_capacity_sectors = mib_to_sectors(device_capacity_mib);
 
+        let s = storage.clone();
         let queue_data = Arc::try_pin_init(
             try_pin_init!(Self {
-                storage,
+                storage: s,
                 irq_mode,
                 completion_time,
                 memory_backed,
@@ -439,7 +444,9 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             .capacity_sectors(device_capacity_sectors)
             .logical_block_size(block_size_bytes)?
             .physical_block_size(block_size_bytes)?
-            .rotational(rotational);
+            .rotational(rotational)
+            .write_cache(storage.cache_enabled())
+            .forced_unit_access(forced_unit_access && storage.cache_enabled());
 
         #[cfg(CONFIG_BLK_DEV_ZONED)]
         {
@@ -496,6 +503,7 @@ fn write<'a, 'b, 'c>(
         hw_data_guard: &'b mut SpinLockGuard<'c, HwQueueContext>,
         mut sector: u64,
         mut segment: Segment<'_>,
+        bypass_cache: bool,
     ) -> Result {
         let mut sheaf: Option<XArraySheaf<'_>> = None;
 
@@ -524,12 +532,21 @@ fn write<'a, 'b, 'c>(
 
             let mut access = self.storage.access(tree_guard, hw_data_guard, sheaf);
 
-            let page = access.get_write_page(sector)?;
+            if bypass_cache {
+                if let Some(page) = access.get_cache_page(sector) {
+                    page.set_free(sector);
+                }
+            }
+
+            let page = access.get_write_page(sector, bypass_cache)?;
             page.set_occupied(sector);
             let page_offset = (sector & u64::from(block::SECTOR_MASK)) << block::SECTOR_SHIFT;
 
-            sector += segment.copy_to_page(page.page_mut().get_pin_mut(), page_offset as usize)
-                as u64
+            sector += segment.copy_to_page_limit(
+                page.page_mut().get_pin_mut(),
+                page_offset as usize,
+                self.block_size_bytes.try_into()?,
+            ) as u64
                 >> block::SECTOR_SHIFT;
 
             sheaf = access.sheaf;
@@ -588,6 +605,8 @@ fn transfer(
         let mut hw_data_guard = hw_data.lock();
         let mut tree_guard = self.storage.lock();
 
+        let skip_cache = rq.flags().contains(mq::RequestFlag::ForcedUnitAccess);
+
         for bio in rq.bio_iter_mut() {
             let segment_iter = bio.segment_iter();
             for segment in segment_iter {
@@ -596,9 +615,13 @@ fn transfer(
                     .len()
                     .min((end_sector - sector) as u32 >> SECTOR_SHIFT);
                 match command {
-                    mq::Command::Write => {
-                        self.write(&mut tree_guard, &mut hw_data_guard, sector, segment)?
-                    }
+                    mq::Command::Write => self.write(
+                        &mut tree_guard,
+                        &mut hw_data_guard,
+                        sector,
+                        segment,
+                        skip_cache,
+                    )?,
                     mq::Command::Read => {
                         self.read(&mut tree_guard, &mut hw_data_guard, sector, segment)?
                     }

-- 
2.51.2


