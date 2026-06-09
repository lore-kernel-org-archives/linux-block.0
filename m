Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C5123D2A4;
	Tue,  9 Jun 2026 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032235; cv=none; b=Mf36gWFUdt/skA1KGkorig2NqA/8QoO6c8D8O+FWOtYQhX5OQe2ifJlj8+gg2pHyb2cZDUtaydD2c5Ag3We9KxAV+jmvUC+yDHHNdM+3QBk5VgJFCLRYptLPTcf2ejJZ6DyWP45YO5pXGeSRSJybmLuECpgqJ+Pqc0on0nJEqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032235; c=relaxed/simple;
	bh=HAe34xfCsUoHt6x/RPtlMZRmBGzEmDCCiUB3Z6xwSqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZNdTcAYKMqPlZZhdqiWiKPRzm6qNk0tll+ATDzxOJbo3nft9Q9Art3h3DxcCSIyTs7UlvVPIh89t1WoKB2mmDp1hoTHcAfX0YyPRhpHMUS6r/OrpuM5HSa9L1yEjtJRTzT9dx+wMLBA1o3p2vIm6DhrTe/+0oTuDE6OZ8kk/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHfR6GEK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHfR6GEK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3181F00893;
	Tue,  9 Jun 2026 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032234;
	bh=n7KJ52vVknn+HZxloD2rw0BcCGYGEtC34QZpg9ZQ/io=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DHfR6GEKhSRqH51YDspmHwYVmBeWfn0CFJ/sAWvISIn+W4A9qsA7B1nseHmI9fiHF
	 fZ006O6symB4+yUn2j81GvONJQmwZxHnj/cLWbXxYDvferpNv0TrcPzwvhEVsyeaI7
	 DJ+2svd/J2oDkl4QLUXMSlIBwsrmmUp/uPc+Os7h/VPVSd31f9NoRnMFMSubPoszuA
	 SRfRxPag60Tu/3j905lr8UWXI3WTFD/IK8qMW6Itr4ZBTB4ryLxVIoHVfytCuBFdhf
	 aJknQP6B8UQBj+JRBnRcvEBmZWcBnsTCNNNHkwYHwiGKnaZc+i1TYX/J1jzkOvYm6y
	 8jVegc5ufeA4g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:49 +0200
Subject: [PATCH v2 70/83] block: rnull: support queue_rqs
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-70-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12569;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=HAe34xfCsUoHt6x/RPtlMZRmBGzEmDCCiUB3Z6xwSqQ=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT0dEhhxLsMeCG5/JhmGIrhDtwxcH+HffVaZ
 VUvAm0Dw4qJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk9AAKCRD6UCkIqsW9
 0Nr4D/9RKrd5HFQ7814Jyv+pbynsFomOHkYK6cDSuf2Vza5IIU7h6Ha59MUhEldPZvuKHYS/b0w
 Ak6vgufUIxiEU1Rw3BQtOyBRrwvHuJrMS6+g6MVJ53nlr4tPdnEQzI5fUGg6NmXH7e8UaSZFqNF
 o5fYoOcFgfeP/7HiusbwsMOeFcKG3hqKCFfOLwE0MFKJDYXpStrl3RTttqlvDugrHB2jiFLoyEk
 tHd91XqBTKqvDf5rlHWRO0096yLfkoSROlBMwOWeu5VgAQfaSvMXLbiMJFc6jb2I48SjxsGomk4
 cKT6ggfDBWvWKQQ+u1+tzez4mswknQrIx5ndWVD6xVUSomSnkgMHDI350YFsWWKYFPCygsYlUpV
 /lT6rdCcL3qoD+Z2iJRbH8XeyOOXXI+7lEXEQOI2yAfHrg77SRux0KCIcR9lRNXu1gxsLfsJdoh
 67yj+m+biE+807KtgYaYe3Ohf5/J0gAyAhcSMXDJsAAhBDSgzlVkKNZ0T9oW+6N/onQ0HXSwfHv
 uLDNeF7aU3ulKhQIQ0bOFyqHNGAUtxiZdVdSbHIb5g3g0P6YOUyG/mZRNkfwsIUGdz2IQepDAo1
 xLKtyh5y1oS2pL/sXZxAlok8wWtLhVfFOWZcLVQ0D6Mvdm0f43pYuY/jhS7e7plZqvND7ji1uBB
 hmuxkWh6ftahgbw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Implement the `queue_rqs` callback for rnull, allowing the block layer
to submit multiple requests in a single call. This improves performance
by reducing per-request overhead and enabling batch processing.

The implementation processes requests from the list one at a time,
removing successfully processed requests from the list.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/disk_storage.rs |  36 ++++----
 drivers/block/rnull/rnull.rs        | 180 +++++++++++++++++++++++-------------
 2 files changed, 133 insertions(+), 83 deletions(-)

diff --git a/drivers/block/rnull/disk_storage.rs b/drivers/block/rnull/disk_storage.rs
index 4a9bf480221f..6797b7996da3 100644
--- a/drivers/block/rnull/disk_storage.rs
+++ b/drivers/block/rnull/disk_storage.rs
@@ -86,7 +86,7 @@ pub(crate) fn discard(
         }
     }
 
