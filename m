Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093C158866;
	Wed, 25 Sep 2024 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300812; cv=none; b=gKK6SkVre2b0JKRrqdLIuKDtMSH+oDZmBE4CXl0VodZ5lHJW3bZMXDTxDAWSciKa4LwdAA5nxXm7ngsxRNgkjD1A+9olKNxscmTNYxDz3lEI3Xu6lt1li5i9GjgGFGR7/WwNr++ytgvB4eGRLT8gfJpBgH+FpFmIbLDalT7hffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300812; c=relaxed/simple;
	bh=JRS8ctlAm3qYU/7UxMl0igxy25UFiLYuqzTjAkmm7t4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tto4mCGxR0TuSjwIOf3mVnxm/bfXUjHczt58k68v7/zqGC58NrMn0u3kKHbfKtx338yB0hEXddsUhgCHuJq4zhak+RxbfW3cDw9lX9XHvkskFbU2lMbCJqtcxyldzZxL3LQPLAW645sB18YVqQOcQk5iKGvwNq3fK48Gp1cJjt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTW7cVBm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTW7cVBm"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so2340905e9.2;
        Wed, 25 Sep 2024 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727300809; x=1727905609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPfCoOMxsJjIr/wXEPPqXPDSbCfoVOLl/AUDyDHyFMM=;
        b=JTW7cVBmt6wPnj4wTGt7cCGaAffTOsekWNhufpwECg7i1l0fnnEsZlWxlzv0DPv5ts
         OaWsJt1Y7lnl5k1cbvfAEOU6mty9Zo8ci7HTOHpLFGyh3itagTUtIRbJSVBwDAR6Nnhv
         JUtXc5CVERzEDI2ViUwhFMp4VCSUVmB2YmAwuGqioysGB/Mu9JSJvfGs796FTZf7L5xo
         CW8YSI11gvnyDd7i2+2w+qtEWTcLGNG48gG9oEr4v2Wo/5fv+r+YoPlzf8TpxnzM4Djt
         eLCylenht1TcOTxtijpFB+1xZ/SnBUaRREa9WaFAypAr4BBoFPjIVBkqT37Jse1LQNIt
         Goug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727300809; x=1727905609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPfCoOMxsJjIr/wXEPPqXPDSbCfoVOLl/AUDyDHyFMM=;
        b=jFm7sDCFk8lYOpvXvfSBbWL8W66FCcYAFg6jPGf22CrrCz3vmI0lOKbW3mF11stqOy
         FW30uEORQOaupSt5OWc0jIBMmYJG0KXvl+4zCbIJ7BmMTmFAwV84lxfyC/MyunDksXj1
         jf5dAh8nISLlq057pmLXH0DE5/hNykW9X72RzQQ93qaae5BPSC4hz266h35R3QK3XXwO
         JyJJMdtNcYnrD45/wonyuzJ4+lPN8ArQm0tgP6YL5/ZL/n/nilw649b0u4j/Kw3fUUkd
         grdtAnRRRBl0URq9S1NI/50uABPj+oLwTnzipLPNe3+L9aWKdDOwQtZGhi3MmmfCzLRI
         FxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4cJD78LAZtGx+xdDQ9R/r5w9W+DyKZpbB42u730tGqn8FfTHA0JoQVG7qQMCIpWHaKsffOOx6eq5KT+Ue@vger.kernel.org, AJvYcCV1PwPGDI2NpwvVFfTaw7EudkpI3WjbXf/WGML98TOXpw1LkmWqFYvHfYyb7uUfzFpGgWsToqnRqeBd5FU=@vger.kernel.org, AJvYcCW767O3EbOeyRz1FznHLPEnPBUgMn5CC0ix581DXkuDV39f9XNqJ3ym/RH0L00HD2SQtPeimmNxDW93@vger.kernel.org, AJvYcCXKT4D+DlfBEbUx1e3E4I1636ugA6uKJGw9+uZbjwx2FFnNmBtES26Z4gA0NgnuQlAIZ0WAdQy8/yac@vger.kernel.org, AJvYcCXNZVqDvquh7JUi+1ZX/hhryGgFyp4XZVxcETtnFmNzrBWk8QV6C4U0q+iZs8Zwh+IGD473+XeWXffZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7SlKfuh0GuIH1Aj5/z98qwQaetDA6UXw7SBrVFRwQC/IVJEH
	Bnrfx1iEbogy4mxKq3IRGfJNzAi7/g/RLKOKvXjrcVkZHuLnyTHK
