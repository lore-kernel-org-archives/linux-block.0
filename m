Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0522DEA75;
	Sun, 15 Feb 2026 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199002; cv=none; b=roQJNEI0bcPEtfUuyhzqqOVYRTCPxrKgPuxfV95Z3Kt4zNfAf7k9z+DfYwT1CTsfHvvl6jR5sDh46k4vDJBpnbOTyzPqLFaKg1qMrJXvXJLL798+9aapHcEcDoy2SOZ7SpD9gESd4p9ZyySUby2wIQqwIn8Ln/1gSg/1qPNHE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199002; c=relaxed/simple;
	bh=u9tAIyBFICh0h8M21rtuVjobkuPmRcCa8Z1Q+dHSvbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+3YTljDN7zg1QH1oe0YPDBbIjXCmi3Omh1EsL7PY0YdGwC0cJixdAaWZhvOpmBxFFPqjpHNCsP+70fw62xmG5sAZx0YuZ+AJGN+L5i8zaOGe7Bwfvlrlx4fEyjtJge/0xVOJ339goWaTOnFDE5sIiRPV9krt8jmPoFepeGA5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn0Sci4k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn0Sci4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90CDC4CEF7;
	Sun, 15 Feb 2026 23:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199001;
	bh=u9tAIyBFICh0h8M21rtuVjobkuPmRcCa8Z1Q+dHSvbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mn0Sci4kIejuXJiTiTwdIfMXc3NqoDFy3RaGKisDg44zwaa3hSX3aAZrmGMOb1eec
	 7x+6SC3q5Z+9cLM/tkFHnalMzYwYLe78vwFaM0XEAnZ8+1lB9viOpgzktWVz+80QZT
	 QSjgz6a5F8xIzO2TJLivOQ5kXo3xCpVQyZLa6f2X+coFC2pTG1ODGvT4GWK+/K94jm
	 7ynXUlozo6wQAqE2IrfGh6EGsOkn0s0GY+hz9LRGPMxrlT0g5oNpLLgDmCImMpcnly
	 IONfgmAV92usz5sE83QOlBGxkJo1gjwtb1SDOuheDJ6JlmZ5L6opBfWPB60UCYcCWV
	 yH9X/rnEcjlJg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:36:04 +0100
Subject: [PATCH 77/79] block: rnull: add `virt_boundary` option
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-77-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4488; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=u9tAIyBFICh0h8M21rtuVjobkuPmRcCa8Z1Q+dHSvbY=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhhlk7rsPagv2Uwv84amFbhOdhB2bAscIG/l
 qV12jhD6D2JAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYYQAKCRDhuBo+eShj
 d39FD/96ZYUm8hNRgfOmyMX5tCjDFNgsfNiS40He5tLPYN/6WQj6DrGgYwv+z1pGIP5EDiWlZ09
 laL9bCVVPzdOdm+xGHJM3oRPpcjUgp3vfQlfL1sMp1+gebfGvFcb1pRWX7kDloy/79czcjq8ZZZ
 Ew2ZOAAd4zYAA8N+l182+vgq8BWrVmS3t/zpZaIvqxD+TjtM1RhHdgQnlEbAEF0CWMBf9GE3mJ0
 v8H29/X1YY1Qx+tcEyZ6y0J2cIFtmGzkMTSOMZVs2edeuuBCFYlnHTNDNVqAXxp7iG7CdqFbtiY
 fxkRP8jEYWWY+GGJJm6Vx4Hsgbwph2axGY1gT+jwIj8zxjIUbteI3xdD8ODOACOLRQjnzF2NG0G
 nzRtBJa3Ioc1hCdZPK8Ji3+re+kKP1h0aQ9mArwvdEcp7gnkeUXwTn6fFd6DUE1CSDuKr2p82z2
 MHFJ3Bc/BSVGBr/tK/GTTEMg/60SSV0z4YUwBDJHFvJ2AkOblvrgm+xvS3mzdYKXrwfc/T29YyK
 3TkuOp/0brAa6hgft36PbxJ0BU8NNFnhDc9FLu2y69Wubmb1BobDHlKRuxuL8+fbCePwd6eAAtp
 SCc2W5iseGlDBlHXIR9WqgzbOkp2HJCUcxX2S6O4WUSXTGW67mJKb56Ha8shPJq/utfHM3KDuH5
 CBlxRfFuSrMvDDg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a configfs attribute to configure the virtual memory boundary mask
