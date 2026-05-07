Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E144B677
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167491; cv=none; b=GRPhCqp2NlZ6FFR5cQFOrcg9guz7r80wGI6xBAR88XYidHxBWdclztIVoY3mKcB1iDc85/oANQvY5Sx2FUNmEhFhVinStq8ymuXIKX8tLARMtyeakZDqgMU98ePEvjWujF96IkM4SOTV1iOlM88K87HTgLsmCxnuSTlVhZBvA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167491; c=relaxed/simple;
	bh=Yq9eZWlTIDpBT1jqRXA1YcQ7jewB4Li4nESrsfqdqxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aeba4KmNKjHOTeyIHJnhCpkTSTSAHzmth4WEJNO00GDfmw2zMwKNVGO2XguKiIabxIUYV9mmlIXKopXcH4ajjtSvBXNOXfD2wz63MjFdckDQd6qgLjpLtr2xBs76owE2BUyenqzC75bhDTPCTIxUPgJQX0qsdWobsNLtLCmvx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PHIaw8lj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UqyYzGxt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PHIaw8lj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UqyYzGxt"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6479CoHZ3464724
	for <linux-block@vger.kernel.org>; Thu, 7 May 2026 15:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z8YhFkwRRG7HQCuWlp0zuKi3fIa5ZkmTd/FI4268HU0=; b=PHIaw8ljGKMKOyXW
	JOMO0FrKk7092/z3zBfZ51Z0eshaRXz/CQjQi3MqCNsDNbb1qyI6e1z8L6NOHnkr
	a1T9wEdg+HlOXoTK3j8BvpPkfYpIYnQpUUdIHv3nEYEtQ6QuuHUsOFBNOYnw/w5k
	G2dlYAXt7ffweosKr94E6p9uMOyUBDLi6BeLLgIrCIfN6eB3m4+vWiIyvLUwJqUL
	IeNMZtKS/iDJbuF36Egxpn6xYoL4qBCCYwivxpddkuSgwv+10CSYj8MbKhHJIe0U
	Vg0yh/yatuoRZzZWNG2qQ3C7Gm1F+6hc4NFRkzcjcFx6rUa0Rh0SVRfIm84CrLFu
	IbJ5LA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hvn2s8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 07 May 2026 15:24:49 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-61010bc9c12so615963137.2
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167488; x=1778772288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8YhFkwRRG7HQCuWlp0zuKi3fIa5ZkmTd/FI4268HU0=;
        b=UqyYzGxtw4RaQzs+Lh7p3NAX+TfIazBHUHl3Tt9PoIe22UEUWSag0zGZPWXj6nFdoa
         US9Pn74G3mNcsuuFo+X/XgxXikIOYw7eFIBrj8S9FZfN+nS2vLJ6YvI4fHxY5uJlQVUp
         crYdIPHBbNbwuzxZ1im8QrBxY/KxQg0B/eULb9Wh+WUNMUboYLovphyOOjUL9Zw3fI9r
         vcvXH6fmR6WE094U3VU8efcdFEL3jwtRYslld5EKDupMG10t5Xvd7TP3Fyb4+9XJ8Fd2
         GIdUdFy1918mpYnHZwwBLB/0/YJNh/IJD552BSffi8RHc4Swpis0f4CYLisf+w/SU+S8
         SFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167488; x=1778772288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z8YhFkwRRG7HQCuWlp0zuKi3fIa5ZkmTd/FI4268HU0=;
        b=PfF+TNLQt9BqIdEew6TLVvnfrljwaVggjVrQ+drRuYtG48vFm2td8v6QPo/AGG/xmb
         +lpBm3DTcZOW0R9U+F/etOBYCa/0KnuVLmAi6ZPQnTMdHdAtLQ70CByd0avUd8eBROFN
         jwTB9RUvvj659WP1XTko6NufVlqI9Ic1mTm3WAShhVcpu44ytIY0iUPuDMJgJj0S7vQ4
         QM1DbeML11jjy5wZjGh+6hOHjuQjmj0fALOc8MiyRjngZnpqEyvcwhJFtxx8oWdim8AA
         2m5ckNcGDkq2TrPmsVLn9S5nzHJNaQf7QDbamqbOXXWAFfbiYxNI0sSFlg/lefiawCpC
         0QKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zNXq8R5ClJs5LDysMhCEmgam3ej/flUlz0LA1qfM7quyi/w8ueTksB6BhmnaO1h0hemg+yT5DhAC/Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvI1Mq+kWciQ5OIsuauLGgvhT2KuJS9BT2oJc9yfX+pxU7pbZC
	oO/Kje7dShuZIWUscRzsYsKq4nFv2Cqe6n8CSneSEPjkQbtekHcNR3HM36e6vC1T+KucHS7iAxq
	WIoIFiXzzNqxKCp/EUoT3tGaAtzRb2whg2KESFFpfQn5WyR6ZizynWgSeKIp7xWxLlQ==
