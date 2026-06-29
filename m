Received: from out-03.smtp.spacemail.com (out-03.smtp.spacemail.com [63.250.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096CBA3D;
	Mon, 29 Jun 2026 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782704322; cv=none; b=rFDpvQnFikm+juuFIe2OL6wHkdn/iwsC24JKHopojw+dVVarotucQzfMOUZDCD2P825vf0FjzAjvhkXzNzzMswExnZKagaYt/suIVd/d0h7Ewn0HNPmsb4Uw3kQJSAiU+bgwJgfI2eUdF1+iYJ4i3zNSDDrHboDtYY0HQ1y50K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782704322; c=relaxed/simple;
	bh=IFp8KIfJQFaD5SxJ03pX/G7sKzcitokGMS85gqHLheo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pY7d6cTiG4u1WbtgMY/+JHG31B3nBDa8MPOvgxC52IEE+/US6Jynui9dpRLkNKfthADcJVjTYtTqH07tjQIZe3wlLFDaG+dzhcXF+h8bFH4AK4p3YECmgdSqnUaxXAY3aYIMrr17zjX6/0fLNpE2FS6RYE4T+9+P3LTkB2e8Y8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=EhhFE7XY; arc=none smtp.client-ip=63.250.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="EhhFE7XY"
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gpX7H6gmwz8sbG;
	Mon, 29 Jun 2026 03:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1782704318;
	bh=YIeQik7zWpB4jmw4IE+FSK27BQvQ/I/lwKnJtdpPOVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EhhFE7XYbRvohudmbaj4Tj/bf7TsPPwJS6wC8hq61i/uzpkfCPn9O/Sj+E6vte5mI
	 zbnJ9PqzqqaLumWY6B+onwSBNV/N76KtKvpbx7stlcS3fDZ9oMExVWMz38iTcsSWwO
	 w+0ygrtBSeD6V211j4eHZhNCHmNJbZX06k/SLUnRt01sFiEAWtvcBgfdXLpH8y+NxD
	 PuODykExHbQ4D7tovt0GiZQVTfBrDuTvGtLEJhO67v9mO5L9Dk9Ot7WdHsyhsU3HGO
	 Yu1WQEDXN2d6In0WW0QXUi7DPbd9JKlwh78KcnLoxIh/ivkPjwTJJI78IQh07n+xfJ
	 U7tOax9rEkydw==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 28 Jun 2026 20:38:19 -0700
Subject: [PATCH 5/7] net: phy: ax88796b: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-b4-rust-vertical-imports-v1-5-98bc71d4810b@gurudas.dev>
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
 drivers/net/phy/ax88796b_rust.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index 2d24628a4e58..5a21fe09bd62 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -5,7 +5,12 @@
 //!
 //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
 use kernel::{
-    net::phy::{self, reg::C22, DeviceId, Driver},
+    net::phy::{
+        self,
+        reg::C22,
+        DeviceId,
+        Driver, //
+    },
     prelude::*,
     uapi,
 };

-- 
2.54.0

