Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB21B6CFC;
	Mon, 18 Nov 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940620; cv=none; b=Y9W0Qv7U//cd7c9cPFzpn5gBPh99b/I1NiFzcIujWPyfargG3OnxfYwGNcdXuwg3WHFkvxGk6DsWCZK8ub/hTHL/f+zLmE3kegUPcjPyvAd7L5ED/wZlMW4TqSUiDnS6UR0GkZB7RWCS5dplFrluJ7Gpg+o7IrLo5z2G8XJWZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940620; c=relaxed/simple;
	bh=1C5xQW7WAmLfa3yWt5eppmcy13VdQvDCpoa+yQ2xw68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYWxqpq3/mclCj6dn5dX9iafTBsRoKAeF4C4HC8cB4rnoB51RDJtMqgVZ/p0ZwP5c2QVHGk8n8Ob/EQbRCmgTsqL+CQ+qR2OGXcWYLVlpUhmwAjPr7Wbay4T06s5aVxcgV8raPG9eETOR7bwY5T+Dfq9Cl6qLOsjqqLWTNaDHEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTlrgu1h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTlrgu1h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2786CC4CEDE;
	Mon, 18 Nov 2024 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731940620;
	bh=1C5xQW7WAmLfa3yWt5eppmcy13VdQvDCpoa+yQ2xw68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RTlrgu1hpr0/ND4l7SsMNABskDLfpGcS364kqlO/5OBKd1RcpIZ48p3OZNiuigYtt
	 U5yy5Wz3Q1lhjHM0GlU9GyDEZU0ft6hswf51WqE0O50u+U4m0d16D+EZaTDJXTfRLG
	 2TzMNfoU/KiCklIqDYEv5hHDQCYLCmD6aQk+XuLJbyNmjIBlNHJqJbZXQNs/u0O0R2
	 XbCZT8z5/haCskqctngH/STuOd9yOkepJn7dT0jaYv31oqkF1ZoUjXikhda+x+2vVP
	 RYhgpJ6vlJApVR3YJ0t1l5QXZtPTAx70gD2unxtxptNdCnkdZyXpRICId9zttt+Oc/
	 3Uvym7zbWBfJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EBFD4922D;
	Mon, 18 Nov 2024 14:37:00 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Mon, 18 Nov 2024 20:07:00 +0530
Subject: [PATCH v3 3/3] rust: macros: simplify Result<()> in function
 returns
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-simplify-result-v3-3-6b1566a77eab@iiitd.ac.in>
References: <20241118-simplify-result-v3-0-6b1566a77eab@iiitd.ac.in>
In-Reply-To: <20241118-simplify-result-v3-0-6b1566a77eab@iiitd.ac.in>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731940618; l=1445;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=NTTuXPWy5AUeqCEPojOUwO8gX5t/CAh+3ZZpchSjGSw=;
 b=TvZk+POq6esMzkJ39tL4CXbkwnxgKtAKjrW1VbhsNzlmzrcikgodE1xGSsj5SBJ+2ZWv8+42z
 ALzxsGbc1aoAJxPiSudyRmYmI22IvW9BpJV5IlEEHGn2VbgFrdfC6y+
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

Functions foo and bar in doctests return `Result<()>` type. This type
can be simply written as `Result` as default type parameters are unit
`()` and `Error` types. Thus keep the usage of `Result` consistent.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1128
Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
 rust/macros/lib.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 4ab94e44adfe3206faad159e81417ea41a35815b..463920353ca9c408f5d69e2626c13a173bae98d7 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -144,11 +144,11 @@ pub fn module(ts: TokenStream) -> TokenStream {
 /// // Declares a `#[vtable]` trait
 /// #[vtable]
 /// pub trait Operations: Send + Sync + Sized {
-///     fn foo(&self) -> Result<()> {
+///     fn foo(&self) -> Result {
 ///         kernel::build_error(VTABLE_DEFAULT_ERROR)
 ///     }
 ///
-///     fn bar(&self) -> Result<()> {
+///     fn bar(&self) -> Result {
 ///         kernel::build_error(VTABLE_DEFAULT_ERROR)
 ///     }
 /// }
@@ -158,7 +158,7 @@ pub fn module(ts: TokenStream) -> TokenStream {
 /// // Implements the `#[vtable]` trait
 /// #[vtable]
 /// impl Operations for Foo {
-///     fn foo(&self) -> Result<()> {
+///     fn foo(&self) -> Result {
 /// #        Err(EINVAL)
 ///         // ...
 ///     }

-- 
2.47.0


