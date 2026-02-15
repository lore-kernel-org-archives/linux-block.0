Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A61BD035;
	Sun, 15 Feb 2026 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198884; cv=none; b=WMzWVKhgw6SfVQsdfjirN+GTFvZ6egrjxOIqSUBvyOZ+eeTq/20G4wqzrYu2X1IqN5Nov1SEZbP7G8wEW5NF/fhhqiP3rqwiW8eSJs8LDR3eXqwELisaaZEBIPWjYrOCThzwGdBhYYIH8neuXEFW6ux8MdKek/7nB8GU27qRk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198884; c=relaxed/simple;
	bh=t1ASQJfBzdDC92qEwscNrrmiCuGCWMUOPUsdRJYBsD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFFIx66uFERLj0gMwYyZ282HxH5903p+XwiXfxdAi5CdXNAIv2OKemU1D/OkU0U3o2ndbnyNJRGtErKuedsMCzCMWypGzE6fDB+xCcv0galmBHA4KhF2LNNaiEa3ff2oImtu6/X6x0sP8EGBv/9HkVwht2rjioEhJ4GxU7adg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5f/Fu5M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5f/Fu5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAC5C4AF09;
	Sun, 15 Feb 2026 23:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198884;
	bh=t1ASQJfBzdDC92qEwscNrrmiCuGCWMUOPUsdRJYBsD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O5f/Fu5Mr1MpI9+DceCrppsOt8psR2zmL7tDTzmcftdQ82droIygIw3qEVSdA89T6
	 8QowxFsoEi6dOmlL43k5mzgEmmd8Td6sTcsrQSVYH2C3uq0SaFssB7lba16WPzLF9R
	 pU07XUhSftlvfzcWiMqHD34xGm8E1vly+l9DpiO9bNtB0QaYbVYu/ErUJoFJWebREv
	 yWsDQs5J5qHu/Q1WWAvW/xa6tHisRCxr4G0slgal/K5pN5nj/al/DmcUeWPAo2zizH
	 dpiKXSVu7eN1l1MulH7Im2A30QmXaTcpa/lJZ0qJ70Kmj7IiVvy2QByMbp1eGyqkKt
	 6FyckWmhmb0Sg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:34:57 +0100
Subject: [PATCH 10/79] block: rust: add `command` getter to `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-10-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=t1ASQJfBzdDC92qEwscNrrmiCuGCWMUOPUsdRJYBsD8=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgkNOXP5tPUBMAf9BmZYuGDAbCtojzNtAios
 +8laK9Y39mJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYJAAKCRDhuBo+eShj
 d194D/4mIQB1EGLbNrOl+I/uS4wCtD6CzbRXmXcl5fFe92Xg2YsO6rekD3VJzEIABP7VCe7qKRP
 wyC9KwDV8OaosaLR2awz+ORVTzJXWo82qjUiMIyAjXz8esf4P9iapP4hVXk9vY34LNXQGC87V0H
 mDn2MaQcbXjd5riAooVucs9b2nJ9AFLI9Du4Mj1N23oKn8ghSYPkVz4/dibfpINwnuYqZimSlB/
 018p/1lX+xO/t1GESKTGSWUvBN+nImW651QYrVCOMXiKIQ7/I9SaMI08YLF3c92ex0FPsvRqUt7
 aHsYLVPCTduOZXdOG+MEmi45DjRUH+0NuHjRY8CtxLRWVc5AxGPVaJD1QZMfkegYDG4EgIqN1lH
 gd6HhCH64uOuuJnhY6tJpBZlVOiXP/wcUMu+Srf5DEqxl51YH5m33GeBoORPGQakjhCTge8iYlx
 WF1R5hKUTYs1gQ3NpNRFMrsBQBj0e+eu805gzj+ZUBPQUe+SZ/oxrA15hLHeOm6yngwleIe0y4F
 nl9AzTzV8Cw3cE6Ejx0m9WNZbxjxiCcKa5MaPzJchaymBQ4yvZS4fq8ylJ+YsRJPJcXoqorkiZv
 xpFAzJPcHId1f0zPP6AwbMCWXuX3APyh8UTjsuCWMsHNGWxIH9Zbqy4NvlWnTZXsFoAY4toT5JJ
 GfwScsfr1lGfJ8g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to extract the command operation code from a request. The
command is obtained by masking the lower bits of `cmd_flags` as defined by
`REQ_OP_BITS`. This allows Rust block drivers to determine the type of
operation being requested.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index b49197a0c66d7..0dd329ae93dfc 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -78,6 +78,12 @@ pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
         unsafe { ARef::from_raw(NonNull::new_unchecked(ptr.cast())) }
     }
 
+    /// Get the command identifier for the request
+    pub fn command(&self) -> u32 {
+        // SAFETY: By C API contract and type invariant, `cmd_flags` is valid for read
+        unsafe { (*self.0.get()).cmd_flags & ((1 << bindings::REQ_OP_BITS) - 1) }
+    }
+
     /// Complete the request by scheduling `Operations::complete` for
     /// execution.
     ///

-- 
2.51.2


