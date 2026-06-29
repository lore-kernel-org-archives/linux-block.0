Received: from out-13.smtp.spacemail.com (out-13.smtp.spacemail.com [63.250.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C937D13D;
	Mon, 29 Jun 2026 03:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782704703; cv=none; b=VZOkfKgkdPuKr6yXr+1TzQ8KZZ/hFdZAUwND1E6QlhygI7+xUsDagdCf7FgcuP+CtYTNGjJqVJyXSAT464nwR8OZG1fRn3z/3nrpebJG9wS+ZkXjS0veo3/fFuX3aVm9/fYmw0kTW1k2E7hxD4+UEFz6c1dd52H3qMLOEqk+k2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782704703; c=relaxed/simple;
	bh=/einyFsallnIvowLraedJWNdq8l5Vx+XkKnMCBgvEf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRRnxCv9kt1KEUOqvK2hxsqUwHyqP58U4vWGEhtWsVfKWikuwP/v9w5zgetSOH4xXaOG8romb/HESh6qx4yoIRTfuHlg0Bt20GazL9jEYszTWoQln1ci16mOegwDHsSSor/aITDIOyLzXqI1s1pTRgmFHRh4zspn/V5SDd3YHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=kv2IuH9q; arc=none smtp.client-ip=63.250.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="kv2IuH9q"
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gpX762Nf6z8sbG;
	Mon, 29 Jun 2026 03:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1782704308;
	bh=rsu/r/WBwNXuJN8+t83R5Jph4X6WrLULsoFBk7AwSRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kv2IuH9qfjU5qN/fw93o9W9+0qz6xE604v+ZgxAzE0ov+Uk2R8ms9TEB6TNmOF7lO
	 xK9WLHj5MKV8YYCguPZvH3cFTfqkZMzJzs4RBhOGSSEvTMEKRulKik8j9+oFGY2N8g
	 Hk+HbNVOn77oYvxczTNJlHDU1zl3tynxSouRbfJjAh44W2BgEeVQ2mMSWnSAIB3Nce
	 OajHwrVSsBaICMGfcsAtzygyi7EVWId4EctQHov4lOm+gBB9qnkKeT4OYNa7VQ0iLB
	 Z6TUUmbEcmBrnm42OQe7+XjvXD7ba3HYxpQyz4Z8y9xNIOgGl5JKKhS7lsqcw3eqfa
	 a+H7FTHt/d9Sw==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 28 Jun 2026 20:38:15 -0700
Subject: [PATCH 1/7] samples: rust_dma: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-b4-rust-vertical-imports-v1-1-98bc71d4810b@gurudas.dev>
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
To: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 driver-core@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-block@vger.kernel.org, netdev@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 samples/rust/rust_dma.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 5046b4628d0e..7d14574e8875 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -14,7 +14,10 @@
     },
     page, pci,
     prelude::*,
-    scatterlist::{Owned, SGTable},
+    scatterlist::{
+        Owned,
+        SGTable, //
+    },
     sync::aref::ARef,
 };
 

-- 
2.54.0

