Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D902E06E0;
	Mon, 16 Jun 2025 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080365; cv=none; b=dRbqD1EtVcgb5mF0MfW2fgshLJTdEdlVmKsQt8SZRC/ZZApFD+u2q+wa+O0sFV/TWnmeI+9GQTMSQCUww7oJg4qqdDnLjMFGifiBMqzK48yrKuL6tTNQfEECBRdcb/BOHZLAEMkyGyW/FUHaNBe2KLr4OEhoKOf3pl7CxUQmhKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080365; c=relaxed/simple;
	bh=UIGqb28OhjGi0ShhnGEPp1GLyZDUYd5N5Zi5nYnQrJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFtaaGxWt3hcmzksBYza9BZs1JqvSpCBc7kcnnaEpy99ct+lF95MKSIKvUiXVlPFj64uvG+zyyO6UxwTil0zNzEhi+eoGVGieug3onZSQJmLG0B7bGK1cMiXI6ePetbdhDLpTE7VxrC65hyM1lNdV74RH9OF8fmiw/s/aqISCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhJON0XK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhJON0XK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573AAC4CEEA;
	Mon, 16 Jun 2025 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750080364;
	bh=UIGqb28OhjGi0ShhnGEPp1GLyZDUYd5N5Zi5nYnQrJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dhJON0XKg+NgBXbCcLLwCLCHdtrnxTiLT4j8arcj7jMSmtlSOvHxYgie8IuWk3oY4
	 zvcYG7x4Zg6IVMYNPvO74VlnJEZrcllzmPAieCMROvTx8+ZskktVXZS8l/GGpzeB9U
	 aTfi22vrQvZntbNYaeYrvJ+gnDEsr005bjIxgWgaH7DWNVqI8BX+KSbm+/BHpCSHqO
	 DNSrwI7k289HVPmDkUOIL8AArmrZaRql6orGedvpq7CjLFEow7gPV9pQiuSKlBMDJj
	 3IMGytEoXGFIjuDSXtrV6XhBcGoPriqeWSBdAS7lDRVXqUCcRYXVFLtRdXAADncDT8
	 d7yKGfFow17PA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Jun 2025 15:23:52 +0200
Subject: [PATCH 2/9] rust: block: add block related constants
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rnull-up-v6-16-v1-2-a4168b8e76b2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=UIGqb28OhjGi0ShhnGEPp1GLyZDUYd5N5Zi5nYnQrJQ=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoUBsLt44lXpykJGpSDz2lZX4hbtWnNegNyeE1l
 qkxc0Y+elqJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaFAbCwAKCRDhuBo+eShj
 d+e1EACpZbZvhtMlv8Xw/JAufrfAJ7FtM6sl44AhN8GSGQyqm0egya/Kwx1Re+MtzHAlGpKete6
 9KHTglXEXEsVXrl60388Mc6zPrryXe3k9sqFy3ALVGZjKHxbJH7w3iK6MOw2g2P4CTH1jRS1AXR
 ltDyMnO4bvD6A3nrzAFr1RNFESm1BvfQAnto3+7OBP1rpZEmYJBZHihR2nG6+aLZstwwSqXm+9t
 Jqm/gkc6Z0t02TyQgfyp3gOSBbdBSkNTisV1CtBMNHpEoqL2dl5KOA7atDCDkNv5i1T5GREHsy1
 zTK9/qse53WcLPnP+t/qshWbwSAzswKt3xofctboQd2779Ibh7Z6N9RRvHPFmdBTtw9TUAnXGUQ
 a9QpmN0gc95cglwUFKj8WdY9KOdXltU/0RNM+mP4jcZgyHNzIhQEFn2tiswakQQKCGSLonqkmeK
 tOvPTtnrm1SYY9n7CvZD3rLxbmrkSwIQP2RcODxJY948WoHayrQuN/5qriAd4sQVpRkbePgJ9/+
 tJX8k7NU/jQ8vgNkWf2r4KV2kTeoRyrjfdOxSXedDO/Eefe0D4Jmt39XnH6jLzIYhHPyYhnh8w6
 ckThm54dnqIQOLz3hfDtzIrxdzg6up5M/oQ0p4fIfyVot785GFQZ/gLrqEfGth8j5cWXk0GMbIc
 F+OrtwGnzc1R1ng==
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


