Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92117A931
	for <linux-block@vger.kernel.org>; Tue, 11 Jun 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106370; cv=none; b=u6OfLqG44hEBcx04v6dsRcosy6Xg5qIbAIze1nAJEE99boHU40hfORRqnZS9/THX8EH9LJZPsV16YLTnqkZoxHT40FqdGkvBXZYZGDhf/LUU1QH7f2tCYBljUJwZB5RU25kItDzDgjeQj+BP/QRDWtk2ryBeWqvgVJJ2CrpQUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106370; c=relaxed/simple;
	bh=lPk0DHo0qn2ngIxulPs6rImg+UVgHo9sWl8XWBY8tX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swuz1kn/XbZURCZHP5ft+KA1I3gCDS/Rd0nwrUx0ILZMfGkha7J0NAN2SvlMcbNHUnTfYt/wGn4FzRxpGTKJyKsfU4qMrXv1rf4XYt7a7fSNVfm1qP0od+t95+/roz0bF4gQNkmK81sp1x0OnjozObvrpqrysUOLE+ye9hwYNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=yJI1pI/c; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="yJI1pI/c"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebdfe261f9so36486331fa.1
        for <linux-block@vger.kernel.org>; Tue, 11 Jun 2024 04:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1718106366; x=1718711166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNx00mxi5pBwMfCPuGqeNzsaOgfcJX2bZVPG62r30rM=;
        b=yJI1pI/c2+3YN3q0w+LujFD2uMzICShBFLOUTOwFrEKT2diCez/cHRUgpu6QWQ3bkF
         Yxi1wcYoZJ3x6hhovfesi6NWALq23jIyRFlAVH3lPslb/K66L+NQodQdZ0XXasp6nJvE
         977/FNpCTjuB9xlfkiUicPvUajBwRuv1Cr9zjYQnIBuimXNZsOZeKlAejvffcik6MPh5
         yix/G+oUthz6O+mNsPr4JC0jayxRAcXNJQ4G8YiE9dr+/oQuZoi/Datr5AuJq0Fqk0sf
         VF53qowrkU2Qm9+BqjojeVmdiGoPh3oSRtL09LXtbiapM4T9wBPWbz3OVoCQjTCKjFn7
         itwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106366; x=1718711166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNx00mxi5pBwMfCPuGqeNzsaOgfcJX2bZVPG62r30rM=;
        b=CTMUttDWDwK+XwfV+nKNo82ONMcXfMYlhbelJvkAI7SdxRJAcR3qVyUsAWl2K/hG1e
         P8+v8aYbQK3FCDkUD7h9+JVikuPtyREs8F1GORsstsLmFZR0uhLyCi9p3s7N7OOebdWk
         LceyIGPPJJq05t7xelEa7hhVDmGFx8+u6XQ0LLDp4iqewcJubehlO2xDk/5EZ2bCg1H8
         uYQwkUVqJQpZn1NUfBx5CBLc3kMc2SnDMIg/OPnmnyR+6wiMABIYJ83nT+YvTwcJbeJz
         r/mHddWQ0Cp7Sbev3S725XGhLn5Jh4Q5i03QKgoZrNjCzIELqhhc4uhNfgksEvUfECAn
         5Sxw==
X-Forwarded-Encrypted: i=1; AJvYcCV0B3Aj8PiwyhbPei6tQ/6Rzqa7nE6lWiKiZbY5CYxAFmeKnVcn8t85UV8iiAlfBkRFfcPN/zdyte3Cx5vh8L8RXiTgp4cXvcJT4+8=
X-Gm-Message-State: AOJu0Yxt7D/cTI+45/MtBI5md5astmO9AIeH1Ye5JDIKXVAuPmVCVuSn
	VjnAzxQCSYSrFIXkrwlteGOJBHZa4HBgV8nmhr8/2inhdzGPV32+B/Sq00lgemQ=
