Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6244E025
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386205; cv=none; b=uPlguLnfHH7m7h6C0DtMFVs6J4fTpdmRZNam/4sp7z0m00air9RozKr3AhF2piKzwg6RPj2Z8rfvJSVfvCgKrWS8aMdfUJVTC9onmp2BBFmzEYny829CFIdYqdvnlajxq77l4DRhXke2v4gI7ycQ+m/p/lVGN9+cQEwR5VQmrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386205; c=relaxed/simple;
	bh=lN5UQLAw786XNpBVzweElxIfw6eaZ0HrStvnhyBZ5No=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llkF1ig9OmO01ty8bHj+I1tr/ZTObcjLPpKzlx/OjdPEi526WA+oFpuSdBSkSwXpfo1ZAkyRAv7y/iKRkcZpG6i7TYNUZ6nAk1gp76R2wulM+hMJyU+yAFceyxsmn51UnVL4/5jiO5bMDqVeZL2GMo0oZlrGpLHjBzsdhhrrsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b1SqOvwx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OYaaE5vp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b1SqOvwx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OYaaE5vp"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SDOKqH3967994
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wfgrsp3+OXcemYYLvo9SkPw2QHC3Nuf+HBxk2NFolPw=; b=b1SqOvwxePq20lsa
	leNNsisiDEHCvr4Yyygj/28n9cMo3mjjjiOsw0r/GuEHg2L2RDbdhrI1a92eKHJ6
	4+r2Fw/O47qGZy33jZ7WwA/3VF8gto6MSn3uyP6ScvCZ2FlhfuJnccjToE8EyLaT
	M8q+KP9+kjv80xsdnMVQC4d3X1Wuq8BkDY5r04Z7ruIAgCuLGlgbK73cWq/h5ak9
	nEg/ezjKhI3XbUZ1zzcD9t//Ejsqb/0LAkCtv8mBe43lNY2McRws/gSWIzcoyEJl
	X87uFQV2bBH8gdevOHCKddTRDLBk6WcJSQ63vny4PJhCrCKmfs5efc0B7HXASypL
	wkQjBQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0hgr4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:21 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5662a21d35bso23328983e0c.2
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386198; x=1777990998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wfgrsp3+OXcemYYLvo9SkPw2QHC3Nuf+HBxk2NFolPw=;
        b=OYaaE5vp7MTygn8cm3pitZh9codPJXaWIgBt3BIMatax83bVoGnuNUb8dO6ApV1Jl3
         vp5UoP8KY6klfCHKxTQpdU9lws0xOXAhC0YON+08pBn6QqYu0GOcF2gRgiV3UPLI5vOn
         tL1r5rHTWY7RhHAcDyZBH0Il14FyqOaUfbaAR6KZiI9+c9FdFlO6rMQMf97sn02lugLN
         Eb6v0RPrtZegKdKwuvM1E1nqTbWABHzZvvF8gXw77wFbopFR4KqHysrA0GzDr5Moucnk
         SOYvf6fFHAuUgVfYQnDwpU6fP7fu6B0cWWnnVc9MB5DipwtXbaKbgdOcps034dInIZed
         /G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386198; x=1777990998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wfgrsp3+OXcemYYLvo9SkPw2QHC3Nuf+HBxk2NFolPw=;
        b=tQNLdXBfnRLTd2+Y/OCMOLRkZavV2H0Fn9wEvN2kCQ5uAEinX9iwOdnOUYm+E36Im9
         HytjD69hZ8zl+IjG5HpLOU7xUXbzhmQsKktjcfdXieX89xew5xDGVeKeDJSFl8d8IU4z
         Ig8gKzs/JI/t/q9iiD9C0K8RWQ1PM/ds8xY5CRpQQZzcOQxpBYxpKpZZwHGuuvfUKdHB
         jbWliZYE8o5PNVvkxMU6Kh2n+Sr4G5q82kOK0j342HCXUqQEb26UbWwQ3pG9PF2B9mn5
         QauVd8ImBNiPC9JnCsROjt5Lyr3AaNma+d0N+D4fDwQ8AoXb2RUgqkCo6Su5yM7SdU3n
         WZTA==
