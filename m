Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323F19F42F;
	Wed,  2 Oct 2024 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907240; cv=none; b=kmBn5CvaRqq2B1cza0uSPisDVIFAo2qnLTBpMt4rE6+bjMFGXNNjEwLhFAjFfRWc3QAJV1vyMFiJgIQuCrSvVC8jn2tODxj7vfGocoIXfjFKHaJ4foZeicmh2JPT4COYRDTlOrRlE7H1VFoTBMvGhxNe2ozlvsXmlX1mMfSIkXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907240; c=relaxed/simple;
	bh=jgKRogDhouHxgHp3uWFozI93Z/lGip8Zz1ZZk0ZOOnw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sK/9ch4ABcjOgR2CTBe6cYyXWGEO6hSsY/thZDCFVzstFvwa1t1/PsRh61/TCq2Ym9YNY2ZJLO7bX3Km/F3Lwtfo+yqc7omRREa8PkXq8qG4QI65VKfkIenq8fCtsmFr8p9+z6U8oMFrbbxPdSLHUS2U/AfmPtt4T9roBzkYRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrAELc5d; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrAELc5d"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cba8340beso8290635e9.1;
        Wed, 02 Oct 2024 15:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727907237; x=1728512037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PlY4kQjRGMW2mhTFZj4kRJ1PV/IGOaEuiYkQi7f2Dg=;
        b=TrAELc5dqbz/9IrH77Z/Rz1yY0xt0k4mnc0eLfyPGvXkEYcP5AkLBEAR47aNTkSsHL
         r4E0QKsaAPfvCMSFyOWCjhqvhOwQw77IjuRkpjumIlEkanbD+j8jiJujGYRkufSFnB5f
         7HkrbMi4P6j76+0BLlRQES05BUlFJ6hwpnxpvZjL49WpQ+Ni6TvPbFVCzhlITWIpYBTJ
         BQGLuXqnh8jU29JEHauYNm1+GtlDqanLoQtjLRHNWoT/SBhSWyQd4E+45M6V63ze0OiN
         IFYwPirysahtDcChiX8V1Jlqkm6XUACHrs+LbYWorpGFlu3elH4et32sap8gQEb7Kva/
         5zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907237; x=1728512037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PlY4kQjRGMW2mhTFZj4kRJ1PV/IGOaEuiYkQi7f2Dg=;
        b=vjeD2K0Ia8hrXtRq7DmBlGeRDkF7bC4qx+jIZjE44sPOrocgElNBxUW2zbT9C06p4J
         TdLpPVtA7TKJkzhCpyZe3TLdtXgXPA76dx9sCgP6wCRYk9M98NaIHLc4EJ70R+K/ruJG
         cznORo/YoGoc41E3vQFPl4XgIAPY5+E22afiOFUHz3ZmN1zsZfYY1XYR+idPnD9sYemn
         ZyIDiUppTsThvd7m9S2kxiHE279zrWydbbSTaa/BHWIxagWO6ZmbJjoUF46T1jI7yt8m
         c/an6ouuWNRhtjx6DITha/Zf6rtJ2Xweo8dJRSMR3CpwBlBuZfYteNCZ7K3ajROe0AWD
         G7fw==
X-Forwarded-Encrypted: i=1; AJvYcCUa/OEVRopwRdZUuxFpNTUEgzy+f2QxyjJF8h/uszaU5fHrXaHmQHwGjDl8UyH2Q9wMuJfhJVI3pFKCVn8=@vger.kernel.org, AJvYcCVrOC3WyoVyLfoXRMSwHWgNLt0ttpDV91srsNQpW3iShJAe5Azv0rFW/ieDhUVxTGRC0nxdek1bjfyF@vger.kernel.org, AJvYcCWhNj7g0+o46KFu5zX73R2K5ahv75Z3djsDSD/tF2X8Xa+retbOKQoFXO2BjB1DEebFrZAeVmKlk4Lz@vger.kernel.org, AJvYcCWl+hmdxXWuiHXZA/NeDO5MAxfa4LZMxJO3Ruzvd90peLUfJm7pclIyDxPFshpIzpNxzAWUkcs6rUuV@vger.kernel.org, AJvYcCWyCTzmGI0b1yaqRuajNjHYcDJFcVXnM5Vart12cBRwga1Ksp4Ct1C3Sx4qk8/lXayZbn4lJ40/tNMD1b5U@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLocMpE8eCWI70kuLnuq95vj+L8eUxVNI0EwsqN6emvdaMMZu
	husiy6wIbA+jiBNBe6QqNAbSvFcQU8Kc56IjVmGhWNM1fQXaVVq7
X-Google-Smtp-Source: AGHT+IHxkMPF8AkGmoyyfCpyi4PkUp9zju0olvxSD6e2eh/QKcym1EZg6VPGiPFOKaJOPN5w/UF6bg==
X-Received: by 2002:a5d:5b85:0:b0:374:c33d:377d with SMTP id ffacd0b85a97d-37d04a7b2f1mr571448f8f.28.1727907236933;
        Wed, 02 Oct 2024 15:13:56 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f79ead1absm29218245e9.17.2024.10.02.15.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:13:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ming Lei <ming.lei@redhat.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Avri Altman <avri.altman@wdc.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	upstream@airoha.com,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v6 6/6] dt-bindings: mmc: Document support for partition table in mmc-card
Date: Thu,  3 Oct 2024 00:11:46 +0200
Message-ID: <20241002221306.4403-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002221306.4403-1-ansuelsmth@gmail.com>
References: <20241002221306.4403-1-ansuelsmth@gmail.com>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

