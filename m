Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C332FB602;
	Fri, 22 Aug 2025 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864961; cv=none; b=KweuvthBxUnOepmYyouTqrUtkQARnTqC6K9JL4VbAUCrLJTgPlbyGiSqUAl6AI7R9pX9AjOtS4H4Ldl6ovC/g2Wl6CeBigj4/BcBWZ6Fo0HLW6HslgP9aiq9Ngs5bZ5tqLeLArUvgPRukickaVUlDUxn2exSzDhcMEF8G07In3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864961; c=relaxed/simple;
	bh=pzI+PzwBdiJXG7Rnf/MUlf5BoxNaAVR/4KH77t5lHuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F2K2tOq0JKl7BiqHkIeiw51r1T8Ajkh70YJD/H1vJHvau/jKazLAQkeBqU3kczVeXEU76ay2HBwZ0MsMzjZhkBP03B26vkfkWCv5a4LpVLo4N+aSXj4UJKXyaneSbMlN5O5n66gSHAX0k9Iigqmb9Ffohr37IkE2jaJXGtPZz5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eugPQauq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eugPQauq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A04C4CEED;
	Fri, 22 Aug 2025 12:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864961;
	bh=pzI+PzwBdiJXG7Rnf/MUlf5BoxNaAVR/4KH77t5lHuM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eugPQauqg9s+DD4CckkQbzlLP6GQoWAYapYakDQwI813GtNJNLD6+HbFC8OvY6G4k
	 whaZnS3bhuC0qC4OBeEHezW6Z1vsvseL3yf21h/GvkukmlcJhZi5i+r33XElg8R6w5
	 STChSaAiywon/8S883fKnxUSUB+knJwSZlRgCfRnfulOWsF9ekZ4Mii/vMUNYtTrcw
	 cM+N+DbuqxOBrJc0nWsmKhNK+GhXPGZQbBffe5YA78vkKmT2w4TfF8uEpwrJtiDcF+
	 3FFBbkWSZGrb/2NmL9xeAXJ+4Z1twB2fSyMslO3BdStXmqK0ARFsi6vQUN0VzhEtm0
	 Tmv8W9i3KTIbA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:48 +0200
Subject: [PATCH v6 12/18] rust: block: add block related constants
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-12-ec65006e2f07@kernel.org>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
In-Reply-To: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=pzI+PzwBdiJXG7Rnf/MUlf5BoxNaAVR/4KH77t5lHuM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF88vYZZFUYtq6sIQRW6685mmouPx6UDAXTUz
 URQ6DhtdBaJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfPAAKCRDhuBo+eShj
 d7M+EADFxD2piNMvveM7zDctM76JNI59SOxhxT6ZlWjPWmPWx5CCZTUK/rCIQ0kAm2TgGGM2rma
 cDpyV9InTXTn3TTIltEvKKTDk6Y3JeRARm1hfw961YFsZSFlqBJwoMbk/MFvkpFk+jvs3Yg+TBa
 MdoFL/4dh/7h6R1qRYD2Cfqn4v7CozNWUeQyhwUSg/hWJ/ioPnAn3VPonhFiVySWOt1zeYSi0/m
 wIf/fBzfqQll9OXmgVaiz/W+VGYKW+cYvt+OM6p7UWsfaCDZ4nkxygRvQSnBaySkfx2ZRIxR85c
 dw4fKYHjojxzYii4CP8soLiZrT5kpzntUn8ZMYE1yLCl3Sn3IvQOstQwTu9H9uKwj+7VjCwEcz+
 ead+sErcQMb7r9PpD1ZPZ0lYb6zXfDOCevOnBYMJ3TtolipM4DaqvgLyKpd/vsWhgLsEXIqBoeP
 89hHIG3j+Oez4ykDwcl2AchPA2SDbhE8YWv47adWvZtGgQrm4thwAjJRqhpG4nv0zqm+K0ef9r/
 nJIf3+rf9WChUCsIXT4/FNO/P6SvT+DxhxnYtrCyQJTZU/2aKq1ZrkbWoU8/cP7jlYfJGcgQL7H
 QzeNx8rOEJGzh6Yrwyy0QqtO/oxTRXJuFh1TI4RACJPoVe08wPuliPxBEmInMOpOm9oKNkCcz+H
 f8QKbiuohVn2LyQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a few block subsystem constants to the rust `kernel::block` name space.
This makes it easier to access the constants from rust code.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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


