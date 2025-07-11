Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A22D27A44C;
	Fri, 11 Jul 2025 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234211; cv=none; b=rHyVQ3a9ZNKsJeUult8o4MDuEqKXqeX+jngez7CRxAsztPJZIrM0Ce/n/UWEnu0uUW358vl14eztAJ7/jwbWq/ci/S9dk5nwpufzaCudT9yxTCP7M8syLw+pXmoIUbEEeFYxgkknwt/8IYMM6BnMWgXiCVupRInblX7o3DMxppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234211; c=relaxed/simple;
	bh=7kKEIeuBmyNvAHyL84OBtlsy59K5vqkobCWeseIJrWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stBnaOMcwYtKATLRKmYXCLfxICaByu776MPkaAgppPmaLBzfru0t2fdVXweSy0IO8j4c8H7cwRmRIbfZsyKpkopxbwnxbyF7I9oUqHG08sNtRLVqTlWUnkQpXflKvoTb0vM6R+WShgf0PrOVbXBzW+2+9PLtKtonOM/UIEQSHoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+EeDWUc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+EeDWUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4BCC4CEED;
	Fri, 11 Jul 2025 11:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234211;
	bh=7kKEIeuBmyNvAHyL84OBtlsy59K5vqkobCWeseIJrWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n+EeDWUciQZQU4P8LvXIE4ClDK3TJCLpfCMYgO/FB7f4fG96iAfCxiRN5iBWLfq0o
	 podjPxZ2fGyfNN7o3eLL0AeiII9YkuImlq9F8IP0CKtfn36mDj0zrqLgNDgT/AGDyx
	 t8fZeXyUIEb3YYFWquXgQV0GaX5D5mfvkLgBUct9GYBKSTovSyxM+CwbtKKQaXwH2X
	 EqMeIOdK/OOU39iiO4EOX7Rh3swIMwELmL80AOKlz1PTDkakuYYQ6VRf6H/mRUNCK3
	 mIW33jG3+RbwsK2rOqxfSo3LqXtaCp+yUOQgSVEILLSyaHQdxqJPfj7342JL4FUjJv
	 BydZ4QVHApDcA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:12 +0200
Subject: [PATCH v3 11/16] rnull: move driver to separate directory
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-11-3a262b4e2921@kernel.org>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
In-Reply-To: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjUca7fbC/aea8BEVK/3llQKLK36fA9k7Xnj
 aNuufcwO4SJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD41AAKCRDhuBo+eShj
 d4D4EACzGLHqO5APIkvsBpjpjj+/xKLPQhp6RGUGwTmO6j1EXo4vIaeHJHacQe2mOcRBMeUCN+b
 CRsDrev79mNrw7rMAToKZLHkMuw7UBLfMBN1QllLFlxB/2dzGjkxsh8FYcSjhW1ZQ9I94TGct/R
 iearpkNrm3UejFWjPYlHopUnE4Z3yWuUgZ5ZDU85mAXBURcCVKkv3hHN48LAfBxPifSZu8e8Huo
 eX6spESu9r6BFKOKXu1pVckg5SiXDUXgmePK+K6kZ14yA+IXCxk8CIdEr5zZfUHXi4F1LKbFej1
 W6K76l2C7UM3/mwCxQFV9brl+ItECvnYbRW59n6f1ZXROk2FxL4L5OPuHnUPWboP/zN7ij/bSyq
 CpP/6NTZoavz8eEPBE8MEGSujT8Nb2RjK40AM9HhlZgzKKf+At8A4vEuSSEtKVfnOMnjW0DkjLs
 k0hLzXt8N0wx7vupklyTm1aobt8zs9ek1FG1nk7wZJI4hDBOt3IzYoyV3gvchgxFrG4Q4vIXzeS
 I6a1+1g4stsiIuFPzeorl3agaYAkAwhOyHbM1AiTwScN+eGmYpKHp5owXtdUthWypiPgyldGWCb
 Py3RzeX+SEIWfOhmlL082pwJt5Iufy+dNTmU3Viq1N8YislTKvJ/upxlq6/Yb4ta5j405s70N9x
 thqyBlspsdROJOA==
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


