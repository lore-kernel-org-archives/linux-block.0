Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAEE4D90B3;
	Tue,  9 Jun 2026 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032494; cv=none; b=PfekR4wBDQ1E45a7gSWylZaz5mtery5BO+rRh+5ZXwaa6OTS6YzrDiizSX3sECTWphP7Z5Oc+2pvwzs1P4cFLeUE+1u7/yXUlAcdfyUhuKX3K8Vvf5YjoqCfIXZl/MKeMIdMYj1X/SUVJuRMHrcU2KuiTXqvVBheZLZ8maLY8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032494; c=relaxed/simple;
	bh=QPO62OaNBIAfYDSzpo0UED4W/ZvhuueaX47bHuuBkyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bENFMTsruEAHtMXVy9ZcIrRXQ4gJM2IE7MyNJsJEljmGdTA4n7lH6KYesLLKUUW/CzkYmGBXXTZljQgEaLLyuysyvwIA67FK2g8mhOwbwTstKVySr6SZiZSjFo58mq6AsPJyls4NM03rKajisxsUh89lLw0+UrjcYu5g64Hwi1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyN9ApUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyN9ApUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B4D1F00893;
	Tue,  9 Jun 2026 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032493;
	bh=UouDyN+bv+pg1LIszIBRKxLF6COncO6rj93swX5VWIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EyN9ApUfLL7GV5unCKn9nFGRDRGHNM1W5clT9YVptBVEqFjAbCGjIBHUbnHjVVhfn
	 d5uVEg1A/JZvhLoyetw6k5KAZCtYdLSAbmbb8yJjzr323cvRoCQ7VkrB064O56K11E
	 hS5S4KlWrLH9jGXzqfywsP2fv61lQQBKlpiMql83NeIV3k7vcnOlWALLQfPaI+tBAl
	 SdIK0ERHvxsCdU1Vfeex19y09guma31EZbBvtwmLSe0ievVd7CWLznlewGDo9nSbUq
	 2nrW3VYJV5vMvkApzTI7Goqeiw7fcVjshw/Z6RJwm07L85IH+/VAXtgpprwxF6fcMV
	 2kPx10Q0vCYTw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:37 +0200
Subject: [PATCH v2 58/83] block: rnull: add polled completion support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-58-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11432;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=QPO62OaNBIAfYDSzpo0UED4W/ZvhuueaX47bHuuBkyo=;
 b=kA0DAAoB+lApCKrFvdAByyZiAGooZOnIPDXi/2iD3GYkBFxkVpu58B/kp89G/GaHEdTrd59Bl
 YkCMwQAAQoAHRYhBFeK2cjZZnYmKsBqhvpQKQiqxb3QBQJqKGTpAAoJEPpQKQiqxb3QW0MP/1uA
 Mf80s3MI/u69Kg8Js4t4bnVVcYYpKrOYyg5QbzOwZtuWMtPpcrT4p0tUAbZJXwV5jcallrMAijS
 9/NgFGS/iJxUfsI94X9nDW7h7UFCE9Hf/h1sKDMrPtngmzlq8jbdgrPZQCAhkXb+TAs9DEd2y3N
 Opjf2z8Q99n93ZvTR6ae3urfkxV4A61jJXRoMI3zaP2XLy4AqMcmHPuH93OEuMBk0UJMHDCLJgo
 5ksHNOnU8cK3NlXRX4s61C97aaHU17fkjB3uQrD1QP0m7vWk0sFy32vN458lFze9C8q6wEmA0VD
 /PIhUK9WAmIY+eNG8UsLRI0TknpR5yZDLZXHM3KCZLijMYMhyHVY3d0TEvWymy1sQyMABTM60pk
 PYx5hfX0F+fOuuv0XD5G20jX4PytlMbO7wgI675kHDgwC2D6jnvKF43Wg3eYkx118ZFJ2WDALD9
 Gpa98cqnyRozMPuNdMQNHmhB0JMPzt81KCB9tUmDN/y66Tct91BSe0pXjpz7ca3IK06j/JF9Zo5
 AVJ+Cu5BU1bjHtFk8kdhppC6OtqUFgpINvDqQYkEjubhKzk/EwxSSz2zkBEOEhWgb9CoUxOX2ME
 gZ5qPQ7MMPlOh3K70OA6GFpsiIh7fRhDabpH+XOrRW1l8jyEVQa7vSf1i/eJmS9m6zug8wmD0KX
 8kr8g
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for polled I/O completion in rnull. This feature requires
configuring poll queues via the `poll_queues` attribute.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  19 +++++-
 drivers/block/rnull/rnull.rs    | 133 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 139 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index f866595a263c..0637c1e0ab22 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -81,7 +81,7 @@ impl AttributeOperations<0> for Config {
         writer.write_str(
             "blocksize,size,rotational,irqmode,completion_nsec,memory_backed,\
              submit_queues,use_per_node_hctx,discard,blocking,shared_tags,\
-             zoned,zone_size,zone_capacity\n",
+             zoned,zone_size,zone_capacity,poll_queues\n",
         )?;
         Ok(writer.bytes_written())
     }
@@ -127,6 +127,7 @@ fn make_group(
                 zone_max_open: 24,
                 zone_max_active: 25,
                 zone_append_max_sectors: 26,
+                poll_queues: 27,
             ],
         };
 
