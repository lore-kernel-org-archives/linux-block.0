Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D495412EAF;
	Tue,  9 Jun 2026 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032544; cv=none; b=fDv1wStAQ3Iz/4dZmTWqhOJS/kVb7Eb2IP8F/DzcZPAUr0yNLSe2R8iCM9ygZbxRvM2O61bC58m9cmG2F3neG2gfl/I+PKHMhXv7ByLqbldAFPU67wLivMcXkwqXOIHjL/SAqR/bTpklCmq0MSX+q4LUw6eQ2bKLpE+S6F5WIoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032544; c=relaxed/simple;
	bh=LKRO/kdnz0HdXDtAJ98fqv3Q8kP2DI6d0zTWOdCxz60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXAH+SmsXIJfSXorMHQ6aa2kZD/FLVigBZo2oP1vo1HxlSHMFMoJ0ksqMM5WGpvvxA7HuwpziynHSzE849mhMx4Nws5zBKO2FTg3hz7n7dhZHpHLzxmeLEXYH6gvRP/1/20zQ+XXJDycZZ31OcYfD93Gk9MioLMkyGNPAlmfNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g54eXIsj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g54eXIsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7680A1F00893;
	Tue,  9 Jun 2026 19:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032543;
	bh=ObZUiZGkmGKCKDmrRrIYTd2UdzvwSBsSQswoI/qC1L4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=g54eXIsjeu7SPnLFCcPLpvO9MXyFiWh1dt+cdGb6rkoOX6apHL8ot8TbdBnlmoSfl
	 GKjNRNH2Jm8lgMIXCs+aaLz+pTLJfO1M3cugjTZNbKia9OrzQHZlFkQ4TBNYkTR4Da
	 LRJ2K/cVic6wAJzw2MLhRc/O0jX9+Ul9ecnZWcXKC8b4ZpfkHPCTJwnqrDUEBsz4JB
	 XauxiseH1Kv3CSNuvwChqKe4pD98+7SUab6/ikwPPNX3+x2VmN/+35tgR0c7VqMdN7
	 srCoEuU0EnlppSaWYHTQpnqdfr+fT9f7/A2LoZ5lPPtP6OP9yPd6gv6bvol5spfONo
	 AcR7MBeDt716g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:56 +0200
Subject: [PATCH v2 77/83] block: rnull: add fault injection support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-77-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16656;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=LKRO/kdnz0HdXDtAJ98fqv3Q8kP2DI6d0zTWOdCxz60=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT6fFbzOOyZeh9I5VN2kkchzacCjx9+cOsVD
 uuoBYVbif2JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk+gAKCRD6UCkIqsW9
 0MOhEACvYoJ26WQA8ahQCGMgqawwcYnBZkeu75ZVq0YqxzJrZ/Gj5pIIMboKx42YdAFcN+FJll0
 7sdjBKs/utevmwzgDaWq6PlyZt9WgxBsRECdsKlBkPL3EDwwufQK6Wv3eo8HFIAk7k6HW1N0afb
 sIyACn4PJIfWb5yTHQ28S9ARWlQtYPMeE0eDQyJWQ42HRYdl/nzoaybHpLthYsNNXn3OOUt0fmH
 8X1LuzLnDXkg0x7mwiNnJT0nEa7RtcQOyquR2+N9ze+eXp5lc5/koWKD34oDTM42h13rB89hKxB
 HbV3nZhKO2fhnJHpFBgJNDTilNH3IlJZo2airpD/72VR20BOVfxN9kD10g5QwwJ9Z45xB0kkNB8
 yGkmPb12JyLaMLT7dZV+VtPtKtUJc+MYV0Z8kXvrZPZ0N2SrKYK5wZmS4EwlQouDbCC9eDVngl2
 E8DzV30j83LgMz87el8Q01vqfBDE+5YToJhj/3QG8hVfGC8faeCgd5AZr+tVwm0kswWz6iXyk3W
 8oPyJm4SSKpMyj4/T433JbtTcqYorR/AUC05Q4jx1m6mQgDv+83sh3ef/joxR8CvXCG4WO4rrc+
 hdE5Ic4sOMPfsLiImjriEj9lnm+7Csas2KQeNIOYpBOWN2NJQ0MinQL8Bd/3ya+7Gi6VLCPSfNh
 1vp2COdxIRUsDAA==
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
 drivers/block/rnull/rnull.rs    | 121 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 180 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnull/Kconfig b/drivers/block/rnull/Kconfig
