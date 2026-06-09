Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015794D9907;
	Tue,  9 Jun 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032472; cv=none; b=Q/eD2Iy5myS/UqIt6H7jjcZIyOo41LFpQyvshYvU3NTxvsqrCCiTWYccNuZA2pFg6ccq6s9VFq6/GdqwsZykCed/PYII79H8MWLWlenCT7njR9DJsjMkV3rjXaMnjmgzr7yKTIH1a2qJs+1DWTuQNXI/qTAloU89Nilo6G3Aihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032472; c=relaxed/simple;
	bh=dEPmlUxwcO+Z1aUp8x6Cur6OyCq6SpGxV6GyA9LbAqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VpJ7IzYwep88TAbTEdspYJbJIj4o4RCzC1WKCgZtozPqAqBshlhTN85XASbF0qoX0dKTlp36RajJrTOLVh2sktDExqJcwBzhs5Ev1GvvgNNafLnGudLLqDnvqfV4rsPwy1OXQohvlpPrM3fZa0DiQTTiueh3olQxKtBFdBrwfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUOTO/5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUOTO/5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861FB1F00893;
	Tue,  9 Jun 2026 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032471;
	bh=yCdEZ68IJNlYPAWBV8MghxbvXE9NFFUFrCiuA8Oc9Y8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dUOTO/5dgtxbFMdbxqoipkYQeeWf8MyOeQdKWhPUr0eI7maU7Fi4OjvUNtNGPrfzA
	 VJyzqcM3ZAuTq+okb8Jf5Xqk4RghniTH+a5ursvS/slGyK4fY8WvJoM08LQ59mCwz6
	 cAJHfKOn1AixaoCzxEyYeVSg+ijkUwfDC6DkCyzmV/Q+Cu1yIVR6wKMuuBaTtXNUwB
	 PxqBv3/7ZLl16DL9aeX2HIKxNjPAt+s0UZFlWv4nn1tfj+FxIe6k/Vi3JcJEw6uDbG
	 0TW1ekT50kNXN4mxwC08P6YQs7JrrayFslQnpWJO2f1xZ4JqJ905syUyQHDq01ZYNK
	 L+ktlL75QCAYQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:51 +0200
Subject: [PATCH v2 72/83] block: rust: add a debug assert for refcounts
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-72-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=dEPmlUxwcO+Z1aUp8x6Cur6OyCq6SpGxV6GyA9LbAqo=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT1t5B7OMznwXk8t33ak/UoKnSo82sNtKPE4
 l1ctAFhDBGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk9QAKCRD6UCkIqsW9
 0J9CD/9f9tEnTGtTO3lz4bba9E7Rk81Gu6FqZ3nTV+ku9eLPqem/tv5hDKXD6QLR6I0OuSqvaBY
 ty/gCLetdWBvzLW0dGdDvRlbMPNShJUycx24awKp0NF3w7c8KxZ54aVMelLfnVL1N+ZhL2T3P4G
 r5cYQPdu2/asYUvO2BM8cqe0hcWn4tn+0H5Q8iSsEW4gZkZTjbuvkaN2I0a5mIbdy47Qmmjbur5
 Q29HxY16fLW2NAPN6e1slr4/LWaUkhfggan73RC0kA8eGcSG4Y+4no49aqK8SYaPAhgk6ntbyY+
 MJZbIlepcJA07j8Lsi1JlKVtmiw/gmOMv8S+kZrQIfbSptnBHBiinuDt5v7wIXBKsOMpvdi48Op
 m3WvEEO6D+ClOMYhT+sO7OJwwS+9LBBMncaUmKOhCtyOFOlc/jxK7toJMQlP5sOJAmo9nhIUVDX
 By70DQOGP/Iz5xDcZEgkFrPz0hapvzSlXJGfg0+TIqTAPwreJV7P8Dvc8sNg3+nAi5xJQrAVL1u
 r3wpA+ug/ZZNExmQASxAruvhPt+nT/ZyVJMzabVkjYq62zCIK7VCBuqdIH/1zo/mchWvy3K/uWM
 q4kJCjGW2z9SJICFwfA9UUtG8vkTCI/qPTEoVjpqf3e8p+xnKXfAQmWd+wkOxsisgyobBEYRKsL
 vIUoFDMOIrrvLHw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a debug assertion in `ARef<Request>::dismiss` to verify that the
request refcount is at least two when an `ARef<Request>` exists. This
helps catch reference counting bugs during development.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 9c451583e75d..05b167dfc6c6 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -619,9 +619,20 @@ impl<T> RequestTimerHandle<T>
     pub fn dismiss(mut self) {
         let inner = core::ptr::from_mut(&mut self.inner);
 
+        debug_assert!(
+            self.inner
+                .wrapper_ref()
+                .refcount()
+                .as_atomic()
+                .load(ordering::Relaxed)
+                >= 2,
+            "Request refcount must be at least two when an ARef<Request> exist"
+        );
+
         // SAFETY: `inner` is valid for reads and writes, is properly aligned and nonnull. We have
         // exclusive access to `inner` and we do not access `inner` after this call.
         unsafe { core::ptr::drop_in_place(inner) };
+
         core::mem::forget(self);
     }
 }

-- 
2.51.2


