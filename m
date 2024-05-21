Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98E76C76
	for <linux-block@vger.kernel.org>; Tue, 21 May 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300124; cv=none; b=tUr4hin69o+SWBrZ69pthbtYq7j7ueMSrJG5HcePbdt4MO7nxbfHRB9fa7cu6DDUcUagx3FCUPTRvVtcebobU7HtrFvw1zDefNd2oqqrRCrOqrMDs32VWNbDQEMMngzaQz0075+wdImf2UXyB/jDyeA791BBFe9z1yLcAjCc0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300124; c=relaxed/simple;
	bh=7TAYloK5kzDebFM1Y8oAp1F0aTUICsOGItGWg4GtCvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVib7FvTZ55T+Hw+F/wcERZXalLYIroj/EADJFJUg4R0zBtggBmzf+Oyi8l8PHKlluARf4qcxJZjKiByn1hwOaqQoZgFnMTv8Rq5CXBjHsdyoMvBqqISdOhIVQlC0B9kh5HDi1eCfM2jeR5t4+/HuERrIFfjhJ0uTeGGQtldcUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=w2L20YyZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="w2L20YyZ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so759405666b.0
        for <linux-block@vger.kernel.org>; Tue, 21 May 2024 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1716300120; x=1716904920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8lnGdbLYpvYt+yIUoV6YtLJixJE+Ymu/iGUu1Q9leE=;
        b=w2L20YyZWjQDxBq1y5N1T11OUUAN+aQePrmbhy3ucJ0hRU6GqVDhIhKdf/xb2s0P5m
         6tEANfguBUfIT3AATqwtldyzvR61mv/TFVf8hSQewk59ZC9gVL/N+JPzHtvt+5+Y1yHo
         erKLmvhjMXJSVAdvicRoVRSgGHq0zIKTwteTm+3daHY5bE9FvXQvBd8o+LHJBrsj0m5t
         KUIoGSyjd3P9wYnA7glOVST3EAJP26vKUFFMlonRvDzHGC0T5lZS5ia0COzILmTvPXhc
         FB8fOeEIKHJ6wIuJcEtRugsDghs5xv4XuZLJqyN3rXERW3PyU3v4qyAdJT+YRH07iLZg
         KazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300120; x=1716904920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8lnGdbLYpvYt+yIUoV6YtLJixJE+Ymu/iGUu1Q9leE=;
        b=fa7is6CIcBM5n7vyXldogf71EnHc+PDpOiilOwP6QEvf0MC3bsuyNUlMXeVrScXY9o
         VtIlMTKem5620sG6IeTus0w8a93LZxEdhW30h1ddv/ospF7XhK8+BCbV/euwxX5X5g9P
         m5V9OMWg6UwKXA1KhrSbQpNaVYTk4qpXyV8jEYNGLFzETyvNXajXFTIVutIKTUZYfppG
         3srRNZh34/2Ld79YJw+jyoZ2TfnRG+nhiVLn4/L/wy9XFJdzIfv7XtN4kuR7yMF8sAIm
         bNLLGa+/nAgMJ0HFoVC9J8nf/o178/wZiooTskKv/+VSa81aO0fD0+3iI4BLsQEHs0dm
         4Fuw==
X-Forwarded-Encrypted: i=1; AJvYcCXGvorUSWsQEvMWxENabbqltaYJchBu0TxMqmI7XRCdYud3ZfxYnJyoDixwNPApSy1dTDHa95ZXrJhXGdB+F+ZMlz/h4y6EcWnU1pk=
X-Gm-Message-State: AOJu0Yw9ORV3jaGKgS82afPQBAouss6Kn52O488SLYei6JWbqxjGrx2P
	HMB4QgSgzPc/GUMVEudh2P1QgNVeLRq15Z+tNKficbE6IsqjVv+4tqE8qWLXwAc=
