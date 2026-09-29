Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD73A8753;
	Tue, 29 Sep 2026 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674534; cv=none; b=axBWLK6IR+LnEvbrq8YpTMs8enfpUNfq4wQcEjTea9T8Yrn1SVY9AbL7c58HTe9dPF/2OdtwfurU9M2wIIClI6dnUbp50vAMtZFaAojY8/2tzRRThTvBEDsSgc0wCbBhWDfffnDPfDPXS/CMJYzTe+/5xjhlXL15pTyVMnZjO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674534; c=relaxed/simple;
	bh=zwM2XHtlBXSiY0KIljJww2BVuXxamLCSacNpc1XGD2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZQWUem5j76NYsuWEo35qgzjywJpZBdzPTjMAoDb7KaS84pelrH4+GplVrbDKeI/tS6iZT27m6ohXpPWTH6INqx30WLLbvo4AnDriYBTm48gEgee6CkpQqlNjenQzXdEc4eO68J2ElRBp+fE84OGHPJrJShUZgdxHBhQYOxB8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUAVT7v8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUAVT7v8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0540A1F00893;
	Tue, 29 Sep 2026 09:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674532;
	bh=sUY9rDuHOOo4dF9qMMVk6YRVMH482ea9+/r5cilVXSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AUAVT7v8GBTrjpbQgkvL3unDSJAn5fdiJYljTDi++WGJyD5M6xwDKwcEAPuiS0Zx8
	 u6tQ8nOBogsFdl9H4W8ImdKrd9H1Tmm8SiuPVrzdKoF8b6jVmju1SVbaR0z7aTMroS
	 kqFj9fa9TO5ad8Owf9OT8EfNR1+Pk48a+8tD5qyRiPto7TbdwTLVrqGw0e7ilTsf2Q
	 fw+5N+fqd/5puP5cDjO3hkBj8CJCDricLTsx5dUpfg8xMYPNOEbSHL0wDVqTA47y9H
	 ARnFa0kjmJyz/BARHaAkNR8I5SX7fWZ5LN6Cn0xiG9F14e2RHdX77/fa/dK63zlAV0
	 9lDLGdeyuyzvg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 29 Sep 2026 11:34:05 +0200
Subject: [PATCH GIT PULL 7/9] rnull: fix geometry store check-then-act
 across lock scopes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rust-block-for-v7-4-rc1-b4-v1-7-642a4c1aebd7@kernel.org>
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
In-Reply-To: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qingxiao Xu <qingxiao@tamu.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3066; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=PNGqV4nm9iI9+fMlo17K+Qban70juDHqIBqhLUT/fds=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqu4YZdOgFS5hk6Sivyk68bFe5AIZM88cLR9d1y
 xxNdCNWcUqJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaruGGQAKCRD6UCkIqsW9
 0MPnD/4tyjTsJctzqCaxGMcrEF/Stt8CKSLR8iBWk3fZCCkUN5WTl9omXFYLsZs4SXemIKJvsc4
 G/XARysV5xJ1mu5QakCzHpUGf0GaqXQqNeYxh/33JVFKqw0G5zAGArA4ZmJSTDbKo8L9H+nuqxI
 4dGlhaT7UQwfdT8x+n1ZIfZE4lyVU7NHI9qaIKRnZ+uzSAX+L934sSYzlpzKbq0soXlAkCLoO/Z
 vSZneKvMBwkYb1oVQWL8us9Fx1ACLVvnbAzbZtFozWhgvm1xkdx8O3PH3dHx4Thb3I0b9hG3ZVB
 8ow8wYi8wlFDyYRbTOOqWnoTedjXH+XtC+Xp8TddK0cnp8bGnyuyDsXXRDjzunC62E3o8arTACt
 sC0AG541RcJuXzgK+3mVkQ2lyYAm/DXylgJ0Pypvrk+PexTbpKiN01yQjF8ZoMdqBrH8oqY4Dvo
 C2pEqgVk6Amdwm7+lMb1w1HHu+nZErCmQE6MoSyiUCMVJmybRt4g5u7HwJrNTXRM4CbJH+SmaG0
 lgbTJSRv/ycvfj+JrIEJINFyd3hOpkuB8QhuJk76oIkHJ8BxCeVdYyk2mpQDGPpH8MAWJXUF7Qs
 3r01wF4Ic/uTqqCAvkwRJ6JO6k1PSohzsfymFi6MpOoW7nX0BAR8R0W5uFPp30jixx2Z8Uvkngs
 RFqdMGoqWDhHzdQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Qingxiao Xu <qingxiao@tamu.edu>

The blocksize/rotational/capacity/irqmode stores check powered under one
Mutex acquisition, drop the guard, then update under a second acquisition.
A concurrent power-on can create the live disk from stale geometry in
between, leaving powered==true with config != live disk.

Hold one guard for the powered check and the field update.

Signed-off-by: Qingxiao Xu <qingxiao@tamu.edu>
Link: https://msgid.link/20260908200845.405112-1-qingxiao@tamu.edu
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 9b28be215093..24b02256b4cd 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -186,7 +186,8 @@ impl configfs::AttributeOperations<1> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
+        let mut guard = this.data.lock();
+        if guard.powered {
             return Err(EBUSY);
         }
 
@@ -194,7 +195,7 @@ fn store(this: &DeviceConfig, page: &[u8]) -> Result {
         let value = text.parse::<u32>().map_err(|_| EINVAL)?;
 
         GenDiskBuilder::validate_block_size(value)?;
-        this.data.lock().block_size = value;
+        guard.block_size = value;
         Ok(())
     }
 }
@@ -216,11 +217,12 @@ impl configfs::AttributeOperations<2> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
+        let mut guard = this.data.lock();
+        if guard.powered {
             return Err(EBUSY);
         }
 
-        this.data.lock().rotational = kstrtobool_bytes(page)?;
+        guard.rotational = kstrtobool_bytes(page)?;
 
         Ok(())
     }
@@ -237,14 +239,15 @@ impl configfs::AttributeOperations<3> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
+        let mut guard = this.data.lock();
+        if guard.powered {
             return Err(EBUSY);
         }
 
         let text = core::str::from_utf8(page)?.trim();
         let value = text.parse::<u64>().map_err(|_| EINVAL)?;
 
-        this.data.lock().capacity_mib = value;
+        guard.capacity_mib = value;
         Ok(())
     }
 }
@@ -260,14 +263,15 @@ impl configfs::AttributeOperations<4> for DeviceConfig {
     }
 
     fn store(this: &DeviceConfig, page: &[u8]) -> Result {
-        if this.data.lock().powered {
+        let mut guard = this.data.lock();
+        if guard.powered {
             return Err(EBUSY);
         }
 
         let text = core::str::from_utf8(page)?.trim();
         let value = text.parse::<u8>().map_err(|_| EINVAL)?;
 
-        this.data.lock().irq_mode = IRQMode::try_from(value)?;
+        guard.irq_mode = IRQMode::try_from(value)?;
         Ok(())
     }
 }

-- 
2.54.0


