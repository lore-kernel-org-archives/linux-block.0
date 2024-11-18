Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443DE19AA5F;
	Mon, 18 Nov 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935539; cv=none; b=k8MENPdS31xH9HCxACe/5ew9UbHZZoVPD9IhNclJSzURgg9Y1Ji0bkfj9ttQBwpEF59ON+3nK/QzxSXWzLOmUod4iXOOQMD9aTGnRojMVsUukTzn6FM052tElF4AMqH5896kfrOKBJorxcJ8Cf69smSfM8RRDS3xVAuKMN3QagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935539; c=relaxed/simple;
	bh=HMy7z0vmYlrGgIkxgA33QHVGMm+yBmfqpLCVJj6m1Uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUMC6wXvtti8tfByj9BofAhB9QSW8jSeTToER5CJ5KmjlvU7Y8VaVeCC7/OTWxFv5iYfGxRMMsnmFBk807Xo2wE0fS+0JPia01q0hq0KzA/DrRHTt9JIUhrDdihv9Nhl+0xPFr50Q2VwXdOfFBkqBkaS7CQKehs4Gq8PbHhdLM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eza5mQId; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eza5mQId"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC6B2C4CED0;
	Mon, 18 Nov 2024 13:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731935538;
	bh=HMy7z0vmYlrGgIkxgA33QHVGMm+yBmfqpLCVJj6m1Uw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Eza5mQIdgWdqiSgZgnmQAkn7mU9Ay++wtU+RNmBq+RHDmtFGlykDRzucakXCeD5zk
	 T7iWUbQkE/gHWKXJGkZ9TGIiDrgngRbC1cQE2MaXXjriTxBT99McC+yegJlnAHuuf8
	 Ed/QPY3hzN7R6u/VwSUOZo3/UDme4yfV2jsyoF7ycBYuDckoYkca7K9JvI4hVNcEdG
	 Jj1cN1j3WGL22J3L2PEtz6zf/+iPOlJc4sM+mQOADYEDT93fqqIz57bo0A1Jz91iis
	 EBD/L6k9puozdYlcC5jwv/g4bVHqjUIr3SbyQCMiSyFeYVrs+EF8lsSa7kUrWavFZE
	 KMOAkgo/sV1oA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C873CD4921C;
	Mon, 18 Nov 2024 13:12:18 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Mon, 18 Nov 2024 18:42:17 +0530
Subject: [PATCH v2 1/3] rust: block: simplify Result<()> in
 validate_block_size return
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-simplify-result-v2-1-9d280ada516d@iiitd.ac.in>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731935537; l=1089;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=mynh6sk8RoVgNyY4+tCv1gPC6C3Qaqxtwv1pM7qKGxI=;
 b=NIq7enWghtGJmPtwMxRPMx2hjBp6cdJYkvGzFhObjXO9HQlM1ll9+VlepGEXfM1RjQ3XekVqW
 34Qzlh1WHo3BzgxH9PeFxze6MJoRyqNIp0cdjdFJPyaTrBCmcuUX5e4
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

`Result` is used in place of `Result<()>` because the default type
parameters are unit `()` and `Error` types, which are automatically
inferred. This patch keeps the usage consistent throughout codebase.

Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
 rust/kernel/block/mq/gen_disk.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 708125dce96a934f32caab44d5e6cff14c4321a9..798c4ae0bdedd58221b5851a630c0e1052e0face 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -45,7 +45,7 @@ pub fn rotational(mut self, rotational: bool) -> Self {
 
     /// Validate block size by verifying that it is between 512 and `PAGE_SIZE`,
     /// and that it is a power of two.
-    fn validate_block_size(size: u32) -> Result<()> {
+    fn validate_block_size(size: u32) -> Result {
         if !(512..=bindings::PAGE_SIZE as u32).contains(&size) || !size.is_power_of_two() {
             Err(error::code::EINVAL)
         } else {

-- 
2.47.0


