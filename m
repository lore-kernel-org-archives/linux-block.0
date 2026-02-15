Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419A2E54BD;
	Sun, 15 Feb 2026 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199206; cv=none; b=G12GQkqi9Qo/ip5Jrtl1IdHrpKIrIivzkwsjcBUbMptMN70pSNhuu07lRW0WwMhX4xE1iRpMBVCRYj+cXjQ4liuHzoENjgF3FkdkQ0o6h/hevWPs1Vo6oZdyxIHk75zgUfozMu7kL3Ec3RmeDO56WbH2ntneRVXTHXX8U3WVqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199206; c=relaxed/simple;
	bh=eohGXCOnx46jHczP9dAsSKL7WJgwmz4UPPhsJskp2tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1Ki8uS56dIxe6AXibocalg9EXpkhTwv+75/trR94CFnCoxAi8y9bZF9e0ADB86wzS/M64JrEW8MYTuZfKYKyG0YohPE/gkeIDXnWQkjKrnkOAbloOR3+LPDxXhkirj4HLd8U3J3nwB3UlEOHqKumQy2X85fDFGWLa8BkA6YhRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xex8n73Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xex8n73Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDD6C4CEF7;
	Sun, 15 Feb 2026 23:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199206;
	bh=eohGXCOnx46jHczP9dAsSKL7WJgwmz4UPPhsJskp2tU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xex8n73Q8oXjVBQEhoMXO54rl2DX5CR0ALwLFLO6wSWHw9oa+AJtEpumCla9vvHTS
	 cWky+W7GKoCkzcPnxUSUx4Ph6ZGIkmwxIFgqKANolRlRT1Luv49qRTNEXJFWCugtOx
	 keUg99C7sSNkqH+E1HYB79RPxj8RLs8d6IMV9N2BZXfDeUfnpT7tdr/paRgsYBalj1
	 VSEpSe67DAfItIHRJ0bDN6XoapdfEFibjCXHABNZ51/isypweM5hOwH7LI6ukQ7uHo
	 Qj8l4UB0Wzv/l3+Kf5KEwd2inblhNXXpbr/rSD+NcdSV7QxIzPXz8SgjjWI24xaZ9a
	 KHZjk743vIghw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:23 +0100
Subject: [PATCH 36/79] block: rust: add a method to get the request queue
 for a request
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-36-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=eohGXCOnx46jHczP9dAsSKL7WJgwmz4UPPhsJskp2tU=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg8dg/PhpsHgOFH3l0YMtC6LWUuqH43wi3Py
 0nPnS34BySJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYPAAKCRDhuBo+eShj
 dznwD/sHTnyIp1mixWF4FtiLgwKs1LYUBAJTXKWLW8mnumj2jqbZtIVbjsea2ML8uKpUJ7IbxR5
 uEhUV922BCO+J72fsH3SuhWkOsqk7VKvKO2jVlo6XgaDr4KPKkcyCoGMeGxGyRFc5NK0qBqXXNd
 r++7HEvsG9RWayIwg911zold+v7hJBwXp+zxaYqKMHUlsrTCG3pwZdRNfgESwjZQbVq3quEBgNs
 WNNnnNoqv9hIxgKG2wcF9Lx/6/OPIGG+hF/4r+jxNsLsmKbKPG/42YG9zKrPx0keXI+AGmLiDSi
 o7rJSCdbQ8ClM99EgGiiqWzejr8vW2ZIV8qTUh2n7s59hSDakHsS//EgSvfHLVgD7XV2FIZTCJR
 T7Kb9R+QxyWFoOV2QqEHmSnVcDN4sdlYIqIhl1ETDh8smFzqiw59dOs/tqTK/4LmEqSl6lN/Jr6
 S5spzhexPyf9jct1+zxmYdbtTRmAulBiSLhKSe5HpZMwIJgF81wApWjWisB/bSfZkzuWQ11QDSp
 myA+I+Uh8wnqQ7M/upI1KePq77rKS1xhYGcjus40ZpPcSl6C/o2V4Cn7UIrprwoQ1XuCf/8beoY
 kexMxbatftJ8+d9HSAo6zePfqczhqFkQxRC91+69ObBzho5w91lgQaMh1TMPt5TgBPYqxee1Gc0
 XbSMW0Ka3eI9ldA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to `Request` for obtaining the associated `RequestQueue`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index f6addd20624a9..d6f3ffde1c5c4 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -19,6 +19,7 @@
 };
 use core::{ffi::c_void, marker::PhantomData, ops::Deref, ptr::NonNull};
 
+use super::RequestQueue;
 use crate::block::bio::Bio;
 use crate::block::bio::BioIterator;
 
@@ -118,6 +119,12 @@ pub fn queue_data(&self) -> <T::QueueData as ForeignOwnable>::Borrowed<'_> {
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


