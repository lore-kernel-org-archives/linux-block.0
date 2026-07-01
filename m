Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF0A4B8DE1
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921660; cv=none; b=hyuvbWfTpMJWvLIilqDyUJpe5oBy9o17YGtTLUzmLM7ngJjtmhhG0onmuuuna9ySH6KCQQVyUbbRsjNpT8I1g5hvR0WF7OD1ioeMaDRjiTyQO7PQp6IgCNEpRdsAVvUB0KkYnX6+XMbije9L0dahN/fv4Z+/sSlQngTxgbSEyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921660; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttnls4HLxMJG0fOBcOYGbwDosHNZ11VylQ+Bvv7ZUfngjJK3haMS6F73E9DivifNaqY1gWRkGxe+DoKPNyf0V7/73EZR+pnraQIN2nT4LWO81Yza6eOFSiQqd4mTAnLPKEoKAi9ktAEQrSaSlnb2mh6fxA2Xl0G4RzOC96IPObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NbIMQfWk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CPXHx/yA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NbIMQfWk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CPXHx/yA"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoEPm1570366
	for <linux-block@vger.kernel.org>; Wed, 1 Jul 2026 16:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=NbIMQfWk/M75Jc/m
	JJcsFsiD2oORCimjwwYEEgLE4CCbKa8/jk6TtZTAo2x1Chq82xjvwdmFs4twAiDE
	VmDSeiTYXtYJ39ntpwwchbR4xciMLf94auLLm5dXenL6roE2PUu4b2pcjDlKN9xr
	Tmqt2K6wYY4XM7zkpb8EEBtYVMordmmk8cH//v311NIYAS4Ewqa30tp56XPJEkxp
	NnUVh1GPoJ9JUr24MaNvUObsxb/pYWhBmwiTgocSru7GcYIPCxOqTEcs6tMXN12J
	Yoiz/RgXGsjpYOtHtjdn03/y2bD6I/b9+OrJm8s54ZTFl7pmFxudXQyCt6fIC9on
	tk9Efg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510aheeg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 16:00:52 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-495f68a7973so751282b6e.2
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921652; x=1783526452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=CPXHx/yA9SWZf/msCSHBnGg5vUirWSVlKMjclcdpQbz9wzcdoQZOJ3TRw+viG0Om1Q
         BYMARaWiEbNMkE/FqE27Iqny7dxlw5jiul5y9U83SnjXSFKQl5Zc3u33kb/K1k1+rkGb
         rL0yYGcZ9dBOpCcnMF3hf3fo5cT6TNKpHqnX9ByRFvJBZxbM9H6+iaMhOywGzV8axqLF
         BrvH+CTr1s2rXcnhJYRAR6Td0aoQe2zH/L+TTvkUKtZJQEoyTRDx8+EGHA2Su7O8uL30
         9GWeiHhqDGd43JNsdv+twEE87Ad0DuZFWSt+JlbK5b5lqGtYCGq6X07izwZFLY0BnNoT
         Z/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921652; x=1783526452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=ZZDBWCHL6dFL0RkgoeU55AXtT/btC3fCdv1gWIJ3rya5CkWsv0NDsvlEInPJluychP
         LG0Ka2+kiS1H1xRWmoEv2wkH1qyRePOGsZhNA7j0rZtkIT9sv01V9ns8Ee+Br47gCuut
         h9bP73MhoDLAOGLp8RYklWzMJdRnD3d10TP8NCQCyef3gP00qlx3Muq6E5Ud5o5dJPdQ
         U0XYiE5Kdlz6BypWvuYOZPQHgZu+RsDMntwRPPQJy22yM2lU1yIEP3ASM1s3cuMmhy6q
         ml6oywIau+40FJ1ooB020b6WbKzfFlM4ysbyuUwm7IYSFHegDMzgEWzXC7dvFXWlHaOh
         nUfA==