for the rnull block device. This allows testing how drivers and
filesystems handle devices with specific alignment requirements.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs |  5 +++++
 drivers/block/rnull/rnull.rs    | 17 ++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 9eaace8b4257e..8b9ad8a1a243b 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -123,6 +123,7 @@ fn make_group(
                 poll_queues: 27,
                 fua: 28,
                 max_sectors: 29,
+                virt_boundary: 30,
             ],
         };
 
@@ -210,6 +211,7 @@ fn make_group(
                     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                     init_hctx_inject,
                     max_sectors: 0,
+                    virt_boundary: false,
                 }),
             }),
             default_groups,
@@ -293,6 +295,7 @@ struct DeviceConfigInner {
     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
     init_hctx_inject: Arc<FaultConfig>,
     max_sectors: u32,
+    virt_boundary: bool,
 }
 
 #[vtable]
@@ -351,6 +354,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                 timeout_inject: guard.timeout_inject.clone(),
                 max_sectors: guard.max_sectors,
+                virt_boundary: guard.virt_boundary,
             })?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -629,3 +633,4 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
 }
 configfs_simple_bool_field!(DeviceConfig, 28, fua);
 configfs_simple_field!(DeviceConfig, 29, max_sectors, u32);
+configfs_simple_bool_field!(DeviceConfig, 30, virt_boundary);
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 495a810f4f4e1..dfdb56bd76f52 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -28,7 +28,10 @@
             BadBlocks, //
         },
         bio::Segment,
-        error::{BlkError, BlkResult},
+        error::{
+            BlkError,
+            BlkResult, //
+        },
         mq::{
             self,
             gen_disk::{
@@ -53,6 +56,7 @@
     impl_has_hr_timer,
     new_mutex,
     new_spinlock,
+    page::PAGE_SIZE,
     pr_info,
     prelude::*,
     revocable::Revocable,
@@ -210,6 +214,10 @@
             default: 0,
             description: "Maximum size of a command (in 512B sectors)",
         },
+        virt_boundary: u8 {
+            default: 0,
+            description: "Set alignment requirement for IO buffers to be page size.",
+        },
     },
 }
 
@@ -287,6 +295,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
                     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
                     timeout_inject: Arc::pin_init(FaultConfig::new(c"timeout_inject"), GFP_KERNEL)?,
                     max_sectors: *module_parameters::max_sectors.value(),
+                    virt_boundary: *module_parameters::virt_boundary.value() != 0,
                 })?;
                 disks.push(disk, GFP_KERNEL)?;
             }
@@ -342,6 +351,7 @@ struct NullBlkOptions<'a> {
     #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
     timeout_inject: Arc<FaultConfig>,
     max_sectors: u32,
+    virt_boundary: bool,
 }
 
 static SHARED_TAG_SET: SetOnce<Arc<TagSet<NullBlkDevice>>> = SetOnce::new();
@@ -414,6 +424,7 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             #[cfg(CONFIG_BLK_DEV_RUST_NULL_FAULT_INJECTION)]
             timeout_inject,
             max_sectors,
+            virt_boundary,
         } = options;
 
         let mut flags = mq::tag_set::Flags::default();
@@ -512,6 +523,10 @@ fn new(options: NullBlkOptions<'_>) -> Result<Arc<GenDisk<Self>>> {
             .forced_unit_access(forced_unit_access && storage.cache_enabled())
             .max_sectors(max_sectors);
 
+        if virt_boundary {
+            builder = builder.virt_boundary_mask(PAGE_SIZE - 1);
+        }
+
         #[cfg(CONFIG_BLK_DEV_ZONED)]
         {
             builder = builder

-- 
2.51.2


