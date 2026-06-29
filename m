Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE43FADFC
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723351; cv=none; b=ODCF6Gyfu1+iBla9Pd2Xe3K0EVbtsvPzAwrIiGsP1cojY0CDO5AEnHShxzprbPYVVs2ALW1JzSPhZx9/dYB99xGf/T3waYamvzOR1asU8JGpr0avekZex1BvxPTHtl70jK1oSyym/sU7h70plJbolMZYSRZZwKshjcj9xtHT2fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723351; c=relaxed/simple;
	bh=+S+svEblCgUppZ1HOg5J8cBfo2GYNn4HEFtbMzXGGfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LHhL+0fVuPOI9h5XDK4d6AJ0mS8jSDqVAjvQbRTthRu+35/FYMM7W6q6FC3GRRJ33zDOUb4YYvgWhwtzOu2oAblu+cEwi83Sj6xx/ZkBS7f8+gOQnTDzYOYlgmiDikD0YgytZouRC8s8XHTqu1TkmYtcCRC6QJG9qx4mHTEC82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pX86Czb9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EDOFXoYA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pX86Czb9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EDOFXoYA"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rIQM2097149
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OcTiSzV5CVcWs86Y9J99L1MrJ0Tbe0CLQ7Splzu1vMM=; b=pX86Czb9chwHGe5O
	KgsPZCxyZpBLOMDEILVpySAvlhInQ9T42c3DflRUase3EEy36NkTD6BXkcmL1BIZ
	jhGbCJBKonjAXwJz3oFL3roWfPPrfYWQCfMaQLyxkUGjlqW3ko3gqrxFhGVgDf0/
	FYIPFQCt7gMlXkDRuXYl3Y1SQW3me5kIBwdg/vEQx6g0LjTT342X2ylNAp5Y6xLS
	jp1Ku1wDOMpdrv+IxNFc3ch6FH07G5vyDDnJ5yn0XLdEUeSjUdtEw2WPMrP+x1eq
	JH0TI34ri/FXptbXl+cq78Fd1qypCpMQ+mKXrN64betuxuRXlQCbBX6PVAjX7FQz
	bxMERw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7wfcc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:40 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-966c4d68d91so952779241.2
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723339; x=1783328139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcTiSzV5CVcWs86Y9J99L1MrJ0Tbe0CLQ7Splzu1vMM=;
        b=EDOFXoYAuhg/QAn4nxNHAtV2e/ffcsGzE0BKreq0RplX5kd/GkRGmPWwoHQKBuO/NQ
         ZPbkCkld8XappSU6kQWM7gPar83eLFpu/4UfECchRYvQc8Eklk8Qktzr6YwBYrSCxEMO
         lw4fBn7vz2JJf4HHnIsWsrxsAkI2ohAur0YHgVuhxHVUp0Ul0V/rfTaA9/tlQX0IAlu9
         SJ/OqpGZAsDyBtubk8T6D4ZDWWwdFwg3ztBH0qTKKD/yCdFq7QHXGmCqJQCByKbpAiHV
         dsGuEodfqfDIb6Y/ZVgtH+6txhoNeXBDilI52I27djkaBBtuFz8FHAEefClxMxYnLqxI
         OXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723339; x=1783328139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OcTiSzV5CVcWs86Y9J99L1MrJ0Tbe0CLQ7Splzu1vMM=;
        b=TT9W3SUneVE9I/6Pkw8c4tGR5jIs9uNlWCSRTdBffCxuUTErKj3nKJxKT8j2hPjuL8
         as05dPKfbE62aFACFigdHtwG8gjJnXX2M5EHmnhj6paxOKrSgK0597vt7c/4V5fO6lX0
         +CjgMw3KDgDx1i2SApijRfztrxMDTl1lIKViUrAgalI4auLG02WIDdjX9SHtcfic7cBY
         RwkEQ8W0AUoMIGQZ0dRmQ+UxnjhuNbmZSQJFUhhO8rkvaRwz0rWqVM2kcnB0aLJ9FN1/
         mY2/QR/O9rjFYXSEEhlPgdfSkNhA368qE6j9gJ1Lknj1c8OSCmUZvclYWqy9HveDHZjv
         mtHA==
X-Forwarded-Encrypted: i=1; AHgh+RpWLHPG1tgNQW9RRSrnOV/KRWdu2250+79EkL/GINElrNfzjXO0q0a+rAr1psu4XonrC8w98u8fzI3CHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCxmmcHNKG+x0+TgujHwBO2WZcMl2UfsX3qizu4TU+NRXlSZS
	ZwfYnFefZaBQ1igk6p5+58cRHQJIgaae+/LB8yg1ZpkgniJXi5M2fd7iNpwHb7VEMdOqEnMnGKr
	sZwgy96jJfmTQKr9Ph8BzCEWvpEpPmprRVQ7L6WbuEok4qJMUcFL05h1rzoeiP8Tupg==
