Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0A1DF75D;
	Sun, 15 Feb 2026 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198835; cv=none; b=Xn71h359cAsfoTMY4MNtOex/5bfrQ210EsyoRtDfbpiGAzN8yU/f9nwaKz2rFwKZZY5v37is40OQy1Nn1aAtcyo3ANUi/8z0MOp2y8RR5kDS8fakBBO69XFJOxhWG5K9FfZ9n2hf2kSY0Tl3Gpo2OYHE1DmhkbQ2tAtzJjd0Df8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198835; c=relaxed/simple;
	bh=lhLM7VW+elgLHbwAaApu2uDju5ClodzV2lsUXSCKd6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dx+DTKbGHcpRESqwznOpDfs9mZQlx+NzLk1bIOXZRfCuw5fdFRsiNx2aoRf1RFTwIeBSsTUeEub2ERpvqlQ/hlJwaeHg7hmxPKqu8SmkPRCUzZtgLiF+tZWoIBhTMfM+02bGA4aXze9yFdTSkFpeGY7Zx5T57sdUNmBNVTniPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIVtL4lw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIVtL4lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4950AC4CEF7;
	Sun, 15 Feb 2026 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198834;
	bh=lhLM7VW+elgLHbwAaApu2uDju5ClodzV2lsUXSCKd6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EIVtL4lw8JFCfYyLbkOkVEa7JXlNSdcyGo4qOyIIWOqr+nEHnuDiRWmxUe6wzDpdt
	 isgZdMXuUFBbJIUNka6yubc0IlqQeppw0r5J7yihoL0PlRPF3nv1l0ZcM/RjqhXCnQ
	 ZXSayfGGBCotK5nvCVqe7QpRipdTvgbA9iZlPNJlpTWsBUO8LhhVDFR8B1xyV9HWsO
	 degsko85wF5DrlPMznLHzQHKJp7T67C/Lv0943THWRSn45NAVDXxlfNuP9LzNFreQ8
	 +Vy6bec8YMLhqwhZBRcwIELNj+GoqC52kS9fMO8Nyk5zg9MMVo1UX8+DahqmUIXAz5
	 Z1ehugPEPKz6A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:41 +0100
Subject: [PATCH 54/79] block: rnull: add REQ_OP_FLUSH support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-54-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4765; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=lhLM7VW+elgLHbwAaApu2uDju5ClodzV2lsUXSCKd6w=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhM3Jq8YHxrfkqK/oCU6MjwIsMXoUhI4IkTK
 +/jl05X3saJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYTAAKCRDhuBo+eShj
 d8KjD/0QbfTC3g4Lbp6rrVquof9Xlz219bbRgWBbI0ddnxfwoBL0oYG9l+U7pgzMJwxChHNGUsW
 yaXD7XeOVnRfKxNopjmfMpgY8dz4KBRFRPfAI1FOKkjg5Q7pAH68iGn3ytQrqpQ0vOy/qjO8hWX
 SOdpbBoM5SkJQWgmbRC5eW99He2gVmaNawIruI/N7nMh+H/v7+nDHxodwp+6l16XQ8T4h8L8eoH
 IsD89YfFpQavHXTBxUv+bhU5YKdy0HNGW8by7aRCmOhpvqP7ctHLNOLeEe8qCfkdEXg0DV/XDYj
 WqUXjGKZ7ImjxPcNgg6RAYVNerGHKqNus6SnHMgZzSrFspg7SeWJ9M9/BXW5P29HFP+k/lPzTHg
 J1PMbstlAaUcLEtJMqUkGpUCYYFkMgXeThO1GAnKHp5k+RAFZL6l99kAbEYLl0Cyp66FNYfJiN0
 U3CzV14Qz1w1zRUoQKl6uMkCY+A0DIUDKOD7Whm/lR0Zw5xKKxFt+SazbuUIjCjMr4boyqklSy8
 WN1vAeenCReskUvStsX6RSMCQEbP+SyNOphfLq15xvx25z1HfP72OFWohynS+RkoOwdhT/4nnse
 Jb++s4gzj5w8zDYD4uZ486v3p7PLBAoL0/UgxZK2hDpXeRoSMrJzlbvs48ilKYWUSluC5HSjQdz
 VoZHh/6GYoIaaWA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for handling flush requests in rnull. When memory backing
and write cache are enabled, flush requests trigger a cache flush
operation that writes all dirty cache pages to the backing store.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/disk_storage.rs | 36 ++++++++++++++++++++++++++++--------
 drivers/block/rnull/rnull.rs        | 31 ++++++++++++++++++++++---------
 2 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rnull/disk_storage.rs b/drivers/block/rnull/disk_storage.rs
index ce3e83671709a..a613ed5223ba7 100644
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
@@ -118,13 +125,16 @@ fn to_sector(index: usize) -> u64 {
         (index << block::PAGE_SECTORS_SHIFT) as u64
     }
 
-    fn extract_cache_page(&mut self) -> Result<KBox<NullBlockPage>> {
-        let cache_entry = self
-            .cache_guard
-            .find_next_entry_circular(
-                self.disk_storage.next_flush_sector.load(ordering::Relaxed) as usize
-            )
-            .expect("Expected to find a page in the cache");
+    fn extract_cache_page(&mut self) -> Result<Option<KBox<NullBlockPage>>> {
+        let cache_entry = self.cache_guard.find_next_entry_circular(
+            self.disk_storage.next_flush_sector.load(ordering::Relaxed) as usize,
+        );
+
+        let cache_entry = if let Some(entry) = cache_entry {
+            entry
+        } else {
+            return Ok(None);
+        };
 
         let index = cache_entry.index();
 
@@ -168,7 +178,16 @@ fn extract_cache_page(&mut self) -> Result<KBox<NullBlockPage>> {
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
@@ -186,6 +205,7 @@ fn get_cache_page(&mut self, sector: u64) -> Result<&mut NullBlockPage> {
                     .expect("Expected to have a page available")
             } else {
                 self.extract_cache_page()?
+                    .expect("Expected to find a page in the cache")
             };
             Ok(self
                 .cache_guard
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 92e75f15e02c6..4870aa3b7a53e 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -673,6 +673,18 @@ fn end_request(rq: Owned<mq::Request<Self>>) {
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
@@ -789,6 +801,15 @@ fn queue_rq(
 
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
@@ -814,15 +835,7 @@ fn queue_rq(
 
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


