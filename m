Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA222DECA1;
	Sun, 15 Feb 2026 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198923; cv=none; b=aFlv2owfZKDoE+rjaoOIQPuDrn+NNDk/D6d7DEH0+2BEA3/fcsstLwOrKRWMclef132hq0ssmh3JTotQJe6h4s84RI9iruznNtoKXmomcEwKgFa60OUQ0wY7u5bA48zGjtN25uy2vXVEpopTF6Us5U4fak/6rfKJ6+O+yXv2jmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198923; c=relaxed/simple;
	bh=EF8S7FmFl3vSFKxHiqAFcxC7opaobmJHHkh7NyfesPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bN2El3oXd3DI7Ft/TJctppf/cqC00ebY6bpJCA3Ak7x8SZoTCKOfDR4RGZCfqa3tnIdGqxEALVxQAR4HgZVh9rwcgZGoP0soSDRiX1nrBHBI8xzBez2WYRAAJljyQor0EvgzMxquGyfJYVMs4BP2T837qHMHR+nxxtcQ8C/nfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohVjIgyq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohVjIgyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A76FC19422;
	Sun, 15 Feb 2026 23:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198923;
	bh=EF8S7FmFl3vSFKxHiqAFcxC7opaobmJHHkh7NyfesPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ohVjIgyq+9ZcKRmy85+VAIPos6ieoFUf7IrfB0vpWBkF4UmMEIJGcb7X3KUIu7szr
	 uQp+/uHB89+wk4oLqScNs3x/4AKs9vyO6WBUXGIMKpZSWmh10K9TIK3nFv83V6mY+f
	 3FLGDsu8oRMyp6Ekxmwb+d3nnaraSnjz1U6/+9R3KKI5A3ZJKqrxQYYe8I0QyyaOsH
	 PjD9BxtoBixN2sAf9tLYSkyhkWl0dsqPZo9gNpNXbDasvkkhxcxoXBZ+egOFkckO3G
	 yQo4+hK0C0YQwHYvQait1QpFBjc1+x7ds+Uh4bCb5YlMzksGZPZ4gZQjLWNb85wOlQ
	 M43NGEbAZPdTQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:13 +0100
Subject: [PATCH 26/79] block: rnull: add badblocks support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-26-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8577; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=EF8S7FmFl3vSFKxHiqAFcxC7opaobmJHHkh7NyfesPA=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgzCA5NKN0hlzRJ+B3wI8OXUsh2VHHxSR288
 UF5GphVh4OJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYMwAKCRDhuBo+eShj
 d2wvEACO+eazDMVAJLN0GdcSEnzfv4GHoA4o8dfxM15esOo7Welb8VxAhDC2XXVg3Qb7tsdG3Wv
 yQ0qA8AvvWvnsdwXiElwFD14hB509xw5X7VZyEWLTmeUB7ZsKA0I/YSA3XSZr7+/C2e78nOPsf8
 faDFaVBXfb/pXA+Pm9YHNn6j1mlKBfFj2u0j6M8Ei+rvZRxm0KzTQHa8inblXNOXFxGNYkyAwdv
 eEqQ6LLNz1AspU0lNhC4rtn/DBzN9v6MHJCEqUtesRgrxoNd41B2A6h2NZrmX63hSwJEFHzatyj
 UXAZF7luejDKv4T2xgWsN/HPbuxRiRam9mT0fVxZO4zOtjqd+vbr6VteXCRLC1fQNytkvrOxX/0
 V46/1Qr9layTOdMPU6fF6hEDeV4wiJNImaicjCBNlEzmEY0g0sTjZ/xCq6XnQPeN5hVdI1MM3dl
 tKeIrYpzRDIPwrPQtoJ3JMwaIUMDeZhssAut5Dxu01PGoX2ayRd4Og8pJuVAJ61tVHPX8goJDkY
 PGAsDNIqyJybynjO2OFs0QdxeU8ali0gl3ivlIU3ycJ6APNzICDdHDoViaKV1fNPtx/FoOWxoPi
 2ugP9oVP+5W9lWVpGYFFkxD8nz+hAsVx6LCIpFfvXGrVhUWftQUDYs0zQ9sArU2lynbpttaYx0S
 o2ykBH3e1UR4mjg==
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
index 18e32a87673aa..61a76addf468b 100644
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
     c_str,
     configfs::{
@@ -27,7 +30,10 @@
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
@@ -96,6 +102,7 @@ fn make_group(
                 home_node: 9,
                 discard: 10,
                 no_sched:11,
+                badblocks: 12,
             ],
         };
 
@@ -118,6 +125,7 @@ fn make_group(
                     home_node: bindings::NUMA_NO_NODE,
                     discard: false,
                     no_sched: false,
+                    bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                 }),
             }),
             core::iter::empty(),
@@ -177,6 +185,7 @@ struct DeviceConfigInner {
     home_node: i32,
     discard: bool,
     no_sched: bool,
+    bad_blocks: Arc<BadBlocks>,
 }
 
 #[vtable]
@@ -212,6 +221,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 home_node: guard.home_node,
                 discard: guard.discard,
                 no_sched: guard.no_sched,
+                bad_blocks: guard.bad_blocks.clone(),
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -367,3 +377,48 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     }
 }
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
index b0008e2f9c398..861392c5b5841 100644
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
@@ -37,6 +38,10 @@
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
@@ -155,6 +160,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     home_node: *module_parameters::home_node.value(),
                     discard: *module_parameters::discard.value() != 0,
                     no_sched: *module_parameters::no_sched.value() != 0,
+                    bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -181,6 +187,7 @@ struct NullBlkOptions<'a> {
     home_node: i32,
     discard: bool,
     no_sched: bool,
+    bad_blocks: Arc<BadBlocks>,
 }
 struct NullBlkDevice;
 
@@ -198,6 +205,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             home_node,
             discard,
             no_sched,
+            bad_blocks,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -226,6 +234,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
                 completion_time,
                 memory_backed,
                 block_size: block_size.into(),
+                bad_blocks,
             }),
             GFP_KERNEL,
         )?;
@@ -327,6 +336,16 @@ fn transfer(
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
 
 const _CHEKC_STATUS_WIDTH: () = build_assert!((PAGE_SIZE >> SECTOR_SHIFT) <= 64);
@@ -373,12 +392,14 @@ struct QueueData {
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
@@ -408,6 +429,7 @@ impl Operations for NullBlkDevice {
     fn new_request_data() -> impl PinInit<Self::RequestData> {
         pin_init!(Pdu {
             timer <- kernel::time::hrtimer::HrTimer::new(),
+            error: Atomic::new(0),
         })
     }
 
@@ -417,6 +439,19 @@ fn queue_rq(
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
             let tree = &queue_data.tree;
             let command = rq.command();
@@ -437,7 +472,7 @@ fn queue_rq(
         }
 
         match queue_data.irq_mode {
-            IRQMode::None => rq.end_ok(),
+            IRQMode::None => Self::end_request(rq),
             IRQMode::Soft => mq::Request::complete(rq.into()),
             IRQMode::Timer => {
                 OwnableRefCounted::into_shared(rq)
@@ -451,9 +486,10 @@ fn queue_rq(
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


