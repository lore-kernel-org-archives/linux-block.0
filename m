Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6183009DA;
	Fri, 22 Aug 2025 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864940; cv=none; b=VFbCdiUJJeunltveCIqcIB30B/pifVQ+6Rdi8AkBFSwOsHWHUoTJFyBPDyXpYtozsxSjvSRcWfSs5DI1BonnNCsH+e9vCiWnPBlFYkM5DbiZ+ok2FKNc/JsaHnzVp0k9jJq1U9cxUtGkTxHyXZvDlWaus1ntOc7I7lYoUYR5DKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864940; c=relaxed/simple;
	bh=pIuBZvrIaCfOxk5R8QT6fU57Jtv4V7ScNiWvZ/2peFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bp17TVpEDQxfFDOxfeSBs+EkQ++RNnvH+QVFGQQh1OUgt9jLb1YZArUqmL0siaR7JHmeo1mkdrDVcPnIYqHtQmtfyV+o3o08Tb5X27B2zl7i9B+7n/0/ZgteSzRbp+wID9yQI1li8UO33eabOaxTQ5zzUguhLjcCW5uvmBCWN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSd+jrfY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSd+jrfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B2CC113D0;
	Fri, 22 Aug 2025 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864939;
	bh=pIuBZvrIaCfOxk5R8QT6fU57Jtv4V7ScNiWvZ/2peFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rSd+jrfYFV5sW5ZHN15MdlosaaP5RKDfXXjcYs35eYY+tzxYF6zKhp7OsBQKLDdaz
	 eZwtaJh4IR9JAD1SNQukCbLFZgSm1Ao5IuEgkJA66YfQRLRTr3RLRuhxIFCkX/1VR9
	 fS0b2sUDoEw5pQ3+0NrsSCDmpFjs/Whu0QfZeGCIyfsVmVWUsV+bYhZ8zDS5GnY6oP
	 vT7NZmb84gIyOrlr6hqIfKgTPP6duwTpVea/ubfEXZHmdq1mOXN8quQ0vw5agYZkdr
	 UbQtHFJqEm3dBUEHIvXxDdAUVW0y6PYwgr2DXDLZxA/KdL0Ci3b3dunk8Kg6qKTRM7
	 IPevpiYDSuJ2g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:49 +0200
Subject: [PATCH v6 13/18] rnull: move driver to separate directory
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-13-ec65006e2f07@kernel.org>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
In-Reply-To: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3780; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=pIuBZvrIaCfOxk5R8QT6fU57Jtv4V7ScNiWvZ/2peFE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF89GOSg2qFj2udURlTwvSVv2liyoM3WDOLhl
 v8N4YeKOXWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfPQAKCRDhuBo+eShj
 d0bED/9uBA/z+Yy0POTVykqZ537WGT9ztvQilq8u2+Ai3d8yzTH5Krr02S4mdyFwsf4wUguhMmL
 fLv76qn0kC5TvT5VfRajnrQdBLZRY1Jw6j06n4LG/Bw4g5wtAaci9iXmtVlhWuS/ydHqKEMskLI
 ARZgXKz2+ot+ucaE3X9Yn2B7qyDkp/WBqPXQRC79XDdyYf922d2UcMVkhP6vkpAjhtDJd0jb96y
 fPHFXOZ7IK8hdmZLI9G8G21jt9psa/MneXoCt/8vvjrEG0Rtfm4t/CSSOzY4yb3LfN29Vp72uDG
 6DZ1ANddIM9VooXMiPSyBbz2RoJTPU6Un6u5dvDHWE5AmSejAQTECnKTe8FeuYVm8A3Aa/2IUtg
 YzOCr1N7Z3HNVuL/4ekdVsah4WCTByqofL4GoDkEuvf6tPhGrHRH3O6zgtK9UH5ibOEbl5TSdAh
 kfumZcxXFrpqFmDSZeVdP9RSAv5/0JmyuuKIsrkZ/FuDlupCE4tU5+nGOpLey64lAqrmjhQ8sLW
 dHjgvpUNX7KuZw/Na3sGmELVE6xtMCwP7EUYNzbeU5ujTqnDsrGZTzqcX5lRByIvl+wbklymWta
 4OCV2Ad9cKa2JQFVeWfxOjhu1ToRVoUAZifc9Vd72KYPkSwAdobXxhfbgDXiBEKnRHt3TcVpUH2
 6QVem7vFQOUnGlQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The rust null block driver is about to gain some additional modules. Rather
