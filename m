Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AD2D94BE;
	Sun, 15 Feb 2026 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198953; cv=none; b=QUGReWhcnV3Cxr7rFscaWMo3P3VMcIoeaihGrxRY5lyV8xK7dPoLkveOtBnRBfnRv3mlr2Yo6JLpnNKhv9U9TM804z38bbtIW1DqQsiwNAPDs9EldFWLDXozBRCenQXeIkfRnjb6wsnCTdBJjs/6fFFv2tLYi3PQDTCz0T1gW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198953; c=relaxed/simple;
	bh=ZBT3g2yxwr2ga5MlCDT4cJc5rd6AoVQ9CyP5UJLr7JY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSkmRB9niKNZutB+V+ITW322IlefuETSSKVmu+DsXlx/OKtGrSq0k0+xVjGrrB8SRbi1NY2sljZNvajtrBYNPqzeyGGJzPiwrfIRmIjI4Zm2Kl2WvqyiGd9h4uoyTvF3sJQK2qmQ1u9tdPd6gx0Ar/7u0AunKcZh33+HUe3si/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ0LJSHO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ0LJSHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBDCC19422;
	Sun, 15 Feb 2026 23:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198953;
	bh=ZBT3g2yxwr2ga5MlCDT4cJc5rd6AoVQ9CyP5UJLr7JY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oQ0LJSHOI5yscAmkUVG++3cAQSWRAceqv3D0uq2h4/A0ND+d+Vay35uo/6D8Nhd6t
	 Kzr1zb85rkn8P/78LpvGZ59R4GfHdtt3COdBcJEYKIr7lRH4bRoIKWw+fymLavNP3q
	 SBtVcCVRmM1yfS7oBEqzJe77DVBax4bkBD6j2pITc/rOXCSZ1qH1STZdMsBJNZV+OG
	 yXnGajUfOZZ7QyYxYwN6FUzK9Vjj63nHRv3vcVqya/h5YfvC3g/PWL7l2ZdE2XLJwd
	 h9KR3R+ehhy5DQU9iIce96EAr3JH88izhhVM63PLazxU4ndAAPzn3uOjCSAVGobvf2
	 oevjZEmirz1wA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:34:50 +0100
Subject: [PATCH 03/79] block: rnull: add macros to define configfs
 attributes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-3-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10210;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=ZBT3g2yxwr2ga5MlCDT4cJc5rd6AoVQ9CyP5UJLr7JY=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgeSt5Gpp+/cjlALcsKqnCvx2CtOLaSgTmuZ
 5S1M+PAvxKJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYHgAKCRDhuBo+eShj
 dxG0EACwY4lNl7HxgkSgg52iQKuudaW+KKtUEtLbOPnjN4vwDRaW5/rzgKREi8+8L4Hn5i/pRaE
 aLRUmsG035uMlSrRwgqucvAmHDuETFlxewsvaN7bHlDpPIc69KG7I6dqME4ApI99615IFir39Il
 US4j/8i7YXr6fLC7NRBJwm0YG31P22xqc/oHntGgoG8zFsyiUbOp3AnMBP/2ffB1zdwLTVDNDGp
 zcFP3+yr7euceudcVIoeVJkw74154p/lEI8rerssardEivgs7WsVg5nDpvSJO3elWw2ZSyCP/u0
 v/XB3MuW+tuiYWeJl4ZQdSwQecBB4T5lirjtCUR87ijjFr4U7gV+0uzyEf4htnzdnOY3LzVkxxX
 +UDQYhjIA3VI5xFOLVe9lA9vmGmpgVXANMzhsaqH10mf4qx/EeqxFqFPDUskqY2caxftq7KxGQK
 mvVrfajabD6Bsbpoe19hmDSh1GG5dQ0AZwVDTGVLQt5Yhgrx6jhCDqV8tfHRV88+vj6++g1QAOy
 5AGIXTLcyWlLBc57zWrNCWZKLv2ZFE1hewbPQQhGbMmvmBmzAtSA6EVXeBEtZrgKGzGNu73fCGb
 /GXzLK6AF3F/BfkVnOcRSln/2rPEyETi0aqJoa8EPiCrGY7UEoJuwxs0SkRb93ZhKRRxCoqTEcJ
 fIvQw9h7rLuyy/Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Defining configfs attributes in rust is a bit verbose at the moment. Add
some macros to make the attribute definition less verbose.

