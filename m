Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDA923D2A4;
	Tue,  9 Jun 2026 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032281; cv=none; b=uAiUR/RPRRk6+hps6QaTMDfmgt1iVFa6P1uKZwumTF3iOcRtor/CRiS0V8zb9TdivLnu23Ygv/cdfj/cld2MD90p7e0/g6Yk5xSI3gjAG2EZipDAklaI2fo3WvkPBOf3Cv+ty1SOb+y3rka3mIakIxflQreMCpMHNOWHCFEGJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032281; c=relaxed/simple;
	bh=mBVFER4nWrZs+8ynhjMfZaNZazMthVQxUgWM919F7I4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+y75GUSZO+DiKd+yoMOFrCQRvHgOXtn7nYykhd8IP1in9sxp6/GtsFZBq0Soo5M2IAder4rN3UIGzyqtV5U3HhjxxobdXtwqNu5KaEs1j5NM07bFltzwbrEWARDI5rjfeBemrgBiKYtL8P/thsAqceSgsJo5sYp51NT8A1rCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjLr6wq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjLr6wq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C241F00893;
	Tue,  9 Jun 2026 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032280;
	bh=KilJT6sKvydSYR5+me7VI/DGNTEVkZbaYVToN0IHPfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BjLr6wq4e25sVTou0OaA6fD+9JF++b1zX3fzRdWtlKGizoHcOiMZQ7eSaLZkaQ/GT
	 qlTFftploMEN10YzFDj6Edo+qC4MJjG/cS7KqxpRyAgugcKFr1bAHTYjHFmhiZxIee
	 IlxcTGJBV0ZgmVmbWTjj4jgMP2krdboUiOMkxqG9mIMYBzPrYmcyt44gapjfWXziGY
	 5tkX0g+Ps3sNKE9uTRpBnvAYCAzQEGfLHiq60I8zC0e++1WYve+FV8N0az+ouabHUO
	 /OB1c8SRM45bd5k/jAqLzJ8GddId96lhURhdpoqgOpe04dFueNadbtUcjipLX8cOP6
	 MqpMgzu99sw8g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:10 +0200
Subject: [PATCH v2 31/83] block: rust: add `Segment::truncate`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-31-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1671; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=mBVFER4nWrZs+8ynhjMfZaNZazMthVQxUgWM919F7I4=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTQNzHBxSzi8DrV8H8g1Ugz2ZxPBx/cKvwuy
 5a8kGpX0RWJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk0AAKCRD6UCkIqsW9
 0Hw5EACkjHqDIlzn7uZ2gAggaV5oUwQ+rp2jrz3Nma9IjCrnBK4Q9p6cn/1CrpI8nyc7uVlIwbC
 5+Vn+PielpQcAGzBTH55vXrrepSbx+zx4Kue04PX0vNq2Q2lIVlBDPvGg5FajY03X3MtMtTEV6B
 UQSEKX7OUt7j0VUA+wwaLwxw6NZJFvQbIwsfqo7qFPSUakUotBvyxwP0bdpdulzWgxhUgjd4ppx
 nQqzGSG1Pd2TfvNDBubKFRLcOpbSQAtifywnvaNPTHWb2YVEDj541UArVxVoqOCMGJnrQWqf+Xu
 W9QjQoA/HEi8cQ3JMt3JBZlaIWjLT0BagtBWUhfyhaUL62UpsnYP+5WKag7xRI5J8No+Nt2yaQp
 S1pstT1rf7lbQmqjjjX6yEo4+XAiT77Uhc0eMF29yjfUJtfPcN3xs4nwosWa0WIbKr5cSnNH3Wv
 p/9C1a0gK2oCFoYlrkiasejuWjM5YCff8+uI5R90KnFWGrkpuw73yo0ybUed5y61Y0BYpGtk1KN
 t0BHh3h2x8DTu33oax6VhJoH4DKqunh/6ax+B4o8Bqks6KRA3y+KLhZpQTlY2/SobAzBnPH1QCW
 uaaA43Wzb2Uf7FBC7GR1tdXKuKsqs0Y85bpkP5PGeEpINnbwXwpuATZuvfQWVCLzmNYgLVvXgrV
 ts+xMNrZWroS58Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method that limits the remaining length of a `Segment` without
moving its offset. This complements `Segment::advance`, which can skip
data at the front but cannot trim data at the back, and gives callers a
way to clip a segment to a maximum byte count before handing it to the
existing `copy_to_page` / `copy_from_page` / `zero_page` helpers, which
already bound themselves by `Segment::len()`.

This is needed by rnull's partial bad-block I/O path, which needs to
clamp per-segment work to a sector boundary computed from the bad-block
range.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/bio/vec.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/block/bio/vec.rs b/rust/kernel/block/bio/vec.rs
index 99ab164d4038..61d83a07397f 100644
--- a/rust/kernel/block/bio/vec.rs
+++ b/rust/kernel/block/bio/vec.rs
@@ -81,6 +81,18 @@ pub fn advance(&mut self, count: u32) -> Result {
         Ok(())
     }
 
+    /// Limit the remaining length of the segment.
+    ///
+    /// Shortens the segment to at most `new_len` bytes. If `new_len` is
+    /// greater than or equal to the current remaining length, the segment is
+    /// left unchanged. The offset is not modified, so subsequent copy
+    /// operations still start from the current position.
+    pub fn truncate(&mut self, new_len: u32) {
+        if new_len < self.len() {
+            self.bio_vec.bv_len = new_len;
+        }
+    }
+
     /// Copy data of this segment into `dst_page`.
     ///
     /// Copies data from the current offset to the next page boundary. That is `PAGE_SIZE -

-- 
2.51.2


