Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8233B585D;
	Fri, 10 Apr 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812131; cv=none; b=KyzNhBKfTyXrAcOhxh7qcnSvKY0Y4pLCKnTLknYzV+w9qctFzKkF2ckCJd8EDbWZGBUYj1V6W8gT+EgpaTtYkyn6ytOw/J6jxaOPKjPfqtENEmyxwAPh+3LUAy4IAySr+6UqxOg3ao0CZEoh4rPWOe3KkjMi6f30YLJynT0ou4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812131; c=relaxed/simple;
	bh=mWIyB6EVGnGgpvfQZVlVwT1IyrrL9c5oWQaXdoIQRLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kywZpmE+fAC1zLgbU4jkfm2EUY7TpR6u6eDU4HU3AOdFa0te/2ssgfGSX49PUnLejD288wQQ+xvIjZwdQxhPa33uSL51BDgo4sVuzEaykr30P27k2dBjbivrDSiLMhkM4nFrVO7TFXI0cInayb8Hv13qwFD0T3buoeU9spu6FRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=pK5toNxr; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="pK5toNxr"
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a3dd6907;
	Fri, 10 Apr 2026 17:08:41 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: axboe@kernel.dk,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: bjorn3_gh@protonmail.com,
	aliceryhl@google.com,
	lossin@kernel.org,
	boqun@kernel.org,
	dakr@kernel.org,
	gary@garyguo.net,
	sunke@kylinos.cn,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] block: rnull: support BLK_MQ_F_BLOCKING via configfs
Date: Fri, 10 Apr 2026 05:08:29 -0400
Message-Id: <20260410090829.1409430-3-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410090829.1409430-1-wenzhaoliao@ruc.edu.cn>
References: <20260410090829.1409430-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d76a6939b03a2kunme6cebcccb9d00
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGRhJVhkaQ05KSklPHRhOT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=pK5toNxrP5YfWsxivM7u5prIr9zP3pKX8CTUj317Onkmjf4CGzTIHct7hLCKoggWBa8GbAv9Ia5Jwyz4MZUnzBiyrbNvMfYP1aaSv87PhA3gLL0GAvk/mB5hY6HJbb9/Drq5F2eKqwkKsEbGdXph4Z3rvGLkUcORjAccOgp99No=; s=default; c=relaxed/relaxed; d=ruc.edu.cn; v=1;
	bh=KRFZFm//W2RUoOyI4BbU/k2zwl2tS5EsLKX7YZmZHcA=;
	h=date:mime-version:subject:message-id:from;

Add a new configfs boolean attribute named blocking.

Advertise blocking in the rnull features list.

On power-on, map blocking=1 to TagSetFlags::BLOCKING.

Create the tag set with TagSet::new_with_flags().

Keep default blocking=0 to preserve existing behavior.

Like other parameters, blocking writes return -EBUSY while powered on.

Validated with LLVM=-15 out-of-tree builds and QEMU runtime tests.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 drivers/block/rnull/configfs.rs | 32 +++++++++++++++++++++++++++++++-
 drivers/block/rnull/rnull.rs    | 11 +++++++++--
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 7c2eb5c0b722..a9d46a511340 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -35,7 +35,7 @@ impl AttributeOperations<0> for Config {
 
     fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         let mut writer = kernel::str::Formatter::new(page);
-        writer.write_str("blocksize,size,rotational,irqmode\n")?;
+        writer.write_str("blocksize,size,rotational,irqmode,blocking\n")?;
         Ok(writer.bytes_written())
     }
 }
@@ -58,6 +58,7 @@ fn make_group(
                 rotational: 2,
                 size: 3,
                 irqmode: 4,
+                blocking: 5,
             ],
         };
 
@@ -73,6 +74,7 @@ fn make_group(
                     disk: None,
                     capacity_mib: 4096,
                     irq_mode: IRQMode::None,
+                    blocking: false,
                     name: name.try_into()?,
                 }),
             }),
@@ -122,6 +124,7 @@ struct DeviceConfigInner {
     rotational: bool,
     capacity_mib: u64,
     irq_mode: IRQMode,
+    blocking: bool,
     disk: Option<GenDisk<NullBlkDevice>>,
 }
 
@@ -152,6 +155,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
                 guard.rotational,
                 guard.capacity_mib,
                 guard.irq_mode,
+                guard.blocking,
             )?);
             guard.powered = true;
         } else if guard.powered && !power_op {
@@ -259,3 +263,29 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         Ok(())
     }
 }
+
+#[vtable]
+impl configfs::AttributeOperations<5> for DeviceConfig {
+    type Data = DeviceConfig;
+
+    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        let mut writer = kernel::str::Formatter::new(page);
+
+        if this.data.lock().blocking {
+            writer.write_str("1\n")?;
+        } else {
+            writer.write_str("0\n")?;
+        }
+
+        Ok(writer.bytes_written())
+    }
+
+    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
+        if this.data.lock().powered {
+            return Err(EBUSY);
+        }
+
+        this.data.lock().blocking = kstrtobool_bytes(page)?;
+        Ok(())
+    }
+}
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715febe8..d7ebd504d8df 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -11,7 +11,7 @@
         mq::{
             self,
             gen_disk::{self, GenDisk},
-            Operations, TagSet,
+            Operations, TagSet, TagSetFlags,
         },
     },
     prelude::*,
@@ -51,8 +51,15 @@ fn new(
         rotational: bool,
         capacity_mib: u64,
         irq_mode: IRQMode,
+        blocking: bool,
     ) -> Result<GenDisk<Self>> {
-        let tagset = Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
+        let flags = if blocking {
+            TagSetFlags::BLOCKING
+        } else {
+            TagSetFlags::empty()
+        };
+
+        let tagset = Arc::pin_init(TagSet::new_with_flags(1, 256, 1, flags), GFP_KERNEL)?;
 
         let queue_data = Box::new(QueueData { irq_mode }, GFP_KERNEL)?;
 
-- 
2.34.1

