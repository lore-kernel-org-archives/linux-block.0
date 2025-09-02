Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153B2F9C53;
	Tue,  2 Sep 2025 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806999; cv=none; b=Mo0H6J12Qkg/JAPFF7M8cyQHbllFYXRyJQKWItLSmQU7KHthKOyZjGcxBZ2T5hbMA9j+MxjPIfdAr8skjT+6wWo4D4HhcOKkro1TEsbGPipn6qdtNHiHe8TM8/98eKXYZ6JOVfYSCfJEPAjcTal/la8fY6UgU5SwCmYeJ/OQMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806999; c=relaxed/simple;
	bh=DnQWptRm6OEtyKtyeEKDg0SEKWvOGMP22Avp/Fwe/FE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSLjjp+ew7zfhmn8+BjmsB8pHssxGiX9wQrXSK+Jlger9NId+N1jTY9gbH/4ERzgAsCZo/XxhNlnGQCisAUgIcVGZlta4qUo4QeUgwxySxltehn5eg/fhCEN2HeI+hktp7luyfNkxG3SZ+yRjgUJSLUy5AZY2o3zq/UmRAGFdkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/K5XsYw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/K5XsYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9814EC4CEF5;
	Tue,  2 Sep 2025 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806998;
	bh=DnQWptRm6OEtyKtyeEKDg0SEKWvOGMP22Avp/Fwe/FE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G/K5XsYwsSlDy0eQzES0lr5HMCwlwYBiRvK/jS/Ac1nr9D9rkG9VC+JoHfiMuv2zZ
	 Vkv18qsHvFKefruzdVlvO19vCHJ/Yt0dqb2uLKSCk53S4w0P+USp8exNoS5/aL0muf
	 jjdspS5fBkFz2JyiZ/wDIum28/+o0XYssRc2mckyAO1co/v8sIfQYJO8IZ33mmOj34
	 TlNuhWJbpMiy3FJ0P14hc05Zkf8N63NcmvuVgEhn60nPTUcKXCffI4yp6sHDKwVAOS
	 FoD/+p1fL2CdBQqHf/nv7RXThCKHwl30jJlKuW0a4QiAIK1jhNLoAQWH0icHbNmAi+
	 UYDIbqEq2E8hg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:54:55 +0200
Subject: [PATCH v7 01/17] rust: str: normalize imports in `str.rs`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-1-b5212cc89b98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=DnQWptRm6OEtyKtyeEKDg0SEKWvOGMP22Avp/Fwe/FE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr75SEkZ/zMMjxiWlubx6xDXiKsLDbKtLyt1b
 Pg9fCcCt8uJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa++QAKCRDhuBo+eShj
 d+tUEACgTEeKLSJtbBn4EfAn/gVPBerY8hixSfWNUIUsb+sXCVWVze0QiuJOk0GOd0m1Wtonqvb
 bi6M6AUcsDeXNrpK3CCddi9DGhvvU4zrQtBgF3OrAonxsS8456B3bsXbGfPkEyB9e9HOiPy2J4d
 M6Xvzz3pAqYrHRlHF12GZm/96sjYC4t0jannMWis8u7LvCRTf8mPUgGgFj3LRlgWupagm3UcLA+
 gM02vavwJB3eFFuiYTgkp+Vff9b2SQbHtpZGyJo5U6cF34J0klHiYYsLGcRd3v70qPzXn4pALrb
 F0oj7gRJ1qmZnWNeCkGwJ0ILCdIj9hlnBa5cyd6Yijl1yI6sTz3p3gCknsCEskybC1b6d8FunD9
 3lYnqU4bKJtPUFsHKeFeqlEHSgFD8SBzrtyJN0sR1qbdHM1XXyG3CVKeQvv1S02t2GxLn6Fmf3c
 6w05GpHqA9QYxWI6XhwXFzmQuAdPUyKEf4LXpPXcUWw/j2f37Q5O1zWfVOAMbOxnyGVMdOyJI9E
 anBXDn9I+2X4VhUVaTAzykqy67gMRIOH2nL3s8HrV28671mHpX3FCgvSXVXyfIzSCOgCfmhHojL
 REeSCquAemXyRYAxKjPktxipMYSzYzjfv9lDwiYOKmCt80v6zXwZgbKF81ISgF/5a5zcDPj3Mv0
 7M299b2FfdhJkCA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Clean up imports in `str.rs`. This makes future code manipulation more
manageable.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
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


