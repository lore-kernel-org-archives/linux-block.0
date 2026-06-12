Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042EE3FFAC0
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270488; cv=none; b=trgWXWW0Qx6dGux6VVO9IpFamaZoQ+SoJjSWGmPNCZMCm+Vf5wivlD6ESvtBgwx1URcbEaFhtTkLizsFgSBf6+RueZgUE1uyfFdCDx2zhiFiPvRc38rhepDsxhH6DFBHqwr2S4Yo8bUaBdloLH/wabQ3Yif+XVsb5BQkNYAahrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270488; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxEjTQ9M28NEmr+O9flBwJobUJjNXPGQAtrwchJML2yzbYV7bwEno8OB1tqydKuO5GBkGP/jmNcBb4pLtJ10PCk8CMAalmffyZA+mLVdg8mVPWG5aKPxsJEt+JLbTys5+z58Kiynx70An8o5IepSUmkpJZYVzeHZhThJMFwPyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G5OM1ip8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i6vf09Zy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G5OM1ip8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i6vf09Zy"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCjB7U3721608
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=G5OM1ip8TUiczHnG
	jV45VH7AZKJhsfHdm0Wd3H13La1OeotXMV4iMo9k8tf1ubm+/yWIyRg75WQTylSW
	aCLi2PfVB7MHDllFoBXBbJYks0VYRPX8kVTv6NVsqy/ZhVSAs0XWudRgY/99kV1y
	412IKCSsXeD3TwVz4ihANy9FgtXjnvcq58dS7mQQhLCW+2TnSQVUcBy4Ge8YOxUg
	USi8m1BM2Aya68aVeLMvEppC8tLa55Xtb8z9MMVz0m5ewvlM1KQM4SRgILgBjmXK
	rJv0voEjx+j3rEWZKv76SpEHnIEXcEIh1zsKpsW0gF4QyLwgzwRNK2vm6HBqc/ZP
	cZq2rg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbke7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:25 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6c6dc39a6afso404212137.3
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270485; x=1781875285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=i6vf09Zyhx0qOxeEdo+n1eK+WdR/jh08wCpCKUaQyThVVKu/lgXchLKVKgxKFUfTri
         OAf1tA+3IDYjnq56Dzgj7H8Bwd6IJHrKCkQxT2pUif7zfz1NdVGb2BGdvylf+MxDzv3m
         ZLXWgl7cgR58mwireznP6gO6tDxAOyvb9U1bCFCv1JYBgYz6V42JD8Si1Ds/YNdR7ELd
         vwfhjWRwkNlPAiCulvu9UwRS5YFpToRerwEM3WqiuG1OqA3goApn15v1Gut1PVUU1OIx
         atqhg5VMkICCGzf/uqxfqAQhS+STGgxsmWuOQ4uoqxpZI7ROvrFneVZDLv2nssrNZ6un
         gHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270485; x=1781875285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=qmy4nvMwou5jOLCl1XuOiWv3il9dSF4MenuN5q1i/DGZmTTw6H7DmnPigXQoDmVFsx
         /vgqNHB67kjEW5JtxtuOgxFQKazoUgL3GcOlBBymrja+5Vk1lcrkq9iadBUsiCkNrVR0
         fcy4Du60B7CDYH5UkLOv9+mTx0oXDRuIxnfEJj207kIXqXnE1H9Owp40n1uMGmJB/sCF
         auHUPAVEmAGkercmGrha2XnUjpx4yzghDwzNBGqZDeIyA/w/BVzF6cLLH+Ov+7zLaep4
         lpcbVyG1KDXjS3hXuLL4B6rgnIBTvUsJiyJ0syYMStTW4FMnNSOdew0xt5O4SUaHAfKR
         vX1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9A7BWPDq14TOlXV5yCMnfp3RYcC/BXLz28gR3wSIUnpHjUtX54CVIyz/mHeCN3RaswEe++IuYLSW+4ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/uQwS/FlHz9dzjvmy6loHztIeMwq0tl2jnsLO1MAC2dcoV37R
	TW5wR8ixbPBbOpf2WQXyQaao2eYHa3TbpKdjuyoNrCpj3xzP6DKqm8B84jgTZab6L2a5TO4l5gF
	ucCLArodfa60AkKd2ZDu0QBf8DkgHuqFOSYXG77wyeafsK5MI9yQUD34dF2Va9Uenug==