X-Forwarded-Encrypted: i=1; AFNElJ8QH84ZjGoZD8rHlOKNhepnl4gm/B5N8hv6oNobhkpKSudu01m96mh1UesCPXd4iZNiaQH+hWybTlwi5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcIyf6Qg+sBsLn5HW5ouRrXZcLqpkxK/l+rHzrPoccKHfygcIH
	FlQod+fpwAZIGgm5XWmCDPKYI986qcSQzBjcQ7FVBCqZgyzkbugJkQ8RasVt6F/RidLJ5vvKcl0
	tpSVCvjVwpDXkhN+FfzoML4DvvhgX8W/iYAX6bDVxIvxIMcW48moI/1T5mk4FhOICbg==
X-Gm-Gg: AeBDies7eD1y1TYJEEb6qUUMEUsDXaNV94oamwd+1doCh96cfrjGrg/nWox80wkFt/b
	K1xyJfVKudCsfqQb61GOoYuyUwfLukLYWwqsj9mcmhg6vj9tjn0Kfznia1V+5kpnQA8IwEHcDuR
	axYtMr5jNHgNSvTJZY4+76IZhWyIQy0GZcYC1QsMH8WPqVeBMXmMcR03LToIhmgQR1UBO0KsaL+
	J6/J2A5hiOUeXtYxza3N+QCQrITOXUmj9i3sPhZiAIJcKsx2tZnxnJB6372vPicUxfOZ9Ek/fcv
	4xPfI3WUjFA0PmgP5H+b/2IlNMNX8/Jb2ikX5HrMeUvKyF6eEoaQwrB8tUzLo3APPBg13OzS7MB
	wjCsc3ad4tjfYpWFDb1kSRO2JxLCLxE5zp+iYFwl/V/sc2kzY+wLY4N/HHzSP7OuklJx9HL0cEq
	X3bc77ZSux3My34vjgota/8ig20F0=
X-Received: by 2002:a05:6122:4201:b0:56c:860b:c34e with SMTP id 71dfb90a1353d-573a55b83fcmr1685509e0c.8.1777386198172;
        Tue, 28 Apr 2026 07:23:18 -0700 (PDT)
X-Received: by 2002:a05:6122:4201:b0:56c:860b:c34e with SMTP id 71dfb90a1353d-573a55b83fcmr1685459e0c.8.1777386197727;
        Tue, 28 Apr 2026 07:23:17 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:16 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:08 +0200
Subject: [PATCH 3/9] block: implement NVMEM provider
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-3-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f0c2d9 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VT4XjZGOAAAA:8
 a=EUspDBNiAAAA:8 a=0xOXAJtWE3glxeOP_3AA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-GUID: XGAQRL2qEvuRpUoeNOkiTEXgoVki0gdL
X-Proofpoint-ORIG-GUID: XGAQRL2qEvuRpUoeNOkiTEXgoVki0gdL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX+QUnbUTkTqA0
 F8DfPr34JRD/9Y5KuyMaWkQk+DMmw1xfU2oXs9s4bg0bxMjUT/LJ/AqjIH4p4KiunsTRTZE2YbO
 pctIm9ON+tyZgX2sULIMPrcBd0MVJ/ko+fE7O32D6XqQkMeCFDWPZCPLeH6x+4uT6cJOmXWeeQI
 AZ5h2qBkZ0JboGOiWsQ8ZVlg0VuX7hNJRfWuAXfgRBlQUKj0oonVXrDPnISPzQ0WG9LxM9ADWCa
 CfEdIssJx77BTgMcEuIpGct6ajh53ce25oXhFV8TdiQ174sm3L+EIn2bCoY+sbg2lDJ8STI/0lP
 s8PUFQMh7TEGVVLCEOwJo6CJ5FuSMEqvdRGSdQxNfVrEHOwSvmcSutj7yYh0KrJsP6ffMPipzKE
 NWPWpjQBwoq4Dc1GKt5/22WqCfDrckYnghiu/2lNzy2k27h/4riU8gGCGQunCjyRsxymdgTvdbc
 FGJ/RBADrxLqC89yX9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136

