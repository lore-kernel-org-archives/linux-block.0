Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B447F2EB
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027150; cv=none; b=OFgiskRPHn3SwY0nD+PBaW2wNdZrOYPr7O24WaE6u03ArSMvLfIrc/rgNSath+TcP2RkL/W5hA7dGAal0qdF08eh4mP1BXniJDXfqoMd9WEWmwiTeCAHxv9e75+QicSeYZ/MAz76LTyAZE81l0PpYdmMSxuLaea1OCxapHLESdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027150; c=relaxed/simple;
	bh=L92wgefYXvtbzOMdFEhUTkLwtCR1yYb0ZcvRRGDMuNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fsfY/dOLxikyX5RjdAxNwMJMyFBLQNBzTZ/P0/NxNRo9mcXpIoksgMZgx2ROB/mImMQwyKUCp+gvIyP4iOlCf+8rmnCKta31z0Brs+Q7JUXMzHJ8n8gyyce077C1PxWFDDIfIRFXKHEhcT+JjNOkAz1z3YY9wwnI7iusw4uLjYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tu7wovN1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W6zuJobQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tu7wovN1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W6zuJobQ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Bx29J3038027
	for <linux-block@vger.kernel.org>; Thu, 6 Aug 2026 14:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=; b=Tu7wovN1yUeuNh2h
	YaUwjkkkN8p0Y3Y4/b64xoMPKryZFIwHN1MEm+K6zTfr5B/pupMFOE93Y0b9hszq
	HNNiigNAb7txL8R0o15QcYwQijLQfpziy61yvktiD2bmL7qvQ5x3BkjpywMlevzV
	fZy0AzmR83bdWZ2Gq4azy4Y6Ail743FLZcaAWYcNiMyT7cMQ2qFbGz7W2SbHDBu4
	znBl8nhMZy+S8kN91o393vnzDBtZSZHE7JyB4njZ0mqAVxeO1IyJxAcKAfn5fLf3
	AJ6xisRMQLTiTjg5QAmDVuWERq8L9crSL7HxA3FyDTNPvCeJyfDDgi3zoitBNabc
	9o3wxQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvsvd0sp7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 14:39:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5283df62d68so25621211cf.0
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027146; x=1786631946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=;
        b=W6zuJobQMzovX5XY+ges5LegvJc+QfPblYTnJUOHwItKm8JCYcHMPM6gG0zfGOIWlW
         uX1PAe1KN24dK+jJi/+KKB7Jj9oFD1V1xRME7uj1zk414emthsC8lTpaSxzpBwBiMELf
         Y/tPHG+Ca8hh7H8Wy+/8dzhMWEfqGUnNxV22ok18TrieqA1YtYAD4Ff4CSvDoEzN4T/L
         zCGtGsbKlq36d7AfQIUADN+U/gEIZWMPlOlFzABzMXfnjSWTPSsEqxe1x/48OHcG4opF
         /MWHov3C7FErWl506blcIMe/kn8/vcPdyByjXqQyMRCWtSPaA3qw649fFZvWCpv4Evky
         DM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027146; x=1786631946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=;
        b=eptNahhiTGRl1f7xx+FSj75t02lN9U1280VaIWLEqk+C1z9hW6sotaER6Ro2wv25o/
         nRhU2Y2RiPhR0nF96ssxo0Ge26eO/CyDee+tu6Y6TItIMA/XcGFuSfic17J8t01rMIwq
         O5a+z0NSnvNjkILCaiN+qpw35/stwwrX/uWwq+Vft557lWga1aHn36d0ht+Whfd6+Dcx
         yVwannXVfbcywmmdC1P6cEOCYLKenWLcFjWjSUETt43L4bQ7bM+wWWsB1x/FOLAsckq5
         /3dxgys4e1c8Ia3LpAJFwaJuHzPJ2wwZSzSyQ2ipD5A1Nz13OwJxswg2GfU+s0d26eXm
         bhyQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYZGn3BsoaMsHHPnTNu3XBe8aqweS3bt292d0W9XvEIl11h4vWWpBLQwJ1JvkVcbhuNsiIF98FlylmQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVU51HbtXWoeO6ReuT5+A/ve5p9UafYQ3AjxRwbNMAayojERC
	WsHPQKfJSlPjICYtsOhFdkC0JOlfGrJPZsZ0C0MnLFwaVtp8VeS0eqrdgKVb10OQ+Z7MEva16a/
	E2QlxdYsYZnx8REKc3lFWxqPXzO6HQYR3P+jiugrgRWQUaAcE2DpQcn/TM6dr4+VFzg==
