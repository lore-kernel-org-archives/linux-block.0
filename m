Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44642D949F;
	Sun, 15 Feb 2026 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199016; cv=none; b=QeeefOs2dfoiqah0xVNDljXHJeOj7+XPn1oeCuPC7vRfBGc5ZetWK6yzqGkYrvWycBPndhkxbzWtbXPdPigW17CDuWHLU3KQDIAKzo7wn3AgsPka6/yA6S1guMf0+VhVp+VpPwJKZevUkCDOu7wKb875L5gSlprnR7Zuz+tUVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199016; c=relaxed/simple;
	bh=c72UaM9t8Nsnn6kAPdjGxkpAM0WUzhWF4XrAzC0RQao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A1VCdCb4RYgiky6lPbW4YxvJjkfwApo78xpDoOkVbnbiGX4eVdoVbJxNPOgbb6svvARyaBKRVJjR9wT0QBSnjBH3CIrO3Y2vbbUHSDm2VJhZtjKPFMCCEqKWDN1LwY35mbz8mCa+PBYwbnLDp7ltAherHdsTzU3vjmRPQtcYARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no3QM/pF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no3QM/pF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424BCC4CEF7;
	Sun, 15 Feb 2026 23:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199016;
	bh=c72UaM9t8Nsnn6kAPdjGxkpAM0WUzhWF4XrAzC0RQao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=no3QM/pFs9zo1QK0k4glZQiApqW0oX1HM3K3pehWTOoTK5+CankPp2HTPq8P+QJZ+
	 I17e+CXbn9dYJlnxN8fCWL1TnXQZZXQwouZxjV3r2Wn+cQzWWKabGQ5p7t986WqRD2
	 NDMgiLh3v+c5dRmsYevQgsCk1VJC2rp7r10RHZB6sQBgTjLRKa9UEPr6ThOJGONVdc
	 dFkJuVEwknzqzZBZFc172OIF1y9A/5EGt4KdPDoabnZ5OCeKoZ+8RoWxaxGXRZ1qNo
	 oUTK9FQ7aoNJSveQ7CDjduiwvsbk+HJmyRmdxAquPdJ+4LmgOuN6UFpSppPaQ2205n
	 P9k3NHHKl6caA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:36:03 +0100
Subject: [PATCH 76/79] block: rust: add `virt_boundary_mask` option to
 `GenDiskBuilder`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-76-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=c72UaM9t8Nsnn6kAPdjGxkpAM0WUzhWF4XrAzC0RQao=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhgs4wMS8YB3muuW0aSQ3HICO4ZNqX1ZK51R
 3nW17TLDTyJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYYAAKCRDhuBo+eShj
 d8CpEACJwP4yRNF/vxN+0m7tnWXUQpbGdqaRTYay3DIJwmRNjTfNA7gS8JGyX2CboYyVhnlfOXd
 FjSGLFlqVkN3pQXpOwbJaiA8fEqbo0/a60mZW9b7TMJal9zLIjyn+kWTUl+Y5vEsNQt73qrqPGO
 5vsfhqkiGrG3tKZy10A6l2LP+VEr2pIla3wU5Ze14AgIsFUfxCAYrFXYUMwsdmv6LEKL7zKPyU0
 iM6d6XhpXXDMeJpDfX+F58ijvk4e9eNqVZBikMKGvkTDMZAi8moJYOSWmxqETcS/8mm/xW+kgla
 oksaa54icWULPIQPxed8y8yJdx8GWYsSLAGKDuFjZaw29DGI0ZmbVLf0/NaKc2SZE9DTtaqe9H4
 tkO/gfW6QBYKo6H5LK3sxEDslJuwmm4rqiJGW5RJUdsjTBkVUPYbyR19vZbBcLCJzsao9Jng8LX
 TrnnOlh5wBVGRUEmbuQVjz26NFMO3uVUfrmB5+a3dT39tFxhQbi1hs/R0DeouVUFDv4N5iYKpJc
 CEAJyu7bNfnrGL4p2EoIjEkCw3HWLXrAA3Cs4TYuVo9N6ES3vxwhbAy+zrdjpp40k5E9Gc80PEh
 Rq5nV4quXuG0aeW14mY2CfORzn5CxSB4H7jMdFo930kvb5zH7nsKze2ly7FQbQTHmbiQO/lYFmy
 hb9ZpII2eAkHWYQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow Rust device drivers to set the `virt_boundary_mask` property for
block devices.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index b428e3f4207f4..bf4775dbd6d25 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -37,6 +37,7 @@ pub struct GenDiskBuilder<T> {
     write_cache: bool,
     forced_unit_access: bool,
     max_sectors: u32,
+    virt_boundary_mask: usize,
     _p: PhantomData<T>,
 }
 
@@ -57,6 +58,7 @@ fn default() -> Self {
             write_cache: false,
             forced_unit_access: false,
             max_sectors: 0,
+            virt_boundary_mask: 0,
             _p: PhantomData,
         }
     }
@@ -167,6 +169,15 @@ pub fn max_sectors(mut self, sectors: u32) -> Self {
         self
     }
 
+    /// Set the I/O segment memory alignment mask for the block device. I/O requests to this device
+    /// will be split between segments wherever either the memory address of the end of the previous
+    /// segment or the memory address of the beginning of the current segment is not aligned to
+    /// virt_boundary_mask + 1 bytes.
+    pub fn virt_boundary_mask(mut self, mask: usize) -> Self {
+        self.virt_boundary_mask = mask;
+        self
+    }
+
     /// Build a new `GenDisk` and add it to the VFS.
     pub fn build(
         self,
@@ -187,6 +198,7 @@ pub fn build(
         lim.physical_block_size = self.physical_block_size;
         lim.max_hw_discard_sectors = self.max_hw_discard_sectors;
         lim.max_sectors = self.max_sectors;
+        lim.virt_boundary_mask = self.virt_boundary_mask;
         if self.rotational {
             lim.features = Feature::Rotational.into();
         }

-- 
2.51.2


