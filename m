Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926B4A3F26;
	Mon, 19 Oct 2026 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403925; cv=none; b=eV39/RbRn1misYnksZfw3PT2Tgj6pwRpw3GJMnrK7nwGdXwJyF8HBtlQgrPZ6J2zwmaInQFZdqXJHAiqO7d/uQJGcv8nbXh31mPdSg/0b3GrZnMEUalvWRPrYA63E6fUZmwmRc1ZAJpytRlBYBLeiJ4uns497wdMVbQmltLLBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403925; c=relaxed/simple;
	bh=GW8/0uoNT92TX4Jm2XL1p10F/geIT3Pftx8oGPFQ9k0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WG9uis6N0V0MTPzO0Z98RDTMWvl2JOFLLR1Rb/RsuXuY3CwKqpzyiiNA4WYlhI1Txwr3+akqAw3ruXSySG9yZ2b9NT1UQkxVQfjL2bIX/RUplSE2JuRZtYS7SbRbtI+nCSz6fJ1dko58H89fE9kPKGLhqVHJoCsJE22orUA9lws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Rzm9lCHz; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Rzm9lCHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yo
	aSTyIAZlCf7IrpG6xDvxi5QR2YUjffz80uNqfSkNw=; b=Rzm9lCHznLFy0tG85c
	poBlbcT9hLNfj2VxP/ZUBuwA788L5ksZeIW1EcZMCCKbDrO8HgUhgSQ47n/mF+iC
	qbu4RL0uxpwDoCdEcSKdejehGyQ541a7FghNpxTqCy/hvQXnpM3842P7gr92ugPW
	S05gHfejdwqpkSWPe4aIM+Krw=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3VECx6dVqUUgcAw--.30679S2;
	Mon, 19 Oct 2026 17:58:10 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <jiale.yao@example.com>,
	Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] rnull: serialize configfs updates with power changes
Date: Mon, 19 Oct 2026 17:58:07 +0800
Message-Id: <20261019095807.1906316-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3VECx6dVqUUgcAw--.30679S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrW7Ar47AryfJF15GF15urg_yoW5WFW5pF
	W5Kw1jyF45GFyfXr47t347uF13Xwn7CFW7GrZ7Wa1Sgr15Crya9rnYqryUWw1rur9aq3Wa
	vr4FqFy7uay7Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piAwIDUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BK28GrV6bJYkwAA3L

From: Jiale Yao <jiale.yao@example.com>

The configuration stores check whether the device is powered before
parsing the new value, then take the mutex again to update the field.
A concurrent power-on can complete between these lock acquisitions,
allowing a live device configuration to be changed.

Parse the input before taking the mutex, then check powered and update
the configuration while holding the same lock.

Fixes: d969d504bc13 ("rnull: enable configuration via `configfs`")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/block/rnull/configfs.rs | 42 ++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 32c10c3f4d0f..1808fcacfd55 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -174,15 +174,17 @@ impl configfs::AttributeOperations<1> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
-            return Err(EBUSY);
-        }
-
         let text = core::str::from_utf8(page)?.trim();
         let value = text.parse::<u32>().map_err(|_| EINVAL)?;
 
         GenDiskBuilder::validate_block_size(value)?;
-        this.data.lock().block_size = value;
+        let mut guard = this.data.lock();
+
+        if guard.powered {
+            return Err(EBUSY);
+        }
+
+        guard.block_size = value;
         Ok(())
     }
 }
@@ -204,11 +206,14 @@ impl configfs::AttributeOperations<2> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
+        let value = kstrtobool_bytes(page)?;
+        let mut guard = this.data.lock();
+
+        if guard.powered {
             return Err(EBUSY);
         }
 
-        this.data.lock().rotational = kstrtobool_bytes(page)?;
+        guard.rotational = value;
 
         Ok(())
     }
@@ -225,14 +230,15 @@ impl configfs::AttributeOperations<3> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
-            return Err(EBUSY);
-        }
-
         let text = core::str::from_utf8(page)?.trim();
         let value = text.parse::<u64>().map_err(|_| EINVAL)?;
+        let mut guard = this.data.lock();
 
-        this.data.lock().capacity_mib = value;
+        if guard.powered {
+            return Err(EBUSY);
+        }
+
+        guard.capacity_mib = value;
         Ok(())
     }
 }
@@ -248,14 +254,16 @@ impl configfs::AttributeOperations<4> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
-            return Err(EBUSY);
-        }
-
         let text = core::str::from_utf8(page)?.trim();
         let value = text.parse::<u8>().map_err(|_| EINVAL)?;
+        let value = IRQMode::try_from(value)?;
+        let mut guard = this.data.lock();
+
+        if guard.powered {
+            return Err(EBUSY);
+        }
 
-        this.data.lock().irq_mode = IRQMode::try_from(value)?;
+        guard.irq_mode = value;
         Ok(())
     }
 }
-- 
2.34.1

