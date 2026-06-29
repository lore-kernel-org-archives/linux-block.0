Received: from out-13.smtp.spacemail.com (out-13.smtp.spacemail.com [63.250.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB137FF54;
	Mon, 29 Jun 2026 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782704324; cv=none; b=M26U9jQJlopJF+Y0fAh+TZl93BW8tTe1LSAxRiwR1xK4zV5NUVxGihXqFEAf8ze+rJ+Uzth4+ACImXyE2kHBCB34vLBtFLQvdfiDQjGLNEqfVoV1PEyzmaDSZwEiiKuz1n3r0lZw3FNRLj0ApwlmT9cvpx6oyPJIEyz9Xd787nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782704324; c=relaxed/simple;
	bh=thiPY5S+QBxellP5Uj9DdCyEm46ESuaHvrW+lWMbg0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OkGziMn3MafLjr1BYlSBZtf2V74n0bngrWbJGLoPNOLotkOT+jscl2SQVWFbmKHzW1yB+6SLuaMBrgGf5JoiMhNNKYmbBTHP3TtLIXxh6JstgTcf9HUKm3lQGNQ9U9i+cgN08cnHEv4YWhoYhIWEDE5wMzmiX9I29sbVzY3OT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=YKtNGdPN; arc=none smtp.client-ip=63.250.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="YKtNGdPN"
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gpX7L3L2qz8sbh;
	Mon, 29 Jun 2026 03:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1782704321;
	bh=YS27Kixvby6KSWXTt2w35oH9jMdFGUOYAotvdtSmrSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YKtNGdPNllSWHUf29xTf+H/qJRGsTx9ge6T579+WgPUypUW5v6y3OJtqWs9HWUTiV
	 zbhlllaRoZxWjota9YxkLFCLGUnaZSNXbEHfDHKvUTG+CT7vASnJUFZVfv57AR/Ec4
	 Fd5+G/+P+UUSqhj8+IT43fw3bELljdvhSncYSiDIFxwhmV9y+Otp+AcMqSGLXXXdl4
	 1p0/vY7R4zmYhlP/s+8tmuFG4M0xvDXSzDQZQqw1SNiukkScPwDdbYFoBIAx57yRsb
	 A4UBNbrxuI8Ovx4rFMv+ZAmaWs7neivc5ZH3vRpkCpGXtKUUb1OEKNc3Z5hcESrTNF
	 WpS5rTL2gqnAw==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 28 Jun 2026 20:38:20 -0700
Subject: [PATCH 6/7] net: phy: qt2025: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-b4-rust-vertical-imports-v1-6-98bc71d4810b@gurudas.dev>
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
To: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 driver-core@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-block@vger.kernel.org, netdev@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 drivers/net/phy/qt2025.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 470d89a0ac00..efde3f909367 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -14,11 +14,17 @@
 use kernel::io::poll::read_poll_timeout;
 use kernel::net::phy::{
     self,
-    reg::{Mmd, C45},
+    reg::{
+        Mmd,
+        C45, //
+    },
     Driver,
 };
 use kernel::prelude::*;
-use kernel::sizes::{SZ_16K, SZ_8K};
+use kernel::sizes::{
+    SZ_16K,
+    SZ_8K, //
+};
 use kernel::time::Delta;
 
 kernel::module_phy_driver! {

-- 
2.54.0

