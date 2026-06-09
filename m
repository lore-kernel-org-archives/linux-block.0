Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4184D90B3;
	Tue,  9 Jun 2026 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032489; cv=none; b=teZsNjuxveyEkto4GOeKqltqd7k6qGR4dpUBv1SmA0j6ydsjmDXACdk1JV+xVenn2Ask9iDSKBZPTMuQQPeNIYKr7ZOw37JHV74n0tO2F78OZRrlhuRrBcqkX5PTMadVi+n9obiKIqOlsYCNHxl4/FwhQoz6A8CtsZQqROYA9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032489; c=relaxed/simple;
	bh=UpX4gG7L/JrWoAycLPQmU4GCqRdexz34zVS4aoqb37s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POBtf4vEFQxhbebR1uXx9ZnvEFiJ+O8M7Imxq6FHW5CG3S4NIR6rmsn/1GKmJnzF3njLEnBZ0yuNP7rz9qkIh0Q4SvqSHQ1Et5CXF7XZdOikwZEw1x+LQiwgY16O1E0P7N9sw3XbCnZWH48DIFp8Zo4OVkRoTUtmRvVYHQR6WkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWyNwyB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWyNwyB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514EE1F00898;
	Tue,  9 Jun 2026 19:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032488;
	bh=RYYbnA7Q4dh7igQ57Y011k9mdRZ1hokxHpxllxzwi44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bWyNwyB6adFUkYFJfv842UmUDVq0mrAXsfUn0bPtMclR/u/umgM7MP+B06igld1bs
	 A8aF5kdlvfIVyuifXdsLkQJ5BlWOp0vvmZp+qAXiSEB4tku4WBWdZrTBKKX1d2V4tB
	 uePjAyngdh3WYxTybFWC9GYOOtOR9BhqiccMF4nQD44JnDrMHbVmJzWsU2TWuoZAPL
	 JJHlWih9Lk6CLwvEtBCb+yU1e6thapVD3IXtcq5sJjNUJOmnodZy72Wuth/G1ChhtY
	 WKL5i0PuRHvPbk3tsU08jIdiM5ftr0A4R59YU+sFsWb5nFqEnte6gSU10Rs7Q8tNDR
	 5aPXC7YSFa3aw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:38 +0200
Subject: [PATCH v2 59/83] block: rnull: add REQ_OP_FLUSH support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-59-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5324; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=UpX4gG7L/JrWoAycLPQmU4GCqRdexz34zVS4aoqb37s=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTqZ+E1LBttgu8oVGQJ213mTDB9ii02KysEx
 sxYZnUwv0yJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk6gAKCRD6UCkIqsW9
 0FqcEACHRLYMIzbzsj377pL0AVUKQNA3v/IIbHjqKDbwp9jFhJpcFsShNwdi6+Hjxi08g+CN5NU
 8zyMZmvY68JQTlN3j1tJyIWbb+YLnV7yEhnF+6Kciv0dToFZShpYI1xT0Hbv5CajqybY3yWWEyV
 Ev4DvIXdeyD3Gkx5ecpI8hem4cqX4aCGEtLMAR4XqPDhNWGAs5t3eFl3WKvFUlOCqApIlo1pRlb
 FQAhufO6qJ3b7UEvOgNfUa46TxXVOqImPa6Q9yMwa8F2OsaH0W5g2Xzm/9ilLUgw1abLPLYVwwN
 CMTPDvwL2zUjg9Ut27Rfri6ImqCQnDJzciTuO9e5JjO6PLTORMJvTwJ0Ni5sH40NaxDV4Pkisqx
 Fb7uBy9CE5KniRLf/r3cNgsLFhe+/bf2P+/tHJp6ocaX7itDUgrNKlbxlI7qO0H0f6a5VRsXcy2
 azZCK/Wit2MRrSFWhft9Gpcw/9o/Yunh9KSHEy2di6neFyT6gIQbJO6XXCHtwuHuQw7qi80Ujo2
 Z87t/RqnNrQOd76aHnJ6tes3nJPkgz+kSbKflkg4Rh+zhRlFdI9LRYCczPHhn9u70PmLBjsHezE
 iVfFX5lp/AjhEXY6fL/EBW0YXEkX3pNYRmv0gua/hty2NwyQOaBXqPfzpOmGDH0HIjLPgd99Eyk
 9hyJetaPpyfZ38A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for handling flush requests in rnull. When memory backing
and write cache are enabled, flush requests trigger a cache flush
operation that writes all dirty cache pages to the backing store.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/disk_storage.rs | 45 +++++++++++++++++++++++++++++++------
 drivers/block/rnull/rnull.rs        | 31 +++++++++++++++++--------
 2 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/drivers/block/rnull/disk_storage.rs b/drivers/block/rnull/disk_storage.rs
