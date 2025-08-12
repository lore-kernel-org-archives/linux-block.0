Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6272E2F00;
	Tue, 12 Aug 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988357; cv=none; b=gn2SJF1tB+RyDrklSGT3z4RgCYsO8tXVq4vesXRm8Nn94O1xwM+v9jmIpsiPW6YMMvpfaBVQGRkNqBgT8AyZCVl9hOQhsjLLBgeqWQywPFnrAXvVs1e4FnnOEABRsKYG/EfLkapyr3gzk5zHEIftTeXtqpoMX1idJA4n7ZLgTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988357; c=relaxed/simple;
	bh=Y3vina1qhyMgk8nl1C5xu+5Ei5OeBSOUuHwJTqyPFQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kE4voUMfFzfE/gPuBbfUtHcu3pPsa8lkDUkYud5bziVuL4zhfekjitQKoehoMvXH/NKQ8ohr5B4Xe4wKUibw3o2s33N0KqQqNNZ46kk0TE+rv/NcfgEIK8v6fnvjtrYztvIbKarQNLb0j/REIenAQheL0p5K+IqwXyNqT28xrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4B5LTe/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4B5LTe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6163FC4CEF4;
	Tue, 12 Aug 2025 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988357;
	bh=Y3vina1qhyMgk8nl1C5xu+5Ei5OeBSOUuHwJTqyPFQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k4B5LTe/KYuFbmJ+Us8rQokdIyZpgNGr9iHlzUnK7yEGMjm8hLjhBlRpEjvH/IHh0
	 32030t7iLU12tpgLDWFnYP+2XuXgmErZbJbVxkRCLS5cSTFDMA1/E9XxZevFmVoLQZ
	 RiYrr0y10csIlemn5KSb7MNIHekcluZ2ArU1QLE7Bb/FlDjPhTtHOPTtuQyHDeT2po
	 xiS0Qqjd4NHqtABygJh5psuO7DCECdt4ZqnwOk+7sfy9oEFfNm2aMWocoEouoX6eyI
	 vgi2mB7hSJFryXT6C2Pqv61bwhNRG+nbqjiMCTjZqqmkf+tkrOUZQ1wfWC7a/GT3PT
	 Q0BYazNZq7xnQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:33 +0200
Subject: [PATCH v4 15/15] rnull: add soft-irq completion support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-15-ed801dd3ba5c@kernel.org>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
In-Reply-To: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6342; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Y3vina1qhyMgk8nl1C5xu+5Ei5OeBSOUuHwJTqyPFQU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8p3KOzLO9xTSZ1fel1sUh05sdwYtsqovB60
 dQt9ItidxOJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/KQAKCRDhuBo+eShj
 d3AED/9vxUI0kMQwOYpfQIRuxeIoyYi+yoNMALeEuFXYdOixW7mHdvNfGqnN19QgnDuprb2IioA
 UgZqQvMt+6mLsakQjUZvL/rGDO4D7KSmis07n5FBvQd2s965L0K9BxQXZ97yyIDgbH7Mz5H4fI4
 dcugL/uHdarTp4VkehMoD1luZMzpPIons1lEBbm69mtIoPLZTCUxU2d4CvaI/CHqQ+jTvRLCJSI
 C/cxNGHsJEdDcJ25baHJoBxwQtC6Stv9DCMUBxRfEWsMgPr0j01itPpdGK9Z2h/DVHT9h3g0kuE
 HHFLwT43uT2MWrlH/UIkyqDrFGNSu91kUGYyYDigAc2qosIR/NnisVY2ENmA2LAe/zPbItSfEYp
 4ASpbwO+cow0JGc4+mdVYXmW0IVXPEg4gMdV+d+w23Z+kJIk/2sC/yCGXbfAfIp0zonYoa9Gike
 WxRFA4NSWD9kDFARYtoczSfmSKalp7j4SPJ6I0S8WeR03Uf2XMeJRnCb0tL/sZaHHfb8uWmCW3K
 GmdZy8OsVCVmYkYmZcctfc+oeg4QG+nGpdnX1iG028mKSNaJUXcNSi4ncGI+g6fpFYzfmf2fvIS
 0DDmU2DG5qRL4fGCcSGdhF0h27rVpMitQFqk/oMSFW7VQ0AFAO4n2NIjKhGisRPh1SC9Xpi4CFK
 twyiBQ3+3ijN9VQ==
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
index 8d469c046a39..c4f6131eb9da 100644
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
 
@@ -128,6 +159,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 guard.block_size,
                 guard.rotational,
                 guard.capacity_mib,
+                guard.irq_mode,
             )?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -216,3 +248,26 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
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


