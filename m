Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228E3CF678
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027135; cv=none; b=Hh8creTuWoXlNuUt5tOzhQoqK2Cx5tOqSeIcx1rPXeMhPoz4LL0n4P5wx3SB1omG7WaE9c/KW+UcVaxFTw1SIz5bqnZZpN6nPo4tkpY6OwzVXMEy62JNKJnYO6j9m//3TUAwMz+q7P+VvWyonCUpeoi0LiCTp3UH0qAmpLnb2uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027135; c=relaxed/simple;
	bh=rFLR77CJJYP1sKLFQ6gl8hLWfcBFJvASp2MjESWcdt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jH78TxTSKrbM7QM8Uq3yyD2nROJ3blfvZggb3snuUn+k2FKukVtgoN9F2Y7HNMSO1SY0A78kSo+PHEKUR/PXc68seX++S5KdCpaqPQ2Rm2EXSs45+lU1GpbVHIfsKP+WS68Nsax1GKfg0CbuUULYxTHtX10Bc/+lMwy1xUEMSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DY8zLtgk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HPrRqYRy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DY8zLtgk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HPrRqYRy"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ndDS1625673
	for <linux-block@vger.kernel.org>; Thu, 6 Aug 2026 14:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=; b=DY8zLtgk6GRUKKXH
	ChvACXmhsf7wRge6WlyJBT7d4hVgvki94RA1N7o53IJ6WoMzYGRCarNMLpYLFwzG
	3nDXtEuYF3/p0zimY+tOUUM5+tN0nYnD3xU5yZ/JKpuk36jd8krQwo64bxdmJ3G1
	jPbL5DM0gz+L6MfwAQZpZwkHrjMzuTadkrWryDvyz/EPmH0GgWwxAcPX05E6xxTb
	9WvNdUp0TG0BznJspN/B7I+G+o3oGERTHb06nLVFrBuew8It9V3CJslxKhYZK1ec
	EzgD7VRnZwvDo51yH8+rP0bFF+mHqxw/xrDqg4XrzMAFpH0odyAqNQ6WaP3UVRl2
	PxMeCw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvntnhxp6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 14:38:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a236220so21688721cf.3
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027132; x=1786631932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=HPrRqYRyp9VRV4c8jnwJoQn7HFKLsJ4PbF600beG10JNh4QzlGmgyACefyctu/jLtt
         0tlGUeZYk4qz2qns2I4gki4I7SRPJ/l89U+0yZPfIfRts5n9cOHRxfjuGjCzzGqYVNgU
         xJypK2gxSF5baIRh4LtOWBi+sBg3Axo/BO/NQE4xt4zQKTdR0rzOSyiUVYfwkOVZ/qB8
         hntIFD3mIEF7TlvpIIvw5zTAlqpyFZ5yTYGs7iHZWxYdgIfgaHigmUuHevwuSC+2Q1jw
         TDHBLe4cQa7MxM9jUJjHNKoPxB3U+KUJK7qYSlb0x3tdjf6PCedqjVPHELZb9ErHTojm
         8ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027132; x=1786631932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=pe/CKMkp+BEenJyAadZu/9G6wr/0SeibwThSP4lRIb+OFwuHvwrOf//MeXGhZWCAs9
         AkXK0ZJp389DOgm3YjtOpmcn9hU0l06LoW208vxdULtqLrVawVvd/x/8Z0epY/FJA3l3
         puYbLegwZmlyMOV2xzT0R+F+h+Js33CIdPXFXR6rye83Nbou6YxPcHOBjU6PALEJCQ7b
         KYOHJIl5IlaSZXMJw9bgFxeo12vmo+5kdkz4XUEM0Jl4m33dV5JLrWwSIob9xuIBF9UO
         ECSBV7J6clFl/TCTE5yydXxI1BO+Yz21NcRRg+uqRJ7YHfqR+0rTE5eFj6dupi6P310q
         s7hQ==