X-Forwarded-Encrypted: i=1; AFNElJ/VYT/Y/IigussTRWeIw/vewAeUjDd2qOC+XuoMi32XKw04cXQU5vGitu2mD4NIITmMuT7bU8RSPu6+8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJV0c950yuFUpzYtr8aqVt4kgOaKmfl0+UCFCxXaMMWxLySJL
	s2KTVGApHd0Tt+Nzyre0C4qZ9Jk+/gL+WgvXq0/DhhhVds9G/oTUuVSVDKekZLVrd2a1qyZLlcd
	7cGdvQbdvqy92YBPMh1pTGaO4EZepAvaaPd9ujZNKz/x029NCxfvpkwLnuGkyCCASfqpwzqEP73
	dYkag=
X-Gm-Gg: AfdE7cld6eujWbYI+2lFGH6qPly1dM9dXXnRGC82J8WLSiJD7djG4iy70AtlvVPJwEI
	1wPRH8o47D+dkHx2DrMtC1c25guvBRv6aObSemXoX19kpkcJk9IaNAQZnE5m61WoNAKEVPqZ+Bb
	K6guDsygLF1v/DFOWX+x5M3m/tTiSoszfP/qkgCJKbviee7MDi9r63pvvu1UOzazZ3iEFPENFpR
	3WJkuov3RLz2XXciWKaTp1pdbETyg7giqbBaIFJ6xLrXktM8E9Qi44L4gY5SOkuTb+Bt2x1KHlK
	jRF4G97EZlQ/YtheVzYw39AVXmR9pM7IjvxLyzkVUjT1mOoJO8qX0wgSoIs+UuEGhDkv3tGQy7v
	Bit0+zOzP4emZ9wpMLTKAnZtlj7bihZ1onJcppfdq4n58H/Ku8yngMfg1mY9VzkwjbLecyduCWT
	+LftBV3zD9YVnoMU919QkAhW+YL7PBGJkChV3gvwY2wj88CO/GoNt4qevBmKwFnSk=
X-Received: by 2002:a05:6808:d52:b0:486:8827:66cc with SMTP id 5614622812f47-4960f04fc93mr1353684b6e.40.1782921651673;
        Wed, 01 Jul 2026 09:00:51 -0700 (PDT)
X-Received: by 2002:a05:620a:6f02:b0:915:afa5:725 with SMTP id af79cd13be357-92e78206c88mr299831085a.6.1782921639993;
        Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:27 +0200
Subject: [PATCH v7 3/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-3-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
X-Proofpoint-GUID: L_vXTIvrH9VlPClxcl84LLZ1EQ-EdNU2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX/n7rbg9/tcOW
 zoX/+gzSzIkV1xlQTBqR9KlnXog/DaIn7lvosTKh1NGukzaHDFtjhA6JRdVW65xAN+m1/HSCYND
 zYbf0gr23cyszTdi0n0Hv1x1uWLRee3xegDqrer0g+5MXRYjNhN76mGO8kyWLmaNqREzTm+mXQG
 7QPslyyqih9WPJT5u69KMdFmN8ViOEralVad/LebEyIwiTSTtJwnv1MWswugAo2JOp6oVysZvWr
 D63UeIjNKHKkOonr2ljVd6cddkc3397uXcqufyRQq516HK6L0oMtUde0UIhZ/JGEnrqRBq9EkRI
 lvHW8osCqgiopyY4Z0lQIWIWQeGZJvV3OK+czbfme7Dyep+nHe5ZwbORvGN1me8b6xIUhDyRfZd
 HfDre1OatUqEashxXt2qLRggteb5TRiic/ugi6XatD+kjq+JEkShapMDxuIp1God3q86Khwx/bt
 SiYizK+bymLuBsYPDiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX2dvAQlN8LaET
 IAy3E5FLHh83QWf+/cTV/emR+8loVmdb2byryK70X174GIw1u/6S06avuNgLAPlB5Gg7ZWKB2+J
 eiy0n303tmz09lzPJIxVeT59a990ocY=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a4539b4 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: L_vXTIvrH9VlPClxcl84LLZ1EQ-EdNU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

