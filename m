Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB43F9C3
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327969; cv=none; b=m+Ig7XilZNROxyN8f7vQFoLN7VuOkf1IubJIE1Nks6lZokmXJ4/nRWjbp9SdofLGUcomBiTczRv5+iofMKFlVoFQM5foTGLH8rcgSQ/jcuzFJDZhDMhVI/IVjD+vXSvsO9PlSyMPu5Xy2G/n2w59VGzqCJpwO8xiecTB+1tkjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327969; c=relaxed/simple;
	bh=xjQCJb4J7tMhqbOJEMnpM+ZXei9HK+wmDq2+xus48ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG0fef7x12iJbgdy9VKpow7Okr/jHMabiJ6gNFuK1JSMN2YUvJvJUIM0p78qfxHwbBhXtooJLU1Oq3VVEJTT6XfzEqUEsg8sB3ZrslxP7KafJzsh/VPOTTdX7MIveQfVUcGXAclhbwa+AMPHQRzHp4l3Egqu3Ytg7/LEhO4XFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=0A3yRXY1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="0A3yRXY1"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so138706366b.0
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710327966; x=1710932766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I4BjeZBW5065VSFTPBsKa9SI4Ksu3+QBW/uFzCaABA=;
        b=0A3yRXY1VMqCKvJ6Oe6xCSlecM4puPbyCfKKksLY9sMVEx29KhWIVrKAHBzgA7zsgy
         sJ9CnvWD6+jnICpW+lhZRknTGK+z9TYQd+OzBM05W3957eg7KPMahmVpV6KgIVz6itU/
         D25YRI54VRKFS8FIr+GsQpDK2hg7M68gxJm1Or6CMtSsXDeoOLT63CI1FxfP0VUoMvrb
         RF+rd3IlgH7WQ5Lr/4g0oJMxuht8CQgbLYulzBcBu/M/DvtlIjEPD5CfVAhZiWqlbyBI
         U7nGzWnq6eDsCx7hLhfuDSMuE47P3ztPLZIauGOpBGDA9BtlY+YbIBkYT/YKr/Cy1CHB
         Elaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327966; x=1710932766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I4BjeZBW5065VSFTPBsKa9SI4Ksu3+QBW/uFzCaABA=;
        b=v3CxBkSPDR9IU737K+hjXA4Fvy8NO0IpCnB/nL+g+PUSIu3zae28pxbc0Lr5G4N7fh
         Jyz1KzDgGUXW9cinteBh0XLpDUHRCxx6Uq0HDGxJbH6VsaBPHMYTVTx/eD0nmhfeGfBz
         0rGYP6jxE/2m/NScjbv68dHkY+/NVNTGuaC/HS0c2E28hOh2PXs0sj3tsfEnjuWlLgPC
         2br59bHU7+MHdeJrWaFg8eYVJ+qPQ51/DbDJ8BwQJ2aLIZJ4vna57BZq6nkjp0N280mI
         UapdPSk0Dr2c8l4dx2Sle4Ao0SO3DRWc2PfbsOdhPTC2dEigKSi+CKbI4Ra/NXk3bXNq
         aOUA==
X-Forwarded-Encrypted: i=1; AJvYcCWHjj7e+khxNhVSVu1n/lLq/A6dyigQKuoTVG6QDvoI+M7WlOcUiYnQO6vTzcj++JZ2pZowkcrcX6JaKpiZ2mN+rU4H9oIU7edsBDI=
X-Gm-Message-State: AOJu0YwryhM8T6bO05gyAWjG7aAJzyPnV7VxMdTro2hSNEwnmBgtc7Ja
	M6/sbN7bvN+hryONh0zQtl9oqh3UWghxaR4ZAhAE7VoIfBihilbC8WL8cJIK/iE=
