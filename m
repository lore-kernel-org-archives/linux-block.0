Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67740F33E;
	Tue,  9 Jun 2026 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032506; cv=none; b=eIhg+VMBfaKUEYVoS1VAcatkOR3VmKYruDcvDvOZMoOr8bcaOAVfdJehPkIF56Vk7gZyUpukxa8h/jqI0bhiHP493hkdTXHdUONT3XuTdTv32TqYYgaRdhcFw7KFYRtm5PInf0E+bc9chAgQ9q7EcoQ2VOsSSzouFIVUUINUjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032506; c=relaxed/simple;
	bh=5ZDAw2d4+wjEV9WBL84Feycxe65EY0rEcU1DrNk0Mw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jC0eUZBDCQHz/xqpuD8GriDBp4fKLN9Z4RXG17q8u2FafZZURBvuHwvL/wZNGZKSw6aWVhj6zrPf6TK+4WBS2QQduZXWYmGIB+QfSSstfOBeIaOGTN9P9msj35qsRXY20gDQxff3m/fKxgkmlCx2ikLfutfTHG8YdqHiiuc4QV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkYwzbAL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkYwzbAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89CC1F00893;
	Tue,  9 Jun 2026 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032504;
	bh=q3myJXRVGS6pYA1Jmu7PlFD54lLFsKGWr7dOlhEJ36M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gkYwzbAL3t+TSX+8S2eqNxw5+5hJ2hR7DgJKhsh5ygCRD0DYuIGmtF3S5OWlI+DVD
	 ILLbpjWp+pDxlHlOYGcnblEmUuPPIRTHjRvTiFOyHiunLV/QJOnjkxMjAWwRA9TK9i
	 KWbpl5H8TVsheFt6uMxykY9rMLURh3tpn5+QokX/tXdadPoqfceb8qqQnSxLsoDBmv
	 BqyjGIiAteBuMUtxlAN6yt8up8N2DksEUKxVNizJE+q1L05eomwtP7QxORbiItN+OH
	 3ggY4CnFywEKYgfiiKjHDLixFHHp/OjC8w6hWJw97swZxczPO3y0UWEup+I0fEMABd
	 JKkTHWq9iIPUQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:43 +0200
Subject: [PATCH v2 64/83] block: rnull: add fua support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-64-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9701; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=5ZDAw2d4+wjEV9WBL84Feycxe65EY0rEcU1DrNk0Mw4=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTuAz1cLMPwLLtPPjzuLS1WhD7/D4OChQeKr
 pc/tbbTv1uJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk7gAKCRD6UCkIqsW9
 0J+LD/9XjmhK/H/XcSIv69e4TN+NKqL0T1jXIEseBLH5bopZMhMPXWkyh1lge+JOmGGhxTVWf06
 v1sTI+3NDDjThUEBexq+7f04qpcqDniA5Afj0/4q80EkTnrDxvxvJ2K6nInRKPOQlKXv8PzeaEO
 xNB0HJ4a9Q/kkqA4SKicjU2Pe7CJxNQ5C4pcveQXfk4y0lvHPyFKUV8XpZlp8W+XVMmBRwxG3qz
 ZVFn2dEEMFRumjbRpmX4RR4DvXCn8RbjAfNX2pPToQELTWesuFzNuIw0nZ6pJ9TbbSN55DnFjz7
 pNu18c1OrN9SDAZ5GoGESpohSljq2tgIsr3vWJhJ7Ca04rreJC3JmFFCxYu0wqQzDScSQNDe5lI
 Hv3MI0PMPcwh5Fu6b1PyULbRSJ3zdQcUiOT4o9mLA12NFyT6FMw6LqkRJZAazr8vi7JPKvajAwW
 P5gLITw5nAK0qaw18VeDRmOy2bLb1zkUD98+76ABmpu3wwQ75avD6rtrQtHYVz878xBn7EJwTKP
 A3LQnUm+8l8IlxbBcvzIi7ffkuzxmXRzHBg7qnRrLNPfEpp4Ol1O1nd3Pyz0b24W62iKTipVbW/
 MSC9TH0wSw8vZMNsICXBL4zx2PJ/2VU9q3p43i9asDn2CGoD9gJ417TwpytDtCuRJTgTtWfnxPP
 2c0V/Y8qBmsVUgw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add Forced Unit Access (FUA) support to rnull. When enabled via the `fua`
configfs attribute, the driver advertises FUA capability and handles FUA
requests by bypassing the volatile cache in the write path.

FUA support requires memory backing and write cache to be enabled.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs          |  5 ++++
 drivers/block/rnull/disk_storage.rs      | 22 +++++++++++++----
 drivers/block/rnull/disk_storage/page.rs |  1 +
 drivers/block/rnull/rnull.rs             | 41 ++++++++++++++++++++++++++------
 4 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 0637c1e0ab22..8195d645ecc6 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -128,6 +128,7 @@ fn make_group(
                 zone_max_active: 25,
                 zone_append_max_sectors: 26,
                 poll_queues: 27,
+                fua: 28,
             ],
         };
 
@@ -169,6 +170,7 @@ fn make_group(
                     zone_max_active: 0,
                     zone_append_max_sectors: u32::MAX,
                     poll_queues: 0,
+                    fua: true,
                 }),
             }),
             core::iter::empty(),