X-Forwarded-Encrypted: i=1; AHgh+RowXNezWv6RqmgNzJ/jmltoixVDxxizTuwj0mMAUu2QGGzrmLqWbY/wU7ykkU97km2ednvqfCLC8VZFwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4C1FgwdqgO4RUw5yOGejPrhahFq6nRm63RkTaLyPnfQ14eatk
	2toS1xH/u8gvfDE0U2d3usns7Njs27pvRsHEQFrgQAKuO802dhU4/L8FNT+ZNPWJJpHTMDkTk+O
	jNnH6EFpUMu8i5MQEakZldvVTURVe0qgXc7h/sUqTQDe/BiJ4NmfciCMDlzYXDKOzeA==
X-Gm-Gg: AR+sD12LdcSJbYgZewd0rZBUwKqd0OUy2I05WSXiJnixQERpGc8EAdedkjmUjFqe1UY
	eReYaDu5O7FIsTAdxw2OZ5zUwN0/A4yQXuKdXW7oqRNdJ/aPzrFaP27fEMncS/h7IF1Vo0CqIQG
	g1rpSOguninMNMFTynFiEsN91efQFK/QyOESliWDeI/99pAa2GzoJcXY/chfy9WJmVxn/7CNTJi
	mAdV9bZyh5xSFPE4fLcWpEyPxMkBt9WjbrOCHLOkUxemJas7qwGASNYJYy/8gnkVUoLiFmSt8uy
	CGKaH6aTXq65PtUmPbcVQ981FEaIHm9JqsLmQdsMQib2X9nqs+NPxvnTL9FJW+gPK0P8dNypy4M
	ZnOq7ogJVDpLEavHWnJBaUEOMREFetGQRhH7Bywm6BClSmTFMaHSSD5SgvicGnpAQ36vzgsJykX
	Y4Pv2Ya0CUkJMSIgWsj6CIssffvJkWKgQUa49QOHe7U98yvUbACg==
X-Received: by 2002:a05:622a:1447:b0:527:43a:2f30 with SMTP id d75a77b69052e-52ce5f6013emr149751621cf.1.1786027131468;
        Thu, 06 Aug 2026 07:38:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1447:b0:527:43a:2f30 with SMTP id d75a77b69052e-52ce5f6013emr149750561cf.1.1786027130781;
        Thu, 06 Aug 2026 07:38:50 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:38:50 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:35 +0200
Subject: [PATCH v10 02/10] dt-bindings: net: wireless: qcom,ath10k:
 Document NVMEM cells
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-2-be598b2a5606@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfXx/+cmICC1NjH
 4a7SUzQv78VHffqXvDZKCx3sCGcH/MLIVQl4X7odcA34NNyhK0NLxuLfGnSDhXO3+6jxfR7g0YM
 YJnoyBTH70ZVAfe9QPWVDSkbWkRiL97BqTQ2ltxqL29zV5Snjus9cEun9pR3G9zdfaShZrXbyAb
 nrF53hEQFsMsywFtqQLOebEXVYRTDNS/siiiHeO+LrIrLZDxA/14JFTwEo3uIxzDrpIyqw+Ep3D
 PYdg22K7ujSNf5eYQNCsmFlE9fbvNr9zoe4WcMwQj/kYJ/Rh+nvhNbEYAthdZI3J2YElk+J1Qw5
 kC2S4KKxKQkVQzk2Kgr0BO3rVxtvN/KR/pQXurTaW3fU+2RmhX0yIFjugbgs4NAHirCoSl8HWkR
 xfujZH3YMS44RSA2Ht8P+mfMl5/T+7t8lWyO67ImxYyGk0RIkZN+KjU4pIY37L9/me/VS98pd/X
 hHoPB9SHScZYvTYGg/w==
X-Proofpoint-ORIG-GUID: bRwE-NVVaflISpBIF96CsA_a3poGBY2q
X-Proofpoint-GUID: bRwE-NVVaflISpBIF96CsA_a3poGBY2q
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a749c7c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX/di9FdNxbbic
 oMinV7QQRGBxudwGPRGcnnvcWBBuSydpelMkABB/clP2MglFABBxRWsX/+JUtwtVgnP23C5UceV
 d0lRoE6w98usM9hHqHlhXfyxhzPmEA0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060114

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Since such data may also originate from chipset OTP or be supplied
via other device tree structures. All of these cells are optional
and can be provided independently, in any combination.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index d4f4d72ee0d388f43437fc5a3047f90b464a5274..7f9d16cb7c14330e11ce7d567d585b5e47793bd8 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description:
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1

