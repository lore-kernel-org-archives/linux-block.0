Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B12D0C71;
	Fri, 15 Aug 2025 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243125; cv=none; b=AjVp7l7WsDZIYsEkXZ87LsjcwgW8pAlx7tsZAl+e2n+NkiE7kMYnQ2rDdaux92IvOwvM0bDe+T/t+H+DBq6KMv1yE3Rj9cLkg6sRsrCNZ7EwpjK6spWvzNHIsa4HoOrEe7XSnqOVWAzR1hIaBmgqzUzUg4JtdoJFk+umhz2BHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243125; c=relaxed/simple;
	bh=OGLyatEXOCPSpOutMp50W+e7q9fc8iP/qLDZApYU/wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubrmKg4ENkx/ffOtw95mYvfFGWovHxGBrbMf7IacPVTku8awfrdkTIc5zxwpJHcpHVvn2Dlv1msvc2R3OI+0SK3vqQ3DcmB1U31BknwQFEkXTTpcByi6NRVptGy3cX0Apx7qwcseqqeO+eJ3PIgdWDiSeHyBxq/WYlOd/fcPYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZT/Xr9l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZT/Xr9l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49D4C4CEEB;
	Fri, 15 Aug 2025 07:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243124;
	bh=OGLyatEXOCPSpOutMp50W+e7q9fc8iP/qLDZApYU/wQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pZT/Xr9lcJS+kpOQclaEAhxmM2ImqA+V4ArodtmUa/v5y+kMsWWzfvqKRWXQq8i3f
	 w5Jvc/5AkZN9lgD/9vOuiZAhiyphLaS3op87YP3SsHhdyoG4IoY+JiVUPxzlX02Coi
	 TvCPdU162x69JFf/slKq4KekW0x6/zefNJU+/QsasHnNvJBmHNnPkPlktRaJUiyFk7
	 S8Xs9YFGj12HQeDIJz3XzsQLECG6sg4vjD2nbGet9Z/6Ph4AuAMA3zlYLCiHm9jtth
	 Py1Dne3CaYckwK4SWAQrheCMKznUpuGf+N2nPSZh2b1SmUfaLs84en0Ownm8ZdjA1h
	 KmdLMl5Gdx1SQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:49 +0200
