Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A7199234;
	Mon, 23 Sep 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089216; cv=none; b=ETeyr9C6saBd7E92zFMkSBR23ngfwz6tXSv0SbsFVoNQJ+xui6Y27ISQ9GFJRgyxGjgOhmC8DQR3bRhx/R5vx7ZKjyS9Y7rfm+kaw2M8FnLWsW+4QIYfqVotUjdROZ0ZVgUqIcxqSbisMdJFMWLNuH/63/FucGfjpyyKD3Rs2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089216; c=relaxed/simple;
	bh=WK2gxePyJ3COI9wVgLo2wfO2u0lNfIo8LDzjMGUNyDE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9gS81rcQQDVDmhQciaOgY5AGxiRaa46c86PE/DTFt7DOFfTvLDdCbIQEUNTY+vQASNZqL8P5w10agKiatOtEvcu/RKXL+4VGBnvLFibvNRBq7+ZzGfuxWt+Yg0wh7qcMW4PmH+NLDcn9e7tu2OG+E/FKglZuxJlgli0pNPQ7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1b8jcNU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1b8jcNU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so41854175e9.1;
        Mon, 23 Sep 2024 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727089213; x=1727694013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUqmFP2QzVpf7LDbD5h6EoX7C93mpfwdZpjgGxZ7JB0=;
        b=V1b8jcNUQbo/A/dyYzcKtqpdxKRsyu6STfSSZpxNJliqLWtOsgYwEQ0B+UA3X+bS53
         CjGm1pbpeh9gjIP2GoJjL9r5bBVRd3ShyCgSiOs0MHZvn8iZJJCMED/WqgpQOXaRsdz2
         EizsfT1qX+qITec/r1HssVVqTqHgjTQ/0WOdvtVrfir0RcO3rI/rIUi/lb809gyduVv6
         +w3ho7ijLoHNlCHMuQKqZhlMF/jZCLodzlTCJJcW+efZXf9Epof0DEW+5Oi/CVFRf/r8
         dhB9Eb6g8pB1zRYK4WVBCqIMNqP3iqB22B2gp6NhP3D0IOPHyGyh88u8foUfl/U8TWwf
         8lTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727089213; x=1727694013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUqmFP2QzVpf7LDbD5h6EoX7C93mpfwdZpjgGxZ7JB0=;
        b=ALbf9DugoGxInT2SfKE1akw9UrQhWtLkLuk+iOdqYFSuIFBJh8lHzZiqjvz33fwr58
         J21iBtdDorxtUDsKMgwyIQoZ0KjMwYZCV4vliVl3VCU2vp6N6u6OKtICQYmSWW8ywF+4
         kIGxnFgSWWXNPklL7O74oin/Ljb0QsgvgaIY7I95YLFardmYuoAWiF2/owBCl2zw8Xpm
         G3bZXULGjxQkWUqWRwIpTGiDa5Uuy5OZfciMrg1KB6uMYtcFW3CyNd/RDKfCSH5isE4j
         TbM7+ECLVjVIrN6/O/nsoLOvuwk+IRQ5rF/sHaQf83MgVkfSWYoNNLMIVY1RTt2yphIk
         JFIw==
X-Forwarded-Encrypted: i=1; AJvYcCUNl0PG1An1JJIW4UskACyWWo12Kou9dvkkqemkyCQH79oine6vBEwRKWIVyuKcZtQlBncrBTktJBKpgaKA@vger.kernel.org, AJvYcCVbCcXVNdzqBe3fVNrU8gS7bAwJXT/yeQqkXJIuEE9E6kXdZRFyzwSdhzf2OfHRD68Koo6DUAP/AsrC@vger.kernel.org, AJvYcCVqDcctbDN1tVNI/kMxeTh+vGHEPsYy0BVBwH7KHrCX/N+UbVp8V3o6FX0qSVOWX5fDF+dIDHy0XSGHkU8=@vger.kernel.org, AJvYcCW+UCyU0D43Wdj0CnOL3zo4PfQAGyLEwb2moNVoUo5BxiXi/SnNGEJt+QSY/qAOI5lL+lSCs4nssVLi@vger.kernel.org, AJvYcCXhZ8Ij6+qLX966RDNVVjBdwszgxvuPwYPpNrrGlMbvz376qxWEV/B3fsbgW/tMP7RsDoUgwgfSofMG@vger.kernel.org
X-Gm-Message-State: AOJu0YxcaJEOMlJQn/0Kh9SEx3rtEN7QEvCkuULj6BieICzSaWgs7YfN
	lAI3PylF4mZJslIoj4adC9pD4q6j4uLGi43t7r7vnS2UQ2gU3C0K
X-Google-Smtp-Source: AGHT+IHCSD/ALgIwBZ5s3Hy9r99p7T8tE7frQFItu74MHzu4oqQCqGEDZBKVq8n6KYGDunFNzIIAfw==
X-Received: by 2002:a7b:cb8f:0:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-42e7fa8229dmr57296115e9.10.1727089213273;
        Mon, 23 Sep 2024 04:00:13 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e7afd7490sm97856615e9.28.2024.09.23.04.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:00:12 -0700 (PDT)
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
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [RFC PATCH 4/4] dt-bindings: mmc: Document support for partition table in mmc-card
Date: Mon, 23 Sep 2024 12:59:33 +0200
Message-ID: <20240923105937.4374-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923105937.4374-1-ansuelsmth@gmail.com>
References: <20240923105937.4374-1-ansuelsmth@gmail.com>
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

eMMC provide a generic disk for user data and if supported also provide
one or two additional disk (boot0 and boot1) for special usage of boot
operation where normally is stored the bootloader or boot info.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml     | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index fd347126449a..fab9fa5c170a 100644
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
@@ -26,6 +30,48 @@ properties:
       Use this to indicate that the mmc-card has a broken hpi
       implementation, and that hpi should not be used.
 
+  "#address-cells": true
+
+  "#size-cells": true
+
+patternProperties:
+  "^partitions(-boot[01])?$":
+    type: object
+
+    properties:
+      "#address-cells": true
+
+      "#size-cells": true
+
+    patternProperties:
+      "@[0-9a-f]+$":
+        type: object
+
+        properties:
+          reg:
+            description: partition's offset and size within the flash (in sector
+              block, 512byte)
+            maxItems: 1
+
+
+          label:
+            description: The label / name for this partition.
+
+          read-only:
+            description: This parameter, if present, is a hint that this partition
+              should only be mounted read-only. This is usually used for flash
+              partitions containing early-boot firmware images or data which should
+              not be clobbered.
+            type: boolean
+
+        required:
+          - reg
+          - label
+
+        additionalProperties: false
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -42,6 +88,35 @@ examples:
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
+                    reg = <0x0 0x10000>; /* 32 MB */
+                };
+
+                partition@3400 {
+                    label = "rootfs";
+                    reg = <0x3400 0x200000>; /* 1GB */
+                };
+            };
+
+            partitions-boot0 {
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0 {
+                    label = "bl";
+                    reg = <0x0 0x10000>; /* 32MB */
+                    read-only;
+                };
+            };
         };
     };
 
-- 
2.45.2

