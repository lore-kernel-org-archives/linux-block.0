Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA329373BFE;
	Tue,  9 Jun 2026 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032432; cv=none; b=GdtFA/rTvFwqnIz7yAGEvV+/4eT3JF4uN9NgWpIdoco6XEl+s+/tbV0p3LdBEu/bP6dUtpVa1cC8L8oc8zyMAO2B1X1Yf7CNobjxrWy8s4b7QQzMMcRSRIC0e6hmAeEaNPcXHsLv5kBlQlCTrk/Q7+eevV0KXN6eVE97/1xznOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032432; c=relaxed/simple;
	bh=Z4bTvtitOiRUpVB/vtnTPuYJk3qDeC9v435ynCbwhKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oe+nQbWMdcZJGNQheBNRBPJvFR/Mhuz47nz6hzouvMu5gA1uVMhj79s/9oBaM5S2gADOSqo4yOfzLWmL7HRGJVt2ttFX6U/m6mUaV/N07Xmb8IeZ+YkA5vB4Mipo44R1ez49oBElKJxYgayOsF93GXnvVeLh6Dbnvb7qxbB01JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo6CXLUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo6CXLUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95A51F00898;
	Tue,  9 Jun 2026 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032430;
	bh=RwDIVImKkZ54sd2q6hPX1oX6gadqlWc4TQjYIjlzw7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Uo6CXLUE1iYXFFn5qXQl5CLsZDNmGC+xqboP+YL55rAJeKIsTQk/GWivS1AXxfkq2
	 1kH7PaVlLurPRERGkgTZr3YZnqh76Crpc8XcBnoEdSfLgUaJNye6TyQeK8e3/Ts/hq
	 QvXYSOgwW+NzirJRNfPZ415rJL6il3evGUnDY8WpvVrXrZndDotRqov2kvQLpZMwXB
	 YpCwL4Vw+OSWK3PCX6Sz8TWyDnDuGoIi0oUxE/jDikq8u7xKMZHllfVgtrBF8pAEv1
	 5VH3VoPXnhsATsggoSRNz9osQUqshFhQQMJDH49p/vdWSEwTaWFMeBZJN00fawHoqa
	 0QLq3Ytsf8r7Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:08 +0200
Subject: [PATCH v2 29/83] block: rnull: add badblocks support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-29-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8576; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Z4bTvtitOiRUpVB/vtnTPuYJk3qDeC9v435ynCbwhKQ=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTO4SWpDWOTQpKuppQyjtocpGDBfs4l6cpI1
 YmC6ruiDU2JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkzgAKCRD6UCkIqsW9
 0BLTD/4pE5l+jd7Un+rj/Z4vBWnQ2DGFDngPPPqu33XdKQf5Y0H0s2EDGJiLAS66NfHmv9Y3VQy
 xww7+gqD4l5tCDuKPlt3aDym1hhf9Zn+JY3Tx+RSkJs9yNfPdVyzVTVlzyywVXJ2zdV01JXeN6w
 cqIK+XCCfOxuOSdObW9Lf6hh3wfobK4V2yAMWJzeYK5c0qvIzQZv94rfupDTcOJXVICOM/2+caW
 8b5kyqE4PFOL72KXnavqStdpp9927ASRkZOf2R5iD74pND012qGLwWKokU1E8EoA2DLLyMDXrxz
 ISK7vfkrfbHWKJUFzdSuMQA06hhccZzWWb7nYo0MBqMIfkVUybvZ/oMNDTqvnEVnakgQjjBYi5m
 4d8w7IeN8aqzHhmYR+zWPFSh+YDjrxxnOR7jS1qPRL1+cMutR8B0uLM8Bu2Ibg74/ovVf15aQW4
 jVwIP5aTUOjNklDtmnFdGnv8XNlTn/PgulHfYdsagNTyUv4R66SkmaCBgeV+iTkOLWvHvki2dOU
 Dti4t9OJbJpAh6U9Fdw4hSh8hadMvwJVMK+0x6q0WZd410UprMULv3rxZ1IhOjkWVxsGaU/XJ6c
 3gwATWIJS8qbbeKEVoX9Bm590uxQULT1/USttL7kxlSueG0cItM4nfP6IPjE6GWLu8Pk872bI1g
 6C4dFIesc5G5haw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add badblocks support to the rnull driver with a configfs interface for