Subject: [PATCH v5 14/18] rnull: enable configuration via `configfs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-14-581453124c15@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10499;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=OGLyatEXOCPSpOutMp50W+e7q9fc8iP/qLDZApYU/wQ=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuJAX11XWdNUyN5BPEJbFLt5McVOB75cxdKUk
 Vp67bFyrQ6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iQAAKCRDhuBo+eShj
 d1zbEADBbi/U6j0KTrNt4jJdVzPUkpkwkak+GpR2QiFfCFdc8EcfivgavZPOKX63tO+nI0zVIU4
 WVjH1w7iStl/71yWyPfgqu5pAJFHv1oaeWYHijikp4gsaPBKK8bxx6lzeBtoF+PF7dNChW/p+nx
 H7LALFDLXrQW0BjrMvA7QHmH6z5/Fcu+qlLgSLAkCKDtZSKX84yK/RtTwenNq/2X5FwNXXVxWXQ
 V4KppvOZ1jmshOQOprCToz8tSq4FuZYIDbqQfM950UT9knNlBemOd0mC7UqdnODvAy2keNU2QT7
 CBZRKCeUSQDLwGLzQSWMxUlE7v4tQu2LNOGuVLOpGd00mr6KnsYo4ufjtQOmLz4YjNUbyjLx2/m
 /g4FREoZJYewi32d1suLBvsRiGjgoXiZLkbTpS1rt/rJyMq4sI9aDvjrjVrSAsYknNSKQ8uJMrx
 zLUz0i2e3UTFlulYCKqnIeXCQyPr4bZhpuAbB4lnlIcJCdFY3QDSC/R6SWmRRwhJW5u6WFzKlQz
 xXWffseRQZKnvE9j8nuoL8+0OkgO+jXt40e07J4XbDwcLwBWoMBwXxpFOqP7pZiUpFGxlRYNsLK
 srVt8VXylN0X65AELY1+rfXt6lqEv7lv2Io9kBY7pmOJFdeL6Vk0oauYSrDKAVi0ogJxzCVkU2p
 /nDQMhDoU5ZU77w==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow rust null block devices to be configured and instantiated via
`configfs`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/Kconfig      |   2 +-
 drivers/block/rnull/configfs.rs  | 207 +++++++++++++++++++++++++++++++++++++++
 drivers/block/rnull/rnull.rs     |  58 ++++++-----
 rust/kernel/block/mq/gen_disk.rs |   2 +-
 4 files changed, 240 insertions(+), 29 deletions(-)

diff --git a/drivers/block/rnull/Kconfig b/drivers/block/rnull/Kconfig
index 6dc5aff96bf4..7bc5b376c128 100644
--- a/drivers/block/rnull/Kconfig
+++ b/drivers/block/rnull/Kconfig
@@ -4,7 +4,7 @@
 
 config BLK_DEV_RUST_NULL
 	tristate "Rust null block driver (Experimental)"
-	depends on RUST
+	depends on RUST && CONFIGFS_FS
 	help
 	  This is the Rust implementation of the null block driver. Like
 	  the C version, the driver allows the user to create virutal block
diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
new file mode 100644
index 000000000000..488fe27f83a2
--- /dev/null
+++ b/drivers/block/rnull/configfs.rs
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::{NullBlkDevice, THIS_MODULE};
+use core::fmt::Write;
+use kernel::{
+    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
+    c_str,
+    configfs::{self, AttributeOperations},
+    configfs_attrs, new_mutex,
+    page::PAGE_SIZE,
+    prelude::*,
+    str::{bytes_to_bool, CString},
+    sync::Mutex,
+};
+use pin_init::PinInit;
+
+pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsystem<Config>, Error> {
+    let item_type = configfs_attrs! {
+        container: configfs::Subsystem<Config>,
+        data: Config,
+        child: DeviceConfig,
+        attributes: [
+            features: 0,
+        ],
+    };
+
+    kernel::configfs::Subsystem::new(c_str!("rnull"), item_type, try_pin_init!(Config {}))
+}
+
+#[pin_data]
+pub(crate) struct Config {}
+
+#[vtable]
+impl AttributeOperations<0> for Config {
+    type Data = Config;
+
+    fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::Formatter::new(page);
+        writer.write_str("blocksize,size,rotational\n")?;
+        Ok(writer.bytes_written())
+    }
+}
+
+#[vtable]
+impl configfs::GroupOperations for Config {
+    type Child = DeviceConfig;
+
+    fn make_group(
+        &self,
+        name: &CStr,
+    ) -> Result<impl PinInit<configfs::Group<DeviceConfig>, Error>> {
+        let item_type = configfs_attrs! {
+            container: configfs::Group<DeviceConfig>,
+            data: DeviceConfig,
+            attributes: [
+                // Named for compatibility with C null_blk
+                power: 0,
+                blocksize: 1,
+                rotational: 2,
+                size: 3,
+            ],
+        };
+
+        Ok(configfs::Group::new(
+            name.try_into()?,
+            item_type,
+            // TODO: cannot coerce new_mutex!() to impl PinInit<_, Error>, so put mutex inside
+            try_pin_init!( DeviceConfig {
+                data <- new_mutex!(DeviceConfigInner {
+                    powered: false,
+                    block_size: 4096,
+                    rotational: false,
+                    disk: None,
+                    capacity_mib: 4096,
+                    name: name.try_into()?,
+                }),
+            }),
+        ))
+    }
+}
+
+#[pin_data]
+pub(crate) struct DeviceConfig {
+    #[pin]
+    data: Mutex<DeviceConfigInner>,
+}
+
+#[pin_data]
+struct DeviceConfigInner {
+    powered: bool,
+    name: CString,
+    block_size: u32,
+    rotational: bool,
+    capacity_mib: u64,
+    disk: Option<GenDisk<NullBlkDevice>>,
+}
+
+#[vtable]
+impl configfs::AttributeOperations<0> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::Formatter::new(page);
+
+        if this.data.lock().powered {
+            writer.write_str("1\n")?;
+        } else {
+            writer.write_str("0\n")?;
+        }
+
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        let power_op = bytes_to_bool(page)?;
+        let mut guard = this.data.lock();
+
+        if !guard.powered && power_op {
+            guard.disk = Some(NullBlkDevice::new(
+                &guard.name,
+                guard.block_size,
+                guard.rotational,
+                guard.capacity_mib,
+            )?);
+            guard.powered = true;
+        } else if guard.powered && !power_op {
+            drop(guard.disk.take());
+            guard.powered = false;
+        }
+
+        Ok(())
+    }
+}
+
+#[vtable]
+impl configfs::AttributeOperations<1> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::Formatter::new(page);
+        writer.write_fmt(fmt!("{}\n", this.data.lock().block_size))?;
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        if this.data.lock().powered {
+            return Err(EBUSY);
+        }
+
+        let text = core::str::from_utf8(page)?.trim();
+        let value = text.parse::<u32>().map_err(|_| EINVAL)?;
+
+        GenDiskBuilder::validate_block_size(value)?;
+        this.data.lock().block_size = value;
+        Ok(())
+    }
+}
+
+#[vtable]
+impl configfs::AttributeOperations<2> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::Formatter::new(page);
+
+        if this.data.lock().rotational {
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
+        this.data.lock().rotational = bytes_to_bool(page)?;
+
+        Ok(())
+    }
+}
+
+#[vtable]
+impl configfs::AttributeOperations<3> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::Formatter::new(page);
+        writer.write_fmt(fmt!("{}\n", this.data.lock().capacity_mib))?;
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        if this.data.lock().powered {
+            return Err(EBUSY);
+        }
+
+        let text = core::str::from_utf8(page)?.trim();
+        let value = text.parse::<u64>().map_err(|_| EINVAL)?;
+
+        this.data.lock().capacity_mib = value;
+        Ok(())
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index d07e76ae2c13..d09bc77861e4 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -1,28 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
 
 //! This is a Rust implementation of the C null block driver.
-//!
-//! Supported features:
-//!
-//! - blk-mq interface
-//! - direct completion
-//! - block size 4k
-//!
-//! The driver is not configurable.
+
+mod configfs;
 
 use kernel::{
     alloc::flags,
-    block::mq::{
+    block::{
         self,
-        gen_disk::{self, GenDisk},
-        Operations, TagSet,
+        mq::{
+            self,
+            gen_disk::{self, GenDisk},
+            Operations, TagSet,
+        },
     },
     error::Result,
-    new_mutex, pr_info,
+    pr_info,
     prelude::*,
-    sync::{Arc, Mutex},
+    sync::Arc,
     types::ARef,
 };
+use pin_init::PinInit;
 
 module! {
     type: NullBlkModule,
@@ -35,33 +33,39 @@
 #[pin_data]
 struct NullBlkModule {
     #[pin]
-    _disk: Mutex<GenDisk<NullBlkDevice>>,
+    configfs_subsystem: kernel::configfs::Subsystem<configfs::Config>,
 }
 
 impl kernel::InPlaceModule for NullBlkModule {
     fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         pr_info!("Rust null_blk loaded\n");
 
-        // Use a immediately-called closure as a stable `try` block
-        let disk = /* try */ (|| {
-            let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
-
-            gen_disk::GenDiskBuilder::new()
-                .capacity_sectors(4096 << 11)
-                .logical_block_size(4096)?
-                .physical_block_size(4096)?
-                .rotational(false)
-                .build(format_args!("rnullb{}", 0), tagset)
-        })();
-
         try_pin_init!(Self {
-            _disk <- new_mutex!(disk?, "nullb:disk"),
+            configfs_subsystem <- configfs::subsystem(),
         })
     }
 }
 
 struct NullBlkDevice;
 
+impl NullBlkDevice {
+    fn new(
+        name: &CStr,
+        block_size: u32,
+        rotational: bool,
+        capacity_mib: u64,
+    ) -> Result<GenDisk<Self>> {
+        let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
+
+        gen_disk::GenDiskBuilder::new()
+            .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT))
+            .logical_block_size(block_size)?
+            .physical_block_size(block_size)?
+            .rotational(rotational)
+            .build(fmt!("{}", name.to_str()?), tagset)
+    }
+}
+
 #[vtable]
 impl Operations for NullBlkDevice {
     #[inline(always)]
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 20f1d46c774d..6b1b846874db 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -51,7 +51,7 @@ pub fn rotational(mut self, rotational: bool) -> Self {
 
     /// Validate block size by verifying that it is between 512 and `PAGE_SIZE`,
     /// and that it is a power of two.
-    fn validate_block_size(size: u32) -> Result {
+    pub fn validate_block_size(size: u32) -> Result {
         if !(512..=bindings::PAGE_SIZE as u32).contains(&size) || !size.is_power_of_two() {
             Err(error::code::EINVAL)
         } else {

-- 
2.47.2


