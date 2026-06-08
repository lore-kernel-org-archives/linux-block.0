Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5BC33D6FD
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915849; cv=none; b=Nh4m/Gio4utZuxtX3RDN8hzZO/JfJTSVCxJEuxPWwyqywe86uIj/ow8qxpJuzTCM1KMZuTTrRN54rWOJUXTiNFM2nF6b2fia5REOUOxMWzUjkq372KHcb1QbqAjv1OvlUxxsd0Q/DMz/fkLycXzZdExt1WzAtH/hGl25/6jyGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915849; c=relaxed/simple;
	bh=Py9S39WSsqNn5txRhNRguCyI8QhKY+XwVW2450FRg1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTd5RGu2S3yPOKUiSVJWddnsDEGR9iWt9x2xCyaROQ6mkFONuQJ1ZaAbkboRsJ0qxn3d6oJbAeyVj+yvaAPNGxGLgG9jnvjM64AwvSlB4+tq/grMdJjpnuWrSFvffn4Vzer/cw2KVRVFcAeB4rXqFo5lL6ORwpYnFcDYIuqdgjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DIbofuVL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWwNbzKt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIbofuVL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWwNbzKt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658A3OSr2848052
	for <linux-block@vger.kernel.org>; Mon, 8 Jun 2026 10:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OWi+MtCOvdURNk0hMiFLYvRu4fS7vb184xBw7cGri0Q=; b=DIbofuVLZ0OazGPY
	eM5Fx7D4dpdBevCAkSGgCG4FSIbgCFSVwfZW4LCQAntAgjPxORVNho5v1DCgfslF
	W9kj/1D7UKheGa6LNYtUnNLQJOOex1NVWxTPw0zSfl2lx2eX6JCUa7+aDO+bKy+c
	0rqCQHpy+l1MKNyCZSbY1v3ObgIN6qzypHWDb4Z0yV4PFVe9jK44lABrGw5Fjmsw
	PrwdFTEvzBigxfKLrzRJ5wPt7S6hQ3nCmbvRqXaFkcchzzBXhc48ggXw7gBo+OG6
	LwmZ7+R826Z8AO3t306GnuKl+gyzgYPbqTIR6jn3mGtVnInRVeLXvRIVySfZjkUY
	HJaGEA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuna86pa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 10:50:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5175a1e32e3so119761521cf.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915846; x=1781520646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWi+MtCOvdURNk0hMiFLYvRu4fS7vb184xBw7cGri0Q=;
        b=fWwNbzKtowlmBTzbBb4R0//1pts1pkwTsZYLOC5+KbgAcm6b3OwYvGiCti51PYmSYt
         Yth23EBRbA7H9e8TqOcwhlpOaWcfNig6tT0l4OlHH7wu5ZiqzYY8gM8pAj4NesmDdqCF
         UOKtZQRn4X7e4YkgxBgPH7NZgqEAMwo2yilwakdq7CCw5Au0tI7HSBhtUOjnDBMMNscu
         uQdY2+5skXjqem3jA45RUX9qfbXT7PSm7qIcsCBCjtdexqRaaCWujC//lX9TNITf2KYr
         qzFBUNK8AFvtBLrp9a6ejo9F8/d710hWsNp6VPjBOVhjQ1flyraBESGMsnhSQDwMMW+S
         R49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915846; x=1781520646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OWi+MtCOvdURNk0hMiFLYvRu4fS7vb184xBw7cGri0Q=;
        b=kFtyzN253vyTop+Z/PajUVXqJO/qM21PYc4iUx7J62cdcX1mnmMJ8HaF8DGQNI090U
         65QjTsYiYyZWR2HYWYshMKEmEaLwwvVGEDYQf5BJYGYfsRks8QV19FAPAQtn89tHnJ2Y
         vA67EG0GudxTz4fyrysK254zqGl5oW0E/zzoffdVdVd5d2JPHHHNHqYwhU1bRDmbr8WV
         8SkGqX8giB4C7twFcq8n3yS21CsOxzcnzkJckb6RnOevpnwfm6Mr2cYO/OdUl0kRUtOb
         Athp5x66fGHz1vthfG8BnbX4cd7gtOkLh7ErZfjHwdAuhARSwzq9xTn4iL2HPTs4aZiv
         mM4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9QvYJj6rbbuiYIS846tv48n5azl5Yzrvt+UodZNzJgYpFtmffE1kd3ZmioUB1a85Ynah741sSxUmp7lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjUh/Ybyts4Gmb3+579td0TVYfb51B5J9ALVfMHQ/wywMUZVvb
	XLrKqs0KM0kyIGv5bdsvKBbxd3zb2nshx0wISfaxqK/uwcqEjep4X38UDg762ExWtoO0+EUwvXy
	hFdWzZHbI6JfwfqTKOZ25xEDaxVSs4VV15LkBps6dZ9VbyXPXxq/ZZKoWBxmMSAlU8Q==
