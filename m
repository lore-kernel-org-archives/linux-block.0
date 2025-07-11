Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39F291142;
	Fri, 11 Jul 2025 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234251; cv=none; b=D2zGYUlGmkHwPMMepEC1ioIqeaqoSF/5CrRhjckKVLu/TIljETAkUYrl7R3rxyQ+0qf0LcpGwB2K/pmwPPdqhEucsKJCHT3j55/bPE2SNP5q+8Z3lKihxcEOZxiWTYdlss4KS5678JFh6LYchx8NSVth654o5PLeXLfynHB2ZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234251; c=relaxed/simple;
	bh=jXiS1Zr4AgONsdr3cNnll+LNNcD6UkVhZL6a7Sj9en4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m50lT+aqDx6GjARXG64ceZ98ZkVnyTWBKk38rLVF47q/RfGjsSkPlVMFxr/oz6vzQDL/DytCMtRq9/9s2URgH16zM8BMUAf4BrfG7oV//akgV30JAMf/0InuEa98ylrwAH9Hhr+tJZ3UwOh7WJc2BuaLtnA39gW8TkiDG7sVSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl2U/s8S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl2U/s8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4F0C4CEED;
	Fri, 11 Jul 2025 11:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234251;
	bh=jXiS1Zr4AgONsdr3cNnll+LNNcD6UkVhZL6a7Sj9en4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xl2U/s8SJOSM60Sf7KdgVwhMH19SB7gebIHAOdUNfko73//2lMNKpq2OjtmQ6CZ3m
	 uw+BSIIW2y5TRgriqqcwbqX+MXhs40+Jk62PZIO96bwIsXR9ScjlmszBjUiGXEp9yP
	 371716yFKAHtWPp6RyQugbLeBzYh0O9p3d1jW/f0yRMZCVsXART9nN8y2R4E6WMl4J
	 UbSmSaguEFjx5xuEXlUY85oiBWcTJRVubbG/6CAt7FFC50k/GKVq4yapuAYzdQjayH
	 +leNylcVLfaPbVhaLHWr/c4SbctlaEb9Cv/+iWh/MBQPbmUe8UEog3czN9hdkk2rLu
	 ANb3ZOOZYKlsw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:02 +0200
Subject: [PATCH v3 01/16] rust: str: normalize imports in `str.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-1-3a262b4e2921@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=jXiS1Zr4AgONsdr3cNnll+LNNcD6UkVhZL6a7Sj9en4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjKl+Q2WYQl0UeRgBLWSU60DfU6PgRy5/yzh
 jANcaat0zeJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD4ygAKCRDhuBo+eShj
 d6dlEACa1IbHaekBERBUBnnKtwCaP4ThvpT0/KN3qi/7VdhuR3DOMWeb7YG6dyzrOfgK6F0ulZs
 cPoVC6Ggw5Tl78v2HCQwQZkl6/phSOCjBxOGYktfHXEaFpGCS6dwbsiKL7jtQ+72lXfLB5S42fJ
 G/DyXsLibet+SExoFK334tWPspLTG53C2J7xW+VLwngxu7ogPbscIMZdwPkMP8OXt1izE0QnJzv
 qLeD37ByDJDv5wD8jYByxaT5oteCrreGtk0D7ReUqwyb1yg0QGmVUlHOwegX6ld+1XfnnLMo0S5
 ijFMugENhVAnxddhTkg2RaOu1ExoqG+hl8+96/vfh3zOnO/0h9rckweUKCqTHaSkmOWoMmOQe1i
 /tleXSLxDv1owkwQHzYGEsIwYWvRQAO9kTfjjFA4NGU0WBNuIF0rP9076SUq11aQ078LR+frCRg
 OIavP4cVs645znyNBK41+YHry9CoAon4rBU1JanbCHgSpa9vH25Q5E32FA5LBIPGxn0pJIzeUhV
 GddGtQlYy9dkSBTDeSgHM/CpkLgzKZqXYi4wy7xNdjq+8+XKgT283Zid+P57bapW6sGbrC8nQpT
 qkPqLX1iRIHQlVquYVpkVnwslb1OcdivrYLfGohuSoFjBkNF8fa01CWRTW1jVANISz2/Eshghaa
 WKqOfoXRszLB4Fg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Clean up imports in `str.rs`. This makes future code manipulation more
manageable.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index a927db8e079c..488b0e97004e 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -3,10 +3,11 @@
 //! String representations.
 
 use crate::alloc::{flags::*, AllocError, KVec};
-use core::fmt::{self, Write};
-use core::ops::{self, Deref, DerefMut, Index};
-
 use crate::prelude::*;
+use core::{
+    fmt::{self, Write},
+    ops::{self, Deref, DerefMut, Index},
+};
 
 /// Byte string without UTF-8 validity guarantee.
 #[repr(transparent)]

-- 
2.47.2


