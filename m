Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135E53C3BE
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074400; cv=none; b=jBmPTiLRNUjdd16AN8pdahDavh/yrJNDldmf6IjyxihvBmv58cfxsV19d1gn5apwxd3/Elm7h+WfDG3vAOgBJnU4i9Y1M4dFBMEi1xpO7sxxD4nyaSlbxOxIGLgoOKvYLFaTMaZbL/p4lZ5GKX7uvxMCZo7XJZI0o8TSCM3E7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074400; c=relaxed/simple;
	bh=a8WAuizjOIp0uvWddVAkkazbg53HG363DU1eiQXDUGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orN8sltap8GSkxHfRgk4sKE5SoEvDC7b3E4DDBZ/acqZ/bn+HKUfL1EhJb2DiTkYGV+rxEWOM8Dv39QL+Pi8BkoGKSl4whPQdG1Rna5EGOS+Iy0MP6hEJVgf1eYIuOsacg843GXlZJgpYZTSXICNQhdawxCLWveoHRwYfvS3Q+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YcwVFhyx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vi7dqSUn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YcwVFhyx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vi7dqSUn"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jSsb2662666
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 14:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S2pLh6KbXd9OKT880BVflHuBCk2sw7UKfLHTzSWPYoQ=; b=YcwVFhyxfMrHENEp
	raSVyukRIDGjDfYeppHUHgebFWXvB4LYRB/MVNCe/T/B7RdYx5JkudSK4UqQBcHJ
	LNttiBotdFqZdwtMcrYDh7plOiWvJwkwbdlayekdVub022QeynZH/RrBn/N8YfOW
	ZPZGSU+xOAdSpJKpsd4FETRMc+wybVA17KYfkKj6AkFddmV29+Oo3e6iBGKiI1dS
	PLSdBVWwWYiY2hW0ZrFHmGe1AiKPVyGmZJLtyfxcKVdFz2rS4cvBekyHb7neTyuk
	Yik6xQXnx966gznMXS3l5wpdIpuG+mlqTGWQEQEZCFhCIRwXwj2lQqJJyL0tzGml
	d/ghQw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda2gat-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 14:26:29 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7cb225252f4so28010137.0
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792074389; x=1792679189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2pLh6KbXd9OKT880BVflHuBCk2sw7UKfLHTzSWPYoQ=;
        b=Vi7dqSUnY6AF2cF8vpLABrmyikMDqBQ/iJwtKONLPu52IAuFoPRn2s0ZAoLYKs/ZSN
         +aGmsZ3jt/vaM6Yf5BNefYyArv3E0RGJrpANmqkyi/K5jDL9tHrlEsb2uuk9ADIYyhuW
         MszFDLqh67q1Eks85abdrblmPovBsVixGMHZvqDPREAAaWnEsxu/kRhJzk9pxcsOBGvs
         tFNExpVaoTOxJN7Z2KQRw9XcmWqJP/TIIG1CeRFmUaAi/O5x/Ur3bz89GWy0tJnm5IAA
         mtSGQ3Ky4MbZpbx6c1YtV3bvDdD/fJY6szC6SLBGGyb4e8Qi6ZAtUAurgUhlUpEmESyl
         QSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074389; x=1792679189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2pLh6KbXd9OKT880BVflHuBCk2sw7UKfLHTzSWPYoQ=;
        b=pSv2TaPIxJxR59qKx5Ptns2cKppJH/c/YgDi5sfhkigoXFGWeN2CnDTMh36VDCxIiv
         ftU+D+OfVOWb7zyaB0qdl/C/UIEeoM9XfZ1MZo0TqS2jO7OjJWeT1VGqgIYV2w1FMZRp
         gp9CYDWiOD5FDUIcHZPlaas35FmEwKSpOU4O5c9EGS7rD1bX1rKuElRddTDKL2XtGP3h
         o4qPrddnYtd6lkUQxa0IyQ6g70mnchlF90M7HRNuUswYzX/9grzZHUIMXaUrHcOJvWlX
         Gjw9T0dk89mqmJf/064ynIRedenfOhyVYiirn4xJw+IPYOUhOMSudXBZmtnqoWILh0ap
         KIlA==
X-Forwarded-Encrypted: i=1; AKwUvByH0wMUkrRN/s0GMPROj5UH2njv3/0eDhCD38LL1qhEHfu1yed66vL3jSzsgHfXFH6Kd3EtYGYP59i7sg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJjzsuld+gFNrRckIyTnKV8xwPZoC/vU+G+Ka68L5vM41xQGBf3
	IP2Yp6MB1/H0F5rbGdC7WKvvlCw3AE2Gwm5hnUgw+xNIItJj4yWvK3nKfJh2ESOFL4AnZWVugN0
	QM8IitydH8H4DZ+tbj/cNIA5a+EiluNPVC5Jg7LZQAeSOEO6URYuQ+FUAstH24CloGg==
