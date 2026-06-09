Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BD41D9E8;
	Tue,  9 Jun 2026 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032648; cv=none; b=fr/AFT7i7+AZhWTNYTZUvQfFPc5gbclhVx8IjnF2kPivRoJ4uKzwV27odkW1fFoylorLSmkvBwt0rkC6fHKtgZxVFyjyvFgN5sI7za0QJ9Cd0Fo1MGwGETOI+VVjDDT/sn9upEq8b4kiGaQFce1GtPk0acA2eOV/J/VY9J2bCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032648; c=relaxed/simple;
	bh=fop9S+9mzVcsTkO1rMOxG+AfrBnmsW7E8Z0RHs803s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4J/hjoT0UzgPbHGTOGxkt3YZOQXrRB7vrjTMwJPSghW5eOQo2IZi4BQF6xoSBS9MG42fFQrPYAvBfkqnHWkn0UIsymFEkUTolVeGdMqClMeiaaN8ON2ZEor1ae4GfHNMCRos896jY1O3NLFU8n1ezBWYQFW4TXUM+PqdE6Pths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlrvzFZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlrvzFZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF751F00898;
	Tue,  9 Jun 2026 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032647;
	bh=l4agbTirNlyUYcdjQT8pmN2Uz+Tb+GEZRsrovxY+04g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NlrvzFZvPGR4r0FNlUqsKm++UKOhHK9QP0yTaBU7RQVTO9eHAX6zE73w7SOEXOqzz
	 HbqiiTpXR9TGlS3R1TpzwnAtw6OLHW7j1knJpzQuF1e2fd/qEFd7Ucy//TBEc/0zG0
	 /85I1zCRbhg2xHXdMU4mUkMdbQBEOI611kkbd/C4oOPDg7eDylgpbUd/NxpHdeZ63U
	 xF4Z34AwNl4fAkpkmCVUBZLoKhABDFEbUZI+/VPNNgi1tPJErzbOhbadAj10o4G+lp
	 9PS5nNaobsnkaCbtJ/Pa8O3hsxb0Ft3qvZ3psLw2KYXw71L9zYW6exHzoYng1bQ8bS
	 rZNA+z5ZE6EZA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:53 +0200
Subject: [PATCH v2 74/83] block: rust: add `Request::queue_index`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-74-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=fop9S+9mzVcsTkO1rMOxG+AfrBnmsW7E8Z0RHs803s4=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT3vhakzgq4tXf5rIzfy3B6X1NktI4mR2vyG
 W7qLn2llZGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk9wAKCRD6UCkIqsW9
 0Bg7D/4snWv9goqos2qzgRQYcA8FkUKrKYnV6R6LAk7i9bC3v34ZUm4z7VyF+eJWfWf7o9V2Er8
 TbQZy5aVqp6ptRU1JCmcHZifV+9oQ6ywjAbputtg8TgQHjUQ2c28RZzZdwJDHRFpT6qUYkeJ7lc
 5nWrAhMhkxiFs8f4jZiFnU3P63hgN3dyOWS5mrO41E13MtvQ0/Dq89IlRTRGvihZbagHHD1IKsA
 TSoIEhfng5ttW+FQLZft2CpwPoz8IjnlflIGn5JTM+adojBxi2le3/MYoso83fC/8YEMQC6f9zM
 sEeY0E03bg1r8Pc4KPyG1QHTsaQyO6/xpFZAR2hT0fZubKdABYnBt1ESu8EcWmU0XqZDbG+VGw0
 Y0Mb3xXr3s0mEZ6VnY3A8wBem47djoGLzkoiDukouoN40CfeWvBodvM5ZFb69nLL3imY+xE0b7k
 L1/cjFAzaR3sBLT0vCHzjSFo0HV8KzTzOtPlt77fSHtXRGfK92wysvVWo1ZUClsdTKXa/tAPfZv
 0v/lusk/BplPsNb9+xgGQvAwcjQ9rNu9ZE587fvULiyig1jEbu0RTZONQSjXLN6H2iinQ65N7NZ
 0MRGFoQqvNbkKm8pGOgr3vIvmgbIGYlT7iKFtWGmqA2AhYDsz1OhXxGaEgB2jfRT0rkCV7eydxd
 HtfYGWM0XD9snvQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to query a request about the index for the hardware queue
associated with the request.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 05b167dfc6c6..54b5202567f8 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -191,6 +191,13 @@ pub fn hw_data(&self) -> <T::HwData as ForeignOwnable>::Borrowed<'_> {
         unsafe { T::HwData::borrow((*hctx).driver_data) }
     }
 
+    /// Get the queue index for the hardware queue associated with this request.
+    pub fn queue_index(&self) -> u32 {
+        // SAFETY: The requests is guaranteed to be associated with a hardware
+        // context while we have access to it.
+        unsafe { (*self.hctx_raw()).queue_num }
+    }
+
     pub fn is_poll(&self) -> bool {
         let hctx = self.hctx_raw();
 

-- 
2.51.2


