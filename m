Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C53F86F7
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723347; cv=none; b=hLo6lOjwctzi/OKHofkFsD/8GqgvMH7Oep+AKtlvrl94/7CqphXpzAsEKWW6AS81ccYBo/NG8fCifscAwwZzwP0ofdTwij8GJaG3aovOqwukpex1EH3H/FXMCat7V7Uq5GvSlbty6KJkWRnXmOR3XAitdaSpqtmyXM3pKku2wmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723347; c=relaxed/simple;
	bh=6b0Jqnu0CGr/aHLEgYJK9A+WdSx4puE7YgV7L+bka1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LuVoJdZv/y76/MfFvOG7NjJrMREvP8K0QQLhvHk6nyyO+YHGNSXidvf0n/IogDLtvWTQfmklZvE5MrouyGt68gqIGrFVXdZ/9pSu9DXTc0BHRNIpmlYpUB0Ro3O97Hyy2h/ic+WPTDFrYx2oFUwHj4txcW09Y1mrg8+bPEMdELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qnlt2Mnx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEZ47822; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qnlt2Mnx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEZ47822"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rHlr2101534
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t0giUD+SohDjvu6JqPIFA2PNVMKYNwxQ9YxaoTjC03s=; b=Qnlt2MnxJR4rdAYN
	d+Ia4snWxrKPjUuSfEHA/c3vFeaUCLaJMMFwzHEPUvufZIirCkLTWZOR+Jcp7HAN
	S478oMv16icAgozsNwGSbvqAF27wTya3Rm6xtcxK8v7rs5TapvdzRP2p5mvSv852
	/vX4LGRHUqE85OxsMRUNzG5hmeGLiIfk7+RColCxhDRryqDCtENTBn4A1hzRSzA9
	rYKGlQKvFV1fZyF35Lc+hM6lexwkPwFQPyUroMV3mZwtri7AakkaPGbGrP4olV7l
	EQEr5lM1kMnQsYDYb/pylqZ8F+VNBADwUa8SuuSdrHA3FP/WSuJ+3d1nQOCp4fwO
	W0hwwA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279cng4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:45 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-969289fca9dso671326241.1
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723344; x=1783328144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0giUD+SohDjvu6JqPIFA2PNVMKYNwxQ9YxaoTjC03s=;
        b=IEZ47822Hu4poQSZK1FaPyQdJZvdGssGqpqL/hyJWlzPCl8owtJMC8j6MTp8AWQSf4
         5EUQ3m4v6VIFcVNE7niy0riPy7wRanY23euPqwf5YhTLVvU8xeib7iMADjjq7idV2tgs
         9I0RBmGAi9Ogw2a6axo4FIh7Bxkc5Fw1a5SqbmzrIinK6Y3+Q/DsIUM8Nd/nzy3LkdBb
         oQglSgPicND1YYu5Hk6w2gJujM9dzxkgDkaT6Q7rQeQn0OFKx/dCqx9S04xciCSurv66
         QibqOMa9zOx3bxcJnzSWu9dOarXbWWl9VjLraUgCjsSB4ZQTCfm8/2FDUGZHj3tv6lb8
         kbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723344; x=1783328144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t0giUD+SohDjvu6JqPIFA2PNVMKYNwxQ9YxaoTjC03s=;
        b=iHSfO4rc869OoYNPoF86SOembOB8i9fgrKtNetk1ogAAQBiv18+P+dClL5TQsy84EW
         sVtHpfF+2QFzxif3plAA4p1FbRMfLeH9k1q+uk2C7kiQCF3hM951zUh2dVZC/PmV4fTu
         sFOIEzQm3fKlUnGEtGg60A245jNXGh7F0e+u/LZy0em/XpIbL4Je0tr6u6L6qjmFkqmQ
         G0N3wAwRiiQ5tw7wUE/4ANihsHQ8CoS5GHS6/DqQyRWqpko40wlKYBqrl2kXuUGa6RkF
         9hHybCHU3pJmSJgOUopIAAiPYf3GhTWiNB0EN7D4KHG06CoFuRQqpue06TDFsmqa3PpW
         /VvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgyyjurYA98Td3uaAjXix4eEOMxOBELe2FiYm4Ge4QZ0ln85aqdr+KR0i3chDMiClf1r1cIUSslnlN0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6unfd1d1b9E0VXdSw03+Zc1kXoGWIs7YYtrdJPcLWwIiZHBo
	NBq+b+Fc+52ip1jFxzG3Lol6OMsm+v863uRNYEOfdnBljptFWhSosSrZKY6W/Y0C5pzgJDFnkF+
	hdpzKckLKaP9RytZPG1nreG8Q7mNmI5AhYmnNYZZmnbHa6p2vzzBi5mNXYeFwqFp44g==
