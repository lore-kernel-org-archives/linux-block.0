Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86912BEC28;
	Mon, 16 Jun 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080371; cv=none; b=Gq3bsbkiSiuH/3qxU4OnjsZd/a58CfC+xNR9KuZLd3zY6g9gKQTrZEi7FYIRJqlJUKgSwcborR3yjLfJHR24IWubbXqJKofeiIwH31Ao3Dzr35fdqfujaO6rIDdb79gy1GXDp907ZRItFT4Q5XJCSl60EzE1Z3WS7pZ46vxpXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080371; c=relaxed/simple;
	bh=dTgPoZkqeSzmhbD3zTW4tZnvROkf83BsbNxNte8KtQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsXGzvDZ3YvTRkG7bZchluK34G9jUFJGV8DvFItYL2AsGIEuBjlpDv+3IPl7yd2RkM9jVCewAHkNfSlPtp5Oe062rP6RFCA539N228UaLUXOsm8Jd+AvM7bX8x6zVry4/knAAwUUBV6KVI7X1ai4Bhe1uzbg4/nKL1E7Kqi3MC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzKNAZC1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzKNAZC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CCBC4CEED;
	Mon, 16 Jun 2025 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750080371;
	bh=dTgPoZkqeSzmhbD3zTW4tZnvROkf83BsbNxNte8KtQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dzKNAZC1WUu7nMBXuaTAdUXCJbgiueXDJxcSE8So0CStqYmwkZHIm1+q2PT/d42ti
	 oTj2ApTOrJoCM07/22V5gm6CCPtux2jwf/C1vdsBn7bSm9j++NmUhGfyyfU/BzkRLB
	 FlrFkawngZxP3eCWT/JhNd+OB6GkWSUuIWZ0W3XCtJl4rk3QhDtLSy14BQZEWzd2q0
	 uZObPOCO05PTwjMKa9SMjIoIqh2Kz3lysJVuUTLfTSQfLXGJ6FQ9jhmZY6P/uDE5lP
	 LI4uSg/3+fyjEsg20W+HdSkD5y5x42+XQcMp5zgxAlLwy230cyaBARMS4xQTEfVR4Q
	 eN3oi8KFDSSQg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Jun 2025 15:23:59 +0200
Subject: [PATCH 9/9] rnull: add soft-irq completion support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rnull-up-v6-16-v1-9-a4168b8e76b2@kernel.org>
References: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
In-Reply-To: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6402; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=dTgPoZkqeSzmhbD3zTW4tZnvROkf83BsbNxNte8KtQY=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoUBsSCoREy8jtImQsfJflLYzF1UigDvdHuVQvc
 OO+1YxFgHOJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaFAbEgAKCRDhuBo+eShj
 d553D/9VZbWPqk35VqeRAhcq89xfE5xu3K9b9AjTrVoNE1fBO9oBHdbAh+Cb8PdIoNxuWvKfrrN
 gkDxguSh+v8JnMpAvY6vxNRYrgEA6hrbLVOszYfmm8D4jl5OXcP4RzD1IVOicMFklmvljcEXUb/
 MHdNviq87DdtIVe4opK/5+Q6NGSkv4duWGl/Uw/GeUmEv4koc/h7EIpmyvALz/z/n0oQbZz7khh
 zbcM5dhjxFFCwC/LrhxrKia7B7SH/+acrD1ivg1405jYQ0WQJXTN788uPbK/cuCODkCqkkEC4FE
 sRMtK4XnuZ6Z6QW5RFmf94hfRZ+qK5QXxjrZEeAjmLEhj8MUcQxLIy17pY4ghH32EW2CLbdMbKu
 kESQ5KNEC66RVLlYkKty3XBovTunX9vm8a1Qbs8ioFp6wczo2zpjkS/1tHJ0W/uM0B6xVW6bdfv
 m5xiokinovACYIBi2nKuxenfOn8pBzr/TOcZvNPy+rL/WY9EH2tjTlRLGGKlcWkNZ2pLo5IM9Du
 WSfio26g0EdhgoYxsauQOZE3YYpe+XAw6qTFfpJdw3R1Lpchghwbdjm8dwsQzrGUBb3LxOg32NH
 5Cx+OzEzKubcn752kAUnXIYgX/EyEIiTmJDixb2OZIreRVCZlFgi2upAxx/0Ffvq/9bv9KtBMJz
 P8nBprzZG9+DD9A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

rnull currently only supports direct completion. Add option for completing
requests across CPU nodes via soft IRQ or IPMI.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 61 +++++++++++++++++++++++++++++++++++++++--
 drivers/block/rnull/rnull.rs    | 32 +++++++++++++--------
 2 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 315e04fbf14f..22a7ec26cb36 100644
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
         let mut writer = kernel::str::BufferWriter::new(page)?;
-        writer.write_str("blocksize,size,rotational\n")?;
+        writer.write_str("blocksize,size,rotational,irqmode\n")?;
         Ok(writer.pos())
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
+        let mut writer = kernel::str::BufferWriter::new(page)?;
+        writer.write_fmt(fmt!("{}\n", this.data.lock().irq_mode))?;
+        Ok(writer.pos())
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