X-Gm-Gg: Acq92OEbp/6KYm5x6DLLTTsT+1CBjB/Er4hGyWAtzNyj4MefLwsPgS+Er8qS2kYwXFR
	6iM86QRQ1GgzU0uY9iwPgHSUpVekk/4uKhJZM96EfJudMwWtlIrYmfPOxIcx+v1fG1QrPv5rjoC
	h9dzOasbCOLpWNBC3bR3hEk7zbLZmHRekI581DS30J6d/zELE51m9Kw6vavyjYM26ZjffIPK4Un
	z6hpPNWUb+22SgYYB85ZQe+Kc4YARFTvtsNfChM8LE1apdZYX0EG3b1WZw+Vft+72KTWZLxoirB
	vmKYeZlA9t36ebmUpjw3cXcxG+UibfPBEZzlXtA27ZZCntYJ+7Vhfk7Z7vHUQ3ZKFnv1fOegNbL
	OrysWOj3+Z7g3JfREU2KYGjTJTNh6eRhiehVPfDG5ZgPf6tV2CzN/J0EYyGL4pZAQxhW42n3qSD
	r0OBEI9RKVN2GJVZgKiwazNvgEV/tm8ZsfgU02EH0sJbY25uHYGJ20hj6j01u6k8uasPpcnamn
X-Received: by 2002:a05:6102:292a:b0:6d8:89a0:4ae4 with SMTP id ada2fe7eead31-71e88c6af86mr1261406137.18.1781270485224;
        Fri, 12 Jun 2026 06:21:25 -0700 (PDT)
X-Received: by 2002:a05:6102:292a:b0:6d8:89a0:4ae4 with SMTP id ada2fe7eead31-71e88c6af86mr1261324137.18.1781270484709;
        Fri, 12 Jun 2026 06:21:24 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:23 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:21:00 +0200
Subject: [PATCH v5 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-8-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 0aWsD5ZMp-vWHLyUv0rxSRQDgCoGMK3Q
X-Proofpoint-ORIG-GUID: 0aWsD5ZMp-vWHLyUv0rxSRQDgCoGMK3Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX4kz97Aqv1D5v
 69+tL8a4t7an4uv7SmudtXFrHKFiFRoEsvka7DBQ3f2lDqKH/c2VYGILpT5Q8p0+r82BtzMa1nk
 /seoVmkRIRhhRs0OYVeoMIdUbFhxM4I=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2c07d6 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfXwAwUuEKABnHm
 kC33MX/Ztq6ZReE+ckUUCF80zNzF2B2TozPtNI6V1m6mQ0qyWSRJYpf8EoEX2ZKLJXYgdXkmXZv
 r1GB/2a7tsb31V+6qEbEMQBedzbhX17srKNv7go9zTlVfTMrrjRTBHhDuomtK+Ipi9INhsjziJV
 AsWJuKRIYtviBs5DeOoY7eWlaJn3aB3+PWW/56HzCDhTwaM4KvjdROqZwB17OvzQJ1Amtlq1UDY
 bm3LBGfuJb6WJUDdV9UwUymcMYQPXgX+1iWKB4OpxpSIHRuS7ZEmRumvNIt/40PRLB22lM/eUaV
 CpEr1WsKqCkCeLAdvmSoYg2GjQZe6MtJ8szjshxz66uf2fMzQoB1tLs6kinpdAGh4h54HlGiWjb
 EuQG8pQMKvRkM8U6TrCRVRo5H5dUjNl0TAJMpj4CGKep89JfMkSopwEebTydvtb5PbkAujyZmpf
 I2MDA6ughC9G553+e8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120122

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1

