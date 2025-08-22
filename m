Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E152FDC3D;
	Fri, 22 Aug 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864944; cv=none; b=VnG09z3aI7lxarSTb9qiFt3RCGx99fl9yZRQXHOOU1UfdDl3yt9VaGnQhen7B4c88Qg/m74jxBuI2DeeNl4u1QCkFjqoey12SfklIovz98asCX4ASuLTSRXQmYNqd3s1kbaXhGmiZ91/0tEnar1iU/JotJXaWfN2AAWPbzIkWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864944; c=relaxed/simple;
	bh=ATd5+u0whvcapgNxLkUWKYG0itmO7zjTecaarUvu5lI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNJEcunB3dAWsPxBrecswY4TXn4RH1qBzhQKAc/5kBpUnreZIsW1fVrhKeRaY9hfI8EDetSofNuNjGFbLdLrurS/xClAh+0vvQvVyAVJG6qGlleT25JJeoiWAXoW2AzGbmCboa+ta5VT+Z2auwPFoxohTxVBs4XDGmrKU/WWvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYBxR+IB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYBxR+IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722A8C116C6;
	Fri, 22 Aug 2025 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864943;
	bh=ATd5+u0whvcapgNxLkUWKYG0itmO7zjTecaarUvu5lI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DYBxR+IBPUkqD9JvCaIrUrnxARfa8PdbKEvhc8fFvoYFBsqFNveyEOJQxHtpWpRLn
	 pa1hdyq1R4Zty1e0KewQBhWIPJUVeV90btoZB6eMcmf0Bi0v4J8zK6PnS8EruV79xp
	 7zJcWUAOmzucC7xnObrXV3f1QhhYQq9ixwrWwJRe7gO5IdOypAB2I3fLqcDy2Zr8Hd
	 IvNBQ4JyGOp46fMPdwO5CJIRpWNfEvUYr5qaQp/aRiZHzwQa7ajFWcQJRLIpRJPUDs
	 wCkuacgK1TLANRIcbfR9kT7wgB7mPj7RWE3HOd02Pz5dyssVrF5YJSi5RK40W2dHgL
	 BjKr+NqdK/ZeQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:43 +0200
Subject: [PATCH v6 07/18] rust: configfs: re-export `configfs_attrs` from
 `configfs` module
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-7-ec65006e2f07@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ATd5+u0whvcapgNxLkUWKYG0itmO7zjTecaarUvu5lI=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF83Ky5IQVSq++INe0nzExH+utK1YiwzqUJP2
 B46T5iL9oGJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfNwAKCRDhuBo+eShj
 d3m8D/9uwUXdXA4j6OM0nJBLpMcuKCeT5uL4rSeQXBorLWs9MhuzL2CdiMU28UhjHrJ0ODQPmOo
 QuHmoaW/a2e0RApYeKaIYlzAm554uL38s5Kr4FmrMeBPKuaZdDbRVP/EptSBMTenoivzQneTuwD
 pbNUrMzu7lg1gacYAGx0JO4LVtLu7x1KkF/X9mf37N29MpxQFdDFooajTAnugqlbXKUpIDTZpvQ
 1WYI1ABbCzX0f5XMY/Ao0ZvQISsT7owoxv84liZDhKob6j07ci5RUUm05dFmBXRes+MZ2LG83h4
 5o2tokuJCGDa0g5x/MFYkiiaggONgz0/brR3ru18hiqEsvAnVZGT/CaDNxWHdiO8czn1ZyITonv
 NzdYBKgJPNWhHYJ0MClKWSulNK+eJUghBdy3qks7ucJI3uhMeSOpaKO84EFkoQIV7hi4FJWR8Vw
 m7KGddpWzmNn/jPdV91kqXkWilTpB9C6Baw/P6B/5ILyl8++NK/w+HeXyz4nTuULdsh4jF2rY51
 PugppUB6jLdJHjVkOmOJnizgrYuhi13UpGepZqOeg5do9Ey2/KpaMgmg1pIqZIRpoAvDXvpuBsp
 5bNHae3+MZEXvSS0QbYCwDkTO4M0/mJ2LM6vfp0LguF018yOoMH1CHvlWn0uXLaSRdiFPpHYEUk
 B2YwsZuLXThZoTA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Re-export `configfs_attrs` from `configfs` module, so that users can import
the macro from the `configfs` module rather than the root of the `kernel`
crate.

Also update users to import from the new path.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/configfs.rs       | 2 ++
 samples/rust/rust_configfs.rs | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2736b798cdc6..318a2f073d1c 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -1039,3 +1039,5 @@ macro_rules! configfs_attrs {
     };
 
 }
+
+pub use crate::configfs_attrs;
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
index af04bfa35cb2..ad364fb93e53 100644
--- a/samples/rust/rust_configfs.rs
+++ b/samples/rust/rust_configfs.rs
@@ -5,7 +5,7 @@
 use kernel::alloc::flags;
 use kernel::c_str;
 use kernel::configfs;
-use kernel::configfs_attrs;
+use kernel::configfs::configfs_attrs;
 use kernel::new_mutex;
 use kernel::page::PAGE_SIZE;
 use kernel::prelude::*;

-- 
2.47.2


