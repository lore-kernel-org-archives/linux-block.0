Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0922EFD87;
	Tue,  2 Sep 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806978; cv=none; b=fdKYFDVeLolKcCA6Y+aWZTU65uiz0lfK2VaZAfq0Qta9S5xl9KEirVbms7DaPQ2B5q5BlHSgXEmSlD7kA4O3wZuTJH07wyOJuUgnkUbC6Rky9yZYDw+7iXX17Jxf38n+Kd6f8RbdCOYIjQTwC1sRTcYEKbzU795G92EOHDTjeTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806978; c=relaxed/simple;
	bh=aP8rjJy/aucU/AdvUODqarq27NqARAu9QR2SBF7RTRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLFvmjhwnHxD001OrQx9Boau8ckrK+20dlslzxsYLGvuRFw7jqqtPQf/V9RzJY+4zx7dGBwnp13XZ9VcFE6lrggYyE/UsMA9L+7VVZNZ3m+K9idSyXW34c87i32n3RYIFie3HlGKUo8B8IBukU/gV1EpuNMxMl5WCx0SP69ctXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5V1zOvK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5V1zOvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFADC4CEED;
	Tue,  2 Sep 2025 09:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806978;
	bh=aP8rjJy/aucU/AdvUODqarq27NqARAu9QR2SBF7RTRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q5V1zOvK66uXPBVXkTZAGq2iioQokxkC4nWSiQJjAQb+TNt6LorkfQja9Du5E4dZh
	 WDZpdhhLzfl7IgBGJO0QP68IWialXEXvv9pxm52ErY7moNUK8jvP911AT/QpbmoxUt
	 cGOmcjQhodpkuSNsxSPzeqj17lEJIueXt3StNigIxRAKBIEhg2zUMsCFIfUJaGn+rx
	 0sifpYLLtwhp9NMKaDqyXXu9xWQDVaHCIpp9gs7accLAjjc8xFmO5IiKAsGpHdKG4y
	 7ktvew5XKqisobTcvVczvI0nRTaPK+1UnCq9wNv3Sht5qcboHo8mwoxRvBttm9yPbG
	 Eehv74/5KqtXQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:55:11 +0200
Subject: [PATCH v7 17/17] rnull: add soft-irq completion support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-17-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6432; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=aP8rjJy/aucU/AdvUODqarq27NqARAu9QR2SBF7RTRs=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr8IjCY/BdHMZ8XJPjj87NQsvEdfa7Mg1jHq7
 bfQXYRKm0yJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa/CAAKCRDhuBo+eShj
 d8kqEACDbS/6X7I8dK6VSVaSFhS2Ylq/gIAKfVNieEzjfUJ5TX1+SGgo8UsqzY9bXWbIuH0Pyip
 8PVho4RQiTAjnyzIuTQIzjqxLThq899ASeTejTVNaJ6+XeU/8QwZ+GeQALzYl6HqNw1Apnsl3wj
 5Psrx8ICZQtS4pyppo7+GYw6l1REJ+Uo/GWDZVrVKsofi+UB/o9crUXnxLvUGaHKyBovxeUVc8q
 SrjMpJKPgICW2zdM0A182JSzwO/FZ2XN1NK5eMUfvLb7tPWhAT4rJ0P4Pm4nvrf9VdXQA5SMnLI
 Z5rU+a7j0CuXQiwn5F/n6q4/wPleqN+NuGPdauRgdbniBMAe/lvnGABThW5lSCxTY3Iw4HGRrbT
 vkkGz14i+UGQ5/t3/t26DMsiyLvnNYD/1OUwi7wRLyPeJYXjfRBjKPxH7jlxQBU3fRgAycOgdY1
 Ew8AztcmGIJUR+TvH07j20Mo5+GSQxUh8R2dwY89vMwh2bBaG3rf0FDZDttlTtJzoNuUuTcBrUz
 Dx8gnmBQ3Tb0hONgiBOoKHSSRu7zKx8ED5e/Pi/ibFv/EWHjeHsy/yplk41XbLq7u8WhglYTl0P
 odUukwtDLyL314zJcQ9HE3RwgGBkMcrc7ZiJ4mDDV07k3tdrhM6UMl35/M2HqePPE0rgCJgHp6Q
 SdLTo0l4pCpiLzQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

rnull currently only supports direct completion. Add option for completing
requests across CPU nodes via soft IRQ or IPI.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 59 +++++++++++++++++++++++++++++++++++++++--
 drivers/block/rnull/rnull.rs    | 32 ++++++++++++++--------
 2 files changed, 78 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 46710a1e1af4..8498e9bae6fd 100644
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
index a19c55717c4f..1ec694d7f1a6 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -4,6 +4,7 @@
 
 mod configfs;
 
+use configfs::IRQMode;
 use kernel::{
     block::{
         self,
@@ -53,35 +54,44 @@ fn new(
         block_size: u32,
         rotational: bool,
         capacity_mib: u64,
+        irq_mode: IRQMode,
     ) -> Result<GenDisk<Self>> {
         let tagset = Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
 
+        let queue_data = Box::new(QueueData { irq_mode }, GFP_KERNEL)?;
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


