Received: from out-13.smtp.spacemail.com (out-13.smtp.spacemail.com [63.250.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A437F8DB;
	Mon, 29 Jun 2026 03:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782704704; cv=none; b=XDSreQ4L1r5UII6oeiZG8oe4y0aFStXazvDXQRvzA2hJqG3Arn5iIMujKs57hgn76B7wJDb5N9mv9cQ9AtI69FbD08iiWY+O4NKWsXaedswQkKjp3VmINGrDEXvuU9BiQuFK1M1oFu2ppvh9/+jrxETRklT+x+JI8XiRQd+Qcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782704704; c=relaxed/simple;
	bh=w6THCbQamf6kdZbzdipfxMfxxBnDt6WWIJX3uo3xmSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbmKvZuSZLWcE/PKy70yCc6A+NhxViwEtyiDoDtUJjkFJ3ZatCX/SnPkC9RtkndleYuIK3i6YguFp2hhfcXK1V8xP0ARzKx6m77JUKZ0HNLWf0UQksY09/4AcqZZRhHumRhgtJju00/rmUmb8P4527mR4caiSyT60PA5NEtyhRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=jLuXfRzF; arc=none smtp.client-ip=63.250.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="jLuXfRzF"
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gpX7C0rnKz8sb8;
	Mon, 29 Jun 2026 03:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1782704313;
	bh=12kJt+AIgxakapjwIcyF/iXkCRfLwOpvhuLILXfF+08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jLuXfRzFg0qttahpIa6foL6H00Gl811uWp5MQXz4hhf4ExCOOLebSIOqCdH25gaVw
	 w+7wULiJuPP0pOJbMoG87Qr12+sPu2YQhik5HhMucF6ADHFqIgiF/AMyDFIw68+VFc
	 CA1Egal6jqOERY4nl6ozzQKji4gWbczzEdkSlT12vW8pJMzUjxy1lnzG3x1X/G40vm
	 SNgmdhqb1Dp5bANhBGtKi/YQEAQ5KAE5+ukV8d4SRdEUwLriy54prAIUrMjadV7HCG
	 vIFjEdOZpphWzC2dSb3y3Ar7MyN+3fV/bMoREtSa0C0D8aCwCRt+jzHq2XMxS0UVnQ
	 ZGMCXTwwI9+pA==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 28 Jun 2026 20:38:17 -0700
Subject: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
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
 drivers/cpufreq/rcpufreq_dt.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 10106fa13095..6f83cf8955a6 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -6,7 +6,10 @@
     clk::Clk,
     cpu, cpufreq,
     cpumask::CpumaskVar,
-    device::{Core, Device},
+    device::{
+        Core,
+        Device, //
+    },
     error::code::*,
     macros::vtable,
     module_platform_driver, of, opp, platform,

-- 
2.54.0