The configfs Rust abstractions should eventually provide procedural macros
for this task. When we get more users of the configfs Rust abstractions, we
shall consider this task.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs        | 134 +++++++++------------------------
 drivers/block/rnull/configfs/macros.rs | 128 +++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+), 98 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index ea38b27a9011c..eafa71dfc40d3 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,20 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use super::{NullBlkDevice, THIS_MODULE};
+use super::{
+    NullBlkDevice,
+    THIS_MODULE, //
+};
 use kernel::{
-    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
+    block::mq::gen_disk::{
+        GenDisk,
+        GenDiskBuilder, //
+    },
     c_str,
-    configfs::{self, AttributeOperations},
+    configfs::{
+        self,
+        AttributeOperations, //
+    },
     configfs_attrs,
-    fmt::{self, Write as _},
+    fmt::{
+        self,
+        Write as _, //
+    },
     new_mutex,
     page::PAGE_SIZE,
     prelude::*,
-    str::{kstrtobool_bytes, CString},
-    sync::Mutex,
+    str::{
+        kstrtobool_bytes,
+        CString, //
+    },
+    sync::Mutex, //
+};
+use macros::{
+    configfs_simple_bool_field,
+    configfs_simple_field, //
 };
 use pin_init::PinInit;
 
+mod macros;
+
 pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsystem<Config>, Error> {
     let item_type = configfs_attrs! {
         container: configfs::Subsystem<Config>,
@@ -166,99 +187,16 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
     }
 }
 
-#[vtable]
-impl configfs::AttributeOperations<1> for DeviceConfig {
-    type Data = DeviceConfig;
-
-    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
-        let mut writer = kernel::str::Formatter::new(page);
-        writer.write_fmt(fmt!("{}\n", this.data.lock().block_size))?;
-        Ok(writer.bytes_written())
-    }
-
-    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
-            return Err(EBUSY);
-        }
-
-        let text = core::str::from_utf8(page)?.trim();
-        let value = text.parse::<u32>().map_err(|_| EINVAL)?;
-
-        GenDiskBuilder::validate_block_size(value)?;
-        this.data.lock().block_size = value;
-        Ok(())
-    }
-}
-
-#[vtable]
-impl configfs::AttributeOperations<2> for DeviceConfig {
-    type Data = DeviceConfig;
-
-    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
-        let mut writer = kernel::str::Formatter::new(page);
-
-        if this.data.lock().rotational {
-            writer.write_str("1\n")?;
-        } else {
-            writer.write_str("0\n")?;
-        }
-
-        Ok(writer.bytes_written())
-    }
-
-    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
-            return Err(EBUSY);
-        }
-
-        this.data.lock().rotational = kstrtobool_bytes(page)?;
-
-        Ok(())
-    }
-}
-
-#[vtable]
-impl configfs::AttributeOperations<3> for DeviceConfig {
-    type Data = DeviceConfig;
-
-    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
-        let mut writer = kernel::str::Formatter::new(page);
-        writer.write_fmt(fmt!("{}\n", this.data.lock().capacity_mib))?;
-        Ok(writer.bytes_written())
-    }
-
-    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
-            return Err(EBUSY);
-        }
-
-        let text = core::str::from_utf8(page)?.trim();
-        let value = text.parse::<u64>().map_err(|_| EINVAL)?;
-
-        this.data.lock().capacity_mib = value;
-        Ok(())
-    }
-}
-
-#[vtable]
-impl configfs::AttributeOperations<4> for DeviceConfig {
-    type Data = DeviceConfig;
-
-    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
-        let mut writer = kernel::str::Formatter::new(page);
-        writer.write_fmt(fmt!("{}\n", this.data.lock().irq_mode))?;
-        Ok(writer.bytes_written())
-    }
+configfs_simple_field!(DeviceConfig, 1, block_size, u32, check GenDiskBuilder::validate_block_size);
+configfs_simple_bool_field!(DeviceConfig, 2, rotational);
+configfs_simple_field!(DeviceConfig, 3, capacity_mib, u64);
+configfs_simple_field!(DeviceConfig, 4, irq_mode, IRQMode);
 
-    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
-            return Err(EBUSY);
-        }
+impl core::str::FromStr for IRQMode {
+    type Err = Error;
 
-        let text = core::str::from_utf8(page)?.trim();
-        let value = text.parse::<u8>().map_err(|_| EINVAL)?;
-
-        this.data.lock().irq_mode = IRQMode::try_from(value)?;
-        Ok(())
+    fn from_str(s: &str) -> Result<Self> {
+        let value: u8 = s.parse().map_err(|_| EINVAL)?;
+        value.try_into()
     }
 }
