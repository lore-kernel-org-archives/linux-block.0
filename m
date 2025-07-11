Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4328C035;
	Fri, 11 Jul 2025 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234237; cv=none; b=DGyqijRAuYc1fICBBXLaN1tqrZJZsZlIUU4BNcTsF+76OVts96kuwLBTHmO1QO4OxczWUMc6d1NJqi+rEdFeLNBf4UaeuvoVGZA24LgAKcxuhioDGVOKBTPbMvETTShB0tJo2/0ZvKqaQ7/v2Pwnmz0QN5Byowt2lWb09DAAOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234237; c=relaxed/simple;
	bh=0EQMqwW4o3TiIuFA9NjfmF2wt3+kw0d4Rv4MVtzTMgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kvau66TlCfOwYDQQUoBKM5gGpnAm36Y+JMMvyeZ8fBC4anpVlDMMaz3n/qFq3Ezo6VR/cdjeJCgPwBuw/DpKaMadF0hE7hmlbuLNPtHlMa7s/Xl0fMwc9o7p6WNzJZ0uejTzwwdn35HDVrkASM9MeUw9a/rUkZksEvra+VMySpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPx1VSrL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPx1VSrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A94C4CEED;
	Fri, 11 Jul 2025 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234236;
	bh=0EQMqwW4o3TiIuFA9NjfmF2wt3+kw0d4Rv4MVtzTMgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uPx1VSrL1qUSMH2yx4i7iPhRQwN1dNmOKWFBkiOBiZWerIakMcdnhE+SI51tj5V4W
	 vcyq6W0jjrqC9/zDjhGmm2Uwxe2SQacFzPkPMA798y4jsbbdvj0nDB+WpfEk9m0b9M
	 MRtGpfcVHh1W+VxnhJd8RkOeAqgF8CFLs2/q0QzdYW+sjpZvtZgEbg//NOr2T9NWND
	 k3NP2ksNqk5tRGLsnOCjhG6Q542JRbj0WHCS5w3Be1wLa7RgXbSFdVIUxyP5Ww9bH1
	 dB/NgMbtwIiEYhfA9ea2mV75pVbYxADbOFynH9Mdp1RbXaFoPzsZEqlGytT3G/o7CS
	 JsOPd9dwdbUDQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:10 +0200
Subject: [PATCH v3 09/16] rust: block: remove trait bound from
 `mq::Request` definition
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-9-3a262b4e2921@kernel.org>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
In-Reply-To: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=0EQMqwW4o3TiIuFA9NjfmF2wt3+kw0d4Rv4MVtzTMgM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjSkIuSjcnlZY9GDxYXn2lSIO/Xb/XtfY6ig
 WyxQC2KJ22JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD40gAKCRDhuBo+eShj
 dyxRD/0Rjacli0N+bgNxxLgMjy2/7QOV6TIx+3QHQJ8hBtihGeZDtGxUmoo5Lad8rK04RPTE2Pb
 DlQru3haN/a4zWB7VAbr8xtr2e/vdEtcUPqqmziul1AWUF7eS4+DgUNttzdwi/sZoq4Sd+A3geM
 HhquptK+5o4x5AK8ImD8Ins8PKbjfneKLIDX4SU8ypdByk8D5bcK6IJx0Xef9pPUBwnHGJOYSs/
 rSl/qshZlJIxz9RWfYN9xaIKQK+PMJEKUUyrvSTQXCOXEGvUO04x2/WPobSbCD6sRjcSn9cPQLp
 4Uk+KT36C0lewZ/JWKJ1kN/YqE5TT2b+yE7pxlFyyck0q4gH+lLmzpqBkZmSYdH/BK8gW7XdxTN
 rTL/sB+CpE9tv21xRHUruQymO31JJia01UjyJjwOq1SpDsYfCLurHkLPng/SBzImX1QoeNkcTD8
 Vso/y/OiHNCReQ+j9yKx54hO7u0yeFw7C18QogQQDMZPnq0nEt57sTS7svJoTWkRaLw2TQ3o3HI
 8dhFtQwJKCtjdcUluF+DNEZZzI5UIOOmLhzmzRuYDXLWDOpP9rrzkbnPwz7aysfwaCL6AuJFVoj
 fK/+ZLZau2lRphmTkqizq7VHpBsSXUO3gIKKZ4YNr2YxlxWDZcCLrvFM/EmJdxMLFwDHMfa/M6A
 X4Sxy0IZpIr1bwQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Remove the trait bound `T:Operations` from `mq::Request`. The bound is not
required, so remove it to reduce complexity.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 4a5b7ec914ef..2d14a6261a31 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -53,7 +53,7 @@
 /// [`struct request`]: srctree/include/linux/blk-mq.h
 ///
 #[repr(transparent)]
-pub struct Request<T: Operations>(Opaque<bindings::request>, PhantomData<T>);
+pub struct Request<T>(Opaque<bindings::request>, PhantomData<T>);
 
 impl<T: Operations> Request<T> {
     /// Create an [`ARef<Request>`] from a [`struct request`] pointer.

-- 
2.47.2


