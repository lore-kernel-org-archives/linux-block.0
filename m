Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A5A4DB563;
	Tue,  9 Jun 2026 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032310; cv=none; b=eDurSOFJFw0iOPjd9M5EOnErP361LpVKNiKhOq79Ks/3Zi3lmuy8haZ0oWeSSSSU8b+SZ+4SRhirptLfIB+Y+DsFT2IVp3nMyiPTNUPpUIY7ED92+o9daHD9NitJse3uHSlazzF9+KG7MLuT1IAgAif4dQ5oq0mhny/7JED4lr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032310; c=relaxed/simple;
	bh=7twqnJezwG7YFrJ5o1U16sXUnbxUjCBfg374lo5njEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rUKEb9ffCvDLnupbdJOjEKddo+y6gGd7kxJwY6uCCYuWdCy+7rg3RN7u/GTh4sxnIHuJ1uPn7izKChUAGWU48PyvslzIZuuPWLyc3vKs0SLHepdZd6p4xwSyMdW/mch89TZdw/qc9kiV6toB3U8reD1dcGJcCXMMk8DkZCAAAVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyL0vqob; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyL0vqob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BAF1F00898;
	Tue,  9 Jun 2026 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032307;
	bh=v4Z8AHRxPgKpZNYlJlm3R0WTIJzVY9sjt95caEWA3FU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FyL0vqobNgq2bJN3QVgiuWZUEWwnm69ZsAY5sgnbeMg4yqz+QOfCMS+26Svt+DOpq
	 Cz3uYdyQ8aG1yRMMpq6b/gMhMLkX9LIgeIXYkv9s2y0WxY5dPPKTDvbldzIKegimJ0
	 9aVRSnJM3R2DAZUsUXxX8o+y7dZ47IEIVzbiDSB0GIcIn7THLwe+LVLojJJg3BqONc
	 BhShP9FKlzUrT+jbgTYNIlWeGZafiIRtdR+RuJn3JCP1iw/9kqMFnLxOuxOR+55ipu
	 wfHxFLfyiDEizPOJqe/qTl3/uMDVaEkjzlSSa8Ijzf9PLHvVHCtJassHUiUktCISQY
	 KBMl9pVHvvpGA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:41 +0200
Subject: [PATCH v2 02/83] rust: block: rename `SECTOR_MASK` to
 `PAGE_SECTOR_MASK`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-2-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=7twqnJezwG7YFrJ5o1U16sXUnbxUjCBfg374lo5njEE=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGS2jkBlMXprmSKrEyFaF9EB3OxN7q7deJAwW
 z8X8xGygpOJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihktgAKCRD6UCkIqsW9
 0KohEAC0G5926iVZdDlAI/QAadxwjGDcLBe6MxfhB04nVnEWPurh4URtNIDfql0VvjgnK5GoOGI
 vUvYMWMait7VM/0VSbi5NUNtEktgdyfc01g9BNEEmEjc8fXmQKhaD88Gy/qmNvpga+KEu53mQQ8
 AnAGw3F+t55amoJeOaRirIwlRzmj6VY42w+7Msrcs1/AEWaRsOnA9UcO2SzlgswDxWRFdN2LGUq
 N675ReEzy0SX3LF5dTJEdOqdkT4mNbWuSS9X1JhjxwDjVN825N8NL75u2K2yZxETb8d+qs7qAIF
 CkycmdpYuK8Lpbx0cnoryLdKVVGWfVhRvxBXHJLJWTUIf7NAeKkBxTaOABSkoqwDJAyY0S8iTaz
 hShmSJlT5PlhDfp1CJSA2rZyHgE6Ij2n6EhewL22FU91gvQp+PZauBRRg0xXX+X3ZQ86WQRUCc8
 GcDnCpI2BP0fdkLsXuXFO5Qp+yfDmiGTPvh3IKul0AB9EUEOMOfXq/4hf6E8MBacORz2XNjCsl+
 wZj1sd7CA4P2Su0LqkYz0/8f5E7LYbxXLKfSyp2fGuGZGXzZZTGVd67X8iQVs9SknplyNNkj+iQ
 Tngch73oPcV4Varpq9ZaCgtSYfO1NX7Os7BBsOm+s3/JoCT7WKdATreu537hhNSwTcQv43zxAJw
 8nxoutHdmOPcWEA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The constant exposes `bindings::SECTOR_MASK`, which masks the sector
index within a page (`PAGE_SIZE / SECTOR_SIZE - 1`), not `SECTOR_SIZE`
itself as the original docstring suggested. The misleading name made
it easy for callers to reach for it when they wanted a byte-level
sector mask.

Rename the Rust constant to `PAGE_SECTOR_MASK` and fix the docstring.
The C binding is unchanged.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index 32c8d865afb6..b120e83d9425 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -4,8 +4,8 @@
 
 pub mod mq;
 
-/// Bit mask for masking out [`SECTOR_SIZE`].
-pub const SECTOR_MASK: u32 = bindings::SECTOR_MASK;
+/// Bit mask for masking out the sector index in a page.
+pub const PAGE_SECTOR_MASK: u32 = bindings::SECTOR_MASK;
 
 /// Sectors are size `1 << SECTOR_SHIFT`.
 pub const SECTOR_SHIFT: u32 = bindings::SECTOR_SHIFT;

-- 
2.51.2


