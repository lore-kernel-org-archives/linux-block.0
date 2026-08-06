Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86AA480335
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027153; cv=none; b=E7TjSGTHrkk0vgVNVfcjzBsBy/UVLfvJuNx1aYeN+EZxawfd9RXDA5yNeSIgyI6aYJFIeYyd8z5nVxDKvl4OLwmYbSa94G0BfsPERpTUWKHAeWQ3m/2M8RAHU2JaJ4pM7vsoCIgXe0Ue1dD+1g5xkRTBW7k0TQwaUmha0ZgMtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027153; c=relaxed/simple;
	bh=uhpDyIoGXajFOzs4zO0R7BhqrSY1CyahIEnZEYC/lAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGWebNgi5GJTCV7efiE6LLypEQg7J/f4Bb3xFbilcWdb/a5c9RJ6yQ9ybCYSGxla+yj+C12Z5QbxUIGPn9789PkF8GSFfLTVufA2I3Fd3bI9ErCHx2v7dxN3yUGt4TkS6HDO34ZOWb/G1hYyKaq+Bf95h4rv5KG6E37vMXLSXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TCzLLmkl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PmBrBW2t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TCzLLmkl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PmBrBW2t"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nfNf1580758
	for <linux-block@vger.kernel.org>; Thu, 6 Aug 2026 14:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SkfAnMQDHbMi2DKEw9B9JDdOl1z4aZR7BlMrHcVf2Tg=; b=TCzLLmklckCWLwgB
	EHmYTcVuGsmvFTyYFnSJeCxCLQJ4cT+eu3toRPVOpxU3lxdHUXKeiUTwLqUpi6y9
	YGuaUrGGuF9QVIJwepkptpeGyt8G+gXfl2rHLev9I9kjYGL6leKvPQbyPonCPABG
	ZPbjCurLPaAEbQV12DzbHbXdYEkF8X8lLbA94Oy2tegml44YUetmI12iwazbkUBr
	O7ddWPxxQE53onXqoZW1MfPNtzNkViLMx6nvuTIflNX9qHKuIA3KtAklrLjUUiIr
	3vlWgSe6X22uw3ZX+bJfHln4mIkT6qie1Viq9gguvrikNOZEU3Z6++RV25ZPeRhp
	eVGZAg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvmrjj8qs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 14:39:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a8b0a08d2so17979011cf.0
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027149; x=1786631949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SkfAnMQDHbMi2DKEw9B9JDdOl1z4aZR7BlMrHcVf2Tg=;
        b=PmBrBW2tG3cjzuiC1TuxN2PZ3WaLR2xk/SV2DR3Vf22AhAek47ZmXI0BzdFxmVvGZY
         V3TYH1S2wxAqO9Sz8VrlhLxgqefbg6EV884fXugHRJ9QOF8haHwIt7+AyPnMGW3VRY8V
         6kjnZiw6C5LDfmAlo/jX8sDRCeGTsb1ZsXt96t0+feRpWA/yPzzea13iy1h0ZcBMq7fx
         ikmAwH/M9Itsw1FOTOEZWzNaT3gsy8H1E/TJJTAdNqF1laEFWoqdTH9vi2QDXmXQk/cJ
         guA14LRhpmWJQzCqJoC3v5mAGjDHDuoufvyxeuJX7FTRNj5obKI7gpYEiLr3MK+XkbDO
         hlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027149; x=1786631949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SkfAnMQDHbMi2DKEw9B9JDdOl1z4aZR7BlMrHcVf2Tg=;
        b=CKKreFXOedRJ93CNlWgbBQfEmGXPESP4Ef8HekZkMy/h3QpCHl9jrbx2syU1LmfHbm
         d+N6S3tgcvFDtsPMKfCEtLozTR02EqlTcmfxmt2jQG9hfdkPks09cf8eCaiFi/huDKXE
         SEmZSaWZe5VwVnfYCZ+NyWPMazJkVeWCq8A69jk7X/gDpxShHxSrF+hPQRljEyiJgnxh
         ycDehoCK3NYX7nLHTg3G7M8fGhvvDkYEMj9AUzD3VgCHlk1xOlM8FZ7Qp1LzDCbBSiqt
         QhQUTCkubzpDW8kPqtoze4gDLm+8+P0VDgVw89AVRhlBY5LwTNAooL64ujp0d4zrBaYH
         XV3A==
X-Forwarded-Encrypted: i=1; AHgh+Ro+LmiAqWu0KHOBzRYWBvQIYVkQkz4Dnwa4niOu9cBQsPJWZnbK+QFCnG7TS10rXVma4c95ZcASr9y4dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRn35PoN6Zl5LE/IktLjaaCZQoPQQQJdj2v1I814Js5Oz7JHcR
	2mla41J2fiGvn7EXzjJXgnuj2TyhbpKoamvd+WUtdV+KipNTIsapCE5RfMDZtytnD+ar4EjiBxC
	Vjm8AKMwUYzWylWobGE7TVOdJEmzgIECthHICpv7rUGDMNyB8iFNa+R6yO3SdZQjLWg==
