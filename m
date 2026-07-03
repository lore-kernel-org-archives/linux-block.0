Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2373D9533
	for <linux-block@vger.kernel.org>; Fri,  3 Jul 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086326; cv=none; b=dsneRMx9q26jlfWJVeqJP6Ywh5jBaw246Fuv5YOp/wtYBnqO78n52H3u8AmFA+keoK/mUaulfccEJy6ezkKmpYc+Jl6kA1PxNc3JBY2bzSzcS3ugIKYopo44va8T9lZo2M7e0AEe1RJOcCST890UVAMDmefCMkEoyuKmd/7PeBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086326; c=relaxed/simple;
	bh=g/kZEO26OX4smC+wgpc8bkbcZi84SL0SycYp6R1V6Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMIjK3Zu8fPxYYMnMKvlvePgAoUA6YFvZeC5j4DmsRCe8IVufrppWgW2V3li1pi1JKhlUtPLxOxU9dxXRkJOtKpacfP1ljD1i3/GATIIJSabCk6Q1QUhRSUsJGR3x+pxoC535ifHW4eCBXRx/7+tNQ26VKs8dcet9n/AFevhYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hQrtxPOD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TOKtYeMr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQrtxPOD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TOKtYeMr"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BxjWI3053703
	for <linux-block@vger.kernel.org>; Fri, 3 Jul 2026 13:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=; b=hQrtxPODMLsXzsMY
	Ky5XzFZLaa3/GdOLddqzgIsN/xncfImwxbfBYVyirfLaRanQ7XhsJPPXlbI+INlN
	tIDpj0PFEJTAwEnsgD8ry+vvE1MsWu/JQlvFKtOOFdjREWPhWKp6uc7ZrS9utKIS
	7fn7sgSTRM2nIzTbg7YN29v8K+NEHXAR5FoZL9HUF6CJeU09thBjQ0lONiFfmqJz
	blcbppHE9CUzXBTG9v9d/fCpNnbQIjj2NYW2W96h3qHVRRi9xqb2BixqfPpbHKy1
	SL4hS6mK1tnDjr6FwfQV1/cUBhOQScj8Ym1n8gI5fDPIbpCo4QQQCvpgIOZX3CTD
	3jcTJg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j01pd5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 13:45:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8eeba1d9e47so6639636d6.2
        for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086322; x=1783691122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=TOKtYeMr5Ig6yhlGAE8TelGEDNL/Q+zYAbzjVFVhO2h7zIiG81Wvkd5psLgjklAOKa
         yYA14KtUGQ9r36jFOfdlDulaMh472LHcfqzmyGfMox2KA2n/SLiRSerg4g9BiY5pyZ4g
         KdAHXJTeO7Zb5t0L8+rP7PbhYSysjLxcqvQJMENNi1dGyKdJRHxC5i3M20P9W1ywRcne
         qR/RF11HTRIynDKfUAgTcaqRPYUWacfzzSK/vYJI8VVW7em9GYjVkxfnQUiFNa5WZQAN
         53LhvZUm9okUpaGMukm3vBqylpNyfX3MT5/DuO9lxXVbVZFY8S0LV+jzzBbp/yUYX7p2
         beIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086322; x=1783691122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=Aah1Uon9jKlazsv2udRopvVPk26C4GgdUWiVG2VERfcZb0VfHB+BZFMne01nZgAkQD
         fDTX/3Jq8iE9rpYGFQsUcNyKE/94Ht5FaC7i7yuo+Cv0tKtJNnUw2k/CfxjCGEh2s7MB
         dTZIOZ+9r62tM9uDx4CgZ4tFAd7Prk71K/0pcpmUyJN1mCEwACnUkGvMlk8wyuUbILbq
         hOJ34zAIDNZtAJgYdp4DewDkdG5m8Ma/f2HjGr2lUv/o6aNBbtSgrO0X+ytirixCEFUQ
         0PpmwDoD+k6KQ+0sT03+jQy6o1XDcq786hDKSESCj4yLos/8G3umv/9oTQbWpX/pB1n8
         uzuA==
X-Forwarded-Encrypted: i=1; AFNElJ+8gAAVpV1XPtOLE1I1DiOhG9MqN5+oBG64SRKfEq3jtNME1h5uFkZ9mZRVSG5oLBBb0uAZDM0MUstyUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQT3Uf9/LNhDVRk8nWEdJUUGCmXfzn+IW6qMXhdXYTEQwjf8Gn
	0fqhNatOa0gRE5H+/1hYxLsUI2auTSw1el3wZZ5wAUjN9pmmsnJnYYZCityBg8BssaTFfKt865X
	WaUzZ2F/WoQXq498Dk2vQD9X/uyPt5Jg/eRBhY3vUpaG5CeVCdghaFocUld24TxBfYQ==