diff --git a/drivers/block/rnull/configfs/macros.rs b/drivers/block/rnull/configfs/macros.rs
new file mode 100644
index 0000000000000..53ce9d5dbdc8a
--- /dev/null
+++ b/drivers/block/rnull/configfs/macros.rs
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::DeviceConfig;
+use core::{fmt::Write, str::FromStr};
+use kernel::{page::PAGE_SIZE, prelude::*};
+
+pub(crate) fn show_field<T: fmt::Display>(value: T, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+    let mut writer = kernel::str::Formatter::new(page);
+    writer.write_fmt(fmt!("{}\n", value))?;
+    Ok(writer.bytes_written())
+}
+
+pub(crate) fn store_with_power_check<F>(this: &DeviceConfig, page: &[u8], store_fn: F) -> Result
+where
+    F: FnOnce(&DeviceConfig, &[u8]) -> Result,
+{
+    if this.data.lock().powered {
+        return Err(EBUSY);
+    }
+    store_fn(this, page)
+}
+
+pub(crate) fn store_number_with_power_check<F, T>(
+    this: &DeviceConfig,
+    page: &[u8],
+    store_fn: F,
+) -> Result
+where
+    F: FnOnce(&DeviceConfig, T) -> Result,
+    T: FromStr,
+{
+    if this.data.lock().powered {
+        return Err(EBUSY);
+    }
+
+    let text = core::str::from_utf8(page)?.trim();
+    let value = text.parse::<T>().map_err(|_| EINVAL)?;
+
+    store_fn(this, value)
+}
+
+macro_rules! configfs_attribute {
+    (
+        $type:ty,
+        $id:literal,
+        show: |$show_this:ident, $show_page:ident| $show_block:expr,
+        store: |$store_this:ident, $store_page:ident| $store_block:expr
+        $(,)?
+    ) => {
+        #[vtable]
+        impl configfs::AttributeOperations<$id> for $type {
+            type Data = $type;
+
+            fn show($show_this: &$type, $show_page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+                $show_block
+            }
+
+            fn store($store_this: &$type, $store_page: &[u8]) -> Result {
+                $store_block
+            }
+        }
+    };
+}
+pub(crate) use configfs_attribute;
+
+// Specialized macro for simple boolean fields that just store kstrtobool_bytes result.
+macro_rules! configfs_simple_bool_field {
+    ($type:ty, $id:literal, $field:ident) => {
+        crate::configfs::macros::configfs_attribute!($type, $id,
+            show: |this, page| crate::configfs::macros::show_field(this.data.lock().$field, page),
+            store: |this, page|
+              crate::configfs::macros::store_with_power_check(this, page, |this, page| {
+                this.data.lock().$field = kstrtobool_bytes(page)?;
+                Ok(())
+            })
+        );
+    };
+}
+pub(crate) use configfs_simple_bool_field;
+
+// Specialized macro for simple numeric fields that just parse and assign
+macro_rules! configfs_simple_field {
+    // Simple direct assignment
+    ($type:ty, $id:literal, $field:ident, $field_type:ty) => {
+        crate::configfs::macros::configfs_attribute!($type, $id,
+            show: |this, page| crate::configfs::macros::show_field(this.data.lock().$field, page),
+            store: |this, page| crate::configfs::macros::store_number_with_power_check(
+                this,
+                page,
+                |this, value: $field_type| {
+                    this.data.lock().$field = value;
+                    Ok(())
+                }
+            )
+        );
+    };
+    // With infallible conversion expression (direct value)
+    ($type:ty, $id:literal, $field:ident, $field_type:ty, into $convert:expr) => {
+        crate::configfs::macros::configfs_attribute!($type, $id,
+            show: |this, page|
+                crate::configfs::macros::show_field(this.data.lock().$field, page),
+            store: |this, page| crate::configfs::macros::store_number_with_power_check(
+                this,
+                page,
+                |this, value: $field_type| {
+                    this.data.lock().$field = $convert(value);
+                    Ok(())
+                }
+            )
+        );
+    };
+    // With check, no conversion
+    ($type:ty, $id:literal, $field:ident, $field_type:ty, check $check:expr) => {
+        crate::configfs::macros::configfs_attribute!($type, $id,
+            show: |this, page| crate::configfs::macros::show_field(this.data.lock().$field, page),
+            store: |this, page| crate::configfs::macros::store_number_with_power_check(
+                this,
+                page,
+                |this, value: $field_type| {
+                    $check(value)?;
+                    this.data.lock().$field = value;
+                    Ok(())
+                }
+            )
+        );
+    };
+}
+pub(crate) use configfs_simple_field;

-- 
2.51.2


