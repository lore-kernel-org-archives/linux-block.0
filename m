Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28E178374
	for <linux-block@vger.kernel.org>; Tue, 11 Jun 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106371; cv=none; b=LQElqtHMvSoeDaVdeAXBrNEhlA5b3aVt/ex7/N/6tuUJSjpCw8y39wDJVH2rg0QckshqgEw1Kd+K/1gNakEH2EixmgKZcM2FT/+d6Xeb/aL2PFVNM0fpuANpbovF3BqACP88yrB+H6V5b97xEevTmXGY2BZmNUFPat1QNijLeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106371; c=relaxed/simple;
	bh=MjLNIBTvGs14XFCLVDVzSsokBqfcDSCFocRqLi9UH6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxQX1Xa5laqGepWDkjOj9loe09l6rdJaP0itXtVngM06LjEXLHmS4HB8Je9XIe/CJo2m0RgGsdN4ZbsfIOrLFQxUW7frRbxH/muM0L3MN9hLTu+6U1pW+fMqur5HC9zk5c32HJNl+QZI4wb+iWGtoEFNXvUoIbE6aeqvXvN9scA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=3auIKog8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="3auIKog8"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c7440876bso1235093a12.0
        for <linux-block@vger.kernel.org>; Tue, 11 Jun 2024 04:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1718106366; x=1718711166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oWxOyphmclJd0VuSTwITcsS6WTDGONtYxmKyn/8PNU=;
        b=3auIKog8GkWceUeiYZZpHpa40wLpBlvhhRNK1OEojFuybGOl7/8+5Gs1lnO9Q/uTzz
         Ow4LeBFE3GKWvTHVuxGrypbjAGaGCawO5y8RnBvLuVX/WcV1IqFe1JreoDOfZnh9U2d+
         FS3g9uUiIFMk6u2mOm+NqidANpPkLTh6RDSlUGgCHiHBvNQ5CpPd6ENrkWwxJIG5eICq
         Pvq91tFHiYHGQTrdl/i3vup1rC36bgRW84K4BdwmxBbPPOYqimK6T22fe7d+tIsZnUXb
         nl8naqjZYZG2S2D+42hRBELWqalJtCysfvWJ4PGULQxpXHAbUqLuFg5PzMW6s4NOa9C7
         f2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106366; x=1718711166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oWxOyphmclJd0VuSTwITcsS6WTDGONtYxmKyn/8PNU=;
        b=MKuhEfWvswEPTd5i847PhDwIA2vByzA1BEbOC7IaK4NwreKKrXGRUruPFtYnyPj+MI
         JVcbrAwGWKZsQ2YgXEpl8r+UrcMgy5avxJNNyAVuHqfGpDJlMsUxN1o6/cOORZuBA5/e
         C1OKl0asQLfGzP6Y7Sa7M+SKb4u3DGElXtamhX5aBlHNJC1Q+RDg4KHeWIfNokBnPTx1
         M0YO+KF5GOP+NE6E6iHhtrNh30WtRCTquubaDkPyqBotE4i/5QMPPxvQtUvnTlM0czFq
         e83K1SCZTRGocru24tQr1pN+VhTzbwfjjWqXDd8inA93pIOPlLCqgHXrdVCSEPUnnvES
         RkNA==
X-Forwarded-Encrypted: i=1; AJvYcCXPwEsxx5tyhd4d/b+XqjAROZURHBme/OVPIy7bMtrXTm6mPeJdbl4tRn9sgdzzc20j4EEG0xU0gB+awGK33zcVEq4V0BVNcVcL0MI=
X-Gm-Message-State: AOJu0Yxl3EwpA7WpVZQpemA0TVWoEYK4hT27sUvFxLyn4SmOlxLYXxCJ
	UIqN59GIKtr4JXpGxpSJBTEftr2mHzJOawRrhJpiS3+9gTlHU//v8CpjBM6QPwc=
X-Google-Smtp-Source: AGHT+IEP7USEquzebFShJ6nlse0PX36I/St/mpHzkzcNj9IJ3/LGTrI4xRRDlNw9BuMib5IpvrNhvA==
X-Received: by 2002:a17:906:354f:b0:a6e:ff2f:8780 with SMTP id a640c23a62f3a-a6eff2f890fmr660647666b.36.1718106364997;
        Tue, 11 Jun 2024 04:46:04 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef8bddd6bsm499883466b.87.2024.06.11.04.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:46:04 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: [PATCH v6 1/3] rust: block: introduce `kernel::block::mq` module
