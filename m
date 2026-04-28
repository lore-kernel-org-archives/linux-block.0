Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6524508E4
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386207; cv=none; b=s/j8DSAjWKNyB2Zagi7aCP4nQOIFIDaFd/mdoTWoIs6pZGcz7MaNj+3veamk3fkxrj9PyAeuWZmsQQWxfBFK1kDk2S3MBdaALDs9ZhKKx5mFsonjoJpirMSrAJJtj0olre7ZE/ijMXuwDWuylEy8UrduzqK+lxgddXjA3TR23p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386207; c=relaxed/simple;
	bh=cAnljmIAnY0RgmqbpHx3i/y6lGT992IHdJ79dMHjCc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDMq0bz0bTTAYGjAcQ2LKNjs07v9sW8Qox6BY71dHbhbPnd8Nd68qACod9dvQOF8+OUukTKNQjZ0HAB8ekqrkZYJrhnVy8KefPSfiMu4asp0/6+hvaRBSkm0yTLua2QRF9AUYaPzjrNJ0n18E8KY61H5D9eMffVZV9vbddWE3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pV6jaFMt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AnTC8ue9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pV6jaFMt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AnTC8ue9"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SACOwJ2928898
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0EtjVuK8tfVE6lW6LjScpaxrDNQ+sqkyAA5l5tfy/xI=; b=pV6jaFMtwD5NMekP
	nZgGZJa9bXjPxtiaCr3uI+//DV6UjSWPh0Ypf0f3UhJ+BlPYQ4HFT0U5Quh/yDYr
	V/aKdxN5iEj9NS95plMyA8u1V2vutmcvrpa7BL2JKvTXhw7ARLp9Sm0X7Pe94vJR
	U3SAm4VnBGjaBrBuPp9P/phSMyJS/yrNsJqcKGHH2BVOyBc1mdHkMG+Y3jCJJKmi
	I+LGPClg/nEkiiTtCBcacVkYHsOG0zuLfH07Q3u3OB5BaC406zg2RxOEZ1uam+ta
	siRy78avZU1ZRgTIOGLWuaPy+Yfu9ffQ3Ec131pVTWxFPLP9IPqwsyCIRBiPqUeT
	92h/FQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttxh8wrt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:23 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56ef11518d3so20082211e0c.3
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386203; x=1777991003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EtjVuK8tfVE6lW6LjScpaxrDNQ+sqkyAA5l5tfy/xI=;
        b=AnTC8ue9hT0r6hTBiEKhc4aQnaHQqa106TIND4E5d4v0ZlJFzDX/AUsgSnRTDd289T
         m1fDS3OKBvkRIDlkYSE8O/4OaptigXVkemqvFh3HQBftLFh3+vTkMr057LDEOpDNyCGz
         ahdOw4DhV+BoX2OZf6w+TVf1nK8hJ8TG1gKTRQ+yQB4697/ShXBycBXz6vJy3oAvjRmO
         Vb9KDA4+//nGL8FD+72ePty2IJwIe8tVGNb3TFC49/WlJRdrw3aD/G/QogMgc33ZEtbc
         ZoBClIZRdKB74mN2TxeoGKJ8BQcFzBWeFLuCyytzdiovjAHdIe2a/i21h/0Ppzs8G08j
         KB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386203; x=1777991003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0EtjVuK8tfVE6lW6LjScpaxrDNQ+sqkyAA5l5tfy/xI=;
        b=FsKMZIU+9i0UxA41uB/4DgbzZbFJRMrQYYjvW6JpGqiIcQaQcfrqR1xN4WjKxNr0zT
         Gcga687+qiHmjsXSdTuaoHkNZ98JZTgtIKl9CX6y7uTek1PPhIIPP7SdgW5Y7DKqRu5W
         7NV+GO9XJdvPXHa16JBNVEQPZkva/ZDTlyg3YgT4jlF9qUIUNhHVB7CSjTIKp1U2u8yd
         W1mHEcZ4RgIGfHarg1VQN1W2UB3hOM1KnLTHKLx9NduY9wAYDn6OJwyPFKChNIxZoEQj
         pqEUnGu272cSPVz/neAUoCl7WUjlSnV1rhfT2rMGWmerPxcQTVICzNGpIJjHkBZFTw1G
         xzSA==
