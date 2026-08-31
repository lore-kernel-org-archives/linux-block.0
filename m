Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257873B2FD8;
	Mon, 31 Aug 2026 03:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788148068; cv=none; b=H0D0BYVUa69Sr8rd0oltT5cX0FW05UqL/NqhuCxWuVd+YXGwc1TCv1e/whQXx91hrQJRFBgow8PLMvJg7FHYOHfGsuttWIB7N1AX28RkcsUSZrjo++UV4AUbiUtC75vpZj+OhwQ0neNRc45dMv6mIDWlGvGFJGQbJCPB6ph5mY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788148068; c=relaxed/simple;
	bh=9EsBwWz73AT1tlEJoRTGPijpAzPGqq+LkGpMBCPyK0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RBFSBlkYn8bS4KkbBb706wMm/LtPvS2atkysOykqLPCAOPx/5HZkpmSD9lEBg+BW4225I2iZFKKZCeEMtZOTYmB9gEsvPctrOTeYlld/s1cswJ72yGFYrwSIcdYUxwe8tSeAamdCXkubAE0QxPWmiqLVhA2FIzQEwwDSerXxq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imAAo0FO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imAAo0FO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F267C2BCFA;
	Mon, 31 Aug 2026 03:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788148066;
	bh=9EsBwWz73AT1tlEJoRTGPijpAzPGqq+LkGpMBCPyK0U=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=imAAo0FOTs3+8tZ/5OHTxNFI8BfXOz1i/yNDR5bn4+TnpruWXmkVXisJtSkjHQ+TL
	 +2ae/rNEJYZg6x81xYgySuHQH7remxAPYTDGOeGffO22bU2AC30C4sjHAYZvq/+41H
	 /Wt9iqVmD4IRjyNl63G/kShbZk+8JaPT0xkBye1+VvN1z3EhYQgRjen/icNwSI9iTe
	 wM6aDIxOVidmhWRD3j1ckI9huR+cHOSHmwYuvq4wiR19wIi43tSfXEsfcKgtofHUU3
	 OGuydN2D8Nr024yJJMAFq57PN1d6c0Ht6COsOE9nc/JeFMQB889NkKltDg41hrMBYj
	 aS9TRAvsCCRkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6E8C61DD3;
	Mon, 31 Aug 2026 03:47:46 +0000 (UTC)
From: Sophon Z via B4 Relay <devnull+aiqubits.hotmail.com@kernel.org>
Date: Mon, 31 Aug 2026 11:47:24 +0800
Subject: [PATCH] rust: block: Fix GenDiskBuilder block size documentation
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-fix-gendisk-block-size-docs-v1-1-900546005799@hotmail.com>
X-B4-Tracking: v=1; b=H4sIAEv5lGoC/yXMQQrCMBBG4auUWTuQprSKVxEX7eS3jpVEMlqKp
 Xc36vKDx1vJkBVGx2qljFlNUyyodxXJtY8jWEMxeec7d2hqvujCI2JQm3i4J5nY9A0OSYylgfe
 97F3btVQOj4yS/+6n89/2Gm6Q53dJ2/YBZI91iX8AAAA=
X-Change-ID: 20260831-fix-gendisk-block-size-docs-c3e22ac70565
To: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sophon Z <aiqubits@hotmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788148062; l=1956;
 i=aiqubits@hotmail.com; s=20260831; h=from:subject:message-id;
 bh=bOkxOycOeNPewqeSHo0cMWhcJJczIZOzbJuJHTlpI4Q=;
 b=yuKAM79tiw8QxxMHkC1czHgpI34xIchucM2KyO6i1hjzynv4/BYooVAIAsMJcOrmHFG7s3tif
 Y1uLBw8eymKDLx5emH9O9Jt84x4Tj6bE6JY3OqtiicYqv/04clyMEE4
X-Developer-Key: i=aiqubits@hotmail.com; a=ed25519;
 pk=+mrkwQAyCCkZdVPpu+CBQr1VZQlkXa7/1WizfeSF/yg=
X-Endpoint-Received: by B4 Relay for aiqubits@hotmail.com/20260831 with
 auth_id=992
X-Original-From: Sophon Z <aiqubits@hotmail.com>
Reply-To: aiqubits@hotmail.com

From: Sophon Z <aiqubits@hotmail.com>

GenDiskBuilder::validate_block_size() accepts powers of two from 512
through PAGE_SIZE, but the documentation for logical_block_size() and
physical_block_size() states that the maximum is 4096.

Use PAGE_SIZE for both documented upper bounds so that the documentation
matches validation on architectures with larger page sizes.

Signed-off-by: Sophon Z <aiqubits@hotmail.com>
---
 rust/kernel/block/mq/gen_disk.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index fc97dd873974..119ee522d854 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -63,7 +63,7 @@ pub fn validate_block_size(size: u32) -> Result {
     /// Set the logical block size of the device to be built.
     ///
     /// This method will check that block size is a power of two and between 512
-    /// and 4096. If not, an error is returned and the block size is not set.
+    /// and `PAGE_SIZE`. If not, an error is returned and the block size is not set.
     ///
     /// This is the smallest unit the storage device can address. It is
     /// typically 4096 bytes.
@@ -76,7 +76,7 @@ pub fn logical_block_size(mut self, block_size: u32) -> Result<Self> {
     /// Set the physical block size of the device to be built.
     ///
     /// This method will check that block size is a power of two and between 512
-    /// and 4096. If not, an error is returned and the block size is not set.
+    /// and `PAGE_SIZE`. If not, an error is returned and the block size is not set.
     ///
     /// This is the smallest unit a physical storage device can write
     /// atomically. It is usually the same as the logical block size but may be

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260831-fix-gendisk-block-size-docs-c3e22ac70565

Best regards,
--  
Sophon Z <aiqubits@hotmail.com>