index 7bc5b376c128..1ade5d8c1799 100644
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
index d9246b9150f4..eaa7617e5ffa 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -48,6 +48,9 @@
 
 mod macros;
 
+#[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+use kernel::fault_injection::FaultConfig;
+
 pub(crate) fn subsystem(
     shared_tag_set: Arc<TagSet<NullBlkDevice>>,
 ) -> impl PinInit<kernel::configfs::Subsystem<Config>, Error> {
@@ -132,10 +135,44 @@ fn make_group(
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
@@ -176,9 +213,15 @@ fn make_group(
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
@@ -263,6 +306,12 @@ struct DeviceConfigInner {
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
@@ -320,6 +369,8 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                     memory_backed: guard.memory_backed,
                     no_sched: guard.no_sched,
                     hw_queue_depth: guard.hw_queue_depth,
+                    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                    init_hctx_inject: guard.init_hctx_inject.clone(),
                 },
                 zoned: guard.zoned,
                 zone_size_mib: guard.zone_size_mib,
@@ -329,6 +380,10 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 zone_max_active: guard.zone_max_active,
                 zone_append_max_sectors: guard.zone_append_max_sectors,
                 forced_unit_access: guard.fua,
+                #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                requeue_inject: guard.requeue_inject.clone(),
+                #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                timeout_inject: guard.timeout_inject.clone(),
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 8e17b2b17a66..f909360ec70d 100644
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
 };
 use util::*;
 
+#[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+use kernel::fault_injection::FaultConfig;
+
 module! {
     type: NullBlkModule,
     name: "rnull_mod",
@@ -203,6 +207,8 @@
     },
 }
 
+// TODO: Fault inject via params - requires module_params string support.
+
 #[pin_data]
 struct NullBlkModule {
     #[pin]
@@ -241,6 +247,11 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                 memory_backed,
                 no_sched,
                 hw_queue_depth,
+                #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                init_hctx_inject: Arc::pin_init(
+                    FaultConfig::new(c"init_hctx_fault_inject"),
+                    GFP_KERNEL,
+                )?,
             })?;
 
             let mut disks = KVec::new();
@@ -278,6 +289,11 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                         memory_backed,
                         no_sched,
                         hw_queue_depth,
+                        #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                        init_hctx_inject: Arc::pin_init(
+                            FaultConfig::new(c"init_hctx_fault_inject"),
+                            GFP_KERNEL,
+                        )?,
                     },
                     zoned: module_parameters::zoned.value(),
                     zone_size_mib: module_parameters::zone_size.value(),
@@ -287,6 +303,10 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     zone_max_active: module_parameters::zone_max_active.value(),
                     zone_append_max_sectors: module_parameters::zone_append_max_sectors.value(),
                     forced_unit_access: module_parameters::fua.value(),
+                    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                    requeue_inject: Arc::pin_init(FaultConfig::new(c"requeue_inject"), GFP_KERNEL)?,
+                    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                    timeout_inject: Arc::pin_init(FaultConfig::new(c"timeout_inject"), GFP_KERNEL)?,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -328,6 +348,10 @@ struct NullBlkOptions<'a> {
     #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(dead_code))]
     zone_append_max_sectors: u32,
     forced_unit_access: bool,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    requeue_inject: Arc<FaultConfig>,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    timeout_inject: Arc<FaultConfig>,
 }
 
 #[pin_data]
