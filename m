Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F328DD0;
	Thu, 30 May 2024 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717035327; cv=none; b=CXb4IGnfRyG3aR6mwhXcB8IFEQHapG3j2F5gUA7l7wvEboUS2IwcwYL8+E9dOFMaAtTFvK2bO7QIKmyA6q8gaOtMMb52wOvTlGuKlVrlc946c1X58VyYDQGgOLQr0+zHvJux9QVGu91X6lUVuot2A464ykIuJzets2Bcoaxm4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717035327; c=relaxed/simple;
	bh=ZND/IraLGpqQA+zSSLk7Bz2Qe5V3dwxk3TRcMUKSLPk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpZEqwVtNavCpDQ2TaYkDaT48W8/Oh29JSLuxkBaOGMmBAYW8rosjGJ0dfXCycT7PT6hNildFTmho4YcW4AK+lzhhhG3GSFtdV4vDaySWi4Qb1noP9i5qQPKnm6LCol/fz4LlR/28GYUPqpZLxQYddxAiUKubHxo6nEPJH+6ayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sCVJz-000000004hP-0r0o;
	Thu, 30 May 2024 02:15:15 +0000
Date: Thu, 30 May 2024 03:15:11 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>, Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH v2 6/9] dt-bindings: mmc: mmc-card: add block device nodes
Message-ID: <e1018427f46d500eaa4fc10a3f2c0eac71eb399a.1717031992.git.daniel@makrotopia.org>
References: <cover.1717031992.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717031992.git.daniel@makrotopia.org>

Add nodes representing the block devices exposed by an MMC device
including an example involving nvmem-cells.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/mmc/mmc-card.yaml     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index fd347126449a..95ccbda871d2 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -26,6 +26,18 @@ properties:
       Use this to indicate that the mmc-card has a broken hpi
       implementation, and that hpi should not be used.
 
+  block:
+    $ref: /schemas/block/block-device.yaml#
+    description:
+      Represents the block storage provided by an SD card or the
+      main hardware partition of an eMMC.
+
+patternProperties:
+  '^boot[0-9]+':
+    $ref: /schemas/block/block-device.yaml#
+    description:
+      Represents a boot hardware partition on an eMMC.
+
 required:
   - compatible
   - reg
@@ -42,6 +54,39 @@ examples:
             compatible = "mmc-card";
             reg = <0>;
             broken-hpi;
+
+            block {
+                partitions {
+                    cal_data: block-partition-rf {
+                        partnum = <3>;
+                        partname = "rf";
+
+                        nvmem-layout {
+                            compatible = "fixed-layout";
+                            #address-cells = <1>;
+                            #size-cells = <1>;
+
+                            eeprom@0 {
+                                reg = <0x0 0x1000>;
+                            };
+                        };
+                    };
+                };
+            };
+
+            boot1 {
+                nvmem-layout {
+                    compatible = "fixed-layout";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    macaddr: macaddr@a {
+                        compatible = "mac-base";
+                        reg = <0xa 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+                };
+            };
         };
     };
 
-- 
2.45.1
