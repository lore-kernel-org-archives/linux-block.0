Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8537FF63;
	Tue,  9 Jun 2026 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032522; cv=none; b=uHxuykTZYHLZZYcWIBDpw1tJOo/8R6FY43up1ogThpaPlJp128+1n6NBeKGUwAiMvmlp1pg2bdOA6vijF5aJ73GHr32azoRw0atgYZ1Hw5nDH2KMWeF6vyv3wisVjVKonUaUjw4kA8d3IyO2FgWYrCyU4dl95HidwhfuYGvCehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032522; c=relaxed/simple;
	bh=DgqXpos7C80lClbWnsjqwY/+BJEIchncSKiJddAVFzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LozoHf0j4/z0O9nCTHQ9MUWB7b7Sgi9L7A6mcRnZI6H4c7b8OPfBngvZ+4nl3POBmtWepDlIwjjPYVAnhEnYGiPoVX4zxU6w1DRbJ1EoKPrOdvzA1xAoDyHGWwdI8LTiIT07SFjks69NoIGYtFa9hOSmNW1fAaoFlINE05ykJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnGNp+U7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnGNp+U7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C9A1F00893;
	Tue,  9 Jun 2026 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032521;
	bh=DZGnmBi8mHh4p9y0/gnRSVsorGqqRp78wd3TOoNIUWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lnGNp+U7lAm5TT7NragGdHyHIpj5W/ggjDukYYZfxoLkmwB/zHaT09MQy68txK4dP
	 RXCl0hNOempY7pxNynN6Su//rED5AGL4Cd0Tc5n1yLrm5xHFJRN1SHv89LAX8ubz7a
	 1qCZWTesGzjQf/0kVeaDe0Aus51szcX4jATCD1gTxNbx0+LIzY5eLHxn+h74dlQamx
	 ZuvDLtY4kQLwBQScw9NMu49hlkOoJpeNtQxL/0Ow4P505SyOmmGPdpgiJL4talvB+D
	 seoV3GintN5UCwVYOP+EzaHkep7a+IFnFChahUdWddmZZqbcw0a/G8BiexrddvdLf7
	 WWpKSQYu59U9A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:36 +0200
Subject: [PATCH v2 57/83] block: rust: add accessors to `TagSet`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-57-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=DgqXpos7C80lClbWnsjqwY/+BJEIchncSKiJddAVFzY=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGToQokKIiIK5c0rRnI8tRT1EM+BSmSLw36zh
 gEkP49VKD6JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk6AAKCRD6UCkIqsW9
 0KkYEAC5XUOUpCMv00hmZWvvpzfwCR6OoLx2WY3L4hGfe1HPjTDBH+Rs7HujdMlbqnVGEam8I7a
 MCW9s9FDf9sKjmX+T+bNrONZsuyPKQ8baL+2xE2zZcH8lsBd2aWU16gagSgfRKiNAUQGq+EcTwz
 /2IjccxOcK6fS4L9NIdKbQLqrBf9TSAL1+/HJg6m8Obl8BkqIxvFsPRS9+cJGrbjfvtMJ1CdakM
 SqH8o8A043MXmCjUlEpayeJyIpzhjXn2EUoEegAHXO9wM0F9ADFDzjA1ykrWwUi9kiGSr2WOX9I
 KH+dqr6K3zDHu4bzRrnyeAaY8oCJMM6wTrCW80OEePgqvhraTsKTf7KEYFLNQR0r/ZsW9FtI8vq
 yS7OWDzyWFIiDQmlB+ZtVp5jpw7PFgpqug+os3nbKsFhXEvYMavRRMgCkeqsQx2zQma6bJhHd6s
 +F/e/jgQxhqe0kqQIIp0FaZ/UhI4pV3F+PHRrXmmVqPJSTqGNplMi+ubYnfa4jh3yRE0S/R7q5m
 QfFU+95OZf6/SwiSA5EunitjI/O+1lNqwmDfwl9YFXZ4Fo86iiIksafQGeixEJPI3+wCYVRySv2
 MoNQipcDq+e5qSu/cjpAQgZ/xpSiYaqJHSOV8dvnY0N6fd0KwScumMCub7RwiWN0nZR43g2GSKv
 Yovc8yWTHPWru5g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add `hw_queue_count()` to query the number of hardware queues and
`data()` to borrow the private tag set data associated with a `TagSet`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/tag_set.rs | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index e62dfd267fd9..858c1b952b00 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -4,8 +4,6 @@
 //!
 //! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
 
-use core::pin::Pin;
-
 use crate::{
     alloc::NumaNode,
     bindings,
@@ -26,7 +24,8 @@
 };
 use core::{
     convert::TryInto,
-    marker::PhantomData, //
+    marker::PhantomData,
+    pin::Pin, //
 };
 use pin_init::{
     pin_data,
@@ -164,6 +163,22 @@ pub fn update_maps(self: Pin<&mut Self>, mut cb: impl FnMut(QueueMap)) -> Result
 
         Ok(())
     }
+
+    /// Return the number of hardware queues for this tag set.
+    pub fn hw_queue_count(&self) -> u32 {
+        // SAFETY: By type invariant, `self.inner` is valid.
+        unsafe { (*self.inner.get()).nr_hw_queues }
+    }
+
+    /// Borrow the [`T::TagSetData`] associated with this tag set.
+    pub fn data(&self) -> <T::TagSetData as ForeignOwnable>::Borrowed<'_> {
+        // SAFETY: By type invariant, `self.inner` is valid.
+        let ptr = unsafe { (*self.inner.get()).driver_data };
+
+        // SAFETY: `ptr` was created by `into_foreign` during initialization and the target is not
+        // converted back with `from_foreign` while `&self` is live.
+        unsafe { T::TagSetData::borrow(ptr) }
+    }
 }
 
 #[pinned_drop]

-- 
2.51.2


