Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0660347FB16
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027152; cv=none; b=DqsHvMCkSACenL5SEupGLzSgwm9Jq21OfXQZJxgtXILeTJ1zU/D2b7/I+a+5o0jhfwsX2Ey55qLJIJmenNQN0H5YfFbTWAvpZMYJiLLAG3jTOD2m2OWA6rbRrXxQNj5aH2jRsWgckzUL9OlwFOXVOq+NvO9kt6Q6v/Qur3L6IUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027152; c=relaxed/simple;
	bh=8zb72y+uRtZA5JG7Jpy7Gdf5cpo//eqQjoZwFUzntms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9y+tNdA1Ft4hNPQQK8uCcaC8PEbH39buSkLmQviz6OPhSpgQNBSpnkR1uC1ZPDyCKk4xFgRkCmPv74Mkny02NRwWoqpz+NubCVgnMWbP1FqSmfds8D+2ti1GZx8Qe0zbPlDLZUMryxA6YIo6gwhpcZ+M+5ej202CQa+2rmCXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Umdw0+wX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BtdvXBWA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Umdw0+wX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BtdvXBWA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ncu61580560
	for <linux-block@vger.kernel.org>; Thu, 6 Aug 2026 14:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tLAbMrw6kMVW1KpbCEzwXaQHTu3vG+Xv+taIs0sFboE=; b=Umdw0+wXDi/tThuW
	hp38e8A8JadQ4rM/lXI8TBE5H9Qz1QR7UzvGGkZCqBQ2zUgqhfnWUVDD5WAJsKKE
	R/XhAYL5WSB885KUs+UeTFEyHlF+I0cmfY/23fWoiY+AbGo4WWBmgwtNaO/BYwW5
	a3F8EvBz7P7xQxTRM1EAE3o7LjkPUKuhpYSaGchOp6PMCVLHFVKgXhS0s3v7zDjA
	yopcd/y7sL8nzPj59wEbTvp1mutd7Itp1xIUbYkc6GB2C2WUcpuw4DiCXYitgQYB
	ujuHuSYvPIfStAEqtz/aumqKyP4AufbKbWc+TSJuL+WMOQfG1UCVbCAkT4I4JIw2
	551lBg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvmrjj8qf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 14:39:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90410c668adso21414126d6.1
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027143; x=1786631943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tLAbMrw6kMVW1KpbCEzwXaQHTu3vG+Xv+taIs0sFboE=;
        b=BtdvXBWAfvyBuvA9XF0E2UtTHOCU1HsIoEzPDNBKBHI7qxCpFLybv/uABO7Y686XUu
         uJhT5J1QLKKkv+3PT7O5PBfP9Ult4j2oodtHcopUE6nWII6sDupRCqgOPRXj/MhszqXV
         Lg46IKEjhJxHM84DPqT/5jwJ9Xa8D7ZQ7SkEJkRG1RYy2Isilj1zwFTQ2pmKSu3Q2hVm
         yMDXyxKiyj1yl90I/m0ZNVbK1kjYm9KZLlzHH2icjNp94pC1pI+IclXxtf/9L1WGkglg
         VZTGLomR6H3PYpNGsWRwGYLDmgcwi9MbTOTqXRmp7SrJL1Z6UTsX2f6Ux9S+ow0lKlNP
         Q8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027143; x=1786631943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLAbMrw6kMVW1KpbCEzwXaQHTu3vG+Xv+taIs0sFboE=;
        b=KG+GSMdQ00bcVzbzjrZ0Vy7AG43SMsJDiPcIcOMXhrJ8gbt2pU4LWds8Z2g5vKUnV/
         xtHt4n6WwbpswL+FIpcLZu04HJNm1aacn4RIDnyYQoBC2n5YUQbh8l3FdiJl2gTEcMFs
         hUYiuOFofZiP6VjJ2bRNNvdsb2NHT9rCHxSu2BKiCV+AMoadPrv7ZSBGHxKnuH37h13J
         V2adjyABoypdu1USVwg6yXLLQAc6LHzIiKQ5KWKe80nW1tdEBZHoSDFOWbOVd/ggksDi
         67A6YFbANiF+pegLke97Ql6WbEinoSyhkJJXfBuW5hJVsnEi96idD2vt+uDVsE8DKxDZ
         5XbQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnIUyOMDLXbqhkAcDtOrQw6XsaE+utemEJJjZMgvuVU2lZWZCy5fhrGeYDZ57eA2NXzjNEbKOHbcTD+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWKWSqiq3VLVqPftijy3YpaGbFCqCaIFjTPmMMdGaZ2xEvEc5
	Rzos7ka0Yub6PN9BhbFZIsg/0ay7XSuydQJt9QNifdyvwm+6Rr7ZgmQhfQd9y2CrqNWC0KuQ4nO
	bgykLIYHnNQc8fvCWMUwRA740wNUxa2EnrIj907BvMJVcrPUSuiUdcY/OLpGVjQ26Sw==
