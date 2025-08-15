Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23272E92D7;
	Fri, 15 Aug 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243152; cv=none; b=oT5epJXS3FpO3RXUsRdL+/JAYvPZbZnoWzbnx4/16rRzBEGwAniw1Ryj+UXHkaFANp3ffXaN2LaDNB3LbDLYEPTBKku7114yEJP4Az02395typgeZN9WAljR3gtBGYr3pG3k1JS4U6wdCLz8BEfG1+WkJd0VnkH/PPrllKvLVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243152; c=relaxed/simple;
	bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuBsVO6G0HXCyk5PmsU7lLq2Nh4uQZ36RXAxq0TSGxj8zJsrcO2S6U3WwcCANtzJbAj8GypHFgVkhY3kV0jIArz+dmr7ItjaZLfqQbipMqKMLsNvpSvz6Q/zFvjmi1tHK06jQb4LYNZ/JZC7KR6rXNiSWbizyGB64wkNQaOCNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjENElwt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjENElwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC03AC4CEEB;
	Fri, 15 Aug 2025 07:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243151;
	bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gjENElwtmJDtxbTFqY/YSgIyam/48XuoCV9bTeW36l4zDHW+EYUGFNKpNPHLbPeCw
	 Cey4rIdvGy3+5BwzwTCIvsxcJOduJExGcCEtoZqHgORrpSoA7NWTNdh/1UkTlbqFJN
	 mqAdDqBYjoLTKsMv4xDnJFmCGdQoPX8cDjc2WPLc/OBCqO4omOJsgjRn7+v1BKavhy
	 FkaXNdIdBePWVI6BKOgCYGsUtHcFR/wW7UsaYP24Tku2VBsIPhuNsNCnWHb3BGCyBk
	 sjSvDAg+tBUZJCWVMKYj/51M524pHaHyYjc1uqXmkHMOH0BMl4L3t55rEj7I1BFoYv
	 sKzzY1VrwhjFg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:46 +0200
Subject: [PATCH v5 11/18] rust: block: remove trait bound from
 `mq::Request` definition
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-11-581453124c15@kernel.org>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
In-Reply-To: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI9pjtmLRwmoX/9a7niCXIWqdqwqVeO2nSf1
 hcJhyJmO5+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iPQAKCRDhuBo+eShj
 d/fFEACUwhkVewPjgePT9oEM5w6sLKE+pctmwFWP7VEg1Hmk8Qm7D1d1A0uf+6NlKq1aHayNcYr
 htpmuRZPasMpAgRXqGKEPoLSx6/R3ep2n0STDv4OmDpfpNn9fuf4Rtt11ZmG17ExsMIjErwqUJj
 omd9BPEm+tgMBm2Veq9R4fM3wtv9PHmOmJKIydmnVr6gvEakRdykSzdbt7taQSt8zYX1Pk1dpk5
 frpDDZavn6gEtdzYC0GI23Zp4L5fWfutat1tXrMAjJ+9Sm7PQOH4TKfpVjrsFQBzdqGlXBLbQKg
 bOLjkFQcqj46b0HQW/TEYW98eFaZakYcUjMTOmL5wuaY8+36s9B/zjqpnupPTF3Y6q/VAxYgrNp
 UJ3v/lFk2cay5Ms2WhBudOP2511Aq/qnIGk/URK/kFPQS4b7KznVWbUp3qvsLOtDA1gatuZDCXp
 Tak1lrkAmjYN2uyMDIEneHg70P+fr7hF0PvpQGJubIDmQdIT0o9XWiXhpRW38fNcnyQziwHD2lj
 idaXRsOS25kWE+yV6JqI3dC8kheUsF/DfYXnbXIBVfNVmUYcLF1OYZR5+W9XJBDpy76J8BoRd4n
 s6abFa9Jxk1cECa6BL4WtRU/bBblg0pexk0rGO91Yl7RT18JrxNSSAh1stbNvZFL5FYWa3Cuy6b
 KO2YqJszJEhIv1w==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Remove the trait bound `T:Operations` from `mq::Request`. The bound is not
required, so remove it to reduce complexity.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index fefd394f064a..f723d74091c1 100644
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


