Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329B2EA499;
	Fri, 11 Jul 2025 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234265; cv=none; b=nSX9LslbNhOvf23JEnDEhvoMEkM5QTOCjU4IM6ykH+/I552FIKL3S5my0hORSFBdmQjzwaHAlLEP3hKn19TVx2tlgPC8mPHrZd7mLOMX0O4/XLgE4MYxlsFAK7nbBRr3nwupB9W6s2Emvk1y11fdj9is2V1h58C8oinK3cgVCrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234265; c=relaxed/simple;
	bh=kNIg3hkkOzE1843fVUQVqCA9SmYe5SbYcBp0IcJb8eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnOEuJr73JWqj/RcMHjEw6W62aGgClDcug038/R9z+wbKk0+oEpYNElnY215EDJre352XW4ahROFHYiKsSWFfLEzja4KjAh0GTOKTay2zW9Qerth5U1RsLGRz3m7vY5DaiTO7ggtH5CPQAq4ONKxh6wpnQEzjD21Bv3fFSWEius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrhJM/yE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrhJM/yE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE335C4CEF4;
	Fri, 11 Jul 2025 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234264;
	bh=kNIg3hkkOzE1843fVUQVqCA9SmYe5SbYcBp0IcJb8eE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SrhJM/yEE4ktjpHGsABvW/G91MYd6vxV7snrc7i9+kCqM+TnhZ9zz667iAl5JNNZi
	 P5mC9VNWX/Dk97IceOSZY7Rs4t1+T4oeTGCiWV7bndbgYaHwVh4Ad9hmrH1it1tmqe
	 vP4K+3qcrSSDD7lqFB/RIpaahj1LXmj5LzE6/d43l61zTz4gL1t8pRc1ToFswkqHZM
	 MLjPTlU5hFwiJ15kgBOQOW6i8FT95dITsj+7mt22EguRq2Hd5rmakzNGsK2iTcP4p8
	 BLTwDbBJddX/TguSojmjYAj6N1xy3uITiNbgZmaEkDAq59dq3H+0kpQBC+diUA05T3
	 oP8xO5QJ5dCUw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:13 +0200
Subject: [PATCH v3 12/16] rnull: enable configuration via `configfs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-12-3a262b4e2921@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10886;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=kNIg3hkkOzE1843fVUQVqCA9SmYe5SbYcBp0IcJb8eE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjUK0FtDzMzsNcedDP78IaboOs5lpCvhB7ol
 9aI1ffsl2iJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD41AAKCRDhuBo+eShj
 dxg9EACtZN3kH8xV1R4zdsh5hc1Im/NifutQhHvxiIWpXLi6e6P8s3RevmKZ2gmE8U+6LQIFwC3
 kGq1vjsLs39qSr9za+R4z8SSGST8iqf4rBQ956hXVybJ24Stqe0Cck5W9td0mMtIna4UglCrhcn
 s1yMgjZVS4nUDHv4iYuXrzvD48X//mpeyJMY8ip3Oleb/w8UFQPN18aZpz/x6H1twAamK6THwOF
 +laaxnoi9B90cemvVyxbWrxZxnstIav7w9dbBvLK8J91VJKDR3WlRU9obCiE1Cq1ZMuDZC2kcEv
 wpsUL1Xis0oymntt1UBk95y6NpJaBbUnNB+eeDINIXtTjQDmDDKzpHIRyvLOqO5yW9m8qcws9Wb
 /gaXc05KTNqKUznccwMCKhAZCqQDdMI7t3ALdo4lWMwNWFSbksirYo4VxBXF+bLBVCIRxjss9L+
 nv+XZ9iCsb4T3r9cxJnS6rnGEUrd1nxzoYtvKtO71wsb3Xr+TGM0u8pGwr9kGNBwKSnGROHMhDn
 xdblVkrVxEW+3bhfbhyETQ+CdYroX0FS6+k7M0kY2B+T0b08kABD4w9Bd8Iz5meQNcK1/uvL3Bz
 EZz2GFY5ntCK5ikaCS3laogMURlN+2TDm5XhK/JZCWktp8LgM/9mfWRIMOKNuP+CnW5cUS/sy7A
 FFHTiWQaFqfwFkQ==
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
index 000000000000..6c0e3bbb36ec
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
+        let mut writer = kernel::str::Formatter::new(page);
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
+        let mut writer = kernel::str::Formatter::new(page);
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
+        let value = text
+            .parse::<u64>()
+            .map_err(|_| kernel::error::code::EINVAL)?;
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
index 39be2a31337f..7ab049ec591b 100644
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


