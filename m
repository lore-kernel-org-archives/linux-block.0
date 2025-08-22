Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF93093A6;
	Fri, 22 Aug 2025 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864979; cv=none; b=NBQ4EQq7nRHI0dwLSZJuiJwp4MtCQteHW3hTlM56vf4sIl/f2PJqAAGqExQRzvtMoZyWO+/TJloc5x5dennQZhE4yvtqPgJv71QPAutjtLozF9hxYh2HvQS815M8OV2GGIP1BSy8a/eA6JBYhK9ysdhNGnFy5tRxCl3gkNRkmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864979; c=relaxed/simple;
	bh=OzYLZcoR2X2ar16/GYPn46bn5FFs0TT9hSw7MAwyKy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcn1kFuXOIZcIj4ked8+P/Nj3G57MhA2WkaD4bYCZ7up8hHCcAxNJpWzfD9HFsMjlO0O5f8lAquD+aiYEVwmWwI/9KzQk/B3+ZtynLc0HaNnOk+6NCTPok9l1Inwp1LyinSIkas/aWPS8ZAFWPQG6cm+zhGIQ2JMyQtR7FaxMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po+xr1kJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po+xr1kJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C51C4CEED;
	Fri, 22 Aug 2025 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864978;
	bh=OzYLZcoR2X2ar16/GYPn46bn5FFs0TT9hSw7MAwyKy0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Po+xr1kJaQN1T2m1C8jqLNFgZsBbLa+lSQdi84iOJxr7Mr1W/8kPLLGK9OqwUoX4v
	 UeQCeTxa+29nq6ApUVS6iCrRGxH0W4OjHIjpqx1iIjhOuzyxx8ZiFvm8uQaLHPq7nA
	 FL+o9pJH6xMZuj4Vg18PXH7YYVt+S6W6l/3tEv6DLVYcmMVdLhaWlxMTPZRcut/h8w
	 qXKxHmAIMArPKuEQpFfKr2Q8Lh/99Rwweoe/Ut7KmT/pJsJvhtWmOFd+4VTCAx3pjy
	 YSl3vW2+KA5pdvY9ys7gXWj3piyg7rqSGsie2I4soxkUC0xD/AfVqj/YZF3BYZDeP4
	 2zZObObkvDKKw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:54 +0200
Subject: [PATCH v6 18/18] rnull: add soft-irq completion support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-18-ec65006e2f07@kernel.org>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
In-Reply-To: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6372; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=OzYLZcoR2X2ar16/GYPn46bn5FFs0TT9hSw7MAwyKy0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF9CEw3x/wP6LFyggIIgSviVsPb85GCgiEaau
 Mt5L6d3SSSJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfQgAKCRDhuBo+eShj
 d/aEEACrZFNVeRnnwzbNU9bsVXC6SOQ9PeQzgDNcR5APm1K90vavLZtiVvFIYQMb1sIyREVkhDL
 nz0Cadgcb6ipuj1T+SF7BoXy6vAr8LKEjtqBgqguFErS2CmlqMg4/tirtPDjd7HLLS2CagQkyVv
 YAum7ai/cb2FRO+eN+Ps75/Yx7W15kLpUSmK1d7QCdxcrtmSkqCHYHN00JTVg5GV7IqYET8pGLM
 AmETYYUVuYb8d77ywUd7m4kx8bgO1WapFUfQ7UK3Iw7ioUNYP45+CiuQkol1f0QEqXWKePknGsa
 PhmTIvYm2nDYbJmC8ECNW+Fjn45WwWHj1FbIvuR+qIpnumvnwjZTmOmmrfY1lVj8uahi/57oJci
 uGscKuVGXLSJvT+neKvDf34vaiu9dB6Gqidgx14LCZsyfzhwEmY538/LpyeQek+7tmToC6Lq75J
 8cONxUfT0mlMuJqxLuHzOl4JWg2qgWwZUSqMu6gwKLO5fAjiyiMbTvoF3BURdA27FwSea7LPqu0
 6FKKC4ZRnuLEy4b0JAWDNbAhRA5/bSBzbZlZpTKK8PPhPG7xvC1a0F3gXlxGti2Zl8SWd3O+HNt
 bxykHH8so8hRAiV2J8gx5lcA9ZPQdXoV3SjoR0/nWzw5mFqS7CxrMS2RZvZ8BRszFy/8ekcW+V4
 cvuKxOCotTtQ/pQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

rnull currently only supports direct completion. Add option for completing
requests across CPU nodes via soft IRQ or IPI.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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


