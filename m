Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C62DE6FF;
	Sun, 15 Feb 2026 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199146; cv=none; b=N1+CCTyKDXrqcqEFCuHMgxiv11ZB32K9i3blrOu5jiPN/k2J9K7Tg3gE3YT8EOnOweyODiNjpCGaemMqHS+gyxokFD7OgMljt7JBIF0iBYrX5BZ5Fe68/y6280z75XM4mUSdZKIp61oDxgCR2aAp+mDvDwN5EXl0swLc0RJS/gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199146; c=relaxed/simple;
	bh=SHQHcWrAr56kHNOm4L4h66Q7ENSNd//dP5BDvu4tb6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=da/iUjfH/eyh4tpOXW2YxR1YXzEkRJmH8RwnI1wngaCN0CHLmqxh3b18suALiAnY9+48TI3MYcDnD7f+n0fE8a5spCaR6+maZXedZ2NLi9+aFGfaowKGwVyi76O3W2S8cV2xpvVDLF+kkw8KcjIJX2x4qK9FP14gxTRZ/mUV/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPpt3LKx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPpt3LKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9D6C4CEF7;
	Sun, 15 Feb 2026 23:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199145;
	bh=SHQHcWrAr56kHNOm4L4h66Q7ENSNd//dP5BDvu4tb6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hPpt3LKx5ODgoYvnFGDMc14a3psBUBdm8tStjS5YgTVFEr+gtMc//bnKnabcdQdT7
	 I/rS6+/EcCG5iTAq6a3lk6rDMPGzsyC3TYYaS3t9M259/FDw1QplubWXeerUvMD6iB
	 LN6k+te+eC0yHj4VBoMBMMe6PaNnSxdaxBM+B5kfQyWawcr5LgZYkb3mDy5w8NOaGV
	 3wTNcFGqxqwLhPg9ZriKTYgMaud9NlUCz3brhRzVgXWpRYBO5nYRKmwGXvxWSAw7e/
	 IESujoisZqCNTtgdFy275L4lm7V5YNO6V+Rxs5YgWRrNr2S6AlI9Z7rG7FFLVOfEM8
	 ArP9h9+gYnmSA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:40 +0100
Subject: [PATCH 53/79] block: rnull: add polled completion support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-53-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10872;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=SHQHcWrAr56kHNOm4L4h66Q7ENSNd//dP5BDvu4tb6M=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhLjsQPQorh27YF42h7pD7jlkOf1PFHTBR0u
 3TI7UoofBKJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYSwAKCRDhuBo+eShj
 d/KSD/0Rq9t9OnKDySf4+B2ol8H/EOjSF++wjSDKMA6Gpxss08a0mQWIH/LyS47nXEwmBggaUy9
 tu/RxjMv0xAtNqMH+77fDnl4wQ6Mz71L75tvo5/bdr+r0XqtDpMFSz9/ORtahkvxnUh/fvZaPFi
 Kw9SMbHJLN7zdXYv3lmjmxORRblYVtx9wjy7fSkr1VIqgXlmF2PdImQjOj/3CiR1dvKRPrxBRTb
 jg/e3bw0Bylhy3p9JdQDWy45aS+y2Efo87I0xdwGJFHq66oC0imdKawYcAKJWVxN5uLYRaa8yPY
 DuKjEvfrHiFWnoVf/taQxtIOObpyTuEm9WFZQcc5ab/Bn6Y8c+E3cpmvHfNxZh8XRvElSrOs8gr
 g+gCRZ5xRBC7ttW7aJ452Nasv/Jjj5nX4W0coMwiJHjCEPU1aBZ16/K6NM3xg30jvGxlwUKxPL5
 sHAMc2ZuAWxKc98g3LwKspOP+ec5E+TCQAKUTawX0Hg91XkIiC3J7NrRmL1K9UTchJTepvhfY8X
 IDu6hjqSwaf1UQDrbaP20U18GBNQQMuC1e8MyCBNhR88ge25oY3qeGV9Omdqw4COBKSMZtTmsZ4
 gI6/xPGsy82TJ0P006FIq2h6Nf77XHBzaZ5tj1LD+KeI8k7C61GSP3d6nI8PPTXxRR7j9yb4mqG
 S4rjwcR/abkmxyA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for polled I/O completion in rnull. This feature requires
configuring poll queues via the `poll_queues` attribute.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  19 +++++-
 drivers/block/rnull/rnull.rs    | 130 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 136 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 0873d696f80f6..e134e21a6b564 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -71,7 +71,7 @@ impl AttributeOperations<0> for Config {
         writer.write_str(
             "blocksize,size,rotational,irqmode,completion_nsec,memory_backed\
              submit_queues,use_per_node_hctx,discard,blocking,shared_tags,\
-             zoned,zone_size,zone_capacity\n",
+             zoned,zone_size,zone_capacity,poll_queues\n",
         )?;
         Ok(writer.bytes_written())
     }
