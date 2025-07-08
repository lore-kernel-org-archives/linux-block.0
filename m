Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464032512D7;
	Tue,  8 Jul 2025 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003965; cv=none; b=l/xY2BOTisiv0mRSpfKNev29uivDBbcBl2npELMDK5hSJW4rkw/W+ooNC7Km6EiMx8kQZ6QtVixPWN4dUzzQhIcNCi/j/5QTcRLsYYwZgaGPdizn7KsxlP0irvX+Gid9nmImaKSOczDQ1aOqy+cial4x8hAhADTPgH+cGAbdeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003965; c=relaxed/simple;
	bh=KtHw1QmkuL/sm+PVBCjjLX5l+yiMnLEt2qOzqap7pmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZwU1wzptQuMNOL3cI3k2WJtS+pfqydp0hsYmNUcyoHfWKn/1SmQjPqEqpzYL9rv59c0JLFwP+PtF80kLglT57y+e73fzBwn0q0ABIsyzxjiwgNVojWJocV1dXsVhIuo3EovxCUSjAuUwvAiY/lG++yI1PUigyTIEmnJuj4H6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SE0ws8Cs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SE0ws8Cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41137C4CEF0;
	Tue,  8 Jul 2025 19:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003965;
	bh=KtHw1QmkuL/sm+PVBCjjLX5l+yiMnLEt2qOzqap7pmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SE0ws8CsgBA9mG/XWsHoNwyX+xEidTQ9JhrD5Ti0BqqobZmowadq1wVGrgrQCWWz0
	 7MtbyBsSMK3p8v7n5dX3dB5uhhHBlmaNRBWyDVRfbi4T1eGaolertrJltv2oStl4Hk
	 734BQ6+TsL2xKqBsPFs9FeoR1UPpYaIqwXzb336AHHRcgXaQgPb6oDvMaiF44Ne55G
	 1pYSyFmJ4j9v5c4zNqqzfv1/B3teZaQgxjyhEp8Q5hEnt/oYgemU3o5ArtgBd1WIMR
	 sB7kEGwvwR/3qlD9suXnqQMZqkYVshUdSd9wR41mWYBY5tUp6efl5oTQXqMriYRn58
	 F3PRtz8lPw6ng==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:44:56 +0200
Subject: [PATCH v2 01/14] rust: str: normalize imports in `str.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-1-ab93c0ff429b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=775; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=KtHw1QmkuL/sm+PVBCjjLX5l+yiMnLEt2qOzqap7pmU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVBOv4u+LhBKYblj3Sy/TSNHHB9B2MPUVN7k
 Ri70aUpKcuJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11QQAKCRDhuBo+eShj
 d6NxD/0bOh9Pbw5gaGMfYn3GdzY6iFiaSXPUGHnM4MQQ+m7+Kf9umk5i1mimS3403cA1j5uRm04
 ONhjQLZ92B3nVnoGUHpYXRALurFjQY9hE5WPiMD4CX6YF5LBHT1HUQPyBMCqAJiQAcLzyn7lGmI
 mc7HgibggI1otko7n0Vr+yrK0Ti2BQYqWMYIgb0p3druoflBgCVRNoPjEShxmrG5usbO3oPawm4
 NZkrNe1QqYRQuDSlkqNEt8YD/ddPxDgpbrMEC7xxQQksFf3nqwm/hpZDcUJzzYwh8Qj1ZibvOvp
 +huESt9lOXQvVFTPxmHFPS4PLgMT73/HLcW4b/hr96TUBtRWENJgPAuqva3Nts8gqk8XKcvlHrQ
 qAX9SvdOr4lLtyyXgrXdQOXs212N9O1FW9U87RVjLLurmsWDTr89dyM3Jlh4RXCUYUGdydXskqf
 kgMZjEPQqIGPlzuZ/3e8e2wOWhyNTEMb8KbFHG8ptC+shtrTWz2/jKvOnDq6NJaqqeGNvDD6Cy8
 NqMB+Mb5WvnwF9vy36qDVAcHA8ZHq2gMZtMpY0Awoh+B2Se347JBOPv+L5uwP18RBax9F8zbmAs
 GR8r1n7xqfV4eXm8vYvj30lY+TLDLIKUTD+4zZpyhoXhQytN4DkrAA8nrGvoFq78R6lTTH29v8o
 WIucYeMjSlxRkTQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Clean up imports in `str.rs`. This makes future code manipulation more
manageable.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index a927db8e079c3..488b0e97004ee 100644
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


