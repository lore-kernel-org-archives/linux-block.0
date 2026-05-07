Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BCE450910
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167497; cv=none; b=VWHkV8I7jaA+3XzlIk3HtNGQPAMx0fC5QxDSXQYakYQPqUqakoFnMP72ZMI2jQoc9RuN2PsKui0t1naZp68EtQGmkk9WVhVfgt6QYAflCpzpe3gdO1E5Z6n0suLLckEZTZ6BnZd6hc+GSGCMN2PESbckgUwJwEnPnHKc2IuAjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167497; c=relaxed/simple;
	bh=RjAXLDtyeqYajrszhA7+nXfORAO+2o+t2+Lsa/IoOi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGCA8t8XoEmC+iUCvbu7U0R4Int+A9UdeDe/KZBHwotKXIP5n7PY4RP7zbbZn7jU8mausyKpb4dY7H9D3rumyHJRafAme5ACuGKJU62pVM0asDYUWpE0xT4drZZYNdGLdHLAEimnTjs7ELgJO5kmh2Za3qve2fqnGletjzli09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pngJchIU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CRTV/mo3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pngJchIU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CRTV/mo3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647A4PnT879573
	for <linux-block@vger.kernel.org>; Thu, 7 May 2026 15:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=; b=pngJchIUuTR6hnjQ
	lUECzDHVo3pz1dlhpiqmaq1DuAFQv80gbFnsc430vvYvth4mo1bwdyR6UWKw5WdL
	WOpcq2EHSqx0x7SuRWqWe2LCyY625A/6sKNH2CPBz1+ERlw6lSn9VmVhjg3m2AjE
	9xjqaSAc6WqXXEOq/Srh54PIvF9/IBE1T0VyqUIqyRFa90B/3Dgo/n+591Morvba
	unefJ2L0hLpbQtFvm9AZTpw+nb43cU0FWeITrCo5GCw5BvFhhlt8ia+b3JuFJtgM
	lcihyLA5QdlvrdltBs6JtiQmmkeQ7kGuSsh/wQ29S1Y3j4W5t0tX7JFr9FIvJpJx
	E+BCeQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq2fvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 07 May 2026 15:24:53 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56fab6d9242so2266882e0c.0
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167492; x=1778772292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=CRTV/mo3NE9KvXaj5tBP1qjtfldSrl9mDiZ3TPbOJ6Q+kfXCPSEe9PLb5PjUI7soL0
         WMIimb1Z+nfH79b2MOGlYiQdcRoL1kUHJZhzlVpDSVMhOZ9bqIWg4E78NqjEpJsiRjNu
         R4SRwtrWbwJzcf8wFyPPYTmLxCcUIrYOb9VVQyX+kC370bZzqrmhMpLUODoWL9pevPnj
         riGex3G5Vabf1DqNTwYxRHtLERDXl0F6HazZduX+k5hvi7vdwHwJvIXoMiL+NSJdeXG0
         pAibKaDw5Wrdd/3bd6C4d6IcwVnX+fExVFuWr5guECHzjOzkLQO2rshNnxI2CgZ98Lsl
         yS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167492; x=1778772292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=j0xksZ9yGjTkqlQ1TObMuSE6XwEGoPYvUedQj5HqSjkriLDf9hH7OdBdCKdMAyL+0+
         WvdATKyU5104xwnecxDqnCZBBvXYc7bQl9SVDFzEbEXcB+ys2PvHvjV9tI38ui5xblcd
         vV0r60gcihyvAGYSEwHJXCjwTlpN+jS5IkfBd9hN1BawWi7coimWRQNJtSGPyNwxBR2z
         mJLA1CTrs3gdiWvybF3MzGHldrN3g3kuezusI/qjkS53mxGq5A6Gk1titbZkjpM1XyYs
         me5XzNVyR44NU2PviUHZiOpr5nK2PKDEM69oXH91eyXTQD+1peZxngIdr9DNr3DTCMNi
         5r8A==