@@ -350,6 +374,12 @@ struct NullBlkDevice {
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
 
 struct TagSetOptions {
@@ -359,6 +389,8 @@ struct TagSetOptions {
     memory_backed: bool,
     no_sched: bool,
     hw_queue_depth: u32,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    init_hctx_inject: Arc<FaultConfig>,
 }
 
 impl NullBlkDevice {
@@ -372,6 +404,8 @@ fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
             memory_backed,
             no_sched,
             hw_queue_depth,
+            #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+            init_hctx_inject,
         } = options;
 
         if home_node > kernel::numa::num_online_nodes().try_into()? {
@@ -404,6 +438,8 @@ fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
                     NullBlkTagsetData {
                         queue_depth: hw_queue_depth,
                         queue_config,
+                        #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+                        init_hctx_inject,
                     },
                     GFP_KERNEL,
                 )?,
@@ -446,6 +482,11 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), allow(unused_variables))]
             zone_append_max_sectors,
             forced_unit_access,
+
+            #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+            requeue_inject,
+            #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+            timeout_inject,
         } = options;
 
         let memory_backed = tag_set.memory_backed;
@@ -491,6 +532,12 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
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
@@ -733,7 +780,9 @@ fn handle_bad_blocks(&self, rq: &mut Owned<mq::Request<Self>>, sectors: &mut u32
                 badblocks::BlockStatus::None => {}
                 badblocks::BlockStatus::Acknowledged(mut range)
                 | badblocks::BlockStatus::Unacknowledged(mut range) => {
-                    rq.data_ref().error.store(1, ordering::Relaxed);
+                    rq.data_ref()
+                        .error
+                        .store(block::error::code::BLK_STS_IOERR.into(), ordering::Relaxed);
 
                     if self.bad_blocks_once {
                         self.bad_blocks.set_good(range.clone())?;
@@ -783,6 +832,22 @@ fn queue_rq_internal(
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
+                return Err(QueueRequestError { request: rq });
+            } else {
+                rq.requeue(true);
+                return Ok(());
+            }
+        }
+
         if this.bandwidth_limit != 0 {
             if !this.bandwidth_timer.active() {
                 drop(this.bandwidth_timer_handle.lock().take());
@@ -808,6 +873,12 @@ fn queue_rq_internal(
 
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
@@ -831,12 +902,13 @@ fn queue_rq_internal(
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
@@ -914,7 +986,8 @@ struct HwQueueContext {
 struct Pdu {
     #[pin]
     timer: HrTimer<Self>,
-    error: Atomic<i32>,
+    error: Atomic<u32>,
+    fake_timeout: Atomic<u32>,
 }
 
 impl HrTimerCallback for Pdu {
@@ -939,6 +1012,8 @@ impl HasHrTimer<Self> for Pdu {
 struct NullBlkTagsetData {
     queue_depth: u32,
     queue_config: Arc<Mutex<QueueConfig>>,
+    #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
+    init_hctx_inject: Arc<FaultConfig>,
 }
 
 #[vtable]
@@ -952,6 +1027,7 @@ fn new_request_data() -> impl PinInit<Self::RequestData> {
         pin_init!(Pdu {
             timer <- HrTimer::new(),
             error: Atomic::new(0),
+            fake_timeout: Atomic::new(0),
         })
     }
 
@@ -1006,6 +1082,11 @@ fn poll(
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
@@ -1067,4 +1148,28 @@ fn map_queues(tag_set: Pin<&mut TagSet<Self>>) {
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
+                kernel::pr_warn_once!("Timed out request could not be completed\n");
+            }
+        } else {
+            kernel::pr_warn_once!("Timed out request referenced in timeout handler\n");
+        }
+        RequestTimeoutStatus::RetryLater
+    }
 }

-- 
2.51.2


