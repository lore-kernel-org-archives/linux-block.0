Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0532D23B9;
	Fri, 15 Aug 2025 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243148; cv=none; b=PposFRSR9B6MQNhDvwofYhnlqQ9fmFyifHdcuvXGbsEQ9b2b3QT0m/P05PihUq2/qulFY12ZukVDgLGZp2iRjA7lGMox+r/9UeXrYEmroFA2EhBmboXR6FfyQ11zu12ytY3GCLqhnAEru2sqsKSRhLo6J0P6GMGYYl9J7SJDC5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243148; c=relaxed/simple;
	bh=W+DYHnlyo/3Sa+o2Sc3dmpZfrnUsGYHrKzmjAeLisGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/mF0ydxjdoKpzdr4LzA3jJv5lT5iY4hnEBlLeAkS6BnhuLmxE9ZOc+vWy2Ic+nGKkl7apiQ4ylTvMZ+jZreIpUlEgnEg2ZZeBxN++d/WaFA5aW2vQvJgs5tzcMSvpyhWgHsVHp/biOGQdWLtWgcAr3BPGDzA6H6/DUtSokipmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfRtWcTn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfRtWcTn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E65C4CEEB;
	Fri, 15 Aug 2025 07:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243148;
	bh=W+DYHnlyo/3Sa+o2Sc3dmpZfrnUsGYHrKzmjAeLisGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gfRtWcTn/QBPhQYeLScfmj4H9IcPxCbb6UHkfxkZzL76JRtaIFq3q1mBAVVKhfcqp
	 oRwdwz/f5Lidx2eZU5fyM6e/zY0AUr/vORyTmcDv6VJ7RlH1y7gQ3jr325klLUpJhn
	 6Udbd35KeGqUmo7vfR9NsNW+or+BwXbRCEaCqXIH6FAz1aD8xp/ucFZ/9vv+LFMn6+
	 E4pnH2iHZQSprEJTntEOOXf5PfyLIe71c2u3TWtL3MmX8SacRxj9aXG/9NrOL2+t/B
	 DtNwVh3/vdx7Clghe6s2Zzbh4gde4PA1eI/f1yiTy/BOYGFrAM1FVCjBiHCWRscE3o
	 4C34KymZzx6GQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:53 +0200
Subject: [PATCH v5 18/18] rnull: add soft-irq completion support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-18-581453124c15@kernel.org>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
In-Reply-To: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6342; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=W+DYHnlyo/3Sa+o2Sc3dmpZfrnUsGYHrKzmjAeLisGY=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuJEALxl5Ba/R/LoqX+1GBLRTMKyTcuBulT2l
 tlf/2tWyHCJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iRAAKCRDhuBo+eShj
 d9e5EACODFBQuqVSnYJYQlsUAmfwrzv9+qNhzbBzxLnHSvyjDgKoDxB3uyqJuLciE+8sUw4oS5D
 lR0AvXm1x441hifAZMi6VR7hY0n0CQ68JyMUtQSCJfpqtY9WR1BK4Cuk80kTJ8srbobjivNtfSI
 xVIeQYg6FZSc36/B764Gs4y2+s/Z3f/EF3NjSXdWSg9I/j+A+8hGM7i31V4unJmjrbrwuLx4Fnt
 c39RVgcs67IlhemkwVed+WI83kZXFKD5lrreMPpdPsZs5Kaa9oikfEEGN3e/2IxH9ffMPcEc/hi
 obZ9DtUkWAqXTN8t+rntEazPv841wTcjugmuOheV6Rt8mI9x8pbk76BSfsRs5MMcYZaYnOZw54P
 pZoYPkkAh28C8sJ5YiIh5LI9PkuqlWBg4nUrYSnbeiNuei7sgZt/Ie1LLZlwytBhHkjdQyTH6XK
 PLbmjfe27vyuJFKjuR9LyEGMrpLiMkGSkyENfPUK8JeB/hUhHVFTPauyZFEg+X6aJvBweXpL7z/
 eAhZii5+bAHY+giejiV1MnsWX7PAePA/2LML1GynmSvCZeqfXOFSow0b8+ik6Mz58w0LPE9S8rG
 O8XDLFFHJXGdasNbYvmjxi4woa3ZIj3992P61Jkh5y2rGKe6FLGk0LscXrOqP7UKjPlyibZ9tt8
 ADEiS22QB+gRbKQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

rnull currently only supports direct completion. Add option for completing
requests across CPU nodes via soft IRQ or IPI.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 59 +++++++++++++++++++++++++++++++++++++++--
 drivers/block/rnull/rnull.rs    | 32 ++++++++++++++--------
 2 files changed, 78 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 488fe27f83a2..adc5bf5d2f8c 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use super::{NullBlkDevice, THIS_MODULE};
