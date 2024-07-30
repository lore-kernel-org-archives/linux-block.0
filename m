Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5E189B97;
	Tue, 30 Jul 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367506; cv=none; b=NCFyFESKOe8qVJaQzxzH6ueQUN1TI3RbtqwveAyqfBdonO7LdL2p3uaSdCDAdukuyfFV17WXeNi/vk6GGLzncOsfZp27DUJqW4TETDMmpcLeVOZRG3iPcC6BDSBuwEYAhpjdvi+8Jl9IOWxSPVs71TQtfZ1FgRvBqh0hrqqJP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367506; c=relaxed/simple;
	bh=SMwuI++WDdWUu7eCGhGJabbU9UQdQZM6IqiYwy2zG3k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md3zl5NTB7zCqQ+n0rYQ33+7iHBxr7bC07lD8r4LZt3Y9dLuTq/7jBv9qU2DIzGL4+mbXxIrBCU4RACOv2PcgMYqEA+MVHe1bIIMDN8rEJKs2L+og/TmAEBWwslsNWgQN0q5Y0sTlcAJbkKSSf4pRU9cFogzaZxfkU/97pp1y+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sYsSp-000000003CL-0AsN;
	Tue, 30 Jul 2024 19:24:51 +0000
Date: Tue, 30 Jul 2024 20:24:47 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Chad Monroe <chad.monroe@adtran.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tianling Shen <cnsztl@immortalwrt.org>,
	Chuanhong Guo <gch981213@gmail.com>,
	Chen Minqiang <ptpt52@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH v5 1/4] dt-bindings: block: add basic bindings for block
 devices
Message-ID: <8b6d5fadd6304cbd99672deb950cd7ff3e7c4ce0.1722365899.git.daniel@makrotopia.org>
References: <cover.1722365899.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722365899.git.daniel@makrotopia.org>

Add bindings for block devices and partitions which are used to allow
referencing nvmem bits on them.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../bindings/block/block-device.yaml          | 22 ++++++++
 .../devicetree/bindings/block/partition.yaml  | 51 +++++++++++++++++++
 .../devicetree/bindings/block/partitions.yaml | 20 ++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/block/block-device.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partition.yaml
 create mode 100644 Documentation/devicetree/bindings/block/partitions.yaml

diff --git a/Documentation/devicetree/bindings/block/block-device.yaml b/Documentation/devicetree/bindings/block/block-device.yaml
new file mode 100644
index 0000000000000..c83ea525650ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/block/block-device.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/block/block-device.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: block storage device
+
+description: |
+  This binding is generic and describes a block-oriented storage device.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+properties:
+  partitions:
+    $ref: /schemas/block/partitions.yaml
+
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
+
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/block/partition.yaml b/Documentation/devicetree/bindings/block/partition.yaml
new file mode 100644
index 0000000000000..86b61e30f9a41
--- /dev/null
+++ b/Documentation/devicetree/bindings/block/partition.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/block/partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Partition on a block device
+
+description: |
+  This binding describes a partition on a block device.
+  Partitions may be matched by a combination of partition number, name,
+  and UUID.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+properties:
+  $nodename:
+    pattern: '^block-partition-.+$'
+
+  partnum:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Matches partition by number if present.
+
+  partname:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Matches partition by PARTNAME if present.
+
+  partuuid:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Matches partition by PARTUUID if present.
+
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
+    description:
+      This container may reference an NVMEM layout parser.
+
+anyOf:
+  - required:
+      - partnum
+
+  - required:
+      - partname
+
+  - required:
+      - partuuid
+
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/block/partitions.yaml b/Documentation/devicetree/bindings/block/partitions.yaml
new file mode 100644
index 0000000000000..fd84c3ba8493b
--- /dev/null
+++ b/Documentation/devicetree/bindings/block/partitions.yaml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/block/partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Partitions on block devices
+
+description: |
+  This binding is generic and describes the content of the partitions container
+  node.
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+patternProperties:
+  "^block-partition-.+$":
+    $ref: partition.yaml
+
+unevaluatedProperties: false
-- 
2.45.2