@@ -117,6 +117,7 @@ fn make_group(
                 zone_max_open: 24,
                 zone_max_active: 25,
                 zone_append_max_sectors: 26,
+                poll_queues: 27,
             ],
         };
 
@@ -156,6 +157,7 @@ fn make_group(
                     zone_max_open: 0,
                     zone_max_active: 0,
                     zone_append_max_sectors: u32::MAX,
+                    poll_queues: 0,
                 }),
             }),
             core::iter::empty(),
@@ -231,6 +233,7 @@ struct DeviceConfigInner {
     zone_max_open: u32,
     zone_max_active: u32,
     zone_append_max_sectors: u32,
+    poll_queues: u32,
 }
 
 #[vtable]
@@ -281,6 +284,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 zone_max_open: guard.zone_max_open,
                 zone_max_active: guard.zone_max_active,
                 zone_append_max_sectors: guard.zone_append_max_sectors,
+                poll_queues: guard.poll_queues,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -510,3 +514,16 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 configfs_simple_field!(DeviceConfig, 24, zone_max_open, u32);
 configfs_simple_field!(DeviceConfig, 25, zone_max_active, u32);
 configfs_simple_field!(DeviceConfig, 26, zone_append_max_sectors, u32);
+configfs_simple_field!(
+    DeviceConfig,
+    27,
+    poll_queues,
+    u32,
+    check | value | {
+        if value > kernel::num_possible_cpus() {
+            Err(kernel::error::code::EINVAL)
+        } else {
+            Ok(())
+        }
+    }
+);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 765bbc8101d10..92e75f15e02c6 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -33,6 +33,7 @@
                 GenDisk,
                 GenDiskRef, //
             },
+            IoCompletionBatch,
             Operations,
             TagSet, //
         },
@@ -188,6 +189,10 @@
             default: 0,
             description: "Maximum size of a zone append command (in 512B sectors). Specify 0 for no zone append.",
         },
+        poll_queues: u32 {
+            default: 0,
+            description: "Number of IOPOLL submission queues.",
+        },
     },
 }
 
@@ -244,6 +249,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     zone_max_open: *module_parameters::zone_max_open.value(),
                     zone_max_active: *module_parameters::zone_max_active.value(),
                     zone_append_max_sectors: *module_parameters::zone_append_max_sectors.value(),
+                    poll_queues: *module_parameters::poll_queues.value(),
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -291,6 +297,7 @@ struct NullBlkOptions<'a> {
     zone_max_active: u32,
     #[cfg_attr(not(CONFIG_BLK_DEV_ZONED), expect(unused_variables))]
     zone_append_max_sectors: u32,
+    poll_queues: u32,
 }
 
 static SHARED_TAG_SET: SetOnce<Arc<TagSet<NullBlkDevice>>> = SetOnce::new();
@@ -348,6 +355,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             zone_max_open,
             zone_max_active,
             zone_append_max_sectors,
+            poll_queues,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -369,7 +377,21 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
 
         let tagset_ctor = || -> Result<Arc<_>> {
             Arc::pin_init(
-                TagSet::new(submit_queues, (), hw_queue_depth, 1, home_node, flags),
+                TagSet::new(
+                    submit_queues + poll_queues,
+                    KBox::new(
+                        NullBlkTagsetData {
+                            queue_depth: hw_queue_depth,
+                            submit_queue_count: submit_queues,
+                            poll_queue_count: poll_queues,
+                        },
+                        GFP_KERNEL,
+                    )?,
+                    hw_queue_depth,
+                    if poll_queues == 0 { 1 } else { 3 },
+                    home_node,
+                    flags,
+                ),
                 GFP_KERNEL,
             )
         };
@@ -685,6 +707,7 @@ fn run(
 
 struct HwQueueContext {
     page: Option<KBox<disk_storage::NullBlockPage>>,
+    poll_queue: kernel::ringbuffer::RingBuffer<Owned<mq::Request<NullBlkDevice>>>,
 }
 
 #[pin_data]
@@ -713,11 +736,17 @@ impl HasHrTimer<Self> for Pdu {
     }
 }
 
