Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D2492529
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921646; cv=none; b=GVJ6PYiYyp7xypWPgWU+6geuRYsF0HfLQAIU/iPcK77q1bSl74lWY0Ja4qv8VIKVl5TvIQYUz68x9j92G3rO53MyKw/dg9unMlMZsmzkY+5PcXnlZKtHWzfRZJ+RwZqDUUxgTLpEDiaugP3wICAqD2Vy0r2HRnFGLpF2RPFPMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921646; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4KZ/37WPedQw6NMo9jwQzX9w+mJw+Zaf4uJ9qLqb7ZdlSSnhQraXtl0rOhNLxq/PzaozI4OySuWEG3v6qf9+ropTwO/CsCllRGwurjYmba6jIxaVSMfwSgxk9IyXYPOhvNlYMItdcQCngRD7hGD5C95fCiPhCqgAvEiBsm7Xyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRY1uaTe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=alhe9P4Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HRY1uaTe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="alhe9P4Q"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoApC1546093
	for <linux-block@vger.kernel.org>; Wed, 1 Jul 2026 16:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=HRY1uaTeGIIRXKEL
	6wsaDKZf2cVplnvu8A7vouedWY/oJZ9OBdObNQEd5NXv59+E12gXEZG2Pue3jodZ
	Bf9nuB74OOOyxq3OY8Jnt8//r1cOb5bzbB87nvHHzfO+zPeP+gIGxBWsXvnSGkOB
	2sC5Leun+VnKFM05qXn0uwb/uc/49eaUxgwfH6B6lFtaXTBwCCWPZQsULNVLy1It
	7+iLF/bWx4bxIcjYIzCL94f3uW4Vsgk9mMqVs2JtjJHf9HuhdLux2WDTPsfCyZ6u
	1cNFycmRWxPCwad87+4Sxcdt48EMG54PciKP0BCWCVCgOYX4Zt3uVLYeRRwTEMPg
	qjISzQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqshjx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 16:00:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e663c29f2so101962485a.0
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921638; x=1783526438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=alhe9P4Q4tCe33hu4R2/Ad33TZpZRpsVNsQGI2bv1xnNdGeXADKd3cJ/KvgldAUm4l
         oJMZXqWy62vYZVdGBLe0MZaQ2lqWclVX1EVZl8v41Fs9EugRJ8MGWFc8XYDiLkAAuxZR
         2VMPPfxA3uNYl59ghAnvfa2Cc3Cd9aoBvLWEpc9aEus2IL0upwJqKmVxlp++1xJ2hSlN
         urSvESYa4sCsHkokJDzsY2JM37UV3EPwhP3hHbC7keWibOlcXFpLfGWjMbKp+ddCUB7e
         mlkN7LvzPCmlGWHqCCfAyoxCE5IPUlzw8sU2DwOcihGwbAMPaNX3xBPx+r09CvrLV7R0
         Eqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921638; x=1783526438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=dBlW3p/sxWOzVIYCt6ULGBjNefqw2nUVkK0Clt4i8Xw/XytkmrDBKlaxoUlxu9Blq3
         ioCK4TgN6vUtY/cbwObvS5xX0ESRIXYTmDiaOFJI6iIyBcoNp7UYR9qMtl4L/opwVErZ
         d18FUa3hkklUdD9xxXaV087rANfkG9fQzOzJqYs2SyGd+QXmcGJS+qbRCpQXUYzYfdme
         rcXmOPxIe3MWZftVpqUTLslbZ1oOqA1bYlzFPEyab8BLfs2SH1jP/xp2IUZghDcjMeGd
         ObYdhmyAUybcuiOycgn4Edd7X+eYQfH/hj7R36/1a0zdWUH+eg99O3f7snHb8ldGrei6
         CxmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9X5Fx/65U03mx+LH91JXnK2pDCnkbSZBTsEd1OKEmofOzwX0Usu24uAej5cnZAqc8xrGONK3uduDLz9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Zc9QKh5UtEmJVLWapXbujRXcVltT+pP68xHhXTjs02LeT8rO
	ibPgd5jS6mt1NQevCWNlN8enqBiko5Gqp9XRxtglAj4hrFGAf/IBJcTqRwM/5nbJ/PBNRJX8ZLY
	xq/r5diL2pxA6zGxu46ngt5kP5js2SdFkWGkw3HwlWwXpovKoAN6Qse/o5Y/sScaVHA==