-    pub(crate) fn flush(&self, hw_data: &Pin<&SpinLock<HwQueueContext>>) -> Result {
+    pub(crate) fn flush(&self, hw_data: &Pin<&SpinLock<HwQueueContext>>) {
         let mut tree_guard = self.lock();
         let mut hw_data_guard = hw_data.lock();
         let mut access = self.access(&mut tree_guard, &mut hw_data_guard, None);
@@ -131,7 +131,7 @@ fn to_sector(index: usize) -> u64 {
         (index << block::PAGE_SECTORS_SHIFT) as u64
     }
 
-    fn extract_cache_page(&mut self) -> Result<Option<KBox<NullBlockPage>>> {
+    fn extract_cache_page(&mut self) -> Option<KBox<NullBlockPage>> {
         Self::extract_cache_page_inner(
             &mut self.cache_guard,
             &mut self.disk_guard,
@@ -147,16 +147,10 @@ fn extract_cache_page_inner<'g>(
         disk_storage: &DiskStorage,
         hw_data: &mut HwQueueContext,
         sheaf: Option<&mut XArraySheaf<'_>>,
-    ) -> Result<Option<KBox<NullBlockPage>>> {
+    ) -> Option<KBox<NullBlockPage>> {
         let cache_entry = cache_guard.find_next_entry_circular(
             disk_storage.next_flush_sector.load(ordering::Relaxed) as usize,
-        );
-
-        let cache_entry = if let Some(entry) = cache_entry {
-            entry
-        } else {
-            return Ok(None);
-        };
+        )?;
 
         let index = cache_entry.index();
 
@@ -183,11 +177,14 @@ fn extract_cache_page_inner<'g>(
                     let mut src = cache_entry;
                     let mut offset = 0;
                     for _ in 0..PAGE_SECTORS {
-                        src.page_mut().as_pin_mut().copy_to_page(
-                            disk_entry.page_mut().as_pin_mut(),
-                            offset,
-                            block::SECTOR_SIZE as usize,
-                        )?;
+                        src.page_mut()
+                            .as_pin_mut()
+                            .copy_to_page(
+                                disk_entry.page_mut().as_pin_mut(),
+                                offset,
+                                block::SECTOR_SIZE as usize,
+                            )
+                            .expect("Write to succeed");
                         offset += block::SECTOR_SIZE as usize;
                     }
                     src.remove()
@@ -197,16 +194,15 @@ fn extract_cache_page_inner<'g>(
             }
         };
 
-        Ok(Some(page))
+        Some(page)
     }
 
-    fn flush(&mut self) -> Result {
+    fn flush(&mut self) {
         if self.disk_storage.cache_size > 0 {
-            while let Some(page) = self.extract_cache_page()? {
+            while let Some(page) = self.extract_cache_page() {
                 drop(page);
             }
         }
-        Ok(())
     }
 
     fn get_or_alloc_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
@@ -230,7 +226,7 @@ fn get_or_alloc_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage>
                         self.disk_storage,
                         self.hw_data_guard,
                         self.sheaf.as_mut(),
-                    )?
+                    )
                     .expect("Expected to find a page in the cache")
                 };
                 let xarray::Entry::Vacant(vacant_entry) = cache_guard.entry(index) else {
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 6653db5c069b..32af69bbf8f0 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -28,7 +28,7 @@
             BadBlocks, //
         },
         bio::Segment,
-        error::BlkResult,
+        error::{BlkError, BlkResult},
         mq::{
             self,
             gen_disk::{
@@ -36,8 +36,10 @@
                 GenDisk,
                 GenDiskRef, //
             },
+            IdleRequest,
             IoCompletionBatch,
             Operations,
+            RequestList,
             TagSet, //
         },
         SECTOR_SHIFT,
@@ -773,6 +775,104 @@ fn complete_request(&self, rq: Owned<mq::Request<Self>>) {
             }
         }
     }