X-Gm-Gg: AfdE7cnuf8YsO7PbJSFgQnhb/H4fpe3fbxm+bQfCA6z8bUguhziZYAnkqjm+Scj+kkc
	656ztC5UbORZy5WAS0p7BTcjwQes7fGpvMS3nBfWQEnnzrZDO6TE4RMp1VeVDe20Rwr0LLv39k/
	5gB9wBfVp+GaFzIgk0gV5mOJOgyEBIpJKXvlvLgQ9B211aKu9pAKdbwSRpvuqIE5f0EpSPfDFwK
	1FXkkK6fmViOcZq9AFvyi3qQ7V4pHZSeLzCPNwaiuz4A9Q6nGNJeHkaXj0NHOUQX2Xz3o7JYJd1
	MRxDnaWAfCMm+97qcZLAGrB+obCM68q5oH0tMKxYy0UDYIxu2z6MbLl8o+NIH2sOBOXcZ4cUsHj
	iJj8+4Nb3LSoIiUpaAXOa3gHO1+Z9+i9ppL9pgoDnN/RnzDSHdtISXZ1WidN/ojiDTn1anvUPXP
	qtfrDrojLITMWFBvSBlkTelLexwJSFDcCSKjpjNkX7l8dWwBHO92Q1klKuG9rqsI9mFhrIZItRl
	CkuOd39tIX9a9TcJtT4
X-Received: by 2002:a05:6122:4683:b0:5a0:5805:c8ba with SMTP id 71dfb90a1353d-5bd69d85542mr6116233e0c.11.1782723338942;
        Mon, 29 Jun 2026 01:55:38 -0700 (PDT)
X-Received: by 2002:a05:6122:4683:b0:5a0:5805:c8ba with SMTP id 71dfb90a1353d-5bd69d85542mr6116214e0c.11.1782723338384;
        Mon, 29 Jun 2026 01:55:38 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:37 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:24 +0200
Subject: [PATCH v6 5/9] block: implement NVMEM provider
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-5-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXzvSfuTdTv7Bj
 rBi5wl2jlQWq8Qqmpq5ROtVwDe6xTz5Js4DV7K5dBrOSfNVBHtoTRqSJ4vqAuADvJkgRc7jUGwV
 7qlKcRHsIsJpDj5hWOiW9BG8nCcLQFiWXxDlXSmbXs2SJhWFm2ku+hgzVM3Vo7yAGkTdWQfTeo+
 /HlYyGdElx1MVoT7BjnMFNXWV+Brh3fWsxasdx9B6njkbG8uXKCBVr6BIncsXVHFKAw3k3i0d6F
 p8Nf67HhA/qjlYSI3aJrYqwag3Zh/dkD5yHd8MqEezXSqPaqoX2erGpyXW7dcb8YwJfugw4oHGP
 1uLyvsHG23grY4E/yfb7toaHu/IQOn/y5YII0qdLvDQFYKYRg/4i1wb1ieK47O0Mmm6bOhy/8CP
 ODKIuUYPs6LaAg0dfy8l9/yx1TJQUUfjwj4oukUX8nZMZFnEtzrQiFqIdjv8JnkOx2N/lP05J+b
 S6/gH1V1ttdZqKJCy4w==
X-Proofpoint-GUID: 7PmzwhbsTTBfTndJSA2yTXPDPY2xkCS0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX8f1rxw9vVN4v
 krwIyTru0A3RH1jaxLog4UjKhF8FkL9qI8eky738a926eiEM9Q2Zv4IC13pRj3jrfvCiJ2hbq3P
 RJue5X2GgKHU9EDzoMZYv/j11ZUHydM=
X-Proofpoint-ORIG-GUID: 7PmzwhbsTTBfTndJSA2yTXPDPY2xkCS0
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a42330c cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=QS6QONgytJYYblx7mpIA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

From: Daniel Golle <daniel@makrotopia.org>

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

For now, NVMEM is only registered for the whole disk block device, as the
OF node is currently only associated to it.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/Kconfig             |   9 ++++
 block/Makefile            |   1 +
 block/blk-nvmem.c         | 111 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   8 ++++
 block/genhd.c             |   4 ++
 include/linux/blk_types.h |   3 ++
 include/linux/blkdev.h    |   1 +
 7 files changed, 137 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706f75c92bdf8b648f7c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  typically used with eMMC to store MAC addresses or Wi-Fi
