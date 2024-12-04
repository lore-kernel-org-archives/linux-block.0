Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198A1990C4;
	Wed,  4 Dec 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301939; cv=none; b=fxutrGNlXD7xTQWPN8ygyciv76Ve8TkU+57Pl659h9u0Mmuve/M2RCI/eqZ8OTC+BQHwVnL2mR4jbsurUreGGmmk8s6dFwL218RQfB0Hw7/XC9QcUaP7HEPq5RhS9eZmxHyhjvqpP0sFWFl1duSx8jQRQhnMEd0EpsFmQp3i9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301939; c=relaxed/simple;
	bh=cxBWfMZH2U+jwIDZvQvJEXLqWIblgWr8+ybOCIolbnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iqCfdbCDvdX5gAhtrbLAt1OCMXMPrW7rVOsfHaskPq9qwKnncgfuPl1W3EDlEp/alK8qGDg2TEm8k6/I0rvt2ALWRcqjszZnmJDUDk32sl8AtpWI95BoLHh1maTzdWrZ+G+A/SK/X92kGVIKd3SFsvKjrgW+mFkB6M6px5GtAc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dugarreau.fr; spf=none smtp.mailfrom=dugarreau.fr; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dugarreau.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dugarreau.fr
Received: from [127.0.1.1] ([185.116.133.150]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M1IRY-1tLW5B02fK-00CGAz; Wed, 04 Dec 2024 09:40:03 +0100
From: =?utf-8?q?Beno=C3=AEt_du_Garreau?= <benoit@dugarreau.fr>
Date: Wed, 04 Dec 2024 09:38:39 +0100
Subject: [PATCH] block: rnull: Initialize the module in place
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241204-rnull_in_place-v1-1-efe3eafac9fb@dugarreau.fr>
X-B4-Tracking: v=1; b=H4sIAA4VUGcC/zXM0QrCMAxA0V8ZebaQtRPFXxEZbZdtgRJHOkUY+
 3fjwMfzcO8GlZSpwq3ZQOnNlZ9iaE8N5DnKRI4HM3j0XesxOJVXKT1Lv5SYyZ0J0yUM14CYwaJ
 FaeTPMbw/zClWckmj5Pm3+Xc24BX2/Que9xuTgAAAAA==
X-Change-ID: 20241203-rnull_in_place-5e0b73d8300c
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_du_Garreau?= <benoit@dugarreau.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733301602; l=2218;
 i=benoit@dugarreau.fr; s=20241203; h=from:subject:message-id;
 bh=cxBWfMZH2U+jwIDZvQvJEXLqWIblgWr8+ybOCIolbnc=;
 b=+hLAeDCGQO4R2Of+/EAJ8WlTlZvIWp6dmrjrTOXGwjmFyMSxS1/HN+XeuTDv6ZRacpw3rbFCj
 ymEpD2FdCI3Dw6DfvNbh7MRlIUVg2lE1AUCvKuOPV/2jHV+klaQHUzA
X-Developer-Key: i=benoit@dugarreau.fr; a=ed25519;
 pk=l4tCZw3UpEkwtwhwsl5BV1HlPvHlXLQQRh96sL21/FU=
X-Provags-ID: V03:K1:z91Ow9ERORgj5fKYQthmbNT+6lMCY18u9hLuV/E5/6LtiMa4kk4
 Wf0CXcNkh4cIajEQC8M//B96h5ZFxQgVV05hyJQBSEjqaGX1rW534aHVOVkfaK5t1WAYRsy
 cnpJGT0zy2DESxKG7j4vy4JozRvow6GF0xGLUmD4N2NvI6VzbB28xXsv1y+yQBzkuk1mGNQ
 fgr7NQV81+lgXtbcjZ/aw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/6RFLwCjgX8=;d84qXBJWLhfQt80OPCIh+zxgg+M
 M6Nv0N+L+GG0waOM00OTFLldTlBKm6+eLpJeepFlDW7pN24TRw59GzlMiSww58WGiGxbV8eg+
 wNm+DWbcg0J+tgeL7nmxQqEohtBHXZpEx7FnV9DPnvg69hkvzmBWnVJ6Ze/X4HPBkhJeyi+xA
 cZWEb/LF4Vw18NjUVAhzPG33wF6btEzgqkhF9uGlQl3HGaXEuc5PEm4lMvZegwy+TslhvC79a
 GqRpWp+7+zUbohGeqQKb52yltN/kRacOtGlLVpTpLGJWxKqPcD7fj1fo5SwVqCkaaBKnve6nZ
 bMLYtDgEdVFCxtzc8zhTOQAMcWZu2qsJod2sEii2kVW3hroLfXyhJV+yLEMmrdc6/Kn4JgeaZ
 eIhY/glpwJtukb05JH6y4oQD7ZQSoOOx4yjhD+FwgPIKG5cx36Wcymwzhu14WDGb4jQNbA08O
 HsL+m/5vsCYGoxj0LI+0Ed7X3X8CHeUidQXN8ZCvoqnWvPDrIPbRzkzXe76kz3HDIL+LIEvgL
 1nnV4Nz+53k5QEoTUlihezzBWJD2oMY+7+AYwJ59vug6lO3zMF7yojLsEjWQOON5Y3l1RZT8Q
 TPtMVve/wJJO7gz56ExFitPMNY6CLthRm3hPCZOvmADVU16nTMbIR8xZgytFsLU6hpaUrXKJ2
 FZaDWG1jEUI08NHOx4Sd9DkcTFsEc56XbKHygtX8cY+KJv93Hh4Z3o4rEbQQ0dxT3AMTtMD5z
 h3Rapi1BICvqXRHRYAEYcsHMdQo7vxIg7rIdoQSaB3LUfA6lktGXLss+osaTNPFWq7FUr+1Ib
 32CPdyQCqtFUJp5RnymurtjPGwp1xcloeoHo4xbcVmVIcSWQriMmJERaxqNzXWmqwnYs0SokP
 ZMdVjLYx/+vTjBLAfZboWHGbGvuR2nAcBUp9abo3DV5C//51Eo9FPKqN81AjJ9kQW+9ASFJP+
 wyiqHOmFtaHaUJYln1/5w+aLOeCuw08wB7LZidz8xQUvFk+qMsBtkDxkO5I1Why/gCrGMoyl5
 XT/NpeEhS9KZ/VO8HPYaw3vJuia5FJnvdDr6DyG

Using `InPlaceModule` avoids an allocation and an indirection.

Signed-off-by: Benoît du Garreau <benoit@dugarreau.fr>
---
 drivers/block/rnull.rs | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index 5de7223beb4d5b4224010c86fca826967a019c27..6cdd2589c4621369cd57af66a2b817889321ed15 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -31,25 +31,31 @@
     license: "GPL v2",
 }
 