X-Gm-Gg: AR+sD10zS3Qw0uiU23TEp9YIA+YzI4kAnXu1FUpA5jM9bhVNufH2nwV8NVoQ2fPvlyr
	SqNsYNgWEvE069LKNWvq0D+ZSKcF2pFYwocRunqC/NFuyvrBMoglAXwCz9qHcrfKUXh4fo2R6xj
	cZZ5AVEjbsmfW9CkRt+erlgALIkcK9wH9MqP7NJRDlZeJvOw+LS2gnJg2Qf8fV1PyuCfgPcJ5gH
	WcZDRoNG05i4HVJtgYillBSPwiknCpnv6A/L/8pf33ZwaNyKZrXeXcUHJ6oup3x49Hc3+35x+IC
	aFbRS70Tyqal0qgVl7PaICpE5I9FYgt2tET2fE5dzZJD+lV7p8317ZK7nk8ROON6W3Cx1HMlWZU
	2k1QUm6kjCbd/idtNwvoCNMQzhb4jSTOygyQJFj3zOtLtBDIOfdjbhkS8OLfCSswpqrJfHuwJbt
	zEB+MmjOFlb9pdd8w9RHH/0rdTq6v47EL02UWCkStt4n/VlR1AZw==
X-Received: by 2002:a05:622a:1489:b0:51a:89c1:1eef with SMTP id d75a77b69052e-52ce6022480mr139973701cf.14.1786027145651;
        Thu, 06 Aug 2026 07:39:05 -0700 (PDT)
X-Received: by 2002:a05:622a:1489:b0:51a:89c1:1eef with SMTP id d75a77b69052e-52ce6022480mr139972401cf.14.1786027145034;
        Thu, 06 Aug 2026 07:39:05 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:39:04 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:40 +0200
Subject: [PATCH v10 07/10] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-7-be598b2a5606@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX8mWYPg+MI/mV
 K9oOlWoE7yhqlqG/dkpzWH8vkSir7277jQW8hwY8vX2LYHb37Urn1qILWIBBmYPJWqPbgr86BQH
 Q8+QdzYfTMUaWzoMo4+VO3ssItKzvcg=
X-Authority-Analysis: v=2.4 cv=WbY8rUhX c=1 sm=1 tr=0 ts=6a749c8a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: WTmzbUNuaMvPnHkwD0OQhVIQvROvkmPr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfXztVo3vSJm9i6
 5OHXzM0NX5CymGultjhGX/NbQU3EK677aNIoT28HwOhAHvMi/aaDb34JKiXFqkfSCkSxoga5KRG
 z8wnW4GngeAtuNytAykjt8CrQaGKoq8+yhHka2bwpVV8OxpxEiN7e2o+1gzl+0Syy0XuwseQBkY
 dEVXTOeX5PSK5oZksz7MpcMmHE4il330xpYTjXlUih9o16c20y2Pr/J30ldcLGrDEUPtfveqSlE
 g/fst6JS46gwFg3Czq9JoE3/2gCO4wQb6rb+d/2Uetjd/lHlPybmcSnB3OS6OZFkUoL0u3ZBKhC
 o9NR+cM9VMnAFqHMU3506BNU6Yl9lagiUS0kBv0YqMsmnv/tVVLI9swhXrj393iHbMQ449jbWcN
 FPhHaGznbpKpwyt/Xh6Aav8IqYF7yxhYdLolSXW/9+xMTAS8hXvDkLoAQOyriYISul3oLoD9D5b
 EQmlLP8/OY5Fla8jyeA==
X-Proofpoint-GUID: WTmzbUNuaMvPnHkwD0OQhVIQvROvkmPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060114

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

