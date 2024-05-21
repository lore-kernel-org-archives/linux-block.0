Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995997C6C1
	for <linux-block@vger.kernel.org>; Tue, 21 May 2024 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300125; cv=none; b=F7S0nCV60guwkqpaNN/ZEOXXquL0aTRySVanPvDw884gfvngP41AUccgmXFelgFmIPjVWaw8bDbXvRfFaWvbKQe2AnqzmdLaYJhkaTUVKxnxTFIQyMK4N0/mxVu558DQzhn+BT68SIn6L4WlXInAmvgBNIUOdb+PwsHKYwYqUJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300125; c=relaxed/simple;
	bh=9QGBZCzlqj+FFJ1Y45J9aRl9xBFDHF+jLJOxIIOwF/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPx2wnJxCaarOzm6SkapztJA77OHZnFxzFCz2lrjdJQheoTKFa0uHHTH/0K9GBv8OOGpDN9qu5Dm2T2qmO15dK1WE4DlxJIvwUJsnH1E0BsUt/Uk/WNIHmLPwvzwN7wUbOar91qeZbhJ3KKE7J7+jQADGngmSsfE1RqhDuPwYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=b7/anavp; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="b7/anavp"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52232d0e5ceso5358210e87.0
        for <linux-block@vger.kernel.org>; Tue, 21 May 2024 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1716300121; x=1716904921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAOewCQLgwWz0kHK72YTOt1hH5xfEC+UYb1BKwQbRIw=;
        b=b7/anavpfp7Q0tFuZWojlZKauaWewyVnUTjuGCZfA4IC9IfQaKk8lcmFnGxrKwnrwe
         IU3IwKZnaIlMlamGF2AP55mRS6ZyAnKt2SFhWR8b3RRXjcXrsM0PZlH18uMCyBqTT4bI
         hSnxTC2XPQO3GDGErp6sVa6Ma1GWZTlOWEPl1hzz0mjw+DUVs8r+YjzmhT6juzBd9q8j
         phQMdPzcMwAYrBYRQkKSdDhibeHf8DaPmnWHroHENzep6VmCucOewoNlybKQvfPe1WIi
         F/54rCBzqhTr48nEdSovfHDjCyqoG/251/x6KKdDx3l4N7f/J1vRPBiKC3YHxZk0JfBi
         DDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300121; x=1716904921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAOewCQLgwWz0kHK72YTOt1hH5xfEC+UYb1BKwQbRIw=;
        b=wjdhf5qOfMNmaIhzLuUgWdj7xuImq+xtpoQepu5bM8Sf0lwyuEd78lMPi4GxRnGGwN
         eR4dbEBFCNU7vUHaSqDXdkIS3lvH3myMlxykaQDimufz8HYQI3hEVjDLYddRDEoTsDGT
         FJ4oltHhaRab7iakJW/v43ebbORa+/QU7/DkT7w/X1CzsRUklKP5fltNNV4U166iS7Lg
         b6oDe7IkQkRepbXciuiCv7K0vUVrckX7dSAxfdiK6KZmqyRsuJjfn1BLMSAcC21u2PBq
         4MN43eqRXzfF0+8XY7JNH9Y7T1ld9NtA61Yiv0Apn4jl1X9b/+sPg/c7sfRscLX2Cpjk
         JtSg==
X-Forwarded-Encrypted: i=1; AJvYcCVStk2upTANfhHfx62XYUZKVJjC/J0Jf9zirvDo89dzH7sHMGLxaeHYPK6dsXcOuKBdiNHbW/Cv5/M1eUCYgw6e6jHG/Iz5j9JaiYY=
X-Gm-Message-State: AOJu0YxN3u97P6QdOMwMs3n+5Rl+cx2j/tZmSdttokfvbGu3zBLVl4u1
	t93ffBHj1Yp8Zef40IBpw+gDlP8z7eTD79JUpA1s/OpFjoHF+y1mIgeXRQG5tdE=
X-Google-Smtp-Source: AGHT+IFUIWPmXj9+GXNdRE2OUazzO4sAHN+7BfxwiRRlyfE6BJecl0lNxlnzU790wHUbIwpl/QBBzA==
X-Received: by 2002:a05:6512:3da1:b0:51f:1bf8:610c with SMTP id 2adb3069b0e04-5220fb77569mr26213481e87.11.1716300120353;
        Tue, 21 May 2024 07:02:00 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed72bbsm16630154a12.57.2024.05.21.07.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:01:59 -0700 (PDT)
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
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: [PATCH v2 2/3] rust: block: add rnull, Rust null_blk implementation
Date: Tue, 21 May 2024 16:03:21 +0200
Message-ID: <20240521140323.2960069-3-nmi@metaspace.dk>
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

