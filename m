Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD22D7DF1;
	Sun, 15 Feb 2026 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198929; cv=none; b=Tc9WcKqGItfOICj9sKUPlrH8JCWnPJBlF2n0Hzyr1l97I9doB2+2Mt4cwKy2XTZCL20cdi21YLj6/lt1oy/FwU8aL+fVte3aGR3+tghtjIIRJ/gn3uWqSdWgMDekIvdk9IWvkbEcDXu8bsQTqmQUKut4+Rcm0Q6T0Iv5AlH6xXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198929; c=relaxed/simple;
	bh=uYEwg9qVRQ0NhWZcmlYe0zv8laqBKSDqB2tGW/RMct8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3zsPLnIOMnQQktGhXgnhQKyuKrS7LRUcKSRhVXEPUpNu5XTQnFlKwLkR3Z6jCxuW+rnrIyylGVPrj/bsUc5vkAuL5eIOSLY7tbHKOaN5ciHSG0szOPRjMpXL92T+sa4YCGRuqEn5o1KZI34SMpK5G4X1bhEE9+Lejqm3cAqe0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU27ZXms; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU27ZXms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D6AC19425;
	Sun, 15 Feb 2026 23:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198928;
	bh=uYEwg9qVRQ0NhWZcmlYe0zv8laqBKSDqB2tGW/RMct8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CU27ZXms6kIrV7G19DfaAaAOwUelhCVipFwQDeCbX4VWn6wVJPDLJ3grDPzSnCtK+
	 KiuMpnyzd8owICPC2W0nqFdb5DrMTnIxEomPXMeWMm3QGk8Qp3tZcdom0FXNbB1OF3
	 xwp2ycZjZvwEnm0SbXFmmEx8fPkYkZN5dSSwlKMe1WpNA3bGiOWZ7mHerhivkeXudH
	 otqNDMK90oSKhrl57Wv9F0Iq4PyNxVeEhkJujbCXcvaVMxk2fhM7WPYnmy0J2J2rSd
	 omkM1H18JL/cwXlob4zMsBQ7RMTfe/1XOx5TpA5tlAHEbRBQbiQIXRYlM4rP29ymMY
	 h+cIgNNxzckGQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:45 +0100
Subject: [PATCH 58/79] block: rust: add `Segment::copy_to_page_limit`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-58-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2840; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=uYEwg9qVRQ0NhWZcmlYe0zv8laqBKSDqB2tGW/RMct8=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhPD1Vd13GaRkq5agX96n72Np4kCvlo5WLCD
 fk9Egr801WJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYTwAKCRDhuBo+eShj
 d7efD/wPEHMykdNbgIQEgFjD0g5u2LBnODSA52TqS+8dh9ONb7dkKxO6CM34Xdd5hZN9vKMUaJ5
 oyXEeVDHOLxk95g1hPvhVpYZ1QVVxOEySidpbAGXoIucHyW3bNa/75cg0df/ymrsxTT2vsZbVoh
 aWjyFDqwMSw0k6Dn0E1nMfxMPlP2IGXS/G8AxSz/Y/1NjDs/ln6V27Menk1/1K4/WfWpa2g6jtT
 i7LiKLwqGTtRBXq/9T4PO6TuRJedJ/2IAUxbftcIT0mUbMSxTM2rnJVl7s5NouEgt6D2YSdgKoV
 S2I0ax8k7WECCBLHwKmcmPI8WX9CqSjg0X5BLpIVT3c7KNLcrCk88REdnMIszn21mE34J1gVp21
 wujZR9oktHlgM7OSn/hcmXEmq7G05hqdOO5nyvDruUebu7pdNJfDrg0czUEbX9hOpJBHOInTLyI
 ysttQjhHvQkaNthtvcRF3/nI7va/qZfjWTcMZPnv8whDNEXUA+xip5OJ2v0stNbB1kGlkUeQuUx
 OcJI0uds2mDLTZpGXcOPYOCNutpX8eCzUMGFi9z3oTCF8QhQxfRs9QI9uV0ApIqO9FUsZIAdhG2
 Kmzp5QHauxc0nuXi7kddfnCSwPO9b2rR013RDTJA4cu92ljKeaL85sobd0WH5Dc2H0W0HHVTO1K
 fM4GmOTX+d+pGvQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to `block::mq::bio::Segment` to copy a bounded amount of bytes
to a page.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/bio/vec.rs    | 27 ++++++++++++++++++++++++++-
 rust/kernel/block/mq/request.rs |  3 +--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/block/bio/vec.rs b/rust/kernel/block/bio/vec.rs
index 20cea478050b9..ed1c1374c9c76 100644
--- a/rust/kernel/block/bio/vec.rs
+++ b/rust/kernel/block/bio/vec.rs
@@ -79,13 +79,38 @@ pub fn advance(&mut self, count: u32) -> Result {
     /// Returns the number of bytes copied.
     #[inline(always)]
     pub fn copy_to_page(&mut self, dst_page: Pin<&mut SafePage>, dst_offset: usize) -> usize {
+        self.copy_to_page_limit(dst_page, dst_offset, 0)
+    }
+
+    /// Copy data of this segment into `dst_page`.
+    ///
+    /// Copies at most `limit` bytes of data from the current offset to the next page boundary. That
+    /// is `PAGE_SIZE - (self.offeset() % PAGE_SIZE)` bytes of data. Data is placed at offset
+    /// `self.offset()` in the target page. This call will advance offset and reduce length of
+    /// `self`.
+    ///
+    /// If `limit` is zero it is ignored.
+    ///
+    /// Returns the number of bytes copied.
+    #[inline(always)]
+    pub fn copy_to_page_limit(
+        &mut self,
+        dst_page: Pin<&mut SafePage>,
+        dst_offset: usize,
+        limit: usize,
+    ) -> usize {
         // SAFETY: We are not moving out of `dst_page`.
         let dst_page = unsafe { Pin::into_inner_unchecked(dst_page) };
         let src_offset = self.offset() % PAGE_SIZE;
         debug_assert!(dst_offset <= PAGE_SIZE);
-        let length = (PAGE_SIZE - src_offset)
+        let mut length = (PAGE_SIZE - src_offset)
             .min(self.len() as usize)
             .min(PAGE_SIZE - dst_offset);
+
+        if limit > 0 {
+            length = length.min(limit);
+        }
+
         let page_idx = self.offset() / PAGE_SIZE;
 
         // SAFETY: self.bio_vec is valid and thus bv_page must be a valid
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index cebb30fe9b3bc..bc655d202ca01 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -7,7 +7,6 @@
 use crate::{
     bindings,
     block::mq::Operations,
-    prelude::*,
     sync::{
         aref::{ARef, RefCounted},
         atomic::ordering,
@@ -18,7 +17,7 @@
     },
     types::{ForeignOwnable, Opaque, Ownable, OwnableRefCounted, Owned},
 };
-use core::{ffi::c_void, marker::PhantomData, ops::Deref, ptr::NonNull};
+use core::{ffi::c_void, marker::PhantomData, ops::Deref, pin::Pin, ptr::NonNull};
 
 use super::RequestQueue;
 use crate::block::bio::Bio;

-- 
2.51.2