+	  calibration data on embedded devices.
+
 source "block/partitions/Kconfig"
 
 config BLK_PM
diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800ea266190a43b3e63d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
 					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
+obj-$(CONFIG_BLK_NVMEM)                += blk-nvmem.o
diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..4b35a74255059320ef0cbd3c0003f1510bae5733
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * block device NVMEM provider
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Useful on devices using a partition on an eMMC for MAC addresses or
+ * Wi-Fi calibration EEPROM data.
+ */
+
+#include <linux/file.h>
+#include <linux/nvmem-provider.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/pagemap.h>
+#include <linux/property.h>
+
+#include "blk.h"
+
+static int blk_nvmem_reg_read(void *priv, unsigned int from, void *val, size_t bytes)
+{
+	dev_t devt = (dev_t)(uintptr_t)priv;
+	size_t bytes_left = bytes;
+	loff_t pos = from;
+	int ret = 0;
+
+	struct file *bdev_file __free(fput) =
+		bdev_file_open_by_dev(devt, BLK_OPEN_READ, NULL, NULL);
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	while (bytes_left) {
+		pgoff_t f_index = pos >> PAGE_SHIFT;
+		struct folio *folio;
+		size_t folio_off;
+		size_t to_read;
+
+		folio = read_mapping_folio(bdev_file->f_mapping, f_index, NULL);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			break;
+		}
+
+		folio_off = offset_in_folio(folio, pos);
+		to_read = min(bytes_left, folio_size(folio) - folio_off);
+		memcpy_from_folio(val, folio, folio_off, to_read);
+		pos += to_read;
+		bytes_left -= to_read;
+		val += to_read;
+		folio_put(folio);
+	}
+
+	return ret;
+}
+
+int blk_nvmem_add(struct block_device *bdev)
+{
+	struct device *dev = &bdev->bd_device;
+	struct nvmem_config config = {};
+
+	/* skip devices which do not have a device tree node */
+	if (!dev_of_node(dev))
+		return 0;
+
+	/* skip devices without an nvmem layout defined */
+	struct device_node *child __free(device_node) =
+		of_get_child_by_name(dev_of_node(dev), "nvmem-layout");
+	if (!child)
+		return 0;
+
+	/*
+	 * skip block device too large to be represented as NVMEM devices,
+	 * nvmem_config.size is a signed int
+	 */
+	if (bdev_nr_bytes(bdev) > INT_MAX) {
+		dev_warn(dev, "block device too large to be an NVMEM provider\n");
+		return 0;
+	}
+
+	config.id = NVMEM_DEVID_NONE;
+	config.dev = dev;
+	config.name = dev_name(dev);
+	config.owner = THIS_MODULE;
+	config.priv = (void *)(uintptr_t)dev->devt;
+	config.reg_read = blk_nvmem_reg_read;
+	config.size = bdev_nr_bytes(bdev);
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.ignore_wp = true;
+	config.of_node = to_of_node(dev->fwnode);
+
+	bdev->bd_nvmem = nvmem_register(&config);
+	if (IS_ERR(bdev->bd_nvmem)) {
+		int ret = PTR_ERR(bdev->bd_nvmem);
+
+		bdev->bd_nvmem = NULL;
+		dev_err_probe(dev, ret, "Failed to register NVMEM device\n");
+		return ret;
+	}
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
index ec4674cdf2ead4fd259ff5fc42401f591e684ee9..ed0c10168ba7be10855509637f824a9cea2b9ccb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -757,4 +757,12 @@ static inline void blk_debugfs_unlock(struct request_queue *q,
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
index 7d6854fd28e95ae9134309679a7c6a937f5b7db8..1b2382de6fb30c1e5f60f45c04dc03ed3bf5d5f2 100644
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
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c09e0ceaac41ba59e86fb0c4efc64..ace6f59b860d0813665b2f62a1c03a1f4be94059 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -73,6 +73,9 @@ struct block_device {
 	int			bd_writers;
 #ifdef CONFIG_SECURITY
 	void			*bd_security;
+#endif
+#ifdef CONFIG_BLK_NVMEM
+	struct nvmem_device	*bd_nvmem;
 #endif
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 890128cdea1ce66863c5baa36f3b336ec4550807..f15d2b5bf9e4fd2368b8a70416a978e22c0d4333 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -30,6 +30,7 @@
 
 struct module;
 struct request_queue;
+struct nvmem_device;
 struct elevator_queue;
 struct blk_trace;
 struct request;

-- 
2.34.1

