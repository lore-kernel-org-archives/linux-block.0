Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ADD2DC772;
	Sun, 15 Feb 2026 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198964; cv=none; b=X2NHgXn0iJQ5R4zHXbNFqnkMEb9HpmWp4saXVj6SHW9OUqYe9UBYmQvilZHse9yyMKmdHMl7K3j7G+ZtWaoSdTbko3S2ZDO/K/oDPPZO04pvyzqiTkTEHkxPRIQiBbEBhBS8ACU8DLs2kT7tf+n4b4S8xUwXWasdbm3MKbtiEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198964; c=relaxed/simple;
	bh=HabGkFaZxpg0TMJ4bmudZjM7RGpHBrmdEEt4p/Jhb1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9GVyEJcT1FCb8wWYBsfJihWtgH5CeZKFjtHpGmCnQtDKQCSUSWIywLrtHjd82JxzOUHdXezwxCsNxs4T9/BdNq1pg4Y1t36k7KxC+SR4RkQWK6pV0HwpmJRsKQhkmmUEX5dOUHvTzCv/2fPMIWnSecr+vYRqaz4YNVoteWSG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXxMYA5k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXxMYA5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E47C19422;
	Sun, 15 Feb 2026 23:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198963;
	bh=HabGkFaZxpg0TMJ4bmudZjM7RGpHBrmdEEt4p/Jhb1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kXxMYA5k9qgWa5ikrqf3E7noxTHmJP9lj9IGdrolkpPOiCVw8m6LM03P9KRstoyOG
	 SBx3DNAwt64nWIRtYjejcLoEif6QdvvQ+JCkEMl43dd/jSkrS2EaDfGeiToiW7KiUP
	 /c91dRdES0AtltjsdmESioZDNLCnBERqGERE0NESPSGq/fwZqUYAZaI9YdA523S9RL
	 tRRUhkkiyz3OJB1dClxVmZv03z5Xb5k2u9vNPiZI0rusnYiPwQ3Hk3MiWNDel2DPzM
	 Gpe7mZ+K+bffCphn5RAxasPhNGbBC2/8OzJqRN9Wcg+0pWzq3bAcu1m4VnNlgUGiMX
	 ochoOXMZY/E0w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:36:00 +0100
Subject: [PATCH 73/79] block: rnull: add fault injection support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-73-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15513;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=HabGkFaZxpg0TMJ4bmudZjM7RGpHBrmdEEt4p/Jhb1o=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklheNbL2fIfLyru1HT+aFI3GFoq8t4w60izcs
 N0qtuiwoviJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYXgAKCRDhuBo+eShj
 dyXYD/0TdBR75C0VGxkSg7cAr4tEIvCg9n37n7uhifxV9p7+QDFfZMT+MrJBAEuR9LwkVzR03aw
 JaqxDKLPERl6EwnX2EWG8L8OiqKCpWWW58LVgIEu/hl7RQncJKW+ZudBvN0N84x2RYXg75YlTns
 KsprP4FoPUpH2mhwuQtpGQGt8Pr5mSvbxDdLzzekp4g0BmFGDM9Gnkjmh4naEja1jkDDsRpUM8p
 //pCmqKU3O7LIVOet9NZqIdCzIxCgcUgw94P7Ovto3jNqoLleIUFGwAh+7PDDPo+xZzP7N/RGte
 3d9NWFQgFe14NDSks2v1qD/qt3JW8yyK7DCK/tF01ynqy6wdU9k3GYFBZSr9+q/apCzfSM+QVGH
 4d/MiCQa4160O/vWUBSM8O/OYPsrCvlx/qfereQiXKxahEmykl+mPJ9rATmyciWdBNxv8SvVdch
 K+yKxRQW4m79Sj5JKaoo+jgZ8bt37aQrW2UYhm1mspcL5c+9q/BuWfo1fHtQVG/GM23f9058/RJ
 Vat/WaWPbGR5VOyy9AakaKcvSXhHuPMO6Er9ecXXUD6xFGSc2H1KnsCIO/yHG5nEbgaWHogBJ0g
 w6Fjin7g0IGdK/1JQ1TFVs/RfWpcozd861+LSuEqw9vJ6GFKAPotmP/QC4xZnEkGqGRhZosM6gH
 atlS+mokMm4gDGw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add fault injection support to rnull using the kernel fault injection