managing bad sectors.

- Configfs attribute for adding/removing bad blocks via "+start-end" and
  "-start-end" syntax.
- Request handling that checks for bad blocks and returns IO errors.
- Updated request completion to handle error status properly.

The badblocks functionality is disabled by default and is enabled when
first bad block is added.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 63 ++++++++++++++++++++++++++++++++++++++---
 drivers/block/rnull/rnull.rs    | 46 ++++++++++++++++++++++++++----
 2 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index d9aead646ae0..4db3ba26c2d1 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -6,9 +6,12 @@
 };
 use kernel::{
     bindings,
-    block::mq::gen_disk::{
-        GenDisk,
-        GenDiskBuilder, //
+    block::{
+        badblocks::BadBlocks,
+        mq::gen_disk::{
+            GenDisk,
+            GenDiskBuilder, //
+        }, //
     },
     configfs::{
         self,
@@ -26,7 +29,10 @@
         kstrtobool_bytes,
         CString, //
     },
-    sync::Mutex,
+    sync::{
+        Arc,
+        Mutex, //
+    },
     time, //
 };
 use macros::{
@@ -95,6 +101,7 @@ fn make_group(
                 home_node: 9,
                 discard: 10,
                 no_sched:11,
+                badblocks: 12,
             ],
         };
 
@@ -117,6 +124,7 @@ fn make_group(
                     home_node: bindings::NUMA_NO_NODE,
                     discard: false,
                     no_sched: false,
+                    bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                 }),
             }),
             core::iter::empty(),
@@ -186,6 +194,7 @@ struct DeviceConfigInner {
     home_node: i32,
     discard: bool,
     no_sched: bool,
+    bad_blocks: Arc<BadBlocks>,
 }
 
 #[vtable]
@@ -221,6 +230,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 home_node: guard.home_node,
                 discard: guard.discard,
                 no_sched: guard.no_sched,
+                bad_blocks: guard.bad_blocks.clone(),
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -328,3 +338,48 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 );
 
 configfs_simple_bool_field!(DeviceConfig, 11, no_sched);
+
+#[vtable]
+impl configfs::AttributeOperations<12> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let ret = this.data.lock().bad_blocks.show(page, false);
+        if ret < 0 {
+            Err(Error::from_errno(ret as c_int))
+        } else {
+            Ok(ret as usize)
+        }
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        // This attribute can be set while device is powered.
+
+        for line in core::str::from_utf8(page)?.lines() {
+            let mut chars = line.chars();
+            match chars.next() {
+                Some(sign @ '+' | sign @ '-') => {
+                    if let Some((start, end)) = chars.as_str().split_once('-') {
+                        let start: u64 = start.parse().map_err(|_| EINVAL)?;
+                        let end: u64 = end.parse().map_err(|_| EINVAL)?;
+
+                        if start > end {
+                            return Err(EINVAL);
+                        }
+
+                        this.data.lock().bad_blocks.enable();
+
+                        if sign == '+' {
+                            this.data.lock().bad_blocks.set_bad(start..=end, true)?;
+                        } else {
+                            this.data.lock().bad_blocks.set_good(start..=end)?;
+                        }
+                    }
+                }
+                _ => return Err(EINVAL),
+            }
+        }
+
+        Ok(())
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 73f14d6e379f..90dbf318c2f8 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -9,6 +9,7 @@
     bindings,
     block::{
         self,
+        badblocks::{self, BadBlocks},
         bio::Segment,
         mq::{
             self,
@@ -38,6 +39,10 @@
     str::CString,
     sync::{
         aref::ARef,
+        atomic::{
+            ordering,
+            Atomic, //
+        },
         Arc,
         Mutex, //
     },
@@ -153,6 +158,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     home_node: module_parameters::home_node.value(),
                     discard: module_parameters::discard.value(),
                     no_sched: module_parameters::no_sched.value(),
+                    bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -179,6 +185,7 @@ struct NullBlkOptions<'a> {
     home_node: i32,
     discard: bool,
     no_sched: bool,
+    bad_blocks: Arc<BadBlocks>,
 }
 struct NullBlkDevice;
 
@@ -196,6 +203,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             home_node,
             discard,
             no_sched,
+            bad_blocks,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -237,6 +245,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
                 completion_time,
                 memory_backed,
                 block_size: block_size.into(),
+                bad_blocks,
             }),
             GFP_KERNEL,
         )?;
