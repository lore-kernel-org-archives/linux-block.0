Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955DE44A725
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386213; cv=none; b=mzQHnDQPdFyg3x1+nnnznDwd5zjTISWYfv6zSofPd+rnopz1IowAO/uw+wsLBDE3CgUmDz0qFtU8lu2Ctp2+bp3DrNP0YO1NOUnN1os/bgBbVKpn8OlQMcIdUFhtxcCzmZrx5DT0dJ/msAB+fctkPAEg8/bOl6PuljjtrG1KYts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386213; c=relaxed/simple;
	bh=8aNLvyuCs0cA/dQVyyMYQTpbdYd3gLaJzFwxfD7t/3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZgH9hJCip3ccslovPpDt9Yx7prdXgeMUvMxSEmbTm8dcl0evJV1/ONjZy6Rh/ec+tp9wk8Hb6Xt+KBmRYXmNspG/9d/01nQp7LEl7K4SbFYknBTyeWtQ2uZCh3CU125ZVnr2gpdNgt2AQsT8Ij3HcH1hzoahRnAbfxVo6byKoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DtAn6knq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BhiMwWGK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DtAn6knq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BhiMwWGK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA40Rj3275300
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=; b=DtAn6knqeUmwx9Kt
	yl5DkawW+RQTgBprHQ4phVtcWPE7jBsnsjJgw/ee0YFczkz+EmS6GxaLa9qefrjy
	285x9ymwBvfViyaLyksWqIX8SLt243kvbWvUMVwKepOIXt/q/qaJ9msPNOIZ6r1v
	tUjKo1nOMMERMOKRjwq7/qWcfvsbLG4Upaacz7THphct2lW2FasJqtwVaLUNj3v6
	7k127p/VB1RiM0iltEkZUuyAKIAExZi2r7wUx48Nbv2PHdyeRxglifKabRP+lQif
	bnhT4R13shiAIqp2BYCpbPUNEvt7SFXSCSwyE7K2rxi3OJcPKm3bv/v3T13HXrIt
	JkSH4Q==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtttjgy6m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:27 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-467dc3431cbso5967485b6e.0
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386207; x=1777991007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=;
        b=BhiMwWGKSC1alLhVU2T2QFBceIihX5bW/wNaAehaBlGFj5wqyA0+Ik3C5lSW/KkdJH
         5M9EWVj5RjWkbe9+ijA1Y2li3E0sRERTWb0WNVf4EChKXLqoqoykaWqoOeObs/w5DJ/C
         evI66CNGwDhewDv78D8ZG+Yt6HhnYyVL/K3kMXpLFLqeFaRNkSk9v+7FZfTBRnLJOabn
         uGgcXVDTnuevrsv2LwhyhVqAMHBuqbqED7ocUIt397U+tFIWrlgch/2sYY+iIZuCsCCE
         mGSudBuRVPhFtkLLVk10nkr7yk/Waekd3Cuu74V6JcWALp6K16TprLLAWaGiQXTsxOTJ
         wOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386207; x=1777991007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=;
        b=QRXiVbnFcFwMh1W9phVPo2TZZIa1FjEfdpfj6qx8Us55YOHDt1y9osUa7Ejybv5s1i
         kWmfsNV9ollpWpU6Mr5x3dj7ozKhkYYLJCyAczMqcaTKJKVYjnG0RlTWrLDu3dkcMRsc
         wCPNIiNYfECvGe5TOg4g3qpzAd9Pvvjbcawtcy0YGPRZSItKJz+2OY1FzQG7yBywSJUf
         +E08QapscxR0mNzoluuyK89idgzKXr0BJzbZZeTMvpuGwcIdU1HPhXx74HKdqq5aqGBJ
         dAb35FrWcNTvP3IWc4NjUmAeBf8Bjjp8xMT2bZBg2EjHbjTh3d/jxq2MfgUhO+oZOwb+
         ywFA==
