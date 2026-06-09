Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670D4D90CA;
	Tue,  9 Jun 2026 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032402; cv=none; b=WApNq9D+NCCQ6Ry19ZEpBNZXTX73cEAXJRkbywStj9AnFgghMWRJgDmVwCs8Ta9qw6RujZrpbYGeMissH9a+2wBRhdgpCXHvPGmrzuGwmmlPsZbvZhUCJe5FXOKrUBorQNF/zq2QsKVBHPu5Qf9wvGxu14eyQG0kS354x4NGl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032402; c=relaxed/simple;
	bh=cO3QVWHBp3bOOCRfL0F0a19BcOtYRij0a3oTZkjsymw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t64rpdS4tsXuTPYT8Vj5GiPND6UQKqFObV5V8pYaWvYB9+FJDudF+rB39ioVSS6b6DJxufFryvtD5dTe/b+/dy1Not1qytQmpLLnJMtzkyIePusonaMOiAgXwnpRwcvrUtXpDFDfTPt5IoU2ozwiNauq3dLPLDrkLBtW1ERDjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID+9rl9i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID+9rl9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9CB1F00893;
	Tue,  9 Jun 2026 19:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032401;
	bh=/9ybO/t8zOvRCr2bRBHoQTxr/dQJgA17JKTcxpSIg3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ID+9rl9i5FcVp4DSVY6a+jf6ixiMKI5GWzj4dZM8z3TyyuSTQ/lmM2T1i5l9+u98b
	 GlgxxBGXBxmGMysQbxzci7NbKQL0jEI9AzKOOD4egRna6tx7JQ7Dg1gpktL1N82g1v
	 k5SSzdNm2rD2uR8jVLQ+4Ey/lpiEzn9Zt7QsX4oi7+W63hc6KlHTUHIUc7mhXbqJYb
	 6wiwyUcjUMaFU+kjtxsbP7MjqRxX5b+UvHGP8qT870Ix6wvfZTxIt3vEV3TYTBKjEJ
	 5/ANL1p0rITS6eTWvkUkcZWrDZfLuWRR2DdS6ydQYMaquJyIxUn7cI3B3yKaNJz36g
	 0BkwYrWU9CVXA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:07 +0200
Subject: [PATCH v2 28/83] block: rust: mq: add Request::end() method for
 custom status codes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-28-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=cO3QVWHBp3bOOCRfL0F0a19BcOtYRij0a3oTZkjsymw=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTOwOJ+Mxk74baYbuWET2T8HjDFCqOB+l0b0
 r0Fytyjv8eJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkzgAKCRD6UCkIqsW9
 0Jx3EACqq6sM1Fp2PN6SLigvCgaPbaiBkyHfgHxbnJcEjrYb2k+0u13lhvpIorRTR+3R62TV+WX
 /vBPhKnYOd6xObFSdUh1k5B0wEcyk2Zrp5yfnkOR1caJbTWxLdaks4KSPxWS9tbRdEorKs8J0me
 NowWypzsEXQ7s0MbXagvt7Xvm4cEXmSMeIbwKIesyDuEfpMM5ukqYjbuOX3gScAAB0SSKlerGRw
 OFKJdRvAZJ98xGMK4mWh917bVXcXM7vzqReCJ3sv+TBLHBGadx9bEEx/FSU4AtIUzWivyEpsLYH
 Uh9ntbu39dSC6fY9WX0vrIbO1EmpG3VeYS3X39MqsXBpNy2oyzdulzmwtd6goSEK2lvCwJXLW/M
 1CC5h/qmsIirn4D7Wa0HIXu7TUD6TR8/kULT0mBlHRtV93Wz5B2HmUU2PZ6FehGubZouGWl42E7
 MQO2zsb2s6YR4v0sBDtLrR38Bjufs4UHrAIxEkP/tK6hbFFfpe476bilYL0bFPBcz40Zx49rPBY
 xUioWLibTAF6J7imjQ52yI7AAOOM+M9sRW4nDooWS7kUvDSrQRsAnN0OeAaCo9gvh66otumNJqW
 6Pq5obt3DY/mWq0ctpr3BiEuz7ofHbpQ2HpsmQO5s0KRwM6AjJ2BmeQ7SrJaTw1m67uO+55Idly
 3tXDmex+9KNr7ew==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add end() method to Request that accepts a custom status code parameter,
refactoring end_ok() to use it with BLK_STS_OK.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 9e176f015ab8..c06907dfe5b5 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -336,13 +336,18 @@ pub(crate) unsafe fn start_unchecked(&mut self) {
 
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


