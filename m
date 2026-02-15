Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B32D7397;
	Sun, 15 Feb 2026 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198894; cv=none; b=YD2BIHE6RjfpsRJ1v6IxdrYbnEDCJXkvHXpnaEkvJYUShTpevwZLWLRuN0NER3lzuwOj4oqv/kWGikYc8lSv0k0KqAWWDjxVnYcCYtOgbAJvN1pKDqmCGtE5U9vTftXPSyixY0F0+BIoIm62ldcI2boZFAE7q6BSCaPiVEoXwgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198894; c=relaxed/simple;
	bh=acRR0LGwJ+y2FUW7GXjH8dY8YE5jwTLkAI8WFKvdvS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ef5bhLxH+iKxEZ0s+if+FFz4uQg8UlWYGaKBSVpyCNY5pJ2tSWu4TRwJS2tLynRLIwDdfjPBswC8QPnTGAGzaAK3Z4mnAQtc8E+U4ZqbGrOKlaNySS65NJswO/Ml1YDI6UFYSq5pDs0XxBIgEyaJ1h4EVx7uJIkl/JbEwbIlojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L77sVJGJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L77sVJGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036A0C4CEF7;
	Sun, 15 Feb 2026 23:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198894;
	bh=acRR0LGwJ+y2FUW7GXjH8dY8YE5jwTLkAI8WFKvdvS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L77sVJGJj5AWUp/VBo02FiIgfdQ5aGIMLXeURfrgkHpVzHAQnM6emwYJGi8nBy5YN
	 t/GKtv+Gjp4xid2JjZNhlyatNgOb7mH2RS/eft1GgYfaCaNmM5Pu0G5H72jxN9OzDG
	 w3F+cBlWWqSGMa2nmyzVu3HC3NcLLbgrNITUhjXaDMbfjbs0/zfLPxlVedLGGXOYux
	 yuOqqPmQnqKFkIMfuLTpSHndjtU+rmQ+oJt6Vb9TQ8EyO0+6j3IyO1ajTSVacikhD9
	 jqrMgSgnKrf/+Wnt77SiDoOTx6nCqE0qyFMpSpuSRDVPfRMoJqNX2Z706Z7jnpWmVD
	 l5SOvkxYC5D5w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:34:58 +0100
Subject: [PATCH 11/79] block: rust: mq: use GFP_KERNEL from prelude
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-11-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=acRR0LGwJ+y2FUW7GXjH8dY8YE5jwTLkAI8WFKvdvS0=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklglP/KMsdGWPNdgIxkYpZcNKm6lzoIdY5t40
 tyXldVLppiJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYJQAKCRDhuBo+eShj
 d9xOD/9FOygg/84nz9+W8W2ER0YJsvYemP2aXeb/lR7sW6F05uvwWohT2XxSYaSLDGF9vFZeAD1
 hFVl9PzB7B+uzt+uZNFcjaB+bdmOI0mHU3orIn3M8rnrF3u0v8Kfde2uUiLXVglcvGw7QpyJOEu
 QfHPsmTtsQhxtmMf3EdNBhYioH7d3kAUg521/kYeZlr+SF/rlyXgLWGyZ2kZrG6UI+iBE9U3bv2
 7pV//iJSSizhA75X6E4l4eCTHgvfSKo/4gDmSM97YQq9wTHfDUIYXzH0psvShnnWyNSoUWthLn5
 Ka4nBngHT9e0jBZo2bu/WUizXidDTYl3kze8Ur1GDXIT5wOIlAypakvPe4Uv9cEba1PftVtAoqY
 xvxWf37mkn5PQPazg0xs+Mlyu+9GmFGokhtxA304Br4V07pwcix7JGNpWNOQGCnzb3HbB4vDjjR
 5GKbbztCE7IaQ1RI6xKpTXL/+nPBgDCOo7qBXhBPKIDFiy4T2CAFZjFKOGoh3XAXkhRcMm+iQXi
 Ng5c0mmdcJLRK4e2sBs8p61im4GeUsYwQXXIiOWsRr15rwNpVzyjZHawhzJ/zT54QgBtFQ0jTOh
 LH4gIX5WigNLyJb+sT6pkoWj5AukpenSB4cKMxYLmkv5Q/AvLYidf8bNUs/kPcFx651A38xcX0n
 5SgmfJP+zdDT4WQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Remove the explicit import of kernel::alloc::flags and use GFP_KERNEL
directly from the prelude in the module documentation example.

This simplifies the import list and follows the pattern of using
commonly used constants from the prelude.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index cedaf85ba0b1d..884bf18abbba5 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -57,7 +57,6 @@
 //!
 //! ```rust
 //! use kernel::{
-//!     alloc::flags,
 //!     block::mq::*,
 //!     new_mutex,
 //!     prelude::*,
@@ -93,7 +92,7 @@
 //! }
 //!
 //! let tagset: Arc<TagSet<MyBlkDevice>> =
-//!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
+//!     Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
 //! let mut disk = gen_disk::GenDiskBuilder::new()
 //!     .capacity_sectors(4096)
 //!     .build(fmt!("myblk"), tagset, ())?;

-- 
2.51.2


