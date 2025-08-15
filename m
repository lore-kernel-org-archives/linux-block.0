Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6541862;
	Fri, 15 Aug 2025 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243131; cv=none; b=EX9zDYKHhOhpe84rRDEr226n+0H50BvWf1seuyOvJzSEgkq0SFrc60SF/OaW8sd6d1ZdGEj1Zz69zOlHvfxNLzJAPM4qJpC1ci3vpTw/JRmyraRpswadMOgaotm/1pwAA4mDdNb9W/4wPjA6XyjfSIPx+LlUmhWKUBCD72xARLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243131; c=relaxed/simple;
	bh=tDTjZd+5UIJEcvpFCoWeOEwqbYXX//kOhz1DDrET25c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ieTWhbmny6IFR1bMRUbXXf7z3IuwAfQACA38YHK+NkwUpJ+S0Ks2ghbCE0OYOMboEmpPfowxSlbM/w9x1scRDVqHc+wp2yg4/h8q3VTEBxF+53wjm9LLHGaUqbdCOgpnAPzJ92bPp54RcupytAoSwcvHjk3ZVhd1mkdATmLJF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDcbsEV1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDcbsEV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8788AC4CEEB;
	Fri, 15 Aug 2025 07:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243131;
	bh=tDTjZd+5UIJEcvpFCoWeOEwqbYXX//kOhz1DDrET25c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YDcbsEV17vKg5yNg3jhua6TpfMDCrYxRYSYApBzAJRjXbFvvTDgavmn+GwaOfQPl/
	 aOOB2YhoKPwGB89x/n+KPrCp8fS/b1Tr/+W/T0GgM1/loMRmZHRWbC3EsBrbwYCoNO
	 hi7e8Al3LC4M22WZb1CArlLbvYJeJoj0aL3B18kANSLAmagwksniceeGe4hp44rKot
	 DtSr2x2HJc3DX81Efuy1rmmeYnWzl4d2wYmmOvmwPRURwnkxVxyFzuZY17v+TaE/X5
	 x4KcDDy1nhk95JgUF5WNlkgKV0pLZ0KFy2wGAPv/tUaeLh23zHd555xueoxf+ga0rI
	 bFGqPp+VggiUQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:48 +0200
Subject: [PATCH v5 13/18] rnull: move driver to separate directory
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-13-581453124c15@kernel.org>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
In-Reply-To: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
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
 h=from:subject:message-id; bh=tDTjZd+5UIJEcvpFCoWeOEwqbYXX//kOhz1DDrET25c=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI/zppQBSh4S5PYaROLGl1XUozcNfMmlZp+h
 UE23fYlUGWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iPwAKCRDhuBo+eShj
 dyjzD/sEfxmAJJGV82v1PYByIK6AiUOX96rXEi/OAnsFfL5LqQ+6kSE/69YAqRcHbUDbpOaBxPf
 g1uW/2blFH06dtp4FPI8tiQWGnl0erMVSzp0UqOsrSThL+iupGCYIJHBQfMKZml3eTYY48Jbdjb
 wilRQrUnGbweyE3983kMSM6cB9b/3E1+2wE80p9bmfKnkz6Gjghwttwhep4bT6ZbU5og/fAiI5d
 z+OqPsQ9wuBbieToQMLzpx15J8acg+tyqMPzbtCvkKMkquVIc9Yeyl8ZgDk5kp2kK4YBbytTNbU
 aG2YxsQom3Rn1La48g5pPXLOZdvy9TX0fE9CMxzSUw1e0hE1ET+Je6+srbMO2TrkICrD5klvSGX
 cXnqsNVmJE3Jnjaxj1BIkGwgVmZ+NS26SkPFfJZAUFG+WuQH5K79R/7eblZ98ow9cSL6wBXT9tG
 bNVqKce9t6x0uSGEkLHQ6mqzgx3MfuYSBCu2FOPWzDGK7BeS909JPFvp8niHJ6I0FR6wOIm4sKz
 sIEavpa5JBw28aTHUsEtu6rE/wn/fJJrlhgyGkMHxfHpHhOkbCB5Rju6SuiCc6shTJ6TIPTPdhH
 zOd0AqCeo8JRTT9FjlEWlrKES8gJsZoBN8ZQzwfYNG2fBwtTLao6BKIXaHrpNhvLcoLkOdNw2Zl
 rHLc1kJQmoofZfg==
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
index fe168477caa4..238ff10f537d 100644
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