+
+    #[inline(always)]
+    fn queue_rq_internal(
+        hw_data: Pin<&SpinLock<HwQueueContext>>,
+        this: ArcBorrow<'_, Self>,
+        rq: Owned<mq::IdleRequest<Self>>,
+        _is_last: bool,
+    ) -> Result<(), QueueRequestError> {
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
+                return Err(QueueRequestError { request: rq });
+            }
+        }
+
+        let mut rq = rq.start();
+
+        if rq.command() == mq::Command::Flush {
+            if this.memory_backed {
+                this.storage.flush(&hw_data);
+            }
+            this.complete_request(rq);
+
+            return Ok(());
+        }
+
+        let status = (|| -> Result {
+            #[cfg(CONFIG_BLK_DEV_ZONED)]
+            if this.zoned.enabled {
+                this.handle_zoned_command(&hw_data, &mut rq)?;
+            } else {
+                this.handle_regular_command(&hw_data, &mut rq)?;
+            }
+
+            #[cfg(not(CONFIG_BLK_DEV_ZONED))]
+            this.handle_regular_command(&hw_data, &mut rq)?;
+
+            Ok(())
+        })();
+
+        if let Err(e) = status {
+            // Do not overwrite existing error. We do not care whether this write fails.
+            let _ = rq
+                .data_ref()
+                .error
+                .cmpxchg(0, e.to_errno(), ordering::Relaxed);
+        }
+
+        if rq.is_poll() {
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
+            hw_data
+                .lock()
+                .poll_queue
+                .push_head(rq)
+                .expect("Buffer is sized to hold all in flight requests");
+        } else {
+            this.complete_request(rq);
+        }
+
+        Ok(())
+    }
+}
+
+struct QueueRequestError {
+    request: Owned<IdleRequest<NullBlkDevice>>,
+}
+
+impl From<QueueRequestError> for BlkError {
+    fn from(_value: QueueRequestError) -> Self {
+        kernel::block::error::code::BLK_STS_IOERR
+    }
 }
 
 impl_has_hr_timer! {
@@ -814,7 +914,7 @@ struct HwQueueContext {
 struct Pdu {
     #[pin]
     timer: HrTimer<Self>,
-    error: Atomic<u32>,
+    error: Atomic<i32>,
 }
 
 impl HrTimerCallback for Pdu {
@@ -855,76 +955,31 @@ fn new_request_data() -> impl PinInit<Self::RequestData> {
         })
     }
 
-    #[inline(always)]
     fn queue_rq(
         hw_data: Pin<&SpinLock<HwQueueContext>>,
         this: ArcBorrow<'_, Self>,
         rq: Owned<mq::IdleRequest<Self>>,
-        _is_last: bool,
-        is_poll: bool,
+        is_last: bool,
+        _is_poll: bool,
     ) -> BlkResult {
-        if this.bandwidth_limit != 0 {
-            if !this.bandwidth_timer.active() {
-                drop(this.bandwidth_timer_handle.lock().take());
-                let arc: Arc<_> = this.into();
-                *this.bandwidth_timer_handle.lock() =
-                    Some(arc.start(Self::BANDWIDTH_TIMER_INTERVAL));
-            }
+        Ok(Self::queue_rq_internal(hw_data, this, rq, is_last)?)
+    }
 
-            if this
-                .bandwidth_bytes
-                .fetch_add(u64::from(rq.bytes()), ordering::Relaxed)
-                + u64::from(rq.bytes())
-                > this.bandwidth_limit
+    fn queue_rqs(
+        hw_data: Pin<&SpinLock<HwQueueContext>>,
+        this: ArcBorrow<'_, Self>,
+        requests: &mut RequestList<Self>,
+    ) {
+        let mut requeue = RequestList::new();
+        while let Some(request) = requests.pop() {
+            if let Err(QueueRequestError { request }) =
+                Self::queue_rq_internal(hw_data, this, request, false)
             {
-                rq.queue().stop_hw_queues();
-                if this.bandwidth_bytes.load(ordering::Relaxed) <= this.bandwidth_limit {
-                    rq.queue().start_stopped_hw_queues_async();
-                }
-
-                return Err(kernel::block::error::code::BLK_STS_DEV_RESOURCE);
+                requeue.push_tail(request);
             }
         }
 
-        let mut rq = rq.start();
-
-        if rq.command() == mq::Command::Flush {
-            if this.memory_backed {
-                this.storage.flush(&hw_data)?;
-            }
-            this.complete_request(rq);
-
-            return Ok(());
-        }
-
-        #[cfg(CONFIG_BLK_DEV_ZONED)]
-        if this.zoned.enabled {
-            this.handle_zoned_command(&hw_data, &mut rq)?;
-        } else {
-            this.handle_regular_command(&hw_data, &mut rq)?;
-        }
-
-        #[cfg(not(CONFIG_BLK_DEV_ZONED))]
-        this.handle_regular_command(&hw_data, &mut rq)?;
-
-        if is_poll {
-            // NOTE: We lack the ability to insert `Owned<Request>` into a
-            // `kernel::list::List`, so we use a `RingBuffer` instead. The
-            // drawback of this is that we have to allocate the space for the
-            // ring buffer during drive initialization, and we have to hold the
-            // lock protecting the list until we have processed all the requests
-            // in the list. Change to a linked list when the kernel gets this
-            // ability.
-
-            // NOTE: We are processing requests during submit rather than during
-            // poll. This is different from C driver. C driver does processing
-            // during poll.
-
-            hw_data.lock().poll_queue.push_head(rq)?;
-        } else {
-            this.complete_request(rq);
-        }
-        Ok(())
+        drop(core::mem::replace(requests, requeue));
     }
 
     fn commit_rqs(_hw_data: Pin<&SpinLock<HwQueueContext>>, _queue_data: ArcBorrow<'_, Self>) {}
@@ -941,7 +996,6 @@ fn poll(
             let status = rq.data_ref().error.load(ordering::Relaxed);
             rq.data_ref().error.store(0, ordering::Relaxed);
 
-            // TODO: check error handling via status
             if let Err(rq) = batch.add_request(rq, status != 0) {
                 Self::end_request(rq);
             }

-- 
2.51.2