X-Google-Smtp-Source: AGHT+IGOchPTEwVc1NP+20OHE3woXNtq7ZGAK95XOq6o/e/XnJ5OU4vtDQ9GpW7fyFG0Xs6V3WYxGw==
X-Received: by 2002:a17:906:54c2:b0:a44:52ec:b9e7 with SMTP id c2-20020a17090654c200b00a4452ecb9e7mr1771157ejp.16.1710327965737;
        Wed, 13 Mar 2024 04:06:05 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm3173785ejb.126.2024.03.13.04.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:06:05 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
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
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: [RFC PATCH 4/5] rust: block: add rnull, Rust null_blk implementation
Date: Wed, 13 Mar 2024 12:05:11 +0100
Message-ID: <20240313110515.70088-5-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313110515.70088-1-nmi@metaspace.dk>
References: <20240313110515.70088-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/Kconfig  |   4 +
 drivers/block/Makefile |   3 +
 drivers/block/rnull.rs | 323 +++++++++++++++++++++++++++++++++++++++++
 rust/helpers.c         |   1 +
 scripts/Makefile.build |   2 +-
 5 files changed, 332 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/rnull.rs

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..fb877d4f8ddf 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -354,6 +354,10 @@ config VIRTIO_BLK
 	  This is the virtual block driver for virtio.  It can be used with
           QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
+config BLK_DEV_RUST_NULL
+	tristate "Rust null block driver"
+	depends on RUST
+
 config BLK_DEV_RBD
 	tristate "Rados block device (RBD)"
 	depends on INET && BLOCK
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..1105a2d4fdcb 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -9,6 +9,9 @@
 # needed for trace events
 ccflags-y				+= -I$(src)
 
+obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull_mod.o
+rnull_mod-y := rnull.o
+
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_SWIM)	+= swim_mod.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
new file mode 100644
index 000000000000..05fef30e910c
--- /dev/null
+++ b/drivers/block/rnull.rs
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This is a Rust implementation of the C null block driver.
+//!
+//! Supported features:
+//!
+//! - optional memory backing
+//! - blk-mq interface
+//! - direct completion
+//! - softirq completion
+//! - timer completion
+//!
+//! The driver is configured at module load time by parameters
+//! `param_memory_backed`, `param_capacity_mib`, `param_irq_mode` and
+//! `param_completion_time_nsec!.
+
+use core::ops::Deref;
+
+use kernel::{
+    bindings,
+    block::{
+        bio::Segment,
+        mq::{self, GenDisk, Operations, RequestDataRef, TagSet},
+    },
+    error::Result,
+    folio::*,
+    hrtimer::{RawTimer, TimerCallback},
+    new_mutex, pr_info,
+    prelude::*,
+    sync::{Arc, Mutex},
+    types::{ARef, ForeignOwnable},
+    xarray::XArray,
+};
+
+use kernel::new_spinlock;
+use kernel::CacheAligned;
+use kernel::sync::SpinLock;
+
+module! {
+    type: NullBlkModule,
+    name: "rnull_mod",
+    author: "Andreas Hindborg",
+    license: "GPL v2",
+    params: {
+        param_memory_backed: bool {
+            default: true,
+            permissions: 0,
+            description: "Use memory backing",
+        },
+        // Problems with pin_init when `irq_mode`
+        param_irq_mode: u8 {
+            default: 0,
+            permissions: 0,
+            description: "IRQ Mode (0: None, 1: Soft, 2: Timer)",
+        },
+        param_capacity_mib: u64 {
+            default: 4096,
+            permissions: 0,
+            description: "Device capacity in MiB",
+        },
+        param_completion_time_nsec: u64 {
+            default: 1_000_000,
+            permissions: 0,
+            description: "Completion time in nano seconds for timer mode",
+        },
+        param_block_size: u16 {
+            default: 4096,
+            permissions: 0,
+            description: "Block size in bytes",
+        },
+    },
+}
+
+#[derive(Debug)]
+enum IRQMode {
+    None,
+    Soft,
+    Timer,
+}
+
+impl TryFrom<u8> for IRQMode {
+    type Error = kernel::error::Error;
+
+    fn try_from(value: u8) -> Result<Self> {
+        match value {
+            0 => Ok(Self::None),
+            1 => Ok(Self::Soft),
+            2 => Ok(Self::Timer),
+            _ => Err(kernel::error::code::EINVAL),
+        }
+    }
+}
+
+struct NullBlkModule {
+    _disk: Pin<Box<Mutex<GenDisk<NullBlkDevice>>>>,
+}
+
+fn add_disk(tagset: Arc<TagSet<NullBlkDevice>>) -> Result<GenDisk<NullBlkDevice>> {
+    let block_size = *param_block_size.read();
+    if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
+        return Err(kernel::error::code::EINVAL);
+    }
+
+    let irq_mode = (*param_irq_mode.read()).try_into()?;
+
+    let queue_data = Box::pin_init(pin_init!(
+        QueueData {
+            tree <- TreeContainer::new(),
+            completion_time_nsec: *param_completion_time_nsec.read(),
+            irq_mode,
+            memory_backed: *param_memory_backed.read(),
+            block_size,
+        }
+    ))?;
+
+    let block_size = queue_data.block_size;
+
+    let mut disk = GenDisk::try_new(tagset, queue_data)?;
+    disk.set_name(format_args!("rnullb{}", 0))?;
+    disk.set_capacity_sectors(*param_capacity_mib.read() << 11);
+    disk.set_queue_logical_block_size(block_size.into());
+    disk.set_queue_physical_block_size(block_size.into());
+    disk.set_rotational(false);
+    Ok(disk)
+}
+
+impl kernel::Module for NullBlkModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust null_blk loaded\n");
+        let tagset = Arc::pin_init(TagSet::try_new(1, (), 256, 1))?;
+        let disk = Box::pin_init(new_mutex!(add_disk(tagset)?, "nullb:disk"))?;
+
+        disk.lock().add()?;
+
+        Ok(Self { _disk: disk })
+    }
+}
+
+impl Drop for NullBlkModule {
+    fn drop(&mut self) {
+        pr_info!("Dropping rnullb\n");
+    }
+}
+
+struct NullBlkDevice;
+
+type Tree = XArray<Box<UniqueFolio>>;
+type TreeRef<'a> = &'a Tree;
+
+#[pin_data]
+struct TreeContainer {
+    // `XArray` is safe to use without a lock, as it applies internal locking.
+    // However, there are two reasons to use an external lock: a) cache line
+    // contention and b) we don't want to take the lock for each page we
+    // process.
+    //
+    // A: The `XArray` lock (xa_lock) is located on the same cache line as the
+    // xarray data pointer (xa_head). The effect of this arrangement is that
+    // under heavy contention, we often get a cache miss when we try to follow
+    // the data pointer after acquiring the lock. We would rather have consumers
+    // spinning on another lock, so we do not get a miss on xa_head. This issue
+    // can potentially be fixed by padding the C `struct xarray`.
+    //
+    // B: The current `XArray` Rust API requires that we take the `xa_lock` for
+    // each `XArray` operation. This is very inefficient when the lock is
+    // contended and we have many operations to perform. Eventually we should
+    // update the `XArray` API to allow multiple tree operations under a single
+    // lock acquisition. For now, serialize tree access with an external lock.
+    #[pin]
+    tree: CacheAligned<Tree>,
+    #[pin]
+    lock: CacheAligned<SpinLock<()>>,
+}
+
+impl TreeContainer {
+    fn new() -> impl PinInit<Self> {
+        pin_init!(TreeContainer {
+            tree <- CacheAligned::new_initializer(XArray::new(0)),
+            lock <- CacheAligned::new_initializer(new_spinlock!((), "rnullb:mem")),
+        })
+    }
+}
+
+#[pin_data]
+struct QueueData {
+    #[pin]
+    tree: TreeContainer,
+    completion_time_nsec: u64,
+    irq_mode: IRQMode,
+    memory_backed: bool,
+    block_size: u16,
+}
+
+impl NullBlkDevice {
+    #[inline(always)]
+    fn write(tree: TreeRef<'_>, sector: usize, segment: &Segment<'_>) -> Result {
+        let idx = sector >> bindings::PAGE_SECTORS_SHIFT;
+
+        let mut folio = if let Some(page) = tree.get_locked(idx) {
+            page
+        } else {
+            tree.set(idx, Box::try_new(Folio::try_new(0)?)?)?;
+            tree.get_locked(idx).unwrap()
+        };
+
+        segment.copy_to_folio(&mut folio)?;
+
+        Ok(())
+    }
+
+    #[inline(always)]
+    fn read(tree: TreeRef<'_>, sector: usize, segment: &mut Segment<'_>) -> Result {
+        let idx = sector >> bindings::PAGE_SECTORS_SHIFT;
+
+        if let Some(folio) = tree.get_locked(idx) {
+            segment.copy_from_folio(folio.deref())?;
+        }
+
+        Ok(())
+    }
+
+    #[inline(never)]
+    fn transfer(
+        command: bindings::req_op,
+        tree: TreeRef<'_>,
+        sector: usize,
+        segment: &mut Segment<'_>,
+    ) -> Result {
+        match command {
+            bindings::req_op_REQ_OP_WRITE => Self::write(tree, sector, segment)?,
+            bindings::req_op_REQ_OP_READ => Self::read(tree, sector, segment)?,
+            _ => (),
+        }
+        Ok(())
+    }
+}
+
+#[pin_data]
+struct Pdu {
+    #[pin]
+    timer: kernel::hrtimer::Timer<Self>,
+}
+
+impl TimerCallback for Pdu {
+    type Receiver = RequestDataRef<NullBlkDevice>;
+
+    fn run(this: Self::Receiver) {
+        this.request().end_ok();
+    }
+}
+
+kernel::impl_has_timer! {
+    impl HasTimer<Self> for Pdu { self.timer }
+}
+
+#[vtable]
+impl Operations for NullBlkDevice {
+    type RequestData = Pdu;
+    type RequestDataInit = impl PinInit<Pdu>;
+    type QueueData = Pin<Box<QueueData>>;
+    type HwData = ();
+    type TagSetData = ();
+
+    fn new_request_data(
+        _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
+    ) -> Self::RequestDataInit {
+        pin_init!( Pdu {
+            timer <- kernel::hrtimer::Timer::new(),
+        })
+    }
+
+    #[inline(always)]
+    fn queue_rq(
+        _hw_data: (),
+        queue_data: &QueueData,
+        rq: ARef<mq::Request<Self>>,
+        _is_last: bool,
+    ) -> Result {
+        rq.start();
+        if queue_data.memory_backed {
+            let guard = queue_data.tree.lock.lock();
+            let tree = queue_data.tree.tree.deref();
+
+            let mut sector = rq.sector();
+            for bio in rq.bio_iter() {
+                for mut segment in bio.segment_iter() {
+                    Self::transfer(rq.command(), tree, sector, &mut segment)?;
+                    sector += segment.len() >> bindings::SECTOR_SHIFT;
+                }
+            }
+
+            drop(guard);
+        }
+
+
+        match queue_data.irq_mode {
+            IRQMode::None => rq.end_ok(),
+            IRQMode::Soft => rq.complete(),
+            IRQMode::Timer => {
+                mq::Request::owned_data_ref(rq).schedule(queue_data.completion_time_nsec)
+            }
+        }
+
+        Ok(())
+    }
+
+    fn commit_rqs(
+        _hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
+        _queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
+    ) {
+    }
+
+    fn complete(rq: &mq::Request<Self>) {
+        rq.end_ok();
+    }
+
+    fn init_hctx(
+        _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
+        _hctx_idx: u32,
+    ) -> Result<Self::HwData> {
+        Ok(())
+    }
+}
diff --git a/rust/helpers.c b/rust/helpers.c
index 017fa90366e6..9c8976629e90 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -200,6 +200,7 @@ struct page *rust_helper_folio_page(struct folio *folio, size_t n)
 {
 	return folio_page(folio, n);
 }
+EXPORT_SYMBOL_GPL(rust_helper_folio_page);
 
 loff_t rust_helper_folio_pos(struct folio *folio)
 {
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index dae447a1ad30..f64be2310010 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -262,7 +262,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := new_uninit,offset_of
+rust_allowed_features := new_uninit,offset_of,allocator_api,impl_trait_in_assoc_type
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
-- 
2.44.0

