Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.30.211.244
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958570;
	b=1HSj1uugr4WRZH6yR+kToeYk9QzCaZQTPA/pwP2cfEheLA7iwgagV7kmo6pYxAeo1WTO
	 JjDHu9RCHls+hu4vP5KkODhlt4XaBv6Yw2WB2lNR3C8JU2jjBc0ho8R1XlwsXXeOtNOFO
	 olQwC/wfwZxpOem1mcV+B0g763mHHqdxlecUAZABLIa+pPj9C+4e+enjaafHIaQfFl+zS
	 kcDIrL22TRHc8jPlgJAK8VFYKeaty3ON6+2Sbdtpg44+w6AM8RFns2CtAt7kVJImMhKh2
	 4Hlg6FA6owoq+2MF1XCsYWOPtKCahB5wG+xQWVxw+/RDc6ZDWSo0mH+jY5JF2eLRlvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958570;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gqignXaU0V5hW9lQt4WWA4Icn1y7QvPbKaaiz/DMnAU=;
	b=fviFfNKkzW/NNdznGR3vTqVphDEW4SCSBZ5N+bSML8oLZ+B7RJnnG4GBTRTh+J2eE6dV
	 c4cmLLUSx20ELsqmquCK9aTfwHLvxt4bbUFIpr/CqPBWGoxJFCYArN4bqiEO74lZXeXZm
	 pnFJFyFv4hWWA9+2bj7My6p+yV5jQrclXAuNMpiPW1mkDhu/60uj0kTMSRIRKm+tvPAm+
	 OH1gisUDsHuZi1LyRy0Lu6QsVL7lykPvHrsi5CocJowbIjW1S5XQHqxwdIpQROKN6K7JP
	 uKLqBbhoY6Kt7fIiTGS64LvjZa3Rodwb75+Lzq0QKNR3KINsWpgkLbQ5YxyHTPUIL9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=konsulko.se;
	spf=none smtp.mailfrom=konsulko.se;
	dkim=pass header.d=konsulko.se header.i=@konsulko.se header.a=rsa-sha256 header.s=rsa2 header.b=ZN168bIe;
	dkim=pass header.d=konsulko.se header.i=@konsulko.se header.a=ed25519-sha256 header.s=ed2 header.b=G2RrmLZx;
	arc=none smtp.remote-ip=46.30.211.244
Received: from mailrelay-egress5.pub.mailoutpod3-cph3.one.com (mailrelay-egress5.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87378606A32C
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 23:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87378606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=konsulko.se header.i=@konsulko.se header.a=rsa-sha256 header.s=rsa2 header.b=ZN168bIe;
	dkim=pass header.d=konsulko.se header.i=@konsulko.se header.a=ed25519-sha256 header.s=ed2 header.b=G2RrmLZx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794958567; x=1795563367;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=gqignXaU0V5hW9lQt4WWA4Icn1y7QvPbKaaiz/DMnAU=;
	b=ZN168bIeLs99PdNvaKFNO6kwnTpdFUq5Rh51Vc/QjzhuyYuKPdpjENzQUAxAxXFj8zGaZKG66Ku9x
	 M30mDivqMTpzv480atLkjuIc9R0wYhAzqMDD3vCPGMVozJNFRTYdahve582noWIHCz0+1m5rzN0nI4
	 N0xJ61rNxPM+7OCLPddLgMBqCit5klFXWz24E/blhf0POpuilkz3zKIb8qht+XntV+M+8sxCPVg8+5
	 0ndKyvq+TorxYSxXhM5L7dOjicxAbTBe0QqfBo+a8N1citJhHH6yNr74k0Ry0oWsyP8gIv83d7TM5O
	 3MuKulR+UmAt/AlrtkgI/abQ64F3vvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794958567; x=1795563367;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=gqignXaU0V5hW9lQt4WWA4Icn1y7QvPbKaaiz/DMnAU=;
	b=G2RrmLZx6Fhcs20twnkMKNhQ9l2zvidYWA6Nywq45O3ivJlHj4gg6LbPcelXJn8tgP5gl2GU4HKfE
	 nFppFlkCw==
X-HalOne-ID: a7693497-e2df-11f1-92eb-49de817b90c1
Received: from slottsdator.home (unknown [2a02:1406:27d:15:2438:a644:c11e:a5ef])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id a7693497-e2df-11f1-92eb-49de817b90c1;
	Tue, 17 Nov 2026 23:36:05 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH 3/3] rust: block: add rbrd, a RAM backed block driver
