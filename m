Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E02E54A2;
	Sun, 15 Feb 2026 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198987; cv=none; b=RpSa/S+gjQqB72FYYLD1XXJnp2l06cE3Y06oGZVqBFSNjiaTTYpA3/6WHun+fp5IuPUowhAgZYY6pt/yvkmWicNa3mjeHRYoBppfNPHk5fsPRb2WFPxsPi+7pPyVcyu4v1SxrYzttrVWbWx8WI43MrK3SDu9wSfKr1vb+R4pOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198987; c=relaxed/simple;
	bh=g5LW6csT032CGxKoiloM9/8wSOoZndfzpAjeHZm9vX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLbXDXpebxUdrLrRfJYhuXGJNoiF8yzLBM9JCctObu/jI1LGHeTDRHP/jxsFulcZI6ZtSqQmHj66Os1+b5rRDpZfJaGkgCYQlhxbfOXDDOJJaBbg64t/w6diED9LqVp/Exa/vTiY9ZPExsnOk915sQSa6WSmS8+DlOyEsLoY/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx+uunxp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx+uunxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33F4C4CEF7;
	Sun, 15 Feb 2026 23:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198987;
	bh=g5LW6csT032CGxKoiloM9/8wSOoZndfzpAjeHZm9vX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zx+uunxpUs5Oi9tE3v9dXqBlUuE1QYCwU1Ow40WRmAr9MQdSYJi2MpEhhs8tBWGtn
	 0d9tK85IAOB7Z9s8gs1vLmIGSR+CYv8/a9Pk1VHTp7cMi0bUh3RMWHcBQotO6hQAd6
	 4uRQEt6aqwvrVy75EXGa7oFP6GerMYfBVcTi11Hi+/z21i+wa+vPFKTv+lcUGOs/6B
	 cHgO6GmWStx5QtAphWF8If9g6H4Fumk2nPf+Ldc3RNOE4mbLelFsIHimENQK9cud8A
	 Tc7dt885RbQ+bZaBmQpbnQbWMBlLung72sy8F9AIGqDzASp+MIuph1eS7toRFCc7PY
	 QdJM921qm4+eA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:58 +0100
Subject: [PATCH 71/79] block: rust: add `Request::requeue`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-71-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=g5LW6csT032CGxKoiloM9/8wSOoZndfzpAjeHZm9vX8=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhc/Y1g/b0vvwu95fBzmEX7w8cu76KNhIq5l
 I+j3m5oTruJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYXAAKCRDhuBo+eShj
 d8KzD/41eNC99szTK+r357aOuZhjbUWcBfaAU6NcRV3rPS7DxRpqHPHuQC4LrldgEw5s2KplPUc
 qpB/YUxQFdtmK5WjxqzYnASzOhghp33LoecJM4JfsPhkQBI5V+Y2xu2C5yOrDvmpBTsijhB+Yf4
 Dktc28xWY5XcaEIwAw+6UWicjNjUducMp3Pns+bIAQqxoYwRenWTqbL/CInb4Gelz7PQc5urccy
 jDx3Nx3DtaD0cIqKKECShxBdkVE0YLz5kFTv9wm8VO/NbjPckXRQmfQ8+eAOzJMuUx9/YsBffAy
 rSdbIo6bv7bO01LmxuKi5A7mffoN8lEbts4empUi+Om9PcAzyJEsk6t2d0s2d7SKHM2TvE/ETQR
 3jwSjztJ1uR0fOJXYKjciDBETZ1BlyZh1frvzBBQGsM2qHi/gvbr8LaDwL8bBubiEdi6VMiBG0+
 9hOX74LuVZ4xVRXfOpcW4MSyjwBgsW7dcae4G8nvUaTuSrKDX7rYWBIBSJOUqNBdvpfpbHyVdfB
 M53RHvcf005IKbfO7vK2jK2TAq+S+RMsOrTw2guXnvHfEEzluOMI6nR/m3jGSIli6UqcvfyHbaO
 0bkPx31tNWCf59AgggQ0EvIhW7bTah8omTgcUWAodMRNJvct07//69Rj2BPjGGD+jEAi5JlISb0
 l9TNEwJtVbfy1jg==
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
index e2fafe7737379..af10dcbd3ffd1 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -75,6 +75,18 @@ pub(crate) unsafe fn from_raw(ptr: *mut bindings::request) -> Owned<Self> {
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
 
 // SAFETY: The `release` implementation leaks the `IdleRequest`, which is a valid state for a

-- 
2.51.2


