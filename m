Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA323D2AD;
	Tue,  8 Jul 2025 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003969; cv=none; b=YNqfzrE+FEj93c391PUtA+2t3upebmKkUo8gyXHFC36tn0XbAL6A2W6ZReLLP/PA6HKxsXmTscm2O9sQt6araEkc7lp6SC5d2X8YxjWmVk/gQQXZoQvEyXey8yTwp0C+aMLUhqsYuuOSTIbQw/dZGmkO4BW//GDgQlnQ7ROgnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003969; c=relaxed/simple;
	bh=EfT5ee6ZDKLcdtWm0kzm2QQNu8YrPCPhmrWRg9QQ6MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+O4ZjBaV6XN36rA0slFWI04jqr8dV0U6s5+i8oM0VhG5Ggp57XBfWsBz9gtWJme9QS4fA6pkw6nJZgCTeUVpf7X1AKAgcp63oUizvsiaSweRUyIsJNWfw9kxVb8uL3zUo8VNads9aJwConRF0CF2GF3W0PHJuOGd7I9go2itgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d645AdX2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d645AdX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFFBC4CEED;
	Tue,  8 Jul 2025 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003968;
	bh=EfT5ee6ZDKLcdtWm0kzm2QQNu8YrPCPhmrWRg9QQ6MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d645AdX2szkm9zIhuE0bIY1GB8Gnb1vJA63AVZoDtbDoK24VJO8rgVXymOrXnrt3g
	 aJggyLnbzGb4qZB9KWpAA6UCVlaJJnrj+3onnoMpheMfuBK7/06d8LCWtWOXwr01QX
	 /8Y3r7FPTrRB7l+6+Eq+ka/0RhDkrdua1W2IIlhhUKHTurAkFdYSoG82YHTjyYRQuh
	 LULWIGP/orOw/tjA9VY6/u1RbNq+JEIvsVaNTBChlgMqzskT2pVlXhvGfBkBbSjjms
	 sOlp4KeDMsPxgX3Jn1jAIHD/B7W+uTtnnFeN34r043/efwOHJ4B71RpVtjXUv2CxAB
	 hQRxOX9xubTmA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:45:05 +0200
Subject: [PATCH v2 10/14] rnull: enable configuration via `configfs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-10-ab93c0ff429b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10929;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=EfT5ee6ZDKLcdtWm0kzm2QQNu8YrPCPhmrWRg9QQ6MM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVJu5SzzA11kvRG+tlEpGDFFWCfaGOVS2D8Y
 NX5MSVPNc+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11SQAKCRDhuBo+eShj
 d1gEEACkqtbzGrUUd5y4vgoaQCMxGvGe5Wv1x04omOzhFzmdinPzWwQIBCAkwPkD95uBmgnfVgA
 xJjXFGRTHOucLhRla97fTixdTy3HEDIZKyOdwJi+dFXWArEvEuO0i4HZlIdDDhTpNkriBS9Az1V
 wZYRig8tw364RIaMBnyQ0iC3UTFp2MGxXZntVdMUcoYmsEyP14R8Zrr3UFOOerR1ZW1Kzj4bHB8
 pmmScnIe0Atdg4XMkuYngiV7hb4n7i3Bb/gm4U8SuC/A3qbcGO9fIlOgQRmxtcV5xoB+2GMOYSN
 w4BmhkUnWLzk2VJVZxaBQQkZdrLKeZrhBzkaK0h/CwUpl1DgI1QYRjs6eTnzyMzkcRfJA0FK9Ls
 zTXcE5f6iCjwxCt9Bhgf/KQ3MIhsqEG1p3vDw8CZ3b/qEHKKSTFP7P7MVp4xF+rhi+zFsMnCwAR
 z5stGqgSzhhWvxgiIwFfZYKVXZUY46V/7/J6K5d94LvlcgdReQhytFcIsX/BXSaJY8FI2/hDjsG
 mz7mZM1D20nW6olplZT2WaidO8eJngj84OaZX7HOAA+czGpyFPmH5fYn0YonagIpOtmVy2itUOG
 McuvfHlkuT0NYrDv0DTfDxdgJUMBZAflMMpzhKDATvoi/NNFjNwIYwVXTbe0ruJI3TkGaZ5IINQ
 Ehhv6IG7yvjwCyQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow rust null block devices to be configured and instantiated via
`configfs`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/Kconfig      |   2 +-
 drivers/block/rnull/configfs.rs  | 220 +++++++++++++++++++++++++++++++++++++++
 drivers/block/rnull/rnull.rs     |  58 ++++++-----
 rust/kernel/block/mq/gen_disk.rs |   2 +-
 4 files changed, 253 insertions(+), 29 deletions(-)

diff --git a/drivers/block/rnull/Kconfig b/drivers/block/rnull/Kconfig
index 6dc5aff96bf4e..7bc5b376c128b 100644
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
index 0000000000000..e7bd2b8f1e905
--- /dev/null
+++ b/drivers/block/rnull/configfs.rs
@@ -0,0 +1,220 @@
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
+    str::CString,
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
+        let mut writer = kernel::str::BorrowFormatter::new(page)?;
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
+                data <- new_mutex!( DeviceConfigInner {
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
+        let mut writer = kernel::str::BorrowFormatter::new(page)?;
+
+        if this.data.lock().powered {
+            writer.write_fmt(fmt!("1\n"))?;
+        } else {
+            writer.write_fmt(fmt!("0\n"))?;
+        }
+
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        let power_op: bool = core::str::from_utf8(page)?
+            .trim()
+            .parse::<u8>()
+            .map_err(|_| kernel::error::code::EINVAL)?
+            != 0;
+
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
+        let mut writer = kernel::str::BorrowFormatter::new(page)?;
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
+        let value = text
+            .parse::<u32>()
+            .map_err(|_| kernel::error::code::EINVAL)?;
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
+        let mut writer = kernel::str::BorrowFormatter::new(page)?;
+
+        if this.data.lock().rotational {
+            writer.write_fmt(fmt!("1\n"))?;
+        } else {
+            writer.write_fmt(fmt!("0\n"))?;
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
+        this.data.lock().rotational = core::str::from_utf8(page)?
+            .trim()
+            .parse::<u8>()
+            .map_err(|_| kernel::error::code::EINVAL)?
+            != 0;
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
+        let mut writer = kernel::str::BorrowFormatter::new(page)?;
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
+        let value = text
+            .parse::<u64>()
+            .map_err(|_| kernel::error::code::EINVAL)?;
+
+        this.data.lock().capacity_mib = value;
+        Ok(())
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index d07e76ae2c13f..d09bc77861e4e 100644
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
index e0e42f7028276..6cf0f3d411b4f 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -50,7 +50,7 @@ pub fn rotational(mut self, rotational: bool) -> Self {
 
     /// Validate block size by verifying that it is between 512 and `PAGE_SIZE`,
     /// and that it is a power of two.
-    fn validate_block_size(size: u32) -> Result {
+    pub fn validate_block_size(size: u32) -> Result {
         if !(512..=bindings::PAGE_SIZE as u32).contains(&size) || !size.is_power_of_two() {
             Err(error::code::EINVAL)
         } else {

-- 
2.47.2


