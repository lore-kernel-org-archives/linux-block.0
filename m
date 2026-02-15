Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844F2E2852;
	Sun, 15 Feb 2026 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199176; cv=none; b=iVvjawRVcj630cX4LugLzBhoGGJ6I77FT/qEf6BxbTT22+9R8/PZI/VkF4dhbYA73qj7fRhXkBlJe2MjREo23HottjY3jnPCwbg2SukK4Jb0Bgb038kzuSD45wTw1NXudl3pZVo0DgWOKegpCnXi5EB3AJAL1EJM4ntn7kJEnXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199176; c=relaxed/simple;
	bh=SmeQZXFebNfgMhT0PU4tfkkh8SCMyfZDkLAJp5Aj2+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LyfPNv0xwFM5EOzLlQD2IfaRVuLECaNiBNlNLh1OVzm7ixjTyWRnkVgYgEntxcx3EprSR+Bg/ERnHUZgF3RNPzAy9h+pnzBGE0ahjHihSq3SHzJ9aTaZWPGnvc4QjUrzeT1Xy6JQTCUC3L8Sb3dDI9wWbxh5MqZHp//1VeEWXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knbOyE00; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knbOyE00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864ACC4CEF7;
	Sun, 15 Feb 2026 23:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199176;
	bh=SmeQZXFebNfgMhT0PU4tfkkh8SCMyfZDkLAJp5Aj2+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=knbOyE00fHy5kmFNl9V+TkJ2VfcplCF4AeFvXCssIlmBjbGFlST02ikxq5VIxwjEU
	 cAQJZulXgIGpfYdvUVCxJROn345beJ63HQacigsH3SmHFtf6p18NRlKq6KUopXzvMP
	 u0cXk/H7K1cqwE1c8TgMcIaQT8JZIJ8HbbWVJrqAUqJoCcQ4AkQ6I2JCMEg6NCpB1V
	 WNJLYtEpctbJO+lrb2+BrZv31E/bm/fLWSwLl1rZbB/+HgYV5MEQO6KnUSgZvFPBRX
	 aOPMGZzY8v3UJ5v7Hs8a/C5B4tt8R42GuU9axuD2s12tJTy5vwFFzj621e6yQ19su5
	 xUCBuNIC4KuJQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:44 +0100
Subject: [PATCH 57/79] block: rust: allow setting write cache and FUA flags
 for `GenDisk`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-57-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3122; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=SmeQZXFebNfgMhT0PU4tfkkh8SCMyfZDkLAJp5Aj2+g=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhPxhVYrbg/jqgQz+TX3wQMfT4hRanolERcq
 iBGDi6PjuSJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYTwAKCRDhuBo+eShj
 d8VrD/9iDAv4/R16Jikua6mLzD8+doovIV+CniFnxdRh9EjytOr41KXGvjIE2jpebbEWLXNvnhu
 J/pLqVjdxVGJkfuYyyOGJZ5xUTfed3f+2oGEwtn/fIyLjQ02fBxX3V9uR5TDvxbMFYEJWCXVInA
 nheaxy+vjh7rP0DPWqslmsajzqztYr7TD+XYRI2yVR1YD4a66YlslCmcSohocxU9Hvhf1rAJ3Zv
 9yedHbMyr0+T1UzL9DwSfvTpA0G4mFNzlt8/mIorrLgbrdodHgrkzJ33KOnZm2oNyVT7rJER5w9
 bk7/iOGMYu1bwzy3NiWaruwGoywlJgeMJf73OaUEv5nfFZE2Ed5/6ScUDATU5Opvnru7I+u5H1z
 awIZnLhwRz1x9qCRe0FTY2+0dlTT7X9hz1CBw4OjNK5rDTIHFw7i2A7NjdikeEowX73PwJJ141u
 3dnbRekFt9x72pavXfVUAGCkRjoVYqLtrHVOdYXrmbpit4JiwFkC+h/iRnhcE1YKtY9huAtmyW9
 BTvx4eSeANFBm4KjSKnbeIzmztOTXC6zo0U3cwvpe93LeFxvnlMhsr77Kwg6SfWi6oAxNuuaR5f
 jEIhOrv3llH+ImrALAH8vYA4RBFVYDkvE6igKcpWXNkbTDaBpeijcGuBrbGhYPAbOkUUIahPV7K
 /dIvSHjKMitbfpQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add methods to `GenDiskBuilder` for enabling the write cache and FUA
feature flags. These flags are set in the `queue_limits` structure
when building the disk.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index a6f113ea4bea4..c6b9839864012 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -7,7 +7,7 @@
 
 use crate::{
     bindings,
-    block::mq::{operations::OperationsVTable, Operations, RequestQueue, TagSet},
+    block::mq::{operations::OperationsVTable, Feature, Operations, RequestQueue, TagSet},
     error::{self, from_err_ptr, Result},
     fmt::{self, Write},
     prelude::*,
@@ -34,6 +34,8 @@ pub struct GenDiskBuilder<T> {
     zone_size_sectors: u32,
     #[cfg(CONFIG_BLK_DEV_ZONED)]
     zone_append_max_sectors: u32,
+    write_cache: bool,
+    forced_unit_access: bool,
     _p: PhantomData<T>,
 }
 
@@ -51,6 +53,8 @@ fn default() -> Self {
             zone_size_sectors: 0,
             #[cfg(CONFIG_BLK_DEV_ZONED)]
             zone_append_max_sectors: 0,
+            write_cache: false,
+            forced_unit_access: false,
             _p: PhantomData,
         }
     }
@@ -143,6 +147,18 @@ pub fn zone_append_max(mut self, sectors: u32) -> Self {
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
@@ -163,7 +179,7 @@ pub fn build(
         lim.physical_block_size = self.physical_block_size;
         lim.max_hw_discard_sectors = self.max_hw_discard_sectors;
         if self.rotational {
-            lim.features |= bindings::BLK_FEAT_ROTATIONAL;
+            lim.features = Feature::Rotational.into();
         }
 
         #[cfg(CONFIG_BLK_DEV_ZONED)]
@@ -172,11 +188,19 @@ pub fn build(
                 return Err(error::code::EINVAL);
             }
 
-            lim.features |= bindings::BLK_FEAT_ZONED;
+            //lim.features |= request::Feature::Zoned.into();
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