Date: Wed, 18 Nov 2026 00:32:11 +0100
Message-Id: <20261117233211.3137168-4-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117233211.3137168-1-vitaly.wool@konsulko.se>
References: <20261117233211.3137168-1-vitaly.wool@konsulko.se>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a RAM backed block driver written in Rust, based on rnull and
working like brd: pages are allocated on first write, unwritten areas
read as zeroes and discards free the pages they fully cover. Devices
are created through configfs, with `power`, `blocksize` and `size`
(MiB) attributes:

  mkdir /sys/kernel/config/rbrd/rram0
  echo 1 > /sys/kernel/config/rbrd/rram0/power    # adds /dev/rram0

Pages are kept in a flat array of atomic pointers allocated at power
on. Lookups take a speculative reference with `Page::try_get_raw()`
and re-check the slot, like brd_lookup_page(); inserts use a
compare-and-exchange and discards an exchange with null, so the I/O
path takes no lock. Copies to and from each page are serialized by
a bit spinlock in its `page->private`, as opposed to the existing
RAM block device driver which allows simultaneous reads and writes
to pages. Thus, this driver always keeps data integrity.

Requests are served from queue_rq() with GFP_NOWAIT allocations; on
failure the block layer retries with BLK_STS_RESOURCE. There is one
hardware queue per CPU, which also avoids mq-deadline, and a queue
depth of 32.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
 MAINTAINERS                    |   1 +
 drivers/block/Kconfig          |   1 +
 drivers/block/Makefile         |   1 +
 drivers/block/rbrd/Kconfig     |  17 ++
 drivers/block/rbrd/Makefile    |   2 +
 drivers/block/rbrd/configfs.rs | 188 +++++++++++++++
 drivers/block/rbrd/rbrd.rs     | 420 +++++++++++++++++++++++++++++++++
 7 files changed, 630 insertions(+)
 create mode 100644 drivers/block/rbrd/Kconfig
 create mode 100644 drivers/block/rbrd/Makefile
 create mode 100644 drivers/block/rbrd/configfs.rs
 create mode 100644 drivers/block/rbrd/rbrd.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index ccbcdc0799b9..fcf1ea505101 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4886,6 +4886,7 @@ W:	https://rust-for-linux.com
 B:	https://github.com/Rust-for-Linux/linux/issues
 C:	https://rust-for-linux.zulipchat.com/#narrow/stream/Block
 T:	git https://github.com/Rust-for-Linux/linux.git rust-block-next
+F:	drivers/block/rbrd/
 F:	drivers/block/rnull/
 F:	rust/kernel/block.rs
 F:	rust/kernel/block/
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 858320b6ebb7..34face102851 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -18,6 +18,7 @@ if BLK_DEV
 
 source "drivers/block/null_blk/Kconfig"
 source "drivers/block/rnull/Kconfig"
+source "drivers/block/rbrd/Kconfig"
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 2d8096eb8cdf..54e3e06fbce1 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull/
+obj-$(CONFIG_BLK_DEV_RUST_RAM) += rbrd/
 
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
 obj-$(CONFIG_BLK_DEV_ZONED_LOOP) += zloop.o