+#[pin_data]
 struct NullBlkModule {
-    _disk: Pin<KBox<Mutex<GenDisk<NullBlkDevice>>>>,
+    #[pin]
+    _disk: Mutex<GenDisk<NullBlkDevice>>,
 }
 
-impl kernel::Module for NullBlkModule {
-    fn init(_module: &'static ThisModule) -> Result<Self> {
+impl kernel::InPlaceModule for NullBlkModule {
+    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         pr_info!("Rust null_blk loaded\n");
-        let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
 
-        let disk = gen_disk::GenDiskBuilder::new()
-            .capacity_sectors(4096 << 11)
-            .logical_block_size(4096)?
-            .physical_block_size(4096)?
-            .rotational(false)
-            .build(format_args!("rnullb{}", 0), tagset)?;
+        // Use a immediately-called closure as a stable `try` block
+        let disk = /* try */ (|| {
+            let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
 
-        let disk = KBox::pin_init(new_mutex!(disk, "nullb:disk"), flags::GFP_KERNEL)?;
+            gen_disk::GenDiskBuilder::new()
+                .capacity_sectors(4096 << 11)
+                .logical_block_size(4096)?
+                .physical_block_size(4096)?
+                .rotational(false)
+                .build(format_args!("rnullb{}", 0), tagset)
+        })();
 
-        Ok(Self { _disk: disk })
+        try_pin_init!(Self {
+            _disk <- new_mutex!(disk?, "nullb:disk"),
+        })
     }
 }
 

---
base-commit: 4d6f8ba6e0a7b0627b4a559747948ee0d6797a3a
change-id: 20241203-rnull_in_place-5e0b73d8300c

Best regards,
-- 
Benoît du Garreau <benoit@dugarreau.fr>