index 82de1f656f68..7667830bd616 100644
--- a/drivers/block/rnull/disk_storage.rs
+++ b/drivers/block/rnull/disk_storage.rs
@@ -85,6 +85,13 @@ pub(crate) fn discard(
             remaining_bytes -= processed;
         }
     }
+
+    pub(crate) fn flush(&self, hw_data: &Pin<&SpinLock<HwQueueContext>>) -> Result {
+        let mut tree_guard = self.lock();
+        let mut hw_data_guard = hw_data.lock();
+        let mut access = self.access(&mut tree_guard, &mut hw_data_guard, None);
+        access.flush()
+    }
 }
 
 pub(crate) struct DiskStorageAccess<'a, 'b, 'c> {
@@ -120,18 +127,32 @@ fn to_sector(index: usize) -> u64 {
         (index << block::PAGE_SECTORS_SHIFT) as u64
     }
 
+    fn extract_cache_page(&mut self) -> Result<Option<KBox<NullBlockPage>>> {
+        Self::extract_cache_page_inner(
+            &mut self.cache_guard,
+            &mut self.disk_guard,
+            self.disk_storage,
+            self.hw_data_guard,
+            self.sheaf.as_mut(),
+        )
+    }
+
     fn extract_cache_page_inner<'g>(
         cache_guard: &mut xarray::Guard<'g, TreeNode>,
         disk_guard: &mut xarray::Guard<'g, TreeNode>,
         disk_storage: &DiskStorage,
         hw_data: &mut HwQueueContext,
         sheaf: Option<&mut XArraySheaf<'_>>,
-    ) -> Result<KBox<NullBlockPage>> {
-        let cache_entry = cache_guard
-            .find_next_entry_circular(
-                disk_storage.next_flush_sector.load(ordering::Relaxed) as usize
-            )
-            .expect("Expected to find a page in the cache");
+    ) -> Result<Option<KBox<NullBlockPage>>> {
+        let cache_entry = cache_guard.find_next_entry_circular(
+            disk_storage.next_flush_sector.load(ordering::Relaxed) as usize,
+        );
+
+        let cache_entry = if let Some(entry) = cache_entry {
+            entry
+        } else {
+            return Ok(None);
+        };
 
         let index = cache_entry.index();
 
@@ -172,7 +193,16 @@ fn extract_cache_page_inner<'g>(
             }
         };
 
-        Ok(page)
+        Ok(Some(page))
+    }
+
+    fn flush(&mut self) -> Result {
+        if self.disk_storage.cache_size > 0 {
+            while let Some(page) = self.extract_cache_page()? {
+                drop(page);
+            }
+        }
+        Ok(())
     }
 
     fn get_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
@@ -197,6 +227,7 @@ fn get_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
                         self.hw_data_guard,
                         self.sheaf.as_mut(),
                     )?
+                    .expect("Expected to find a page in the cache")
                 };
                 let xarray::Entry::Vacant(vacant_entry) = cache_guard.entry(index) else {
                     unreachable!("slot was vacant and we hold the lock")
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index edb4ef53d6ad..0695cbd07f1d 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -719,6 +719,18 @@ fn end_request(rq: Owned<mq::Request<Self>>) {
             _ => rq.end(bindings::BLK_STS_IOERR),
         }
     }
+
+    fn complete_request(&self, rq: Owned<mq::Request<Self>>) {
+        match self.irq_mode {
+            IRQMode::None => Self::end_request(rq),
+            IRQMode::Soft => mq::Request::complete(rq.into()),
+            IRQMode::Timer => {
+                OwnableRefCounted::into_shared(rq)
+                    .start(self.completion_time)
+                    .dismiss();
+            }
+        }
+    }
 }
 
 impl_has_hr_timer! {
@@ -835,6 +847,15 @@ fn queue_rq(
 
         let mut rq = rq.start();
 
+        if rq.command() == mq::Command::Flush {
+            if this.memory_backed {
+                this.storage.flush(&hw_data)?;
+            }
+            this.complete_request(rq);
+
+            return Ok(());
+        }
+
         #[cfg(CONFIG_BLK_DEV_ZONED)]
         if this.zoned.enabled {
             this.handle_zoned_command(&hw_data, &mut rq)?;
@@ -860,15 +881,7 @@ fn queue_rq(
 
             hw_data.lock().poll_queue.push_head(rq)?;
         } else {
-            match this.irq_mode {
-                IRQMode::None => Self::end_request(rq),
-                IRQMode::Soft => mq::Request::complete(rq.into()),
-                IRQMode::Timer => {
-                    OwnableRefCounted::into_shared(rq)
-                        .start(this.completion_time)
-                        .dismiss();
-                }
-            }
+            this.complete_request(rq);
         }
         Ok(())
     }

-- 
2.51.2


