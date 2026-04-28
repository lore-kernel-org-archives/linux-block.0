Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97842EEBA
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386197; cv=none; b=Qcy2lSB17vKl3zqtQXFPOeR+AC77quvmpTCeZF/NXxLBq4Q8ARC4yYWwa7kD0pTJWbqadZAl+lcxMGzYWH1zI74gVpeiBhleSHLwcN72hyqxzCeV7gvjuhhtpoQkcldsvblnLEbZGs71Cb0kgJAOZOrvQ7xrc2Ym9qZWO+70Sp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386197; c=relaxed/simple;
	bh=HbSuGEQLc59Sraj4LOcdwW5GSnwxN+lPZ5bkvzKitxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnxMqDEHNQnZuFJi25PTk+4uwZuET6lRFIBKzVdpiNDDXJwWUXHD2IkBQGz9AORtQy0a+0MUDV8dgeEiyhf78HMleHtaRzvlBVFC2PF6/dI5En+KoXiVCiraTSH5I8aRiU/7nzOVVGd2Shnrfd350aZNM+WJw4okCQlvej1LsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b9/Glt7C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YpZBUvZ9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b9/Glt7C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YpZBUvZ9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SAhsVi820261
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2wf6P+dIy3swdOfFQ6eaG3P+EchYwJG+lt6mzyhgaNE=; b=b9/Glt7CpnTksk6T
	JGcQezNXo9AYJwE+b5mnK5BrfZG7lJBvUp/8nVtf1RGaGlCsbmGdR6JreCi0WCxo
	vRt4PILMYInu1zP/3mtX5lO2ousrHul6pzCPMiO2njRYYFUP6dJn1wUKUOQrr3+5
	aq0lEqW0hhN5k2tjlcmBkLPJmVJfQeXMN7EM8uz9+Eyl8pqV56LPqmHFPoOvYv5S
	tJRwF0UNC0phdM+4Cu8Nrt2EfD9lFLmLCXQ4ktIgZycxL0RlP/tn0jMjhE4JZlUS
	uVhHNa94P9G+ICy1K6vWHqD7qZnCOd7Oeowdi2oUXSXwybgLW9mQ0ueNBUHeZrN9
	aSE4fg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtud20u0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:13 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56d402a0cabso9832479e0c.2
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386193; x=1777990993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wf6P+dIy3swdOfFQ6eaG3P+EchYwJG+lt6mzyhgaNE=;
        b=YpZBUvZ9cxizlqEsW0Jimm4pXwc7NExsyh0AK8+jh+SEPVdmgK7B6FvjFdyZY5lfuz
         H5usgo9lHyVjUtFRk5suGHJ1y5N7q/M2gC+7dehwSzGDAUvNHPgJLBf6Qs7WCtxyj6sm
         jqP8MccmbOcgxD3NoAnzSV3QsT2fUJPnkSnI1ea836DxnoMpQerS9ACRWSdbCZIWRxUg
         qUl5sfU0p9y/cueeL3KLtmK9sPJgMG72j+ke/ZwO3ez1sopUQwX4FvpEe4uRIf+DS8yC
         mk7SUFoTSLZ/6ZdbaHz7mf9go++S9t08uaeLp+ykqJcrG8pDXFqSy1odJFqZX6NkGtKI
         XPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386193; x=1777990993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2wf6P+dIy3swdOfFQ6eaG3P+EchYwJG+lt6mzyhgaNE=;
        b=PX9KfOjckvLk2R0CR/uU7WUt0l1MSCAFEXZQKLuml4kvPBCCf+4M9RN+LdnBzFQ4BB
         11a0A3Ly+RDmo+FNcy4UEnYGt7PPfQUwmXP0ELE+oY9w+kUuPCFSVzWMh4TXNPw1Iv4g
         nLnVdkuWe2ekD7GcgbMT0PZGfZfTtkv2yJ6u4dQa9S6y0AyjXXXmxDYxxcJ2OA8n8/nL
         2Msn5PPLA1AitTtipoxClheRKi6YJ1ncB/a2qw7lMn/l7Vz7C1Ztg/sL3/xEybLQT7eI
         UMkr2x3Zyo+7PM77tasm1AcC0fzubY55ZYZiQehT4S6BHW4wPpuxfsEmZi4dOQ/BxbfQ
         InlA==
