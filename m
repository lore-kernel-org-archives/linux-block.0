Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03474657FB
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386219; cv=none; b=Ipl0bOVukFFNMxoBDylpWOXJrslxxNnyub9Q0LPUPnhGPINA1lcmhbdLtbst8wiwJx1JWVS6YFUXEDUqUo2wFNLYGaUKomz6cFY7FzpzqX22Y8I075qZJ5DZz9EhyC67YvbT04MKtMthNed/e8NqnePjlzEXoMJdF7KZmzB0OoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386219; c=relaxed/simple;
	bh=JHOUVT0V1f6mw0N8o8TQITsurij+VJ8yGqDAQM2x4i0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QzVD4wKX0Wcf0A+B0QoWDaL5tHVFzLqX5SeserBtp8Sl65nhihBBTp+POajxvHybxDB5EHJd01P0LTht9Nmo8/GeG+XINN1qLTTMuhet3dqW+Wjm0Sz2QEa40pbktzAqnSEnYo4cnEnw2KLTsL3AdzC5sTUPIO9L9ou5wbev8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EcpAQh6T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JGCxDVa7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EcpAQh6T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JGCxDVa7"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SDULq61744711
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Q1pBVZE4xUj8/QalPHOJhwaMsZksGiJpCvGtPNlm6s=; b=EcpAQh6T9qPyWr8l
	yo7/iDh2mvD2DmoZ3LQIwNGfL8V4wJTtdC2zRUwwoXlwlRKw7tuOUg6KOifU/4CP
	UrnUdvNmG+IvkyXs+9OstpsQK6fmAMM9MszTdh+SBWw4GJhbcoH2O2H0sCXclvQ7
	zoQQHAxmYz57Lr4TzeDb6+Jr7aXyC6L2tYn3tLfT/nfiK/O4c/WIlXw5WlgrjQBl
	/Hew6k6EWh6JBV4EyzP1TFMWHhfVzoCxdksYi8IHo4xF23hRwQ2L8nqYY0/RS+8H
	ksRpS6lFHVd3bJAYFxshm0dDtohw4J3Yyx1GzURiV5VtZ3cRULJSRIAlJ418s5Qh
	CVh6MA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtryd9jgv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:31 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56db8ed8e40so9892899e0c.3
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386210; x=1777991010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Q1pBVZE4xUj8/QalPHOJhwaMsZksGiJpCvGtPNlm6s=;
        b=JGCxDVa7xDL3CmLidLCAsUs+l7bdiNDKSJ8Uch2sM7jiSyOzwEZTiqCws9hMyw0s2Z
         kZfe4Uo4vx06KZpEwvjUqSTCwy+DP7N2moOCB4WoMiVCUuIEZ0X/tCF97PCB45D2PN+h
         UbhI/eyeXoUd+i7og0r/++0EUyL9F9kErQFVPFjF0WgdQ7JGbFtf+GAwB7c7JhqlCTRN
         utUyfXcUvMDVjhKX7dEXoj0RdroXsf7H9jKlM36ekx25clmvdggnXLDGGMxPHJ2PuqyR
         xpjfSzw4WNX8WyPODAth4jESX/0G2TCCwhhEZtywoCnI9wBXsArqYeb+b64Qd2G5iTDH
         xIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386210; x=1777991010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Q1pBVZE4xUj8/QalPHOJhwaMsZksGiJpCvGtPNlm6s=;
        b=nxGjuIhlgql8o4V5TH90fyHchWlFAkBVKOScSfnxutmeAEnYSw0fbCZNPcHHd9rgyR
         z9THAk8sCT2Vm+Q82mYvaDvU3SWAlOT9gAOIcqlt7wIfxQXLhEYBBHPPlrZRK0kijlbC
         HXRpQAJeWntCMnX/N+BCMlLnx6VRLbiRoi42bqehMyNP/rPZCfpJQH0Cn7qC9wMQe47c
         4li522Jm2WzKIbGqzoXO3c+g//JMOXjODDJ4eSwfPX9KcgKtlz5/FaYhbFynF6WqqMX0
         /23kLrzbJE9BZFijgFh3nOf8b9gfkTCwD0Sy2EnHw3ucnn9Fqhhuhq83osg2uTG2TmmA
         mM6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+iRv5R7noBQX6Qh1aGf5KtrKfIfeZJL5F/iySZQaKsgENyMYXRBL2eIJalNidDeOocTdZLD86G01cBmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyE15IDvmwBmTmc1jcKnJCwhS8/AX8Lk5sr+BLHkWq5EEnhH/59
	PE3KmITONKeN994Meh9niwBtzd7k4smneB3T1+TD7Wal1xeW21W029+oh9ziET8tIOYlR0eUgMR
	WE7zkmFYFqylzsDJCKANSHlhsilIowiPym6wLfrkwcrfujfsxWstRYLu6C+X4Un04EQ==
X-Gm-Gg: AeBDievy0xBGkZdvxcr60j9ys0UM7nclHuei5q0zzbt6GtnahOKjSwhP5q+xsHeTiFc
	8pEZZ7eg0/mHiBFpkTxTOeEfl5BD141IDYpyTsMcjEhRmSB658xxWhvgG+uKENKqGF9XjXmS24D
	HBscNEicgSbRrG7VzQuJ8KJ2Yn1undNvf2g4kVdlZDKIUBJa26D88VLOhwogJmgDOyx1V5LchxW
	QIWFarH0m8oy9F+rFtR/SgAVmZ/kd6l/F1PmHJ83WP5e9xc8lzcjete0+j5qGjeZ0oMBCj5bxQg
	rB8n42j/95bi5sCTXw1ZxDCT7ZTesIOKpViOBf4caA91mWMAj9KYEcuToKertZMy6MWDR4KWUsU
	hf3yQo8LbZnFhgMvg+9VayT4Pe/GaimnDIM6VxCw4tbEfPoPe4r23Mrf4uG1zj0aND44Dv40KYB
	ty5bpPG0M9wGl1lCHRn4feSVlwHYU=
