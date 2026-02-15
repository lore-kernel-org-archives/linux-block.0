Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76B2DE6E3;
	Sun, 15 Feb 2026 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198992; cv=none; b=fInowoPofPcfTxzTMC/mrJzgoF9EZAFt9b97cyv7S2UXv5ULNXX60SYYzYp5IgJTG+PvHgoP2m09CGLxLqzKg4sAFw7hfkCk5II8FPi61vUX+CM/5l7zhV7Z2sB0xAIQ0S/zUyMT2kR4zii7HPUrQaSi8YXLGslgspH6JDR2rLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198992; c=relaxed/simple;
	bh=uZ4trczFY+LKih7mhcNOBkSAbmZSPt6rd19ccjIIzfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGwwxa/yjYLp23SVl1RrA0tREN30ipn3JnI/bC2a/B2Z8Em2i3DJSK/tS9RPTkHneYef5MVrBb5/Px46RS4a1BP5bq2DEn1KX7ZsmD0D+j1a0oX3a49UqhBFSd1gHWiIi5voHAy1YR4Y4ouAh59O3QAGZdtvsVi3K9cAGDMgg0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0O2olDr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0O2olDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B767EC4CEF7;
	Sun, 15 Feb 2026 23:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198992;
	bh=uZ4trczFY+LKih7mhcNOBkSAbmZSPt6rd19ccjIIzfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D0O2olDrQqf3mr+n0B/sizmoyVYotgDI8QW2d+giikDSGklyaqt66EKQtPxwQIHK/
	 /+eyggsDhpVYkE72Jwu4mAsgs4zHHlNPa1861MK9HOJ1iwhcjMHCrLJMeMYNvSRw2W
	 OOLrdq3ip4v/UEcJRCLuAyUQacedRcmMzdJtcdXWC87OxZOrpFkg9TVuD7sKdFVGii
	 AcqxnDafvoCAt9hPcxtgYbwpS1W/0ahnc7KKXnl8HywgFP8pJ3/0R7IZnNjR/usFXg
	 8dLovfmM0CXcU6Y7KCfp9NiSNFzMGU6GofcyjKUnz1W8vPas/jJuv4/FTg0Mp9H9mR
	 hzysrmKtP6VHQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:12 +0100
Subject: [PATCH 25/79] block: rust: mq: add Request::end() method for
 custom status codes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-25-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=uZ4trczFY+LKih7mhcNOBkSAbmZSPt6rd19ccjIIzfA=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgyY61m40HV541SUFIPkQbPNupRrSnrD107/
 ev7FWE4kAWJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYMgAKCRDhuBo+eShj
 d8J6EADFFGcykNftC/0A3bvASuRhPdNg8UE92icnkqqo0iumqG8bAA2yHrZF63Go/+zkqglK3R3
 l/mR8piOTJFTaKLIbzeQ+Mlo1gKcErgI4mXi8hY+3UVPfaywVmNojac9uq3zeLgT74ZvJV2BcIt
 PoryU4zS55f7EaVjqCtpgMpQjiWMNu4RQ+tYSczZmLC3EQlt7GDw+q8bxW0uT7LTDBfkNpFqlB7
 uQt3HWq0k4k9+cGZg7jWMla1dEiZ7tvnexQPWqfogiWAA4YDsiq/EPsbZXjCipB9jjM7qv8Zaev
 1KVsjOtOFpH09C1G6bbEYV/yJNkxKbqbY2yEhjlTt1l+Gc6N934CuuHoTKFY/iAgcMvSfmFT3E5
 K5tK+mPp/R7dcoh7/x7oOmJ12nETq2fQ+iPI9JwiaHuo+gKBrLzAGzLKtQdjOI5tBJK8LEHrMne
 EQ99RA6D8TAzgTufRXWNCZkfwNTs4lYrWHGUe3P3aoKAqNjqu196xvKG0vSJU1DjJtdS5Tq6FeC
 ZhyfWV50Q64PNQwYpqX3ivNHlfq4Bv3te2MrSUeAhjMNhySjA+XLzBiDOPWvd2OoncP9ynftR8X
 RUV+E457grGB/zBi/HAkuzdrb8RCb1OzjWCaaWBE7WkG/VTILheDTq4Ayf+O3aP1uspkMNT3Vc5
 KHc8UW1mp+karKQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add end() method to Request that accepts a custom status code parameter,
refactoring end_ok() to use it with BLK_STS_OK.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 8fe7e126c522a..38289b9f966fa 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -297,13 +297,18 @@ pub(crate) unsafe fn start_unchecked(&mut self) {
 
     /// Notify the block layer that the request has been completed without errors.
     pub fn end_ok(self) {
+        self.end(bindings::BLK_STS_OK)
+    }
+
+    /// Notify the block layer that the request has been completed.
+    pub fn end(self, status: u8) {
         let request_ptr = self.0.get().cast();
         core::mem::forget(self);
         // SAFETY: By type invariant, `this.0` was a valid `struct request`. The
         // existence of `self` guarantees that there are no `ARef`s pointing to
         // this request. Therefore it is safe to hand it back to the block
         // layer.
-        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BLK_STS_OK) };
+        unsafe { bindings::blk_mq_end_request(request_ptr, status) };
     }
 }
 

-- 
2.51.2


