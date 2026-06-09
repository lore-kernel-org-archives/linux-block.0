Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC44374A01;
	Tue,  9 Jun 2026 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032444; cv=none; b=E3OnceKiOxYgTKecZm1efkG4YEXfbZOguocXcEgYuzr/IsNVDMCb7+nafU6WmVh92TzAj+a+ogaAltx7SWHgr+VCIjtvjEHRU7YyQyGdt3xCPq/WLR4knFPy3abTpe9xTb5tARd/+xDPL0MDaqepNtWvHGnK/iN8Sa9YXN4zb6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032444; c=relaxed/simple;
	bh=4KyhpI/ipNtBWo4VfFmPMWE541B+ewaPC0dhOaA747E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZwiBXXGNC15PaRdJf1THLdRkVg56drtJrcMq1BbJNc/Bt0RWHNoAkwrEoZtqjML+Qh2r+dgp+3Gl8tuj1TqIAlM+WN/LM+1p2KEUEwXnACLZ35EAM69IjF80TtX2HsLdK1Qq3xttiaACvmIpyg0MisoHn3/I6e/EEmLhlhASZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkzrKIe2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkzrKIe2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391DF1F00898;
	Tue,  9 Jun 2026 19:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032442;
	bh=07OL9kcN1ts1JXzzO+dUFMGY2+vD2vNCDEhWdbU7mT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GkzrKIe2u3GY0JbJewS0RuhVNBjw7yRlApgAHzBncBKj0XnPuXad13OLnC7CRwaXG
	 iMgQ1BzKirKGjzmSiTCjo/1Fs9/L8PDVtB/u0nDJbC37bCWViphuSoV3Cvd3UmrvDj
	 pME6QGR8NxzFmm0HDLEQWprWgzzml6RxsrCNYnyYa/HOjeT5IflAHk4Gc+lccHR5Vi
	 VOthBvAe25P+FT/ToGxNyMYpxjHPvckRZAzs9NU/Jcy5K5VwCW8qQLK31VymURNStI
	 NDGvTJie/NIGPH6KxtT/P0RBcLko0qNzcD+/4wPU5peW1CRKFAmJ+OMnnA6UGIRTP+
	 XfcBzTDei3a0Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:41 +0200
Subject: [PATCH v2 62/83] block: rust: allow setting write cache and FUA
 flags for `GenDisk`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-62-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2966; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=4KyhpI/ipNtBWo4VfFmPMWE541B+ewaPC0dhOaA747E=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTs54UDr8c4HG8t9kjVRyMVGYuBltQmu35Fx
 kzOC0ur7sGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk7AAKCRD6UCkIqsW9
 0MLED/9uhTnck2NzwFArogG6VlzaQyne7VPrBkfmw6Nv9UnoWpTNUkQfe/CsDpQGsQxLtCmae/z
 E1C6XowvFBrQtmwJ2gsPnNOe5tmkJuNQOAnrSXGO7sC5OeqlVJ0tgiEO5QGEfp1EQfsLt4qmIvu
 3ZEioOmYoItty3EBEvv5H3WyjCSGEdo4pKOewZ+FNfE/rJj0G8lpwsZs24HlwBUaXB847igdfCg
 Ww3FMnCeM7z37GSPdxmB6OaqZQM91MVDQrBzEQLu3NYjs5SSWknEe948agXVpRo+mI1nr44JdwO
 ha/ZiVWE5418t6/WrHnzw6UKoj0ALQ00jtulT74X883V9UJqgpSMtGRT/Zx28YdWJCNlG+HkSiJ
 ZUnN7IyNz5oRD5heUlK+3ymtP/gsAougCbARycu9ziTyMX6e5af8ofNWexv8+7LHjiwhlcCEMp2
 fUpW47RaTUxN7poQqnXe5JgXfBtdNmAk49uVTVHcFb2OE/FiYzqEJxqQ7fDA3vUS7Vw8fVGI8ti
 RAf2z/EcyjbByabxIQpiWqLQROy4g8G+IHdgVs+Bu8glPNHc0jzafKewS/RD19YKxcVZcwo+HR+
 37VssMaG+PTuLzYSpas3h8u7UljZO0tMrD6jZWTBYCgRlaz8Y1vLONVCt1MMtPYLPiZXT93duaC
 cq8ynYTAiX1BKag==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add methods to `GenDiskBuilder` for enabling the write cache and FUA
feature flags. These flags are set in the `queue_limits` structure
when building the disk.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index eedba691e167..5367ca92b7aa 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -9,6 +9,7 @@
     bindings,
     block::mq::{
         operations::OperationsVTable,
+        Feature,
         Operations,
         RequestQueue,
         TagSet, //
@@ -55,6 +56,8 @@ pub struct GenDiskBuilder<T> {
     zone_size_sectors: u32,
     #[cfg(CONFIG_BLK_DEV_ZONED)]
     zone_append_max_sectors: u32,
+    write_cache: bool,
+    forced_unit_access: bool,
     _p: PhantomData<T>,
 }
 
@@ -72,6 +75,8 @@ fn default() -> Self {
             zone_size_sectors: 0,
             #[cfg(CONFIG_BLK_DEV_ZONED)]
             zone_append_max_sectors: 0,
+            write_cache: false,
+            forced_unit_access: false,
             _p: PhantomData,
         }
     }
@@ -164,6 +169,18 @@ pub fn zone_append_max(mut self, sectors: u32) -> Self {
         self
     }
 
+    /// Declare that this device supports forced unit access.
+    pub fn forced_unit_access(mut self, enable: bool) -> Self {
+        self.forced_unit_access = enable;
+        self
+    }
+
+    /// Declare that this device has a write-back cache.
+    pub fn write_cache(mut self, enable: bool) -> Self {
+        self.write_cache = enable;
+        self
+    }
+
     /// Build a new `GenDisk` and add it to the VFS.
     pub fn build(
         self,
@@ -183,7 +200,7 @@ pub fn build(
         lim.physical_block_size = self.physical_block_size;
         lim.max_hw_discard_sectors = self.max_hw_discard_sectors;
         if self.rotational {
-            lim.features |= bindings::BLK_FEAT_ROTATIONAL;
+            lim.features = Feature::Rotational.into();
         }
 
         #[cfg(CONFIG_BLK_DEV_ZONED)]
@@ -192,11 +209,19 @@ pub fn build(
                 return Err(error::code::EINVAL);
             }
 
-            lim.features |= bindings::BLK_FEAT_ZONED;
+            lim.features |= Feature::Zoned;
             lim.chunk_sectors = self.zone_size_sectors;
             lim.max_hw_zone_append_sectors = self.zone_append_max_sectors;
         }
 
+        if self.write_cache {
+            lim.features |= Feature::WriteCache;
+        }
+
+        if self.forced_unit_access {
+            lim.features |= Feature::ForcedUnitAccess;
+        }
+
         // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
         let gendisk = from_err_ptr(unsafe {
             bindings::__blk_mq_alloc_disk(

-- 
2.51.2