X-Gm-Gg: AfdE7cmBcCsC7eOYiLc5pj0qSFMRrTMcCAcBEWInM0+zgx94b5YhbHn+H+N3o5KwD9T
	fTBc8U4g7MTVJymJJPiBL/FatxYh5TyAYjR68BJmcLL5A1d6SU5TJgbApwPiE+RDZTGZlQbhgps
	JHpA7Z/ESyn0ArizmtvRIbg3ZTKBPo06401ld5u6JnpOcvTn7s0nT9pBllWrewYsgjGI81BZKuM
	g2SoffF6RcpDNbBKQUDCZ/OBdflpxCSC76gClSLlsbgsERa6bP896btLMRRhrDxIOKE0JIRiXvI
	Uo9g83dVt0QYrfeZfQSmNccX01ONm8S40Ylp21GxBs0uWDW02xJCLmg7lvnsZqDv/6Dj7LxcOYW
	xiYtkSDDsPmxCFKAbY/5WLdKD9vZgMghyuYFIo8bULbzvERUA3p3q+qVGzyoX+l2nQIWZLUdBrW
	p/GBEa1YtX8pOyMS6CDj7LZYcgjprFj5l/BtW+B4OL5OwMDyGFw2u/ewXiezHCo4I=
X-Received: by 2002:a05:620a:370c:b0:92a:c203:471e with SMTP id af79cd13be357-92e781dd674mr1486713285a.9.1783086321730;
        Fri, 03 Jul 2026 06:45:21 -0700 (PDT)
X-Received: by 2002:a05:620a:370c:b0:92a:c203:471e with SMTP id af79cd13be357-92e781dd674mr1486692485a.9.1783086320737;
        Fri, 03 Jul 2026 06:45:20 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:19 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:14 +0200
Subject: [PATCH v8 1/9] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-1-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: hAx_R1Fd572Uy22cwj8hldjXwP7UaPBI
X-Proofpoint-ORIG-GUID: hAx_R1Fd572Uy22cwj8hldjXwP7UaPBI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX1dI0GPxVmGu+
 xTbfQrZTr480JVQo7QBIHar5GPlJ08daL43hBbDZFv23z9DmptmXfdx+UESODLZP7ehK+VkhE9U
 XO3RQgl+XeYAWC/f822j2gS+dy05wiw=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a47bcf3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX42CfxgxEnkOC
 AROuAHncgTXPL2gTo3CLUB8XuG45Tevas1q/EYv7EJ6JTc/rksvKD73geRtJWJbngRrXVvytLks
 UGa6ayqL+BE7lsypMU5TDcEgrv2brVi9l+jfi9di0+oOSKcr1yvdxEtQn2M9Bv6QJQRV5q30ZSw
 kEbix5E/tz3llwwB3QIETJMf/0iKgjAQa/wsVrs62zuAlr3XSXfFh8WInd6FiZa19wIW1/kPAAE
 WpjNRngzfxFHfnOfezdz+7L7DfZCmq3+7HXC6xAnpw0p02GMEdVjysMUq/qIW12sN6Sg06AdXgI
 ysczx7Jl9c44yYhDkxz+yPmSrsvc4Jyc1eh5EYXeVq9m93nhc/jI5JmQl96SJ04HuuALTbBeG/y
 C+Is7Tg8jZAqGZcIF+NwTP1cDIi5JhjrndR5lh4hJQAwLasJakpa0HShJV710iBH3FWL8QwTpw0
 5/Iwb6UAwZASO8xGdfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

Allow an eMMC hardware partition node to describe an NVMEM layout so the
partition can be exposed as an NVMEM provider. This lets a partition
(e.g. an eMMC boot partition) store device-specific information such as a
WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
cells.

Accept "fixed-layout" as the partition node compatible, in addition to
"fixed-partitions", so the layout can be described directly on the
partition node.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca68292b58a5fdbee218358 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -38,7 +38,9 @@ patternProperties:
     properties:
       compatible:
         contains:
-          const: fixed-partitions
+          enum:
+            - fixed-partitions
+            - fixed-layout
 
 required:
   - compatible
@@ -86,6 +88,25 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-layout";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                mac-addr@4400 {
+                    compatible = "mac-base";
+                    reg = <0x4400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+
+                bd-addr@5400 {
+                    compatible = "mac-base";
+                    reg = <0x5400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+            };
         };
     };
 

-- 
2.34.1

