Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967492F4A09;
	Tue,  2 Sep 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806973; cv=none; b=AqXWIREL0Q6MQg5BaBHsvLVrvO7aE/CxAzNW5Zd3N1l7gVuvZYsaxXtjlkcUNfbMr9LZTpO8sl818QMSZkp3buQh7u6mBtip+j+xOm7CK5HwKGgk6cnaoGWHOJPghdUT2oZBNM+sXfDTcq1WtJlpp7Lh5cH6/KNzUjeUAYRiAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806973; c=relaxed/simple;
	bh=pIuBZvrIaCfOxk5R8QT6fU57Jtv4V7ScNiWvZ/2peFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBnoZ+KY6Kl1cJ0iH4JKpB4n9G+Fi1ggk9FcV2xDbmxWdJSu/39iFIh/4IxV0PRNZNeo120QuT3TdyT+RZXRG9WFobu6bpAJBH4y3IbjpzJTPtNPIp4u8BMCzAJOmAuQ5vgumHlix3XId7qGwYeTWA283f7j3c+5k9a9tS6aeGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndSbxD6i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndSbxD6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E3AC4CEED;
	Tue,  2 Sep 2025 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806973;
	bh=pIuBZvrIaCfOxk5R8QT6fU57Jtv4V7ScNiWvZ/2peFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ndSbxD6iB3kGoDhL7VTkbdea5vVoNd0p6dev48Q8fxyuMe8Ty8cGWsSQF6Mzg+VIp
	 8+MBB/v+2eG6MInm8UuSzx0sKHVFDDwtK7ush1EBrI263F7FO2mp9jTgRqTUP8As79
	 9rqd9YssJMdsqj8u2m/D8KLFdGuqhyxWwq2JSM2TyVvqYeySmEUZ7V4c9Oz0uuSq9I
	 42JRHu0Bwuz3YWm894t9UIqdpNSGMk5jsUqWrDNEN2SyBAfdAUTDXRJOlfEvAJvySz
	 h8zz7yiwp34Z3vdt1QvFi6tu9xj0AVid1v3nNfTpreIwtjT4agOVkjjFBkQ/TJxJr7
	 G6D3zBKH36+Mw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:55:06 +0200
Subject: [PATCH v7 12/17] rnull: move driver to separate directory
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-12-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr8EMrtCGQJaSfg5FNjqv7eu4cedktkAzfTYV
 udhcYHI2NmJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa/BAAKCRDhuBo+eShj
 dyykEACyYN9nV7NnY266IMC+HwV7lYYDnvjpQEPehKkSbW9IGOMntwX4Izin3vdqj9UnDPgtxqr
 qMcw/h7owGs4zx3GgQBSR/2myqRbuVGsgazSCzAZ8hZ1D/7BUBPbYO7WOEzrEn7qc9typ2Hq/vx
 xd10lirFdV5Ujs5LaEMv1cucK225LWL9bF6aelykSmkLZsejXsFOpNiLS9J8nCXwSi9o38Ph8+u
 lEQ8Q8Gjv3ZgL2yF3aiBcjJSwPwJj1h6t1P6GwA+kmaVmVwsjfjsxpiTNrWFf0eYDVMgxnDLHGC
 n/6/T5JmuTq6ckh/qChmOr0Ute5Dnlcitmj/HIOaeebKbmy9gtxh9LHP4hnjC8KmVpAbHP2RTLB
 HYerZRE0IeialIemkc8cKwjwow/LL2Maht53Xk7831JQm1WTQrSvCOrOHD2MUS8qWOMn81tcS+r
 H8vd9KLb7kNI5ryBRS4fj9obzsGEIAXz1r6qyZQTLw7sYtryEBvt9JsTNiyahV8WgYnVCbBtrlE
 NNpz1XA4Lo0jk38eCMA7bmpbDxuEb3arDjzNf8FjEVwh87EJ+6kU3Q6zlTEOvImidg7/aLOCa8A
 49Q5yehIuQheUPJtWFaO70YhgkuSXC+VONq8WcA8pNogcD1+QEQ/gP6fsYiStl7dsd+sFzlQkUx
 f53psD4978/5IAA==
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


