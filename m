Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0112D46BF;
	Fri, 15 Aug 2025 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243116; cv=none; b=nhg4Jb9la5xO0ZRFWny9f29hAlo6WZBVxXXq1NkPeIoXrQq8+PmqpUw5bwdExdSx6U5xDmS60PBFM39UlFlj7qCuDcVLwtLwL0Uf8bVviyBh8lvPcD5PCGP+oNgQjnOdTpjVJtLp5orOKpm1Q9f8qmgZyOWOtMmJNTOxyUYY1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243116; c=relaxed/simple;
	bh=WE0oYMKVocpeSumFth9LF4yM1uvggXOmT17lbIpdQMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PDqHwhziNr4pYhhNE/sIA1xQxiEzGXBW30rkVlqh/S+mqHE52BXrAzNXYpio/CmjmHPyMn1vs9xtURC5FFUFQ7diU2p+mBPuAcESu2LXvrRWCnLIkthQ/kdfHvmcWTPJHk08RqwDC9BbIege921i1hu8vsJP5lPGWBN4unPk4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZanBq7oI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZanBq7oI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD357C4CEEB;
	Fri, 15 Aug 2025 07:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243114;
	bh=WE0oYMKVocpeSumFth9LF4yM1uvggXOmT17lbIpdQMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZanBq7oIOBy4VOHmzL1tqiOd+94t3PtGXHCEZVGx1Z1um3wGOTZtWWeaOVy+nDyaM
	 U5334rPTHrS7oNpLdhWZ9GVvkWXyUt8KS812OslYKwjr2LNrlgPK7swKKG1NEbVII2
	 u+L5iNmCJGwWXIH+RRui8WiPKM0SBqd0mcdNFOZ6xk4/VVF0x+cy4yP9yt8DnBRyf+
	 eHHa0IvZD0HlnhGUHZr8I/71QIGzZ7mpfieULE0jof5K+TQN1636647kJc1gj+ebW7
	 Fdoe3U5duJ99Z6HN8LMqhRY7zIDD06/DMpSPhBQJWVq3iBC1a8ZZHgJwhNtGfpt3N6
	 vILDbUBawkDfw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:36 +0200
Subject: [PATCH v5 01/18] rust: str: normalize imports in `str.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-1-581453124c15@kernel.org>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
In-Reply-To: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=WE0oYMKVocpeSumFth9LF4yM1uvggXOmT17lbIpdQMg=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI0A8GSO4ANhM15pKf4emp3CTOYA4EB+oVhK
 LkSIUKwMnyJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iNAAKCRDhuBo+eShj
 d4DGEACpixzUudYAiCbLXXZZqjc+7blcvYyKLLcB8WDAxlvDW0CdD8j/LQMdKa90REOa4YYhKYM
 NskUP+wcrAa1vRmzJQL/13Tr7/uQS7RinZP5yp+qMzlvUReFP5Y3WUpUGauaBMGaABT8853LS+K
 yUwOi3HdzmWQFm4mN7LaL0ko9qR29lwGm2M/GPGcvZG5I0H3hydS6VqJIJI2rqglFiQIrWqkxjj
 Zfn+Rfkuw4boanebtjhYi6KiRbX4d2gp1VkX+73EURWA/mibi23Fr1GRQYQ3nT+GzH7r9pgOR2u
 l36AUOO4CaysmyPdZ0og0lR+Lb0QAIjMaaCLDbz6SBDRyXfNXbGy7J7N7ots4hP/Hosu8yOVUSk
 H9QZHSBCLhE3wcnZJRV3xgMYSkmqjsZZOmAHnlriR1ABStY4D8yf4dHQ8jTqqGd0Qr1IskZhP2A
 GBR+mLFrw2boK8sOqYd56iqOAp6Cpwm7Aun3NB8toC4KwOIiGamkIwf89XlBAtVB3XGFdUz4lyl
 pQyfBsy9SAdDs6Cl9oN4zaRJ4D52qcFJxEg0SVSiwoqlwV2wj/Bzs4GTTaQrT3wHHo+X2djhu2j
 1tXN+xFDhx28nSZhc45JrIjyMCSRP8CS5OeCLyK6m6omKsbRdAxdSuqZnx1dzzbKyv+uwO4AhMk
 BHNG0VdQ7npy5/A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Clean up imports in `str.rs`. This makes future code manipulation more
manageable.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 6c892550c0ba..082790b7a621 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,12 +2,13 @@
 
 //! String representations.
 
-use crate::alloc::{flags::*, AllocError, KVec};
-use crate::fmt::{self, Write};
+use crate::{
+    alloc::{flags::*, AllocError, KVec},
+    fmt::{self, Write},
+    prelude::*,
+};
 use core::ops::{self, Deref, DerefMut, Index};
 
-use crate::prelude::*;
-
 /// Byte string without UTF-8 validity guarantee.
 #[repr(transparent)]
 pub struct BStr([u8]);

-- 
2.47.2


