Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384C3E44FD;
	Tue,  9 Jun 2026 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032555; cv=none; b=rNp9LxwSouxzsUZkFNLyrZ65v4/+8jZmp3v8QBDy1ciwZM7gSbqxqHx+ssPCc58nZ7H96XCGG4bzhxplBBBFZU7G2+3lBUyXCoxqxTGPtV8z1R1H4qFCUBC0+BJuWGeckd00XEzEr/IfM/KU0mKo3q430TQd5QDYKVH6S/BonkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032555; c=relaxed/simple;
	bh=pjTJV6lpFGJdbnqxGVPCelvpzcvZdwrgNcXyn+EPT0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bYcdYmm/NxVKSHygFlCrq9mCPCi74qHgQYbzSkIssYQzY7cqRvol7qH9J9zsi3oCkbYTmUJyDLWzacef5GI0orX9Uet4ZnbnSAa6nzrnMZaCr64MfzUaUWj0ng17U1JU59HQ5iETlD7gulx8jO2juYvTI3LEF0NwwxKJZT2T8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJRuMeub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJRuMeub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BD01F00893;
	Tue,  9 Jun 2026 19:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032554;
	bh=XwkzM7VKd2QXL9hc4jVTBaLQ2ofiUVQa/wzCehzlLfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PJRuMeubNxh1PQSzxL1DyB41AIrvdek8nDKPtSKhm5o0NviyKSTiVrhDLu3iguEBd
	 0xplh6V9VIdWerS8y8DtTZmmThWVU95nzC9QpGylXKU46KuVuhXlvX1CkzsOu+JoCe
	 MjbNF4bZ8B7n25zVRSn0JlV/mgNqTLFHn0oOt9AFFFqYQwcGNwNUe07KPJxHyFvlxZ
	 Uu7ZwCkEGreSa0hJGaoJKGkcUPY8MxZzIjviUr2EHCVUDXUEgt3mRmbGBZP/66UZ2W
	 OV/8H3/4WZpxm6Pd3jfQqPZJXa4soGpN8YNs6Y1td/O2Drf+0BrX00P4V/lDtDuomn
	 uR2Eh6VVq7z5g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:23 +0200
Subject: [PATCH v2 44/83] block: rnull: add bandwidth limiting
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-44-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10642;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=pjTJV6lpFGJdbnqxGVPCelvpzcvZdwrgNcXyn+EPT0s=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTc6+ODZ65AqoAf371RvHz/OnyK5XGNwDbnU
 VCqT77xgpuJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk3AAKCRD6UCkIqsW9
 0JWaD/9mQPWw4JE9i9ltAG5BKZTUckOkIUd7RZ4WGZ4lMe6tJZhAq3cT8nktOiW9M0bpzIgKIxn
 zvuvxpqbwe8dQplaQYysdwCAGcn+HP0sBEBtscs8KVgMMokJ9nBgmFvYRs6YJ8Tcb+p19D2kyWd
 LTX2g/vNcZpNfuMKQXgkE28gwts3AruCAUXNY9LdMN1JGBp0gCNdVCxArt9xgwk0bXStMYm8e4/
 PvKOSHSdDspS/YiNaqzcXvFuDqiEos9gX6gOGqIo3jw963sZZH3IHmpaQD7MMbUHnfOJqPVrKYh
 vk/0QP3ErfWjqJA2N1BmOVmoOLN0zmzfxNI/tKk2kBrn9mxR7XBVPZA5cJaoVCR2HC9KasgmsOP
 rXaf/U4Mmm5Qxl3koLOoY/6DIXTR6RL8YYB1Hdp0hlI8KjvMoAyVOJ2EmMMq6QjV1hTdSQns+wj
 oMsdvt+nwsXit4Nldq6dvzXVHZYT+5cVPCI8s/B/W1yDFENImrG+c9LwvAjh7lbkpIIbR7jcDiy
 /+u6dLn7ukZ4PLM7XGvfLq5xcPqQterwMaq/Egacm65c5lpeGPrRhcSDdm6YgtIgr57sc2JUkkH
 ytSxT7XAWiHYky9m5qKgtQhOr5Z5/7ST297dsw9YFwT2lLyok596jljmWq8MHMJa83kwIaqKOUA
 GUJBbFBDOVZunyQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add bandwidth limiting support to rnull via the `mbps` configfs
attribute. When set to a non-zero value, the driver limits I/O
throughput to the specified rate in megabytes per second.

The implementation uses a token bucket algorithm to enforce the rate
limit, delaying request completion when the limit is exceeded.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |   7 ++-
 drivers/block/rnull/rnull.rs    | 111 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 105 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 4df0b748596a..59217d75f46b 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -104,6 +104,7 @@ fn make_group(
                 badblocks_once: 13,
                 badblocks_partial_io: 14,
                 cache_size_mib: 15,
+                mbps: 16,
             ],
         };
 
@@ -135,6 +136,7 @@ fn make_group(
                         GFP_KERNEL
                     )?,
                     cache_size_mib: 0,