diff --git a/drivers/block/rbrd/Kconfig b/drivers/block/rbrd/Kconfig
new file mode 100644
index 000000000000..94b836d3ff35
--- /dev/null
+++ b/drivers/block/rbrd/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Rust RAM backed block device driver configuration
+
+config BLK_DEV_RUST_RAM
+	tristate "Rust RAM block device driver (Experimental)"
+	depends on RUST && CONFIGFS_FS
+	help
+	  This is a RAM backed block device driver written in Rust, based
+	  on the Rust null block driver. Like the C brd driver, it stores
+	  device contents in pages allocated on demand. Devices are created
+	  and configured through configfs under /sys/kernel/config/rbrd/.
+
+	  Device contents are lost when a device is powered off or the
+	  module is unloaded.
+
+	  If unsure, say N.
diff --git a/drivers/block/rbrd/Makefile b/drivers/block/rbrd/Makefile
new file mode 100644
index 000000000000..b5e0c10b4bea
--- /dev/null
+++ b/drivers/block/rbrd/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_BLK_DEV_RUST_RAM) += rbrd_mod.o
+rbrd_mod-y := rbrd.o
diff --git a/drivers/block/rbrd/configfs.rs b/drivers/block/rbrd/configfs.rs
new file mode 100644
index 000000000000..0179bf2cb123
--- /dev/null
+++ b/drivers/block/rbrd/configfs.rs
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::RamDisk;
+use kernel::{
+    block::mq::gen_disk::{
+        GenDisk,
+        GenDiskBuilder, //
+    },
+    configfs::{
+        self,
+        AttributeOperations, //
+    },
+    configfs_attrs,
+    fmt::Write as _,
+    new_mutex,
+    page::PAGE_SIZE,
+    prelude::*,
+    str::{
+        kstrtobool_bytes,
+        CString, //
+    },
+    sync::Mutex, //
+};
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
+    kernel::configfs::Subsystem::new(c"rbrd", item_type, try_pin_init!(Config {}))
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
+        writer.write_str("blocksize,size,power\n")?;
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
+                power: 0,
+                blocksize: 1,
+                size: 2,
+            ],
+        };
+
+        Ok(configfs::Group::new(
+            name.try_into()?,
+            item_type,
+            try_pin_init!(DeviceConfig {
+                data <- new_mutex!(DeviceConfigInner {
+                    powered: false,
+                    block_size: 512,
+                    disk: None,
+                    capacity_mib: 64,
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
+    capacity_mib: u64,
+    disk: Option<GenDisk<RamDisk>>,
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
+        let power_op = kstrtobool_bytes(page)?;
+        let mut guard = this.data.lock();
+
+        if !guard.powered && power_op {
+            guard.disk = Some(RamDisk::new(
+                &guard.name,
+                guard.block_size,
+                guard.capacity_mib,
+            )?);
+            guard.powered = true;
+        } else if guard.powered && !power_op {
+            // Removes the disk and frees all of its contents.
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
+        let mut guard = this.data.lock();
+        if guard.powered {
+            return Err(EBUSY);
+        }
+
+        let text = core::str::from_utf8(page)?.trim();
+        let value = text.parse::<u32>().map_err(|_| EINVAL)?;
+
+        GenDiskBuilder::validate_block_size(value)?;
+        guard.block_size = value;
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
+        writer.write_fmt(fmt!("{}\n", this.data.lock().capacity_mib))?;
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        let mut guard = this.data.lock();
+        if guard.powered {
+            return Err(EBUSY);
+        }
+
+        let text = core::str::from_utf8(page)?.trim();
+        let value = text.parse::<u64>().map_err(|_| EINVAL)?;
+        if value == 0 {
+            return Err(EINVAL);
+        }
+
+        guard.capacity_mib = value;
+        Ok(())
+    }
+}
diff --git a/drivers/block/rbrd/rbrd.rs b/drivers/block/rbrd/rbrd.rs
new file mode 100644
index 000000000000..e5e698172507
--- /dev/null
+++ b/drivers/block/rbrd/rbrd.rs
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A RAM backed block device driver written in Rust.
+//!
+//! The driver is based on the Rust null block driver and works like the C
+//! `brd` driver: every device stores its contents in pages that are allocated
+//! on the first write to them. Unlike `brd`, the pages are tracked in a flat
+//! array with one slot per page of the device, allocated when the device is
+//! created, instead of in an XArray. Reads of never written areas return
+//! zeroes. Discards free whole pages.
+//!
+//! Devices are created through configfs:
+//!
+//! ```text
+//! mkdir /sys/kernel/config/rbrd/rram0
+//! echo 512 > /sys/kernel/config/rbrd/rram0/size     # MiB
+//! echo 1 > /sys/kernel/config/rbrd/rram0/power      # creates /dev/rram0
+//! ```
+//!
+//! The contents of a device are lost when it is powered off.
+
+mod configfs;
+
+use kernel::{
+    bindings,
+    block::{
+        self,
+        bio::Segment,
+        mq::{
+            self,
+            gen_disk::{
+                self,
+                GenDisk, //
+            },
+            Command,
+            Operations,
+            TagSet, //
+        }, //
+    },
+    page::{
+        Page,
+        PagePrivateBitGuard,
+        PAGE_SHIFT,
+        PAGE_SIZE, //
+    },
+    prelude::*,
+    sync::{
+        aref::ARef,
+        atomic::{
+            Acquire,
+            Atomic,
+            Full,
+            Relaxed, //
+        },
+        Arc, //
+    }, //
+};
+
+use core::ptr::{
+    self,
+    NonNull, //
+};
+
+module! {
+    type: RamDiskModule,
+    name: "rbrd",
+    authors: ["Vitaly Wool"],
+    description: "Rust RAM backed block device driver",
+    license: "GPL v2",
+}
+
+#[pin_data]
+struct RamDiskModule {
+    #[pin]
+    configfs_subsystem: kernel::configfs::Subsystem<configfs::Config>,
+}
+
+impl kernel::InPlaceModule for RamDiskModule {
+    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        pr_info!("Rust RAM block driver loaded\n");
+
+        try_pin_init!(Self {
+            configfs_subsystem <- configfs::subsystem(),
+        })
+    }
+}
+
+/// Maximum size of a single discard request.
+///
+/// Discards are processed in atomic context, page by page. Bound the amount of
+/// work done per request; larger discards are split by the block layer.
+const MAX_DISCARD_SECTORS: u32 = (128 << 20) >> block::SECTOR_SHIFT;
+
+/// GFP flags for allocations in the I/O path, which must not sleep.
+fn io_gfp() -> kernel::alloc::Flags {
+    GFP_NOWAIT | __GFP_NOWARN
+}
+
+struct RamDisk;
+
+impl RamDisk {
+    fn new(name: &CStr, block_size: u32, capacity_mib: u64) -> Result<GenDisk<Self>> {
+        if capacity_mib == 0 {
+            return Err(EINVAL);
+        }
+
+        let capacity_sectors = capacity_mib
+            .checked_mul(1 << (20 - block::SECTOR_SHIFT))
+            .ok_or(EINVAL)?;
+        let nr_pages = usize::try_from(capacity_mib)?
+            .checked_mul((1 << 20) / PAGE_SIZE)
+            .ok_or(EINVAL)?;
+
+        // One hardware queue per CPU. Besides avoiding contention on a single
+        // hardware context, this keeps blk-mq from attaching the mq-deadline
+        // scheduler, which it does by default for single queue devices.
+        //
+        // Requests are completed within `queue_rq()`, which releases their tag
+        // right away, so only a few tags per queue are ever in use at once. A
+        // small depth keeps the requests preallocated for every queue cheap.
+        let tagset = Arc::pin_init(TagSet::new(kernel::cpu::nr_cpu_ids(), 32, 1), GFP_KERNEL)?;
+        let storage = KBox::try_pin_init(Storage::new(nr_pages), GFP_KERNEL)?;
+
+        gen_disk::GenDiskBuilder::new()
+            .capacity_sectors(capacity_sectors)
+            .logical_block_size(block_size)?
+            .physical_block_size(block_size)?
+            .max_hw_discard_sectors(MAX_DISCARD_SECTORS)
+            .discard_granularity(PAGE_SIZE as u32)
+            .build(fmt!("{}", name.to_str()?), tagset, storage)
+    }
+}
+
+/// A flat array of page slots, one per page of the device.
+///
+/// Each slot is either null or holds a pointer obtained from
+/// [`Page::into_raw`], i.e. owns one reference to that page.
+struct PageArray(KVVec<Atomic<*mut bindings::page>>);
+
+impl PageArray {
+    fn new(nr_pages: usize) -> Result<Self> {
+        let mut slots = KVVec::with_capacity(nr_pages, GFP_KERNEL)?;
+        for _ in 0..nr_pages {
+            // Cannot fail: the capacity was reserved above.
+            slots.push(Atomic::new(ptr::null_mut()), GFP_KERNEL)?;
+        }
+        Ok(Self(slots))
+    }
+
+    fn slot(&self, index: usize) -> Option<&Atomic<*mut bindings::page>> {
+        self.0.get(index)
+    }
+}
+
+impl Drop for PageArray {
+    fn drop(&mut self) {
+        for slot in self.0.iter() {
+            if let Some(ptr) = NonNull::new(slot.xchg(ptr::null_mut(), Relaxed)) {
+                // SAFETY: Non-null slots hold pointers from `Page::into_raw`
+                // and own the reference they stand for, which we take back.
+                drop(unsafe { Page::from_raw(ptr) });
+            }
+        }
+    }
+}
+
+/// The backing store of a RAM disk.
+///
+/// Slot `n` of `pages` holds the page for bytes `n * PAGE_SIZE .. (n + 1) *
+/// PAGE_SIZE` of the device, or null if it was never written or since
+/// discarded.
+///
+/// The slot array is allocated up front and lives as long as the device, so,
+/// unlike the nodes of an XArray, it never needs RCU protection, and no lock is
+/// taken to look up, insert or remove a page: [`Self::lookup_page`] is an
+/// atomic load followed by a speculative reference (see [`Page::try_get_raw`]),
+/// [`Self::try_insert_page`] a compare-and-exchange on an empty slot, and
+/// [`Self::discard`] an exchange with null. The price is 8 bytes of slot per
+/// page of capacity, whether or not it is ever written.
+///
+/// Rust's raw page access requires that a page is not read and written, or
+/// written twice, concurrently, a guarantee the C `brd` driver does not itself
+/// provide for overlapping I/O. A bit spinlock in `page->private` of each
+/// backing page provides it here (see [`Storage::lock_copy`]). It is held only
+/// for the duration of a single copy, never while looking up, allocating or
+/// removing a page.
+#[pin_data]
+struct Storage {
+    pages: PageArray,
+}
+
+/// The bit of `page->private` that serializes copies to and from a backing
+/// page.
+const PAGE_COPY_LOCK_BIT: u32 = 0;
+
+impl Storage {
+    /// Locks the copy lock of a backing page.
+    fn lock_copy(page: &Page) -> PagePrivateBitGuard<'_, PAGE_COPY_LOCK_BIT> {
+        // SAFETY: Backing pages are allocated by this driver with
+        // `Page::alloc_page` and never handed to anybody else, and their
+        // `private` field is only used for this lock.
+        unsafe { page.lock_private_bit::<PAGE_COPY_LOCK_BIT>() }
+    }
+
+    fn new(nr_pages: usize) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            pages: PageArray::new(nr_pages)?,
+        })
+    }
+
+    /// Looks up the page for `index`, without taking any lock.
+    ///
+    /// Takes a reference on the page in the slot with an operation that fails
+    /// if the page's reference count has already reached zero, i.e. if a
+    /// concurrent [`Self::discard`] already released it, and then re-reads the
+    /// slot to confirm it still holds the same page, retrying otherwise:
+    /// without that check, a page that was concurrently discarded and whose
+    /// memory was reused for something else in the meantime could be mistaken
+    /// for one that is still ours. See [`Page::try_get_raw`] for more on why
+    /// this is safe.
+    fn lookup_page(&self, index: usize) -> Option<Page> {
+        let slot = self.pages.slot(index)?;
+
+        loop {
+            let ptr = NonNull::new(slot.load(Acquire))?;
+
+            // SAFETY: Every non-null pointer stored in a slot came from
+            // `Page::into_raw`, i.e. is a `struct page` pointer; `struct page`
+            // objects are never freed or reused for anything else, so `ptr`
+            // always points at a valid one, whether or not it is (still)
+            // actually owned by this slot.
+            let Some(page) = (unsafe { Page::try_get_raw(ptr) }) else {
+                // The page's last reference was already dropped concurrently.
+                return None;
+            };
+
+            if slot.load(Relaxed) == ptr.as_ptr() {
+                return Some(page);
+            }
+
+            // The slot was concurrently emptied, or now holds a different
+            // page; `page` is not (or no longer) ours to use. Drop our
+            // reference and retry.
+            drop(page);
+        }
+    }
+
+    /// Allocates a page and installs it at `index` if the slot is still empty.
+    ///
+    /// Returns `None` if another writer installed a page there first, in which
+    /// case the caller looks it up again.
+    fn try_insert_page(&self, index: usize) -> Result<Option<Page>> {
+        let slot = self.pages.slot(index).ok_or(EIO)?;
+        let page = Page::alloc_page(io_gfp() | __GFP_ZERO | __GFP_HIGHMEM)?;
+        // Take our own reference before handing ownership of `page` to the
+        // slot, which keeps the other one.
+        let ours = page.get();
+        let ptr = page.into_raw();
+
+        // `Full` ordering publishes the zeroed page contents along with the
+        // pointer, pairing with the `Acquire` load in `lookup_page()`.
+        if slot.cmpxchg(ptr::null_mut(), ptr.as_ptr(), Full).is_ok() {
+            return Ok(Some(ours));
+        }
+
+        drop(ours);
+        // SAFETY: `ptr` came from `into_raw` above and was not stored, so we
+        // still own the reference it stands for.
+        drop(unsafe { Page::from_raw(ptr) });
+        Ok(None)
+    }
+
+    /// Transfer all data of `rq` between the request buffers and the backing
+    /// store.
+    fn transfer(&self, rq: &mq::Request<RamDisk>, write: bool) -> Result {
+        for bio in rq.bio_iter() {
+            for segment in bio.segment_iter() {
+                self.transfer_segment(&segment, write)?;
+            }
+        }
+        Ok(())
+    }
+
+    /// Transfer one segment, splitting it where it crosses a page boundary of
+    /// the backing store.
+    fn transfer_segment(&self, segment: &Segment<'_>, write: bool) -> Result {
+        let start = segment.sector() << block::SECTOR_SHIFT;
+        let mut done = 0;
+
+        // The block layer never issues I/O beyond the capacity of the device,
+        // which the array covers in full; check it once per segment.
+        if !segment.is_empty() {
+            let last = (start + segment.len() as u64 - 1) >> PAGE_SHIFT;
+            if usize::try_from(last)? >= self.pages.0.len() {
+                return Err(EIO);
+            }
+        }
+
+        while done < segment.len() {
+            let pos = start + done as u64;
+            let index = usize::try_from(pos >> PAGE_SHIFT)?;
+            let page_off = (pos as usize) & (PAGE_SIZE - 1);
+            let len = (segment.len() - done).min(PAGE_SIZE - page_off);
+
+            if write {
+                self.write_chunk(segment, done, index, page_off, len)?;
+            } else {
+                self.read_chunk(segment, done, index, page_off, len)?;
+            }
+
+            done += len;
+        }
+
+        Ok(())
+    }
+
+    fn read_chunk(
+        &self,
+        segment: &Segment<'_>,
+        off: usize,
+        index: usize,
+        page_off: usize,
+        len: usize,
+    ) -> Result {
+        match self.lookup_page(index) {
+            Some(page) => {
+                let _guard = Self::lock_copy(&page);
+                // SAFETY: the page's copy lock rules out a concurrent write to
+                // it.
+                unsafe { segment.copy_from_page(off, &page, page_off, len) }
+            }
+            // Never written; reads as zeroes.
+            None => segment.zero(off, len),
+        }
+    }
+
+    fn write_chunk(
+        &self,
+        segment: &Segment<'_>,
+        off: usize,
+        index: usize,
+        page_off: usize,
+        len: usize,
+    ) -> Result {
+        let page = loop {
+            if let Some(page) = self.lookup_page(index) {
+                break page;
+            }
+            if let Some(page) = self.try_insert_page(index)? {
+                break page;
+            }
+        };
+
+        let _guard = Self::lock_copy(&page);
+        // SAFETY: the page's copy lock rules out a concurrent read or write to
+        // it.
+        unsafe { segment.copy_to_page(off, &page, page_off, len) }
+    }
+
+    /// Free all backing pages that are entirely covered by the range.
+    fn discard(&self, sector: u64, bytes: u32) {
+        let start = sector << block::SECTOR_SHIFT;
+        let end = start + u64::from(bytes);
+        let first = start.div_ceil(PAGE_SIZE as u64);
+        let last = end >> PAGE_SHIFT;
+
+        for index in first..last {
+            let Some(slot) = usize::try_from(index)
+                .ok()
+                .and_then(|index| self.pages.0.get(index))
+            else {
+                break;
+            };
+
+            if let Some(ptr) = NonNull::new(slot.xchg(ptr::null_mut(), Full)) {
+                // SAFETY: Non-null slots hold pointers from `Page::into_raw`
+                // and own the reference they stand for, which we just took
+                // back by emptying the slot. A concurrent `lookup_page()` that
+                // already took its own reference keeps the page alive until
+                // that reference is dropped too.
+                drop(unsafe { Page::from_raw(ptr) });
+            }
+        }
+    }
+}
+
+#[vtable]
+impl Operations for RamDisk {
+    type QueueData = Pin<KBox<Storage>>;
+
+    fn queue_rq(storage: Pin<&Storage>, rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
+        // On error, `rq` is dropped and the error is returned to the block
+        // layer, which ends the request. `ENOMEM` from a failed page allocation
+        // becomes `BLK_STS_RESOURCE`, which makes the block layer retry the
+        // request later. Retrying is safe, since every transfer is idempotent.
+        match rq.command() {
+            Command::Read => storage.transfer(&rq, false)?,
+            Command::Write => storage.transfer(&rq, true)?,
+            Command::Discard => storage.discard(rq.sector(), rq.bytes()),
+            // There is no volatile cache; data is in RAM once written.
+            Command::Flush => {}
+            Command::WriteZeroes | Command::Other(_) => return Err(EOPNOTSUPP),
+        }
+
+        mq::Request::end_ok(rq)
+            .map_err(|_e| kernel::error::code::EIO)
+            // We take no refcounts on the request, so we expect to be able to
+            // end the request. The request reference must be unique at this
+            // point, and so `end_ok` cannot fail.
+            .expect("Fatal error - expected to be able to end request");
+
+        Ok(())
+    }
+
+    fn commit_rqs(_storage: Pin<&Storage>) {}
+
+    fn complete(_rq: ARef<mq::Request<Self>>) {
+        // All requests are completed synchronously in `queue_rq`.
+    }
+}
-- 
2.39.5

