Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77E183CCB;
	Wed, 25 Sep 2024 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300816; cv=none; b=lxwz2Clo4F1FoaT9dASy7oci63beLFRr3Mevl47tIS9st5RR/+QlupsU08SkHBnsqbsnJabHQwMV84noQIikAnCeo70iSMxr0nrnTFPwb0l6yxomCN3ONisJ3Jd6Xe9liGFASOVjeBmN0SUWLnmwDTghm9eo9BOuiDv4WJLmQtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300816; c=relaxed/simple;
	bh=FeHxkCsjuNWL4fLxU+cdqB1g5g+6e0/6atm4D7lPtT8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYAf2aqsfZRVli9Hqyavr9T4ci6dy/ZrMUJKavFIYHeB3nKAcJJHAYBpMS7UXAv0OZnJMLNUvhKpQ6t0ygEQ5mwJO60rN+9+XLPInSvPfUXJK81wSajLlSMjbb1TR5mzFWq0wmfgKxZQPAglIhuKY5Gr2tTN0yOXQPk2kg/BynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKrrdVbw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKrrdVbw"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cc5fb1e45so163542f8f.2;
        Wed, 25 Sep 2024 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727300813; x=1727905613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9nJBatBeRhZqG9r4m0SatNAaTtD+mKgW27WzTrnpaU=;
        b=cKrrdVbw8WMQaaHu5TuAQWGFVeNSWAfDH69/W0MdnZCjwPc/5H2FRQvwIZXQ+otbwf
         OpE3M/jo2YVIfGir0gLBPoKgjT1L+P1rYDhwPM8qtIn/naE5E4awGaNwhpva10mxO6B6
         VszGXjFX8u0BGiN6eQL8pPABk6qocpyoWCf3WGR2bslpx++JCCQO9q/HfVMluu1vD5zN
         nBIIKHv8i1PBIpXrd1et+21HEk1uf9xYH2r66tkl21KHsP21zf0nAbJzDhDndRg0wAwd
         5Uart59LAg87iNnfRNznreRgHUAwpm9yyq/8/ikwzZ/PvmUG5PIdbyzx9RhAxNx5FXh6
         aaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727300813; x=1727905613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9nJBatBeRhZqG9r4m0SatNAaTtD+mKgW27WzTrnpaU=;
        b=kW8q3YB6ztiN6RCJQtR+SFi0EDfyoKhAaIBs/l+/cbbKD8xkgTP14ptzpQ4TrUwZEb
         F4txmQce4N0Ce8QTkk4ADcAy2CxJA9E2rwNzZbWigDgdNpIsEgQjufSXnE2kL9a05O4A
         iCGWn9awbGXWqb6RdYa9ndHyWGpXRZ+r7mhKNXVb6Jr1nkKAQ9Mact8/izEyVDl2ZBNN
         BIYbdgQnY9NtsW01LqRXVjXWEhoU+4ohfABs6ytj6h8fpVGN6nu521SR/lwKuDgbuych
         PD73d7WWRZ/MRJjQNxKu2IM4qOOxr1y18g6hHydF1eZdj8oNAko1UvtRO2mMoA8MmHvP
         DJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWv4SrX+szq8G/DOWDcAFHE6V1y2rKx5fUmmrsSw3q+qiWYu6sloVoD5CO4ui/TKDxSK/3IsKaiuNz@vger.kernel.org, AJvYcCVOdI/ylun78/0K9vHqZRgGao3IeRF7smzKcv+/pses5K3VDuRQDVy8Q0oIi8iBNMCXk7hH+x7GQfikAGg=@vger.kernel.org, AJvYcCVVd9xyvGK3bhRkPKlA3iuthA72IbnBKttTg6kz/cFwnJp2dV1ZRtNFifldGa8X13DVgj0tWxqjo5H6@vger.kernel.org, AJvYcCX1Kui7lfHYNPp+cHZzt1Ilz8E3FsditsHudWRupz7eVrtq9M7nDt/L+Janu47II/EGaox0b027HTzM@vger.kernel.org, AJvYcCXcUQinFyXN41+YWNjDNGg++0z2Fo3Js78DHqC1oUACXutl2cD43TJOv/OxaHgii5p7mkzTLr36rscKyCau@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9xAk6yNHfBD04EiEP1/+9V/phrL8Y7rH3JVlEodJCuT5/3QB
	7GCOYNDBf7VsH4jMPqhEQBtHpbvoaHhQPPykyzf+CadftYXBP7EP
X-Google-Smtp-Source: AGHT+IGZAeyKrzKHwOIGMyU2gN/Hnw0mA0ZY+Q9ejwmwD5hxO/FVKoUk2mqdLL+JRkRUMynqLB4o7Q==
X-Received: by 2002:a05:6000:120a:b0:374:c847:852 with SMTP id ffacd0b85a97d-37cc247944dmr2442137f8f.29.1727300810823;
        Wed, 25 Sep 2024 14:46:50 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e96a1f2aasm28802565e9.45.2024.09.25.14.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:46:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Simon Glass <sjg@chromium.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [RFC PATCH v2 5/5] dt-bindings: mmc: Document support for partition table in mmc-card
Date: Wed, 25 Sep 2024 23:45:25 +0200
Message-ID: <20240925214544.6114-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925214544.6114-1-ansuelsmth@gmail.com>
References: <20240925214544.6114-1-ansuelsmth@gmail.com>
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
 .../devicetree/bindings/mmc/mmc-card.yaml     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index fd347126449a..58b6593a0f60 100644
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
@@ -26,6 +30,30 @@ properties:
       Use this to indicate that the mmc-card has a broken hpi
       implementation, and that hpi should not be used.
 
+  "#address-cells":
+    const: 0
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^partitions(-boot[01])?$":
+    $ref: /schemas/block/partitions/partitions.yaml
+
+    patternProperties:
+      "^partition@[0-9a-f]+$":
+        $ref: /schemas/block/partitions/partition.yaml
+
+        properties:
+          reg:
+            multipleOf: 512
+
+        required:
+          - reg
+          - label
+
+        unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -42,6 +70,35 @@ examples:
             compatible = "mmc-card";
             reg = <0>;
             broken-hpi;
+
+            #address-cells = <0>;
+            #size-cells = <0>;
+
+            partitions {
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

