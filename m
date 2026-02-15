Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A432E1EE7;
	Sun, 15 Feb 2026 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199076; cv=none; b=teWRstbyIBPcKrZDR9bzEl9GJFep0QD/eLq095KTRmY1672WAEmXYi5W5P+dE9f8c9NvRHyBKyEcQFW4JRv//FoHoxYKcy5xUOoOD//uxDER8U3/YCenVYRECSUD0gWMTZ/2jPZUnD2l4p/crFXyZ9YIqGPYhEXc9nDHFjy+42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199076; c=relaxed/simple;
	bh=HKPTgIJvjqkHxf4DOaN33MBiBgSvGkO/5CG2qjyHOmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPl1olt1285eaum3EGdY8uobjRZN98E3KUGNPsLjg3rW/2PAuUUVc0RvFyzQ2Yv1K9vWLwbkH96a2aCgHItgdkuUI25rzqckNcDaoqmdzBUghKstGvkuEX70GKYdOnwB3/KgiQihyzA6yd/gZ66mayDUQU6yjreIx5AQMSUJ7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEwbeqMw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEwbeqMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F643C4CEF7;
	Sun, 15 Feb 2026 23:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199076;
	bh=HKPTgIJvjqkHxf4DOaN33MBiBgSvGkO/5CG2qjyHOmI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HEwbeqMwqhChrUCr0eLVICcsS0kFu3re0MSkS9a7rAap1IsrAEKcKkEc0BoVyz8CP
	 tOt96798R0PqBauyBPJ1bFpvWFtWXVFa8qzPcLPZ8Ld+JV1vCQ28v5arFsYib21ZtN
	 13fg4gOjKrWZD0zKjm8kS9atSllQkX549FQ2Fw4lS4rqSCef/rmiJn8Kts9a5j1Ps6
	 M4Bq5zEUiFadeV1YBprYi+RP6zf368p0qbUaE2ke/jQf5uq8U5LtS97eiDQQfhvNkw
	 z2/q4ntwj/WmHNbNz4TpuVQjOoZdtnbtCsebkeeRcCC0poScOEJZlXf5BzgBJAX5vT
	 ag6JVCquNNJHQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:53 +0100
Subject: [PATCH 66/79] block: rnull: support queue_rqs
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-66-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12232;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=HKPTgIJvjqkHxf4DOaN33MBiBgSvGkO/5CG2qjyHOmI=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhXTS1cfVP+RDBqvgSmswBnxZJTKLx89agmK
 q2pgugwP/eJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYVwAKCRDhuBo+eShj
 d/3tD/40WsdJWyyYdlKPzEWrD0jdbY+3W83zTWtXtFvD++vJ73emsdfzJGywBkqivcTP2Mw4srN
 hMaketviLPQhFfp2PZbweUdYsV0U3uoOic9UhqwrAuINKhlv/y7ee9tkIw+wPtN6ZPlfXXdXYF6
 hwyz6bI3yH7xSxPNC02QrQyfE7ObOt92sKVJbQjcxKKl57ZKkStWM/QHJusHuaaT5+dljtbHFMF
 XqSqkNSxbNfh42AS2LRmc7prBMokZCGMUTPgVMejWe8GyXv26jQuFet3FPvwVqr2C31M5cIf4oq
 d8yph8PhGIDKoUFiAKK0D+a3Cah5jxOwITAlUoTehUeN2uVIAiw+Nf6iiyZIfo2dmuSA9TZSQao
 AmcsNsOFYuD6LTzmO7KAPrPdZF81HMrIpUupHYIhx/+gfsWWR041QgdwCix5HjNmOCIGGA63Tty
 bA4l84a1ugbEHBL+dekLmMrWjgrdSp7ZJTnInQ0rAG29XrUijIveoNZcRaOWiJCmtm78+wEWLFk
 +uhDrBtGlBpviMdoKoqBh/eaRkHXSUlOpZ+jcNKFOJMxJfKugcS5lo42sahjPO28E5jsMFZIVd4
 3OCOlMRfahAfl0GN6VPi4Hdc1WtB/j5+dOZnjSE881iJEkvGykDvIzukH8WOd0m4vVbthdP1rSJ
 qu9CVscK+CEFYAA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Implement the `queue_rqs` callback for rnull, allowing the block layer
