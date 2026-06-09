Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCA4DBD8D;
	Tue,  9 Jun 2026 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032369; cv=none; b=lhQ3tOxmo9yupJxOngvLZtgoTbFb+z0WenAUvLNfBPvbZA/XkwoRxYBLPA+ZmtOi0FY7crY88Sjo3w8C+ebYa9AbnAITJ0csI85ElF6GB2dk/aPGKaBSm/TJI4vh7KEM5vhBpkQfotLdFGtgxgB3F0x3ZtLhpGwgxjHYlFjSAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032369; c=relaxed/simple;
	bh=scALI3Of9papCU7IjOqZJ1u1Kulf0qIwjxsjg5iYtNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYNWoKNehFVN7Hj+CyaPobjLqNbsr4QgxXa4SqzNiee2vMPYj6+VaMMmOOKrG+1OCzwE0Ad/aZIQbDePyzRbTGIf0yAh+CeKHyN7Z6jN7H3qEAKhJmh5W1LnF0xCcsm2jp6y+XjlNa/KVQCjG833V5HPLxP4NAdXuKrE8kqJh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV+8i+U4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV+8i+U4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE171F00893;
	Tue,  9 Jun 2026 19:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032368;
	bh=E4zTF3buoXlpdVNSPu+eDYHPwLwVvZ/+F/dMjwaTG3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cV+8i+U43n6XAVH0qKkpGqpEw8THPoG5GDx+77Vr2ca87tK5ut2BVqSJULdHo1hL2
	 p141gWkNxfeG+5Mp+0//5KGEv9Ew8Es2Wg2t0JcC0kWYLoBPXxGylq46Rbn++CsN2C
	 rxRVwg2gLrybVWOZzFw/p1pquEa8GbekwyeJNuK0ZRP/FSAmbjb+yCzjvUogsJBlQt
	 z8ObVLIcZlAamjFkoxSImz5RQ0HosmKZe56bJZwHqpKYXNk+zUVqyNknLi1wepHEnA
	 5nY9UbuI1j5int48wYdOuU0RwIBC1XMNTg7FIYdFlvDav+85pC0rfutBWdBWXAsGBz
	 eF1kGp0QexmlA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:54 +0200
Subject: [PATCH v2 75/83] block: rust: add `Request::requeue`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-75-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=scALI3Of9papCU7IjOqZJ1u1Kulf0qIwjxsjg5iYtNw=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGT47losJJyzKx25dxqwhmsAjiaceinSmISuB
 74LtHjCMIuJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk+AAKCRD6UCkIqsW9
 0LVCD/0f5aMN4ivKJwIUmvoBpEA1oTSTTcWwTQ16DMSlB5Da4QnuLb8vhomM9pCloc5XmQfBJVe
 qfLrZ5PEe94IN8vCQ9jUEmNPGg8kZai0Z2UmGyu3saUkwWfk35EPalRebaU3bFakJe6Zux3Qn+C
 BCA1441jxGPWzc5hT1zAYwETUK1gDEEKvXgWWZYByEBtyvtkSwHkbMw9Abc21zj4l2Whif5mdt/
 p2E7/Ua4A4a8xt8TzoI6cUe0EtH4VjqAlhBpMl1OSy2GPdt4BKGdA74sZFsePhuN0+m36iX32Fr
 l9ulhIZ06xNRCWeDAZQuGVHa6IFUBTv+ttHLvkmOAygMpix6R6KEY1jCEij+OgWFeMuIQ3cLYiY
 Q1+XFRy6t5fRHV2U8l3jB8bwJ9e4oqpOGWtxMthi/JNx1k06WvYkvrZtgb815J39s/qrSB79ek0
 NdQxosr1F95TF2BCXp5PJ+6+r1rS3EWQXxkXrY0X4s5Ohqnb1+mP4veGTa3jC3Dwo1XEGnbdoKd
 yZBgHkUrRaDXNEalYdKUMv1k5ht0gKKOD2EDZxuSqjhtc4hkixpQ9DzFIFEL7GnPLf2zObrUTFt
 l/FDNHE0kaVd9ziq2D0/SxRMg19xpq/cFQjhPzccSgFYHbvH+z4wESovJwNK3B9azUnXASAq91T
 jXMzYewRKtk7MLw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method on `Request` to requeue the request with the block layer.
Drivers can use this method to send a request back to the block layer
without processing the request.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 54b5202567f8..bf6d58139ab4 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -100,6 +100,18 @@ pub(crate) unsafe fn from_raw(ptr: *mut bindings::request) -> Owned<Self> {
         // SAFETY: By function safety requirements, `ptr` is valid for use as an `IdleRequest`.
         unsafe { Owned::from_raw(NonNull::<Self>::new_unchecked(ptr.cast())) }
     }
+
+    /// Requeue this request at the block layer.
+    ///
+    /// If `kick_requeue_list` is true, this method will schedule processing of
+    /// the requeue list on a workqueue.
+    pub fn requeue(self: Owned<Self>, kick_requeue_list: bool) {
+        let ptr = self.0 .0.get();
+        core::mem::forget(self);
+
+        // SAFETY: By type invariant, the wrapped request is valid.
+        unsafe { bindings::blk_mq_requeue_request(ptr, kick_requeue_list) };
+    }
 }
 
 impl<T: Operations> Ownable for IdleRequest<T> {

-- 
2.51.2


