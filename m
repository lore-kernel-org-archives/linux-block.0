Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65F18EFEC;
	Mon, 30 Sep 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695898; cv=none; b=G7RCb659i0pl6xONYYGn+vx2DK+6jUlSI1XzmJA74jivcqSMFWuEcpKnmjmVBgJlfb8Z45GdaYovP4BYhN1HKStHfCy51yHCrbxHufB53HwaM4omAK+Bz5XDThPKR+OjuVEoiayrHR4ETuVXfgEr5P1Md7JLAx/GoyWDMBADxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695898; c=relaxed/simple;
	bh=XY9CIJRo4kERP1f7gzDDtLEj6FCWJeCQbDTSD4GQKRc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Adneu0dS6i6/mrWo/B5ymE35ZSBYlsStQ74p2nghr5yxFnPeo08FUjmBw/YuD2RxGZHcBbb6dhZ7umfQpnGHHZqsb5VWlDLC4BHbaqDHqVVfmZrXAqbQ7V2kout5WgxIyb9UzWE8bAEOsGVZVvjrlj6cMyYyebquiPahNbNRPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKZo/KvB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKZo/KvB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e5e758093so33658845e9.1;
        Mon, 30 Sep 2024 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727695895; x=1728300695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOC+2wly8ftj8TAYNwXd5GnLMEEgJdboLyIbx9/Qeyc=;
        b=BKZo/KvB4pNksTAK45cGhy9kpW79zkZnUua0Np2Jn9Tu+gv2tpsBSgwezaZoDnWJL5
         nblm/0f0P2TYXqNS84ILG5Cz9Iub/wWmEeS+UhYWA2YhGaoIrlxEmXZRu2fVqFi8iGK6
         3JwMWuovZrxJt/JyItLQkBcKyQB3H/ioDHpNJkX+qbwgPITEsTJvr/Mme6Suo+tuV4z1
         mJfcy+/tz+abOi3CqbuFGrgFZfpzgBjhnvprYeFrOAJ5vAwwPVgxeMm4HD0VYlmJkrlb
         8C7hm4i0bMrUmHZFTLlSdLxmQSqYJLBHG9MVPdtM0b51tNHne24nezEAnzuLZqF2m1F7
         KqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727695895; x=1728300695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOC+2wly8ftj8TAYNwXd5GnLMEEgJdboLyIbx9/Qeyc=;
        b=FL6SEbqFc/d2hP8QuZMDRb2gcBfrKpjWwrBm1gZX/WOEnWHsj50HI4A9wvAvd8mPoZ
         4+jHxbSnj05YbM9IcP5TXKKDzucYrCoNl4w85BYGM/265zCRUUs3gE1cmXBmyKssCHa8
         DCPXXhBrZtGiOQZrLyA8CQOX0bSEfpLVCjRFu4HZgJqalLSPpHk+GBn0BQVVzrgXoejD
         XiQx0XBKRAMaxxgn69ttAt0nl4qTUHAdFdO17iwc41s02S0UXqXkqZJXyAbXs2UlFziC
         TwjUItfBx25LqYc4IST5V0MvB9fSc20OY9SDoCfa6PA8UoTwPcSkk0W7k5rRdq9Qj9s5
         6aew==