@@ -167,6 +168,7 @@ fn make_group(
                     zone_max_open: 0,
                     zone_max_active: 0,
                     zone_append_max_sectors: u32::MAX,
+                    poll_queues: 0,
                 }),
             }),
             core::iter::empty(),
@@ -253,6 +255,7 @@ struct DeviceConfigInner {
     zone_max_open: u32,
     zone_max_active: u32,
     zone_append_max_sectors: u32,
+    poll_queues: u32,
 }
 
 #[vtable]
@@ -305,6 +308,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 shared_tag_set: guard.shared_tags.then(|| guard.shared_tag_set.clone()),
                 tag_set: crate::TagSetOptions {
                     submit_queues: guard.submit_queues,
+                    poll_queues: guard.poll_queues,
                     home_node: guard.home_node,
                     blocking: guard.blocking,
                     memory_backed: guard.memory_backed,
@@ -498,3 +502,16 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 configfs_simple_field!(DeviceConfig, 24, zone_max_open, u32);
 configfs_simple_field!(DeviceConfig, 25, zone_max_active, u32);
 configfs_simple_field!(DeviceConfig, 26, zone_append_max_sectors, u32);
+configfs_simple_field!(
+    DeviceConfig,
+    27,
+    poll_queues,
+    u32,
+    check(|value| {
+        if value > kernel::cpu::num_possible_cpus() {
+            Err(kernel::error::code::EINVAL)
+        } else {
+            Ok(())
+        }
+    })
+);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 076493f92516..edb4ef53d6ad 100644
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
@@ -186,6 +187,10 @@
             default: 0,
             description: "Maximum size of a zone append command (in 512B sectors). Specify 0 for no zone append.",
         },
+        poll_queues: u32 {
+            default: 0,
+            description: "Number of IOPOLL submission queues.",
+        },
     },
 }
 
@@ -207,6 +212,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
             } else {
                 module_parameters::submit_queues.value()
             };
+            let poll_queues = module_parameters::poll_queues.value();
             let home_node = module_parameters::home_node.value();
             let blocking = module_parameters::blocking.value();
             let memory_backed = module_parameters::memory_backed.value();
@@ -215,6 +221,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
 
             let shared_tag_set = NullBlkDevice::build_tag_set(TagSetOptions {
                 submit_queues,
+                poll_queues,
                 home_node,
                 blocking,
                 memory_backed,
@@ -246,6 +253,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                         .then(|| shared_tag_set.clone()),
                     tag_set: TagSetOptions {
                         submit_queues,
+                        poll_queues,
                         home_node,
                         blocking,
                         memory_backed,
@@ -325,6 +333,7 @@ struct NullBlkDevice {
 
 struct TagSetOptions {
     submit_queues: u32,
+    poll_queues: u32,
     home_node: i32,
     blocking: bool,
     memory_backed: bool,
@@ -338,6 +347,7 @@ impl NullBlkDevice {
     fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
         let TagSetOptions {
             submit_queues,
+            poll_queues,
             home_node,
             blocking,
             memory_backed,
@@ -364,7 +374,21 @@ fn build_tag_set(options: TagSetOptions) -> Result<Arc<TagSet<Self>>> {
         }
 
         Arc::pin_init(
-            TagSet::new(submit_queues, (), hw_queue_depth, 1, numa_node, flags),
+            TagSet::new(
+                submit_queues + poll_queues,
+                KBox::new(
+                    NullBlkTagsetData {
+                        queue_depth: hw_queue_depth,
+                        submit_queue_count: submit_queues,
+                        poll_queue_count: poll_queues,
+                    },
+                    GFP_KERNEL,
+                )?,
+                hw_queue_depth,
+                if poll_queues == 0 { 1 } else { 3 },
+                numa_node,
+                flags,
+            ),
             GFP_KERNEL,
         )
     }
@@ -729,6 +753,7 @@ fn run(
 
 struct HwQueueContext {
     page: Option<KBox<disk_storage::NullBlockPage>>,
+    poll_queue: kernel::alloc::ringbuffer::KRingBuffer<Owned<mq::Request<NullBlkDevice>>>,
 }
 
 #[pin_data]
@@ -757,11 +782,17 @@ impl HasHrTimer<Self> for Pdu {
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
@@ -777,7 +808,7 @@ fn queue_rq(
         this: ArcBorrow<'_, Self>,
         rq: Owned<mq::IdleRequest<Self>>,
         _is_last: bool,
-        _is_poll: bool,
+        is_poll: bool,
     ) -> BlkResult {
         if this.bandwidth_limit != 0 {
             if !this.bandwidth_timer.active() {
@@ -814,13 +845,29 @@ fn queue_rq(
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
@@ -828,8 +875,40 @@ fn queue_rq(
 
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
+                poll_queue: kernel::alloc::ringbuffer::KRingBuffer::new(
+                    tagset_data.queue_depth.try_into()?,
+                    GFP_KERNEL,
+                )?,
+            }),
+            GFP_KERNEL,
+        )
     }
 
     fn complete(rq: ARef<mq::Request<Self>>) {
@@ -849,4 +928,34 @@ fn report_zones(
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