infrastructure. When enabled via `CONFIG_FAULT_INJECTION`, users can
inject failures into I/O requests through the standard fault injection
debugfs interface.

The fault injection point is exposed as a configfs default group,
allowing per-device fault injection configuration.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/Kconfig     |  11 ++++
 drivers/block/rnull/configfs.rs |  57 ++++++++++++++++++-
 drivers/block/rnull/rnull.rs    | 120 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 179 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnull/Kconfig b/drivers/block/rnull/Kconfig
index 7bc5b376c128b..1ade5d8c17997 100644
--- a/drivers/block/rnull/Kconfig
+++ b/drivers/block/rnull/Kconfig
@@ -11,3 +11,14 @@ config BLK_DEV_RUST_NULL
 	  devices that can be configured via various configuration options.
 
 	  If unsure, say N.
+
+config BLK_DEV_RUST_NULL_FAULT_INJECTION
+	bool "Support fault injection for Rust Null test block driver"
+	depends on BLK_DEV_RUST_NULL && FAULT_INJECTION_CONFIGFS
+	help
+	  Enable fault injection support for the Rust null block driver. This
+	  allows injecting errors into block I/O operations for testing error
+	  handling paths and verifying system resilience. Fault injection is
+	  configured through configfs alongside the null block device settings.
+
+	  If unsure, say N.
diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 424722f01ab8d..b449ac882d961 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -46,6 +46,9 @@
 
 mod macros;
 
+#[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+use kernel::fault_injection::FaultConfig;
+
 pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsystem<Config>, Error> {
     let item_type = configfs_attrs! {
         container: configfs::Subsystem<Config>,
@@ -122,10 +125,44 @@ fn make_group(
             ],
         };
 
+        use kernel::configfs::CDefaultGroup;
+
+        #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+        let mut default_groups: KVec<Arc<dyn CDefaultGroup>> = KVec::new();
+
+        #[cfg(not(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION))]
+        let default_groups: KVec<Arc<dyn CDefaultGroup>> = KVec::new();
+
+        #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+        let timeout_inject = Arc::pin_init(
+            kernel::fault_injection::FaultConfig::new(c"timeout_inject"),
+            GFP_KERNEL,
+        )?;
+
+        #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+        let requeue_inject = Arc::pin_init(
+            kernel::fault_injection::FaultConfig::new(c"requeue_inject"),
+            GFP_KERNEL,
+        )?;
+
+        #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+        let init_hctx_inject = Arc::pin_init(
+            kernel::fault_injection::FaultConfig::new(c"init_hctx_fault_inject"),
+            GFP_KERNEL,
+        )?;
+
+        #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+        {
+            default_groups.push(timeout_inject.clone(), GFP_KERNEL)?;
+            default_groups.push(requeue_inject.clone(), GFP_KERNEL)?;
+            default_groups.push(init_hctx_inject.clone(), GFP_KERNEL)?;
+        }
+
         let block_size = 4096;
         Ok(configfs::Group::new(
             name.try_into()?,
             item_type,
+            // default_groups,
             // TODO: cannot coerce new_mutex!() to impl PinInit<_, Error>, so put mutex inside
             try_pin_init!(DeviceConfig {
                 data <- new_mutex!(DeviceConfigInner {
@@ -165,9 +202,15 @@ fn make_group(
                     zone_max_active: 0,
                     zone_append_max_sectors: u32::MAX,
                     fua: true,
+                    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                    timeout_inject,
+                    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                    requeue_inject,
+                    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                    init_hctx_inject,
                 }),
             }),
-            core::iter::empty(),
+            default_groups,
         ))
     }
 }
@@ -241,6 +284,12 @@ struct DeviceConfigInner {
     zone_max_active: u32,
     zone_append_max_sectors: u32,
     fua: bool,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    timeout_inject: Arc<FaultConfig>,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    requeue_inject: Arc<FaultConfig>,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    init_hctx_inject: Arc<FaultConfig>,
 }
 
 #[vtable]
@@ -292,6 +341,12 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 zone_max_active: guard.zone_max_active,
                 zone_append_max_sectors: guard.zone_append_max_sectors,
                 forced_unit_access: guard.fua,
