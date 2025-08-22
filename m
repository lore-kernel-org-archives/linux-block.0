Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D449E2FD7A6;
	Fri, 22 Aug 2025 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864933; cv=none; b=DikjWHK4MlRhIhN3pQVY3Z9jPbf8Ba1EZFAJZ1lspi8HvyI48nMC5qnmciqgVh3SUPitjExz5yAOHItBxBt1reO0Ebp7ghgSh2WN0c56LzBq43ye2wZ2ZtON3n7NP9t2ad9PuRa+qhYX2YV5ByhXd6b0hOjD2nqAVOBokQ2iAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864933; c=relaxed/simple;
	bh=WE0oYMKVocpeSumFth9LF4yM1uvggXOmT17lbIpdQMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ES1ykIrMLpVV5UKUxGbKbNKCM3WIQwbuXwWr61cQ5bv5u1QtaaHoodbSapKGPaPeE120nBAxdDTzHQuwLTUQwh8uxXmjEMmvX0HWD6z53mYiK+a18Odrgkoj0/BZ2f+MqngPkgW4SPfNL7Q6kwLHbAhTTmgjUiAQTk8Cj2NJ3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBWTYKQo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBWTYKQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B2EC4AF09;
	Fri, 22 Aug 2025 12:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864931;
	bh=WE0oYMKVocpeSumFth9LF4yM1uvggXOmT17lbIpdQMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YBWTYKQoenj0/Ay3VOigpzS9rvs1/HiznpaF0fi/5X/prxjG5Tb7ef4S+oxBWtc9r
	 5NTLaydzcZOf8QSBMhNoIp885rD5UWmxt6nfG9C2/Y5uV015kr4jqeSoYfA7TPR3JH
	 IlcOb1Y0HRkuCrWRLu05hz4nGIp68aig45DPLRzS92tQ7Y6CIyjUBr8DDjgHnkNfnk
	 RV8rdTLqL0EoLfegEd8t5iMnLZHEPl1Wh07CEEJFhsmaChcnjBi2FHi+45QSA144oh
	 oyRu6WRVoAQuXq35DqMGw3+klYEA5dx30ZZy6pYxRyYX/JQ7H/5PU2iSkhvL0S0Ygy
	 RGPhb5q9DGahQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:37 +0200
Subject: [PATCH v6 01/18] rust: str: normalize imports in `str.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-1-ec65006e2f07@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=WE0oYMKVocpeSumFth9LF4yM1uvggXOmT17lbIpdQMg=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF8yQBXW+JFCudmtBmoZUtf2BkqMp1/Om1gIZ
 E47ujvZOVqJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfMgAKCRDhuBo+eShj
 d1tmD/4j5/ZDzjuBD6KFdFM2l9aVRVQysnhE30axIgf4tlhXuvirDhm5DoS5rA0SobhehVSFv23
 GgkK+fTI7ZCyP2Uj+91lnRq3bbezPZIJANTB3aiXY1zfiRuRViNVdwRSVKQWAQcZ1nPYJsL//KX
 uJ9o7xD2BU7D0lnWytAIrT6AKm+UNTlZoGQ4h2gHCNDudtBWIDXo8GpyUn83yZPedKSQyyErOsb
 ZzLo0Iv97f5ZCcF5SlPO9Z9uHUaN4zimLF/+5685bIoPcGtkxRp9gXy7Ix7cMhNmgboYwKFGjSO
 yN9vUYy5Lj0w09E+T2slkLeBKAwOIGuSY2LTrmHjoFoMvdZfU/nOuWx1rBEIHT8NMjBIOd2olvI
 h9EKGh2vwcKwXQqbSQW1IHIwik2J1+0r1db16oxIadxzmEopm0RwTyrR4svQ2cOMJg1sbcUShOV
 iKEuamFDJH7wI6JnoT5GabhiNG87m5pprFGgVLKi18yMToHwwYrfl+b+G6JwPjNCN421FVQ7EcH
 M9G/gbE2NuMqQ58YsjFJK1djpFWqZ7ooNqR8iZ39LtOXmxiUX7fZ8UEYgmeI6jYExy/Hq5dAyOt
 QXH4YkuFO3/I4lXwOyOUi8r1noECuZNxTf+mKf6rW8+KXXl754E0UWLa42E+gKtcBMD3WI5hQfS
 Pw03ZI2x7hH5B6w==
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


