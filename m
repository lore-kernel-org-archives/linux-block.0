Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D82E7BA2;
	Fri, 11 Jul 2025 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234244; cv=none; b=uPbcKSB4g5Q2vtjfAPeKOgWaG2u0lEk9F1F3SvcgzOkbGTdKizozP0qNrHqWSeriv8t9w31qsnflq1GmXSjGCbSdEgty7NUGzt0rZk0pkdTiJLDL89H5xjgA5Rrp7SXHXnrbCJUTmngkVkT30cKs4AEg4myb+JRnLZ0jroDh9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234244; c=relaxed/simple;
	bh=UIGqb28OhjGi0ShhnGEPp1GLyZDUYd5N5Zi5nYnQrJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vv3f6zKVGAjiITjbXRJmEUhAHOlZqDKSNeG+cbyGMBx/xH5XG9owXZ+bvHZgk40Rqwu45YKS9BukYZijeMGFoXWzL+B9WIjPCmFoKODF97u7Wl59KYY/G8J8ueILoGtijZDVnrsU7nxj8F0bo2pYC/2Ln7bqkUHyHQGipnhlQGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsDD55Rt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsDD55Rt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAF9C4CEF4;
	Fri, 11 Jul 2025 11:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234244;
	bh=UIGqb28OhjGi0ShhnGEPp1GLyZDUYd5N5Zi5nYnQrJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XsDD55RtcGpniNH/jdop4fKpcW+Of3DRyrCx3O+1eBU2BGFytR2gT21HVhd0QsCOz
	 RRP7JIVwyixYMx+LJ3RhKj6cbvZsd/GRC0yndK0eQAkZ1uX4wxGCYxqLpIv8WddL/+
	 e6wgYqezXr41Vx4v/vQ1CNdW7du/GOvrHTOgsizAJDQs4dnpivVQoBe8EBCcY6H8jq
	 eKsZo+H7DcDqXKDMt8xEVsGSxh8X35+Ymp1Y9N/sYs8qGNLf6yP2pV741NKux/XRNg
	 2ywNNnHPIznvxLwu/RhDsxxfqBP0HTVjdY3aIlQtwaAOdjlcrbGEt0e9xVNNr8tQHi
	 4cQ1h2xK3dxsA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:11 +0200
Subject: [PATCH v3 10/16] rust: block: add block related constants
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-10-3a262b4e2921@kernel.org>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
In-Reply-To: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=UIGqb28OhjGi0ShhnGEPp1GLyZDUYd5N5Zi5nYnQrJQ=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjTeBeWTnRhlbZskQwG+CAK8P3M4uHTzUQA6
 V21L1v/JieJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD40wAKCRDhuBo+eShj
 dy1pD/4jn5DzyirTPZjA6UFtCeAC3oEyjUriqitwsoile9/Eez6NzTCbWWAq4KrX1zhbyKNFixh
 K4W679rqOpFLitXptkNZwQfVl45qnN7aBUwQk/rpx/8NEQ74HDAm2tY3Xg8GvjM4G2bxv1/Sozy
 YWw0t8L/SK8TLuPoWNTjSc+J1zGsSL3N0B4oACiMuZF2hgpNyHzvCqi2RbWyq/fOm7LJ+IwZYSO
 vurzdjPAP1jsN3o/2z487KMNM8gflvhxYueMQtvgtq7EyJps5OeuzlbUo6yxa/uqq/Z+HIVfFdo
 J/DOnKcXxzlbHVpkT8h+e7DzarVUcfFCCwv2F5YeOQ8AEEn9NQ8mFIqN99E3IzEPTxaNtokCOJB
 EM99d9FcqfavrC3c7fxgHL8C0e3ZKUa8mFS7jzluXjHsy5X62UXwFIcn3eSeSBRr3zErZSqCHtC
 A2c1ZgXw26BpjP2Efo6m9TnH+LaJyduTylecyHV0I3WghcX/jfhhEj2GxIAT+T+HRx6styFdPW4
 98wiXaP+aGn/tOUbl/IwgxNJh2NY6gCoQzhEMRJSC+71T+lnX6UhSK4k1DIU1wLvKPKb4pDpsCn
 2zz/ypS6R1aScsgaFVuaNsvyZX/RPqtHLGelkGH3lkr/40nEfg4MO2yEl00vNSlqPs0COPct6QH
 7lsju5clVlzd4Tw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a few block subsystem constants to the rust `kernel::block` name space.
This makes it easier to access the constants from rust code.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index 150f710efe5b..7461adf4d7e0 100644
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