X-Gm-Gg: AYBFou10uqcTsxcu7kx0mlcyH+yYnw0fXtRp/S3Q+pBjzZPSng0NhxA/fU4N09HF8O4
	V18apWaPvprAlV+b8I00XbBdC5coTVhw+Tc5eVJy/r/1z69AnGIWSOoWzTTgOECHEeGWcp/yHE3
	13+m+8U27U6VHw6m32hpd+au1biEUsG+/cR9m+CDpJbpCdcQXPeSRNC6DFfsYbDGn0tlRyjndev
	rp7oyVjipTh7yk5m/7bFzKv8yzt7lwFR/aI7GteOQmcZGrcfQU2QYkSlL1SWgdzG8prGs9W28z1
	D9bN5yOHn6FOUX4/AczYYrYQKFagbEpWfNlqclZ2mv7A5zjs9LchDecVES7q+/+3SAVRFRt8UPm
	BNKkAXHe6RMl4zvrg48hB+/9TVJTh9jzlpXFJxkGqxMHkQh2lsPM3gKqlG6nIJalcGDB+7VNlOb
	ZqEL+BrHc0pN7nJJ2G0PodpDfhou8SSBpCeytTazhhI7sr2t9DbgE=
X-Received: by 2002:a05:6102:1941:b0:7cc:14d:52e4 with SMTP id ada2fe7eead31-7cc180e4504mr55364137.8.1792074388841;
        Thu, 15 Oct 2026 07:26:28 -0700 (PDT)
X-Received: by 2002:a05:6102:1941:b0:7cc:14d:52e4 with SMTP id ada2fe7eead31-7cc180e4504mr55320137.8.1792074388076;
        Thu, 15 Oct 2026 07:26:28 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5402:5e0b:9ef0:9b5b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6428b3sm69083145e9.1.2026.10.15.07.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:26:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:26:04 +0200
Subject: [PATCH v11 5/7] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-block-as-nvmem-v11-5-f890ac74f87d@oss.qualcomm.com>
References: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
In-Reply-To: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
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
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfXySK1+iG3pyqJ
 xVcY45G23DcG4X3wgabcSPsKIkYROt4VU8Wqq4/HMyMj10EL+W96zCay97dyLA1EgYPkqJLr3dP
 uq6BdtBqgYWLqrgMAftw6mrxmAWJwxs=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad0e295 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=QyXUC8HyAAAA:8 a=ZruV3ba3MPUC-7CJ7xEA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: QCyXovw23pZh7-tftRkZ40t7ikrkce64
X-Proofpoint-ORIG-GUID: QCyXovw23pZh7-tftRkZ40t7ikrkce64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfX+uYuISngL9WC
 kY0CakQXm2Wt+H4RF+mSHj904vH0pXJ+gaaIIsfrofTxF+YrlalAQUmbiHbvfwKANPzxJIo5+W2
 bfs4GKBZ/EpHk0O4kz7DNQkYsL82ECqoc9t7kcmLLxS9EBFGlLlS/qDXPiqLTKgF0dqJELJpUNW
 Y2tjl8ZkjdZsxZiFiZ3LbY5oHvh9T8o21870rexI3Qai4EN3xw9zlsQJ2FC27wPXHpIAhRL9yo5
 /Fs9/YiMaBY7OBKD77SES8ZDJanL+d2OdUtdcTeukVvkUj7fC8akYieG/UUaY5WUij0OldbwCoB
 jGUC/BXfZ+rxtEPULv7XzbQe5czq6LdZ78Em9H4unxwlML6Rqvi3CaN1Coe66qwCKGq7JWlCegE
 VeiVnJITXqQnbFoQmSYTpfsPf9Q+1cU2amlXsR4eYdmJxTY5iJZxsSVP9HgVh/QqCI+ifC+XVN/
 mZI7w2iUq0O/9EUGF8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150057

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
index 1641d879dbda997604518207ffd5dd4b02c7bf04..ed8ebdf259fa323a6d02ba6f1d75b15b6945eed1 100644
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
index efbd2e5387c0b2cefec5a9919c4295fa41acca0a..a0f1f8fc39c38028b291014c33eb424856794fd4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/property.h>
+#include <linux/of_net.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3771,6 +3772,39 @@ int hci_powered_update_sync(struct hci_dev *hdev)
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
@@ -5332,12 +5366,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
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
index 3b9c82bd2f027e987447e50c0072ad0b5a3227b1..4520cd160a6c145c1bd27c197d5b2f617ec504dd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -613,7 +613,8 @@ static bool is_configured(struct hci_dev *hdev)
 		return false;
 
 	if ((hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY)) &&
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		return false;
 
@@ -629,7 +630,8 @@ static __le32 get_missing_options(struct hci_dev *hdev)
 		options |= MGMT_OPTION_EXTERNAL_CONFIG;
 
 	if ((hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY)) &&
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		options |= MGMT_OPTION_PUBLIC_ADDRESS;
 

-- 
2.34.1