X-Gm-Gg: AR+sD11ez9YhnTz0HuEHOfT4j/tfG7t8hSZgjVKTPPvUS8icHbPm4kpaLd1Ib9PWp25
	bi2Af+zFS610NcgWIj5MDKOeJhjFOg5pNCE6lsvlSRl76a1M2g6sulLaDe4+tEh2KZuruQ4sOZB
	/owyPpCHfwZQ9Mc7gNHdJOBlhEP2aIdCKi+cXYnALeFkdFxD31QBDo2vlEQJQxmGYwje/UrFVPp
	CguSSx6VLiUgmNA+qfviURDbPXUzrL+gmzEwkIAKOcycr+AlpDekCceogrEIK/L8MyFgfnQNv45
	IUvbVIze+7MlWZIjWqUop69BgVXW+r/6B5oAJLsWH8b8Yarx1JiEwp2fJN4cYFpllIYINDs6pmz
	FBUn14UR31zByY60eVwrgY8fte57P10gCit5FwuaFm0NVU2LNtEB0GDZG25R6T/8EdT8uuFKyDu
	ryjkIq3J+eHQgYXW2eNfzwrUJt5H59/jkF158fEcaCtgDj2C/ReQ==
X-Received: by 2002:a05:622a:4c14:b0:51c:2633:9ddd with SMTP id d75a77b69052e-52ce61eabd5mr171870781cf.41.1786027142951;
        Thu, 06 Aug 2026 07:39:02 -0700 (PDT)
X-Received: by 2002:a05:622a:4c14:b0:51c:2633:9ddd with SMTP id d75a77b69052e-52ce61eabd5mr171869411cf.41.1786027142285;
        Thu, 06 Aug 2026 07:39:02 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:39:01 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:39 +0200
Subject: [PATCH v10 06/10] block: implement NVMEM provider
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-6-be598b2a5606@oss.qualcomm.com>
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
In-Reply-To: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=VNPtWdPX c=1 sm=1 tr=0 ts=6a749c8c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VT4XjZGOAAAA:8 a=71DuYGxFrHUPmPLwgxgA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: 6-q1pWKrwAM8qp2GqLACQ-F4kxsiDAyR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX6P3JARmhPSfr
 5bSPOQ7OXHiosmuUDbK6XbvzJDxJNtaw8PUyVDQb92Psoa2ivaglchRIdqIfk+J7tT7lK/DBJ8v
 qo5R2dfgkRaJTVZZ9U8D96P3B5MFBoY=
X-Proofpoint-GUID: 6-q1pWKrwAM8qp2GqLACQ-F4kxsiDAyR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX5cz2CB/K3aSg
 5wCSNi3Nlzv6kMTmgut8Rty++XA8nXE9c3hjedZOnsYsRoH3GK1uw3K3ygQpMgNjPUuJ0R07TbP
 p1Uh+RQXpaecaza14KG4A0Dd6Kv6CUwJAhsTIhRiwe/taS6qnzumJ/+7CAWxcLwwfru7KzkiJkM
 fFsXc+1E3DaWcLZ7Nc896QbAG4JFDzxFkkqbNWtKCxBCsmifLBGR0OfXg8Qq/XQWkvr3qiDxDxH
 FDIzzB6aWNZ05+AqxhhbEtDemqOj/sbadbTSvZ4wT+6I1ZuPEikAi7cUgi6m49MGTYanpiQp5Jo
 KUt2hBCZ/TplPBWpNpEPDIDdYdJ3bycxogRL3AHB9HUrdDJtkMVQaPR7DuRYmwWwweCHCH7VcJR
 93qIYv7EelTCpDUk5XHuZJgYDlwO37Cs/RKz3ndQMCs69uyTeXqw5JRvCAgfJke8BRTvzKcjFqR
 fYcRKQIp3/RYywX4V9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060114

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