This patch adds an initial version of the Rust null block driver.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/Kconfig   |  9 +++++
 drivers/block/Makefile  |  3 ++
 drivers/block/rnull.rs  | 86 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/block/mq.rs |  4 +-
 4 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/rnull.rs

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..ed209f4f2798 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -354,6 +354,15 @@ config VIRTIO_BLK
 	  This is the virtual block driver for virtio.  It can be used with
           QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
+config BLK_DEV_RUST_NULL
+	tristate "Rust null block driver (Experimental)"
+	depends on RUST
+	help
+	  This is the Rust implementation of the null block driver. For now it
+	  is only a minimal stub.
+
+	  If unsure, say N.
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
index 000000000000..1d6ab6f0f26f
--- /dev/null
+++ b/drivers/block/rnull.rs
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This is a Rust implementation of the C null block driver.
+//!
+//! Supported features:
+//!
+//! - blk-mq interface
+//! - direct completion
+//! - block size 4k
+//!
+//! The driver is not configurable.
+
+use kernel::{
+    alloc::flags,
+    block::mq::{
+        self,
+        gen_disk::{self, GenDisk},
+        Operations, TagSet,
+    },
+    error::Result,
+    new_mutex, pr_info,
+    prelude::*,
+    sync::{Arc, Mutex},
+    types::ARef,
+};
+
+module! {
+    type: NullBlkModule,
+    name: "rnull_mod",
+    author: "Andreas Hindborg",
+    license: "GPL v2",
+}
+
+struct NullBlkModule {
+    _disk: Pin<Box<Mutex<GenDisk<NullBlkDevice, gen_disk::Added>>>>,
+}
+
+fn add_disk(tagset: Arc<TagSet<NullBlkDevice>>) -> Result<GenDisk<NullBlkDevice, gen_disk::Added>> {
+    let block_size: u16 = 4096;
+    if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
+        return Err(kernel::error::code::EINVAL);
+    }
+
+    let mut disk = gen_disk::try_new(tagset)?;
+    disk.set_name(format_args!("rnullb{}", 0))?;
+    disk.set_capacity_sectors(4096 << 11);
+    disk.set_queue_logical_block_size(block_size.into());
+    disk.set_queue_physical_block_size(block_size.into());
+    disk.set_rotational(false);
+    disk.add()
+}
+
+impl kernel::Module for NullBlkModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust null_blk loaded\n");
+        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
+        let disk = Box::pin_init(
+            new_mutex!(add_disk(tagset)?, "nullb:disk"),
+            flags::GFP_KERNEL,
+        )?;
+
+        Ok(Self { _disk: disk })
+    }
+}
+
+struct NullBlkDevice;
+
+#[vtable]
+impl Operations for NullBlkDevice {
+    #[inline(always)]
+    fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
+        mq::Request::end_ok(rq)
+            .map_err(|_e| kernel::error::code::EIO)
+            .expect("Failed to complete request");
+
+        Ok(())
+    }
+
+    fn commit_rqs() {}
+
+    fn complete(rq: ARef<mq::Request<Self>>) {
+        mq::Request::end_ok(rq)
+            .map_err(|_e| kernel::error::code::EIO)
+            .expect("Failed to complete request")
+    }
+}
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index efbd2588791b..54e032bbdffd 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -51,6 +51,7 @@
 //!
 //! ```rust
 //! use kernel::{
+//!     alloc::flags,
 //!     block::mq::*,
 //!     new_mutex,
 //!     prelude::*,
@@ -77,7 +78,8 @@
 //!     }
 //! }
 //!
-//! let tagset: Arc<TagSet<MyBlkDevice>> = Arc::pin_init(TagSet::try_new(1, 256, 1))?;
+//! let tagset: Arc<TagSet<MyBlkDevice>> =
+//!     Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
 //! let mut disk = gen_disk::try_new(tagset)?;
 //! disk.set_name(format_args!("myblk"))?;
 //! disk.set_capacity_sectors(4096);
-- 
2.44.0

