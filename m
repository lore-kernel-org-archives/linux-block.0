Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F71A9B3D;
	Mon, 18 Nov 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940620; cv=none; b=dRpv9kUORVDMCpOS3KFgq3dbMv/ItzhK+q+pqv0qNV0iFoZGvWtIIb8E9A4REIBjzwyfm5uUy8Vb50YydfypxDs7Ang3PTcgbql26odXblHkKpWpsP98YlpZCRFNXY+o7sxfwijHOpSu47+pErEiWGGbAcyyqKQrymTtSs5dqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940620; c=relaxed/simple;
	bh=QHseiXY+gfW1EiR35D5KxqOHqK4eeKBQcxrZQPzLitA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bTKCf961XOzVbW/qq/NCsb7uslcvaDQAdNiZ5HHdNAwbIJKmqYu/6gw/Juq9PqbjRAOKG6OCA7ofnL8JUFhzm5lFjQA3vT9dDbabXq1My9S9FKbzhIip8bMEtzoXW8X9SV5liECOdzcbgi5JM02WfrcUWqVgckH5FmmD/o2MUu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMYtyzwm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMYtyzwm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA282C4CECC;
	Mon, 18 Nov 2024 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731940619;
	bh=QHseiXY+gfW1EiR35D5KxqOHqK4eeKBQcxrZQPzLitA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WMYtyzwmiZxR6Em5Picamrf4v7K5P+OdLx8yxrU1zmI27BeugqZF8Pjp2uro7Rt/C
	 piyPGFlVlBMhxnEb/oeeKOIGAZQcVyLqV+LmiA2CEGkmIFrS2V8/abgGtlEamP7i45
	 Ic43BxCdPVhR6dV+cQc5ieI27cYJWcJ5p0yPCVlVsb4jeVYU3lRW8gdRtlvSDDR1Oe
	 iZ1n+Ecv1Sgg4KWcq2eR2fmRqPCA5KIt584nrxTlnPq8xT5S6QI0Kf/ZKHmH+IYnQf
	 LjJz7Ush0JMCZg2HRfiIthOJt7GbYyZo3oGiXi61re5O/qCMT2H1sDWILHQyROzNwg
	 bEtSOoeJ2hxPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC74ED49228;
	Mon, 18 Nov 2024 14:36:59 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Subject: [PATCH v3 0/3] rust: simplify Result<()> uses
Date: Mon, 18 Nov 2024 20:06:57 +0530
Message-Id: <20241118-simplify-result-v3-0-6b1566a77eab@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAlRO2cC/3XNQQ6CMBCF4auQrh3SKYLUlfcwLkpbZBIE0tZGQ
 ri7hZXGuPxfMt8szFtH1rNztjBnI3kahxTFIWO6U8PdApnUTHBxRMQTeHpMPbUzOOuffQCtjKx
 VyyXXkqWrydmWXrt4vaXuyIfRzfuDiNv634oICGXDsTGi4KpqLkQUTK50TgPbtCg+hfpXEMBBG
 lFzZVSJlfkW1nV9A8Na983yAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731940618; l=1260;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=QHseiXY+gfW1EiR35D5KxqOHqK4eeKBQcxrZQPzLitA=;
 b=s2Lr7AgQs25d0IvfDjJKsibL0zs8oJ2YK5AHcKdytvGp7n1aGMrCGAuQVem9QwVc13EGdycYI
 hZaY8R/tP5rCbgqqMYIWtb64UcS2AO+vcvLbYO3kPWYkKBZxYBkUkrg
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
Changes in v3:
- Add Link: and Suggested-by: tags in all three commit messages
- Edit in imperative tense for commit messages
- Link to v2: https://lore.kernel.org/r/20241118-simplify-result-v2-0-9d280ada516d@iiitd.ac.in

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