+                #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                requeue_inject: guard.requeue_inject.clone(),
+                #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                init_hctx_inject: guard.init_hctx_inject.clone(),
+                #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                timeout_inject: guard.timeout_inject.clone(),
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index db856f03b78cb..b2b089a657f12 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -40,6 +40,7 @@
             IoCompletionBatch,
             Operations,
             RequestList,
+            RequestTimeoutStatus,
             TagSet, //
         },
         SECTOR_SHIFT,
@@ -90,6 +91,9 @@
 use pin_init::PinInit;
 use util::*;
 
+#[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+use kernel::fault_injection::FaultConfig;
+
 module! {
     type: NullBlkModule,
     name: "rnull_mod",
@@ -205,6 +209,8 @@
     },
 }
 
+// TODO: Fault inject via params - requires module_params string support.
+
 #[pin_data]
 struct NullBlkModule {
     #[pin]
@@ -267,6 +273,15 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     zone_max_active: *module_parameters::zone_max_active.value(),
                     zone_append_max_sectors: *module_parameters::zone_append_max_sectors.value(),
                     forced_unit_access: *module_parameters::fua.value() != 0,
+                    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                    requeue_inject: Arc::pin_init(FaultConfig::new(c"requeue_inject"), GFP_KERNEL)?,
+                    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                    init_hctx_inject: Arc::pin_init(
+                        FaultConfig::new(c"init_hctx_fault_inject"),
+                        GFP_KERNEL,
+                    )?,
+                    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                    timeout_inject: Arc::pin_init(FaultConfig::new(c"timeout_inject"), GFP_KERNEL)?,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -315,6 +330,12 @@ struct NullBlkOptions<'a> {
     #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), expect(unused_variables))]
     zone_append_max_sectors: u32,
     forced_unit_access: bool,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    requeue_inject: Arc<FaultConfig>,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    init_hctx_inject: Arc<FaultConfig>,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    timeout_inject: Arc<FaultConfig>,
 }
 
 static SHARED_TAG_SET: SetOnce<Arc<TagSet<NullBlkDevice>>> = SetOnce::new();
@@ -339,6 +360,12 @@ struct NullBlkDevice {
     #[cfg(CONFIG_BLK_DEV_ZONED)]
     #[pin]
     zoned: zoned::ZoneOptions,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    requeue_inject: Arc<FaultConfig>,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    requeue_selector: kernel::sync::atomic::Atomic<u64>,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    timeout_inject: Arc<FaultConfig>,
 }
 
 impl NullBlkDevice {
@@ -373,6 +400,13 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             zone_max_active,
             zone_append_max_sectors,
             forced_unit_access,
+
+            #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+            requeue_inject,
+            #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+            init_hctx_inject,
+            #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+            timeout_inject,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -402,6 +436,8 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
                         NullBlkTagsetData {
                             queue_depth: hw_queue_depth,
                             queue_config,
+                            #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                            init_hctx_inject,
                         },
                         GFP_KERNEL,
                     )?,
@@ -450,6 +486,12 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
                     zone_max_active,
                     zone_append_max_sectors,
                 })?,
+                #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                requeue_inject,
+                #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                requeue_selector: Atomic::new(0),
+                #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                timeout_inject,
             }),
             GFP_KERNEL,
         )?;