X-Gm-Gg: AeBDieuHIiHSNh7fZqoR/uLovhXbdds5x/U7ngO3BTpCoqzrTM16ZuFNLHF8yy40HtW
	UUNFaozelKC2E9pL3IMg5QTjuBEKthLWgbRTXFEqqGCm3Rdd9suXE41CbYsJfw7KBqdbcFZrxfS
	/cKX61rSVjl8Getg3c7bwTak2bcEHdKj4smRu/VE6oQ4BKboFEs7mReYbfJAj0qtXYQNpQ1WEO4
	J93afwy7I5a20MYN8KgNHYoK3U06Gh0jjzsMci0g17eYYKur99HxvJQvw1DXsaOTpeIdsu8cnCs
	QOHm4+WCC26zujdfl+DVnDJasBQvhm6oxDEzFCY9Ikj8f1ZHmoDsmAsVQG1bjVVXVn4YsvwIExQ
	Pae3n5R1WnpyoCnUKjqKFKNbERVNKtXPUDqJ71zr1wv2AcATE2BhR83p3UX3mqOIlac/LQN3Jdx
	XL15jzBs4hDjhkJNSUATe99oA5dyQ=
X-Received: by 2002:a05:6102:1614:b0:62f:c97f:aec4 with SMTP id ada2fe7eead31-630f927f4fbmr3735584137.27.1778167487894;
        Thu, 07 May 2026 08:24:47 -0700 (PDT)
X-Received: by 2002:a05:6102:1614:b0:62f:c97f:aec4 with SMTP id ada2fe7eead31-630f927f4fbmr3735537137.27.1778167487442;
        Thu, 07 May 2026 08:24:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:36 +0200
Subject: [PATCH v2 1/8] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-1-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX1d6EIpGxYXY/
 dBvEWvYRU1wlP/8eVBe5oOA+uD6mO9cKq3c17GUDZ9b3WTuq03SiWQjQuBpe9xq9Pu6unDZh6Ii
 /ugjO8aCq70TaooOO2Pi7+FaZOX1FX4CgS888kTcZ6c1Si9fIHUI9PVsUlB81jpMzmW/r14vGiZ
 Lo0K1HdHwZ0p4m4zWwpPU2djpPpB7igp2ABxosJBwlmJnl6Kl9nLdwpvvH+X0+jc+g8P/QB7Vfs
 0bgty9kw/c222F43gxbSpbjZgHV+fKFr1FTl4wZwJpmBwy3lt3aAkif38ECNaZqpxqKPBEm0TqI
 sIBn/rxvAm0eBg+Wy+p876LpvQ0b1iJXVwK+p+FeAxXU+ETT/ysYNDwWYT4dDFlJHSXdBsNseYo
 P4XLpXeVpYGPemOH8AXJ+PnkA4Ib5XQ0lfy2sOW+kzHdHG8QWjfK9torKOW+RVXl2UgvqgjmyIx
 sUJ4rQHC0VdLZNKMqyQ==
X-Proofpoint-ORIG-GUID: KVHymtBESmWA5TQ7BidlyUSJ7VNt4Qxp
X-Proofpoint-GUID: KVHymtBESmWA5TQ7BidlyUSJ7VNt4Qxp
X-Authority-Analysis: v=2.4 cv=ZZ4t8MVA c=1 sm=1 tr=0 ts=69fcaec1 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=hFPe-bIbDLvfECHHD4sA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..b21426a49cf1d9aae5b4e8e447b5be11b08c96bf 100644
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
@@ -86,6 +89,27 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
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