From: Daniel Golle <daniel@makrotopia.org>

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/Kconfig     |   9 +++
 block/Makefile    |   1 +
 block/blk-nvmem.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)

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
index 0000000000000000000000000000000000000000..01b67c638a6dfd1393043024b6a7f3ebb947a57c
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * block device NVMEM provider
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ *
+ * Useful on devices using a partition on an eMMC for MAC addresses or
+ * Wi-Fi calibration EEPROM data.
+ */
+
+#include "blk.h"
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/pagemap.h>
+#include <linux/property.h>
+
+/* List of all NVMEM devices */
+static LIST_HEAD(nvmem_devices);
+static DEFINE_MUTEX(devices_mutex);
+
+struct blk_nvmem {
+	struct nvmem_device	*nvmem;
+	struct device		*dev;
+	struct list_head	list;
+};
+
+static int blk_nvmem_reg_read(void *priv, unsigned int from,
+			      void *val, size_t bytes)
+{
+	blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
+	unsigned long offs = from & ~PAGE_MASK, to_read;
+	pgoff_t f_index = from >> PAGE_SHIFT;
+	struct blk_nvmem *bnv = priv;
+	size_t bytes_left = bytes;
+	struct file *bdev_file;
+	struct folio *folio;
+	void *p;
+	int ret = 0;
+
+	bdev_file = bdev_file_open_by_dev(bnv->dev->devt, mode, priv, NULL);
+	if (!bdev_file)
+		return -ENODEV;
+
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	while (bytes_left) {
+		folio = read_mapping_folio(bdev_file->f_mapping, f_index++, NULL);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			goto err_release_bdev;
+		}
+		to_read = min_t(unsigned long, bytes_left, PAGE_SIZE - offs);
+		p = folio_address(folio) + offset_in_folio(folio, offs);
+		memcpy(val, p, to_read);
+		offs = 0;
+		bytes_left -= to_read;
+		val += to_read;
+		folio_put(folio);
+	}
+
+err_release_bdev:
+	fput(bdev_file);
+
+	return ret;
+}
+
+static int blk_nvmem_register(struct device *dev)
+{
+	struct device_node *np = dev_of_node(dev);
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct nvmem_config config = {};
+	struct blk_nvmem *bnv;
+
+	/* skip devices which do not have a device tree node */
+	if (!np)
+		return 0;
+
+	/* skip devices without an nvmem layout defined */
+	if (!of_get_child_by_name(np, "nvmem-layout"))
+		return 0;
+
+	/*
+	 * skip block device too large to be represented as NVMEM devices
+	 * which are using an 'int' as address
+	 */
+	if (bdev_nr_bytes(bdev) > INT_MAX)
+		return -EFBIG;
+
+	bnv = kzalloc_obj(*bnv);
+	if (!bnv)
+		return -ENOMEM;
+
+	config.id = NVMEM_DEVID_NONE;
+	config.dev = &bdev->bd_device;
+	config.name = dev_name(&bdev->bd_device);
+	config.owner = THIS_MODULE;
+	config.priv = bnv;
+	config.reg_read = blk_nvmem_reg_read;
+	config.size = bdev_nr_bytes(bdev);
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.ignore_wp = true;
+	config.of_node = to_of_node(dev->fwnode);
+
+	bnv->dev = &bdev->bd_device;
+	bnv->nvmem = nvmem_register(&config);
+	if (IS_ERR(bnv->nvmem)) {
+		dev_err_probe(&bdev->bd_device, PTR_ERR(bnv->nvmem),
+			      "Failed to register NVMEM device\n");
+
+		kfree(bnv);
+		return PTR_ERR(bnv->nvmem);
+	}
+
+	mutex_lock(&devices_mutex);
+	list_add_tail(&bnv->list, &nvmem_devices);
+	mutex_unlock(&devices_mutex);
+
+	return 0;
+}
+
+static void blk_nvmem_unregister(struct device *dev)
+{
+	struct blk_nvmem *bnv_c, *bnv = NULL;
+
+	mutex_lock(&devices_mutex);
+	list_for_each_entry(bnv_c, &nvmem_devices, list) {
+		if (bnv_c->dev == dev) {
+			bnv = bnv_c;
+			break;
+		}
+	}
+
+	if (!bnv) {
+		mutex_unlock(&devices_mutex);
+		return;
+	}
+
+	list_del(&bnv->list);
+	mutex_unlock(&devices_mutex);
+	nvmem_unregister(bnv->nvmem);
+	kfree(bnv);
+}
+
+static struct class_interface blk_nvmem_bus_interface __refdata = {
+	.class = &block_class,
+	.add_dev = &blk_nvmem_register,
+	.remove_dev = &blk_nvmem_unregister,
+};
+
+static int __init blk_nvmem_init(void)
+{
+	int ret;
+
+	ret = class_interface_register(&blk_nvmem_bus_interface);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+device_initcall(blk_nvmem_init);

-- 
2.34.1

