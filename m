Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448819AD7E;
	Mon, 18 Nov 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935539; cv=none; b=TIqo3OKMK9NBAxdNHsBi5LG5faBE6xrHmR3I4HcXm33SS4xp2kVIBVS57vTxT6CfAsY/TzrFvTPhSOV6NKDSLx1rxlALuFtpV8sV/5RydiRvz0bA4CHCPFhjlh0DUT+DkDAlMnRLc8y9Jv3ehqfMXB+4ik1chPhaNGY9iu5TmJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935539; c=relaxed/simple;
	bh=fbxklw6aYSFwowHXbk2xxPrEWuhXoyAWAQ3wJtxtslU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIGu3/MbWfG1YwVjOreSkGmsPxdZpQieMw1dDjN0ri7HBD4d4nEwA81hzVErpoa1qpYwPGY6QcShaCxSiA6FXBft0gQHmsCB8lwV/665bdw6kyypzWb0QrjvFeSAwUoYoGI5l5pNtv/pKyjjjceFFGJ/FjDY9B+IRyQ7sAUBEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azbguS5P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azbguS5P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECF98C4CED9;
	Mon, 18 Nov 2024 13:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731935539;
	bh=fbxklw6aYSFwowHXbk2xxPrEWuhXoyAWAQ3wJtxtslU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=azbguS5PkfJqvqqyN2fPQ9+XWrAk3kex7MpVv+e2XZl7qpAyHgx0Ag2A4L4eAVQnr
	 ncDtSxArVdO7swAyLEda9B8d+B0m3+P7Ua6T7E3rlOcDi3Gd/7gjPBxTIyE3wguOzH
	 OTioO3Niqa+UJj3cTvss7a2HCCkbRXjXyOKKHtywxUd3CSM2r5vCX29C+UGpEBwJys
	 7+l9nsgCrK4q5xu+Xangyux4XdIymkUKu+kNVXtb468j93sFz0z5D27YO0cZcYfZ/9
	 RLJFwdc1HY/BJ4cbQAk7/oGIJCLd4YY49N6CDoag8JK91/l2A0QHeT0hZgNYWQIL3m
	 mYft9JFfbuS+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAE2D49220;
	Mon, 18 Nov 2024 13:12:18 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Mon, 18 Nov 2024 18:42:18 +0530
Subject: [PATCH v2 2/3] rust: uaccess: simplify Result<()> in bytes_add_one
 return
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-simplify-result-v2-2-9d280ada516d@iiitd.ac.in>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731935537; l=955;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=9Gxv/qHfLswgJdVyXaRQDKJONyKmoZBo4nn1UwfQens=;
 b=A5WVxANHl42qVjTQgMaEs5OYWJIBBaH9cgMmLGXCsJ9ige2U8lYYSyX2IbGox9gSvQHKMyX5R
 3+t4PGCl1GUDaXF8F3kCvDSG8Hu424BhRq1xeeRS0eiwMOLqJvUpqJK
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

bytes_add_one returns `Result<()>`, a result over unit type. This can be
simplified to `Result` as default type parameters are unit `()` and
`Error` types. This also keeps the usage of `Result` consistent
throughout codebase.

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