X-Forwarded-Encrypted: i=1; AFNElJ9kwn6a0IYxQwrkSA312pt+YCYwNZ9BA3Zt5REptW6xwGLyAcGPWrHv4cybeEfLLkJ1zhYJ7ThbdGf7aw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ZrLgGvhs0dA13Ys8Re5yrd0BwNDElPI7VVqeHVos/0azdgto
	SjIXRkO0g4Pn/VnkUGqgFwnBuxWxXKE9lrMv4jMKJaQTGtQDHOac4APTU5xWLYPMPAFrW6yHFp7
	Gv57pgHxv2354n9KY9Tow8q107MeodS+6fa/jRIzfMSiu7mbDqTWEqR/gpLItJQoS4Q==
X-Gm-Gg: AeBDietrbm46eBmUvsAa4nw9ROLiREC9/6MYpt/ysHHPDKeIvCdVPD3sysxg1uCC7ef
	nS1Lz02IckDf4Sa2hQ6behEZxYQsvgUhSVJGKbl7btzeyPefXC7O6caqc+pAVVVuZ1E8avlkdSp
	Iugbbgi+edIIc+szS+Wdzhq1WUpg4NgO5bsf+4rCpgZxf691k1bpJ5Q1xkAEdP542TqRcWBoH5f
	QoDr294HOf7fG8hRbJL5MJSN37j9WVGK6b3amY5kVntyyLbIIEfX7ozeM2JOlT0bYlhm0LBSRsQ
	8x51igK/KNBsbCrLGIYijh6mXBadsAC+0md/UyNEK8wJuywUdblPPn+E+Lt8HdkXcsVVsHFBEwy
	K7jledb3GTUf4ju6wiw/sxTsM2aM8KhamDKVPeRyLFWp6NXGdzgfJm3Y8QILJBnqQ6/h4LH0eT6
	zrEjGpo4GFwbbhjGH4QTlRc0n3Mf0=
X-Received: by 2002:a05:6122:490b:b0:56f:694e:1f10 with SMTP id 71dfb90a1353d-573a55825a5mr1339713e0c.5.1777386193322;
        Tue, 28 Apr 2026 07:23:13 -0700 (PDT)
X-Received: by 2002:a05:6122:490b:b0:56f:694e:1f10 with SMTP id 71dfb90a1353d-573a55825a5mr1339667e0c.5.1777386192845;
        Tue, 28 Apr 2026 07:23:12 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:12 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:06 +0200
Subject: [PATCH 1/9] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-1-6ad23e75190a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=a/0AM0SF c=1 sm=1 tr=0 ts=69f0c2d1 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=hFPe-bIbDLvfECHHD4sA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: T3N1i8-RTEz9RMeS81YNo5kApQ5_X2_2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX60x2DMtW6q2Y
 U0mD1QzlNXXmjSn6r8HUZE8zHsB8+dRVgKXk8zpgRLfdO4txIU6JWnU46wsoqcVYwvIJcoF2QHt
 bIFACo7fUZ2omrA/puTT3X50ZJkVU/ZPIEk+sDZQg9xmnqB3gODXZqS5JR70IyIc5VLHFSIy7Cw
 eCPk7GJ/XYwCLRTzJq9cD6d1mVUt3g3A5XsWbR4Wupaj5+xDC+ZEr34lYeZRO7fYf8NyHMfs8o7
 c27ckUUPzTHUkl8Xj91YWPlFjqZ2GZrC6bcxkFdLQx675zC7iI2/D5eOlIvHt6ehzwdZCB3BkEL
 +1pl4CgrLbmvRKhH1yh3+SMZ4avuyzasfESZFIEmmEMuS/D9Il8MYqVGpb17taFlf+39IqhZC4o
 y55LEdWSP9VG0gTVW04Lij62ASNbb54woojTAsts4wNDUtpLMKUZySSl57E0ZJVvppmAmQNaz7J
 UaJs4h5NTD5AAPVY84A==
X-Proofpoint-GUID: T3N1i8-RTEz9RMeS81YNo5kApQ5_X2_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/mmc-card.yaml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..e01fc82ab8520a31196475b18acb5e839e1bf71f 100644
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
@@ -86,6 +89,23 @@ examples:
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
+                        reg = <0x4400 0x6>;
+                    };
+
+                    bd-addr@5400 {
+                        reg = <0x5400 0x6>;
+                    };
+                };
+            };
         };
     };
 

-- 
2.34.1

