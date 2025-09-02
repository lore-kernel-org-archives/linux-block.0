Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F32ED873;
	Tue,  2 Sep 2025 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806949; cv=none; b=dO29aiE6vtl39Gaqyxn/wssbRwQPhPO27TSqMydMw4hT6GzPmisSc+cuoqF0eYsJveW+DtUyap3ISc60A8hESPkAy1cqLT0EwOL2c1fuH9x1mrmX+ZbcTPdQjECZvxJsJatFWKpLXdkMNImH/ssC2FTAdjbPZrvDqfq119cYAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806949; c=relaxed/simple;
	bh=5CeGT7OlLAwJ+n1eYK2YzNXyyrj/zX7cdxpv5cnx/wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLNCLQ98IKiHByi246mzA4Cpfqxmm3abm6D3jgMs2pvsalfL4sBISDn9uRC8zjDgmzJ7T2pcCpFuxKIs9RLMzX6Gy+2iKFv342GMouq94MIsq7nww+iv7qW5Q9UkLJRlruLvJgTQZTGJxncS6jmO0dyxciuX6m4Kr6uXK08FcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGkFaXtD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGkFaXtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F2FC4CEF7;
	Tue,  2 Sep 2025 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806947;
	bh=5CeGT7OlLAwJ+n1eYK2YzNXyyrj/zX7cdxpv5cnx/wQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NGkFaXtDYROSoorv26I+Obr4udAKVmi2ap0zcj2jL0QcFzK79pxqlQmB/B8EGe3Oo
	 /klizut9Em/TL+wJJbpURr4c2y8UdHbbCa8qYR8tZ7sPn12INPPVR7yFfrLGUUWO2d
	 +cBEM0NxirQQK8PV9l7Dg38XSg872ik3IucF2BWBjgm1qrZ1uiDrySNpokh7x4FESu
	 R+ih/wG/HGvUGWrs6pItSenoVF4VUc9fAZ03wm0UflCqHgz0KjdhiHiMUWbywKZ3Ct
	 7oPWNtzomt4Qx+P/g2HqPLaVjEhz13VLtbhHYNic0yGQWdg66HYZ2+gSxutLqVamtU
	 jVP4jOAFkveHQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:55:05 +0200
Subject: [PATCH v7 11/17] rust: block: add block related constants
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-11-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=5CeGT7OlLAwJ+n1eYK2YzNXyyrj/zX7cdxpv5cnx/wQ=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr8DpXUlLvBi5GBvjmorCapQWZ7gRCkj5msQP
 d1SM7HF+R2JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa/AwAKCRDhuBo+eShj
 d1ghEAChXQKR8qxW7URDo2QAuBfIybQwxVb14/7oblaHobyj4KVlMk7uSkdN8tDSTXR/ciNbYdy
 S0jS2socVsGdgBNfOtfCzaszz0v7UVWKNcnSPE5WwYat5tu35MWqq44HNrnMyyHuxzxVgjcVJct
 lyOoBoRblOHRxB7Jppjf+z8Nr2SKYzaK3uIyB0Mfdv8tb+KCYlAuZpR44pD606k6XLZMGvDZ36x
 zojOqoAuOBx1Oja95XymouwVFpVOm5nGozB3oB5JpxHBUmBA794W/jDQin+2bIkh5NBpb/RUlWs
 C+knMHYJRdqGMfqKytmoWFselxDpo7aL8T0TgbHTZgK6BNQmmMLD/udhTFeUUdSiGWU3Yyc+CfH
 2wC0woMAPDUhykFHZqZMY0NTXUbnDr4Rv1bfCax3nYrb1b8uhJZaIGwGxL7FhXYIuDSe4LyF25n
 EiQqDkAy+rS7lhm8fS43xcTWSpjdxF4wfgdA7XjIzgUhAWNjx0nm4IUAUZfzCyUAHegJern/UC2
 N4dtm3OvLG/Jz/08paLouGomJXDM0DEg7pqRb41914m0HfN8QTDkNy7/u1sBCpi4z3qpU5eweiL
 jPFcHJPjBQOXG/tMHbmijpV3SHk7G+ljolcRZrfgYdVqLXdc+tSIU3gPSPhrvCETz3+UgofKEnT
 JgLWOFoxsmov6uA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a few block subsystem constants to the rust `kernel::block` name space.
This makes it easier to access the constants from rust code.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index 150f710efe5b..32c8d865afb6 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -3,3 +3,16 @@
 //! Types for working with the block layer.
 
 pub mod mq;
+
+/// Bit mask for masking out [`SECTOR_SIZE`].
+pub const SECTOR_MASK: u32 = bindings::SECTOR_MASK;
+
+/// Sectors are size `1 << SECTOR_SHIFT`.
+pub const SECTOR_SHIFT: u32 = bindings::SECTOR_SHIFT;
+
+/// Size of a sector.
+pub const SECTOR_SIZE: u32 = bindings::SECTOR_SIZE;
+
+/// The difference between the size of a page and the size of a sector,
+/// expressed as a power of two.
+pub const PAGE_SECTORS_SHIFT: u32 = bindings::PAGE_SECTORS_SHIFT;

-- 
2.47.2


