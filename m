Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2C30C616;
	Sun, 15 Feb 2026 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198968; cv=none; b=sQCgFkzExPopZClOh5bASTAASaKsWrno6qV2GfKBjSFOWt/x3NDG+KMBLWvqyljuWXUEYjY7b5Cmh0cIipj/4/2lMv1boaCJW5/d92Lzbi1XT9NTG8As7TuHnAWc4P2acQaQjq/1ZquvbmIQLXBozLgRYbvKeKXN/08H23fC8Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198968; c=relaxed/simple;
	bh=PclSPlh70GQI0xa5AdeesgMZY73x5FcK7yieZwHyBNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/j04Jlz4xeXPaqskGBN7liWyk47eECxYrWHf0l7CVq/JKc4F6nsCS7GVt8MUCjg7FKY4DbogwtZYRIt7CFlaDV0/z74yl+q5h9ovvQXl2Gv/rd8INEGnyRjQOrlExusqI0KiwLCkNaICqYS+D1ofS7H0K1OR603BUK6IJOly3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+DLwcOZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+DLwcOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1969AC4CEF7;
	Sun, 15 Feb 2026 23:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198968;
	bh=PclSPlh70GQI0xa5AdeesgMZY73x5FcK7yieZwHyBNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m+DLwcOZ7ztebda4HD5zmzGEd1dxKhN6VIv3Ey90e3U/WBlrx+pf3F2fWIFCLcI5T
	 hldQpB0o8zQTbtheSVXM9rCm2qhYMCI3ogaf2Vx6ppCCM1auAwzwFbNMXljA/fcjqa
	 r3eJu6VrhR+KV7HrXN+OL7YLt+3JPM9t2+oxfpN4jHjTi2uiB8X9ZxE6E8cQblVTds
	 g1AElKe+UUux/V322EArMeHghqO1p3enbonHlviYx7wy63c4QPvX/BYwiZ25ebUMo+
	 MEbYCOPXyn99/a/fSfZ576dim1A0Oi4TVU3bwG2sQVEg0dsIX2xi4bzSOKmEO3r2Fd
	 GxQsSfgDTR3Tw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:49 +0100
Subject: [PATCH 62/79] block: rust: add `TagSet::update_hw_queue_count`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-62-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=PclSPlh70GQI0xa5AdeesgMZY73x5FcK7yieZwHyBNg=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhTMo0te1+0hDGk5iS523JU63TJIgZV6pKQb
 P0p32p+ORCJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYUwAKCRDhuBo+eShj
 dz6IEACT5CHYFXwgGMGhVFOsIzIVze2XvGdf11AwPQLHKXovdeWBUGKebfuN/DcQ3OPK9AglXZ5
 tm5GgORCPdgssHdGNlfcsNRLHfn6Ln5QKM6AK4Sc7tkaVKu5LYGGWSHcn9GhvVnOx/lpaLszWlN
 6mCEKAauIk666pbJOzJ6mlmJSRl04x9sYQfvDzgb9w0tnIihphmkYYMZPWJA31UaUi7v8p4oyMX
 /pnpFmXu8UwgvIe33s3MB8zKNKeSgG6ZP5uMZV2Qi5iLXqy7Z6+fYFwzqkXLe7OF5ZeC/tTLO+f
 Xv0AepFCGgEPexiO1cb88/4C3m7gS41joiA8nVtFNYu6d1Su9ckl261r5kyHFZEEEk1jz7W5wa7
 YH06lBIytM3mPDDcO010YYmA18RhFXWNv28PxkWHDyobexbUnRr3cVtXGFzODBugO8q2viypqkW
 cQfJdKYov6juRy+vygspWrsJVhnHaixjGBHrbwA5CVXa5/EMgKj4MDMFibd4KPk8a6Q4b1i12ND
 La3cQNmfMFAkkWCbMNM2MOd/AuFcgm9CjR3R5NSjKsJ3VMBzsPUiECbEizBCbI8MxBGW5PEcj/n
 3bTLvOCGMKucYI/wM4mwXs2D18IMIJ+OhANs+L5A2aZ2HqmA9JcY9ST+ivVR1CR7odYpu55i7r/
 xvoD8xIrqD7yQng==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to `TagSet` that allows changing the number of hardware queues
dynamically.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/tag_set.rs | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index 4d00979a83dbd..47a162360e628 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -8,6 +8,7 @@
     bindings,
     block::mq::{operations::OperationsVTable, request::RequestDataWrapper, Operations},
     error::{self, Result},
+    prelude::*,
     try_pin_init,
     types::{ForeignOwnable, Opaque},
 };
@@ -34,7 +35,7 @@ pub struct TagSet<T: Operations> {
 }
 
 impl<T: Operations> TagSet<T> {
-    /// Try to create a new tag set
+    /// Try to create a new tag se }t
     pub fn new(
         nr_hw_queues: u32,
         tagset_data: T::TagSetData,
@@ -142,6 +143,20 @@ pub fn hw_queue_count(&self) -> u32 {
         unsafe { (*self.inner.get()).nr_hw_queues }
     }
 
+    /// Update the number of hardware queues for this tag set.
+    ///
+    /// This operation may fail if memory for tags cannot be allocated.
+    pub fn update_hw_queue_count(&self, nr_hw_queues: u32) -> Result {
+        // SAFETY: blk_mq_update_nr_hw_queues applies internal synchronization.
+        unsafe { bindings::blk_mq_update_nr_hw_queues(self.inner.get(), nr_hw_queues) }
+
+        if self.hw_queue_count() == nr_hw_queues {
+            Ok(())
+        } else {
+            Err(ENOMEM)
+        }
+    }
+
     /// Borrow the [`T::TagSetData`] associated with this tag set.
     pub fn data(&self) -> <T::TagSetData as ForeignOwnable>::Borrowed<'_> {
         // SAFETY: By type invariant, `self.inner` is valid.

-- 
2.51.2