+struct NullBlkTagsetData {
+    queue_depth: u32,
+    submit_queue_count: u32,
+    poll_queue_count: u32,
+}
+
 #[vtable]
 impl Operations for NullBlkDevice {
     type QueueData = Arc<Self>;
     type RequestData = Pdu;
-    type TagSetData = ();
+    type TagSetData = KBox<NullBlkTagsetData>;
     type HwData = Pin<KBox<SpinLock<HwQueueContext>>>;
 
     fn new_request_data() -> impl PinInit<Self::RequestData> {
@@ -733,7 +762,7 @@ fn queue_rq(
         this: ArcBorrow<'_, Self>,
         rq: Owned<mq::IdleRequest<Self>>,
         _is_last: bool,
-        _is_poll: bool,
+        is_poll: bool,
     ) -> BlkResult {
         if this.bandwidth_limit != 0 {
             if !this.bandwidth_timer.active() {
@@ -770,13 +799,29 @@ fn queue_rq(
         #[cfg(not(CONFIG_BLK_DEV_ZONED))]
         this.handle_regular_command(&hw_data, &mut rq)?;
 
-        match this.irq_mode {
-            IRQMode::None => Self::end_request(rq),
-            IRQMode::Soft => mq::Request::complete(rq.into()),
-            IRQMode::Timer => {
-                OwnableRefCounted::into_shared(rq)
-                    .start(this.completion_time)
-                    .dismiss();
+        if is_poll {
+            // NOTE: We lack the ability to insert `Owned<Request>` into a
+            // `kernel::list::List`, so we use a `RingBuffer` instead. The
+            // drawback of this is that we have to allocate the space for the
+            // ring buffer during drive initialization, and we have to hold the
+            // lock protecting the list until we have processed all the requests
+            // in the list. Change to a linked list when the kernel gets this
+            // ability.
+
+            // NOTE: We are processing requests during submit rather than during
+            // poll. This is different from C driver. C driver does processing
+            // during poll.
+
+            hw_data.lock().poll_queue.push_head(rq)?;
+        } else {
+            match this.irq_mode {
+                IRQMode::None => Self::end_request(rq),
+                IRQMode::Soft => mq::Request::complete(rq.into()),
+                IRQMode::Timer => {
+                    OwnableRefCounted::into_shared(rq)
+                        .start(this.completion_time)
+                        .dismiss();
+                }
             }
         }
         Ok(())
@@ -784,8 +829,39 @@ fn queue_rq(
 
     fn commit_rqs(_hw_data: Pin<&SpinLock<HwQueueContext>>, _queue_data: ArcBorrow<'_, Self>) {}
 
-    fn init_hctx(_tagset_data: (), _hctx_idx: u32) -> Result<Self::HwData> {
-        KBox::pin_init(new_spinlock!(HwQueueContext { page: None }), GFP_KERNEL)
+    fn poll(
+        hw_data: Pin<&SpinLock<HwQueueContext>>,
+        _this: ArcBorrow<'_, Self>,
+        batch: &mut IoCompletionBatch<Self>,
+    ) -> Result<bool> {
+        let mut guard = hw_data.lock();
+        let mut completed = false;
+
+        while let Some(rq) = guard.poll_queue.pop_tail() {
+            let status = rq.data_ref().error.load(ordering::Relaxed);
+            rq.data_ref().error.store(0, ordering::Relaxed);
+
+            // TODO: check error handling via status
+            if let Err(rq) = batch.add_request(rq, status != 0) {
+                Self::end_request(rq);
+            }
+
+            completed = true;
+        }
+
+        Ok(completed)
+    }
+
+    fn init_hctx(tagset_data: &NullBlkTagsetData, _hctx_idx: u32) -> Result<Self::HwData> {
+        KBox::pin_init(
+            new_spinlock!(HwQueueContext {
+                page: None,
+                poll_queue: kernel::ringbuffer::RingBuffer::new(
+                    tagset_data.queue_depth.try_into()?
+                )?,
+            }),
+            GFP_KERNEL,
+        )
     }
 
     fn complete(rq: ARef<mq::Request<Self>>) {
@@ -805,4 +881,34 @@ fn report_zones(
     ) -> Result<u32> {
         Self::report_zones_internal(disk, sector, nr_zones, callback)
     }
+
+    fn map_queues(tag_set: Pin<&mut TagSet<Self>>) {
+        let mut submit_queue_count = tag_set.data().submit_queue_count;
+        let mut poll_queue_count = tag_set.data().poll_queue_count;
+
+        if tag_set.hw_queue_count() != submit_queue_count + poll_queue_count {
+            pr_warn!(
+                "tag set has unexpected hardware queue count: {}\n",
+                tag_set.hw_queue_count()
+            );
+            submit_queue_count = 1;
+            poll_queue_count = 0;
+        }
+
+        let mut offset = 0;
+        tag_set
+            .update_maps(|mut qmap| {
+                use mq::QueueType::*;
+                let queue_count = match qmap.kind() {
+                    Default => submit_queue_count,
+                    Read => 0,
+                    Poll => poll_queue_count,
+                };
+                qmap.set_queue_count(queue_count);
+                qmap.set_offset(offset);
+                offset += queue_count;
+                qmap.map_queues();
+            })
+            .unwrap()
+    }
 }

-- 
2.51.2


