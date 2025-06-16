Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB32DBF45;
	Mon, 16 Jun 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080359; cv=none; b=B7WKYT1Cg7RA3LvGvjgc40HGoNIOPrIWogNBXOJJIjamHs8G0VAZzstaXk3N/ttiBx5e6UfsN2U2zjL+jL90Q6Ila7GThQotz1PVAD44cj8JwyUvVO2k4rKq1wUiSn7nThCvEzGBAPQTDDU/UoJVTQ70E/mdMnlKxlsF9WxMgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080359; c=relaxed/simple;
	bh=kK2Vz4P5l+EAGPswcRexlePDdTbNhMuqAdi5ThpTaQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grxqcZZioPGq5QYjrN7MI4AYwhCQUtjIp7uJHlV+hMv/DlmXphyFwquhQmSqqhGbZiattZBHJYlYgePmAeMo0IEXQ7frQtf2z4q4endrJsYjA2417gAuNOZffNcwbLnsAG5+pKtxKdRDaEnc7OK/1s6OrU0db+Wl9vCjTSU29OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMw/dSYw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMw/dSYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E44C4CEEA;
	Mon, 16 Jun 2025 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750080358;
	bh=kK2Vz4P5l+EAGPswcRexlePDdTbNhMuqAdi5ThpTaQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MMw/dSYwphEO2gU5X3BpmelGP1uamo1SIeM+qt+L8emZ1io6KHRKsD0rP/ej5ony6
	 reXqWJnNMrpqOxYZXxuAT8tCT0oq4naDWLcDaDYgcKxfe1cwVy0d8tsUdSx/VdZUfv
	 qopXW+Z/U3u+g8hrBIu6G3VBevu+R8Ia9Q+mwwzoKUns+v+URq8XJlPxFdxw4s6o56
	 szhqV+WW39cjWRcHsDBgn+DcOHmpw86GjOva9Dr05cd71HKfBSArmH4bUZPjveUWD3
	 sU7fIlG+HBCnsp1Q+LbCQVNQiAg/5EURgarSMFtovcaPSHOYC7zX+qrBeW5zshA7hm
	 QdS4+08nqq2LA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Jun 2025 15:23:51 +0200
Subject: [PATCH 1/9] rust: block: remove trait bound from `mq::Request`
 definition
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rnull-up-v6-16-v1-1-a4168b8e76b2@kernel.org>
References: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
In-Reply-To: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=kK2Vz4P5l+EAGPswcRexlePDdTbNhMuqAdi5ThpTaQI=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoUBsKzk0UeqCgYRE3RGq6EsAzP7CLTqhCaQ8nP
 aHIyYFu/U2JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaFAbCgAKCRDhuBo+eShj
 d/9OD/0ehczKDfXNxl50GSB+zKd5SB9+uUN/lpE30CxCfq0uwOX6LiiIfLiJ1f4H7rq14NSwzhC
 LEv5QXzjFcFHPDTZGhoQOnB4N5u9mH2tpj+++AK4v9HQHFLyG7mzz7c/W4mUNq/7lz5UaL0MZWy
 Iy4IPizWNnRAIilqch3z2ZX4u0y69WzO/ej+KCnv5wrOeqVex/waeqPOr7d2e74ZRBKciyUdqwk
 ONVPflnUZwQA7eYWNkAiiYdG87alZ7WnbTU+pRQb0F95xuoiL454otSjmqISGGkepgOzWgVcqEF
 nZAwdgybzzy0JPQg7brkOXZC6BcxTG8U3lckDJK7drAP+djBC1JvTkqQuSbTv6O+9JJ9bSbPjv6
 tPbswn0Ri02mu1o1u+ZeflkHB89guNKnb4mdqpx2hRqLIPNAwnj17eWfwpXeAotJ+e6kS7NbPWC
 buAE/hQ/IF2rle1aM+ldi2XMA5k+aYPsLJOeelp/eTUi/SN+2sni+rUkIR8u80+TjYl2VUB/duQ
 o3fxFjK5z/PVfvDkgErXAJ01ZyZk/RId/pLlZgBDCs3CnZyRS6wmMCsNio9sp0TaJbfYBEJGKrH
 5XQHPooEXX1ZyzYmkeHfQcY51PZnkmcr3f8wfjsYQyIeWH/YJJENH+PRAn6QpxwJtIcq4qocJy6
 COZG6ti+yB9IVWQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Remove the trait bound `T:Operations` from `mq::Request`. The bound is not
required, so remove it to reduce complexity.

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