@@ -256,6 +258,7 @@ struct DeviceConfigInner {
     zone_max_active: u32,
     zone_append_max_sectors: u32,
     poll_queues: u32,
+    fua: bool,
 }
 
 #[vtable]
@@ -322,6 +325,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 zone_max_open: guard.zone_max_open,
                 zone_max_active: guard.zone_max_active,
                 zone_append_max_sectors: guard.zone_append_max_sectors,
+                forced_unit_access: guard.fua,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -515,3 +519,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         }
     })
 );
+configfs_simple_bool_field!(DeviceConfig, 28, fua);
diff --git a/drivers/block/rnull/disk_storage.rs b/drivers/block/rnull/disk_storage.rs
index 7667830bd616..4a9bf480221f 100644
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
@@ -205,7 +209,7 @@ fn flush(&mut self) -> Result {
         Ok(())
     }
 
-    fn get_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
+    fn get_or_alloc_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
         let index = Self::to_index(sector);
 
         match self.cache_guard.entry(index) {
@@ -239,6 +243,12 @@ fn get_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
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
 
@@ -256,9 +266,13 @@ fn get_disk_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
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
index 88dc9a2476bd..846269d31c63 100644
--- a/drivers/block/rnull/disk_storage/page.rs
+++ b/drivers/block/rnull/disk_storage/page.rs
@@ -15,6 +15,7 @@
     uapi::PAGE_SECTORS, //
 };
 
+// TODO: Use rust bitmap
 static_assert!((PAGE_SIZE >> SECTOR_SHIFT) <= 64);
 
 pub(crate) struct NullBlockPage {
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0695cbd07f1d..c3126b923367 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -191,6 +191,10 @@
             default: 0,
             description: "Number of IOPOLL submission queues.",
         },
+        fua: bool {
+            default: true,
+            description: "Enable/disable FUA support when cache_size is used.",
+        },
     },
 }
 
@@ -267,6 +271,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     zone_max_open: module_parameters::zone_max_open.value(),
                     zone_max_active: module_parameters::zone_max_active.value(),
                     zone_append_max_sectors: module_parameters::zone_append_max_sectors.value(),
+                    forced_unit_access: module_parameters::fua.value(),
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -307,6 +312,7 @@ struct NullBlkOptions<'a> {
     zone_max_active: u32,
     #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(dead_code))]
     zone_append_max_sectors: u32,
+    forced_unit_access: bool,
 }
 
 #[pin_data]
@@ -422,6 +428,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             zone_max_active,
             #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(unused_variables))]
             zone_append_max_sectors,
+            forced_unit_access,
         } = options;
 
         let memory_backed = tag_set.memory_backed;
@@ -439,9 +446,10 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             return Err(code::EINVAL);
         }
 
+        let s = storage.clone();
         let queue_data = Arc::try_pin_init(
             try_pin_init!(Self {
-                storage,
+                storage: s,
                 irq_mode,
                 completion_time,
                 memory_backed,
@@ -474,7 +482,9 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             .capacity_sectors(device_capacity_sectors)
             .logical_block_size(block_size_bytes)?
             .physical_block_size(block_size_bytes)?
-            .rotational(rotational);
+            .rotational(rotational)
+            .write_cache(storage.cache_enabled())
+            .forced_unit_access(forced_unit_access && storage.cache_enabled());
 
         #[cfg(CONFIG_BLK_DEV_ZONED)]
         {
@@ -553,6 +563,7 @@ fn write<'a, 'b, 'c>(
         hw_data_guard: &'b mut SpinLockGuard<'c, HwQueueContext>,
         mut sector: u64,
         mut segment: Segment<'_>,
+        bypass_cache: bool,
     ) -> Result {
         let mut sheaf: Option<XArraySheaf<'_>> = None;
 
@@ -561,7 +572,13 @@ fn write<'a, 'b, 'c>(
 
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
 
             // CAST: Page offset always fits in 32 bits.
@@ -569,7 +586,11 @@ fn write<'a, 'b, 'c>(
                 ((sector & u64::from(block::PAGE_SECTOR_MASK)) << block::SECTOR_SHIFT) as usize;
 
             // CAST: Casting from `usize` to `u64` never overflows.
-            sector += segment.copy_to_page(page.page_mut().as_pin_mut(), page_offset) as u64
+            sector += segment.copy_to_page_limit(
+                page.page_mut().as_pin_mut(),
+                page_offset,
+                self.block_size_bytes.try_into()?,
+            ) as u64
                 >> block::SECTOR_SHIFT;
 
             sheaf = access.sheaf;
@@ -632,6 +653,8 @@ fn transfer(
         let mut hw_data_guard = hw_data.lock();
         let mut tree_guard = self.storage.lock();
 
+        let skip_cache = rq.flags().contains(mq::RequestFlag::ForcedUnitAccess);
+
         for bio in rq.bio_iter_mut() {
             let segment_iter = bio.segment_iter();
             for mut segment in segment_iter {
@@ -641,9 +664,13 @@ fn transfer(
                 let length_sectors_allowed = segment_length_sectors.min(max_remaining_sectors);
                 segment.truncate(length_sectors_allowed << SECTOR_SHIFT);
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


