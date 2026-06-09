Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8248B389;
	Tue,  9 Jun 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032224; cv=none; b=WpmR6ReC7s2RD2UK2UKmR43DFqxZzNFAZ8yhe/LkRlCt2SoxDSG6Qep4Fht5kKTOHufblW7K8rMkJd0AhA/EGiWrT69Fu2Pih3mIIZH8ag4IUCaZ/p2Luoaodv9/mSgix2+k9j1xab5vnkMgTpMBRUGIlT2sOyCUmyaMm256gFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032224; c=relaxed/simple;
	bh=QdUIpX955IjWtpvoketZafjzxxc6bEWigg7uBvUHVaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lg/3wQiAhQ1dmQtKj4+K9YsSXYWqCxByttnNs4gfhlOt2gUNYzrHDJy+uT8jVmfcqAoslO0PNzxgya8ZDitzy9gLHNGnQ7ikPa1Jed2Y+dqX+cmdVY37qhygtoruMq88NoVQsu98GENKy6glvwdJ7vwie1S5lRwacFJZNY7Y9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4EdEHZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4EdEHZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C511F00893;
	Tue,  9 Jun 2026 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032222;
	bh=iHY5maGdy9Y0fuMpxRd+GJYueXrmulzdgPUuxeFdpc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I4EdEHZ+4mOmI52HAVmdSd2wciDtFR0/Q+5iTwm0ly5YvhTwazYPxYmIXCZDfXVgG
	 /yWbJXOrQ8VVEfrF56ldHexNv1vKEoGR/BDVNXFAoRcdUFs0hIg33NJWhSorfpLJhj
	 KiHE791tF/dKvrwu49a0YvcEPMDV0g1LLZ69Rgy4nxvZzFtmKsH/BG/5DxmOk8zyjL
	 YtlEV63v70Nv13rR2eBVB5qP8EKyqc9II4cD/gxONQFburypTp7oMl+KJx/nBgyLoP
	 Gcpx/6A/AnoCjUyYM4QxsG50NUdBe46PL8in5Olq8ABlsP/rKX+6L//CUhJwFeu0rI
	 k4QpjPTh30YVg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:22 +0200
Subject: [PATCH v2 43/83] block: rust: add `GenDisk::queue_data`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-43-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=QdUIpX955IjWtpvoketZafjzxxc6bEWigg7uBvUHVaM=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTbpS7sC8gUW2Adx4HtZ/fpiNOjSfvNGjo6B
 NBvkfxPGy6JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk2wAKCRD6UCkIqsW9
 0GkKD/4jKQPzH7UvTzlymlTkzO6nFr0uD+r+lxJMwBCVa3UJ7O/Hiw74mJ5raWq/ELYiqGwZ17q
 BK1XKroXvE7lo3/W2fjw41bqrmg1v56WWQQfNlCe/w5rXtisEs7WSUsxgwCTsH8MlMbBxAYiVZG
 BIgAp9fMcFefidQZ1rioOGGQK7fWOKhtfN5V26APj4FSH2klG8pNPYv8Qwnn1QRljsT6htLvVtA
 8agBETAJEBn2/gcReU6RDaUgyv5WTdYOjApi8mzoW0qVVEbCIpAAAAbKOQS2rWMdXdg9kq5mYnG
 Tw2PhohLdqYMM8qX1sSrGUawgIxfRckb+2DrR21SUtQ1lCAu64PxoOsK1xd79HwdUVxCeO4FJcv
 uby53gHiQsCDK5U8guolyHcVWzSBlfgq21+1KxTxw+IlDlBA3knAIa5qrr9P3+5XI6mugMLJtyX
 qtx1NZcFEUEgzSOv8x8/9oKtpIIaV5eiaMsrd2jP9evv3IeFMKt6Tfd9297ONwbX8A6l5J+WgHB
 FDG2ITMtxPEO99CIBhv3hFdzJeDlUZfp8VC5npQDoZrc4UyRyEVrzgE/1AWgs+JCqqZw2PPQdgO
 6KXUT/c+OsYDx+LwGjkGzaUQk9zkDIJyJQMTzczdk2TAJAZyLPhBaQec/R0MrXSL/IxGvyOBlzr
 Le8kjM8gfkCjTvQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to borrow the private queue data of the queue a `GenDisk` is
associated with.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 6ba8d88f63a9..49ce5ac4774d 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -260,6 +260,12 @@ pub fn queue(&self) -> &RequestQueue<T> {
         // SAFETY: By type invariant, self is a valid gendisk.
         unsafe { RequestQueue::from_raw((*self.gendisk).queue) }
     }
+
+    /// Get the queue data associated with this [`GenDisk`].
+    pub fn queue_data(&self) -> <T::QueueData as ForeignOwnable>::Borrowed<'_> {
+        // SAFETY: By type invariant, self is a valid gendisk.
+        unsafe { T::QueueData::borrow((*(*self.gendisk).queue).queuedata) }
+    }
 }
 
 // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a

-- 
2.51.2


