Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCC2192F9;
	Tue,  8 Jul 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003939; cv=none; b=VIwoFOUsLYBUiTX+pn4OlVjkgpva1lEItjI9D1IrmI4IeVolTEWgVCpLmuvOvqxN0xIEx26W9KzXw7wZ2tyl9EYCXimD8aPUuu/TRWxHPgergQwbZxHXk3WNxCqbyya22p0yy/gEcs2U7TEAY86H0641YSFmjIEzAc3BoLZxQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003939; c=relaxed/simple;
	bh=CTNIjJksV39rh1vFRofP0gEi36ZUmiBHOsMajM2KEl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=De4lmhlKLvdPFPJaaoQ6CcQeGg/wWUvaKrRjiN50mdFIvEUXCV3kVANfGQp4yAbyA0FfYRA9KQrD4Lh9ef7WKnsq/mQN/fqEp0C8MW8Ioe+MuMTsJneb4w/fWYOnzzUWZ8zTlCIk/mAq9MoW9moyHvYJgWo9G0n5hNWSayv+bJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uR0kh2cr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR0kh2cr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D22C4CEED;
	Tue,  8 Jul 2025 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003936;
	bh=CTNIjJksV39rh1vFRofP0gEi36ZUmiBHOsMajM2KEl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uR0kh2crNrboAt87xB96IzHU+EicAu2vZIpdaro6u/wXy56susc+EOCfLvgOKAP3y
	 tE4df7XUEpvmSGjZeWN3ubj6kPL1zW/vHtPTec0faxAcvC4WBMaB63ZBPORuvvRSTN
	 38ctoc/ICnR0GVkXErQ3RGhO6Z5qZypnklztmaGawOOa33dRzLW7E72Wd5VNzwREtq
	 /LkE9ZZpFNUqRpLFeApAm6492nmRPEQwZB0k/zkC6Sz8RNzABiXLdiupmlJTx3wx0e
	 Jkx7nSADRJhW4hTJR/tUbhYWGhpRLLoZ6FC1go1kIQxjbb1aiG6YUJ9y8Dru619AFz
	 aot+C7hxcV51A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:45:04 +0200
Subject: [PATCH v2 09/14] rnull: move driver to separate directory
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-9-ab93c0ff429b@kernel.org>
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
In-Reply-To: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3682; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=CTNIjJksV39rh1vFRofP0gEi36ZUmiBHOsMajM2KEl0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVIHFJxLawG6BbjGd2qf1DI9BWdswMqTl91c
 VwaqS1iL12JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11SAAKCRDhuBo+eShj
 dxDtD/wKS34qv+11LdMaa9Lkxb2/fdmDkQcNx7CBaTf0JLBxSwmYuom1Vz6ozCbTioAgh8t03mc
 SKAin0ySXlz/dRuG46NzFumnQEnwpkPr7fwAwp5VrqAEz0bBfUHQd9tE8L0pDeOhuh5+d1oeOWn
 CVOLacjT6Qds2vSbIngsgHFKr16M9Tx2Wy0DRwcBm/1Uy5HuCV6aUoUARisIPZr+rk6rXtZ3kS9
 GpadYe8bpRAJSofdh5DKsTsz+6y95y2H95y0C37j0YMska+7w5Fb/kZ7d0hnyJD2FGTJ7BjWl+q
 I5C5vfDq/rcKAHW70W+cAbb7PMommxqToEwbsyf9P3I8/d5LOepTPWfszwWqtgFT+JV3bfvuTGe
 dqEYJNgHFeXWHBWYrKHxbbccxlOYPxqGpFJknHJQ+k67NE4lzKiJ/7FXi8W8C29EnJHWzNWwdI4
 8ZVeP218YHwcSIDSUsJ8ldCqHJeF79ERoK8Hn+HFzt7TIT5yw509FH77zULcyaKK+RG0HkHYxY8
 GqC3oK8vvgRRXiyaakMIukJZDqLLS3SnmXSelojyhhPFxszoQ6HltQFRAzWXBXEtcHIxvUz0opk
 OWu8EyfLtvc8jkQVbqDWdNV6AkOZwkRsQNx6rc2yHwfaY8vcWwJZeZdMJl7O7+l7oF00kqMdRo2
 Mc+o1v+5Q243dWg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The rust null block driver is about to gain some additional modules. Rather
than pollute the current directory, move the driver to a subdirectory.

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
index 0c1d245bf7b84..29b14aec3559f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4246,7 +4246,7 @@ W:	https://rust-for-linux.com
 B:	https://github.com/Rust-for-Linux/linux/issues
 C:	https://rust-for-linux.zulipchat.com/#narrow/stream/Block
 T:	git https://github.com/Rust-for-Linux/linux.git rust-block-next
-F:	drivers/block/rnull.rs
+F:	drivers/block/rnull/
 F:	rust/kernel/block.rs
 F:	rust/kernel/block/
 
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 0f70e2374e7fa..6b50dbc0495ba 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -17,6 +17,7 @@ menuconfig BLK_DEV
 if BLK_DEV
 
 source "drivers/block/null_blk/Kconfig"
+source "drivers/block/rnull/Kconfig"
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
@@ -354,15 +355,6 @@ config VIRTIO_BLK
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
index 097707aca7255..aba3e93d5014b 100644
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
@@ -39,6 +36,7 @@ obj-$(CONFIG_ZRAM) += zram/
 obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
+obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull/
 
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
 obj-$(CONFIG_BLK_DEV_ZONED_LOOP) += zloop.o
diff --git a/drivers/block/rnull/Kconfig b/drivers/block/rnull/Kconfig
new file mode 100644
index 0000000000000..6dc5aff96bf4e
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
index 0000000000000..11cfa5e615dcf
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


