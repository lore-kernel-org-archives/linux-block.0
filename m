Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73C47276C
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027132; cv=none; b=bGVWHpGPBIe1wFUs4QUWCy6NwuF43cHmEUKt3gaW+2kUYHF7GVfGam5rBoH2eD4pQved/9zjE02G46Eu6D+WaPYnp/ijemydPZBfP/Eqntinds2nNoXOdFqpGyMj589Sxj+QAcQBm/KlY2GXuZzzEJK1+CVr13kGzLx7B6XQRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027132; c=relaxed/simple;
	bh=036KrKutK2s+JBYYvV0r0UOnKyUPsfS9tqtbriE+abA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+iyP1EPIsd7HNltcP5qbnEvP/EsfTnAHRuM6byZGkLp/tiwpJpgMP9dGkltDyxfoWDM39qvgGSQzXjCiha9aEyI7bnHVXmgqy88Rvr70VdyITeAvoLr948bzo6IpuXocTYLst2PLz+tjmVnNqpbpHQr4rHqesdY8W8ClqQjoek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mbTS1Pxi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gNqBuYBb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mbTS1Pxi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gNqBuYBb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769o1sQ1310096
	for <linux-block@vger.kernel.org>; Thu, 6 Aug 2026 14:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JU8Uh1sAxaXOEPqhB1RXVJGiUv22Sc7mcVDSZZfElb8=; b=mbTS1Pxi0LuRvOGw
	B4YG69hlkx2gjIGqX/GNaXgfcg+nm47kht9/dZYqeBkXlDDaAW6bJEN5TA5hBV8s
	nhNLGDafbeVWioOj/2WsdA/el7v8zGDUK5GUdOvX4nIYkH+CA8bHwLb3WTZc/zTI
	dGKKYl/Dc3h8vwG6+PoCF4QMhl+JARatBo0sYovrfLLj0j6DFZoXPk4ockY7D/SV
	4k6bFus/opI4VlNi7B4cLFBfuG5qOF7SWgnIN7XBjt7fPJxnUO0bfKkimah1ATzY
	pncyWycc92RH3Y/jda/2JdsmuZvjMs46wTx6/q5hNPQXAJjLw47d4ddIfuPEE1yy
	IPfDMw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvp729vde-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 14:38:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d7886cdso38005461cf.1
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027129; x=1786631929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JU8Uh1sAxaXOEPqhB1RXVJGiUv22Sc7mcVDSZZfElb8=;
        b=gNqBuYBbTeHAJepoXDO98X80Riai4sgGvlJerSFA+ErWMfIL/6x29VgVhgsiqNwBcl
         5xKSTaebUPDWhvHI1D6AUy+3Wu8JRRoi6yhjcsY630paYoRatb9DSUasL8IYvLr6pF6q
         spG6UGrP1WpkRpzq60qaCfnoviL9wKG13R+q3yN2sKFT4l2PxcoNIJ5H6KgyDrzZhc8k
         3fzNWwwpuPaJZpVVEXYAWXgImSt+VPMIidRsfB1KCvmLz8uLPOdhwYGAzHikKqu1PvR6
         IOZ10SDIVPxPdXrZj8bNwi9pAiTb94gxtpa3OiTxtScAm7Z/yM35bKRVjzS52tpnX6Re
         cSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027129; x=1786631929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JU8Uh1sAxaXOEPqhB1RXVJGiUv22Sc7mcVDSZZfElb8=;
        b=ia90xclqMcY6CTXOVMRzpLGe7POfXkWL8tlK5juDR+yhZiOhEp73mKdAgnkobbIawE
         ZSm+mDgG0vtSIb0ft8NTIW6yJhIneTnftXWrheZaS5UO6ux2m8S+PhyT4YkmQeURmysS
         yYkvkSwyBg9fTzXMEjDPNJJz1TBmDc/XhU2g2h3mlKva216jKMKQUL7sNahev0+IjWR0
         XelTxB+mtm21uZhq+foF2gBjalweRO631XaXOyc2He1e3uiAX+mFzN6tKJoLHv8g714O
         Kbt+DH2CWQiGqpipU6cY2+aeOXqIkURx/XnctktwozwUGCpg4zEiKpdvF3FF+fSLnHOx
         FwHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqlvxh5YfXuDNTDj2IBr4Z2vDWin25U05HDrMDuiK/eMjezozRFnHXPluPCKa/OXyOHSL87ezrRZw+a3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdEg3eiiNpCdq22SlRoDUja6Eearv1hjsr1PyXz9yghZDhZfD8
	lxMngNN4zFLYHvQLlrBRTHIrnnsBG0lHtPb0R7TEibtAHc7SKIh6CrUUBJ6dCIYLc5r1+z1mDx8
	PtHxw4ygnxc5PAXohZeY+SWIdHuzK9eLNZyN3K+5eHzEb6bbJ+XDihcD6j+IKLNRk3A==
