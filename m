Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF012EB1D
	for <linux-block@vger.kernel.org>; Sun, 12 May 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715539129; cv=none; b=G/OnJX2HqNZKDlXXONVq0UcrL7wpHoPVuweLKtjYDnF/dGFJ6+R20vdd6eFQx15H2COYmQqPnK1+R0xxVHBUwMumUx69i+pbq/wr17/G4fBYSyb4N5I4gfR7ms6ewYuULjqafiALNnaMPICwfPojwsXsROjWwXfn/Ere0NCV7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715539129; c=relaxed/simple;
	bh=zQhfFMtf/32xi+lYgTG1ULLlEVWmIik5yzTYXylWDOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acABlQlsI7psS104vcxHhqKY6nMF91H4Vc6JDxZfbHi/0MLfhg1zz23o5VLEV6AgsRvJ3zEfeUXTpd1E4pPzDEvYjoO7uoiLFEYQsNtOnsTqv5MqD/8lo2NRZ5LpxRry97OnEyH806cwR/Tye4DapH7sGz0ig/iYePqAmKI3R7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=2FoCPYHA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="2FoCPYHA"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-602801ea164so2539234a12.0
        for <linux-block@vger.kernel.org>; Sun, 12 May 2024 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1715539126; x=1716143926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEs+Uy+D6yRLJ6uVdcGDdXVWWb0Ye6WAdIDQbGkZrM4=;
        b=2FoCPYHAqXOoD5KsQOx9WOsfZJadt8Et6fSsgmLIbI/fcqLjn8ZLtLfues+3w4tAaW
         nWmbeOctmqsIE1PPyFLXyeALWcntAF0iMPM6SkH8GS5OLeE1A3kcjYEwFbi3lYeq2wOO
         2/uDv1HZCp1MHYmcNa+1E1ipRTpm1FbCSgr0jTSfs2ne/jNWM226GejUxwsB96J6Q0AZ
         RE2h4RtOIouGpC7ew2HwpYZw7cuQh+mjUjPhjDMq3N6bP11aSq9dH5qzuxw7wunOHkEF
         AwfNsqHqEKSdNWEhvbp3I7rkywKyr/yWFt8O4UcrrAmochkYaOTN005ESzxLdayb0VSy
         4G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715539126; x=1716143926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEs+Uy+D6yRLJ6uVdcGDdXVWWb0Ye6WAdIDQbGkZrM4=;
        b=SmYfLOkfs/4mr6WYUxicpVM9LAsMwPnUZt7ZC+9L9DHomUTp8P5ijOD6tYXRiiBnZ/
         bBmorrll4WasL4r+KBinGIFU0unM44TQ+ID+N0mJjDLfgP19vrfWALYsYsZqdF8Om7Fx
         IsG2w/m5iUqLl8qZ2XrquJ/iNjWmNptmfHArX3ubgWOGRX7O+zHgbVDqchLtZBGeOnHq
         jp0jWkuwVQIRHcxZ9lGWxharftADO6Ui1aZTKWlZ1Hz72LslTkNHTnlS96o8kJgMMZmj
         B/gtTCG6KkHPxhiXMjg6yrVDjWqbvUe8lARDOzlrTdUYOjo0qwFQ8IgBebmHhdCp5JW/
         bQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCV30HHqdnxviNAZxaLdQtGL3gl3Xe0A6HMwYFE+CQxkGslB/orxOGEHj/fSvjRH2eLVtkFn4/m7R8yJEajsI2SziRkp0/DmN1HJIi8=
X-Gm-Message-State: AOJu0YzhsLh9yM2G1eAfgiX8GDRljLiiEMQ4YgmO878tUxU/FICwga4R
	qC9imPy28XOX0Ku5AzqU+tflIcZFhWgR3O0tD0drmz9rJSUC7697J5JCpqMHBis=
X-Google-Smtp-Source: AGHT+IFzxn8oM9sRHT5lPi1yaMqFudJyCRrmgvRN7lZpQ2U2sZg3XiNi4QXfSNB23XmaVSG/z9g+3Q==
X-Received: by 2002:a17:903:41c4:b0:1eb:50fd:7875 with SMTP id d9443c01a7336-1ef43e2323cmr102491605ad.33.1715539125697;
        Sun, 12 May 2024 11:38:45 -0700 (PDT)
Received: from localhost ([50.204.89.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136a59sm65200835ad.237.2024.05.12.11.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 11:38:45 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
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
Subject: [PATCH 2/3] rust: block: add rnull, Rust null_blk implementation
Date: Sun, 12 May 2024 12:39:47 -0600
Message-ID: <20240512183950.1982353-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240512183950.1982353-1-nmi@metaspace.dk>
References: <20240512183950.1982353-1-nmi@metaspace.dk>
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
 drivers/block/rnull.rs | 82 ++++++++++++++++++++++++++++++++++++++++++
 scripts/Makefile.build |  2 +-
 4 files changed, 95 insertions(+), 1 deletion(-)
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
index 000000000000..80e240a95446
--- /dev/null
+++ b/drivers/block/rnull.rs
@@ -0,0 +1,82 @@
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
+        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1))?;
+        let disk = Box::pin_init(new_mutex!(add_disk(tagset)?, "nullb:disk"))?;
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
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index baf86c0880b6..603dee4b66c4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -263,7 +263,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := new_uninit,offset_of
+rust_allowed_features := new_uninit,offset_of,allocator_api
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
-- 
2.44.0

