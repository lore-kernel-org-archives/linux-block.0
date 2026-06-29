Received: from out-21.smtp.spacemail.com (out-21.smtp.spacemail.com [66.29.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B2637F73C;
	Mon, 29 Jun 2026 03:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.29.159.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782704705; cv=none; b=D3Z8vWgXvT6KA7ZvxoTLPujpj4zPZVOTCvgs1Ft+t5axmiy4YozgFjwIStLoxoOqrfj70hU6NVpEGv7bRS6pIpRKKAdmFmoF3h8GdgP1HuVp7dOsC4OhDuX4VDnpD1yKuPYA1zoF+tDxZ3pMVXediBzHGu28ycA2QldeZYjzxGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782704705; c=relaxed/simple;
	bh=cm24XvW/F4GoTflvWfzGJPlAEitmGS5RvymfGbSDfIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oUah96jJqfybnO3OV3iWOR0nhVlVF3a2e8AAA52YRiOnkQigR7w5z5NGHphOkHe6FqA3FrnkowwpTDsji03GavEP39iEoQ//X4Lwbhka/JaHThKt8Krh9OK1pkG+KEFv1UGDGc4N1qkCG0UnSKHOg554oKNPj0Dw4EoIX15DdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=Wn/fpinj; arc=none smtp.client-ip=66.29.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="Wn/fpinj"
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gpX7F3RH8z8sbD;
	Mon, 29 Jun 2026 03:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1782704315;
	bh=+xTdES5iivUlujAb8S85lcbvOQK1iknw8m7NM0ttyH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wn/fpinj+vbdRtvql+K6l/cdD/IQuxl+e8wa5bMUwtZjuwKBolSQ7MPAy/E7r34Vm
	 JlNz056v097vPX0LzLgdqw2ChkZM2e+fJk8P/tSAAd2maOeMGg8lIAZF85c2zvHBDu
	 VvjXDXzHnPpQjWCS+ByzEU1aJQsXP4SMkbdEEHVqG1BkAeoV2x9WC0P0K0Z+MjYOjS
	 au8gLtLRrapdakIsP6VjyV1XxDwH+fWg+f5WXQGK+fiJCCeuiHfvVAww/GogX62e5/
	 gE9EB44qcxIf7szuf9P8Mfi3D550P367GBwwZjyXTtADMoUywMT2GZh/cupjmsZoPi
	 3qRa8ft7LLoJA==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 28 Jun 2026 20:38:18 -0700
Subject: [PATCH 4/7] block: rnull: use vertical import style
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-b4-rust-vertical-imports-v1-4-98bc71d4810b@gurudas.dev>
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
 drivers/block/rnull/configfs.rs | 20 ++++++++++++++++----
 drivers/block/rnull/rnull.rs    | 13 ++++++++++---
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 7c2eb5c0b722..07ce21a44081 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -2,14 +2,26 @@
 
 use super::{NullBlkDevice, THIS_MODULE};
 use kernel::{
-    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
-    configfs::{self, AttributeOperations},
+    block::mq::gen_disk::{
+        GenDisk,
+        GenDiskBuilder, //
+    },
+    configfs::{
+        self,
+        AttributeOperations, //
+    },
     configfs_attrs,
-    fmt::{self, Write as _},
+    fmt::{
+        self,
+        Write as _, //
+    },
     new_mutex,
     page::PAGE_SIZE,
     prelude::*,
-    str::{kstrtobool_bytes, CString},
+    str::{
+        kstrtobool_bytes,
+        CString, //
+    },
     sync::Mutex,
 };
 
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715febe8..d58d2c4c5f63 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -10,12 +10,19 @@
         self,
         mq::{
             self,
-            gen_disk::{self, GenDisk},
-            Operations, TagSet,
+            gen_disk::{
+                self,
+                GenDisk, //
+            },
+            Operations,
+            TagSet, //
         },
     },
     prelude::*,
-    sync::{aref::ARef, Arc},
+    sync::{
+        aref::ARef,
+        Arc, //
+    },
 };
 
 module! {

-- 
2.54.0