than pollute the current directory, move the driver to a subdirectory.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 MAINTAINERS                        |  2 +-
 drivers/block/Kconfig              | 10 +---------
 drivers/block/Makefile             |  4 +---
 drivers/block/rnull/Kconfig        | 13 +++++++++++++
 drivers/block/rnull/Makefile       |  3 +++
 drivers/block/{ => rnull}/rnull.rs |  0
 6 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..d5addcc4b132 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4343,7 +4343,7 @@ W:	https://rust-for-linux.com
 B:	https://github.com/Rust-for-Linux/linux/issues
 C:	https://rust-for-linux.zulipchat.com/#narrow/stream/Block
 T:	git https://github.com/Rust-for-Linux/linux.git rust-block-next
-F:	drivers/block/rnull.rs
+F:	drivers/block/rnull/
 F:	rust/kernel/block.rs
 F:	rust/kernel/block/
 
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index df38fb364904..77d694448990 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -17,6 +17,7 @@ menuconfig BLK_DEV
 if BLK_DEV
 
 source "drivers/block/null_blk/Kconfig"
+source "drivers/block/rnull/Kconfig"
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
@@ -311,15 +312,6 @@ config VIRTIO_BLK
 	  This is the virtual block driver for virtio.  It can be used with
           QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
-config BLK_DEV_RUST_NULL
-	tristate "Rust null block driver (Experimental)"
-	depends on RUST
-	help
-	  This is the Rust implementation of the null block driver. For now it
-	  is only a minimal stub.
-
-	  If unsure, say N.
-
 config BLK_DEV_RBD
 	tristate "Rados block device (RBD)"
 	depends on INET && BLOCK
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a695ce74ef22..2d8096eb8cdf 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -9,9 +9,6 @@
 # needed for trace events
 ccflags-y				+= -I$(src)
 
-obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull_mod.o
-rnull_mod-y := rnull.o
-
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_SWIM)	+= swim_mod.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
@@ -38,6 +35,7 @@ obj-$(CONFIG_ZRAM) += zram/
 obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
+obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull/
 
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
 obj-$(CONFIG_BLK_DEV_ZONED_LOOP) += zloop.o
diff --git a/drivers/block/rnull/Kconfig b/drivers/block/rnull/Kconfig
new file mode 100644
index 000000000000..6dc5aff96bf4
--- /dev/null
+++ b/drivers/block/rnull/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Rust null block device driver configuration
+
+config BLK_DEV_RUST_NULL
+	tristate "Rust null block driver (Experimental)"
+	depends on RUST
+	help
+	  This is the Rust implementation of the null block driver. Like
+	  the C version, the driver allows the user to create virutal block
+	  devices that can be configured via various configuration options.
+
+	  If unsure, say N.
diff --git a/drivers/block/rnull/Makefile b/drivers/block/rnull/Makefile
new file mode 100644
index 000000000000..11cfa5e615dc
--- /dev/null
+++ b/drivers/block/rnull/Makefile
@@ -0,0 +1,3 @@
+
+obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull_mod.o
+rnull_mod-y := rnull.o
diff --git a/drivers/block/rnull.rs b/drivers/block/rnull/rnull.rs
similarity index 100%
rename from drivers/block/rnull.rs
rename to drivers/block/rnull/rnull.rs

-- 
2.47.2