X-Gm-Gg: Acq92OFA/j5x4NCzvNk9yUt7TZqwNBfsJJsn8bNgmWBM6p80bhGxys8icwr1opOCP5W
	p51YIH6JG27ejUjQ3EjuqCf82v1sljVT45FRzPPTg+Y5K7pOH+RlryrL14B7ajGzXwwq0i9FQrv
	SoIeF0GbuFZLx4qh1lWwCM1sVgk4h+7Wh7HIx4QZoZx2eLkDT9ZEU+TqxNMVhikt+0rqRvb3ZM4
	yoEW1HC9Fn/9lMM+nXBLkrZ0TMbkfBuTr6X5/l8qhCAN8cZMImG2XAj2ZHtDPMAkyGV86J57irP
	5dksRIAQKxvLZ3bDH9uCiMQFV9BWqMRrhSjoQHaZA9QB9cbmfPMKFNwP8JEPs61wha+g35QfqY8
	FS5QYkbcjxV7GGzZTSLRKk6k2zVPCma69LrG68/ERySriYBkFhH67pKI9m4SrnuR3WABlhu1ryh
	xkOHpTwVOzOf8j2Y8Vh1fryzqbKufp1n9+ggy1eDzsX5illEr1WBr8I1lwge539CwHmZTZ8qlsS
	vXpy3+44mB4
X-Received: by 2002:ac8:748a:0:b0:50b:6b21:2a83 with SMTP id d75a77b69052e-51795b7322cmr169213871cf.3.1780915846619;
        Mon, 08 Jun 2026 03:50:46 -0700 (PDT)
X-Received: by 2002:ac8:748a:0:b0:50b:6b21:2a83 with SMTP id d75a77b69052e-51795b7322cmr169213621cf.3.1780915846226;
        Mon, 08 Jun 2026 03:50:46 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:45 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:39 +0200
Subject: [PATCH v3 2/7] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-2-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX6lo/x3iUODKN
 mxm8uoijDxv9RLPg3JTsyhH618zcNwu0tHLQeakxdthQ884uZNUpJkfvLEjVkGyMXL4NteG21u3
 d8aw5h37GfxmVB0axXpIL9tCxycDTSEjRt4i4eyoP3//WDvN36iHtKPv1qBeTnufhQXNZ9sE1Ew
 ZIAZcqLzVhZL6nAvHPkRrRMu++Hh10PphAUnuwEkl2wEWp1VrLa2yDKosxBpaqNOaicQ/T5ecN3
 MYl0PYsC1M7Oz9zC0i5ysKputHx7QCw1ewuxK7FVhyBDR3qoeIiBwUJcFQr8RpHL3gf9dHNYbi/
 1iSOqB2qYWwQYGeLiyr6qAuKzddCO2pWYjy/7zHim1DOkJ4eNjWCP2FwBmlQ/hNS3d5yzopT8mE
 VoVo6JBiwiQVoB01/UUl/DPFZr8HlpM2zxAb7d2UQbN33f/sdcEKW1iszU5cUanvbn8TLQxrBoO
 h3xqHGQdxTacK3lk9tQ==
X-Authority-Analysis: v=2.4 cv=RfugzVtv c=1 sm=1 tr=0 ts=6a269e87 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: JFunuS2oSe2qnQrGMthGc3ReYAiMP2Hb
X-Proofpoint-GUID: JFunuS2oSe2qnQrGMthGc3ReYAiMP2Hb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080101

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..7391df5e7071e626af4c64b9919d48c41ac09f1e 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description: |
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

