Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855223A566;
	Wed, 20 May 2026 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244813; cv=none; b=UoaSbH8tSza3FwgujxkdYdO9oiEpbvO86iX4itfhnXztLagPct3TmhK+PljFnRmW21ZKMmZ2bYysGumw+4+G0NEb63kn+a4bY1yWZVtBTPX6QycJpvhvxsvoZMIbzDy3fTXttN8NY01tBEq2kvAkoUO/jKlo5Tj8yVUqr3f2Gtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244813; c=relaxed/simple;
	bh=uxbSDDBiUmtFEUXe6RQ/fhwb3WKp/e+Dv491N2iFhjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7+CBPYVfnVm9dTVTAsx7Xz8vPse00IFJPuV5pNmCX9oGH1pbJLxNJOIVODYAMjmLI5ecKbb3be/EYcu0M95RDJ+MoqsliLnO/BsMy9h0UGR2fVzn7nisyU970jGMjKY3cj4LgBTMb2eWosiXqBpBVf2RNOGUfryMuzaIt/mFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dlkDEfzO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dlkDEfzO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2F16C2BCF6;
	Wed, 20 May 2026 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779244813; bh=uxbSDDBiUmtFEUXe6RQ/fhwb3WKp/e+Dv491N2iFhjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dlkDEfzOzsu91hQxCGZkqUTMfRr22nS3ELmycT5z67LSg11AKvtjmjp8Eou4oMSZ+
	 mmc1oolf/c3RjYcNRpU3USp0+Zz12uiB8avBN86LCkmoQJeRvLRLrjOwB1luP6mtci
	 ytOqZIFEG+ngPnm5VjPu7XCwO52PZvmtY4tb0s+Q=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DB4CD5BAB;
	Wed, 20 May 2026 02:40:12 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Wed, 20 May 2026 10:40:10 +0800
Subject: [PATCH v2 3/5] rust: miscdevice: remove redundant imports
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-miscdev-use-format-v2-3-64dc48fc1345@linux.dev>
References: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev>
In-Reply-To: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779244810; l=994;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=uxbSDDBiUmtFEUXe6RQ/fhwb3WKp/e+Dv491N2iFhjE=;
 b=nIiEQpCRCQxzwxU7nG8LskCvHlORHcgEBXMHXdnjmMhAt7hAPeeUSnksZbGkz+soNZAceM2eE
 CV4phwJU0crBEEDl3toGGxGMm9hFCmhv1pvmoMX+XiuCQGdke2yia+8
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Drop `Error`, `Result`, `Pin`, `c_int`, `c_long`, `c_uint`, and
`c_ulong` imports already provided by `kernel::prelude`.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/miscdevice.rs | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 05a6b6b9770f2..83ce50def5ac9 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -13,16 +13,8 @@
     device::Device,
     error::{
         to_result,
-        Error,
-        Result,
         VTABLE_DEFAULT_ERROR, //
     },
-    ffi::{
-        c_int,
-        c_long,
-        c_uint,
-        c_ulong, //
-    },
     fs::{
         File,
         Kiocb, //
@@ -39,10 +31,7 @@
         Opaque, //
     },
 };
-use core::{
-    marker::PhantomData,
-    pin::Pin, //
-};
+use core::marker::PhantomData;
 
 /// Options for creating a misc device.
 #[derive(Copy, Clone)]

-- 
2.43.0


