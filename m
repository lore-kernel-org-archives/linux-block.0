Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF82EB5DE;
	Mon, 16 Jun 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080374; cv=none; b=t1bUbmz3lAC4lJha9o9IBMm5V6ZlLWI73oqUhcIN0ngDPZLOfUJFmLAvMSHY0aUOn4REjWQViXn32CjFnxWHRUr2c4P6ip9LPQrHqcm4dPN0ds7vEVuOYxSVwXHIdNE7FOyegFEC2eKfqa94fJWUdJn+s8xQDBC32fHAmEhIV90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080374; c=relaxed/simple;
	bh=bwWpprsdtyVDZaqvZNUcUvzzn3+xorlxFgD0pWYxMCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EO7FIHeZ0oSditHQIPSYig7PMXLBwTgvqIcFI5Pf/fofGewtoFMfVs51aVIW8UQsA54KnCHIiSkmhqk1ix2e66jH3w9hT2pPh7rb2VBPFKR8kGdN0a+rFVkyLNijw2asrAn2qBovgZWXTOYlXJBLxrRnHi1Dclws2RHXCxepI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTTvqaIU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTTvqaIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C40C4CEEA;
	Mon, 16 Jun 2025 13:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750080374;
	bh=bwWpprsdtyVDZaqvZNUcUvzzn3+xorlxFgD0pWYxMCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pTTvqaIUEltj8qffyldX2659oMwz4aC/e+FAUrrGYXhQBu3W24cy3wWDEoxDrfygo
	 3S5ufwV1DfNPyHNQc72gVFPKPamrMvJyXUOMTdbk1KVE8BmMDzi68Jj9X10D+IFyqL
	 fGGcwRQ1xRrm4hGJ3osttgsXBN+haxVF52etF6MM2tdjj3VQIGEcphPXTwj/DuMFmn
	 F6YKaFgCMDyUd59y4xwzbtfjxJ89KYeWMuoqvoRAl409BxbWZe2pqCwH4rALqYziTw
	 Dz3Wt3SFwuQtC+Flc1CF8TXfMp3fkaPnyZDvg5trJJHLLGHP5ZO+Waw1LueBH3a04e
	 93al9WTGYTkIg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Jun 2025 15:23:57 +0200
Subject: [PATCH 7/9] rust: block: mq: fix spelling in a safety comment
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rnull-up-v6-16-v1-7-a4168b8e76b2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=bwWpprsdtyVDZaqvZNUcUvzzn3+xorlxFgD0pWYxMCs=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoUBsQXws+UPKZShYY9vASY1mUc3xhyzyNEbvbA
 T9OLCDLHn+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaFAbEAAKCRDhuBo+eShj
 d/PsD/0d7qzRrBSkG3peQMf4MxIYe3XYl0Dv7nzpFhDh8GR12/CmFro7MqYaya8J6iN8NNe2biO
 dK3Ol1oWWLo3vBtmd57yEB3KHPTaJ5Bk3ArENQm2qscBxWj8KP32v5cW2VnvkI8q6s2bAjEo0VR
 LsySldkSK56rXEMMlDv06wSDgX6D9uLDT3b6oK5Gp3xktUm8XV70ePA0Ymr1q0dilBKpv181EZf
 nvr2ZReapyIQ8liiZzzL9n1Vg2fG+AU0WZxnR6uAtau6IGz+vcMVsjfyp03zVzWvTyfxyDCdMZn
 y6oh6R7fuGDYqavcCimOR0j3WgiJOHRJ+xt3uaPmIYjIrK5K2qWycrwC7/BQQoOxJocUWmIKrnp
 cPOEDqA3F6dN6c3wCEqo2ixy6mYktznukaIpfLT0YrzqQXwHptSVTWC0hTTiHWsvw67dFPWEHXf
 phi7HUDJRp6ymBq6ZlrGf+TQZVZ/oB2Vdg9UILKAFl0t1KpYlQHzkTFnVWo5bjd7X2VRbl/Aj45
 MOtyP/9XjA4+PcQJAqMQaEbKmOK1Q/db+OSN1FKzSa28OT4A+iOsizkT8VD4nK9IdCCavPIS/O0
 Mxy4m1VHd8qEeBZ96kUfPyI57OG0p49hXFs0gPl+EUUqBfDfIxmBxTmm9hjHy0WBd5TKo/r8wSQ
 DRezl1onw/coKlw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add code block quotes to a safety comment.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 2d14a6261a31..873d00db74dd 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -143,7 +143,7 @@ pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper>
         // valid allocation.
         let wrapper_ptr =
             unsafe { bindings::blk_mq_rq_to_pdu(request_ptr).cast::<RequestDataWrapper>() };
-        // SAFETY: By C API contract, wrapper_ptr points to a valid allocation
+        // SAFETY: By C API contract, `wrapper_ptr` points to a valid allocation
         // and is not null.
         unsafe { NonNull::new_unchecked(wrapper_ptr) }
     }

-- 
2.47.2