X-Forwarded-Encrypted: i=1; AJvYcCUaiT8P0Mo2MnH1CwnSVvJOcNc5TDKqeNdWBcL0PEwg7wzcWte5+Ot9I3Jm7h5TT5q5CI4SfAnyVXFz+hY=@vger.kernel.org, AJvYcCVOV0KJpVK5fKe2gv+JIs2sphL45cY3EQuIMI4xOYHIkO7fUXvE1CE3OS2Sl4o51/JlVDUqwHmbgi906yoP21Yj@vger.kernel.org, AJvYcCVRrUVrjgzSNY2BXYtks94TXJ0Edo3BcCK2EQaeFBpDA/d0eMHvl5GNeFnM4XIAxfDWm4M4WC3cSRc0pfn8@vger.kernel.org, AJvYcCW3nzLEUdaEALIYV5iNTLqsZ0T3tuCyfC5mFc23GNx8aKGpp/hKktYOQMatkw2zEGnSo+eqzlSN3jPG@vger.kernel.org, AJvYcCWLXkgYuwviC3FpO9ALZka0s9qNuqM58NlZYCjhJCluMQyqusz6dGfAfPEkMJrdNq68H2BL43WVG31x@vger.kernel.org, AJvYcCWQxaSsXOJ1p0s0oI7W99G03f0sy1RajQWdlHa8XlJxNNBuTYUnNs8BxewNo+rVQtc8uncbhpvYrdVs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jeQn228BUB9VUsAjiFJEtxvly2tqOEWbrvEenXv/ZoHSAxBd
	BKbBQhp29Icw787i7ltHr8Phhs6XSq4MN8GzW0BCCWvLKpwocN0p
X-Google-Smtp-Source: AGHT+IFdIkatQerk+zXAxINpq/NRTF+eJHagLd98gelH27PNmGtNgyRLnetKypXvOHMMq/uLAK/OKw==
X-Received: by 2002:a5d:554e:0:b0:37c:d20d:447c with SMTP id ffacd0b85a97d-37cd5ab758emr6846761f8f.29.1727695894648;
        Mon, 30 Sep 2024 04:31:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427c6sm8889363f8f.96.2024.09.30.04.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:31:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH v4 5/5] dt-bindings: mmc: Document support for partition table in mmc-card
Date: Mon, 30 Sep 2024 13:30:12 +0200
Message-ID: <20240930113045.28616-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930113045.28616-1-ansuelsmth@gmail.com>
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for defining a partition table in the mmc-card node.

This is needed if the eMMC doesn't have a partition table written and
the bootloader of the device load data by using absolute offset of the
block device. This is common on embedded device that have eMMC installed
to save space and have non removable block devices.

If an OF partition table is detected, any partition table written in the
eMMC will be ignored and won't be parsed.

eMMC provide a generic disk for user data and if supported (JEDEC 4.4+)
also provide two additional disk ("boot0" and "boot1") for special usage
of boot operation where normally is stored the bootloader or boot info.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index fd347126449a..5f93bb77f246 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -13,6 +13,10 @@ description: |
   This documents describes the devicetree bindings for a mmc-host controller
   child node describing a mmc-card / an eMMC.
 
+  It's possible to define a fixed partition table for an eMMC for the user
+  partition and one of the 2 boot partition (boot0/boot1) if supported by the
+  eMMC.
+
 properties:
   compatible:
     const: mmc-card
@@ -26,6 +30,24 @@ properties:
       Use this to indicate that the mmc-card has a broken hpi
       implementation, and that hpi should not be used.
 
+patternProperties:
+  "^partitions(-boot[01])?$":
+    $ref: /schemas/mtd/partitions/partitions.yaml
+
+    patternProperties:
+      "^partition@[0-9a-f]+$":
+        $ref: /schemas/mtd/partitions/partition.yaml
+
+        properties:
+          reg:
+            description: Must be multiple of 512 as it's converted
+              internally from bytes to SECTOR_SIZE (512 bytes)
+
+        required:
+          - reg
+
+        unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -42,6 +64,36 @@ examples:
             compatible = "mmc-card";
             reg = <0>;
             broken-hpi;
+
+            partitions {
+                compatible = "fixed-partitions";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0 {
+                    label = "kernel"; /* Kernel */
+                    reg = <0x0 0x2000000>; /* 32 MB */
+                };
+
+                partition@2000000 {
+                    label = "rootfs";
+                    reg = <0x2000000 0x40000000>; /* 1GB */
+                };
+            };
+
+            partitions-boot0 {
+                compatible = "fixed-partitions";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0 {
+                    label = "bl";
+                    reg = <0x0 0x2000000>; /* 32MB */
+                    read-only;
+                };
+            };
         };
     };
 
-- 
2.45.2

