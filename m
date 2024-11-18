Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADBC19C560;
	Mon, 18 Nov 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935539; cv=none; b=BD3QxXr7/3egC1S0PVcNGCIHinLhQ1Vp9yHwyp50tOU14V3xxyHLyfkg115kJvLw5DIkNkqy2aYGtEYwwR3xiBp4rKHLotKU4X4hodxRxkrPwKUr8L1LxEPJjTQgH8YxM5Dy4+Zut4cBpLkM2mdOoVE2/9IEvz+kJuFwBePM3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935539; c=relaxed/simple;
	bh=FMYxsf9lW6S6RnGgoIzzxMAtqiexE0hgvQ7nmRbtYa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4w1fLol0A3LPeI4v4YMCh6fXiY0auwBASiO2QN2yagNcInN61oNV3FEoGdZyxoAQf1Ije3S4YjRoieOzO4gohBErtJUiCUQoFw2aJ4dpnvcqR2s2/xKSoElbe9YDTbtRGtV8tLVOrp5bcR0JX3lZLgbzMWku6Pz5Yo6ra2EiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2NdPL96; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2NdPL96"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B1A9C4CEDB;
	Mon, 18 Nov 2024 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731935539;
	bh=FMYxsf9lW6S6RnGgoIzzxMAtqiexE0hgvQ7nmRbtYa0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E2NdPL96N7hBepjMCkhxM0AL2B4PLOEqN/aNFY/y8RRmbP/A+5FH0S/rLekuJuxdh
	 liTgkR9/iTZGaRg0Jatm5CFJ8+N/JwJYQfRlGFtocgsSAo4lPo4u7QBoZdIOYnwGVv
	 1LAQB/142i42wbzxWnyzFsPyFc4u2U9spnTkgrJ1rV/9N7mvrb50WoFQGhzClcNR65
	 J27bSJNi4rltnpHHBbfZgZ0SO9ZdQyK3HNFjUXkobiAi/xpVNTjpK6O5XDZq7fGdVQ
	 BSM81mzWzJ9ed5c5xMPUldmZsjK3FPLPOCco1pWoEtdpTCEVlR1eU1rHL7FIPEF2Pb
	 UPT2JUxHCCgzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0886D49221;
	Mon, 18 Nov 2024 13:12:18 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Mon, 18 Nov 2024 18:42:19 +0530
Subject: [PATCH v2 3/3] rust: macros: simplify Result<()> in function
 returns
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-simplify-result-v2-3-9d280ada516d@iiitd.ac.in>
References: <20241118-simplify-result-v2-0-9d280ada516d@iiitd.ac.in>
In-Reply-To: <20241118-simplify-result-v2-0-9d280ada516d@iiitd.ac.in>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731935537; l=1346;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=kLuPLhtQy03UFJsMApFTqciq/nC1ofEukNt3vnOoNoI=;
 b=KjPfrmtej3yw3CTY13ra2gZyIs0M3OVKKGBxb/WuQ26KVNSQ8jxdoeTy/4O1E/z7OwgmMlaKm
 YHkOTrdtbjeBkAQtbugCM/fRAPIUhlZA5WBglQU13RUz1Og+7nVTHNK
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

Functions foo and bar in doctests return `Result<()>` type. This type
can be simply written as `Result` as default type parameters are unit
`()` and `Error` types. This also keeps the usage of `Result`
consistent.

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