@@ -680,7 +722,9 @@ fn handle_bad_blocks(&self, rq: &mut Owned<mq::Request<Self>>, sectors: &mut u32
                 badblocks::BlockStatus::None => {}
                 badblocks::BlockStatus::Acknowledged(mut range)
                 | badblocks::BlockStatus::Unacknowledged(mut range) => {
-                    rq.data_ref().error.store(1, ordering::Relaxed);
+                    rq.data_ref()
+                        .error
+                        .store(block::error::code::BLK_STS_IOERR.into(), ordering::Relaxed);
 
                     if self.bad_blocks_once {
                         self.bad_blocks.set_good(range.clone())?;
@@ -705,6 +749,7 @@ fn end_request(rq: Owned<mq::Request<Self>>) {
         let status = rq.data_ref().error.load(ordering::Relaxed);
         rq.data_ref().error.store(0, ordering::Relaxed);
 
+        // TODO: Use correct error code
         match status {
             0 => rq.end_ok(),
             _ => rq.end(bindings::BLK_STS_IOERR),
@@ -730,6 +775,24 @@ fn queue_rq_internal(
         rq: Owned<mq::IdleRequest<Self>>,
         _is_last: bool,
     ) -> Result<(), QueueRequestError> {
+        #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+        if rq.queue_data().requeue_inject.should_fail(1) {
+            if rq
+                .queue_data()
+                .requeue_selector
+                .fetch_add(1, ordering::Relaxed)
+                & 1
+                == 0
+            {
+                return Err(QueueRequestError {
+                    request: rq,
+                });
+            } else {
+                rq.requeue(true);
+                return Ok(());
+            }
+        }
+
         if this.bandwidth_limit != 0 {
             if !this.bandwidth_timer.active() {
                 drop(this.bandwidth_timer_handle.lock().take());
@@ -755,6 +818,12 @@ fn queue_rq_internal(
 
         let mut rq = rq.start();
 
+        #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+        if rq.queue_data().timeout_inject.should_fail(1) {
+            rq.data_ref().fake_timeout.store(1, ordering::Relaxed);
+            return Ok(());
+        }
+
         if rq.command() == mq::Command::Flush {
             if this.memory_backed {
                 this.storage.flush(&hw_data);
@@ -778,12 +847,13 @@ fn queue_rq_internal(
             Ok(())
         })();
 
-        if let Err(e) = status {
-            // Do not overwrite existing error. We do not care whether this write fails.
-            let _ = rq
-                .data_ref()
-                .error
-                .cmpxchg(0, e.to_errno(), ordering::Relaxed);
+        if status.is_err() {
+            // Do not overwrite existing error.
+            let _ = rq.data_ref().error.cmpxchg(
+                0,
+                kernel::block::error::code::BLK_STS_IOERR.into(),
+                ordering::Relaxed,
+            );
         }
 
         if rq.is_poll() {
@@ -861,7 +931,8 @@ struct HwQueueContext {
 struct Pdu {
     #[pin]
     timer: HrTimer<Self>,
-    error: Atomic<i32>,
+    error: Atomic<u32>,
+    fake_timeout: Atomic<u32>,
 }
 
 impl HrTimerCallback for Pdu {
@@ -886,6 +957,8 @@ impl HasHrTimer<Self> for Pdu {
 struct NullBlkTagsetData {
     queue_depth: u32,
     queue_config: Arc<Mutex<QueueConfig>>,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    init_hctx_inject: Arc<FaultConfig>,
 }
 
 #[vtable]
@@ -899,6 +972,7 @@ fn new_request_data() -> impl PinInit<Self::RequestData> {
         pin_init!(Pdu {
             timer <- HrTimer::new(),
             error: Atomic::new(0),
+            fake_timeout: Atomic::new(0),
         })
     }
 
@@ -953,6 +1027,11 @@ fn poll(
     }
 
     fn init_hctx(tagset_data: &NullBlkTagsetData, _hctx_idx: u32) -> Result<Self::HwData> {
+        #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+        if tagset_data.init_hctx_inject.should_fail(1) {
+            return Err(EFAULT);
+        }
+
         KBox::pin_init(
             new_spinlock!(HwQueueContext {
                 page: None,
@@ -1013,4 +1092,29 @@ fn map_queues(tag_set: Pin<&mut TagSet<Self>>) {
             })
             .unwrap()
     }
+
+    fn request_timeout(tag_set: &TagSet<Self>, qid: u32, tag: u32) -> RequestTimeoutStatus {
+        if let Some(request) = tag_set.tag_to_rq(qid, tag) {
+            pr_info!("Request timed out\n");
+            // Only fail requests that are faking timeouts. Requests that time
+            // out due to memory pressure will be completed normally.
+            if request.data_ref().fake_timeout.load(ordering::Relaxed) != 0 {
+                request.data_ref().error.store(
+                    block::error::code::BLK_STS_TIMEOUT.into(),
+                    ordering::Relaxed,
+                );
+                request.data_ref().fake_timeout.store(0, ordering::Relaxed);
+
+                if let Ok(request) = OwnableRefCounted::try_from_shared(request) {
+                    Self::end_request(request);
+                    return RequestTimeoutStatus::Completed;
+                }
+                // TODO: pr_warn_once!
+                pr_warn!("Timed out request could not be completed\n");
+            }
+        } else {
+            pr_warn!("Timed out request referenced in timeout handler\n");
+        }
+        RequestTimeoutStatus::RetryLater
+    }
 }

-- 
2.51.2


