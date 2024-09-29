Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87F18308A;
	Sun, 29 Sep 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727618905; cv=none; b=VQTen/o3iOvDV0EH6M63kACTuLEu8zGblxAhxzUveZmF3rFtG1mBCqzm68VqwmvfGT5N1Iy8e/j92A7gO6XgqDk9jDdJJN24dN6maOHjpVPVSytxoAqSgjYSKaPh/KpXJqpPCk2q3BUDK3UqMahAYNNYv85/kpTsuV+wuImYJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727618905; c=relaxed/simple;
	bh=XY9CIJRo4kERP1f7gzDDtLEj6FCWJeCQbDTSD4GQKRc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPJ5ZP+vUoeGYAr3Fxrj4tgpul3e3yJiK65YFe53YSpUlLw2GBqvxGlQFvUIcVru/68DPZNUWQSYiryfnBf9b5yR96dhAZZtsht9k1sr9FXrpt6+OMmXFEAghB6YMd2pYTvdtzgCQTqML24PfDBu1QD/ldlDrzO8kVAKekYPUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbh1lG4J; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbh1lG4J"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cd0b5515fso1694048f8f.2;
        Sun, 29 Sep 2024 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727618902; x=1728223702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOC+2wly8ftj8TAYNwXd5GnLMEEgJdboLyIbx9/Qeyc=;
        b=Nbh1lG4JXUyS2CnNVv6Fbd6c1ZhY2NCMeZYzRNQy3TIrtRXyNnLs51SdA9W28jFecE
         tGP1AUVIxDMu7uC02oSBkGLXwmJd/oGronJcy2hPQyeVcwGrk7xU5ZzNGuRYJ3K//dgt
         n99DFHQTa2H0Yxc8BQxRVglDA69joJPrANur+ypvdmmbc8qkM2QKVPbCzy5u733uWDpe
         dW5Xb0E3scZkXlmrMPzq+BP6i5cDWDLGnWQ5b/eQnfQqpd1bqF/MbG5rJeHbR1w5QPWE
         thTY+iFIecO+asArkdz5GIa8Pj0tonxPnI1eNN/LtvpcGRxLiJD5g+R/ZSS2/grr4cAJ
         YefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727618902; x=1728223702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOC+2wly8ftj8TAYNwXd5GnLMEEgJdboLyIbx9/Qeyc=;
        b=uz5GFKNgKWTBm2KwP7lArg8kPCO5tkdwLzwaHXrLS7JhVviHfd3IDeFqYHVSAWgZxj
         VZ4+iRc2PI9nUhuhFS6z3287zTqVpMYZuIGRfqlmovbR+byv0HG2VX1kLjIhj/585pg5
         CA4mwBe51ceQU8Hq3dhD6UCaTK9iPfRROsl0sOWwbMzOof/QkdxqfhLuApqSpH2b4oeP
         yrvIe8UQytjSyROgDZS88wzTL/A0JhNY0as7GQZBNzWQYWrRSV4kjTHNJFpq62NoF5sI
         ssXqE1CLL6Q0ROpVaAmwl5ebKzHR2h7z7BwPdWKJ23WD9WuY3cWFVHHYGYs2dXyyTg2j
         8lvA==
X-Forwarded-Encrypted: i=1; AJvYcCVg6f04T1xhzhaqaM8BaERxUX8Kk19kjXq3EYNIzpFhueSXNRXhbUbfo0s60ti0mTGe2xu9W2cn8UiI@vger.kernel.org, AJvYcCWClNnpn/CJsA9IFdK4663C0IKR+eWYozyB9jvqPQuhuEP8bHLa9lAv9tabsglCqFfJ6er7GNmkcDoj3dE=@vger.kernel.org, AJvYcCWVsLxcDzkkSQeX8SHs2H7lngWgFYOFnnXSaRNVTCtkhoI1bAXqi3bxPlqGi8Fx2pnsqE/2icIzcJw8@vger.kernel.org, AJvYcCWtew50d+LSv65ReIDi90HdCPf91Dg6tFxBZWhVfYRcBJ2CDv/IgzYsZ1+b7D4T0EtTBbilB4fxKKWx@vger.kernel.org, AJvYcCWylbpMtgTrJAX+KraVtOBYpl8x44AeOJH91EqrwWE2B5zI4OWsC+bFqZwNoEdZgL5V2iCoRxr61oidhP24@vger.kernel.org
X-Gm-Message-State: AOJu0YxZW2DG+QRdzzStVuVqMrXJcypb0cX3DE+ATP3rzq/+z6+IJDbb
	Do2OYG5YaYDNTuXbHDkJWNIHLP2A2hYlh4OS5Cb41mIU2Ov6hsKC
X-Google-Smtp-Source: AGHT+IEaTYIMtXLW2Fbsge2IBd7OpjCtDwOapaLlrUO9/SPaF5c7ADYuNz/90eGwtbd9dof1ZWtvqQ==
X-Received: by 2002:a5d:6807:0:b0:37c:ce45:96f2 with SMTP id ffacd0b85a97d-37cd5b1f317mr4549697f8f.50.1727618902187;
        Sun, 29 Sep 2024 07:08:22 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f57dd3106sm77856005e9.7.2024.09.29.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 07:08:21 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH v3 4/4] dt-bindings: mmc: Document support for partition table in mmc-card
Date: Sun, 29 Sep 2024 16:06:20 +0200
Message-ID: <20240929140713.6883-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240929140713.6883-1-ansuelsmth@gmail.com>
References: <20240929140713.6883-1-ansuelsmth@gmail.com>
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