Date: Tue, 11 Jun 2024 13:45:49 +0200
Message-ID: <20240611114551.228679-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611114551.228679-1-nmi@metaspace.dk>
References: <20240611114551.228679-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=42988; i=a.hindborg@samsung.com;
 h=from:subject; bh=exW9FmT4MWkjt1Vkc0EMLndZ+9Uqaoi1D2LHHJbjpiA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR1pvTnJwdE9HbUZZRzZJMW1rU05Jb3g2dFlRClR3Z0pmY1NJY0luNHI3eHd6
 eGE0Rm9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbWFEYTZ
 BQW9KRU9HNEdqNTVLR04zbTM4UC9SenFLVEtWQXlQQkNmczFoWDNJWGNjeVZxWnp0eGFOS3hLdQ
 piVGR4OGFmcEgwSDRiSE9FMGRQM3FlTTJTUnJlYUtuY3Jidm1ZRm5BSVlqcmg1SGFONU1lNEZiS
 mhuNU1vSWVJCitOcVlFaE4xRGZ0NWd0ODJQMHh0a0t5UllkOFh1NWp2Tm51dTI0REJZcm9Bc1lv
 MzdCajJyaGpia09mcEFDQTgKWFMyaThVN2cwVVVKQTlWenozZDkySG1TL2pCWXEwTHhHWm9idkF
 VcnBXbDB6WXhsWmRXL1JkYkd3a1ZCUitBQgo1ZTg0WWFlbHVLL2libFFIZE5KNlhDb0hjRVBacF
 NxanZMUU1rNUxxL0hiQU8wdlhhWUxsY0hzZ285bmphUTFNClM1L3k4bE5yU3M0NXhTU0dISWllR
 0RweUU0Y2QybzFlTFdiZXg0aVF6T2Z1cEtlUS91TGhLKzdNVXA4NjYrSloKeUlZL0NkVnRVY2w0
 MmFmOTdEbkU1amVMWFJYbW5DWnl0MHk0K25tUVNMTTUzMkNvM1BONmx6dVBBWTdrbDkrTQo3Zjl
 Zb1RFZ0RwSTNGT2pocmpnMXlwRUFKR0s4MklYODIwS2FkQWJiVmY0am5vY2NSTk1IVWdyKzJFSF
 lxZjE1CitpZVpxQ3NidTlqay85WVYzRzQ3UkZMZUs3OEllWDJRMmR4TktVeTN4MFB2anBvYTBmO
 GtWbUx4ZlhoY0RSUnoKbmxHeUhlcEk3Zk9NVG9lR1NXcFJVdDJRWkgvd1llZkMxT3pQL1VDdGxl
 VE1TQ1M0cVZlb3ZXYzF6VTJXWjFlbQpNcEM0Zll5UDJxQmIzTVlzOU5yYkRzMUVvcCtrRkZkQ0t
 xdDVDdnE0Q21qVDBXeUh5MGZKWHFBS1Uzek1FVllmCjlNSzB0S0NhMStFMWRnPT0KPVhpeWkKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@samsung.com; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Add initial abstractions for working with blk-mq.

This patch is a maintained, refactored subset of code originally published
by Wedson Almeida Filho <wedsonaf@gmail.com> [1].

[1] https://github.com/wedsonaf/linux/tree/f2cfd2fe0e2ca4e90994f96afe268bbd4382a891/rust/kernel/blk/mq.rs

Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/bindings/bindings_helper.h    |   3 +
 rust/helpers.c                     |  16 ++
 rust/kernel/block.rs               |   5 +
 rust/kernel/block/mq.rs            |  98 +++++++++++
 rust/kernel/block/mq/gen_disk.rs   | 215 ++++++++++++++++++++++++
 rust/kernel/block/mq/operations.rs | 245 ++++++++++++++++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  55 +++++++
 rust/kernel/block/mq/request.rs    | 253 +++++++++++++++++++++++++++++
 rust/kernel/block/mq/tag_set.rs    |  86 ++++++++++
 rust/kernel/error.rs               |   6 +
 rust/kernel/lib.rs                 |   2 +
 11 files changed, 984 insertions(+)
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ddb5644d4fd9..84f601d7068e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,8 @@
  */
 
 #include <kunit/test.h>
+#include <linux/blk_types.h>
+#include <linux/blk-mq.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/jiffies.h>
@@ -20,6 +22,7 @@
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
+const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
 const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
diff --git a/rust/helpers.c b/rust/helpers.c
index 2c37a0f5d7a8..3df5217fb2ff 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -186,3 +186,19 @@ static_assert(
 	__alignof__(size_t) == __alignof__(uintptr_t),
 	"Rust code expects C `size_t` to match Rust `usize`"
 );
