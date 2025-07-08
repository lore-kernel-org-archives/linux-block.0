Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D524395C;
	Tue,  8 Jul 2025 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003947; cv=none; b=Jmw5rFhblU2TPs9mw/8KC1DGc5Z9bGUElQBZz6zdGP3MF9KZC5VO/6azJTR5+hjXyZ3ibMnlmhfIlv6E6O8E3w9NBdAGAS65Te8A9zdmsUBjL+LNRawSjk1V0WprjzN8jHiCnQpecX+S1bSbw8SRYhCfBwvIAJv7h7ZbQn8AnJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003947; c=relaxed/simple;
	bh=KyYAdTjq7vXAKf52Y9J5Q0lQpvupgzRX8cJI0RjW8t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXYxH9bMk2RWKAC2AFLmJpzgWhs1+YiyeGpDiO2hQgtcpAlP5/nfpJXISna+ikcwckprYVcss0Q4qwQG/Euf0LYE/MSDvAEkPeWegTUpgfGi48mvopg2GyK+YQGB7nh74ibyNJT027gQqFRvxjAWvXmjJua8HKad55/LuqNDFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTcQb7zJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTcQb7zJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885D9C4CEED;
	Tue,  8 Jul 2025 19:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003947;
	bh=KyYAdTjq7vXAKf52Y9J5Q0lQpvupgzRX8cJI0RjW8t8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aTcQb7zJQq6bVWrJiUhU/TPXZIgXc3KkoDJHJk/SjbRdgVbvl5ag4M6hc2fQE863d
	 VBii1N38OysurjMNk6yzrf1ohPcXk08Y0I3N6RGcAAFRfVrxvMZH8GqmAgeyUW1U0k
	 A9Ewkmuvfwu5q5rvtcDba3tfKmOAUtpWKolItDSQSIED3TlDL8t1jl4aTOXY9aZRbF
	 GgNsgG17hNHDUcgHkzzfhhOaItTGuvpZ1roamt4W9ePegCthSmNJC4aNGLhc6uDmAR
	 qcJUVsOiGcFA+xyb+OLDWQMcoaPA9mVqzYre3yyWOFmIPJ+xrHz7BGeYK3qxR29x1N
	 MH4jGUKw6TRig==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:45:09 +0200
Subject: [PATCH v2 14/14] rnull: add soft-irq completion support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-14-ab93c0ff429b@kernel.org>
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
In-Reply-To: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6431; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=KyYAdTjq7vXAKf52Y9J5Q0lQpvupgzRX8cJI0RjW8t8=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVNYdc2WyE6oKp1TOjtf2Lt4LycJsFSVCzgr
 /MTspRzJumJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11TQAKCRDhuBo+eShj
 dwJdD/9vJBxCqEBSG2raQocTX4RuWNggHvlY/VLjAP77sFfWpQaXwb/WRpqbEV7P0R6UE6MOAbs
 q8/cwespWiSMdku9dPFIHFoFIfVNcai66yIHI7e0HafOm1ytkfwbVmesLHNtnnwAVI+3GTt6Dj+
 CQNTug0GxMBEhw5FzxUk6y6+Yj8vOp8sIVr7PZfAVQ/7WOGij1ZxNxme8Kb+auX7DT2nWkLfGhg
 prBjpErKK6aNW3Q+KD5bRx/xHsJEGtPaTwxsm2xp91mZ6jmUj1CC+hgQGcl/wXWWf7crJgvt8xA
 g7Jds833m4HNRmey3ByTXsIO65311OS0BQ9EaK/hwGlBc8g8/28kyEGHyUA3RVWp8VY1PU2HcOD
 OowVP+Gx3uSqmm7nitlhPnrGNGzThnaH2JUMojC7yX1PEQgOsymmGe8X+2V2tgHndwefSGuvzv3
 wE9urzlb6ZdE44Wz0+6eJ2qm+dEZzPNFRfePfm1jeR36HbrqP/t1Eo6qcbRjQ8F2ZBFk59oHiKt
 xS7hcc0ugkOlVcPt1FLZ9T+QhZ9QR5qOdgp6k3vp0E+E2I494DrixWFPgHCiXwwqMzF3zmmItz5
 UrQKTNkX00TYiwb9XK5kNa+X145SvH1SW+oh7CfzBO8MvObkhE4vlRidCDz0l+acmMrLd/VR5BE
 pl42itOTm0YJiKw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

rnull currently only supports direct completion. Add option for completing
requests across CPU nodes via soft IRQ or IPI.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 61 +++++++++++++++++++++++++++++++++++++++--
 drivers/block/rnull/rnull.rs    | 32 +++++++++++++--------
 2 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index e7bd2b8f1e905..19bc7278546ca 100644
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
         let mut writer = kernel::str::BorrowFormatter::new(page)?;
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
+            _ => Err(kernel::error::code::EINVAL),
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
 
@@ -126,6 +157,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 guard.block_size,
                 guard.rotational,
                 guard.capacity_mib,
+                guard.irq_mode,
             )?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -218,3 +250,28 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     }
 }
+
+#[vtable]
+impl configfs::AttributeOperations<4> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::BorrowFormatter::new(page)?;
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
+        let value = text
+            .parse::<u8>()
+            .map_err(|_| kernel::error::code::EINVAL)?;
+
+        this.data.lock().irq_mode = IRQMode::try_from(value)?;
+        Ok(())
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 371786be7f476..85b1509a31065 100644
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