X-Google-Smtp-Source: AGHT+IHgpG5CsbD+dAu/3bc1p58dYePXUyNLZtxPwjK2XZy9iEWocrxe9YoH3sLm0LJ0jMbPHQIzHg==
X-Received: by 2002:a2e:8717:0:b0:2eb:eb25:81f4 with SMTP id 38308e7fff4ca-2ebeb25868dmr35702261fa.6.1718106366157;
        Tue, 11 Jun 2024 04:46:06 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1c2b1e80sm290850966b.145.2024.06.11.04.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:46:05 -0700 (PDT)
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
	Benno Lossin <benno.lossin@proton.me>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
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
Subject: [PATCH v6 2/3] rust: block: add rnull, Rust null_blk implementation
Date: Tue, 11 Jun 2024 13:45:50 +0200
Message-ID: <20240611114551.228679-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611114551.228679-1-nmi@metaspace.dk>
References: <20240611114551.228679-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3705; i=a.hindborg@samsung.com;
 h=from:subject; bh=kjItG6yERTCWNvess/5I9t6qK6ZC0wX9SHch+CVZfT4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR1pvTnJ2MGdOaUV6Y2xZcGE1d2xmZHhqOWlFClpncFg4S1hoZE1kcHk2a3RM
 NnNvcllrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbWFEYTd
 BQW9KRU9HNEdqNTVLR04zeVNJUC8zSWFnRlYrdXdpV0VVYXNJQzZRTFRCRVlOQklaaGEwN1crZA
 pkNXYzcytFbTRSMmltOWpyK3JHVTRIc0tvV2J5UWs3cmxkM2VxeUVHMTlaZlYvVEszck5xYThMY
 kZFektOZFhQCnREbHNoRzlYNGZyR1ZUbnBuVmdqMG9TZUV3ZnBvaW1DdUE1MXF1dURYZW1DTFlS
 SW1BRFhCRWQyckV0cFV4dFYKZkFWelhNYnhUekJha3RjWm9HaDVPaEZicUI2TXFVdkxGTjRoZk1
 pMTk5b2picDFuNTJFclZ3N2dIWnc2WUVxVwpESzJpWjlkWWYySW9GUFpHa0hkelZjWWc3VGFNOC
 s3eDI1SGhCNTVXWURXUWhGTytLeVFQQStCT25UNzlZeVNWClFDRlA5b1JkRFBlckMzQ3l5U2EwY
 kFuN01RQkwwTFVSS2x6Ny8rUHIvRGtFNGlJb3hhNVVIbzhyWjltVEVVUmQKeDIyQURaM1poRS84
 Z3YxR1M1VFVQTG10NkN4UFVVQUpzYlduNlIza0M0eTloYi9XeHAwcWFmZDM3WlM4WU5zNgp5Q2d
 2Y2hWVVZKZllKNGZWYzFFTWFWbnFDcnBDNGsrU2wzR3JhMXF1MzBhUjZheTM2RUU2NDd1R055MU
 0rZjM0CjN5U1hlMThUNG5uTld5RGJVU2RGcE8wNktyWU93ejB2Rm4wZ0tHWFRSaVRJTHVEaVJoe
 G1ucDg0UVBLMk8yUjkKeVVUVTFnR2dRL3RmY3VBODdGV3N5OCtUckgzVVV2WDZIOCthdkNOQ2xq
 UXY2amtzTGpoSitWQWhDMGt1NFFCUgoyZTZpTVg1aDFLRVF0MUtBeEFwYmxlcDluOGhCYkhBZnd
 CdW9xRjJLUWwrenVYRS9uRFdmU3pKV20rN2dSaXQvCkZMby93TUhnNFBJbjNnPT0KPTVHazQKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@samsung.com; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

This patch adds an initial version of the Rust null block driver.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
 drivers/block/Kconfig  |  9 ++++++
 drivers/block/Makefile |  3 ++
 drivers/block/rnull.rs | 73 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
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
index 000000000000..b0227cf9ddd3
--- /dev/null
+++ b/drivers/block/rnull.rs
@@ -0,0 +1,73 @@
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
+    _disk: Pin<Box<Mutex<GenDisk<NullBlkDevice>>>>,
+}
+
+impl kernel::Module for NullBlkModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust null_blk loaded\n");
+        let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
+
+        let disk = gen_disk::GenDiskBuilder::new()
+            .capacity_sectors(4096 << 11)
+            .logical_block_size(4096)?
+            .physical_block_size(4096)?
+            .rotational(false)
+            .build(format_args!("rnullb{}", 0), tagset)?;
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
+            // We take no refcounts on the request, so we expect to be able to
+            // end the request. The request reference must be unique at this
+            // point, and so `end_ok` cannot fail.
+            .expect("Fatal error - expected to be able to end request");
+
+        Ok(())
+    }
+
+    fn commit_rqs() {}
+}
-- 
2.45.2

