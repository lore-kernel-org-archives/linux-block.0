Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928752E03EA;
	Fri, 11 Jul 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234224; cv=none; b=ILPy53hzjxiTiAd2QnQKZMjqlZHsj02qv+zYtK1z/1XaUGEFg2XaxCOGt6NmFS28xMfHEo7mvMUFz1NEwYeCOqr8F4z/ARdAP8qpT95hMtV5B6nK/3dP9nd3g9Hgagmy0l7B2Pc4oBSlSg0hLVpEnJq3VTkQVCTmK1rf0gx0Tr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234224; c=relaxed/simple;
	bh=vgGFsiKABw+m9kDtLSj7y9JLgW+Gk/xJ51MxKxfWHeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZpKgau/MOmj875KcHLglq0Xwi5BG/8DOA2DKDdS6UzYOegkkdqyKqvJ1LzTHi8S655IFQtsbn75U3lPymgrfK3aJYYDeLkaQhYwO2vlBuc4NaUWvjkcHarGHqo1YE1U6HE64Prwuqloe5xeALhs2NWfbI6Evnr3P+HPqYPwuIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szUMbKzE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szUMbKzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8A8C4CEED;
	Fri, 11 Jul 2025 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234224;
	bh=vgGFsiKABw+m9kDtLSj7y9JLgW+Gk/xJ51MxKxfWHeE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=szUMbKzEg7cw4GH87BzqC0rSy4jsrc/UMIqvLUDkbVYZ5T9uvuPOlhBjByLM5e4qy
	 kOIr9rEcI8QGWu0F0FYLtLbhfNxUM8x4K0AafjvxCg4nh3mh4EPT80m8nSLrhwRIRe
	 AmogqJh/KjJlA8f/p6rKFhYvltX8dFMeBNfWFQffbvlM6psVsiGuyWosFuQzhcJ7+0
	 wyFgcChOpn85Hw0e4mvIhFEwsFvtYkjtZTtVBtoVdsYaC2DColk8JVufpd9eGmk5j6
	 uOa/r0Jz5DhMootY4lUAhkLjufc6G+YSvjMOQWGIUHNKNsvvrB0JWRguR2Pz2EazrP
	 rnu5HuJ18YW5A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:05 +0200
Subject: [PATCH v3 04/16] rust: str: make `RawFormatter::bytes_written`
 public.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-4-3a262b4e2921@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=684; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=vgGFsiKABw+m9kDtLSj7y9JLgW+Gk/xJ51MxKxfWHeE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjNxcEYjeAkY0MGRQ0Mh/HGA6ILX2qDqZ1Nl
 YDx3bkCS3CJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD4zQAKCRDhuBo+eShj
 d782D/9XKgb7ERKPIoL156wLxet8cxy5LHF+uVxpm4iJa8Wc+Cn7HJTn0o7bpieyBuER4I5Ft6H
 Pkqfw5eqHNU0jHOT1cosXSuigCRYZ30rEOjfEsPdyBTMfCAlFxPMCxY4Jxf7I0yXdpGtinppf69
 wj9S5X3JgSse4g0CVI8qtQ5Eqs4XsAkoxOv4LLsdmeZDeqKpI0CoLimdzrW9omQIcuxLA6RfnZ5
 vHe4rlhhpiXkpJSoYuTU5p7LOwX9G2Od7cYb4NRUiRCmUekV5BQ6L2eetawF2/16cZKzKiqr3Ag
 5qllCPBor7G+pnY5dgVAIQIbfSsQeKqlVdwetqLRANiQAVzEUogCC9b7jOYuY49OZ0q94oJt/ri
 yaF3AQUjmKQNHQJzGOATB9OhKRmo/723Ej0bF1dlwYEtoMtmBCRbPezgB8t8IwZjuQfjfzghCgI
 1LL1dL7aVcb6wAqq4lys6eIqxXR+S0ZS/OCRUpBgtlrG54wajvzp2w/Cu3RaMVRYT9B9BXVv3jr
 Hlx5Nu99HfmO42FxwUYTSsOoVSYnaeyphS5GOVTYf3kpk5iB18CcxGBgRmYhIJWb3Hapv80a/3S
 0LPrFY4W0lNm+kCUJmib5ymsSRDghLnUwJ+d6yh6mOZC6k8zuX/lIu8gX0DO7cce9Tifqe5coXc
 es3+yC5+HrYFijw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

rnull is going to make use of `kernel::str::RawFormatter::bytes_written`,
so make the visibility public.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 28a6179385fc..b1bc584803b0 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -761,7 +761,7 @@ pub(crate) fn pos(&self) -> *mut u8 {
     }
 
     /// Returns the number of bytes written to the formatter.
-    pub(crate) fn bytes_written(&self) -> usize {
+    pub fn bytes_written(&self) -> usize {
         self.pos - self.beg
     }
 }

-- 
2.47.2