to submit multiple requests in a single call. This improves performance
by reducing per-request overhead and enabling batch processing.

The implementation processes requests from the list one at a time,
removing successfully processed requests from the list.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/disk_storage.rs |  34 +++----
 drivers/block/rnull/rnull.rs        | 180 +++++++++++++++++++++++-------------
 2 files changed, 132 insertions(+), 82 deletions(-)

diff --git a/drivers/block/rnull/disk_storage.rs b/drivers/block/rnull/disk_storage.rs
index b2b5eaa783cdc..d9f2703957fc0 100644
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
@@ -129,16 +129,10 @@ fn to_sector(index: usize) -> u64 {
         (index << block::PAGE_SECTORS_SHIFT) as u64
     }
 
-    fn extract_cache_page(&mut self) -> Result<Option<KBox<NullBlockPage>>> {
+    fn extract_cache_page(&mut self) -> Option<KBox<NullBlockPage>> {
         let cache_entry = self.cache_guard.find_next_entry_circular(
             self.disk_storage.next_flush_sector.load(ordering::Relaxed) as usize,
-        );
-
-        let cache_entry = if let Some(entry) = cache_entry {
-            entry
-        } else {
-            return Ok(None);
-        };
+        )?;
 
         let index = cache_entry.index();
 
@@ -168,11 +162,14 @@ fn extract_cache_page(&mut self) -> Result<Option<KBox<NullBlockPage>>> {
                     let mut src = cache_entry;
                     let mut offset = 0;
                     for _ in 0..PAGE_SECTORS {
-                        src.page_mut().get_pin_mut().copy_to_page(
-                            disk_entry.page_mut().get_pin_mut(),
-                            offset,
-                            block::SECTOR_SIZE as usize,
-                        )?;
+                        src.page_mut()
+                            .get_pin_mut()
+                            .copy_to_page(
+                                disk_entry.page_mut().get_pin_mut(),
+                                offset,
+                                block::SECTOR_SIZE as usize,
+                            )
+                            .expect("Write to succeed");
                         offset += block::SECTOR_SIZE as usize;
                     }
                     src.remove()
@@ -182,16 +179,15 @@ fn extract_cache_page(&mut self) -> Result<Option<KBox<NullBlockPage>>> {
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
@@ -208,7 +204,7 @@ fn get_or_alloc_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage>
                     .take()
                     .expect("Expected to have a page available")
             } else {
-                self.extract_cache_page()?
+                self.extract_cache_page()
                     .expect("Expected to find a page in the cache")
             };
             Ok(self
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 429819bf042ba..592fbf5790fd2 100644
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
@@ -720,6 +722,104 @@ fn complete_request(&self, rq: Owned<mq::Request<Self>>) {
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
@@ -761,7 +861,7 @@ struct HwQueueContext {
 struct Pdu {
     #[pin]
     timer: HrTimer<Self>,
-    error: Atomic<u32>,
+    error: Atomic<i32>,
 }
 
 impl HrTimerCallback for Pdu {
@@ -802,76 +902,31 @@ fn new_request_data() -> impl PinInit<Self::RequestData> {
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
@@ -888,7 +943,6 @@ fn poll(
             let status = rq.data_ref().error.load(ordering::Relaxed);
             rq.data_ref().error.store(0, ordering::Relaxed);
 
-            // TODO: check error handling via status
             if let Err(rq) = batch.add_request(rq, status != 0) {
                 Self::end_request(rq);
             }

-- 
2.51.2


