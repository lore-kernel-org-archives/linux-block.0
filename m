Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B082E717B;
	Tue, 12 Aug 2025 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988395; cv=none; b=kGEk1JGzvKXqmcUEasnRm2HymPIxG2B+ID/ZVxGGyq18o91gzhJ0891/snmLgHVVrIUIU5J/BUBC1cmDmzOpG9JFO8tR7XwnADzDZGQaPzk05eTslgk2VOun5B35Byl5jdRRHUhwLMfWO8l9+J2/yGjApC6tA4JRCqNsr7UA3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988395; c=relaxed/simple;
	bh=WE0oYMKVocpeSumFth9LF4yM1uvggXOmT17lbIpdQMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XM/UpYGQThx5Mjky7e1xJ2V2TgCgelI4epvoKQGk5L0gv4ylzxJOm7dFFzxnTomqb+VWXXGmsGIufbFge9ZIYRG82uX9Iv6iHAWxUEcdiwzvEHIf25RCG/srhh2xIDfIcKNGOMJqJMoGbChy6MD5VQCzfaLKd/p3tbS+it/yzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV0jDIDQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV0jDIDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3F9C4CEF0;
	Tue, 12 Aug 2025 08:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988394;
	bh=WE0oYMKVocpeSumFth9LF4yM1uvggXOmT17lbIpdQMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DV0jDIDQWrHdaKqN1ICXporUHHalbuZre5EuRTNF9dY+pGlJ0qqL7+0k1AlhuTFHu
	 /GHwk5riCa2ms7ymX7MpM/Ei6s3+Y+9j2nBMiTsB3F0Tp1Jzbj/0Y0UWVemNjRR/Gh
	 crBWB1RGRYzCjV9SZXxZPvIMs4r+jNOPprYJgFTdj0rYKLzPSIM0nvMfU+FC2Ntrv6
	 uVUWMrqVEUctcqTzvgMhI+QnQtjplsd2ov3UK8KFREKN0RYdQjF7HG2LYXLLzy+Ok2
	 6cIPWXPCYVtWbccA/GXRQ29kMHNnu6QJM3HAEdDG67F4116GflisxBquAuxFzPYivU
	 B6nPnPcaWRMsQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:19 +0200
Subject: [PATCH v4 01/15] rust: str: normalize imports in `str.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-1-ed801dd3ba5c@kernel.org>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
In-Reply-To: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=WE0oYMKVocpeSumFth9LF4yM1uvggXOmT17lbIpdQMg=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8czWZmbB3cBGXRwBeSNJDbgR/tNu0YBWMIP
 0TvXbNe5kyJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/HAAKCRDhuBo+eShj
 d7DyD/0ZqKFk5Meb/0O9DOCFM2FffVYHIyetBoSlO6rjZDqjgseSlM0i0pVsy9HTd17zu8zW2er
 dRdFgZO/XOvOv/dqj8RVbcMQJBNtACKfPvAdDiwp0I3gG6hjCi1RtWBS/tkoNZMsYCL5uT2LghN
 Rh/Znkb86uxjVIV6W9+zCBOJZv9UhinvEkYQn1mNInBYchtaYw+fJbXFP7opGZC2a7MBnfrqs2v
 y+HtwY/e3+zzgTzeTODzb+GhcEkWVi9k18SeOFzC3+yrnuumZLT8qxsNmXNBFVoizsCT349dUfK
 5dDFjRBK8ILhM6GUWMUqHPKWIsXnASKN6yuG5xcyup0YSyCUaiTDuFrIngpRiV3XYKSzRPUccwp
 GzLk7oeRYEqapMu3YfhfZtnLq1y15ue92Wd4/w9WnzU9JOiclq2e3b5DkszQKp3zHgHkh8jRVZb
 0AhNyk6WFpkmrF4oX71yTa2XTiFaODzOIAh462LYoimK8EDO4CXkQx6u7lnTPv8d9fo7GBlOZ4L
 1wDys7vFQc8/7gVe7AIG1qb/0kpV3uQc8lPdY0wvHqpTtRL+Gs8Rpy6+Ea+v6KoB7mqNpV4hRRP
 Q4sohRh6WEt/PYWm6MpjP64hWMC1WXZV6VsWUPoBAIQWLUlM4Yx+whJXJpRy4sLtlC/RVciXuDA
 qTQtcuE2I0+P6mA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Clean up imports in `str.rs`. This makes future code manipulation more
manageable.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 6c892550c0ba..082790b7a621 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,12 +2,13 @@
 
 //! String representations.
 
-use crate::alloc::{flags::*, AllocError, KVec};
-use crate::fmt::{self, Write};
+use crate::{
+    alloc::{flags::*, AllocError, KVec},
+    fmt::{self, Write},
+    prelude::*,
+};
 use core::ops::{self, Deref, DerefMut, Index};
 
-use crate::prelude::*;
-
 /// Byte string without UTF-8 validity guarantee.
 #[repr(transparent)]
 pub struct BStr([u8]);

-- 
2.47.2


