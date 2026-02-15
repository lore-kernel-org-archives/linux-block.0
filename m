Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA52DC772;
	Sun, 15 Feb 2026 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198958; cv=none; b=Tz/ptuqrPYenRrv7RpPQfZcX8y3EC70FfJfTP2Ga/Kk8ef+HP3kmk5nyTfaIS0ZUXFh5/6qmMzIPdTOTy5hU7p5NgSUl6ql/mHe8EpNNIHTuNX5G1JdAETv68Sbo88h/mfFLYSYHUPpFYbYyZXyZq/h1s7WML8y+ttdgeIybYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198958; c=relaxed/simple;
	bh=mPaJdnA08bz6YzukufDATJZJlX5Z7yfcsTpWSx7drrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpgTflLnDY+UkInjcqtvlGpevvPoEIeZ1nLhZT2oyjkNZjFFgN+3LWGNZJOnmPsxT0sJ2SC85s39jC9feaowsatmBkZ0fAhNov9hpWO8eWmTItGPr4fMy3BP9JeryQe82xknFZY/4d/uE430vZz+A1AvH3j06NgxbqHV27tYcyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLg4izf1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLg4izf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528A3C4CEF7;
	Sun, 15 Feb 2026 23:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198958;
	bh=mPaJdnA08bz6YzukufDATJZJlX5Z7yfcsTpWSx7drrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uLg4izf1PM8gqhPDfHqZL929CRE2DTJ/KxnrvYokJWM7vmx++wtifuDiKP7IDH+/q
	 15hyyd/bcNJWdAMht6NQ8O5WHgwhmDA1mp2jtL4Vmyj4bL6IvYUnYAtcnPdlIWcByl
	 jkz8KNty6uFOR0qPcf+m7WbDyPeonycK4debT3X+sKdLT3r9yW5jYep4sftXPAkLX2
	 ISpV0T0YhSXNjeTNxm2mBQVGXh3Y5U9CA7pIqz+Qvp72cZZUJH9CIEbzv0csjVaZin
	 bDW6RU2bn/zpJ/0f0Bj2cQya7kaJyOWTWoOO0xB7x1e92pbEjzYGH2yDK9aCiAtPDy
	 nFr65qRtcN8qA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:14 +0100
Subject: [PATCH 27/79] block: rnull: add badblocks_once support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-27-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5676; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=mPaJdnA08bz6YzukufDATJZJlX5Z7yfcsTpWSx7drrU=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg0gpsXFXxzc1lHaiAxCsn05VWspInODyhcx
 +COma0+h1WJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYNAAKCRDhuBo+eShj
 d6NdD/9VzqziYOZORL+w+EyvJ+DjwGX57mT4SohYFt5k0+dyu6GNOpWEPwoiE96dQtqQncyWvEt
 TXtKlLSGDSZ3yfpf0ID75MqiBwnUtOmOtLS4R360hVOfPSs64mvN4lR3M9EcXoH+lgZFxcADFuv
 LSM3jC+mSrMj28AzbquDyrPLLDD+wABbXX67Lf2bVrNUajlK9T+8J0arhxvmY4sqF61cF0vDScq
 VtvnB61d8V02U0oYkIXlpr18oitcK4jHHzr+6R0Vh8WN74GW2fpuvX5P32RnHWVaIWR+qVXM+m9
 OnwVifaDcOOR2QwKTFF/G5KoPn7H9Fp4hpDK9ieBVEioELGh+bep84Nw/VbqIIzLhtePNuNYH5+
 zais2/7lYmLWqa/gtJZBIdq4IiA8sxlmDpurdga6YlezkCf/zSFIpTmuZE7sBCNg2AlQ6NCXtud
 2CeNoEMzunwPewSKt7+W3bvaJvri93/eoFj16eH6AfhBLJoIiT048CTEjBNzYDjFE7QlRcxxMvM
 EtLAZvsvI3Pd+0i1zzB6WuQkVsAupbWzVf5k+gcbWy1pPAWaBeK/mSzAPKMYq+IS+g/C40POev6
 j/y+QHdq2/G3Pfnqjis+7XJglP1xf4eBE6wUJesr/Jd3tB4VA5fklhxUZVq210VUyUTKSJXPxEN
 1Vz7GfFZyKM7Kew==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for the badblocks_once feature, which automatically clears
