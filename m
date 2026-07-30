Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD70453A33
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427275; cv=none; b=vFfwMa3aGq/AW5UYlZ2loLzZotmW0XtC8fYoW12tQxjrNIhcesbWpP9YoKG2tkYo86RDDi4XTfbPtANQY/MNYgJEjcI+eHNJdGN0ERaqJBUML8VhAmHwZAXw2zbYElavk2STSVMuxM6hDcXCDIVdzh0XRLqyZ7PO08VOg9s+1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427275; c=relaxed/simple;
	bh=L92wgefYXvtbzOMdFEhUTkLwtCR1yYb0ZcvRRGDMuNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lsieeimis1qzylfe4RBAuNGNyzNhyYoXmCnUzNfrKJzbwxhtB9UNLiqaSSOzL02CBSjJl7TBas3vpxm1laQMvyvvlyJ6h2bAabLSYv8UTsHRK1PdW+5mi4VMp/k0bIp0Gz3WJjUkFibhyJ1J3PaeVRfXR1+9a57pOQTW9kzFtCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YT7WVXhE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZBkMH5Cn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YT7WVXhE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZBkMH5Cn"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQtvb1490249
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=; b=YT7WVXhEsZRuo4tj
	rRS18ZkhpL5M/kLvIYGgnkfXMVwlcTPPbuqRyMuROdWq9ab8QuFzzS63kAEy5Bi7
	Bvul0ORPu/UUS9bzL1gT27Zxr+5i5GR57qvYOl+bme9l1fq5wRTG5PZrnEw1l1eW
	1/rR4Hr3YnpsT2IOumRcSXZ6WlkW2Cw7icpC/OTfAsoMgmmy8/lGe11+NAlgfwKh
	4I7NSS5Jjo8umJcK+JZEfDhGuzM2LaU8JxjSapPBb1pC1al/8a794ME7mQaDak3J
	BmjU11jGwrDQ8FhK1xknkfHycAOXCqqXpbGdQGFoXBO6yOHNx/aJtQe9jm32PfGv
	wl8fGQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8md0dsg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:01:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0408254aso13050881cf.0
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427271; x=1786032071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=;
        b=ZBkMH5CnMmazX5RbjTstQ4BU9zo7+kUb5/29toJgNNuh6Tsy+SqbgG+i7v+Wz2nTNV
         O9p7gvPwEqPbmpquwpJZbz5TtMf/zDE526+jt0EHOQFIaopwYG7+oCAW+ChV7D5tkhd0
         VPSbyIaGMbmP/i2Xs8BM9NPKAW/D/o6+V0V62cVgGpOlX8U5USxtna1c36IoUSkCJury
         hfoYycxDhfF/RMTEZn7MfFRd3y0dvUhTHR2YFSgJ0neDoDbpHQiBkE19jtR6vyrUdrJj
         PeTyEDAUwLhtgBUG2Gy+Ws25rXCa1C7Rb1eg2ccx6u+M3NvrNS0z/ArmVXUorJ2ZZWvJ
         HmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427271; x=1786032071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=;
        b=dEnng+BoiH3uWXeQXmQckhnynFvH6TJ5Fvg1J2jdodzrXJpFZzpxYAo16jsy9CEdNN
         YJBpe8/KTh3q9VNTBmzQMMGIFiWe31XmW1KkujlDhtz/IfFVx/bSG1URIvr89wQIDBJj
         PSFSMm1q/+7lTJSi59t/ABJFEvjbOUN8IIYwTqUjLUNX6b6AMsHTMSvxu6rLJYdP1sTn
         wW5Z0O+8QA3M6Ym9bDSdI3rC24wBvRdplH5i/dg0MlXpld+CRkXIBXwS5ucvYfzrGZU3
         Gb5KVZwFv5VGF4LIIA972yiocWPBnnxsok79DCusKYVwLRCEGe2O2laeXisP5tW77zK6
         56rg==