+
+// This will soon be moved to a separate file, so no need to merge with above.
+#include <linux/blk-mq.h>
+#include <linux/blkdev.h>
+
+void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
+{
+	return blk_mq_rq_to_pdu(rq);
+}
+EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_to_pdu);
+
+struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
+{
+	return blk_mq_rq_from_pdu(pdu);
+}
+EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_from_pdu);
diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
new file mode 100644
index 000000000000..150f710efe5b
--- /dev/null
+++ b/rust/kernel/block.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for working with the block layer.
+
+pub mod mq;
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
new file mode 100644
index 000000000000..fb0f393c1cea
--- /dev/null
+++ b/rust/kernel/block/mq.rs
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides types for implementing block drivers that interface the
+//! blk-mq subsystem.
+//!
+//! To implement a block device driver, a Rust module must do the following:
+//!
+//! - Implement [`Operations`] for a type `T`.
+//! - Create a [`TagSet<T>`].
+//! - Create a [`GenDisk<T>`], via the [`GenDiskBuilder`].
+//! - Add the disk to the system by calling [`GenDiskBuilder::build`] passing in
+//!   the `TagSet` reference.
+//!
+//! The types available in this module that have direct C counterparts are:
+//!
+//! - The [`TagSet`] type that abstracts the C type `struct tag_set`.
+//! - The [`GenDisk`] type that abstracts the C type `struct gendisk`.
+//! - The [`Request`] type that abstracts the C type `struct request`.
+//!
+//! The kernel will interface with the block device driver by calling the method
+//! implementations of the `Operations` trait.
+//!
+//! IO requests are passed to the driver as [`kernel::types::ARef<Request>`]
+//! instances. The `Request` type is a wrapper around the C `struct request`.
+//! The driver must mark end of processing by calling one of the
+//! `Request::end`, methods. Failure to do so can lead to deadlock or timeout
+//! errors. Please note that the C function `blk_mq_start_request` is implicitly
+//! called when the request is queued with the driver.
+//!
+//! The `TagSet` is responsible for creating and maintaining a mapping between
+//! `Request`s and integer ids as well as carrying a pointer to the vtable
+//! generated by `Operations`. This mapping is useful for associating
+//! completions from hardware with the correct `Request` instance. The `TagSet`
+//! determines the maximum queue depth by setting the number of `Request`
+//! instances available to the driver, and it determines the number of queues to
+//! instantiate for the driver. If possible, a driver should allocate one queue
+//! per core, to keep queue data local to a core.
+//!
+//! One `TagSet` instance can be shared between multiple `GenDisk` instances.
+//! This can be useful when implementing drivers where one piece of hardware
+//! with one set of IO resources are represented to the user as multiple disks.
+//!
+//! One significant difference between block device drivers implemented with
+//! these Rust abstractions and drivers implemented in C, is that the Rust
+//! drivers have to own a reference count on the `Request` type when the IO is
+//! in flight. This is to ensure that the C `struct request` instances backing
+//! the Rust `Request` instances are live while the Rust driver holds a
+//! reference to the `Request`. In addition, the conversion of an integer tag to
+//! a `Request` via the `TagSet` would not be sound without this bookkeeping.
+//!
+//! [`GenDisk`]: gen_disk::GenDisk
+//! [`GenDisk<T>`]: gen_disk::GenDisk
+//! [`GenDiskBuilder`]: gen_disk::GenDiskBuilder
+//! [`GenDiskBuilder::build`]: gen_disk::GenDiskBuilder::build
+//!
+//! # Example
+//!
+//! ```rust
+//! use kernel::{
+//!     alloc::flags,
+//!     block::mq::*,
+//!     new_mutex,
+//!     prelude::*,
+//!     sync::{Arc, Mutex},
+//!     types::{ARef, ForeignOwnable},
+//! };
+//!
+//! struct MyBlkDevice;
+//!
+//! #[vtable]
+//! impl Operations for MyBlkDevice {
+//!
+//!     fn queue_rq(rq: ARef<Request<Self>>, _is_last: bool) -> Result {
+//!         Request::end_ok(rq);
+//!         Ok(())
+//!     }
+//!
+//!     fn commit_rqs() {}
+//! }
+//!
+//! let tagset: Arc<TagSet<MyBlkDevice>> =
+//!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
+//! let mut disk = gen_disk::GenDiskBuilder::new()
+//!     .capacity_sectors(4096)
+//!     .build(format_args!("myblk"), tagset)?;
+//!
+//! # Ok::<(), kernel::error::Error>(())
+//! ```
+
+pub mod gen_disk;
+mod operations;
+mod raw_writer;
+mod request;
+mod tag_set;
+
+pub use operations::Operations;
+pub use request::Request;
+pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
new file mode 100644
index 000000000000..3b9edb96c8ff
--- /dev/null
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic disk abstraction.
+//!
+//! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
+//! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
+
+use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
+use crate::error;
+use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
+use core::fmt::{self, Write};
+
+/// A builder for [`GenDisk`].
+///
+/// Use this struct to configure and add new [`GenDisk`] to the VFS.
+pub struct GenDiskBuilder {
+    rotational: bool,
+    logical_block_size: u32,
+    physical_block_size: u32,
+    capacity_sectors: u64,
+}
+
+impl Default for GenDiskBuilder {
+    fn default() -> Self {
+        Self {
+            rotational: false,
+            logical_block_size: bindings::PAGE_SIZE as u32,
+            physical_block_size: bindings::PAGE_SIZE as u32,
+            capacity_sectors: 0,
+        }
+    }
+}
+
+impl GenDiskBuilder {
+    /// Create a new instance.
+    pub fn new() -> Self {
+        Self::default()
+    }
+
+    /// Set the rotational media attribute for the device to be built.
+    pub fn rotational(mut self, rotational: bool) -> Self {
+        self.rotational = rotational;
+        self
+    }
+
+    /// Validate block size by verifying that it is between 512 and `PAGE_SIZE`,
+    /// and that it is a power of two.
+    fn validate_block_size(size: u32) -> Result<()> {
+        if !(512..=bindings::PAGE_SIZE as u32).contains(&size) || !size.is_power_of_two() {
+            Err(error::code::EINVAL)
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Set the logical block size of the device to be built.
+    ///
+    /// This method will check that block size is a power of two and between 512
+    /// and 4096. If not, an error is returned and the block size is not set.
+    ///
+    /// This is the smallest unit the storage device can address. It is
+    /// typically 4096 bytes.
+    pub fn logical_block_size(mut self, block_size: u32) -> Result<Self> {
+        Self::validate_block_size(block_size)?;
+        self.logical_block_size = block_size;
+        Ok(self)
+    }
+
+    /// Set the physical block size of the device to be built.
+    ///
+    /// This method will check that block size is a power of two and between 512
+    /// and 4096. If not, an error is returned and the block size is not set.
+    ///
+    /// This is the smallest unit a physical storage device can write
+    /// atomically. It is usually the same as the logical block size but may be
+    /// bigger. One example is SATA drives with 4096 byte physical block size
+    /// that expose a 512 byte logical block size to the operating system.
+    pub fn physical_block_size(mut self, block_size: u32) -> Result<Self> {
+        Self::validate_block_size(block_size)?;
+        self.physical_block_size = block_size;
+        Ok(self)
+    }
+
+    /// Set the capacity of the device to be built, in sectors (512 bytes).
+    pub fn capacity_sectors(mut self, capacity: u64) -> Self {
+        self.capacity_sectors = capacity;
+        self
+    }
+
+    /// Build a new `GenDisk` and add it to the VFS.
+    pub fn build<T: Operations>(
+        self,
+        name: fmt::Arguments<'_>,
+        tagset: Arc<TagSet<T>>,
+    ) -> Result<GenDisk<T>> {
+        let lock_class_key = crate::sync::LockClassKey::new();
+
+        // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
+        let gendisk = from_err_ptr(unsafe {
+            bindings::__blk_mq_alloc_disk(
+                tagset.raw_tag_set(),
+                core::ptr::null_mut(), // TODO: We can pass queue limits right here
+                core::ptr::null_mut(),
+                lock_class_key.as_ptr(),
+            )
+        })?;
+
+        const TABLE: bindings::block_device_operations = bindings::block_device_operations {
+            submit_bio: None,
+            open: None,
+            release: None,
+            ioctl: None,
+            compat_ioctl: None,
+            check_events: None,
+            unlock_native_capacity: None,
+            getgeo: None,
+            set_read_only: None,
+            swap_slot_free_notify: None,
+            report_zones: None,
+            devnode: None,
+            alternative_gpt_sector: None,
+            get_unique_id: None,
+            // TODO: Set to THIS_MODULE. Waiting for const_refs_to_static feature to
+            // be merged (unstable in rustc 1.78 which is staged for linux 6.10)
+            // https://github.com/rust-lang/rust/issues/119618
+            owner: core::ptr::null_mut(),
+            pr_ops: core::ptr::null_mut(),
+            free_disk: None,
+            poll_bio: None,
+        };
+
+        // SAFETY: `gendisk` is a valid pointer as we initialized it above
+        unsafe { (*gendisk).fops = &TABLE };
+
+        let mut raw_writer = RawWriter::from_array(
+            // SAFETY: `gendisk` points to a valid and initialized instance. We
+            // have exclusive access, since the disk is not added to the VFS
+            // yet.
+            unsafe { &mut (*gendisk).disk_name },
+        )?;
+        raw_writer.write_fmt(name)?;
+        raw_writer.write_char('\0')?;
+
+        // SAFETY: `gendisk` points to a valid and initialized instance of
+        // `struct gendisk`. We have exclusive access, so we cannot race.
+        unsafe {
+            bindings::blk_queue_logical_block_size((*gendisk).queue, self.logical_block_size)
+        };
+
+        // SAFETY: `gendisk` points to a valid and initialized instance of
+        // `struct gendisk`. We have exclusive access, so we cannot race.
+        unsafe {
+            bindings::blk_queue_physical_block_size((*gendisk).queue, self.physical_block_size)
+        };
+
+        // SAFETY: `gendisk` points to a valid and initialized instance of
+        // `struct gendisk`. `set_capacity` takes a lock to synchronize this
+        // operation, so we will not race.
+        unsafe { bindings::set_capacity(gendisk, self.capacity_sectors) };
+
+        if !self.rotational {
+            // SAFETY: `gendisk` points to a valid and initialized instance of
+            // `struct gendisk`. This operation uses a relaxed atomic bit flip
+            // operation, so there is no race on this field.
+            unsafe { bindings::blk_queue_flag_set(bindings::QUEUE_FLAG_NONROT, (*gendisk).queue) };
+        } else {
+            // SAFETY: `gendisk` points to a valid and initialized instance of
+            // `struct gendisk`. This operation uses a relaxed atomic bit flip
+            // operation, so there is no race on this field.
+            unsafe {
+                bindings::blk_queue_flag_clear(bindings::QUEUE_FLAG_NONROT, (*gendisk).queue)
+            };
+        }
+
+        crate::error::to_result(
+            // SAFETY: `gendisk` points to a valid and initialized instance of
+            // `struct gendisk`.
+            unsafe {
+                bindings::device_add_disk(core::ptr::null_mut(), gendisk, core::ptr::null_mut())
+            },
+        )?;
+
+        // INVARIANT: `gendisk` was initialized above.
+        // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
+        Ok(GenDisk {
+            _tagset: tagset,
+            gendisk,
+        })
+    }
+}
+
+/// A generic block device.
+///
+/// # Invariants
+///
+///  - `gendisk` must always point to an initialized and valid `struct gendisk`.
+///  - `gendisk` was added to the VFS through a call to
+///     `bindings::device_add_disk`.
+pub struct GenDisk<T: Operations> {
+    _tagset: Arc<TagSet<T>>,
+    gendisk: *mut bindings::gendisk,
+}
+
+// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
+// `TagSet` It is safe to send this to other threads as long as T is Send.
+unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
+
+impl<T: Operations> Drop for GenDisk<T> {
+    fn drop(&mut self) {
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`, and it was previously added
+        // to the VFS.
+        unsafe { bindings::del_gendisk(self.gendisk) };
+    }
+}
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
new file mode 100644
index 000000000000..9ba7fdfeb4b2
--- /dev/null
+++ b/rust/kernel/block/mq/operations.rs
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides an interface for blk-mq drivers to implement.
+//!
+//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
+
+use crate::{
+    bindings,
+    block::mq::request::RequestDataWrapper,
+    block::mq::Request,
+    error::{from_result, Result},
+    types::ARef,
+};
+use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
+
+/// Implement this trait to interface blk-mq as block devices.
+///
+/// To implement a block device driver, implement this trait as described in the
+/// [module level documentation]. The kernel will use the implementation of the
+/// functions defined in this trait to interface a block device driver. Note:
+/// There is no need for an exit_request() implementation, because the `drop`
+/// implementation of the [`Request`] type will be invoked by automatically by
+/// the C/Rust glue logic.
+///
+/// [module level documentation]: kernel::block::mq
+#[macros::vtable]
+pub trait Operations: Sized {
+    /// Called by the kernel to queue a request with the driver. If `is_last` is
+    /// `false`, the driver is allowed to defer committing the request.
+    fn queue_rq(rq: ARef<Request<Self>>, is_last: bool) -> Result;
+
+    /// Called by the kernel to indicate that queued requests should be submitted.
+    fn commit_rqs();
+
+    /// Called by the kernel to poll the device for completed requests. Only
+    /// used for poll queues.
+    fn poll() -> bool {
+        crate::build_error(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// A vtable for blk-mq to interact with a block device driver.
+///
+/// A `bindings::blk_mq_ops` vtable is constructed from pointers to the `extern
+/// "C"` functions of this struct, exposed through the `OperationsVTable::VTABLE`.
+///
+/// For general documentation of these methods, see the kernel source
+/// documentation related to `struct blk_mq_operations` in
+/// [`include/linux/blk-mq.h`].
+///
+/// [`include/linux/blk-mq.h`]: srctree/include/linux/blk-mq.h
+pub(crate) struct OperationsVTable<T: Operations>(PhantomData<T>);
+
+impl<T: Operations> OperationsVTable<T> {
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// - The caller of this function must ensure that the pointee of `bd` is
+    ///   valid for reads for the duration of this function.
+    /// - This function must be called for an initialized and live `hctx`. That
+    ///   is, `Self::init_hctx_callback` was called and
+    ///   `Self::exit_hctx_callback()` was not yet called.
+    /// - `(*bd).rq` must point to an initialized and live `bindings:request`.
+    ///   That is, `Self::init_request_callback` was called but
+    ///   `Self::exit_request_callback` was not yet called for the request.
+    /// - `(*bd).rq` must be owned by the driver. That is, the block layer must
+    ///   promise to not access the request until the driver calls
+    ///   `bindings::blk_mq_end_request` for the request.
+    unsafe extern "C" fn queue_rq_callback(
+        _hctx: *mut bindings::blk_mq_hw_ctx,
+        bd: *const bindings::blk_mq_queue_data,
+    ) -> bindings::blk_status_t {
+        // SAFETY: `bd.rq` is valid as required by the safety requirement for
+        // this function.
+        let request = unsafe { &*(*bd).rq.cast::<Request<T>>() };
+
+        // One refcount for the ARef, one for being in flight
+        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
+
+        // SAFETY:
+        //  - We own a refcount that we took above. We pass that to `ARef`.
+        //  - By the safety requirements of this function, `request` is a valid
+        //    `struct request` and the private data is properly initialized.
+        //  - `rq` will be alive until `blk_mq_end_request` is called and is
+        //    reference counted by `ARef` until then.
+        let rq = unsafe { Request::aref_from_raw((*bd).rq) };
+
+        // SAFETY: We have exclusive access and we just set the refcount above.
+        unsafe { Request::start_unchecked(&rq) };
+
+        let ret = T::queue_rq(
+            rq,
+            // SAFETY: `bd` is valid as required by the safety requirement for
+            // this function.
+            unsafe { (*bd).last },
+        );
+
+        if let Err(e) = ret {
+            e.to_blk_status()
+        } else {
+            bindings::BLK_STS_OK as _
+        }
+    }
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure.
+    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut bindings::blk_mq_hw_ctx) {
+        T::commit_rqs()
+    }
+
+    /// This function is called by the C kernel. It is not currently
+    /// implemented, and there is no way to exercise this code path.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure.
+    unsafe extern "C" fn complete_callback(_rq: *mut bindings::request) {}
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure.
+    unsafe extern "C" fn poll_callback(
+        _hctx: *mut bindings::blk_mq_hw_ctx,
+        _iob: *mut bindings::io_comp_batch,
+    ) -> core::ffi::c_int {
+        T::poll().into()
+    }
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. This
+    /// function may only be called once before `exit_hctx_callback` is called
+    /// for the same context.
+    unsafe extern "C" fn init_hctx_callback(
+        _hctx: *mut bindings::blk_mq_hw_ctx,
+        _tagset_data: *mut core::ffi::c_void,
+        _hctx_idx: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| Ok(0))
+    }
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure.
+    unsafe extern "C" fn exit_hctx_callback(
+        _hctx: *mut bindings::blk_mq_hw_ctx,
+        _hctx_idx: core::ffi::c_uint,
+    ) {
+    }
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// - This function may only be called by blk-mq C infrastructure.
+    /// - `_set` must point to an initialized `TagSet<T>`.
+    /// - `rq` must point to an initialized `bindings::request`.
+    /// - The allocation pointed to by `rq` must be at the size of `Request`
+    ///   plus the size of `RequestDataWrapper`.
+    unsafe extern "C" fn init_request_callback(
+        _set: *mut bindings::blk_mq_tag_set,
+        rq: *mut bindings::request,
+        _hctx_idx: core::ffi::c_uint,
+        _numa_node: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: By the safety requirements of this function, `rq` points
+            // to a valid allocation.
+            let pdu = unsafe { Request::wrapper_ptr(rq.cast::<Request<T>>()) };
+
+            // SAFETY: The refcount field is allocated but not initialized, so
+            // it is valid for writes.
+            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
+
+            Ok(0)
+        })
+    }
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// - This function may only be called by blk-mq C infrastructure.
+    /// - `_set` must point to an initialized `TagSet<T>`.
+    /// - `rq` must point to an initialized and valid `Request`.
+    unsafe extern "C" fn exit_request_callback(
+        _set: *mut bindings::blk_mq_tag_set,
+        rq: *mut bindings::request,
+        _hctx_idx: core::ffi::c_uint,
+    ) {
+        // SAFETY: The tagset invariants guarantee that all requests are allocated with extra memory
+        // for the request data.
+        let pdu = unsafe { bindings::blk_mq_rq_to_pdu(rq) }.cast::<RequestDataWrapper>();
+
+        // SAFETY: `pdu` is valid for read and write and is properly initialised.
+        unsafe { core::ptr::drop_in_place(pdu) };
+    }
+
+    const VTABLE: bindings::blk_mq_ops = bindings::blk_mq_ops {
+        queue_rq: Some(Self::queue_rq_callback),
+        queue_rqs: None,
+        commit_rqs: Some(Self::commit_rqs_callback),
+        get_budget: None,
+        put_budget: None,
+        set_rq_budget_token: None,
+        get_rq_budget_token: None,
+        timeout: None,
+        poll: if T::HAS_POLL {
+            Some(Self::poll_callback)
+        } else {
+            None
+        },
+        complete: Some(Self::complete_callback),
+        init_hctx: Some(Self::init_hctx_callback),
+        exit_hctx: Some(Self::exit_hctx_callback),
+        init_request: Some(Self::init_request_callback),
+        exit_request: Some(Self::exit_request_callback),
+        cleanup_rq: None,
+        busy: None,
+        map_queues: None,
+        #[cfg(CONFIG_BLK_DEBUG_FS)]
+        show_rq: None,
+    };
+
+    pub(crate) const fn build() -> &'static bindings::blk_mq_ops {
+        &Self::VTABLE
+    }
+}
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
new file mode 100644
index 000000000000..9222465d670b
--- /dev/null
+++ b/rust/kernel/block/mq/raw_writer.rs
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::fmt::{self, Write};
+
+use crate::error::Result;
+use crate::prelude::EINVAL;
+
+/// A mutable reference to a byte buffer where a string can be written into.
+///
+/// # Invariants
+///
+/// `buffer` is always null terminated.
+pub(crate) struct RawWriter<'a> {
+    buffer: &'a mut [u8],
+    pos: usize,
+}
+
+impl<'a> RawWriter<'a> {
+    /// Create a new `RawWriter` instance.
+    fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
+        *(buffer.last_mut().ok_or(EINVAL)?) = 0;
+
+        // INVARIANT: We null terminated the buffer above.
+        Ok(Self { buffer, pos: 0 })
+    }
+
+    pub(crate) fn from_array<const N: usize>(
+        a: &'a mut [core::ffi::c_char; N],
+    ) -> Result<RawWriter<'a>> {
+        Self::new(
+            // SAFETY: the buffer of `a` is valid for read and write as `u8` for
+            // at least `N` bytes.
+            unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cast::<u8>(), N) },
+        )
+    }
+}
+
+impl Write for RawWriter<'_> {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        let bytes = s.as_bytes();
+        let len = bytes.len();
+
+        // We do not want to overwrite our null terminator
+        if self.pos + len > self.buffer.len() - 1 {
+            return Err(fmt::Error);
+        }
+
+        // INVARIANT: We are not overwriting the last byte
+        self.buffer[self.pos..self.pos + len].copy_from_slice(bytes);
+
+        self.pos += len;
+
+        Ok(())
+    }
+}
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
new file mode 100644
index 000000000000..a0e22827f3f4
--- /dev/null
+++ b/rust/kernel/block/mq/request.rs
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides a wrapper for the C `struct request` type.
+//!
+//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
+
+use crate::{
+    bindings,
+    block::mq::Operations,
+    error::Result,
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+use core::{
+    marker::PhantomData,
+    ptr::{addr_of_mut, NonNull},
+    sync::atomic::{AtomicU64, Ordering},
+};
+
+/// A wrapper around a blk-mq `struct request`. This represents an IO request.
+///
+/// # Implementation details
+///
+/// There are four states for a request that the Rust bindings care about:
+///
+/// A) Request is owned by block layer (refcount 0)
+/// B) Request is owned by driver but with zero `ARef`s in existence
+///    (refcount 1)
+/// C) Request is owned by driver with exactly one `ARef` in existence
+///    (refcount 2)
+/// D) Request is owned by driver with more than one `ARef` in existence
+///    (refcount > 2)
+///
+///
+/// We need to track A and B to ensure we fail tag to request conversions for
+/// requests that are not owned by the driver.
+///
+/// We need to track C and D to ensure that it is safe to end the request and hand
+/// back ownership to the block layer.
+///
+/// The states are tracked through the private `refcount` field of
+/// `RequestDataWrapper`. This structure lives in the private data area of the C
+/// `struct request`.
+///
+/// # Invariants
+///
+/// * `self.0` is a valid `struct request` created by the C portion of the kernel.
+/// * The private data area associated with this request must be an initialized
+///   and valid `RequestDataWrapper<T>`.
+/// * `self` is reference counted by atomic modification of
+///   self.wrapper_ref().refcount().
+///
+#[repr(transparent)]
+pub struct Request<T: Operations>(Opaque<bindings::request>, PhantomData<T>);
+
+impl<T: Operations> Request<T> {
+    /// Create an `ARef<Request>` from a `struct request` pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The caller must own a refcount on `ptr` that is transferred to the
+    ///   returned `ARef`.
+    /// * The type invariants for `Request` must hold for the pointee of `ptr`.
+    pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
+        // INVARIANT: By the safety requirements of this function, invariants are upheld.
+        // SAFETY: By the safety requirement of this function, we own a
+        // reference count that we can pass to `ARef`.
+        unsafe { ARef::from_raw(NonNull::new_unchecked(ptr as *const Self as *mut Self)) }
+    }
+
+    /// Notify the block layer that a request is going to be processed now.
+    ///
+    /// The block layer uses this hook to do proper initializations such as
+    /// starting the timeout timer. It is a requirement that block device
+    /// drivers call this function when starting to process a request.
+    ///
+    /// # Safety
+    ///
+    /// The caller must have exclusive ownership of `self`, that is
+    /// `self.wrapper_ref().refcount() == 2`.
+    pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
+        // SAFETY: By type invariant, `self.0` is a valid `struct request` and
+        // we have exclusive access.
+        unsafe { bindings::blk_mq_start_request(this.0.get()) };
+    }
+
+    /// Try to take exclusive ownership of `this` by dropping the refcount to 0.
+    /// This fails if `this` is not the only `ARef` pointing to the underlying
+    /// `Request`.
+    ///
+    /// If the operation is successful, `Ok` is returned with a pointer to the
+    /// C `struct request`. If the operation fails, `this` is returned in the
+    /// `Err` variant.
+    fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
+        // We can race with `TagSet::tag_to_rq`
+        if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
+            2,
+            0,
+            Ordering::Relaxed,
+            Ordering::Relaxed,
+        ) {
+            return Err(this);
+        }
+
+        let request_ptr = this.0.get();
+        core::mem::forget(this);
+
+        Ok(request_ptr)
+    }
+
+    /// Notify the block layer that the request has been completed without errors.
+    ///
+    /// This function will return `Err` if `this` is not the only `ARef`
+    /// referencing the request.
+    pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
+        let request_ptr = Self::try_set_end(this)?;
+
+        // SAFETY: By type invariant, `this.0` was a valid `struct request`. The
+        // success of the call to `try_set_end` guarantees that there are no
+        // `ARef`s pointing to this request. Therefore it is safe to hand it
+        // back to the block layer.
+        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BLK_STS_OK as _) };
+
+        Ok(())
+    }
+
+    /// Return a pointer to the `RequestDataWrapper` stored in the private area
+    /// of the request structure.
+    ///
+    /// # Safety
+    ///
+    /// - `this` must point to a valid allocation of size at least size of
+    ///   `Self` plus size of `RequestDataWrapper`.
+    pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper> {
+        let request_ptr = this.cast::<bindings::request>();
+        // SAFETY: By safety requirements for this function, `this` is a
+        // valid allocation.
+        let wrapper_ptr =
+            unsafe { bindings::blk_mq_rq_to_pdu(request_ptr).cast::<RequestDataWrapper>() };
+        // SAFETY: By C API contract, wrapper_ptr points to a valid allocation
+        // and is not null.
+        unsafe { NonNull::new_unchecked(wrapper_ptr) }
+    }
+
+    /// Return a reference to the `RequestDataWrapper` stored in the private
+    /// area of the request structure.
+    pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
+        // SAFETY: By type invariant, `self.0` is a valid allocation. Further,
+        // the private data associated with this request is initialized and
+        // valid. The existence of `&self` guarantees that the private data is
+        // valid as a shared reference.
+        unsafe { Self::wrapper_ptr(self as *const Self as *mut Self).as_ref() }
+    }
+}
+
+/// A wrapper around data stored in the private area of the C `struct request`.
+pub(crate) struct RequestDataWrapper {
+    /// The Rust request refcount has the following states:
+    ///
+    /// - 0: The request is owned by C block layer.
+    /// - 1: The request is owned by Rust abstractions but there are no ARef references to it.
+    /// - 2+: There are `ARef` references to the request.
+    refcount: AtomicU64,
+}
+
+impl RequestDataWrapper {
+    /// Return a reference to the refcount of the request that is embedding
+    /// `self`.
+    pub(crate) fn refcount(&self) -> &AtomicU64 {
+        &self.refcount
+    }
+
+    /// Return a pointer to the refcount of the request that is embedding the
+    /// pointee of `this`.
+    ///
+    /// # Safety
+    ///
+    /// - `this` must point to a live allocation of at least the size of `Self`.
+    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
+        // SAFETY: Because of the safety requirements of this function, the
+        // field projection is safe.
+        unsafe { addr_of_mut!((*this).refcount) }
+    }
+}
+
+// SAFETY: Exclusive access is thread-safe for `Request`. `Request` has no `&mut
+// self` methods and `&self` methods that mutate `self` are internally
+// synchronized.
+unsafe impl<T: Operations> Send for Request<T> {}
+
+// SAFETY: Shared access is thread-safe for `Request`. `&self` methods that
+// mutate `self` are internally synchronized`
+unsafe impl<T: Operations> Sync for Request<T> {}
+
+/// Store the result of `op(target.load())` in target, returning new value of
+/// target.
+fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
+    let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
+
+    // SAFETY: Because the operation passed to `fetch_update` above always
+    // return `Some`, `old` will always be `Ok`.
+    let old = unsafe { old.unwrap_unchecked() };
+
+    op(old)
+}
+
+/// Store the result of `op(target.load)` in `target` if `target.load() !=
+/// pred`, returning true if the target was updated.
+fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
+    target
+        .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
+            if x == pred {
+                None
+            } else {
+                Some(op(x))
+            }
+        })
+        .is_ok()
+}
+
+// SAFETY: All instances of `Request<T>` are reference counted. This
+// implementation of `AlwaysRefCounted` ensure that increments to the ref count
+// keeps the object alive in memory at least until a matching reference count
+// decrement is executed.
+unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
+    fn inc_ref(&self) {
+        let refcount = &self.wrapper_ref().refcount();
+
+        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
+        let updated = atomic_relaxed_op_unless(refcount, |x| x + 1, 0);
+
+        #[cfg(CONFIG_DEBUG_MISC)]
+        if !updated {
+            panic!("Request refcount zero on clone")
+        }
+    }
+
+    unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
+        // SAFETY: The type invariants of `ARef` guarantee that `obj` is valid
+        // for read.
+        let wrapper_ptr = unsafe { Self::wrapper_ptr(obj.as_ptr()).as_ptr() };
+        // SAFETY: The type invariant of `Request` guarantees that the private
+        // data area is initialized and valid.
+        let refcount = unsafe { &*RequestDataWrapper::refcount_ptr(wrapper_ptr) };
+
+        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
+        let new_refcount = atomic_relaxed_op_return(refcount, |x| x - 1);
+
+        #[cfg(CONFIG_DEBUG_MISC)]
+        if new_refcount == 0 {
+            panic!("Request reached refcount zero in Rust abstractions");
+        }
+    }
+}
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
new file mode 100644
index 000000000000..f9a1ca655a35
--- /dev/null
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides the `TagSet` struct to wrap the C `struct blk_mq_tag_set`.
+//!
+//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
+
+use core::pin::Pin;
+
+use crate::{
+    bindings,
+    block::mq::{operations::OperationsVTable, request::RequestDataWrapper, Operations},
+    error,
+    prelude::PinInit,
+    try_pin_init,
+    types::Opaque,
+};
+use core::{convert::TryInto, marker::PhantomData};
+use macros::{pin_data, pinned_drop};
+
+/// A wrapper for the C `struct blk_mq_tag_set`.
+///
+/// `struct blk_mq_tag_set` contains a `struct list_head` and so must be pinned.
+///
+/// # Invariants
+///
+/// - `inner` is initialized and valid.
+#[pin_data(PinnedDrop)]
+#[repr(transparent)]
+pub struct TagSet<T: Operations> {
+    #[pin]
+    inner: Opaque<bindings::blk_mq_tag_set>,
+    _p: PhantomData<T>,
+}
+
+impl<T: Operations> TagSet<T> {
+    /// Try to create a new tag set
+    pub fn new(
+        nr_hw_queues: u32,
+        num_tags: u32,
+        num_maps: u32,
+    ) -> impl PinInit<Self, error::Error> {
+        // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
+        // all are allowed to be 0.
+        let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
+        let tag_set = core::mem::size_of::<RequestDataWrapper>()
+            .try_into()
+            .map(|cmd_size| {
+                bindings::blk_mq_tag_set {
+                    ops: OperationsVTable::<T>::build(),
+                    nr_hw_queues,
+                    timeout: 0, // 0 means default which is 30Hz in C
+                    numa_node: bindings::NUMA_NO_NODE,
+                    queue_depth: num_tags,
+                    cmd_size,
+                    flags: bindings::BLK_MQ_F_SHOULD_MERGE,
+                    driver_data: core::ptr::null_mut::<core::ffi::c_void>(),
+                    nr_maps: num_maps,
+                    ..tag_set
+                }
+            });
+
+        try_pin_init!(TagSet {
+            inner <- PinInit::<_, error::Error>::pin_chain(Opaque::new(tag_set?), |tag_set| {
+                // SAFETY: we do not move out of `tag_set`.
+                let tag_set = unsafe { Pin::get_unchecked_mut(tag_set) };
+                // SAFETY: `tag_set` is a reference to an initialized `blk_mq_tag_set`.
+                error::to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())})
+            }),
+            _p: PhantomData,
+        })
+    }
+
+    /// Return the pointer to the wrapped `struct blk_mq_tag_set`
+    pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set {
+        self.inner.get()
+    }
+}
+
+#[pinned_drop]
+impl<T: Operations> PinnedDrop for TagSet<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: By type invariant `inner` is valid and has been properly
+        // initialized during construction.
+        unsafe { bindings::blk_mq_free_tag_set(self.inner.get()) };
+    }
+}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 55280ae9fe40..145f5c397009 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -126,6 +126,12 @@ pub fn to_errno(self) -> core::ffi::c_int {
         self.0
     }
 
+    #[cfg(CONFIG_BLOCK)]
+    pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
+        // SAFETY: `self.0` is a valid error due to its invariant.
+        unsafe { bindings::errno_to_blk_status(self.0) }
+    }
+
     /// Returns the error encoded as a pointer.
     #[allow(dead_code)]
     pub(crate) fn to_ptr<T>(self) -> *mut T {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fbd91a48ff8b..2cf7c6b6f66b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -27,6 +27,8 @@
 extern crate self as kernel;
 
 pub mod alloc;
+#[cfg(CONFIG_BLOCK)]
+pub mod block;
 mod build_assert;
 pub mod error;
 pub mod init;
-- 
2.45.2

