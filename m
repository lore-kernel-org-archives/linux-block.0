Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A71862A
	for <linux-block@vger.kernel.org>; Sat,  1 Jun 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717229928; cv=none; b=rq+DggXrv9DrEg0NcjRWRtSSVTX1oCjKnSdyJRzbaDhtVwrI/GJ0ywbYZr/RaRplf39hUDctUNEBqtFLm9XW0EbVKstQ1ONeHCUfr1BQxW5ddBe7uUomY19SDmjJ3lDRTfWFdNo32TxaYfx9bvEAXwFVcN4og1KlFM4ZnXAnm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717229928; c=relaxed/simple;
	bh=xxWqpl1UdnywoGWPzNscyuITvW0QBkWeYUsr5RBxzmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTASg8PbZuJKlORxkqNy/kwp1dbiHiq+0uysbeo7QPcMT/JGhkZXXjALFUU6W0K/aI9iGZcObHNnYfzBAAu0g3WwI8UAw4pbJDrOYTC8ZONIDPsrrxbB5366EgNo8gV2velCZ39K31J8JMzgVAhgsM/l/w5zVVqGydOxP7/OKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=eJxDZP01; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="eJxDZP01"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4212b4eea2eso15357125e9.2
        for <linux-block@vger.kernel.org>; Sat, 01 Jun 2024 01:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717229923; x=1717834723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ezr2Hn7aYE4LisG36b3CCgZ1eNVAXC/BdifcIJ9Gh/g=;
        b=eJxDZP01RE12Ow5uiqojL960JA3eZBPkJP3HJrnGPowx2BF8zNST4kochCWKJUYTME
         JcBxjrykJy7p7kHaU5A10+rLePtKc4awGjNNzTmkFojl0mSbBhqnbZdUTTpPuDfApXvL
         eRBrAJkATfLXJ7U1aGb+oUOEhAfBvrqyDQMcFNU+7jOACvniNotXDBNhkBoslspGV1xe
         V+kwxVLuHeYIOZQF+6qytHW6DGwsagf1uzvbAuUNWIpOMy27mzLBSPnjUrdXIIuX4VYn
         E2g6vz4Y8nc7J2c2yElVpj85YyeUCmMTcYFyF3RAEBbySWHECdmTgkTImkJC0qEutLdA
         kL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717229923; x=1717834723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ezr2Hn7aYE4LisG36b3CCgZ1eNVAXC/BdifcIJ9Gh/g=;
        b=RCVaxB20dOIJYt2ZLZsB6125YSHiz2werVhxy6ptCFabVOWpRkYwUXgZzIHacR1GcI
         AKZq4UN/zUeQFwAqpMe8x/TyWfC391iVpIlpQlHGzJvaBPlDi+c6xgAt8GRnAzQfA8fv
         mPK3DuKbaZjWMofKkcHKWMbGB4qwGrQVkfutRHPvIbnZNSoMs3B7acXKRObby5bgCw+d
         G/FvpgrqATBE51GkuFi8xmzqlobg9jX4IjfrVH0pdjcIsZwlsrzmtKuAAuEIVFUEC1fU
         a7gO+U/8ef2sTqmVJ6giFqTLylX/3HZhcMZJ2tKEfRb5BHjxThUkM/AS/j4nekv+s9+x
         E62g==
X-Forwarded-Encrypted: i=1; AJvYcCXn/JO5IAh3mN61w7tV7hMiNkLr2U+N4qiQmH1AqDezW29UTk5Q7Kdn/BO7jrosIkxgOKPY0IZ6kObFyl38RQb5UcM51cA8MxbVZNY=
X-Gm-Message-State: AOJu0YyM/AA43X3IsfGkDdODTmI9hqM2KN7j0Na7i39cxE5Y4WD3zwnC
	0T1LG9F8/ICxhBZzlxyt1CZZs4r93ZwwaVuipEaNdIqIWB5Y2uGa82/bmznw/Ys=
X-Google-Smtp-Source: AGHT+IHpd+LENg5dHNFlBGYBkOjy1e0oRkRVjYuFUJ+QrqrtY7phJ5F4szd8+0gpfnXQvmJCAEK5xw==
X-Received: by 2002:a05:600c:4f82:b0:420:509:714f with SMTP id 5b1f17b1804b1-4212e0506admr33697185e9.14.1717229923493;
        Sat, 01 Jun 2024 01:18:43 -0700 (PDT)
Received: from localhost ([194.62.217.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8b76f3sm46977445e9.47.2024.06.01.01.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 01:18:43 -0700 (PDT)
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
Subject: [PATCH v3 2/3] rust: block: add rnull, Rust null_blk implementation
Date: Sat,  1 Jun 2024 10:18:05 +0200
Message-ID: <20240601081806.531954-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240601081806.531954-1-nmi@metaspace.dk>
References: <20240601081806.531954-1-nmi@metaspace.dk>
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
 drivers/block/Kconfig  |  9 +++++
 drivers/block/Makefile |  3 ++
 drivers/block/rnull.rs | 78 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
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
index 000000000000..c69ea7e7436e
--- /dev/null
+++ b/drivers/block/rnull.rs
@@ -0,0 +1,78 @@
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
+impl kernel::Module for NullBlkModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust null_blk loaded\n");
+        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
+
+        let disk = {
+            let block_size: u16 = 4096;
+            if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
+                return Err(kernel::error::code::EINVAL);
+            }
+
+            let mut disk = gen_disk::GenDisk::try_new(tagset)?;
+            disk.set_name(format_args!("rnullb{}", 0))?;
+            disk.set_capacity_sectors(4096 << 11);
+            disk.set_queue_logical_block_size(block_size.into());
+            disk.set_queue_physical_block_size(block_size.into());
+            disk.set_rotational(false);
+            disk.add()
+        }?;
+
+        let disk = Box::pin_init(new_mutex!(disk, "nullb:disk"), flags::GFP_KERNEL)?;
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
+            .expect("Fatal error - expected to be able to end request");
+
+        Ok(())
+    }
+
+    fn commit_rqs() {}
+}
-- 
2.45.1

