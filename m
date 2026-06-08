Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8936322C78
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915847; cv=none; b=dzNGVukS2eXl/Vw+N0O3IqHGjR5pVSFbH1dec7ezTtGatGFHfyi/LF5XQmAKMUUdpGK0DXUDBNxNurcXFV37yQeGM2zDs5wnAgKFl8QAkaBUcJxNQUi/egpUS0N3BZZG6qKdSpd0M2COoxVEgBnUA6Co6RlI8WlfQq77z/Vo+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915847; c=relaxed/simple;
	bh=0UCJVzorof5nrjL5gUJKlIsdVzG9DO/UXG+s7ukNm/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShAQF8z02+6dD4vCjWohaL3Kpwqg9O0q/GpgzoS6itWpWTdrV+ATMTg4c/D5hW64jlN2xRw12S8SmDPNKpA2NAzTjM03AZIH+C5mmOyrjsS7CmzM/W4lpXrM4Hv6bgz9aJIDGynzNIbfVeR148uOS05JJF7Oi71vYiJoinLTyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=duqs7ePV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ib1PHrpC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="duqs7ePV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ib1PHrpC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PmwI2733184
	for <linux-block@vger.kernel.org>; Mon, 8 Jun 2026 10:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qWJbmuTRttn/XpwzU/tvQ/1KKugFbudRhbcfvqo/7DA=; b=duqs7ePVjQYUBxv7
	8kevIzWJNFV/IDiVetmiSOwcEHeYmpb+rToxrVBkH7jYyiFehWLS3zXFpeIrPzgH
	j2rnIT4Tk59sIcoFlBUU1x1rAsp3r+AfPw1z3qz9MqRXDxPWeFRWca7rwGghpKak
	PYj1dfHaC2drlFgzmbmv4T+TrvzTpQEVDgG2W1FrWEuyHDD5RlrnxuiY+phpKmuv
	nKnXpjnjykPfRW9LRvaptOphCVPSN/SWObDKBb8SHZrw22vZfg8RHr2CxZiHAbX8
	pncTphi8Cq6+oZ9GMUHcssCtZdFtriQBDIpAY23EtHvwWFBW/vPfM4oKe/W0vy7X
	uXmCjg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf7j4s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 10:50:44 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ccd83d58d9so66745566d6.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915844; x=1781520644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWJbmuTRttn/XpwzU/tvQ/1KKugFbudRhbcfvqo/7DA=;
        b=ib1PHrpCF0XV/LV4vyvLqwxO3AHD2nzHjHX8KMBCirqUesl0r1Ci/es227zCiwBCSJ
         XNrMzXuvJYPi7PfwFIHOm/36lv49whKMleVt2vpbhjoG4fgEYDJ5FMsomKUw8bcK/JgL
         OKMcQBYwzIf9gdkqIfH7buFa5SS/rz8LwA5Qnx+Rsu80TWkZBGSw9Xb9Ga5xshpmPMrr
         wUUuyOsNJSwbmCh7NA3bdK8JowB+4QJYUPIIWTAcTuWtSsqdkf7k0T3GWftNaPbpRhUy
         QBpYBD8nPmj3HumH3BjaC3G6zi7PO2rEUnUP8T+wZSCgXK6mqapmZFEOb4dKoBI/ge3O
         WvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915844; x=1781520644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qWJbmuTRttn/XpwzU/tvQ/1KKugFbudRhbcfvqo/7DA=;
        b=sYxeQX5JLbT02uEQpsmXZN6oK5kxosTj2qIQko5ukg5Meu+NQ4LfR0sftt6wAjqkms
         9NlAWfYm4vVoB0lbQcF7AtvsL60oaWRdvJyCrA7vWe0+UwQ10TMyzQ2X0EaQcW5dfosY
         IQ+VXppg1HqLwkVy04e7PP/+Duu7VsACt5CDCC29nzcnIM3cqml013b3PrSPLdv2yQb7
         UfWiIUDg8RDolbNVhSd0hfjEOjvJoRFmUwDzSXy9Ya0Jvg52RLas7VCzWKCxo+jHXWCA
         6y4e3khFPmxChdV+CYXkFB+YcixOmH7Q6DKoc4+aHpHw2yaaKwurvCIz65hAlFlboZXu
         k/tg==
