Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334111AA1F1;
	Mon, 18 Nov 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940620; cv=none; b=VppbnQZJN0f+QPipzL0vUDBpfwoZdEsM9S6+S3LQwZeufK1/4+UiuugNxtsGi+Emv+LvKiAWHYeYljghQfgUOnvbExCb8uv3iJc4Y3GRFxA4sh+sAQyvEDBkodwTnK4ASNgwvYg2z3KZ7ZAAEVQqe7RlGrHYJ+owt7NRml8IjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940620; c=relaxed/simple;
	bh=esoZCnFjx5WNXz3R+iKa+/Xsb1A2fzUIYjufmmrEiV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNNS5d8EoXMAR/VpIu2nMnUpAwawax368gJInh+B/RAJ0q94F2QZvuwzGga5lPQjM/Ie9h4fKJcynA2rlhi3wIP2cEnFglUbHR3T/k7GesF+UxlMfPKK0Ho+Vk49RAmJdkunPseNiCQh3D0sj0JS3HoixrKC/n7f1lWG0HUJBlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKDmux5y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKDmux5y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FDE0C4CED8;
	Mon, 18 Nov 2024 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731940620;
	bh=esoZCnFjx5WNXz3R+iKa+/Xsb1A2fzUIYjufmmrEiV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qKDmux5yljJdb+TlTh/76+1leOXabxj1Z9Fs2HGlwSQUJxpyhGTeKU3fUIoHgVdo5
	 65X9TOG2Cd9jsQ4gbjbsqikkgrEgt2jOMQvFEKCW7OVbYtYdeQuV3p/7DBKeBsyGsI
	 Gi8ed5rO90cPAO5D/B4xtj7YFw4eKt9bNoosUdTNfCSTiaTkZVrYNnyW4nWde7cPxG
	 KxXLBr6l54hQYJfGHE9ZxV5W3xz1xxnN0suJ269f5+a2qdDLDoZb0rkA5AYJMlqMLl
	 1+KArtFvKqv2VXnUiHuwaNSkh1kPTv3DDYKS8OZCQJCFS5+5nk8gyuIohjZozWu67z
	 MvfpnBQJFznEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02449D4922A;
	Mon, 18 Nov 2024 14:37:00 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Mon, 18 Nov 2024 20:06:59 +0530
Subject: [PATCH v3 2/3] rust: uaccess: simplify Result<()> in bytes_add_one
 return
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-simplify-result-v3-2-6b1566a77eab@iiitd.ac.in>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731940618; l=1055;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=fXvE4MWPDfjFqc2bAWbwVy1YZ0cGmhfaa/pikK8HjcQ=;
 b=dhrh/6LCfnO2UT0ozqsoiea4r/886wFuhiNyyVGrEQk7OM3yTE7VnC+d5S+BD0WyItpc+9Ym2
 9oa/fIrsgD8BQ0JeiQ8iANowMjk3Z+XKsMHs9JDXmzRiKXAEEGXMGzz
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

bytes_add_one returns `Result<()>`, a result over unit type. This can be
simplified to `Result` as default type parameters are unit `()` and
`Error` types. Thus keep the usage of `Result` consistent throughout
codebase.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1128
Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
 rust/kernel/uaccess.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 05b0b8d13b10da731af62be03e1c2c13ced3f706..7c21304344ccd943816e38119a5be2ccf8d8e154 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -49,7 +49,7 @@
 /// use kernel::error::Result;
 /// use kernel::uaccess::{UserPtr, UserSlice};
 ///
-/// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result<()> {
+/// fn bytes_add_one(uptr: UserPtr, len: usize) -> Result {
 ///     let (read, mut write) = UserSlice::new(uptr, len).reader_writer();
 ///
 ///     let mut buf = KVec::new();

-- 
2.47.0


