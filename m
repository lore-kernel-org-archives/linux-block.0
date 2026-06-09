Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9934D2EDE;
	Tue,  9 Jun 2026 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032511; cv=none; b=QEJjpK0PyvOsQKVWHfafG9hz2ItOQomGoa/g0Ok72MRsfA1QJvJdhjXHvy8EXYMZwEK+UX4SbOZGooGTQEACXlMP/BD7RPeS3cX1TcL8l5yxAxo8TJzSUL9eNFl+3ajjoJnV/VIO+CaBssGMCVKk1r21g6a6pYUJ2Z9RlgaWXew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032511; c=relaxed/simple;
	bh=5+GUPrHafhi7e06njalxCX3qEtJzRjQWZ+jqQPaKrWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hjav/kASQxaweoDcANSNnt5QmSOarzkFGiOHHqzponrBSaV/J9LO1W1cb/YF4XI5lavm8EH0fTC/2awxY6bdr10NnMr4gqPlnmqDwxdSkxcEO71E9TqlJ6rLSH88BnYasq216NyXwN84n/b/Bk1MIpXuCBKBOw1l82BUXJQ4cPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILJ4ZGV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILJ4ZGV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4970E1F00898;
	Tue,  9 Jun 2026 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032510;
	bh=64hvSmLNolq6thR/XE1WahjnyPiD4J8xEpWXph8IhxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ILJ4ZGV3IqhZKH9TQnw/S+0cy9b56XT90Qwagujd3q8x0Dr0hMVaLhsl/3XdWRHVq
	 E6koHy5xCOlv8iDzC1IwtRwNRrWU412XAyZNC8ne/hwGDhILazbZ8i3t09gJpDalis
	 wJ0JqcmxEp07yCSIsELbbLuyWnexgc30pw09eSenYfYBeYqqBKkesHqwHL/6pKdmsb
	 4Sbo+qipLgem/kIYtOsmUWP+yPGyjBPF5WBQ5LvaCYixLpsvj0//8c6ssvZYqUxK/J
	 s47/hjd4zM0UDTuo3X9bC5ZK1Bv+5XlqZ0pa4vGdSaN99upOFsPJQfyX19HJGdE77r
	 hnZc2RwqC5h6w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:42 +0200
Subject: [PATCH v2 63/83] block: rust: add `Segment::copy_to_page_limit`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-63-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=5+GUPrHafhi7e06njalxCX3qEtJzRjQWZ+jqQPaKrWg=;
 b=kA0DAAoB+lApCKrFvdAByyZiAGooZO2hozbAw63hLJZ4uFn9jmNCLHArRdSgJaa5AlVUL8B6Q
 4kCMwQAAQoAHRYhBFeK2cjZZnYmKsBqhvpQKQiqxb3QBQJqKGTtAAoJEPpQKQiqxb3Qx+cP/2/W
 ms5Tmyn1Z/jTN07+FyjyTUSksEZV2eNtSnPfn+USQ3MWIf63EoTMejbL93puBw4G9QuRs9mezAZ
 jdtRrCILq3VtPqdFtdYRIrjZzeSHKZy9u2l+9QmI8uAIkMl6TwHxswM1XjGYB09WNl3jvTpysFa
 QLVzHdICSrtPOK1TvUCJUs3zA92cxKEY84XPRVpGh1jnWleCYI7ZEtiuzlLseEIFgGhv3oSguWL
 xdEKUluwi/j+kLqo1LMR856+wcpzl8ujsESFklsm5nBW6Wd1AygX8RFUTzD+DuemwWhAhiCzeO+
 JEdcwfO3MNzTi3roXxSHuglsRaol4BJO5dV+JXx/q37ns0vuxc5dBdJ+4xh1w4IL3az5kB6Gdsi
 DABd7XeiTBCf3ZUicvObJ+p/w1jBtoZ5TE2SU5UH7c/DDnoBlF5/WIXJwkKWUvq0Mj1xQ1U1EF8
 mfH26FpRa5F4Ol3QOooJVp5hJqtthHVXlyjJqdOuWi+A/PDtqQ1LUNuEALgRDO/ec+C13MDo1ZN
 MpzCaFWHq3AA0UEJ4qtTLO8TToZ6QmTvhMgYFDelcOErKCXqcpFViSa3qcKH9aMY61sNysMxuUE
 Ay2NQVXelzeffKyV8c8Lg2+DWJhhwbCwUT/XKAJ/4at764te4+OUcIfOUzMrcxMjfiNzpP9Urm6
 +DfSb
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to `block::mq::bio::Segment` to copy a bounded amount of bytes
to a page.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/bio/vec.rs | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/block/bio/vec.rs b/rust/kernel/block/bio/vec.rs
index 61d83a07397f..82e89a1d17c3 100644
--- a/rust/kernel/block/bio/vec.rs
+++ b/rust/kernel/block/bio/vec.rs
@@ -102,13 +102,38 @@ pub fn truncate(&mut self, new_len: u32) {
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

-- 
2.51.2