NVMEM is registered for a block device whose OF node describes an NVMEM
layout, either via an "nvmem-layout" child or by being a "fixed-layout"
node itself (e.g. an eMMC boot partition associated through its mmc-card
node).

The NVMEM device is a read-only side channel onto a block device.
Each read opens the block device with BLK_OPEN_EXCL to keep other
exclusive openers away for the duration of the access.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 block/Kconfig             |  11 +++++
 block/Makefile            |   1 +
 block/blk-nvmem.c         | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   8 ++++
 block/genhd.c             |   4 ++
 block/partitions/core.c   |   5 +++
 include/linux/blk_types.h |   4 ++
 7 files changed, 145 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 70e4a66d941ff66ecb0ec34f4f7eff7fd1e4be40..4899ad572c71ffdbb62460d57623216254893ddc 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -209,6 +209,17 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  exposing factory-provisioned data such as MAC addresses or Wi-Fi
+	  calibration blobs to the drivers that consume them. This is
+	  typically used on embedded devices where such data is stored in a
+	  dedicated area of an eMMC, instead of a separate EEPROM or OTP.
+
 source "block/partitions/Kconfig"
 
 config BLK_PM
diff --git a/block/Makefile b/block/Makefile
index e7bd320e3d6971a8abf584f5de42776bb54e8216..8200297fbcbab304beb4239d0c33da07011c3ed9 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
 					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
+obj-$(CONFIG_BLK_NVMEM)                += blk-nvmem.o
diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..69b69184e16303444c9cb2dc816d5679daeb13c4
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * block device NVMEM provider
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Useful on devices using a whole disk or a partition (e.g. an eMMC boot
+ * partition) to store MAC addresses, Bluetooth addresses or Wi-Fi
+ * calibration EEPROM data.
+ *
+ * The NVMEM device is a side channel onto a block device that stays fully
+ * usable. This is somewhat mitigated by opening the device exclusively.
+ */
+
+#include <linux/device.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/nvmem-provider.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/property.h>
+
+#include "blk.h"
+
+static int blk_nvmem_reg_read(void *priv, unsigned int from,
+			      void *val, size_t bytes)
+{
+	struct block_device *bdev = priv;
+	struct file *bdev_file;
+	loff_t pos = from;
+	ssize_t ret;
+
+	/* open and prevent other exclusive openers */
+	bdev_file = bdev_file_open_by_dev(bdev->bd_dev,
+					  BLK_OPEN_READ | BLK_OPEN_EXCL,
+					  blk_nvmem_reg_read, NULL);
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	if (file_bdev(bdev_file) != bdev) {
+		fput(bdev_file);
+		return -ENODEV;
+	}
+
+	ret = kernel_read(bdev_file, val, bytes, &pos);
+	fput(bdev_file);
+
+	if (ret < 0)
+		return ret;
+	if (ret != bytes)
+		return -EIO;
+	return 0;
+}
+
+int blk_nvmem_add(struct block_device *bdev)
+{
+	struct device *dev = &bdev->bd_device;
+	struct device_node *np = dev_of_node(dev);
+	struct nvmem_config config = {
+		.id		= NVMEM_DEVID_NONE,
+		.owner		= THIS_MODULE,
+		.word_size	= 1,
+		.stride		= 1,
+		.read_only	= true,
+		.root_only	= true,
+		.ignore_wp	= true,
+	};
+	struct nvmem_device *nvmem;
+	struct device_node *child;
+
+	/* skip devices which do not have a device tree node */
+	if (!np)
+		return 0;
+
+	/*
+	 * The layout is described either by an "nvmem-layout" child node or
+	 * by the device node itself being a "fixed-layout" container.
+	 */
+	child = of_get_child_by_name(np, "nvmem-layout");
+	if (child)
+		of_node_put(child);
+	else if (!of_device_is_compatible(np, "fixed-layout"))
+		return 0;
+
+	if (bdev_nr_bytes(bdev) > INT_MAX) {
+		dev_warn(dev, "block device too large to be an NVMEM\n");
+		return 0;
+	}
+
+	config.dev = dev;
+	config.name = dev_name(dev);
+	config.priv = bdev;
+	config.reg_read = blk_nvmem_reg_read;
+	config.size = bdev_nr_bytes(bdev);
+	config.of_node = np;
+
+	nvmem = nvmem_register(&config);
+	if (IS_ERR(nvmem))
+		return dev_err_probe(dev, PTR_ERR(nvmem),
+				     "Failed to register NVMEM device\n");
+
+	bdev->bd_nvmem = nvmem;
+
+	return 0;
+}
+
+void blk_nvmem_del(struct block_device *bdev)
+{
+	nvmem_unregister(bdev->bd_nvmem);
+	bdev->bd_nvmem = NULL;
+}
diff --git a/block/blk.h b/block/blk.h
index 25af8ac5ef0f77c09b4d747827b275c32e9f2972..dad8f0d7a218edbafa9b6a03aed673657f3e8cbb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -810,4 +810,12 @@ static inline void blk_debugfs_unlock(struct request_queue *q,
 	memalloc_noio_restore(memflags);
 }
 
