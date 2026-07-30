Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4278A44605B
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427249; cv=none; b=cOjmVIJR3bo3var8L3WJzuN4bPmwh1XTv1DRGtFzAzOmzLL4MgJCdko2chp5iYw8DWI76C88vF02tdF48WNtNYm5VKZ5i6tT6Bw/ss/rTH06vbWhdQFPL+bcgns7K+2bxagdtD+/K8DTKt3Pj/3O7qBEbkp4KPjxtS9Kwi3u3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427249; c=relaxed/simple;
	bh=rFLR77CJJYP1sKLFQ6gl8hLWfcBFJvASp2MjESWcdt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIU0jaEEnxcVuapIGn9RcQyN9tgnE0ncYQyMbdXwsSDTKFMcFjeceAaEO6dLWJ3+jB4Yom3oRu4LzKp8kR95Feyk7dyUOOzt1xa50UgVdY1OXigi8tiLMSs3GwiWbXvt7yxQg8Zi5sFiu89e4LsQ6/0IIZU9Sq8rT/GkfOSwFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dv93W4+k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hq5GYknx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dv93W4+k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hq5GYknx"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQtUH1087809
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=; b=dv93W4+kq74ezcsn
	PoGGxoSG5/baz/ImVuFoETwH6zagLZ5tCc+ntmZUwNhu9mrDn5l/aWdX+3RqR09k
	+qqDCr4MUFHFy2rPZp8wG4vW3hoQDx59OoBFCBpp69kYIrO8bHxv/0uRi1U5GXdv
	Ugw5LFDYcP/hHdAAxrIGONk2mCitPtV6mJXd0G5bL21EoMh6yhU+rkt+32uAL3GO
	Dx7bQgk3HLRrtq7QxCpVI8QG6nyEWp9k4X+OwJ5slZ3KmwCUAiAv1GCKNM0WAkR7
	cis9ttgsPcKrpB3KBWV4g004u3i7whUdRwaCue7TVmdnnOT+NKRa3xMNbpUtrbcO
	bY0fdg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8n38ctd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a8b0a08d2so19749621cf.0
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427246; x=1786032046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=Hq5GYknxpa+8WbZbhELHY424WQqiH3+vUO7yuuKM3WLmFaiokAlCBEMxXaX/EQB2Ev
         u5WVd68noRRoYJqDEbZ2Ga4lJwJDbPQ+mDRRoBzHAiL07aHB9APbUTyboQmfUNhOL110
         B1C5cF5I4Bt0E2uquFgyxvj5y3nvJKU3Z9EMu48l2GunuPKeqDCjjuEtDNgirStQJ7Yf
         G5ArPKpQb4u+S8bmo6SQ/h81ZgpoZR9mN9XkjnzeMQs1Ji13CJan4q+xX8u7b/uXlBza
         W8SvN8SXio/4Un3nqo72OwrDZ49Pg22EBAbkCxjTQZQwGf6dvv37RzJ23xVOGL3OE28e
         K+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427246; x=1786032046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=LDQBIXcRArUHgfmc2REdxcEkjEkXkSgM0HqtezHtv2Vy0oVKqAjyVQAq36VRGsj2hD
         w/kNziiitJT0ByEjyoZDruucztkcIkNVMWBDyxWSWTCiwqBUZegFCnU4ZqSgUX1A23Fz
         7Zehje8A1gUDa85+90vN7HkkR92ZLGJff5fkNlKd/+j4FNkzCOxvqbgQqfa7NleAMEhI
         ocGenz+LwVzgAkum7X7XpAZg6eUrKuIR5J+I0TW+ttydsirjbv4369F9BkSq4I9ayTcr
         3tuYiBe3aKcPjUUNqpmOSCMnUXDLk2FXLXSxgfh+zSWJlXy0SmYcgcB5HnPrtVYR/KVw
         TMIw==