X-Google-Smtp-Source: AGHT+IGTce5mi+zGP1nqXGGDPQZkUaai36raLWa1UNPSL60TCBSVV7e7UIdYpJYbrhcAnUbxRz9g7A==
X-Received: by 2002:a05:600c:1910:b0:42c:b9b1:8342 with SMTP id 5b1f17b1804b1-42e96119514mr26588975e9.19.1727300808654;
        Wed, 25 Sep 2024 14:46:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e96a1f2aasm28802565e9.45.2024.09.25.14.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:46:47 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/5] dt-bindings: block: Generalize and introduce property for partitions
Date: Wed, 25 Sep 2024 23:45:24 +0200
Message-ID: <20240925214544.6114-5-ansuelsmth@gmail.com>
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

Generalize property from MTD partitions schema and introduce property for
block partitions defined in OF.

Partition schema for block devices is a reduced schema of the MTD as
only a few property are supported for it. (reg, label and read-only)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/block/partitions/partition.yaml  | 33 +++++++++++++++++++
 .../bindings/block/partitions/partitions.yaml | 27 +++++++++++++++
 .../bindings/mtd/partitions/partition.yaml    | 10 ++----
 3 files changed, 62 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/block/partitions/partition.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partitions/partitions.yaml

diff --git a/Documentation/devicetree/bindings/block/partitions/partition.yaml b/Documentation/devicetree/bindings/block/partitions/partition.yaml
new file mode 100644
index 000000000000..b9b1d8139e56
--- /dev/null
+++ b/Documentation/devicetree/bindings/block/partitions/partition.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/block/partitions/partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Partition
+
+description: |
+  This binding describes a single flash partition. Each partition must have its
+  relative offset and size specified. Depending on partition function extra
+  properties can be used.
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+properties:
+  reg:
+    description: partition's offset and size within the flash (in sector
+      block, 512byte)
+    maxItems: 1
+
+  label:
+    description: The label / name for this partition.
+
+  read-only:
+    description: This parameter, if present, is a hint that this partition
+      should only be mounted read-only. This is usually used for flash
+      partitions containing early-boot firmware images or data which should
+      not be clobbered.
+    type: boolean
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/block/partitions/partitions.yaml b/Documentation/devicetree/bindings/block/partitions/partitions.yaml
new file mode 100644
index 000000000000..9c161aac364d
--- /dev/null
+++ b/Documentation/devicetree/bindings/block/partitions/partitions.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/block/partitions/partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Partitions
+
+description: |
+  This binding is generic and describes the content of the partitions container
+  node.
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+properties:
+  '#address-cells':
+    enum: [1, 2]
+
+  '#size-cells':
+    enum: [1, 2]
+
+patternProperties:
+  "^partition@[0-9a-f]+$":
+    $ref: partition.yaml
+
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 80d0452a2a33..e822d3219b68 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -6,6 +6,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Partition
 
+$ref: /schemas/block/partitions/partition.yaml
+
 description: |
   This binding describes a single flash partition. Each partition must have its
   relative offset and size specified. Depending on partition function extra
@@ -28,19 +30,11 @@ maintainers:
 properties:
   reg:
     description: partition's offset and size within the flash
-    maxItems: 1
 
   label:
     description: The label / name for this partition. If omitted, the label
       is taken from the node name (excluding the unit address).
 
-  read-only:
-    description: This parameter, if present, is a hint that this partition
-      should only be mounted read-only. This is usually used for flash
-      partitions containing early-boot firmware images or data which should
-      not be clobbered.
-    type: boolean
-
   lock:
     description: Do not unlock the partition at initialization time (not
       supported on all devices)
-- 
2.45.2