+                    mbps: 0,
                 }),
             }),
             core::iter::empty(),
@@ -209,6 +211,7 @@ struct DeviceConfigInner {
     bad_blocks_partial_io: bool,
     cache_size_mib: u64,
     disk_storage: Arc<DiskStorage>,
+    mbps: u32,
 }
 
 #[vtable]
@@ -248,6 +251,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 bad_blocks_once: guard.bad_blocks_once,
                 bad_blocks_partial_io: guard.bad_blocks_partial_io,
                 storage: guard.disk_storage.clone(),
+                bandwidth_limit: u64::from(guard.mbps) * 2u64.pow(20),
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -259,7 +263,6 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
     }
 }
 
-// DiskStorage::new(cache_size_mib << 20, block_size as usize),
 configfs_simple_field!(DeviceConfig, 1, block_size, u32, check GenDiskBuilder::validate_block_size);
 configfs_simple_bool_field!(DeviceConfig, 2, rotational);
 configfs_simple_field!(DeviceConfig, 3, capacity_mib, u64);
@@ -417,3 +420,5 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     })
 );
+
+configfs_simple_field!(DeviceConfig, 16, mbps, u32);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 6ceba23a4d3e..1dda8d717b95 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -25,7 +25,8 @@
             self,
             gen_disk::{
                 self,
-                GenDisk, //
+                GenDisk,
+                GenDiskRef, //
             },
             Operations,
             TagSet, //
@@ -37,25 +38,32 @@
         Result, //
     },
     ffi,
+    impl_has_hr_timer,
     memalloc_scope,
     new_mutex,
     new_spinlock,
     pr_info,
     prelude::*,
+    revocable::Revocable,
     str::CString,
     sync::{
         aref::ARef,
         atomic::{
             ordering,
             Atomic, //
-        }, //
+        },
         Arc,
+        ArcBorrow,
         Mutex,
+        SetOnce,
         SpinLock,
-        SpinLockGuard,
+        SpinLockGuard, //
     },
     time::{
         hrtimer::{
+            self,
+            ArcHrTimerHandle,
+            HrTimer,
             HrTimerCallback,
             HrTimerCallbackContext,
             HrTimerPointer,
@@ -127,6 +135,10 @@
             default: false,
             description: "No IO scheduler",
         },
+        mbps: u32 {
+            default: 0,
+            description: "Max bandwidth in MiB/s. 0 means no limit.",
+        },
     },
 }
 
@@ -172,6 +184,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     bad_blocks_once: false,
                     bad_blocks_partial_io: false,
                     storage: Arc::pin_init(DiskStorage::new(0, block_size as usize), GFP_KERNEL)?,
+                    bandwidth_limit: u64::from(module_parameters::mbps.value()) * 2u64.pow(20),
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -202,6 +215,7 @@ struct NullBlkOptions<'a> {
     bad_blocks_once: bool,
     bad_blocks_partial_io: bool,
     storage: Arc<DiskStorage>,
+    bandwidth_limit: u64,
 }
 
 #[pin_data]
@@ -214,9 +228,18 @@ struct NullBlkDevice {
     bad_blocks: Arc<BadBlocks>,
     bad_blocks_once: bool,
     bad_blocks_partial_io: bool,
+    bandwidth_limit: u64,
+    #[pin]
+    bandwidth_timer: HrTimer<Self>,
+    bandwidth_bytes: Atomic<u64>,
+    #[pin]
+    bandwidth_timer_handle: SpinLock<Option<ArcHrTimerHandle<Self>>>,
+    disk: SetOnce<Arc<Revocable<GenDiskRef<Self>>>>,
 }
 
 impl NullBlkDevice {
+    const BANDWIDTH_TIMER_INTERVAL: Delta = Delta::from_millis(20);
+
     fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
         let NullBlkOptions {
             name,
@@ -234,6 +257,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             bad_blocks_once,
             bad_blocks_partial_io,
             storage,
+            bandwidth_limit,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -268,7 +292,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             GFP_KERNEL,
         )?;
 
-        let queue_data = Box::try_pin_init(
+        let queue_data = Arc::try_pin_init(
             try_pin_init!(Self {
                 storage,
                 irq_mode,
@@ -278,6 +302,11 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
                 bad_blocks,
                 bad_blocks_once,
                 bad_blocks_partial_io,
+                bandwidth_limit: bandwidth_limit / 50,
+                bandwidth_timer <- HrTimer::new(),
+                bandwidth_bytes: Atomic::new(0),
+                bandwidth_timer_handle <- new_spinlock!(None),
+                disk: SetOnce::new(),
             }),
             GFP_KERNEL,
         )?;
@@ -294,7 +323,10 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
                 .max_hw_discard_sectors(ffi::c_uint::MAX >> block::SECTOR_SHIFT);
         }
 
-        builder.build(fmt!("{}", name.to_str()?), tagset, queue_data)
+        let disk = builder.build(fmt!("{}", name.to_str()?), tagset, queue_data)?;
+        let queue_data: ArcBorrow<'_, Self> = disk.queue_data();
+        queue_data.disk.populate(disk.get_ref());
+        Ok(disk)
     }
 
     fn sheaf_size() -> usize {
@@ -522,6 +554,36 @@ fn end_request(rq: Owned<mq::Request<Self>>) {
     }
 }
 