X-Forwarded-Encrypted: i=1; AFNElJ/R1RmGyWK7bAGRbMBk0AE3afceuEP69yt0gFerjhHPtplxPB68+gkwCZo4Ug4KnPtTq6sYFZ+MM1EEhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+dH0z8vTDwfYfQ4IfCH/ANCO/maDcauhSKPAA9pZhWXZ3iB+
	gHYA7icRNfEjvR9LtkmKo+PtnOo5RThPQTzvqLUYfhnsrvCktHSz6b+VPL4nxAr4SDiMLvLkXUC
	EYRd0B4QhGA37O8CRxs8rlMk8Hk2rmLyZew4xu2AlAI1k9JaMn5FbsKzae/K/KbucRQ==
X-Gm-Gg: AeBDiesSzh4+sgZp38W2eo7ADXyyqXQlEzkKyGr0l4QqSZePfM44qeP75pEh322qKch
	3OOKOC0bCKrU5EQ+PPK0Xw3hCe81bcvNYCvLeBSwagOGZR3s8DXgdRUuMfLlimlsxmS+DisjDhV
	Z3kdObelAcWDR48f9LhO3n84mIVGNdoWKMV0gW1kab0L8TWOY3EoCWa8Hlb4tdpVS8aiO9+gMDf
	a6X7pRC+ST/h9Jb+PJmdxmRQunwtFV62xJ6yA8WAb7OOuqGMCjr7f6Aoq5RIhn9LbjCi1Wv2/iP
	u8ozeCW01EvhaiJypxQbRKrIifVOidV/auxXmgNbyE27pHa220P9XH3hGWmWkXRF3tW/c5WgIJz
	cDWdIcNAyvRI9TeInEKgQ/qpLA761fPpTHL4O6D5AcvGG+x82H2dSG0qSULeEgL+D5wqCivDA9k
	wvzCRrCERK3su4DE7bZrxOtMHlO80=
X-Received: by 2002:a05:6122:da3:b0:56f:b0bd:2276 with SMTP id 71dfb90a1353d-575591f7b22mr5439000e0c.0.1778167492590;
        Thu, 07 May 2026 08:24:52 -0700 (PDT)
X-Received: by 2002:a05:6122:da3:b0:56f:b0bd:2276 with SMTP id 71dfb90a1353d-575591f7b22mr5438965e0c.0.1778167492169;
        Thu, 07 May 2026 08:24:52 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:51 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:38 +0200
Subject: [PATCH v2 3/8] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-3-bf17edd5134e@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fcaec5 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: k0BrFNGnaaBOtYbYYVTjh3P5cBSiGR9E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX+jg/cmDfaOFu
 0HMcFrXn0gPE9ZP3HhBzI4YOwhLCl8o4QJNsrUGDi8CgLeIcMXRywq2NFTEGWixYbxW8MuTlQeV
 DqAbxTSFUlBo+oHkJoT/0USR+MXBAx9pD7mm13wV/MXmaWfRJHPq9iVHEG39bi165am9DgqSDmy
 zCtoXtsMgqD7iUO09GFGlmNi/PQ0MDzs92HITs3sHhxhdrZzKumaJ1WbK+8GxVhpYgvlm8k5N4h
 h08UbVX6tD5ZbIBdwG4VTYsWXozn3n2aoZC/cnE1ak/I//PXmOd71cP9kV0AFpUokqxgSCHnLhQ
 dqu9aM42qKlMVi/SNbVs/iiv2kwiogwwgQY0ps9KRbb3PuBNcBLmShJE8Ja0gcFiFEiK4+DY7vi
 EVg4cTFU0zfaPhOKHvX+QU/EIVJw6kFtPVrK/IVEGJQnrgxcbUkREhI/tGR7GsSm0sx8D7Newpn
 Jm+uOtoC1hThbHVo2mA==
X-Proofpoint-GUID: k0BrFNGnaaBOtYbYYVTjh3P5cBSiGR9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070154

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1