+#ifdef CONFIG_BLK_NVMEM
+int blk_nvmem_add(struct block_device *bdev);
+void blk_nvmem_del(struct block_device *bdev);
+#else
+static inline int blk_nvmem_add(struct block_device *bdev) { return 0; }
+static inline void blk_nvmem_del(struct block_device *bdev) {}
+#endif
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/genhd.c b/block/genhd.c
index f84b6a355b574af88c870938a8c69aeb9f8f44ad..0c9c5e5ea7baffa326a2d45b075688cf3a0edf5a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -421,6 +421,8 @@ static void add_disk_final(struct gendisk *disk)
 		 */
 		dev_set_uevent_suppress(ddev, 0);
 		disk_uevent(disk, KOBJ_ADD);
+
+		blk_nvmem_add(disk->part0);
 	}
 
 	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
@@ -704,6 +706,8 @@ static void __del_gendisk(struct gendisk *disk)
 
 	disk_del_events(disk);
 
+	blk_nvmem_del(disk->part0);
+
 	/*
 	 * Prevent new openers by unlinked the bdev inode.
 	 */
diff --git a/block/partitions/core.c b/block/partitions/core.c
index eee954df1ac6ef7dd4f02ad5c9d49aed778bf015..c83227710584a6feb25c8abae3b319cfae9cce5b 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -289,6 +289,8 @@ void drop_partition(struct block_device *part)
 	xa_erase(&part->bd_disk->part_tbl, bdev_partno(part));
 	kobject_put(part->bd_holder_dir);
 
+	blk_nvmem_del(part);
+
 	device_del(&part->bd_device);
 	put_device(&part->bd_device);
 }
@@ -406,6 +408,9 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	/* suppress uevent if the disk suppresses it */
 	if (!dev_get_uevent_suppress(ddev))
 		kobject_uevent(&pdev->kobj, KOBJ_ADD);
+
+	blk_nvmem_add(bdev);
+
 	return bdev;
 
 out_del:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c09e0ceaac41ba59e86fb0c4efc64..6ed173c649025b95cce9253b27f68f2c7dbab8eb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -15,6 +15,7 @@
 struct bio_set;
 struct bio;
 struct bio_integrity_payload;
+struct nvmem_device;
 struct page;
 struct io_context;
 struct cgroup_subsys_state;
@@ -73,6 +74,9 @@ struct block_device {
 	int			bd_writers;
 #ifdef CONFIG_SECURITY
 	void			*bd_security;
+#endif
+#ifdef CONFIG_BLK_NVMEM
+	struct nvmem_device	*bd_nvmem;
 #endif
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast

-- 
2.34.1