+impl_has_hr_timer! {
+    impl HasHrTimer<Self> for NullBlkDevice {
+        mode: hrtimer::RelativeHardMode<kernel::time::Monotonic>,
+        field: self.bandwidth_timer,
+    }
+}
+
+impl HrTimerCallback for NullBlkDevice {
+    type Pointer<'a> = Arc<Self>;
+
+    fn run(
+        this: ArcBorrow<'_, Self>,
+        mut context: HrTimerCallbackContext<'_, Self>,
+    ) -> HrTimerRestart {
+        if this.bandwidth_bytes.load(ordering::Relaxed) == 0 {
+            return HrTimerRestart::NoRestart;
+        }
+
+        this.disk.as_ref().map(|disk| {
+            disk.try_access()
+                .map(|disk| disk.queue().start_stopped_hw_queues_async())
+        });
+
+        this.bandwidth_bytes.store(0, ordering::Relaxed);
+
+        context.forward_now(Self::BANDWIDTH_TIMER_INTERVAL);
+        HrTimerRestart::Restart
+    }
+}
+
 struct HwQueueContext {
     page: Option<KBox<disk_storage::NullBlockPage>>,
 }
@@ -529,7 +591,7 @@ struct HwQueueContext {
 #[pin_data]
 struct Pdu {
     #[pin]
-    timer: kernel::time::hrtimer::HrTimer<Self>,
+    timer: HrTimer<Self>,
     error: Atomic<u32>,
 }
 
@@ -578,14 +640,14 @@ fn align_down<T>(value: T, to: T) -> T
 
 #[vtable]
 impl Operations for NullBlkDevice {
-    type QueueData = Pin<KBox<Self>>;
+    type QueueData = Arc<Self>;
     type RequestData = Pdu;
     type TagSetData = ();
     type HwData = Pin<KBox<SpinLock<HwQueueContext>>>;
 
     fn new_request_data() -> impl PinInit<Self::RequestData> {
         pin_init!(Pdu {
-            timer <- kernel::time::hrtimer::HrTimer::new(),
+            timer <- HrTimer::new(),
             error: Atomic::new(0),
         })
     }
@@ -593,14 +655,39 @@ fn new_request_data() -> impl PinInit<Self::RequestData> {
     #[inline(always)]
     fn queue_rq(
         hw_data: Pin<&SpinLock<HwQueueContext>>,
-        this: Pin<&Self>,
+        this: ArcBorrow<'_, Self>,
         rq: Owned<mq::IdleRequest<Self>>,
         _is_last: bool,
     ) -> BlkResult {
-        let mut rq = rq.start();
         let mut sectors = rq.sectors();
 
-        Self::handle_bad_blocks(this.get_ref(), &mut rq, &mut sectors)?;
+        if this.bandwidth_limit != 0 {
+            if !this.bandwidth_timer.active() {
+                drop(this.bandwidth_timer_handle.lock().take());
+                let arc: Arc<_> = this.into();
+                *this.bandwidth_timer_handle.lock() =
+                    Some(arc.start(Self::BANDWIDTH_TIMER_INTERVAL));
+            }
+
+            if this
+                .bandwidth_bytes
+                .fetch_add(u64::from(rq.bytes()), ordering::Relaxed)
+                + u64::from(rq.bytes())
+                > this.bandwidth_limit
+            {
+                rq.queue().stop_hw_queues();
+                if this.bandwidth_bytes.load(ordering::Relaxed) <= this.bandwidth_limit {
+                    rq.queue().start_stopped_hw_queues_async();
+                }
+
+                return Err(kernel::block::error::code::BLK_STS_DEV_RESOURCE);
+            }
+        }
+
+        let mut rq = rq.start();
+
+        use core::ops::Deref;
+        Self::handle_bad_blocks(this.deref(), &mut rq, &mut sectors)?;
 
         if this.memory_backed {
             memalloc_scope!(let _noio: NoIo);
@@ -623,7 +710,7 @@ fn queue_rq(
         Ok(())
     }
 
-    fn commit_rqs(_hw_data: Pin<&SpinLock<HwQueueContext>>, _queue_data: Pin<&Self>) {}
+    fn commit_rqs(_hw_data: Pin<&SpinLock<HwQueueContext>>, _queue_data: ArcBorrow<'_, Self>) {}
 
     fn init_hctx(_tagset_data: (), _hctx_idx: u32) -> Result<Self::HwData> {
         KBox::pin_init(new_spinlock!(HwQueueContext { page: None }), GFP_KERNEL)

-- 
2.51.2


