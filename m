Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EC1B4F25;
	Mon, 18 Nov 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940620; cv=none; b=KLs1DqCZphnxTTttqsDHR0/nPo21PnVfeW9HEsv0tY3XcCcU5E7bx+Bx44zw9aYwlt3r6RFRPB4RQfF3d/JoJ9DPeHJk+LhpZDzg9ao9sc9OqVBRlkMT7V6DmFB8nk9AD/c6K3/cs/+lOeoI9tGovlKqpG6lOQllMWCW1O7wAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940620; c=relaxed/simple;
	bh=F3SnLMn8Ir7Upg1k1br1UqesekB98aJ+5NfcgwfnNzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQDmAiwtIkChyRVGUp86Ui6wV/31WAI1atdtbsKbyRlLIvTIsQAvzQJJzrqKTfk2mnwuJKZiR4/5Dwd8YnNMGvjwpIkKVpZksejK5UI293VqgpXgqVK0EuVyxJ3HW3PvVOjNfukTAOQnMU3+CiKKtAPzaJ9Pkz+ifxKfaEOtVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNgUhIWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNgUhIWi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F33D4C4CED7;
	Mon, 18 Nov 2024 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731940620;
	bh=F3SnLMn8Ir7Upg1k1br1UqesekB98aJ+5NfcgwfnNzE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iNgUhIWiijrBt01dIKmRRbcCM3LXVfUa8kBYpMIhqtp3joXCotTdTVfE0B/er/YlN
	 m+QpkrkFLQUpUAFQteGUZxlpmfGG23ff5ACRKstA9b8i+o8X8axH4FM5oVZXnWT2L2
	 a+/P9rGr/MIQqztPIkcWtXFpw0zklL9cIRGav3hjahTzoVBXSgyrYTLGdf5Lr1q+3a
	 bLfuKayuwkyafU2ySj1rf/qVqKFf3TIn6GTBYj9ArWmVMbJwg14o9NNLpo8DT3/STr
	 4Tmu0en6oms1uA4J2vlU/IL58jPbQrKGCMqCzH8I33iCK2OfZp3za9q26DTx8HRKmp
	 0+uuYL7LPcMOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18BAD4921D;
	Mon, 18 Nov 2024 14:36:59 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Mon, 18 Nov 2024 20:06:58 +0530
Subject: [PATCH v3 1/3] rust: block: simplify Result<()> in
 validate_block_size return
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-simplify-result-v3-1-6b1566a77eab@iiitd.ac.in>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731940618; l=1188;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=SjEoEAw4QthSgW06VVqrPjPqp4OFSw3Gjp5nrbE0RAU=;
 b=A/Mb8qo7Qi7OcYvRPjGPtfsA0qTx3z8eiNe0JuAYfi+2Rbz/Gr8wY65BMN1YbqOcIy8K0CH5v
 +IhxvUu7D4BCvgatpit1szrB6fHrzoXC9w5hIyQ4Jx7vcN2djHlwat+
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

`Result` is used in place of `Result<()>` because the default type
parameters are unit `()` and `Error` types, which are automatically
inferred. Thus keep the usage consistent throughout codebase.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1128
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