X-Gm-Gg: AfdE7clK/hNPvyIPD9FzAeP+Q682y4YqqVDz/r+y/rHh5cStkDfMAJ9b0PF7LLNRTdC
	YwZMM51PJNRi0Ebqak88CjG/IR4FKvTrTkOAQBOCxvGGLR8c2GjbpCB9kiz+PZl/xl6OLz91lGL
	7bahS+gv6awDZud4aUXe+SR+vxrLj76tLuzYTisUHL3qcyLov9V4voVhAmrD8BAo/US5PTtc7W+
	VoKMu5AMAD1sD3esp35N29Jt1q5lJmOHLjUgPLs+cWpLv47hc5YqLY1NviYwmH+AVP/gUL1FqvN
	r63tOzVSO+xNGmhAxL2+tuZUt13aRJDvujKeH9T1ppB8mDlbqxvnlMX9aIxSC3NLC02iaCLBUmw
	+R72IdmKkY4OVcoh/LtKj/nkNFvgQeRhCf0MFqySUJWQXvTouVlsQfdLv8C2Jb+zer6K21qYGR5
	iRaYBBtnrceUmmX6QgHhCCMYPaNlr6/Q4o+YlfPehiKADPeHI/9fZo6KU3MckdnDO/eXAgWuMj6
	O8rjNQ86EKFqk25/U+g
X-Received: by 2002:a05:6122:6b1c:b0:5bd:71b1:d5c6 with SMTP id 71dfb90a1353d-5bd71b1d988mr5371456e0c.4.1782723344092;
        Mon, 29 Jun 2026 01:55:44 -0700 (PDT)
X-Received: by 2002:a05:6122:6b1c:b0:5bd:71b1:d5c6 with SMTP id 71dfb90a1353d-5bd71b1d988mr5371442e0c.4.1782723343668;
        Mon, 29 Jun 2026 01:55:43 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:40 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:25 +0200
Subject: [PATCH v6 6/9] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-6-f02513dcd46d@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a423311 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX4mL5BkSaW7gE
 wc4w1aG/M0/62Sz0D4Zs9HiaNvmgGu7e5iWpJQBwb1dALPux3GMv4KrWq9G9PtJT+taB5jQlWtR
 1u6lggX215NzH+SI3lYshpYKg80SE+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX2HOMT1VAJsjZ
 GEB9nF/qW8/7d7Bf8DBuu+e7+RVGTsIlNeFcVyDFwz6akziKAokO5z/6KwYFweaXvBEu2PQxL61
 PBe33NM7fGPOZsuXScALi3d8F+hNo83Axl81eDlGplU8vsavn7YvDe7SwLdARLur6M6QXJKRDFW
 Sh0fcWHGkapCuwFrjEbwW3vxPqkiJI9Ka5LdOZ/t/Rmjkj/8CrM/+ykXnmQeVsZM1JUFMIgL35G
 c8gMw7zowzBD0XkHd1SKK7HV2XOFo1AE/O0ekU7iTQGrU0xEvv0cbiJYbxfDMHpOiWLEZ5XFJkM
 gJ81mYP9MWhz7qSoo6uBjuYbAOXsHKJrIqL601DAKs3D9KYVvrNbJAV1eFdspHvH8R5Er57ctll
 8JwlHcJb29Ty2AzQxdAhKGD5O8ZGG91ma3nTHxHVvhy21Xo+zVnXqLSqsg8gG4roc/vi4eIqUWo
 0AeGsdn/abafVI50/yg==
X-Proofpoint-GUID: bpM3IkKHVPaJGrb01fquhSdycZ_mS7_5
X-Proofpoint-ORIG-GUID: bpM3IkKHVPaJGrb01fquhSdycZ_mS7_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

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
 net/core/of_net.c      | 49 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 12 deletions(-)

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
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..11c1acca151266ac9287457b4050a54b08e2b5f5 100644
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
@@ -75,27 +73,54 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
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
+	ether_addr_copy(addr, mac);
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
+	if (len != ETH_ALEN || !memchr_inv(eui48, 0, ETH_ALEN)) {
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

