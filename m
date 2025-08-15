Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1F2D3225;
	Fri, 15 Aug 2025 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243158; cv=none; b=kMzuZCMvyMIJRw2cdHpn9Dmug7RZm5XeGROl6hAh15Z5+EJdljaqJeAmYNaaYUXN1/WWH5IPZg862ymnAuggm5gjIiqIgoBukKpL5NUWKi9wpuY5wwrw29vC0lsQw6hCkCbhhQ3v/SAPosCR0IMaCjMeFKhpDu1HPSSr8ZKLeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243158; c=relaxed/simple;
	bh=hixYhOSo78Opw3JCXq3T7Ep1Lb7kHadQhoAfotnnjUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AR67Scki2vOSdPpC5IM0jBGXaKU3lfcTUllmdhKPNJ0qItTJ18uOm4cU+s6QyC4ROiY6qKlsk05Kqota4ll144eBoDKWa6oEvB7u1roRPunf2Tkt46KFWf7PH9/dM5r18fxAVXC+fdOfScI6Rm8AfYjgowaD2TVSuMpiiDRhTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7ALk2rI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7ALk2rI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EABEC4CEEB;
	Fri, 15 Aug 2025 07:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243155;
	bh=hixYhOSo78Opw3JCXq3T7Ep1Lb7kHadQhoAfotnnjUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e7ALk2rIl0en5LLhKCdRB1UEYnrxlvodr13tF3QL0vApm9pmb+/Q6lmKAq5mpVxIk
	 FwNG51Whdkh2Ex0EuHYO9eL+kV4fNzhwXaXhsKfI3CfsIxrdfp/jZHq71GUt3GYaF7
	 0AFkjrmZfENiBjOVCm+31kaSYr5O9M0Tv095rb3+dv6G45Ym2o5JF1WzlkdJ0odVnl
	 nKRMl6OOzkXiIqJ0tDT2P13qiTwJu84dztasi3maiITLCCLZxh6yqShfNLEzKNblrP
	 X+mH5q8pmZxV8eJv7mHj4EGeE9p2BVd260xzr8Q2NUZ/ckcn/maMld0kPZwT4fdh44
	 bnU1wdCftEkcQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:51 +0200
Subject: [PATCH v5 16/18] rust: block: mq: fix spelling in a safety comment
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-16-581453124c15@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=hixYhOSo78Opw3JCXq3T7Ep1Lb7kHadQhoAfotnnjUc=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuJCJxHe2wbjvtpom9FeQGv+WU7jKTJ1zJioN
 19G94REFbGJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iQgAKCRDhuBo+eShj
 d8UDEAClgJzpbwWJkeqPd/Xgvho4AvLt55cbsiEN7FeT/q0Wh0rkkO+RfxcT3ymWlC84tduQv8n
 feeUkQZ3SUbs3svPb1muGnXG3YwRzi/rkk/2jeRn1foUFvqfkcwNhGOnhTJhmKEZcMP3QQkbQtR
 75cKWvnImWkTx84GBMkoin15MYHSIY9/H4P51c7uyj8Tw5xpvea+2rJCfPlbceAWkZP1LcnITPr
 NO8D7o7DENBjzhE8BqDV/Dyg6eQXsItFrBn3o59nKS8WFN/hwmXpu4s5HhXKoGRfn1qZMRIkZy6
 rDq8mgJPpmiw9FO6JBn9b+9GKotyLlADSysC6pBij2PVfXHzTm1HeooVQbtCrqeYJlJ+rPSxyXR
 X3Gdrd1EJxCUifxVNBvhTmXnRBQ+Cme13y36srZsXLrUBE0oRYo15IV+6NwLbIzsD30y17U3JXS
 GmLzaZp4rI0AuJx1oLqRq4hPObYs80LTW1r61A4i1uQ1pyk0TQW9wS8rq4QyQtD46xx0U5avHIW
 qEEoZ8BV+pVoS1aIGYXNm5UDqOWHCMebKcL6KT3mgAJALKoQ5SbK3crGIzN51lYyJpwugC6WA1n
 UBuIsUx/vuVrOSnyZ0IyXzH5TNn7wKiSQkcnGYZZA9SAGaPVAiuHsvLF1gZUfekCJy18BmjjASj
 92Fot6+n/FXcsXw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add code block quotes to a safety comment.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index f723d74091c1..3848cfe63f77 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -148,7 +148,7 @@ pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper>
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