X-Received: by 2002:a05:6122:83c3:b0:56e:f262:9113 with SMTP id 71dfb90a1353d-573a574bd4emr1580875e0c.14.1777386209952;
        Tue, 28 Apr 2026 07:23:29 -0700 (PDT)
X-Received: by 2002:a05:6122:83c3:b0:56e:f262:9113 with SMTP id 71dfb90a1353d-573a574bd4emr1580768e0c.14.1777386209190;
        Tue, 28 Apr 2026 07:23:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:28 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:12 +0200
Subject: [PATCH 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-7-6ad23e75190a@oss.qualcomm.com>
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
X-Proofpoint-GUID: C-M3PbwlUUT-lkQicO7Fexv9Ac2IE2_T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX1jX4KWHLxug0
 WDwNXxJ/+/IlGzwHS7zbOPbOpkn4fCKBUU9YB31DMwF3rokvhXXk27l0zXwUwniTnny/9OwD6XZ
 nioLKPuMW/EtWSnZ7FACQLL8I2vaeXg129frnG294mDr2oYEPNvMnFJU2IrE5A3lWSiBEMrZrvv
 f2knnXFMAnJPUIYTIbIEs20Lb0MlQ0q2go/SXLIyhdCdBlAtxTP6EFyT9owoLAjaCMEIgP41NdO
 8FEvuCXYprIYRRq2LbnK+SiFd1JNftaD6AOHeMW10oAbB1ZD29Us9PjNeWDOqn9lYqwpYP28KZE
 4OpHtJQI74GchyZ0gHwhkoDpLyIDlmV5EBpxwhp1zT67g+ngYJvxMSndSYkHb/vcanvUg+pQkvw
 g0i6foEF+j/2mn9HfoeP0au/WE008MH1p/HcEq36bO0g9iTWYNWEQZBKZj6yWBJICM246fzRy/F
 R2Zwg+cj3O5pz7VdB5g==
X-Proofpoint-ORIG-GUID: C-M3PbwlUUT-lkQicO7Fexv9Ac2IE2_T
X-Authority-Analysis: v=2.4 cv=cMnQdFeN c=1 sm=1 tr=0 ts=69f0c2e3 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=teJl78XSWlBvCPfQsyoA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 18 +++++++++++++++
 net/bluetooth/hci_sync.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75edeb5f6a99fb98ce4cc6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -164,6 +164,24 @@ enum {
 	 */
 	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
 
+	/* When this quirk is set, the public Bluetooth address
+	 * initially reported by HCI Read BD Address command
+	 * is considered invalid. The public BD Address can be
+	 * retrieved via a 'local-bd-address' NVMEM cell.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_USE_BDADDR_NVMEM,
+
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' NVMEM is stored in big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BDADDR_NVMEM_BE,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512a37c22b9a2be90c89ddca4b4d99f..f87cb6ae85c3a5754fe79f415ba05dd177f75fad 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6,6 +6,7 @@
  * Copyright 2023 NXP
  */
 
+#include <linux/nvmem-consumer.h>
 #include <linux/property.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -3588,6 +3589,54 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_nvmem - Get the Bluetooth Device Address
+ *				    (BD_ADDR) for a HCI device from
+ *				    an NVMEM cell.
+ * @hdev:	The HCI device
+ *
+ * Search for 'local-bd-address' NVMEM cell.
+ *
+ * All-zero BD addresses are rejected (unprovisioned).
+ */
+static int hci_dev_get_bd_addr_from_nvmem(struct hci_dev *hdev)
+{
+	struct device *dev = hdev->dev.parent;
+	struct nvmem_cell *cell;
+	const void *ba;
+	int err = 0;
+	size_t len;
+
+	cell = nvmem_cell_get(dev, "local-bd-address");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	ba = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(ba)) {
+		bt_dev_warn(hdev, "Error reading BD address from NVMEM (%ld)\n",
+			    PTR_ERR(ba));
+		err = PTR_ERR(ba);
+		goto done;
+	}
+
+	if (len != sizeof(bdaddr_t) || !bacmp(ba, BDADDR_ANY)) {
+		bt_dev_warn(hdev, "NVMEM BD address has incorrect format\n");
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE))
+		baswap(&hdev->public_addr, (bdaddr_t *)ba);
+	else
+		bacpy(&hdev->public_addr, (bdaddr_t *)ba);
+
+done:
+	kfree(ba);
+	return err;
+}
+
 /**
  * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
  *				       (BD_ADDR) for a HCI device from
@@ -5042,12 +5091,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
 	 * its setup callback.
 	 */
 	invalid_bdaddr = hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
 	if (!ret) {
 		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) &&
 		    !bacmp(&hdev->public_addr, BDADDR_ANY))
 			hci_dev_get_bd_addr_from_property(hdev);
 
+		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM) &&
+		    !bacmp(&hdev->public_addr, BDADDR_ANY))
+			hci_dev_get_bd_addr_from_nvmem(hdev);
+
 		if (invalid_bdaddr && bacmp(&hdev->public_addr, BDADDR_ANY) &&
 		    hdev->set_bdaddr) {
 			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);

-- 
2.34.1

