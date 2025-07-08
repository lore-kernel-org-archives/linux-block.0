Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D9248871;
	Tue,  8 Jul 2025 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003954; cv=none; b=oTpb7Mh5Sq24Oh5bCIHYhcPHICV9NJIoqhzxGAT8CU4HcIO+h3UUcKTgTqvxmHj/KFmrkU2FackjTKkvno898oHJTmqOgA3cMda8Q17mmRoOJgWGj+ECEiQyPmIjNO4DDFOUeGDThksDph8ChL35JcWA3/XAiewRewbOIHONAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003954; c=relaxed/simple;
	bh=RO+tyqWrHCbnzP2crbU2WSIANTt1IoquzI2eUdQ4Jgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bHU1fvGPbvTgm2MNSR3oqo/44iQgBqip/r5ZLLjEbnrU9EXJw4fl1m0P7te5s2QqaurwQbb2yscopjAz76r1TjzCKJvL6DqSrPukEIxhYDtl2JQz+LSjJXvJsG0KrljJFfSN5GfDZrUe9UXTFvm/fPqxF9uBgdeGTKN5f7SsbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTmIp99g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTmIp99g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56682C4CEF0;
	Tue,  8 Jul 2025 19:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003954;
	bh=RO+tyqWrHCbnzP2crbU2WSIANTt1IoquzI2eUdQ4Jgs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DTmIp99gTpVr5Jmw3A0m1aU4I6v3Pdo7AOA1XhgzGwkd+3fmMH6Buf70sun8PovGd
	 7Vay58Nra6QDFkzv7nuLj0WcO8okpLBYP7BuG5pnGXu2QRupWpc7NvX5J6rxwea0oW
	 f15C1+2bA9S1fYf1026410nNYAZaLXrMfshxDSb5A+hpaer6PHVOF/i27jOXT+zy2y
	 y2h4XIHOcoNgVnR2KpazGnEhbIEEz1rrmLCPBkzrDfoZ9TcNbu6UVROAwRF+SUgPzZ
	 6mDr2qZRBe0C5Fih2zBrKvZ3COXo9rPC5WnyM0qR1wABWTBiERH1B0kV+o4F679Vd2
	 qNeK0GRSJbF4w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:45:03 +0200
Subject: [PATCH v2 08/14] rust: block: add block related constants
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-8-ab93c0ff429b@kernel.org>
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
In-Reply-To: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=RO+tyqWrHCbnzP2crbU2WSIANTt1IoquzI2eUdQ4Jgs=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVH+GZmiXeE7Y47innOMVFwgcZO1TcQ4uQ6Y
 NkEoJ3KD2aJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11RwAKCRDhuBo+eShj
 d4eGEACunnqesWrxZ0yRDuKSHCfSG7jn9oz45l2C2TjKpg+R9osmock0kBfUwAXlmFRu9eg/tF1
 lZHv95o6PEouK/Yp8FaohtxnrM1r4uNsHcLbBo3tQ87ItTCT/vPmFbMwiK11Yr1Gw6YYsKLEYe3
 YKPilfB7jHN4gRfVqphThGPVJU+TQnnQQA0zHKlxFyXdlWDnVhqdW9e7rY7rFhYU7mmLuUPJ7xJ
 FhJuKXhAyMTqVW3NjbUeXeqgqwQH29AHAjQvfFTSbIut7hiR81J6cVGZR7xmUCmV3WKoExSKBoI
 lKsHog4QNUesnMe/PNaek/wnsurTEdfVWu+1DRys6mT0dBPBfPXDUiO6nre0nFIj3tMhz2yprTK
 LB3Pq6kk/+zb7RtOTufb9bW6p0yrtdbYREsJWXFSyQDH9+pNM8BpZMKoEI/znQTd+6rvKzoIikR
 O3LvpElBlnSNCPbGMLNEY5vGKpAhXZOexgWe1oNB7iNsKi4gHs51LSq3tKnlpuIFoiDfUCWSWvw
 uOABhPHgLYcTNm9liUbQP1nTpqBEoXDfKFGAhZtTVVNnF9d8MyGV734hXmqTIravYAgm8S8b5Ij
 9J2mfSKiLS5UmMBF1CJLQFTPYxcUViEKelabjdQhI2xQuPd9SvtoIw6W+dS+0XVTbeLSskdi+Nf
 JZv7rwkCJjYQBWA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a few block subsystem constants to the rust `kernel::block` name space.
This makes it easier to access the constants from rust code.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index 150f710efe5b4..7461adf4d7e06 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -3,3 +3,15 @@
 //! Types for working with the block layer.
 
 pub mod mq;
+
+/// Bit mask for masking out [`SECTOR_SIZE`]
+pub const SECTOR_MASK: u32 = bindings::SECTOR_MASK;
+
+/// Sectors are size `1 << SECTOR_SHIFT`.
+pub const SECTOR_SHIFT: u32 = bindings::SECTOR_SHIFT;
+
+/// Size of a sector.
+pub const SECTOR_SIZE: u32 = bindings::SECTOR_SIZE;
+
+/// Power of two difference in size of a page and size of a sector.
+pub const PAGE_SECTORS_SHIFT: u32 = bindings::PAGE_SECTORS_SHIFT;

-- 
2.47.2