X-Forwarded-Encrypted: i=1; AHgh+RpScYV2cD6wslC6UwKvj0uRjOwBk26nK6gwHVvxhIFuazhSL5g0zebnbExKdTqT92txOdxM5v32RiFH3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdD5mCdYQ0XLmTbxHNTxUhrPYed/IgIoCRRd42VpdVO7qOxQe2
	A3rfCt5fmv0YI7bFaDmXo0A9sx+Is9Ka6plekKbd4FYOFtSrUWlMys6Ayc8FhOzTD9ExXvaNmpq
	gO3GOx0BSKNjx032BupgjNbNpFYlwVHwUIImxaatCVLlIsfUVq4SzmrJJRm3kUYDQTA==
X-Gm-Gg: AR+sD13RL0+U9IEaU/wPmzN3T6+O1NftWoeoQkzLGZz2Uw1y1c3XlhptXivfpNasVXU
	eTsmfEYvOxALxznb8SAh5c+REukI0vQPEUzPJJBntC+v3G0n0fi//LY+N1Lb1oxNw9JA/4cF17C
	KQ00mmgNobZ5UJ4+7aBwA+xifsINJAYcjTEzoj3PxS4zCu0o66FYDu88wZRc62rqoZW+IBdRyfZ
	q8eMa8G0UcvxgrNZntyFvK/LZAnnT8VymLbBi6rf6rmTdT+I/Sztl0rk7iTbs5iAV2Bn+3SuQUB
	RJSyW8odWDlYWYA9SxW1hOApjPP79Cr7AjDXM4YdA6txKb7akmYcXMiboUOg4z7vEBH2d0o++Xw
	4ylBV6igcou3LDWf4NHM9LWdxxqMPvfiv7ZUeSPlyndIG1WDu6Hl/wbsRvHApYVw7chhK/0mEaO
	M4YR0HgP0wUf5wd8thppdNIwsJFvd1Tum71++yrchHqYj2kRztt7xc
X-Received: by 2002:a05:622a:488d:b0:528:1bad:a2a4 with SMTP id d75a77b69052e-52b424e2ebfmr11083911cf.15.1785427270727;
        Thu, 30 Jul 2026 09:01:10 -0700 (PDT)
X-Received: by 2002:a05:622a:488d:b0:528:1bad:a2a4 with SMTP id d75a77b69052e-52b424e2ebfmr11072291cf.15.1785427258968;
        Thu, 30 Jul 2026 09:00:58 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:58 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:37 +0200
Subject: [PATCH v9 07/10] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-7-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=UZphjqSN c=1 sm=1 tr=0 ts=6a6b7547 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: pfCTxIgRDJueYH2RhsSC2J2SIfnSHkmI
X-Proofpoint-GUID: pfCTxIgRDJueYH2RhsSC2J2SIfnSHkmI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXxM3IS51CHLTZ
 OOsA1giOePuiZ0mQNj6CEShTjwBvjMVCg5eDNvyFrXUYYtOPEAV90dq1nM+Od0HCx07lHjt/nY1
 KyaeeAOQYyPnD4/rrcRqJ/PVx8ad/e8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX6SZhUhHffrZb
 t8PiDyR0SZBzMopQT/wMgFpx1zergz/El2E4VZrNzQVBPCJgtZW0f1oHyB0gQpqdaMsSl31/aaD
 4Smomg0VKZ8CM31eJR5IMlAlKZDXPnFA+20CNIgMgBanZq7PuCWHqSHV/2umlTEu/R6qZxUmXd2
 rGmRqAtn/f/AwUO6PV8Bf+nznZazSm5Av97hgqyi2PX5cfu6+8CL8rEbERa/trHKKUDMPcaCB4S
 AQYK1fVAW7Zqw49ZbVUPUXUI6ssgO6tIPq89Or98spE2objEZHBsF0bhvFH6Muh0ZRyFu/YPZ/e
 OqzvOKty1uNBwcyuyuFNFINlG36yDxf6VVT3HAzcv3r6bg+D/L+sCYvJqdZk6yi5//OmRSVNBF/
 6YoiwVdE38L006cr1QrrpjwPi7mg22EQfB5sRZY1sYm0fQ/0Q2Nt+hDs+w20ZOLn193Nr6PbOjd
 NNZ8pK12WOoczq02O6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300120

Factor out the common NVMEM EUI-48 retrieval logic from
of_get_mac_address_nvmem() into a new of_get_nvmem_eui48() helper that
accepts the NVMEM cell name as a parameter. This allows other subsystems
(e.g. Bluetooth) to reuse the same lookup-validate-copy pattern with a
different cell name, without duplicating code.

