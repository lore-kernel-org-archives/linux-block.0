Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443919ABCB;
	Mon, 18 Nov 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935539; cv=none; b=BPGw8fHRyQ+AcTVpb/yfMXDoOia5RkZvw8adY2T4+RoMdx20yn1O9enzjaGSc3G+L0qyDY38DmriiVQyex/yyA9QCiVCDeKyZ6D5kqp92vduhje7zQkrGQKyfHKb2PCtdo2bFnAhBPQAxSDdG+JThHdHgvNtZ4IpUvFmbLinm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935539; c=relaxed/simple;
	bh=WmVgkz0KTZN8na8N+JVCaFWKKPWLYbasqjQVdB8DB5U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y6a9qV5fjfBE47cmAh9QtKYyWlQdY8elPlweZ9la83AbVrarzx1vRZl2cac7s7UkOhTJ3uJMF2Fnu9rpa00FJcSnIhZrKxNyFkr91VWm7Fc5HyjYZ4QLZXjs3hkQW1PmQJkCOZA77gTIYLI3Gk8QZ+evwbEAKCCVOV00Pl5Uhho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP/qL+2l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP/qL+2l"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C70A8C4CECC;
	Mon, 18 Nov 2024 13:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731935538;
	bh=WmVgkz0KTZN8na8N+JVCaFWKKPWLYbasqjQVdB8DB5U=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LP/qL+2lfi/zbVVNNr0bAj+T1gDAnDi1DBew1sI7oiWN5BAK8sZY0l65P5HhilE/C
	 5hAz+KafY56n3VNWSz/XYyg8JIgAUZjoFCg1AmHEn43dDwHoZeGB8EsJXSS1ZzvCTy
	 XqLguAAewLyTm+EcXLACOZF5+S/+4Wx0ZbQPv8zVgMUtg432RYo4kStZvTZDYuWpg6
	 OaE5MmAXoSB0PPWnP3Ju2URFP/9MQ08i6KT4JgNLvEA+X95JmiPbcYLdiW3XKPZq33
	 R6ZE0SWQdF8UzUc1PEUPU/k8GFMsinLHPa3FLEmlQcOeTTPAZ8OxeASsLeK9dVy2nk
	 9+wyGMb1ZiPiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06C2D4921D;
	Mon, 18 Nov 2024 13:12:18 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Subject: [PATCH v2 0/3] rust: simplify Result<()> uses
Date: Mon, 18 Nov 2024 18:42:16 +0530
Message-Id: <20241118-simplify-result-v2-0-9d280ada516d@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADA9O2cC/3WNOw6DMBAFr4K2jpHX+Zoq94go/A0rEUC2YwUh3
 z0OfcoZ6c3bILpALkLXbBBcpkjzVEEcGjCDmp6Oka0MgosTIl5ZpNcykl9ZcPE9JmaUlTflueR
 GQl0twXn67MVHX3mgmOaw7gcZf/Z/KyNDdtYctRVHri76TkTJtsq0NEFfSvkC3CcBmbAAAAA=
X-Change-ID: 20241117-simplify-result-cad98af090c9
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731935537; l=1033;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=WmVgkz0KTZN8na8N+JVCaFWKKPWLYbasqjQVdB8DB5U=;
 b=W00j64SL9Dv1dPccbNFTCfQ84f/jDzQt98GYrhDhY0xUqx+f7zICm4a6ZSQ3LBA6Y8J51Kc8A
 cPZHxJjjyADDedbj0d7qJIBqoPCG3Z0/5kyJlzuBkArhquRYEAjYfYg
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
Changes in v2:
- rust: split patches according to various subsystems
- rust: add rationale for change
- qt2025: removed qt2025 patch from this series and sent it separately
  to netdev subsystem
  Link to qt2025 patch:
  https://lore.kernel.org/netdev/20241118-simplify-result-qt2025-v1-1-f2d9cef17fca@iiitd.ac.in/
- Link to v1: https://lore.kernel.org/r/20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in

---
Manas (3):
      rust: block: simplify Result<()> in validate_block_size return
      rust: uaccess: simplify Result<()> in bytes_add_one return
      rust: macros: simplify Result<()> in function returns

 rust/kernel/block/mq/gen_disk.rs | 2 +-
 rust/kernel/uaccess.rs           | 2 +-
 rust/macros/lib.rs               | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
change-id: 20241117-simplify-result-cad98af090c9

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>