X-Forwarded-Encrypted: i=1; AFNElJ+th92t7XoG2/Jmb5izCI+KLUbC0YuXqAJ5nsiloCMtqJoqzgS9cW3BKoSWQKiis3ijL4snKJ6d34lLfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZLf2PxRCkBxYVp4zypoi+219/JA/F+Xi2ezSAC0k+qmS83nD9
	+u58p6URuuPkSEMwLziaDrWELhhF8hBTMi8FNCe3tpMBKVAmuhJxt6/+2I9jhQAVkz4WBS1DIuO
	95lfXakgOUus0sWWsCVh/Ni8LjKNukYl0v6KcX6zfMJKWksAVVraRaKCz1/5iXMJATw==
X-Gm-Gg: AeBDieuNJyUAcAPHOEGnUVQ89CIGZvh6VlI6eNAX7/aW8KZ456eqZvETifzv3cDtlkZ
	Lb62xsa2kbc2Q84705Jbdq43GTx3NVlyUK+4w7aQvGHlUcrCHsanznQM6sb+ThB3k8c2eYc7F3K
	KDkJQ0ypds05pX91+5eDM8TAEipSXjcSCP5PfNTti41B8+VSPR2/td/eLJDnuM36mADHuPvQOPs
	MG7lweHh6isM0/P/VMLpGhPgwIdkYHFepL3mpVR/91pJK4mndno1cyxCbP8Bz9BKirQrs44On46
	/dTMCg2eRTWneGKynx1TEbU94SOWN8dNC9ipWiFCdd0xKwSny0L/FybBKXauR4W4WSyj9Y93nBk
	HvWC07y9L1v5CdPckmzaVkpbAWrue87JWlkKB6VQ2spQBcQlZ4riq/2cq5SfDAz2qNCE+dTSa0k
	SZ16zN/lZATdGG6bhqv1gqck8WjkQ=
X-Received: by 2002:a05:6122:3781:b0:56b:5893:d042 with SMTP id 71dfb90a1353d-573a56a12ecmr1637593e0c.12.1777386202766;
        Tue, 28 Apr 2026 07:23:22 -0700 (PDT)
X-Received: by 2002:a05:6122:3781:b0:56b:5893:d042 with SMTP id 71dfb90a1353d-573a56a12ecmr1637518e0c.12.1777386202261;
        Tue, 28 Apr 2026 07:23:22 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:20 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:09 +0200
Subject: [PATCH 4/9] dt-bindings: net: wireless: qcom,ath10k: Add NVMEM MAC
 address cell
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-4-6ad23e75190a@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX/o357luAH4Kf
 JnkZLUssQZrdtugE0Z6CPkP7TkM8/mFyp4c9h9YDmlUnD2HpUZU1PYM1awMrbgu1LWK2u9GIsGB
 6Z6FIO5A36cWQEgryUQ3V0ieeYiSJA70tjz63aSoIDUubrFnHUoNNUalq05p3nOoar4OP9ExBUY
 cwBoDgV+nMsMlgmkBGIIysPjEdwbWtBMKY+QtApfMvWbBK+pWyXZuAPUwVnEsHLHA5TOytIA8ub
 OPZXWM0NchdGwdi2prIL6jkhjKHUZ40p41iSaj6hJJfq3O+GuRl0u64Ek/FiAI5QzcebVnDT14P
 s3eXjyK2uXTuQ4nTwLstD0PjKG7FDNd4D4o4BbDR1shLwHYe38SBdz+ch6Mh9XH/GRs08QRXZ+Q
 8k4fy3pGepjPavtcGayakJPLPDN3LZurM7LDzyJhXDFblO9LwgIR8J+p4jI2Fi19o8PgXLXQjP0
 hiFECGQ+nHshfa8X8RQ==
X-Authority-Analysis: v=2.4 cv=Uu5T8ewB c=1 sm=1 tr=0 ts=69f0c2db cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: dVgxVPkw8bn3dz_vgACR4fPIxab7n_4F
X-Proofpoint-GUID: dVgxVPkw8bn3dz_vgACR4fPIxab7n_4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136

Add support for an NVMEM cell provider with the standard "mac-address"
cell name. This allows the ath10k device to retrieve its MAC address
from non-volatile storage such as an EEPROM or an eMMC partition.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..7155d8b15cc145c3a7d703db0c9c3e056a54c07e 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,16 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte MAC address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    items:
+      - const: mac-address
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1