X-Forwarded-Encrypted: i=1; AFNElJ9hLa69ZIlgFVEbpuEDKI1T0Sqqoj+pedE2qvQ2tgcb+iaGp6PLQsYZsWRj8kF/9b9oSSqUntT7+D8ugg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1rmLTU8oPQv+JZcml+OYpPNR82J2xqqH8Zvzlvlx5sg9GDFHb
	LeA+BndYM0hgg57ByU+6QUAXokOPpAbjrJl6ER5Acaf6Z8elT9WGeE+juZIcOtKJnOQARWT5pPQ
	qa/+omWQiRVF/aIhvFxLerffHfiLcDFldpLegbene08iwvbpqZ5VCnYBhxFPivZP6Yg==
X-Gm-Gg: Acq92OEWZ4540KPjuRMXTgQdUbH/LrOwWliFB3FBDskj4xTwm/7ZBDlK6S38D3VEk2r
	6I0mZnp6553L8R8T+O5YdxmoVmsWJcnpEg8k1KkwPoiY8K25wPFfTyF96PN/gG7NbKOb2hFGKjk
	sT9ME0VYzG797wCI61wwcquEzbCuw/xyoD+QClmNFZpGSRtkJ3Pvzv/bpFniVMC3TWPwLE+4AEN
	qywuS6EGWliWa71FImJSIxvpaUahXAj5/nBDYcTNV7FazaRveiInkoMLzASHQNL+G3+882P4vZW
	gIluONr1Rc8d/5LWewZo264hdEReVOdKpWqUVqRn7LyIf5QTnDIRIP64YyOtQ6tvMgVwtCoObrE
	kcC3R4ZVkazubJv+z2Qaou9kZRFYygqcOjzOYqeqMLvvTQlNyIdvk9ybj2pSywDvm7Y8GJcWVyP
	/9jyaES2hWmNP4YVVh7pOQaREVdkddJWpzP7lCWU0b9IQ2a4jIbji4WUWs5ifCex84sQeYxni6M
	5v+9nopjonv
X-Received: by 2002:ac8:73ce:0:b0:517:8f52:2724 with SMTP id d75a77b69052e-51796953373mr158456121cf.43.1780915844234;
        Mon, 08 Jun 2026 03:50:44 -0700 (PDT)
X-Received: by 2002:ac8:73ce:0:b0:517:8f52:2724 with SMTP id d75a77b69052e-51796953373mr158455891cf.43.1780915843813;
        Mon, 08 Jun 2026 03:50:43 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:43 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:38 +0200
Subject: [PATCH v3 1/7] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-1-82681f50aa35@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a269e84 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hFPe-bIbDLvfECHHD4sA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: qhBqckBXPYVuf5ZipUdpIxSa0QfHR6LQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX1dMHgt7/xY5u
 dgSUXXtwW2BLfGZdZ3qE6sZIHdBUBCwBBuiElcCDmQGBCgUJ3bPSKWPYJwQx2zmMQZNNh0+Mpmc
 x1oeCaSQZcnuLjnyCr70IXLqIv7l/v2zy3LuNmea+a4f2R45YIeD67T3zV5DI7TUhfVLqJfLD4i
 5hbVFrYplC1RbnV8QSTRaqx5cWMqnuKpI3WnTGLtQ4qPU1syoyA+GL8aTwi9eIqACHLZDvxJ1Is
 tgNI/55QYNh7PHW2iEDvoGVyraviIbuILy7Z1QGWW/KxAhD3bTHUUaBDs9SYyPnEAk/Hs/G0FhD
 PDgX51dH70L9jbmaMDLE4dTT7T4XqDWtSW4MJgvWmFmt4PKKA47YC+M4pVODLSRmz5oaSPAvsxL
 I3QFmHtPE8HeRvbYFnzk4E5W8hSrnAJw3OgooJG42Lgz2La+MC2KGAO7xE6f7uqXwGCAnmVuBW9
 mWY3tXfo4twlI91Gd0g==
X-Proofpoint-GUID: qhBqckBXPYVuf5ZipUdpIxSa0QfHR6LQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..ca907ad73095925b234b119948f94ae81e698c86 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -40,6 +40,9 @@ patternProperties:
         contains:
           const: fixed-partitions
 
+      nvmem-layout:
+        $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+
 required:
   - compatible
   - reg
@@ -86,6 +89,32 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-partitions";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    mac-addr@4400 {
+                        compatible = "mac-base";
+                        reg = <0x4400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+
+                    bd-addr@5400 {
+                        compatible = "mac-base";
+                        reg = <0x5400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+                };
+            };
         };
     };
 

-- 
2.34.1