@@ -351,6 +360,16 @@ fn transfer(
         }
         Ok(())
     }
+
+    fn end_request(rq: Owned<mq::Request<Self>>) {
+        let status = rq.data_ref().error.load(ordering::Relaxed);
+        rq.data_ref().error.store(0, ordering::Relaxed);
+
+        match status {
+            0 => rq.end_ok(),
+            _ => rq.end(bindings::BLK_STS_IOERR),
+        }
+    }
 }
 
 static_assert!((PAGE_SIZE >> SECTOR_SHIFT) <= 64);
@@ -396,12 +415,14 @@ struct QueueData {
     completion_time: Delta,
     memory_backed: bool,
     block_size: u64,
+    bad_blocks: Arc<BadBlocks>,
 }
 
 #[pin_data]
 struct Pdu {
     #[pin]
     timer: kernel::time::hrtimer::HrTimer<Self>,
+    error: Atomic<u32>,
 }
 
 impl HrTimerCallback for Pdu {
@@ -431,6 +452,7 @@ impl Operations for NullBlkDevice {
     fn new_request_data() -> impl PinInit<Self::RequestData> {
         pin_init!(Pdu {
             timer <- kernel::time::hrtimer::HrTimer::new(),
+            error: Atomic::new(0),
         })
     }
 
@@ -440,6 +462,19 @@ fn queue_rq(
         mut rq: Owned<mq::Request<Self>>,
         _is_last: bool,
     ) -> Result {
+        if queue_data.bad_blocks.enabled() {
+            let start = rq.sector();
+            let end = start + u64::from(rq.sectors());
+            if !matches!(
+                queue_data.bad_blocks.check(start..end),
+                badblocks::BlockStatus::None
+            ) {
+                rq.data_ref().error.store(1, ordering::Relaxed);
+            }
+        }
+
+        // TODO: Skip IO if bad block.
+
         if queue_data.memory_backed {
             memalloc_scope!(let _noio: NoIo);
             let tree = &queue_data.tree;
@@ -461,7 +496,7 @@ fn queue_rq(
         }
 
         match queue_data.irq_mode {
-            IRQMode::None => rq.end_ok(),
+            IRQMode::None => Self::end_request(rq),
             IRQMode::Soft => mq::Request::complete(rq.into()),
             IRQMode::Timer => {
                 OwnableRefCounted::into_shared(rq)
@@ -475,9 +510,10 @@ fn queue_rq(
     fn commit_rqs(_queue_data: Pin<&QueueData>) {}
 
     fn complete(rq: ARef<mq::Request<Self>>) {
-        OwnableRefCounted::try_from_shared(rq)
-            .map_err(|_e| kernel::error::code::EIO)
-            .expect("Failed to complete request")
-            .end_ok();
+        Self::end_request(
+            OwnableRefCounted::try_from_shared(rq)
+                .map_err(|_e| kernel::error::code::EIO)
+                .expect("Failed to complete request"),
+        )
     }
 }

-- 
2.51.2


