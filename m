Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBEC31986D;
	Fri, 15 Aug 2025 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243121; cv=none; b=H0BE/D1rJ0wMCOoMOrO6p1UPLAF+nWMu30nWz4mQaPcaLfgrU4gKmIZpV7RMnVlXl4QuyCKup4cDECsT5DY7z9DteeheAMRMcupxvjI00qHkdT4qs/rzfx7qXphbtkB22d++1Jz9At/YC95SYoZbUzhs5tTjSumJ73prb1dytjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243121; c=relaxed/simple;
	bh=J0dcIO8q+R6ovaWgRSo4yUozRWOuH9a5eI1bG+1XmvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hcH3DwGhVM1Rku2LGm5fePpN87tg3njvdK3IA2FRE1gaLx8959mFlPYAduDXr+o4OHDLztkYeiTQj1M4wDrbG8HOVGYLgLNe3OPtrqkRW9iSZ8dF/Fyll6Pfajj6QHSNYrN9qBXlmWEHj4gruniN7kDx8c94yT7G3yfLqMXL9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G93voBOu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G93voBOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7634FC4CEEB;
	Fri, 15 Aug 2025 07:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243121;
	bh=J0dcIO8q+R6ovaWgRSo4yUozRWOuH9a5eI1bG+1XmvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G93voBOu5yyqPy0wLvdJTEzBzl4FMgbOnsNVI82Bp4GG0Lym0JrKLK57QIbN9Ev0+
	 2a9QvclbQ/Fb7rlrqhTNQgOi9s4tOuttd3WCYIoW2z77leQo3f5lAM71m6HD46X4D2
	 /jwmTpi4ZnPTSDgM7KLvjQeK5UYaaGT6XXgbzmb3XeyWi2QJzzyPa3fSLMbLZN97SL
	 DLIo6CtkwTY7LdbcIR83u0GGtMPwQtBrLbKXi6D4HQi9Xe80ZAyiG8g/3FJa/jqIyj
	 mAE5plPcOwjvPyMvx3F1oX/6/+KApPZQjkGX9KrLZXX6UoxEFQM2R0OXYpdwCkUrem
	 YXfo4ODuX0wwg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:42 +0200
Subject: [PATCH v5 07/18] rust: configfs: re-export `configfs_attrs` from
 `configfs` module
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-7-581453124c15@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=J0dcIO8q+R6ovaWgRSo4yUozRWOuH9a5eI1bG+1XmvE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI6R4/sQo6t1ylP+Cdy7ShyHbySRhr5YP0/6
 U8522t06GGJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iOgAKCRDhuBo+eShj
 d/YDD/sGRAPpZ7wgjqskbdog7R7HZgLmq5ybhci7fSz2TMcq28MfDjx5Er8eiKmrl6GxlS3kcCF
 ymK4ZDO8lcKj7OY7qjrr/mpskAxtVXIPrQNhPDzgs5P+I3EVCeIsRdx0X7GfwXiYKHHzT5sGblQ
 vLOQgNB58k/cbNHSG5PeFjPhV3yM1eD4vmGb2cZu5oadDRCN2MYz31ggHuN3mxGdeN9DK/JztPs
 aPv7SzJhPLnTYE8ftUC5lCgE/v+ZfYVbKpxfqBEdZfo54pEBkc018VXHrYLZIlrIKWk0GXMWwnV
 t+V979tio18dfXAPX2TdazPE2BybBFfQZnpMURFg4y9qr4dWqDNqScZvC6XYWjk8Edwu7H2sqE7
 RrJAsSD2WDTWwZjDjA1J1Gn4E/x4A4i3r0D7LdrQGJDUw1UocFp27V/79ljFcqDwNftdc1nKbfT
 48XRAfuKKQi/hhV0NZQejJ2u3cu7bbS0hsKf5s6GVmQaiJ2YRaz/llUV5IEBVizCjOaG1Hx4W5o
 4yIPuSrKxuuHmna0OJiGoupG0pzZy/NYPPMBLBxzrto4/ZrJULL1QyCqEjGdc3FhgoVPYiXjMOK
 Yi8qShcOQDT99J1TApCEYyzgCHXzqDFeYJszB19ybRJAJ2m0GDADiIcuCgCTwpdYzHtSiSU0wpZ
 sDZu3pcxEkXqZSA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Re-export `configfs_attrs` from `configfs` module, so that users can import
the macro from the `configfs` module rather than the root of the `kernel`
crate.

Also update users to import from the new path.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/configfs.rs       | 2 ++
 samples/rust/rust_configfs.rs | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2736b798cdc6..0ca35ca8acb8 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -121,6 +121,8 @@
 use core::cell::UnsafeCell;
 use core::marker::PhantomData;
 
+pub use crate::configfs_attrs;
+
 /// A configfs subsystem.
 ///
 /// This is the top level entrypoint for a configfs hierarchy. To register
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


