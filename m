Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA272EA159;
	Tue, 12 Aug 2025 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988390; cv=none; b=qmNBgJl08t2SsRgUUoIeCbv8Ned56it29HH5AUA+merRp7tFLjBEESpmNZQWetrHhSaz2zm/1KsPdL+5fzq4nswDKqddpQ/5dWuYUsKmF+7iQxoAn58VAujNb23ICAnqEY9TMmFYFHHT88hfaqxS2JFppdROMXON0/WB1ckw3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988390; c=relaxed/simple;
	bh=dNkL1AXVwuljdfihZmuwo7IT4fyYZ7hZ0xzOqsCodNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h44NeslVWFuEYGG1+z4z5c4tJIEj3gHuPGXfJtOlzf9/gzwsQzQB5VINoWRbvpd/cJdR6jMEfPg6i9Ly7QQK0KX99SoLzIT+0OIZQMfLBJUZi0JjAhVEP4nosBfnbG76r1ke5s41iXOxQLYY8uciarYSX4St4LMJslroBbqKneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej1iRFju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej1iRFju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D039C4CEF0;
	Tue, 12 Aug 2025 08:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988390;
	bh=dNkL1AXVwuljdfihZmuwo7IT4fyYZ7hZ0xzOqsCodNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ej1iRFjuusjXG1jfGwSNW/I+toJIZc53wAFDC2Xx1g+YKF4wObQOsPkO9OXH7My+u
	 CaXpNpxy8+DVLbDtK/+8Xp6dTx7BJ6Dvtb8lZFvb7L2tRRUdx002RtCaGU+EA0mMoB
	 GJ8w/SE3ln49+MlbDJq5rz33ldpKbqrKQDnnq8g+NcnfvlKv2VqnqVdYg6nesdv0IR
	 E6MEmOGW7kCHlXyrAyWF5JhXCbc6lEiN5I0cB3ckeC0Z6DQBBO8EdSl54INCBmmrOD
	 7kVBLI4HNXEq6CfbGi32M9W/gXEJxKih9oR5u/Q88I8I/3KzcuIa/bEMU3nFSh6vSb
	 Q9H42K6GRijQw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:27 +0200
Subject: [PATCH v4 09/15] rust: block: add block related constants
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-9-ed801dd3ba5c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=dNkL1AXVwuljdfihZmuwo7IT4fyYZ7hZ0xzOqsCodNw=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8jjBkVYLCEE3H1oiwNjZEP6Wcm1NqusNCgt
 mt451E3+aWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/IwAKCRDhuBo+eShj
 d22LEADHinWAGFXhRHNPUgtQHg5EnNSr5zZQd/Of85wEJ021ljCE3ldcEFIx0JtLKFrY8qXmDrE
 JJkpBWTQdg1tujK8HK35fVqBFJIK0JU0h14r1t9T9b3kNBTNFMOYtsoWNV6HuJcghog8OjGNv2/
 6VgWSzv1wGHSrH/GwJ0HmgFc/xNQnUBJGSzFwOUk5Xh4EcMUElFG/EC/0ycFiJg0BO7wpag/GJW
 XgcPIC7Qy9QnWe0CMVgtVBSkL7slMl+XkD1MdoWomKQW/uga4NPpuNmLcL2L58Ct1b/i2ItPhIl
 4DGcE0AU1o1cxsTiU71cheDrAVw/hcCiMYcH0MsoQoBzBdGmXxqdpPd3kmpLcX2qRRLR9OveMeU
 gKkiMRCbDJ34LgjfHO7+niTh032f1O+E8I+nZllaWmXJmWhnKDlLUNZ5NDrHLgnI+lkMJJtf8mN
 JbB7Vakg36EV47/z9T0ZmmdLny70e0UDiErxsD3IUdIQhaDrQbdAXeXl4VX1fT+sGr6nmyQWeci
 DpryroIHBeojSaDimO6dgv0CAQXvSViXqovQ5bm7Pi10ZpvvK2nP5cGzyEF/yoZeHZuSVlwCNos
 wsQ8SHwOGoA3FhctkgqXwwjkGaTrxKI2EJpYYQguAFa2M0mRDsvmVPPr5JCITdFHyQOfXbDGj00
 xYb6bwYhn8i3Zqw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a few block subsystem constants to the rust `kernel::block` name space.
This makes it easier to access the constants from rust code.

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


