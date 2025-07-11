Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C642E9EBF;
	Fri, 11 Jul 2025 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234258; cv=none; b=uFdXPqJxTPmp6KMSgembinvBOUkXS9iYT+Qp7e+H9If4E3YEnRHvklvc4RF2QZAHna8hGsA1paLawa/uzq/7mgJ2ayzppAk+MpPDLdPZNMCyI08WcyMqyTxSkKRqpT4KwWW2eXHEgek0T0V2/YUz+HSxjkzvcE+QP1wdXWhmCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234258; c=relaxed/simple;
	bh=dCspNMLPwGgCi5Y2yRvx3utl23R9AkFozzldxElpP+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIatbUUjX0z+hABWt/5CspjnlpoQdvGDzJnlIIxqBvAwqYGeUDtRllJe7f9xaspYWeIaOAT62DLi9sy5jsncVM2wCF4x+c0h+6i+iaJKcPBlRsmMZH2bqG7aZduIGeHRgrihZY5VF5BNgMoLwXRoOOOLqkYGM46DFMLqr5uSOxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtU4tTZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtU4tTZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255E1C4CEED;
	Fri, 11 Jul 2025 11:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234257;
	bh=dCspNMLPwGgCi5Y2yRvx3utl23R9AkFozzldxElpP+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FtU4tTZQZ49iRTOJw6oEdBBQjILjkMdmt3cm1gTsaTI8rzOE4mbp2UsuoMc4kxpDW
	 jYAn4Ftvja/Za+yf2a/Pq3nrAHnaFkqi94N/gOkR0lIj3MDZAyjA8PSmFD/omKO+vx
	 jhnTAdRymK+Mw05X0vEVw/3WLVKWsYhsPSjZS2el+0ndus/4fqtfDcGZQzBj/5iT4h
	 O7CAZCIhdr7PKJEXXQo/Eskj2qSynAXISx0Xgzj0DyhKrdvEnyzxBsexsonMBD5eRq
	 5HjlWA24vsvbuaZAJLMIWbQ/TfpCywbCvHb6f1W7gI6JZKxhBAGafNd2vtFxHLYIzl
	 DMT4Yse40RgTg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:17 +0200
Subject: [PATCH v3 16/16] rnull: add soft-irq completion support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-16-3a262b4e2921@kernel.org>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
In-Reply-To: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6413; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=dCspNMLPwGgCi5Y2yRvx3utl23R9AkFozzldxElpP+4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjYZ8B6U4335YMpCCgIcK016VDnpRFmdpT3X
 uX49mJpD/iJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD42AAKCRDhuBo+eShj
 d1LvEACY7AU7V2ksm5sArjmFRpzTEsq9CrgiYgZRYVZJI7a4CiDypBQhpZxhKMWb1uvpjeDNB74
 iYXqHWhRbu5pfPjhrzxGPWCBAEpec8+LTtqHZ0XgnhztvsSLcD9iSXL6tvGEQDWnwhK2svhG0Wy
 zr1LDbtZ2nbShMUeKrTzgx4bTXdalkXzeb171XN/3WewZf1KiIUIm/iH9hDWUtoqgDSz/uoX7Vp
 9hytxfXq/+/kfKsvZqzlOyTALo+0jEwOej5uUdHC44CskZEtuj5JvdEx3/kGva5B/s25u9kQNIL
 oOfNAevwuIlUjweGeR4EfQw8pcqzfcyE2PWmeXmzr4OdQMdUgeZDGA1nfmTwXfseuFkwkTCKVNA
 7FJRLWqxgNTxc0zvi4XxZiwO2lDSNZJtAsIXA0d8h4XFzRp2qNzBLI2TrG6A4F8e+tUzpu6nor0
 qUJvfAA9a5gwPZNCkR1PfnglbmD6aqQxO7ylR3cBtC+cWieejHktZHPv5na5UqEFYSk81Wc782U
 zRl+TV52tKgkf+QLpEBe351HM3s7bRR8hZQA1kASbxuOou6zriGP9aNTv5ln5+1Udz5AvS8CT/I
 1kkpAC94LaGn8J6wqjPNByIzXZjqKQ5RuSnkRB1/ck8YBEa/UWsubIgkJdwdmkeVEB2Sw72X7Q6
 lvBEKpBUfojYAEw==
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
index 6c0e3bbb36ec..3ae84dfc8d62 100644
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
+        let value = text
+            .parse::<u8>()
+            .map_err(|_| kernel::error::code::EINVAL)?;
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


