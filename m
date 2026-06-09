Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A8411686;
	Tue,  9 Jun 2026 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032517; cv=none; b=FitTek9pjBFKhs94ajsn0cyXtQ9tJrruJGC92lYPyfhiaJfuzsgOqk4ekfffFg/5TWa7JYIbig/gS/dl3Cdjr3oEChJCN2ssK1a/bVRrsHu2wRtxpB62NjXv3yNOgZURLT0UUC0w3whe1L65uiADLYfXkuljRtceECQaGmA61X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032517; c=relaxed/simple;
	bh=xXqJf7F04NCf34hZ6dXAld8MDblLWnRBzQzNDZIowmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KT/3mdRCGPspMIDzoZ74YvuttzYTmUZsdWErKl8We/BWZHHM8jHEIz/02XY/d+Tzth4+/ifO2vYPPxnsIY1x/FPgSOnxrKT4a8XVyuTxKkIpV0gl6VVIPLLLyVxw6g7LG5HVsLw9SR/R6Slgvqu+Mm4LzaMLD+CnEVSD4VomzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggWIxrcj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggWIxrcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89F21F00899;
	Tue,  9 Jun 2026 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032516;
	bh=zKR6MXUHWDbRDFl3ImkDVNtbroS5Q/HyfNFCf+FwxNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ggWIxrcjs4A43SLr4s3hdHt917/ecfOv5m8cp9wSvjzF3JoBFOTJjldDMjroXwZ3i
	 bcahTsZaHnpTB4FjNrTNOcxc4P3jrUQOT3nBLICKS25EdvNdDsPaV0Ny0LfZ9RTPKI
	 WuRlLJ8Jr0lhaJBGabII72L6YC/k6hmX8MmumqGxjgPCqpAqK6EjcRSn3x3Dzy4EMs
	 Z42iSrbZQqAaJqJ/mvHM7BAoBKnkpOVW++PQ2L6tJfTFud3OTOtQr21jP6mASeFpk4
	 vqmPlRCGToJQSUCQoDS502fwI7NztczrgB3wvuHanA1ppG3ZvmLj5XxVShp1riWTWe
	 bqOizZ2xFh9bw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:19 +0200
Subject: [PATCH v2 40/83] block: rust: add a method to get the request
 queue for a request
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-40-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=xXqJf7F04NCf34hZ6dXAld8MDblLWnRBzQzNDZIowmk=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTYKpj79Bj8kwYs3EbPRsKivGoKybBXNZCRR
 xXW9AqPvSSJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk2AAKCRD6UCkIqsW9
 0OcBEACoS6o6SVWxtT7ZyVgvB7JIj4BBlPg28VWTaXBFnfHlyKAgn1i0oqQ16TElCSKGc+Puqpc
 NnZdm712Ow2whWUmmGO5Nw2NeFcpJtejoAzJYqy8igr4mIL+wHmRtVYyLmCmUralCpN5yPb9XF9
 KmqkynCMpexMbGVmDRglQzv/9Q/d80FO7N6TlYcds68fLYxUSF0zOHR/KrH1rybJTcOtsTIQwmt
 QEMhL1nZEWdBxGK/xsG8RAfHSDqgdlvlgwZvGQLi+X6BjWYsuMbezvOeLw/jNB8sccYddF4o61Z
 zol2JdhWi4f0QD36nLqujap2uKiK0P4CjTU8U4EgxbyS7TJ8Kkflbg1RI3UbP3xO/VHYNuJq5gk
 ry3kS9L3CuhrYH3vBH9qznVjsvZfL7C9k+WuqF/TIpMKuAGltj1wz6BHXpMIp0W30phm+0yFYyT
 j7NfXKf0V0X7a/TiGXhM+HMCgj2kvSWeuFgqpzCvncumdPgNhatqZXURov/OWOx80hbVw6nnxVO
 QawPayOekOTnzzMDbIknfPLXOTuw4zvoHkgSvWpaVpotOSNV2bgUxv/QbO7+c5OkMZV1oXuHrMa
 Z+a8e5+mEofXCEblsREqhZ0nbAKv7U3y8IK8rsVVchi4UHWqvuov2dTiYVJYjd7oZQZE8BvveCJ
 MTSOmiL8Nhitrgg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to `Request` for obtaining the associated `RequestQueue`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index f94e9c2181d0..a05df2351c2c 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -39,6 +39,7 @@
     ptr::NonNull, //
 };
 
+use super::RequestQueue;
 use crate::block::bio::{
     Bio,
     BioIterator, //
@@ -140,6 +141,12 @@ pub fn queue_data(&self) -> <T::QueueData as ForeignOwnable>::Borrowed<'_> {
         // SAFETY: By type invariants of `Request`, `self.0` is a valid request.
         unsafe { T::QueueData::borrow((*(*self.0.get()).q).queuedata) }
     }
+
+    /// Get the request queue associated with this request.
+    pub fn queue(&self) -> &RequestQueue<T> {
+        // SAFETY: By type invariant, self.0 is guaranteed to be valid.
+        unsafe { RequestQueue::from_raw((*self.0.get()).q) }
+    }
 }
 
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.

-- 
2.51.2