X-Forwarded-Encrypted: i=1; AHgh+Rra/sE29rrowWfuCslZjV1g+aDi3Z3kjwDh9TdL+i/pDPzUSZg1yD/VIMEv/it+yG5b+VG7rAA1byoc6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiC3F/wogAjpEavC3a9Ctrz+Rv4zqISdsZoFERIFdQvpedJl/v
	l2gZrsWGYbDrT9unIXeZc7Ah+zRdHx9Ju2KA3IcJ9R63nxixCfBEG/DMb+XeTeEuvxZqk86/7Up
	fFrn8EYmB+/g1iOrrgGZgUCtfZNf6puV+DT1Zh6+nV37AuElB12223bTexyBW84cXtA==
X-Gm-Gg: AR+sD12zPHQ8kZ01m64Zb70gCgiZjmSMWo8pVI5GlxzEdHzg7uM4rIcnn+Z3u9FWrhi
	LXCrTq9Vi3TEqaM0Hl3XbnrnG+msMu69OAJcbS1xvqPitEZiWZdZPmrlrY3BcCdpvcxh8lS0cTn
	4KbhPi9oicTkUzSWtkwRKBrdF0O9p2MBS8TS1Z9rHsFSJNCNHRjxmQzJZtr6YfWuoUMq3xWvrrn
	gWSn06AQuxytoPPO5HsdT9MWMWZZChxv5vGRD6bf935G5sdXgeR5cDA0ACFt1iGmMlQBl4PGG2k
	nR3W/L0pYGulAh0NMSJuyZM0eFCzPTA014NY5jDLepKhVLsxpa5mU4KAYSJdeUzOIfCgo1ylpQC
	/UnyeRJJaSW3TaliuP76951CkZjGwAAnutL3vvdpJ26MkxKqJI0Jd0BggQF1BrEZBlDaleLTrCY
	fQb5F9S+FgcoL7JdpKcm7L7ELDTcUSfvKydkepmaWFULdFubbTQaWi
X-Received: by 2002:a05:622a:511:b0:527:6d4a:192d with SMTP id d75a77b69052e-52b42cba100mr8220301cf.68.1785427246002;
        Thu, 30 Jul 2026 09:00:46 -0700 (PDT)
X-Received: by 2002:a05:622a:511:b0:527:6d4a:192d with SMTP id d75a77b69052e-52b42cba100mr8218291cf.68.1785427244656;
        Thu, 30 Jul 2026 09:00:44 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:43 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:32 +0200
Subject: [PATCH v9 02/10] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-2-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Ar/eGu9P c=1 sm=1 tr=0 ts=6a6b752e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: gkqXNjTB9UadzcHsFUWne8wVcgtgNYwA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX2OO8+/SLA9br
 FGKw08KnvBoxJnsCRnySnxfNWkEmPCKv5O6JlTBsPmYzT+wI9tRlWKeNzlbtVCS4sojSygc/C4+
 ryITDoqV0WH1419MV0eH1bsTzGVhN5N8smx2R86NDnRh7nvRCeQrenxbMCKVWU7Az9NNPoN9e8J
 Ooa1Oz7i+wRlilWKYYA07wqYDVEuY1TxAcnctih/NVCZoSn9iSm5Naqm4J6ueoh4qgEaOIxHWlx
 Soofb64rLzvgEcp7dNCDDiXI5ARO3ptrVziclWBOVRWrPuZHtibd8SOHxW1vpePpZ/Q5NJhaRyD
 oxOSNAyO5aUjsgAU+nHm5rSFSQI0AITbFDfSyKePj8gWSmiQ6WKMESkKBtUHb4fXwh+98tREcUd
 3nPsbH+GsNbJ2UONpK1xy6sdNduNk6hMynhjsrC4a7oWmVxRgAJqO4eGslXsgNEYcANRfyPfs0O
 6owFCXaa0RvmKp0UbDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX2f06vpGNJ21F
 J/pzr4YG0d7sLvNNnrVapKGGOOodwmMi6cqy9yiUhjUJxY1H1L8BZJdilsC2fxfcI6+d7XMJnl9
 pZbHePynNhtwluWGiO7aMnsNTJSRIg0=
X-Proofpoint-ORIG-GUID: gkqXNjTB9UadzcHsFUWne8wVcgtgNYwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

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