X-Google-Smtp-Source: AGHT+IFLYkq9gO7OQn9gcOC01/yL9c8o8IRd8qp6GlRlK3cZx3zrkQvyYid85RTOGhDtLGWHjFVuug==
X-Received: by 2002:a17:906:3512:b0:a59:a282:5dbd with SMTP id a640c23a62f3a-a5a2d676474mr3020448466b.66.1716300118937;
        Tue, 21 May 2024 07:01:58 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b0150csm1618682466b.154.2024.05.21.07.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:01:58 -0700 (PDT)
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
Subject: [PATCH v2 1/3] rust: block: introduce `kernel::block::mq` module
Date: Tue, 21 May 2024 16:03:20 +0200
Message-ID: <20240521140323.2960069-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240521140323.2960069-1-nmi@metaspace.dk>
References: <20240521140323.2960069-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Add initial abstractions for working with blk-mq.

This patch is a maintained, refactored subset of code originally published
by Wedson Almeida Filho <wedsonaf@gmail.com> [1].

[1] https://github.com/wedsonaf/linux/tree/f2cfd2fe0e2ca4e90994f96afe268bbd4382a891/rust/kernel/blk/mq.rs

Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/bindings/bindings_helper.h    |   2 +
 rust/helpers.c                     |  16 ++
 rust/kernel/block.rs               |   5 +
 rust/kernel/block/mq.rs            |  97 ++++++++++++
 rust/kernel/block/mq/gen_disk.rs   | 206 ++++++++++++++++++++++++
 rust/kernel/block/mq/operations.rs | 245 +++++++++++++++++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  55 +++++++
 rust/kernel/block/mq/request.rs    | 227 ++++++++++++++++++++++++++
 rust/kernel/block/mq/tag_set.rs    |  93 +++++++++++
 rust/kernel/error.rs               |   6 +
 rust/kernel/lib.rs                 |   2 +
 11 files changed, 954 insertions(+)
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ddb5644d4fd9..68f937f8374f 100644
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
diff --git a/rust/helpers.c b/rust/helpers.c
index 4c8b7b92a4f4..3ba108095346 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -178,3 +178,19 @@ static_assert(
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
index 000000000000..efbd2588791b
--- /dev/null
+++ b/rust/kernel/block/mq.rs
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides types for implementing block drivers that interface the
+//! blk-mq subsystem.
+//!
+//! To implement a block device driver, a Rust module must do the following:
+//!
+//! - Implement [`Operations`] for a type `T`
+//! - Create a [`TagSet<T>`]
+//! - Create a [`gen_disk::GenDisk<T>`], passing in the `TagSet` reference
+//! - Add the disk to the system by calling [`gen_disk::GenDisk::add`]
+//!
+//! The types available in this module that have direct C counterparts are:
+//!
+//! - The `TagSet` type that abstracts the C type `struct tag_set`.
+//! - The `GenDisk` type that abstracts the C type `struct gendisk`.
+//! - The `Request` type that abstracts the C type `struct request`.
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
+//! # Example
+//!
+//! ```rust
+//! use kernel::{
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
+//!     fn commit_rqs(
+//!     ) {
+//!     }
+//!
+//!     fn complete(rq: ARef<Request<Self>>) {
+//!         Request::end_ok(rq);
+//!     }
+//! }
+//!
+//! let tagset: Arc<TagSet<MyBlkDevice>> = Arc::pin_init(TagSet::try_new(1, 256, 1))?;
+//! let mut disk = gen_disk::try_new(tagset)?;
+//! disk.set_name(format_args!("myblk"))?;
+//! disk.set_capacity_sectors(4096);
+//! disk.add()?;
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
index 000000000000..a88802c1f918
--- /dev/null
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic disk abstraction.
+//!
+//! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
+//! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
+
+use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
+use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
+use core::fmt::{self, Write};
+use core::marker::PhantomData;
+
+/// A generic block device.
+///
+/// # Invariants
+///
+///  - `gendisk` must always point to an initialized and valid `struct gendisk`.
+pub struct GenDisk<T: Operations, S: GenDiskState> {
+    _tagset: Arc<TagSet<T>>,
+    gendisk: *mut bindings::gendisk,
+    _phantom: core::marker::PhantomData<S>,
+}
+
+// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
+// `TagSet` It is safe to send this to other threads as long as T is Send.
+unsafe impl<T: Operations + Send, S: GenDiskState> Send for GenDisk<T, S> {}
+
+/// Disks in this state are allocated and initialized, but are not yet
+/// accessible from the kernel VFS.
+pub enum Initialized {}
+
+/// Disks in this state have been attached to the kernel VFS and may receive IO
+/// requests.
+pub enum Added {}
+
+/// Typestate representing states of a `GenDisk`.
+pub trait GenDiskState {}
+
+impl GenDiskState for Initialized {}
+impl GenDiskState for Added {}
+
+impl<T: Operations> GenDisk<T, Initialized> {
+    /// Register the device with the kernel. When this function returns, the
+    /// device is accessible from VFS. The kernel may issue reads to the device
+    /// during registration to discover partition information.
+    pub fn add(self) -> Result<GenDisk<T, Added>> {
+        crate::error::to_result(
+            // SAFETY: By type invariant, `self.gendisk` points to a valid and
+            // initialized instance of `struct gendisk`
+            unsafe {
+                bindings::device_add_disk(
+                    core::ptr::null_mut(),
+                    self.gendisk,
+                    core::ptr::null_mut(),
+                )
+            },
+        )?;
+
+        // We don't want to run the destuctor and remove the device from the VFS
+        // when `disk` is dropped.
+        let mut old = core::mem::ManuallyDrop::new(self);
+
+        let new = GenDisk {
+            _tagset: old._tagset.clone(),
+            gendisk: old.gendisk,
+            _phantom: PhantomData,
+        };
+
+        // But we have to drop the `Arc` or it will leak.
+        // SAFETY: `old._tagset` is valid for write, aligned, non-null, and we
+        // have exclusive access. We are not accessing the value again after it
+        // is dropped.
+        unsafe { core::ptr::drop_in_place(&mut old._tagset) };
+
+        Ok(new)
+    }
+
+    /// Set the name of the device.
+    pub fn set_name(&mut self, args: fmt::Arguments<'_>) -> Result {
+        let mut raw_writer = RawWriter::from_array(
+            // SAFETY: By type invariant `self.gendisk` points to a valid and
+            // initialized instance. We have exclusive access, since the disk is
+            // not added to the VFS yet.
+            unsafe { &mut (*self.gendisk).disk_name },
+        )?;
+        raw_writer.write_fmt(args)?;
+        raw_writer.write_char('\0')?;
+        Ok(())
+    }
+
+    /// Set the logical block size of the device.
+    ///
+    /// This is the smallest unit the storage device can address. It is
+    /// typically 4096 bytes.
+    pub fn set_queue_logical_block_size(&mut self, size: u32) {
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`.
+        unsafe { bindings::blk_queue_logical_block_size((*self.gendisk).queue, size) };
+    }
+
+    /// Set the physical block size of the device.
+    ///
+    /// This is the smallest unit a physical storage device can write
+    /// atomically. It is usually the same as the logical block size but may be
+    /// bigger. One example is SATA drives with 4096 byte physical block size
+    /// that expose a 512 byte logical block size to the operating system.
+    pub fn set_queue_physical_block_size(&mut self, size: u32) {
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`.
+        unsafe { bindings::blk_queue_physical_block_size((*self.gendisk).queue, size) };
+    }
+}
+
+impl<T: Operations, S: GenDiskState> GenDisk<T, S> {
+    /// Call to tell the block layer the capacity of the device in sectors (512
+    /// bytes).
+    pub fn set_capacity_sectors(&self, sectors: u64) {
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`. Callee takes a lock to
+        // synchronize this operation, so we will not race.
+        unsafe { bindings::set_capacity(self.gendisk, sectors) };
+    }
+
+    /// Set the rotational media attribute for the device.
+    pub fn set_rotational(&self, rotational: bool) {
+        if !rotational {
+            // SAFETY: By type invariant, `self.gendisk` points to a valid and
+            // initialized instance of `struct gendisk`. This operation uses a
+            // relaxed atomic bit flip operation, so there is no race on this
+            // field.
+            unsafe {
+                bindings::blk_queue_flag_set(bindings::QUEUE_FLAG_NONROT, (*self.gendisk).queue)
+            };
+        } else {
+            // SAFETY: By type invariant, `self.gendisk` points to a valid and
+            // initialized instance of `struct gendisk`. This operation uses a
+            // relaxed atomic bit flip operation, so there is no race on this
+            // field.
+            unsafe {
+                bindings::blk_queue_flag_clear(bindings::QUEUE_FLAG_NONROT, (*self.gendisk).queue)
+            };
+        }
+    }
+}
+
+impl<T: Operations, S: GenDiskState> Drop for GenDisk<T, S> {
+    fn drop(&mut self) {
+        // TODO: This will `WARN` if the disk was not added. Since we cannot
+        // specialize drop, we have to call it, or track state with a flag.
+
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`
+        unsafe { bindings::del_gendisk(self.gendisk) };
+    }
+}
+
+/// Try to create a new `GenDisk`.
+pub fn try_new<T: Operations>(tagset: Arc<TagSet<T>>) -> Result<GenDisk<T, Initialized>> {
+    let lock_class_key = crate::sync::LockClassKey::new();
+
+    // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
+    let gendisk = from_err_ptr(unsafe {
+        bindings::__blk_mq_alloc_disk(
+            tagset.raw_tag_set(),
+            core::ptr::null_mut(), // TODO: We can pass queue limits right here
+            core::ptr::null_mut(),
+            lock_class_key.as_ptr(),
+        )
+    })?;
+
+    const TABLE: bindings::block_device_operations = bindings::block_device_operations {
+        submit_bio: None,
+        open: None,
+        release: None,
+        ioctl: None,
+        compat_ioctl: None,
+        check_events: None,
+        unlock_native_capacity: None,
+        getgeo: None,
+        set_read_only: None,
+        swap_slot_free_notify: None,
+        report_zones: None,
+        devnode: None,
+        alternative_gpt_sector: None,
+        get_unique_id: None,
+        // TODO: Set to THIS_MODULE. Waiting for const_refs_to_static feature to
+        // be merged (unstable in rustc 1.78 which is staged for linux 6.10)
+        // https://github.com/rust-lang/rust/issues/119618
+        owner: core::ptr::null_mut(),
+        pr_ops: core::ptr::null_mut(),
+        free_disk: None,
+        poll_bio: None,
+    };
+
+    // SAFETY: gendisk is a valid pointer as we initialized it above
+    unsafe { (*gendisk).fops = &TABLE };
+
+    // INVARIANT: `gendisk` was initialized above.
+    // INVARIANT: `gendisk.queue.queue_data` is set to `data` in the call to
+    // `__blk_mq_alloc_disk` above.
+    Ok(GenDisk {
+        _tagset: tagset,
+        gendisk,
+        _phantom: PhantomData,
+    })
+}
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
new file mode 100644
index 000000000000..3bd1af2c2260
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
+    /// Called by the kernel when the request is completed.
+    fn complete(_rq: ARef<Request<Self>>);
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
+/// A `bindings::blk_mq_opa` vtable is constructed from pointers to the `extern
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
+    /// - The caller of this function must ensure `bd` is valid
+    ///   and initialized. The pointees must outlive this function.
+    /// - This function must not be called with a `hctx` for which
+    ///   `Self::exit_hctx_callback()` has been called.
+    /// - (*bd).rq must point to a valid `bindings:request` for which
+    ///   `OperationsVTable<T>::init_request_callback` was called
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
+        let rq =
+        // SAFETY: We own a refcount that we took above. We pass that to `ARef`.
+        // By the safety requirements of this function, `request` is a valid
+        // `struct request` and the private data is properly initialized.
+            unsafe {Request::aref_from_raw((*bd).rq)};
+
+        // SAFETY: We have exclusive access and we just set the refcount above.
+        unsafe { Request::start_unchecked(&rq) };
+
+        let ret = T::queue_rq(
+            rq,
+            // SAFETY: `bd` is valid as required by the safety requirement for this function.
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
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `rq` must
+    /// point to a valid request that has been marked as completed. The pointee
+    /// of `rq` must be valid for write for the duration of this function.
+    unsafe extern "C" fn complete_callback(rq: *mut bindings::request) {
+        // SAFETY: This function can only be dispatched through
+        // `Request::complete`. We leaked a refcount then which we pick back up
+        // now.
+        let aref = unsafe { Request::aref_from_raw(rq) };
+        T::complete(aref);
+    }
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
+    /// function may only be called onece before `exit_hctx_callback` is called
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
+    /// This function may only be called by blk-mq C infrastructure. `set` must
+    /// point to an initialized `TagSet<T>`.
+    unsafe extern "C" fn init_request_callback(
+        _set: *mut bindings::blk_mq_tag_set,
+        rq: *mut bindings::request,
+        _hctx_idx: core::ffi::c_uint,
+        _numa_node: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `blk_mq_tag_set` invariants guarantee that all
+            // requests are allocated with extra memory for the request data.
+            let pdu = unsafe { bindings::blk_mq_rq_to_pdu(rq) }.cast::<RequestDataWrapper>();
+
+            // SAFETY: The refcount field is allocated but not initialized, this
+            // valid for write.
+            unsafe { RequestDataWrapper::refcount_ptr(pdu).write(AtomicU64::new(0)) };
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
+    /// This function may only be called by blk-mq C infrastructure. `rq` must
+    /// point to a request that was initialized by a call to
+    /// `Self::init_request_callback`.
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
index 000000000000..4f7e4692b592
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
+        // INVARIANT: We null terminated the buffer above
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
index 000000000000..db5d760615d7
--- /dev/null
+++ b/rust/kernel/block/mq/request.rs
@@ -0,0 +1,227 @@
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
+        // INVARIANTS: By the safety requirements of this function, invariants are upheld.
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
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`. By
+        // existence of `&mut self` we have exclusive access.
+        unsafe { bindings::blk_mq_start_request(this.0.get()) };
+    }
+
+    fn try_set_end(this: ARef<Self>) -> Result<ARef<Self>, ARef<Self>> {
+        // We can race with `TagSet::tag_to_rq`
+        match this.wrapper_ref().refcount().compare_exchange(
+            2,
+            0,
+            Ordering::Relaxed,
+            Ordering::Relaxed,
+        ) {
+            Err(_old) => Err(this),
+            Ok(_) => Ok(this),
+        }
+    }
+
+    /// Notify the block layer that the request has been completed without errors.
+    ///
+    /// This function will return `Err` if `this` is not the only `ARef`
+    /// referencing the request.
+    pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
+        let this = Self::try_set_end(this)?;
+        let request_ptr = this.0.get();
+        core::mem::forget(this);
+
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`. By
+        // existence of `&mut self` we have exclusive access.
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
+    /// - `this` must point to a valid allocation.
+    pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper> {
+        let request_ptr = this.cast::<bindings::request>();
+        let wrapper_ptr =
+            // SAFETY: By safety requirements for this function, `this` is a
+            // valid allocation.
+            unsafe { bindings::blk_mq_rq_to_pdu(request_ptr).cast::<RequestDataWrapper>() };
+        // SAFETY: By C api contract, wrapper_ptr points to a valid allocation
+        // and is not null.
+        unsafe { NonNull::new_unchecked(wrapper_ptr) }
+    }
+
+    /// Return a reference to the `RequestDataWrapper` stored in the private
+    /// area of the request structure.
+    pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
+        // SAFETY: By type invariant, `self.0` is a valid alocation. Further,
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
+// synchronzied.
+unsafe impl<T: Operations> Send for Request<T> {}
+
+// SAFETY: Shared access is thread-safe for `Request`. `&self` methods that
+// mutate `self` are internally synchronized`
+unsafe impl<T: Operations> Sync for Request<T> {}
+
+/// Store the result of `op(target.load())` in target, returning new value of
+/// taret.
+fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
+    let mut old = target.load(Ordering::Relaxed);
+    loop {
+        match target.compare_exchange_weak(old, op(old), Ordering::Relaxed, Ordering::Relaxed) {
+            Ok(_) => break,
+            Err(x) => {
+                old = x;
+            }
+        }
+    }
+
+    op(old)
+}
+
+/// Store the result of `op(target.load)` in `target` if `target.load() !=
+/// pred`, returning previous value of target
+fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
+    let x = target.load(Ordering::Relaxed);
+    loop {
+        if x == pred {
+            break;
+        }
+        if target
+            .compare_exchange_weak(x, op(x), Ordering::Relaxed, Ordering::Relaxed)
+            .is_ok()
+        {
+            break;
+        }
+    }
+
+    x == pred
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
index 000000000000..4217c2b03ff3
--- /dev/null
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -0,0 +1,93 @@
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
+    block::mq::request::RequestDataWrapper,
+    block::mq::{operations::OperationsVTable, Operations},
+    error::{self, Error, Result},
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
+    pub fn try_new(
+        nr_hw_queues: u32,
+        num_tags: u32,
+        num_maps: u32,
+    ) -> impl PinInit<Self, error::Error> {
+        try_pin_init!( TagSet {
+            inner <- unsafe {kernel::init::pin_init_from_closure(move |place: *mut Opaque<bindings::blk_mq_tag_set>| -> Result<()> {
+                let place = place.cast::<bindings::blk_mq_tag_set>();
+
+                // SAFETY: try_ffi_init promises that `place` is writable, and
+                // zeroes is a valid bit pattern for this structure.
+                core::ptr::write_bytes(place, 0, 1);
+
+                /// For a raw pointer to a struct, write a struct field without
+                /// creating a reference to the field
+                macro_rules! write_ptr_field {
+                    ($target:ident, $field:ident, $value:expr) => {
+                        ::core::ptr::write(::core::ptr::addr_of_mut!((*$target).$field), $value)
+                    };
+                }
+
+                // SAFETY: try_ffi_init promises that `place` is writable
+                    write_ptr_field!(place, ops, OperationsVTable::<T>::build());
+                    write_ptr_field!(place, nr_hw_queues , nr_hw_queues);
+                    write_ptr_field!(place, timeout , 0); // 0 means default which is 30 * HZ in C
+                    write_ptr_field!(place, numa_node , bindings::NUMA_NO_NODE);
+                    write_ptr_field!(place, queue_depth , num_tags);
+                    write_ptr_field!(place, cmd_size , core::mem::size_of::<RequestDataWrapper>().try_into()?);
+                    write_ptr_field!(place, flags , bindings::BLK_MQ_F_SHOULD_MERGE);
+                    write_ptr_field!(place, driver_data , core::ptr::null_mut::<core::ffi::c_void>());
+                    write_ptr_field!(place, nr_maps , num_maps);
+
+                // SAFETY: Relevant fields of `place` are initialised above
+                let ret = bindings::blk_mq_alloc_tag_set(place);
+                if ret < 0 {
+                    return Err(Error::from_errno(ret));
+                }
+
+                Ok(())
+            })},
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
+        // SAFETY: We are not moving self below
+        let this = unsafe { Pin::into_inner_unchecked(self) };
+
+        // SAFETY: `inner` is valid and has been properly initialised during construction.
+        unsafe { bindings::blk_mq_free_tag_set(this.inner.get()) };
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
index 9a943d99c71a..79be44281fb4 100644
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
2.44.0

