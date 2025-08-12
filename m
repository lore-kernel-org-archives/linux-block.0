Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DAA2E6107;
	Tue, 12 Aug 2025 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988368; cv=none; b=akfsq6NreJQDakHK/XpFuqs4agymFCvQrpsqGrGQiO2mZCDmn4cvQ6J89rFYRSRc3fwnmyvTA8CGWOVqloqWFsYFgwDBsPOy2/CljRGBp7p8dnD2sohqbyF6N4UHLpMFWU7xB/GCp9avlY/kCLMCrMUqT3AJ1qKps96qWRCWNuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988368; c=relaxed/simple;
	bh=tDTjZd+5UIJEcvpFCoWeOEwqbYXX//kOhz1DDrET25c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6WmUEZKzHVdiWcElUfun5D+bVjFEyfsHB6JwuU4Ng1FQifkHpW3y8bscy+V1/o5/8G5P8sxKIkyjNwc/AWN7T3kqWEAtyKyqsOARVAE7JZeCs1S7ZTp5an/Ks9+jpguTVAlkjWTZwJ/MKxbDGNgp/5uFkv0sc88YWx/ujel1+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2/ZV494; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2/ZV494"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE835C4CEF0;
	Tue, 12 Aug 2025 08:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988367;
	bh=tDTjZd+5UIJEcvpFCoWeOEwqbYXX//kOhz1DDrET25c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E2/ZV494mudYHlpgVWjNxKISJG5UKWz2Awf8/cYPMJ6qjumpq4TmPuAppcOGdAjZ1
	 1zTQJEg3pfpZb+xmfBk7/9jT67HAvCk+iWF2uXnm4oQFpN57Scn9uEtB7HdR1xcfKH
	 RsTEEILMY5QQMzuTFzhEjqo9wCN5EE771VLkmFzMCK9YS94a/2P1w5AOM5fVfPt3nn
	 a5M8MpCwaJhUkM5ISAAosMTXQfwREPzymhcOwSo87gFquUZ8FAbJG9kl6vP1Q2aUdc
	 VOOXaQxgg/8TQp0gt63t7DM5edl0LjbVAOMSfEJZ3dlktwKyf/Mh4FK5uTbIofcBol
	 KxhwQenE02C7Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:28 +0200
Subject: [PATCH v4 10/15] rnull: move driver to separate directory
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-10-ed801dd3ba5c@kernel.org>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
In-Reply-To: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3780; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=tDTjZd+5UIJEcvpFCoWeOEwqbYXX//kOhz1DDrET25c=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8kZJmuBPEmYZwNzs7rTnhXXedH/LLv8DpHm
 eoutnNRhUOJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/JAAKCRDhuBo+eShj
 d976EADFMv1LwdnrO6N+MsaGRv7g04OnsuBx3fr7YvQlmiZXMJGqcaaLlmwUFgQPniZoMxdZS3X
 RF6Dws9/nQLErDnWiL4CJ//u9xQbhLwyCvvudPDVBqN1VN7lZVZd8Ga0OQVxVHF0Mfxi5VPAI3g
 6mPfRsmjyIdw89URV13hAeqSsV/OaZEgdqwaQWqGYE86n4eQ/4P+as3Y0nb0oYPzizbLmZRg6n2
 NnCRjJHtHFPpO/XqDC9gVzP1OfN/hI9sn/kFkxhxhVmw300qt4aPUAnz4wM3nOYpzEGLQoiuvij
 WpQGt7BE83wcrrrquXjmsFBzetbreIrhI2IK3Q0SJBR4ycHDV46UIDqJXgTxuY/9kgBOO0c7AAd
 vTRefLLgNHf93tIoSFAkxeNd2y9RoPTw7jmFi96i1n3nHISk/dcY549cT47ip7BRfyzy3AUZ9OI
 qQE5Wks4WDDb8wV8iEI3GIZxtaV61Qgi31uayuV4/40t0CRTr8Q59z0OCe1iX2EwWfY7u0Fm7Lt
 x0VpVTlLsN5vjAhW3ZWaJstL4QJyc0CX9EFxdtkiCh14tpcJs4jYyklEqWy60n1xGhGMeObDBMW
 zaIWVV+oTbGjNiu1Vio3oLxaQT26CufZl5Hd6zxMuRptKtM5usmaIl8BL3WexA68NUte/Th+qSO
 m3nDW6BgFoZg+7w==
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


