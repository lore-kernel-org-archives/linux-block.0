Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D884BCAA2;
	Tue,  9 Jun 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032241; cv=none; b=PXpHLZE1kI756FS1oWWlEra3j/bxLkHJYHJCrzHyYu23O9Q4NE26mHbQwamEtjO0NN/EBOoSIyqNHeqk4BoInDW51ePvTZhubZ7c6eTB639rlzVyUhDUqgv6xKO3O6dlFu6tCMAaH2nTav6f2frvDsoMJWPXbP9nzPd/sCDCEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032241; c=relaxed/simple;
	bh=s+4gufW3UhlqKWqsXkBFJk+U/u784ZMLj0EBgYGeaY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i3zditjiS/SFKgUFEUgkkGJHHlg7wZCP9HK2dqxfe3oIf/0KipJYrlzwRtB3foC/AdUQGxNOKwvAxsYHlLpF60vgai90JtjtG80wF6tb3nMj4lkv+LXGxJg+nI1UQkW6yBo81eFVp62Zz3WHHUb1iLEQ3kOwMf11EuNQxFo7YS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm1doXFR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm1doXFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B451F00898;
	Tue,  9 Jun 2026 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032240;
	bh=/7g3lYXs2grCtTPuxxxiBCjUGdtPSieCEyjdPX9TpUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lm1doXFR+4S/8kmMih5UCQi0ymkFJpYbFdiQ4qX5gYG0t+4lOjfYlBb4TgoD2nRjO
	 GTwRJXGjsTwXU8o4zK2wI28qJksbQVaW05XjXPDEktcjkR3z30IYnbVFTM1/oKOv8t
	 MnI+RmR2Q7V1c7JbjKAL6d1u19hu9S4WiPdhxfg2ry+sJikFqEW49XDa3wL4muXkah
	 vpX8HfJYx81CFuVlZkVNJ+NESf/fTdhMXi+W1NuIbUufSA6BNZmazZbjVhnsr+h+ar
	 e8p/gcX28taHZSurKCisc2oDXGkk1gRO/bxsoUYZHTDxiJ89WUbomMm2zJ5ND9cijY
	 U3nyLU577Amtw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:53 +0200
Subject: [PATCH v2 14/83] block: rust: mq: use GFP_KERNEL from prelude
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-14-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=s+4gufW3UhlqKWqsXkBFJk+U/u784ZMLj0EBgYGeaY4=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTBPbl9h3oqRHD3qmw+YLlvzYSsXXClOB/ws
 R1mq9pxblqJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkwQAKCRD6UCkIqsW9
 0KnlEACzvlyksB6u2aU1pLlwZ/fl8WaqAxGeKb94S1jgEr3YgSy44Du05LDxbJTqrljEY9Nw89z
 JfCzmr9MkUKrJFoBp6X6gVMw1lICFvyQw1eStDW86Z4pEJAeqQlqegnCf3bmCxi4Oi2ePveenVd
 QYmQ3M2//o3r3izL8vSGEMrcxWTWDaQyLy77WjI8ThjP10CwsrUb7wPwQi6Mrai76pZZoZP3d1f
 Gk4ghY/2l162hUvogAKsQboBvTdP0vMvdN0Qdlx2mACa7Z1EBwxIGT0WOVChatkbRrXPCVL0+f1
 UGRNkA4J0iLTdZ1HRQGsmbDzSDs4F/+nOMCJjO017Hi2dM94inwsm/eXoEJtryuLj7JC2fbQHgF
 ma50rc5KnKtYYuA4x/dNRz4OCwWjqok9TBht6fYIuhCXT11ZCmdUiZO2VqIqN/0WBRc6bhSNnjG
 sduuyzMviPUz7oITP214t2u25YFK3sAXB4X5y9BT9v5C1YfHc57kfpNJ13ALLgvhIQ7pWgDVWLp
 huVyio+8RPWJvvNe03euJ2nD5PCi14wActvblauFVVBb7Bor5eGmz8Sp/zAzT8RXQwQ/E7AzIPd
 24Ip+kB0VvL/Uy2Q6OsuQ+b1VHbSblRGX8KbOyXakb/krEyDBw65i0uFYG9WioBneDLlANLenZm
 rdFLIcZjtTAwNwA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Remove the explicit import of kernel::alloc::flags and use GFP_KERNEL
directly from the prelude in the module documentation example.

This simplifies the import list and follows the pattern of using
commonly used constants from the prelude.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index a03d46d274a5..23660817df29 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -57,7 +57,6 @@
 //!
 //! ```rust
 //! use kernel::{
-//!     alloc::flags,
 //!     block::mq::*,
 //!     new_mutex,
 //!     prelude::*,
@@ -93,7 +92,7 @@
 //! }
 //!
 //! let tagset: Arc<TagSet<MyBlkDevice>> =
-//!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
+//!     Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
 //!     .build(fmt!("myblk"), tagset, ())?;

-- 
2.51.2


