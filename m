Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7E2E972D;
	Tue, 12 Aug 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988378; cv=none; b=RPXqpLbzYuoKUhYmyaUUiDqocErsPs1mtOsTVL2ZBBS5jyhd08SD+5cEEkD7B0Q0YJfGVtZqGKYj6QeEXP74U2TnZfv0HNGhHNQQ5b/dDbzyLecVBqZfFV8mrhUNiZkBKLsH4qcYakeKlltY2d3oW1AmPNL+yFP4MBDSz0Ve258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988378; c=relaxed/simple;
	bh=flRlDhE3XAzugM1vKE+JBErvKHVu87t30+xem0Jh3xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fIDCGjU9fwfgQ2hbJl9Bf7v4yErYzVsSNpz+MrWsLrw1RgxrU7ARySn9fax5hiS35TNOWnUyBnoTPeKA07UYKA3qRC08mbKF/ZempsBDhzU3zkBGS3VhIk4hd9RKBh3APZ62jA0icqgEW+JBXLPsRN3flR+byt4Fiw6yHASZFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrN8LnBH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrN8LnBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434B9C4CEF0;
	Tue, 12 Aug 2025 08:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988378;
	bh=flRlDhE3XAzugM1vKE+JBErvKHVu87t30+xem0Jh3xo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CrN8LnBHlkSzLow1hSYg4P4efNQY3Z960sEkHza+q+7o3ewJGxhwzbU2Syd7w+8R9
	 sK4fQMhDs+Bi9FH0ajzynMGuvm/OfoHDjWt9Umjp7GHNeJQtaWB/bKo0qE8WGdDsN2
	 sP9C1mi856yJiE3uTvV2FQyZip6WFk6n3umM/AXsUYgLwRsJnVT9ee1VHSZnnNVHWk
	 w7AZVMoixkKSINr+ofiXHoHhwDgobuerbfOoLLiPm2DJbx9xe/2L3kkGAIlGTlJHG8
	 J2kRowcmOipUE8p7CkiFH0q2NUJUjRj0QJKJvmQkCJlommCgOIsZGHeGfOE35TZtnA
	 3iB8bq/ym53sw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:29 +0200
Subject: [PATCH v4 11/15] rnull: enable configuration via `configfs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-11-ed801dd3ba5c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10790;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=flRlDhE3XAzugM1vKE+JBErvKHVu87t30+xem0Jh3xo=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8lR83zjnMXRogKV0DZfL2Jl2g7lRYWIR1kx
 5pethdelRSJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/JQAKCRDhuBo+eShj
 dwpLD/9IESeTlwvxp9yP+aWuY+2q1SqVQCHpo3ZIYXVLbcmWD8z1MDAxX4h8T6ij/NOr0VqtN9H
 piLPCiqW18WRkclQzpWRe/dSewFmqx7u5xishvA7om+kwVDj+EJH9eg7Ev6HSXaKZ/nK1LpHEMg
 4l5mAYxYDuJQNynVAdGYgYhRLf5LzIRvg07szewQAQepX+F6cVLXban2vkZz3MDAxCnNw0iw6PY
 AQK2QmkKgWlMPj8phQCzSrisTMpm8LwU0ZtgTRSXcxsgd0i1UBHqf6cDwIDDRHQsbSguDvVI/vM
 yslU/IYJUqlZtd1HBub5a0RhvU/Jfh0V+pbJW4aHJJdiynIpFmOxaTZdWsk+zl9NS2BJRBE30B2
 ARTUgB+3swNyeZxhbjkCHK++/lKh+R8F0Wl5JoKZYGsx+WQzVfkChB8i+ukNdfrod8SU94KJ9rs
 fVVkuHlZ+cPXRFDbazssZsbLEY9Uh+cOjHC/ajClegfj6ZCWLOKmgK0U3lrMUIhnSD4CZocx8gY
 Fqb99RhU4IGw4jiIM6Y8cDhmB80+9vESwSjYlQh1q90RrIb7fkFu8Vf/DIoenoBEA35O9Qgk21d
 6FzGlmobt1rWnLjO/Q3MJpGyuzq9jhzpS96mesgK2CQoz7g/JD2Ej1rDp6tEEyae9MdD0QNCk+E
 e7ka7nm+uPqm8KA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow rust null block devices to be configured and instantiated via
`configfs`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/Kconfig      |   2 +-
 drivers/block/rnull/configfs.rs  | 218 +++++++++++++++++++++++++++++++++++++++
 drivers/block/rnull/rnull.rs     |  58 ++++++-----
 rust/kernel/block/mq/gen_disk.rs |   2 +-
 4 files changed, 251 insertions(+), 29 deletions(-)

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
index 000000000000..8d469c046a39
--- /dev/null
+++ b/drivers/block/rnull/configfs.rs
@@ -0,0 +1,218 @@
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
+            writer.write_str("1\n")?;
+        } else {
+            writer.write_str("0\n")?;
+        }
+
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        let power_op_str = core::str::from_utf8(page)?.trim();
+
+        let power_op = match power_op_str {
+            "0" => Ok(false),
+            "1" => Ok(true),
+            _ => Err(EINVAL),
+        }?;
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
+        this.data.lock().rotational = match core::str::from_utf8(page)?.trim() {
+            "0" => false,
+            "1" => true,
+            _ => return Err(EINVAL),
+        };
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