X-Gm-Gg: AfdE7cmkIt720i2J4nUIHoZWt8PeAWh0pE+O/DvXQSzu5xhqA4BurH4LM+UwS0dOJQz
	TO0s4S7AYiLIAwawAGqENRNmGBUnsqviJ3rfqbvHMWVec04KBCy9iz8dKhIu76vriSYw2V9kVLH
	UOGJ3hk3U2MWLJm0YayhVFQxdhkeW41kCjFxHjFg9HrRlCYzB01SDgJNrWByAbA/Bnn+JaBpN9q
	reu99HnW5qiSo9ZtwmSbSs6N/87o4EU7x9LD5HbGrZ0rHfp3a4RHzKshkp4IrRy6puTyZ1kbJaD
	wZA2G38nNYwn9h1r8Um7QlRfOfxL2XE9EzFjlq21Ke8pcBJbp5FU4pIcVCC8GolrjH906EpoeCP
	bbq0pBRu0iGyISr8K2x/DmP842FjHNfGLrc8bnt7/3/wSh5oAY7y8vUhhen6bcunTIVIyImUjAo
	MBfTtmD8GGDwBhSxpIFqAnkPHOL4sdkQm0HDt3mINwFeRRSNGoo8Nvfb7fqwuQlhU=
X-Received: by 2002:a05:620a:4096:b0:915:6ce1:3576 with SMTP id af79cd13be357-92e697c6671mr914772585a.20.1782921638174;
        Wed, 01 Jul 2026 09:00:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4096:b0:915:6ce1:3576 with SMTP id af79cd13be357-92e697c6671mr914758385a.20.1782921637397;
        Wed, 01 Jul 2026 09:00:37 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:36 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:26 +0200
Subject: [PATCH v7 2/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-2-3fe8205ef0a8@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: KNiGjZZhUkq-IMalud6WEiyO5rJHBYZ2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXwrNXL3LUievi
 tKgc2YA74Tp18eEX/N1Q72SzczxSTzUmm8O+D9ilZjE4b/nOtg4NIiYFzErDcM8UA8ipvYE0FuV
 8Coys+P2q6zmbFrU5Yqbh/PIGGJmXyI=
X-Proofpoint-ORIG-GUID: KNiGjZZhUkq-IMalud6WEiyO5rJHBYZ2
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a4539a7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX0I31UIsDpaux
 gcwiKiCvKaBNquXY3SRaUk+5MypS13ktBPwx/bWRUACNgH5YfBG5a0zTKXQLiddD9pHPgqCC2Bj
 lh3cU2qTf+czl/EA0l3yJLNZoaZ+l9UA2oUmaAQRE+Rv8IHYuvqObTXajl1ryolrIvRO0q/Pp6H
 jViCpTvVe/W0Juwb5lCukdwXv5R9PjESeIwTKyjaPC395f2s6NTNTV6TDCXz/NmEBhr98YWjTVy
 s+9tSk1OojnreBc69Z04nxUTDm/UnCJBLujE7HDMCLuG3RRn1u6ShigC1FS1mSoSv0vkqw4lUpz
 /Kilkx5ArsQgk5Hn4SxnIVNNxTjEzS6HNO06GmUZSR5aTbl0iSQZVPxA3JrnXrCu0lCBx5PxunK
 ZyqQ9OJlShptJWy8SyGizQMgDVeSN9ARazu9iHMizeAHWYu5gLpG0uObuGoIzJ/+BefNZmYlpeH
 3YAsRV3LyfvrTxin2xA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

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
index c21d66c7cd558ab792524be9afec8b79272d1c87..878c5d833a9cb073520c256c1b72d0f1489e7f4a 100644
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