X-Gm-Gg: AR+sD13tEYA0ulXCFIhM03BAXK3Ncm2dKyoi2OVQyw+54tuPju+5CFJesd//frP7sbp
	ie2iDEINDM+E/CG7kDbwyXCTzBAwgcJBWpnPPHk32AEBB/sZpy1kUXYJtsnRTnzYR30ArimJZD5
	JeiodpDVzeZZkVipeZ1D93eu+XBn//YqbJFI/cUdbB5tbRIbNuwfNEux0xTC2TiQV4xJYAwEpLm
	z2hDhyVeWZes/ocEcxDTMblleOy8WKA3dyrBfvxnsjjt6i6O3dzralYaTLzf7GXU/2gL2hbueUs
	aCjsRTqwc6KNIMbvpy8CSzJTa5uYkTKIL+QAY+mPs+SaYRVqHXj0wr6mkWI6V02cW/DcNm72OrA
	hGwiAOcpot+zTreVYMvR5oC6S7O7xXpJTGWgenr0LilTewreA/UA8E+thaFK1Uhls0rzWizPHeW
	iMmgpwz3ObOB4fx8kXDaCjXVIDoJqL5BwULv3MDtonmrdPcsKE6A==
X-Received: by 2002:a05:622a:1ccc:b0:51c:9b44:c59e with SMTP id d75a77b69052e-52ce60d3fd2mr170035271cf.22.1786027148395;
        Thu, 06 Aug 2026 07:39:08 -0700 (PDT)
X-Received: by 2002:a05:622a:1ccc:b0:51c:9b44:c59e with SMTP id d75a77b69052e-52ce60d3fd2mr170034201cf.22.1786027147897;
        Thu, 06 Aug 2026 07:39:07 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:39:07 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:41 +0200
Subject: [PATCH v10 08/10] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-8-be598b2a5606@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=VNPtWdPX c=1 sm=1 tr=0 ts=6a749c8d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=ZruV3ba3MPUC-7CJ7xEA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 8ICSiDaNMI9V8ZkXbaxe0gEeB0eIPhoi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX0W9EwrzqncK3
 ekYxee1kSBOqQQ3FuWuv/PFdJvU+YzgCEJjUGob9lOwzDLF7Kk8HWw1pB6VWmdu/1dDEP6o1Gla
 vWAoOysQrouQmRAoyh+J2WS78KVSsl4=
X-Proofpoint-GUID: 8ICSiDaNMI9V8ZkXbaxe0gEeB0eIPhoi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX6cQ44WT9Dz06
 kqYbSU4BnxKWqcbEKuu3BjIu8/SDUkZ0nqyMD8o66NoNkZ38bGJeCYOUbus+XOrIxooUnIouSXq
 dh42RhbvMf3ZAaANxHwB68yprSDbzOGLzEYBiHvFJRMrQxyIP+YUIxHLdblt0+wB2WwswCTBcPE
 0TXaKpG4eO1rgip4Otf26epvWMQF1hQlvE3g6LSjM4bkAjilutzF9v7Sfy5SNB8AKyvV6pX/AGJ
 psCb9MlknqJ1Ljyk9CMpiUbjgtdpgcylBOoEU0tqH4CoXst+6Asyn3bjcMBnms8STiMBDdJZfrJ
 cLD0tR24Crn443nq43TBzQUG5L0ntikaRiMzf6Exg6DDGzd9WOv4wbVV/Xiqi/6GHJlgrsBY/0M
 WPQMlqjTNns1nBpG2SfBr6Dcq1JF2ELsvBBFCM5SERatP3cakfoRcGF7bJEpgspcKT11NVMJ1Yh
 UzGl08tEAMj1QZpIwuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060114

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 net/bluetooth/hci_sync.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c        |  6 ++++--
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 38186a245f14dbd2a26cbc331e7f1b3e72f1a607..145ab94e51482f903f4c9133d8c97561ac1c1e00 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -161,6 +161,24 @@ enum {
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
index 3be8c3581c6caadeeea56e14e09d4123deb4ec03..c0ed7fb14d19bd79429a6892ec1c7cc89bc7ab3a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/property.h>
+#include <linux/of_net.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3593,6 +3594,39 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_nvmem - Get the Bluetooth Device Address
+ *				    (BD_ADDR) for a HCI device from
+ *				    an NVMEM cell.
+ * @hdev:	The HCI device
+ *
+ * Search for 'local-bd-address' NVMEM cell in the device firmware node.
+ *
+ * All-zero BD addresses are rejected (unprovisioned).
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int hci_dev_get_bd_addr_from_nvmem(struct hci_dev *hdev)
+{
+	struct device_node *np = dev_of_node(hdev->dev.parent);
+	u8 ba[sizeof(bdaddr_t)];
+	int err;
+
+	if (!np)
+		return -ENODEV;
+
+	err = of_get_nvmem_eui48(np, "local-bd-address", ba);
+	if (err)
+		return err;
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE))
+		baswap(&hdev->public_addr, (bdaddr_t *)ba);
+	else
+		bacpy(&hdev->public_addr, (bdaddr_t *)ba);
+
+	return 0;
+}
+
 /**
  * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
  *				       (BD_ADDR) for a HCI device from
@@ -5072,12 +5106,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
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
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d23ca1dd089365fe4606600c68475dceb561e5ee..42b6866f96a4c81850d98041b34b7fcb0f9d0e47 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -614,7 +614,8 @@ static bool is_configured(struct hci_dev *hdev)
 		return false;
 
 	if ((hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY)) &&
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		return false;
 
@@ -630,7 +631,8 @@ static __le32 get_missing_options(struct hci_dev *hdev)
 		options |= MGMT_OPTION_EXTERNAL_CONFIG;
 
 	if ((hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY)) &&
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		options |= MGMT_OPTION_PUBLIC_ADDRESS;
 

-- 
2.34.1