X-Gm-Gg: AR+sD13N8LPiHaohoS//3eoOVwe9xHZXFUIb9na6QwPI0WHG6hwZbiLj7Ue7Ozmedy0
	Yq4tXR3ptCwIaEmKFiJuSp1AJKgqkQhPDbfA94VJ2FkUmZbt1gfz5z2vOWS9KO5N2rDa9zgz/ak
	fyfh4EAUSUEf3s+NY1xwxyoBdSFIhQJN0hvi4LG3TPZXejOEVu0kgj4JtAC3oIVw9950A0Hraim
	dWmjm98g6OfKEQWTge17ihQfKXEefEtreOk4+1FIeUrwaxJtIa2rsf8gl3DduZarsrN4TSSVnLV
	4hddpwuIlrJgIfF2LHMFAo/GbcJsqy19Bu0Sj7CTkaccp2UfjzAlqIrMYDSASmzLH68ffCHRbf+
	GPDUpSqbmNx64QK1rP1X43NGklMKDGl6Y3Vu0sqtjTv+EL7D/Q34k62geMVposazeyd0zF59L2W
	IDjteyXhBwBzhquDgBltuUgU9oS1et3tJkuEOCStZDNWKRzYaXQQ==
X-Received: by 2002:a05:622a:22a2:b0:517:2c1e:8b6 with SMTP id d75a77b69052e-52ce61e7a0dmr167527651cf.38.1786027128565;
        Thu, 06 Aug 2026 07:38:48 -0700 (PDT)
X-Received: by 2002:a05:622a:22a2:b0:517:2c1e:8b6 with SMTP id d75a77b69052e-52ce61e7a0dmr167526851cf.38.1786027128119;
        Thu, 06 Aug 2026 07:38:48 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:38:47 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:34 +0200
Subject: [PATCH v10 01/10] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-1-be598b2a5606@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: k0ANTQm3lcpogjZhuv_sZsjrN9zQO5Jt
X-Authority-Analysis: v=2.4 cv=JYCMa0KV c=1 sm=1 tr=0 ts=6a749c79 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VqbvvwzL3cOeFLaalA4A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX8yNBvhCLPzRR
 K+5qsRVLV0AIIQMM8CHQq7NwDlplO4n0+hDs09AxYbAxk2oqcxTgzcm3VgJ0cnSVwM5GDDtqwjO
 sBDIheMoTUQKrlshWF2hp4gyKig74rZm9/uiPMP3H4przb6z/LqjVw2v8ETy9lmwzsaN/i7Cway
 7s8JdOAhk2SdW+HoE+pjD2DWz44AgS3wucsPN7VXUBpaV1yd/VeyhMbOjMGo2AtD7flEl6nK7Ht
 7tRruE3juWYiuyoZv2pqeTRilRHpRKqpFqq0/UqTgWwumfB+fT9sJLQFqfL67x2DFk1DnWT1qA6
 3onmX0z1Qms1vz8QivCFwWoCASLgEr8POm3z/5/75gxKObyDQSontoXmziA3yKQnYmZvbIC6udR
 mQ7kadnXCFmj2hTkGC27dmwKEPGzQfu6SWN+Ngsovm00S8qm31mZ8jc1vLKHLdUtALNYnbQXyyg
 I92bDjN39gEOO0wMYeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX8I/XEkdXPIAn
 JKE0jXBs+4VCklMpqJEK8N8no2hfN9Ssx1XxAHxoX5ccx9VT/oXeY/3dHRHPgRwplQcUzgeFvqn
 WNq0TVJyjS9FTtsd071+cdAzkIbCnbU=
X-Proofpoint-GUID: k0ANTQm3lcpogjZhuv_sZsjrN9zQO5Jt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060114

Allow an eMMC hardware partition node to describe an NVMEM layout so the
partition can be exposed as an NVMEM provider. This lets a partition
(e.g. an eMMC boot partition) store device-specific information such as a
WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
cells.

Accept "fixed-layout" as the partition node compatible, in addition to
"fixed-partitions", so the layout can be described directly on the
partition node.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

