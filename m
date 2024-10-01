Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B101CFEB1;
	Tue,  1 Oct 2024 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821252; cv=none; b=NhCDkpVBG30GFOdVJ90IjZ2nTSWEpZaZEeWjYHeb5dO6mgC6NgMlS8ufJ8INyxBHP4QTSi2Ke4J0kJvgOk19cCFKJzhN1A+O4jL6i5UxwfU3kDnzPw7CxSMYl3rYeN/jnM143nyTseSJUQ4R0sUuairDp3FVr9io4+z8Hkd3DsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821252; c=relaxed/simple;
	bh=ZGJWblZQ6mWDeDX3xWjLX4Hq31Cq8jNHK7pdlF6Useg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpeJUJ/ukTdVOvFi7W69+6RJN234FyJDNd3W5N44ffqJIy/Q7Xiq5FoyL2BN6l9jzIzPbfCqRUyQOEQtXsrYKIQAM6O9t0B9STM6n7wN8WyDxO89wMe9aBu7jAaXhJ8val4y7YAHWUk5ZQSQIsun0GGcOripf2l6Te8U8pLLbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/2PcnVF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/2PcnVF"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so74016325e9.0;
        Tue, 01 Oct 2024 15:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727821250; x=1728426050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcRl7SYPnHXphMlwKdbFcqFdVK4YyXteBvfwt/gFJ9s=;
        b=e/2PcnVFqVxSzpcUATNlcHesczaLStp6YCzi39PkRzNBJQcFdTL06q0oBK19FBMlKg
         ESFigPQaE9jlZ7ZBv3OKcFatITmPM5pyBB957wn/maWwuG5TM2xQ1nECSA0E7eKLyjui
         FDrxoHwZcVCtGgOLDXLk3p/jVlDO0KbOeOFMo5EIslKxjSCXWZjabSh2zfyueImh9Jaw
         ihTHR1RiZQcf1CW6Wbvm+glBeMdnEPaEwdUY5zMdaWm7RKotfPIlEsKz6mqDP+IzCaun
         Q9TUCbcFVWUr9qqhzU2d8s80m0rB7YDcJrB2XMLYpa5pS5lRz0BAX06EwtWTi793qjzZ
         hDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821250; x=1728426050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcRl7SYPnHXphMlwKdbFcqFdVK4YyXteBvfwt/gFJ9s=;
        b=IinZxOi6Y1Aw4fopUbbg3TqYif2nwEjHi5xrg6tCTj+Ka+1AMzLllpxWaYa8o0Dclc
         vHfwgsOYuFzqR+j5OJ3/OfpGG5mhK2h43jtISJ2cjW+GpYaRC3w0mZ5GI8oBnXFQd4J0
         YsQratVfqZoCslBGRCNibl3zh+D8zO4sLw4G1LQEksW57E8YtrLDt2kIqkvMZmD+I7br
         iRFUgwMhD9t1gXMGZaOwlxriQGr/1OAs/+qszkIn7kYS9U6Vtt3+eD3AVZGgEO2DVUeO
         TLGCWBA6cQJeq8sb3GcPe6Ue5DqmHG1dHJ6uDXJqwonIUEN9733EbHcSzpIf1fzAz5SR
         AC/A==
X-Forwarded-Encrypted: i=1; AJvYcCUQIhQj9Xm+jQT6raOsieW9vb1fz81ODVnXy+02ToS/BizKZulEmPpiBwR48lZ6RmJFNC9NFmf3NHj4jZ4=@vger.kernel.org, AJvYcCWev9md2385wC891U4QCGO9kioM4vPHTo80ytEy6X55pQ2gX9Lbv2Fm6XrWzSyZXlFEWqIgrK/vkmCx@vger.kernel.org, AJvYcCWqYDddXdaklTS/FpuN4vL1p1B49H1YSRsHMg9NSj5WbZEU0XFCuZUox+LJQy52gXG5r3IWj5+egqCmcmg0@vger.kernel.org, AJvYcCXS7cFK1wdM0g6CaUQOFMz9HZbNBRwfP8DIMMhQD0/mqPosgMLH19aGCVgt4dqFK0KMqIkZ5v+g+dCS@vger.kernel.org, AJvYcCXr0vfdh9/VflTRYlbg4Dbos2Crdz/FcLK219ZChTg4xFIROj+p4B2xacxOhSXhGwDrLezo0hD2zO6L@vger.kernel.org
X-Gm-Message-State: AOJu0YxJlQq2KhUHN1C8hiTKIpaSL4NNid6pKzVsKUA6tmMitnPSieyi
	D9Fj/T8aXZ4Y6FpKLpslN3YWcM3ir6FwUjkcDWopAlSut/Br1UDH
X-Google-Smtp-Source: AGHT+IG7WeKRTItajpBK4SbfYQ6nw9VbEZOfPkIyKbhJk/0ty0lEMpKeTh3MQUz4EbpOtFm3SFoaFA==
X-Received: by 2002:a05:600c:5254:b0:42c:b220:4769 with SMTP id 5b1f17b1804b1-42f778f65ebmr7833955e9.32.1727821249579;
        Tue, 01 Oct 2024 15:20:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427fbsm12677089f8f.100.2024.10.01.15.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:20:49 -0700 (PDT)
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
	Ming Lei <ming.lei@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	upstream@airoha.com
Subject: [PATCH v5 6/6] dt-bindings: mmc: Document support for partition table in mmc-card
Date: Wed,  2 Oct 2024 00:18:58 +0200
Message-ID: <20241001221931.9309-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001221931.9309-1-ansuelsmth@gmail.com>
References: <20241001221931.9309-1-ansuelsmth@gmail.com>
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
also provide two additional disk ("boot1" and "boot2") for special usage
of boot operation where normally is stored the bootloader or boot info.
New JEDEC version also supports up to 4 GP partition for other usage
called "gp1", "gp2", "gp3", "gp4".

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index fd347126449a..1d91d4272de0 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -13,6 +13,10 @@ description: |
   This documents describes the devicetree bindings for a mmc-host controller
   child node describing a mmc-card / an eMMC.
 
+  It's possible to define a fixed partition table for an eMMC for the user
+  partition, the 2 BOOT partition (boot1/2) and the 4 GP (gp1/2/3/4) if supported
+  by the eMMC.
+
 properties:
   compatible:
     const: mmc-card
@@ -26,6 +30,24 @@ properties:
       Use this to indicate that the mmc-card has a broken hpi
       implementation, and that hpi should not be used.
 
+patternProperties:
+  "^partitions(-boot[12]|-gp[14])?$":
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
+            partitions-boot1 {
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