of_get_mac_address_nvmem() is updated to call of_get_nvmem_eui48() with
"mac-address", preserving its existing behavior.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/linux/of_net.h |  7 +++++++
 net/core/of_net.c      | 52 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index d88715a0b3a52f87af23d47791bea3baf5be5200..7854ba555d9a55f3d020a37fe00a27ae52e0e5dc 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -15,6 +15,7 @@ struct net_device;
 extern int of_get_phy_mode(struct device_node *np, phy_interface_t *interface);
 extern int of_get_mac_address(struct device_node *np, u8 *mac);
 extern int of_get_mac_address_nvmem(struct device_node *np, u8 *mac);
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr);
 int of_get_ethdev_address(struct device_node *np, struct net_device *dev);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
@@ -34,6 +35,12 @@ static inline int of_get_mac_address_nvmem(struct device_node *np, u8 *mac)
 	return -ENODEV;
 }
 
+static inline int of_get_nvmem_eui48(struct device_node *np,
+				      const char *cell_name, u8 *addr)
+{
+	return -ENODEV;
+}
+
 static inline int of_get_ethdev_address(struct device_node *np, struct net_device *dev)
 {
 	return -ENODEV;
diff --git a/net/core/of_net.c b/net/core/of_net.c
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..999ca0e9258c41580823b80e0ef6db26617bc968 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -61,9 +61,7 @@ static int of_get_mac_addr(struct device_node *np, const char *name, u8 *addr)
 int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 {
 	struct platform_device *pdev = of_find_device_by_node(np);
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
+	u8 mac[ETH_ALEN] __aligned(sizeof(u16));
 	int ret;
 
 	/* Try lookup by device first, there might be a nvmem_cell_lookup
@@ -75,27 +73,57 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 		return ret;
 	}
 
-	cell = of_nvmem_cell_get(np, "mac-address");
+	ret = of_get_nvmem_eui48(np, "mac-address", mac);
+	if (ret)
+		return ret;
+
+	if (!is_valid_ether_addr(mac))
+		return -EINVAL;
+
+	memcpy(addr, mac, ETH_ALEN);
+	return 0;
+}
+EXPORT_SYMBOL(of_get_mac_address_nvmem);
+
+/**
+ * of_get_nvmem_eui48 - Read a 6-byte EUI-48 address from a named NVMEM cell.
+ * @np:		Device node to look up the NVMEM cell from.
+ * @cell_name:	Name of the NVMEM cell (e.g. "mac-address", "local-bd-address").
+ * @addr:	Output buffer for the 6-byte address.
+ *
+ * Reads the named NVMEM cell and validates that it contains a non-zero 6-byte
+ * address. Returns 0 on success, negative errno on failure.
+ */
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr)
+{
+	struct nvmem_cell *cell;
+	const void *eui48;
+	size_t len;
+
+	cell = of_nvmem_cell_get(np, cell_name);
 	if (IS_ERR(cell))
 		return PTR_ERR(cell);
 
-	mac = nvmem_cell_read(cell, &len);
+	eui48 = nvmem_cell_read(cell, &len);
 	nvmem_cell_put(cell);
 
-	if (IS_ERR(mac))
-		return PTR_ERR(mac);
+	if (IS_ERR(eui48))
+		return PTR_ERR(eui48);
 
-	if (len != ETH_ALEN || !is_valid_ether_addr(mac)) {
-		kfree(mac);
+	/* Reject unprogrammed cells that read as all-zeroes or all-ones */
+	if (len != ETH_ALEN ||
+	    !memchr_inv(eui48, 0x00, ETH_ALEN) ||
+	    !memchr_inv(eui48, 0xff, ETH_ALEN)) {
+		kfree(eui48);
 		return -EINVAL;
 	}
 
-	memcpy(addr, mac, ETH_ALEN);
-	kfree(mac);
+	memcpy(addr, eui48, ETH_ALEN);
+	kfree(eui48);
 
 	return 0;
 }
-EXPORT_SYMBOL(of_get_mac_address_nvmem);
+EXPORT_SYMBOL_GPL(of_get_nvmem_eui48);
 
 /**
  * of_get_mac_address()

-- 
2.34.1

