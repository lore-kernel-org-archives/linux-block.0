Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196982ECEAD;
	Mon, 16 Jun 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080378; cv=none; b=htocEjOMHkW2vlU/hp1Hj7qAbY2dWgRX432HMXFQkueu+wpZjqLhVIxPrVYawpDCiUX1TiyzdtqImoWwN+Z4yjrDpdJBIDhiuHYs4sZv6ta0CRjU3QxkHMASqQXTUBdIB+tbDGXQAgvZj8xDR24nkR+AT3iXTXDBYegBIAdp4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080378; c=relaxed/simple;
	bh=7kKEIeuBmyNvAHyL84OBtlsy59K5vqkobCWeseIJrWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRvPixE9lzbUgnKIL3ZwWXSqGLNi7eu7Mw/ldaFZbmfU3hdIm2omJO5k2aOt9UU1t7lx0rCP1ljqbFVVZYEHudPxFq4acuI5KQPJQsRE0pnf0kXiBKAkUT6rVIT01Qq6WsYKIpS0hCeYVGdOwL7aau9by4NL8uT9eAvlwi5n4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPgCMLga; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPgCMLga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1070EC4CEED;
	Mon, 16 Jun 2025 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750080377;
	bh=7kKEIeuBmyNvAHyL84OBtlsy59K5vqkobCWeseIJrWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jPgCMLgaC1cj6E4EQkkfulSy6mf13vILeDY5T4XNoZ6V9vKc7EhaQ4jeyExSAjWLc
	 0MF4XIsQCSFSRERpBtDPImVYAVmd0CjoLoWsrSdRqPgqN+8GagD2+Dqr9H70VWNiRG
	 9tOLjkyj9spKeYDaUdq3Y2IxB/EQT7osGEeq5PkmKNtvr1eCqIGzJA5vR6LN1CzunM
	 aBm/RB4fWQ4sgZJXRRkAloAh6XzoXai/y5Ml1eqRrkVfC/td/MiTf36fzlm4j3emCi
	 Fh8mpA+bXYbYLCiURhGCJ47EFSsIsa7FXPNwUFydggg0pA5ItQsekIGGiDXMv9Xv9r
	 aJef3LkqNlJJA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Jun 2025 15:23:54 +0200
Subject: [PATCH 4/9] rnull: move driver to separate directory
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rnull-up-v6-16-v1-4-a4168b8e76b2@kernel.org>
References: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
In-Reply-To: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3672; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=7kKEIeuBmyNvAHyL84OBtlsy59K5vqkobCWeseIJrWM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoUBsNuWVooiswOAiBS7iM03o7bREFopLpUcPYw
 0RkYsMOHeWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaFAbDQAKCRDhuBo+eShj
 d+1mEACo74mjrLW2U1XkyKPDe2+32sTt7tbG6qKFDMPh0HCp6TgYQv3zCw6WYhyW00+wS77qoYZ
 JijdGVyiwCzntQEPxY0bo+GMaE6f3FTenbI7CKPgtDcWhWKsBo7XmkSejEkOdpbCHD7xN+41HJO
 /iteEgs1/Vxuy1q9EkKZSv+860wfr+X5LtmwqR/mQncbfP1Wls7yK8oyvcLk1bZhGAjJTHf+Ix9
 dvlzBNOE80c/UdfBqGA+sjuBXfA3QP3nnKJxpKEWmNilfB6NqTQtUdipoNEaKBlaNXO1JMs0Eg9
 v5nWwbpOueZGjL7HQCetRDBblc2Xi2Fg4Gl7ODgd/VV794KpBMTJfJyCYza4YGNXNOJVJmCaxHn
 Glg2YSIjsL//y8hwZaPXyvbO09WzPJHl61MuuuuppBGkeBKU/6wM1SNrgRBi3UnX2nUOXsNMzoU
 fazsjSPuZHkndM/E76t7s/J/3t5ZZOKLEGvC6BwQvHZi5q3rqRjrYsDIkKykfxqavYKLormW3uK
 A5aw2eId196EaWWF6x2aHsD+IMfRpq+wZSQPUFzS+BBpjxda+N84Cc5vMMiPJ9BTvWZ0HvKTEgK
 /5SDizKlkf13d11xnTnje4g5SurDCgvHt8AXEEhFT10Yzvn1rJuBTbC6LB7LtHNKSr+Rlr2MZJY
 BFaShSqUwnfqSWA==
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
index 0c1d245bf7b8..29b14aec3559 100644
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
index 0f70e2374e7f..6b50dbc0495b 100644
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
index 097707aca725..aba3e93d5014 100644
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