bad blocks after they are encountered during I/O operations. This
matches the functionality in the C null_blk driver.

When badblocks_once is enabled:
- Bad blocks are checked during I/O requests as usual
- If a bad block is encountered, the I/O is marked as failed
- The bad block range is immediately cleared from the bad blocks table
- Subsequent I/O to the same sectors will succeed

This feature is useful for testing scenarios where bad blocks are
transient or where devices can recover from bad sectors after a single
access attempt.

The feature is configurable via the configfs badblocks_once attribute
and disabled by default, maintaining compatibility with existing
behavior.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 31 +++++++++++++++++++++++++++++++
 drivers/block/rnull/rnull.rs    | 21 +++++++++++++++------
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 61a76addf468b..a39691b39e374 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -103,6 +103,7 @@ fn make_group(
                 discard: 10,
                 no_sched:11,
                 badblocks: 12,
+                badblocks_once: 13,
             ],
         };
 
@@ -126,6 +127,7 @@ fn make_group(
                     discard: false,
                     no_sched: false,
                     bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
+                    bad_blocks_once: false,
                 }),
             }),
             core::iter::empty(),
@@ -186,6 +188,7 @@ struct DeviceConfigInner {
     discard: bool,
     no_sched: bool,
     bad_blocks: Arc<BadBlocks>,
+    bad_blocks_once: bool,
 }
 
 #[vtable]
@@ -222,6 +225,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 discard: guard.discard,
                 no_sched: guard.no_sched,
                 bad_blocks: guard.bad_blocks.clone(),
+                bad_blocks_once: guard.bad_blocks_once,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -422,3 +426,30 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     }
 }
+
+#[vtable]
+impl configfs::AttributeOperations<13> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::Formatter::new(page);
+
+        if this.data.lock().bad_blocks_once {
+            writer.write_str("1\n")?;
+        } else {
+            writer.write_str("0\n")?;
+        }
+
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        if this.data.lock().powered {
+            return Err(EBUSY);
+        }
+
+        this.data.lock().bad_blocks_once = kstrtobool_bytes(page)?;
+
+        Ok(())
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 861392c5b5841..0f569c5b65f77 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -161,6 +161,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     discard: *module_parameters::discard.value() != 0,
                     no_sched: *module_parameters::no_sched.value() != 0,
                     bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
+                    bad_blocks_once: false,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -188,6 +189,7 @@ struct NullBlkOptions<'a> {
     discard: bool,
     no_sched: bool,
     bad_blocks: Arc<BadBlocks>,
+    bad_blocks_once: bool,
 }
 struct NullBlkDevice;
 
@@ -206,6 +208,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
             discard,
             no_sched,
             bad_blocks,
+            bad_blocks_once,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -235,6 +238,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<GenDisk<Self>> {
                 memory_backed,
                 block_size: block_size.into(),
                 bad_blocks,
+                bad_blocks_once,
             }),
             GFP_KERNEL,
         )?;
@@ -393,6 +397,7 @@ struct QueueData {
     memory_backed: bool,
     block_size: u64,
     bad_blocks: Arc<BadBlocks>,
+    bad_blocks_once: bool,
 }
 
 #[pin_data]
@@ -442,12 +447,16 @@ fn queue_rq(
         if queue_data.bad_blocks.enabled() {
             let start = rq.sector();
             let end = start + u64::from(rq.sectors());
-            if !matches!(
-                queue_data.bad_blocks.check(start..end),
-                badblocks::BlockStatus::None
-            ) {
-                rq.data_ref().error.store(1, ordering::Relaxed);
-            }
+            match queue_data.bad_blocks.check(start..end) {
+                badblocks::BlockStatus::None => {}
+                badblocks::BlockStatus::Acknowledged(range)
+                | badblocks::BlockStatus::Unacknowledged(range) => {
+                    rq.data_ref().error.store(1, ordering::Relaxed);
+                    if queue_data.bad_blocks_once {
+                        queue_data.bad_blocks.set_good(range)?;
+                    }
+                }
+            };
         }
 
         // TODO: Skip IO if bad block.

-- 
2.51.2