X-Forwarded-Encrypted: i=1; AFNElJ8PIgNlqdoT+gK5EgF0HNmhvTZcJovv0vjz9i7mTFBZ83X2fLxwD1ZsXWI6d98EGndtodEfGd+Y0aqcrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeu7e2PsTNIudNjxmMduvw5aVZvH/3bxoBVfJBpjBe2yi7GY24
	XneAhzqBNmPuGTtEHQfkDgOha4ipP4xjxA7M1gDkzyDhKZWU1A2GxImCsIWDFGacF0QSY6j0Oy9
	St/w1cAKZaBPc63pHdl6ZGJ1yf6OMoUGFugm7IHXtgITmeViiOJiFUAvJ3gaGuL2YcQ==
X-Gm-Gg: AeBDieurrBgvRmy2CGsWikXxhIgyj1w+EduyFNOR81IXHpOs2X93BK7QZ07jNm4y6EU
	tr0DcOw+urHN3v+m6YmU5cbN2o9wmLb3YTLITfFERt7BNocgYXJxTszxOJ/k4u+utf0Vph8jI04
	gIyGx6GI11+JNtIFaZsMqnXTIvWkcyBOd7fJLBim/ZqELF2rHhAw0gdbWP2fDEYN5JbILuvBAQs
	FMNucbLBgsBKQWoidDBqoY0+gpG0IPynTbzx/Z4EwW0NR6JMLLU4KeV4IBpQow155Rd2W+cEW1D
	jmmm0uv/ocJGz8NcStGYzupFvxuKWxutwjvnnaLw8//mRbySRjfxhAngDpg/Q35O1bU/A9sV9LV
	j2ouOqbCO7ksstpKGBtxePsUpqKJRA1uRcfDMfH9G3fDrZPgv0i3Jo/y/woHYJgEakivW5GEfVK
	ApZfUZpk9mwiT3ZS0NL/3TEvpVPFk=
X-Received: by 2002:a05:6820:2d0c:b0:694:a362:e3ba with SMTP id 006d021491bc7-6965cb93af6mr1550272eaf.48.1777386207305;
        Tue, 28 Apr 2026 07:23:27 -0700 (PDT)
X-Received: by 2002:a05:6820:2d0c:b0:694:a362:e3ba with SMTP id 006d021491bc7-6965cb93af6mr1550261eaf.48.1777386206866;
        Tue, 28 Apr 2026 07:23:26 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:11 +0200
Subject: [PATCH 6/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-6-6ad23e75190a@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX3u231xWoy8jd
 PJ8Bqbe860YqBSJPWIBoo0fHkc59OzLCTcPWFB0LElJmMXt2EB6KiMt9KLNRC3tGTSIQaej3pOS
 Ibdkfp5Z37eLuLOxOjFsGmHKJucXODG4cqs7P5mt5BZHVcyM0FE0+0jVrWayMAcQgrxYdlKHPYV
 SCCWI43Ir69EchSJZgLJoaE+pcOQHggJBdwUODi+aF29feohYxS5rN/gPpbZKaXUwf9d78dBrJo
 Bup8zKPV94RulwL08rbFpW1WDrbx6z8vqCYFJDTOCVY2HUj75sOTOPedynAsUjYr3umwKXHGKoH
 gT8z56/SBy3AVj96SblyH1gguT9tVP6vp9pcqMi0a4v21IzPoyPulala3wPuhRlts2kyhiYtVp/
 nz6PM46OXbsAfxRUEgiff9lW/ykLoSGt8UilG4M8nk6U0+no2A4Ql7eLNW4puoKpsu5RWQisGh7
 q/jDHyWuZh9xMndmOGw==
X-Authority-Analysis: v=2.4 cv=TZKmcxQh c=1 sm=1 tr=0 ts=69f0c2df cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: SmhsJOucGGq7bphg5gHyyo1C72Dau21T
X-Proofpoint-ORIG-GUID: SmhsJOucGGq7bphg5gHyyo1C72Dau21T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../bindings/net/bluetooth/qcom,bluetooth-common.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..ecb3de65506f7f0f1fc1d0b9bbd316163b7c26e8 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,14 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    items:
+      - const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1