-use core::fmt::Write;
+use core::fmt::{Display, Write};
 use kernel::{
     block::mq::gen_disk::{GenDisk, GenDiskBuilder},
     c_str,
@@ -36,7 +36,7 @@ impl AttributeOperations<0> for Config {
 
     fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         let mut writer = kernel::str::Formatter::new(page);
-        writer.write_str("blocksize,size,rotational\n")?;
+        writer.write_str("blocksize,size,rotational,irqmode\n")?;
         Ok(writer.bytes_written())
     }
 }
@@ -58,6 +58,7 @@ fn make_group(
                 blocksize: 1,
                 rotational: 2,
                 size: 3,
+                irqmode: 4,
             ],
         };
 
@@ -72,6 +73,7 @@ fn make_group(
                     rotational: false,
                     disk: None,
                     capacity_mib: 4096,
+                    irq_mode: IRQMode::None,
                     name: name.try_into()?,
                 }),
             }),
@@ -79,6 +81,34 @@ fn make_group(
     }
 }
 
+#[derive(Debug, Clone, Copy)]
+pub(crate) enum IRQMode {
+    None,
+    Soft,
+}
+
+impl TryFrom<u8> for IRQMode {
+    type Error = kernel::error::Error;
+
+    fn try_from(value: u8) -> Result<Self> {
+        match value {
+            0 => Ok(Self::None),
+            1 => Ok(Self::Soft),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl Display for IRQMode {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        match self {
+            Self::None => f.write_str("0")?,
+            Self::Soft => f.write_str("1")?,
+        }
+        Ok(())
+    }
+}
+
 #[pin_data]
 pub(crate) struct DeviceConfig {
     #[pin]
@@ -92,6 +122,7 @@ struct DeviceConfigInner {
     block_size: u32,
     rotational: bool,
     capacity_mib: u64,
+    irq_mode: IRQMode,
     disk: Option<GenDisk<NullBlkDevice>>,
 }
 
@@ -121,6 +152,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 guard.block_size,
                 guard.rotational,
                 guard.capacity_mib,
+                guard.irq_mode,
             )?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -205,3 +237,26 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     }
 }
+
+#[vtable]
+impl configfs::AttributeOperations<4> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::Formatter::new(page);
+        writer.write_fmt(fmt!("{}\n", this.data.lock().irq_mode))?;
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        if this.data.lock().powered {
+            return Err(EBUSY);
+        }
+
+        let text = core::str::from_utf8(page)?.trim();
+        let value = text.parse::<u8>().map_err(|_| EINVAL)?;
+
+        this.data.lock().irq_mode = IRQMode::try_from(value)?;
+        Ok(())
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 371786be7f47..85b1509a3106 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -4,6 +4,7 @@
 
 mod configfs;
 
+use configfs::IRQMode;
 use kernel::{
     alloc::flags,
     block::{
@@ -54,35 +55,44 @@ fn new(
         block_size: u32,
         rotational: bool,
         capacity_mib: u64,
+        irq_mode: IRQMode,
     ) -> Result<GenDisk<Self>> {
         let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
 
+        let queue_data = Box::new(QueueData { irq_mode }, flags::GFP_KERNEL)?;
+
         gen_disk::GenDiskBuilder::new()
             .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT))
             .logical_block_size(block_size)?
             .physical_block_size(block_size)?
             .rotational(rotational)
-            .build(fmt!("{}", name.to_str()?), tagset, ())
+            .build(fmt!("{}", name.to_str()?), tagset, queue_data)
     }
 }
 
+struct QueueData {
+    irq_mode: IRQMode,
+}
+
 #[vtable]
 impl Operations for NullBlkDevice {
-    type QueueData = ();
+    type QueueData = KBox<QueueData>;
 
     #[inline(always)]
-    fn queue_rq(_queue_data: (), rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
-        mq::Request::end_ok(rq)
-            .map_err(|_e| kernel::error::code::EIO)
-            // We take no refcounts on the request, so we expect to be able to
-            // end the request. The request reference must be unique at this
-            // point, and so `end_ok` cannot fail.
-            .expect("Fatal error - expected to be able to end request");
-
+    fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
+        match queue_data.irq_mode {
+            IRQMode::None => mq::Request::end_ok(rq)
+                .map_err(|_e| kernel::error::code::EIO)
+                // We take no refcounts on the request, so we expect to be able to
+                // end the request. The request reference must be unique at this
+                // point, and so `end_ok` cannot fail.
+                .expect("Fatal error - expected to be able to end request"),
+            IRQMode::Soft => mq::Request::complete(rq),
+        }
         Ok(())
     }
 
-    fn commit_rqs(_queue_data: ()) {}
+    fn commit_rqs(_queue_data: &QueueData) {}
 
     fn complete(rq: ARef<mq::Request<Self>>) {
         mq::Request::end_ok(rq)

-- 
2.47.2


