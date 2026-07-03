Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE03D967D
	for <linux-block@vger.kernel.org>; Fri,  3 Jul 2026 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086328; cv=none; b=bQP718Kyw8TFIfY1y1Nww8VN2Amgs5db+xPlojpQoBSdZzZldIKwS18p7XnApwcvLSRq4hAiEoElPKRLAsKoKnxPYRZgn77XQIZasU+dfXELIhHKv9gDM6R2aPuHVkrvG8ZrrcfGBG++3D9BXOYkjYJ+Ei1fNkDhvlkFqI7Nf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086328; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Khfr8oTS3c2klDKgvHbTAyNArbpE6ijoPjLvGW6knka8Tj7rjbkt9GCQl0Fb0OkQAWv7o9EVgJ/aov/GXQr/wxNSNBZ7RpntKv7YeE8vEV18rfOHQUif78R79QwCMrtW37B0D8utDPIshhQNNkEIpmpo7RAs4X+VEEiKonVfMHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HamYwJft; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iIE09BZk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HamYwJft";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iIE09BZk"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663D16DE053898
	for <linux-block@vger.kernel.org>; Fri, 3 Jul 2026 13:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=HamYwJftlF2U+0WQ
	8ZeaDZbNjDDayS3W7TsIqcAxTETXucyC0z4G1o4d/+ETQoYa39mqeUblscuz+VgR
	jV636xWSmpXDuBzmtz9fqW9RN4/gtV260m05QH7R9RGwWPQfHI+oTq9QGyxm0cgY
	LC082MkM1T+aqMGRjJcPF9fUgQRAqFopLYt3/ItSHHp0N6R+Jvp7d7H0mhds/5pZ
	dVLN/Kte205KojmTDX/q7hKwfEO9JR+7k8rJWbq7km3eB9DUIF6jMHouqfWuCBOv
	GPHfGAXTrZBlTlZLeWp5RHSaWg8JpTkgjaPniRYdTUQyd/FkcvETtxlI+R8DbV9w
	vigc9Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkg4mw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 13:45:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e820609d9so40475485a.2
        for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086324; x=1783691124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=iIE09BZk+iJKB3zE/G/Sn88RndPO5kbqb8jjrWdXA6pBqNt7Gr9mAu5rN/83PeFj/M
         4wan/dj8vzC8pkpeV8M8NC/g1a9ixdiOSorTUat08w9Kb9npHVjqamHmpZaLUHX643nj
         E/9tf9taWm1Klg7C04Dnfo3xv0MB4+t/lz4VLoK25W1Rnzf/sVr5yMsT3sFP2XlVdqfk
         3hJpMeU9dNV0bF76BPlTqqW+G17HHln4E4ZvkqqW8AkdOjECZ57sFae+UJzHfzIwOfOd
         ZQRpYL08c387iGY01zlnGZO793S7k7+cxIzHj7WU72LAjJUo4OBEndRYNxMvcfxC9AjA
         QhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086324; x=1783691124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=sc1UV7yHOxXsU+vrlaZkwIxeu5vE3OrnLA9tGu49Io4OHMxSyCBGQnDy4vtNsCNT6e
         SOqoyAKxeS696hccxlPpeRr3Km1s3JAKkfMgH1+LnaR8Ig0sb8MtyFs+fGgehGIiNcBq
         AOVk9OoFB6qUgXz0Mz3FZRtyHyvyswSl82L+Lccwa65a4mDdTngjrCBT8Wr782qV/YrI
         XdiAQ2sHT4I/71EIsTTSfJP3YszcSsVneD3dbs991/Zt84PtxX0VaqdUtmE9hgowXogj
         hnwbBEWFrpyAjwrSVptsHlIf1LXjIQN33mP60FZaThF+o2sBMQJpnc/0E/Bj5eQosvgq
         3niQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ldhjcSEoBLs18K8dwlhd1cj/Bxxu7HTlikEfpxnfFgwz4ZIq6zfOQiDCdBwx0PIBQMJB6T7tKWwqHEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJIHISvAJ19moYb93PgzTf/DYXWyubxyLmM7m20/Kd0Mz3JxH
	Chv9adua1cYT/Fj+YWHtH+Mf+75ovTBMU81GH0m8dYMdvsCr4H07+yPmYPLniwfLH5Fbq7HVmu6
	O/Jz/3u3HCklRE6EQ7CojG2hK6UDL7GWXqofYk9SD8ogcKkFlzWd3hq61Q4ZLXLYxrA==
X-Gm-Gg: AfdE7cmvO+NKP9HmNSZL3h1eG9eUOtuMvCgET3Y3e1x/GoviLd500MCko2+4L/Cndk1
	p903KUxoa5El5pHGmE92Myzw6UcDMA2HpL67BedvV+JKP+vGW2GZGgbe4YnfTLxVM882IDrvwll
	a9zpRBGA1/5L16ObREq3EKKMPle2r2aE/LT5fZo4EcGpC3A1k4PPX+CWeq6CRUZZC8sGVokXxMk
	phkU/Vcvz4Yo7CIJZkBTgeE9UNaYi050ODDUfPd6NQeB0MHzKTOiLwkeS4grQ5iI71mrqEHJ/xv
	kOuejX3YBTMlitVsfIgGx9LO8c3XqXPnnUjdjej4W/r8EPsXvwgpbGtxGuLITDMf7U632di83HQ
	KeBirkCPGF48sda2n4JtiP+Zblsz7nvG2SmvLK/u5Yc/7BQh+yLTnOJcbSQiM/UxwRDzSjM+JfB
	AlS/rj62hSCRK6QQAiKitpILPCaBKxKGntIaAVCp05oFovKbae0DGswrMEM/j8KFs=
X-Received: by 2002:a05:620a:2b45:b0:92e:8405:7ae8 with SMTP id af79cd13be357-92e840591damr804127485a.4.1783086323826;
        Fri, 03 Jul 2026 06:45:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2b45:b0:92e:8405:7ae8 with SMTP id af79cd13be357-92e840591damr804120985a.4.1783086323235;
        Fri, 03 Jul 2026 06:45:23 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:22 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:15 +0200
Subject: [PATCH v8 2/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-2-98ae32bfc49a@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX2Zuvxj2B8dNd
 OljMP+uO7WsSEhWq1Xl90cLlq4TOY+X5K9pTu5zIxIVMkqsYPzLRj24rTE43IUfaA3uVEVUyMs1
 RdwkEhdrIR6foequ0xbEqQ8CwcFTD6q6nob1WL/jqK5cQENKUTraJxlzKaAR6/Mvd/576zilBqZ
 8W+PiWxLLMO/BT+Xh7RlMl0NM5RAqX4v2Ix/dejLiCS1WapLFFgMSUfspcnBKdWHPQn5KT/zoaQ
 To9OUCbPDjj2W5L55Bl6WLCz132NO0QFFZqXfal2lRDBsOkGz9HGMo+77FnO8wC3r+OXvnGs0w+
 kbrr+oTU2y2RUugZ3Qqm3fUMwjyqO411RJY1BEDToKI3BBFqD2UCpvGOYmf68XjHfLUHQ9wQiDJ
 LwI5HpnYBpSj8EHEijdLkT9ZLN9oJdx1JafUmeIITUhnziYz8Kn2abkBfF/n9n6cCCj9KIVV32q
 oktFTrg/+fxH5wOy03A==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a47bcf4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Z6GJNazxZhfBvN1tM1GkMLUz3-Q0trbQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXyvoLVIbnx7Iu
 tbafWshhtjSXdlr5KQOCL7bVMkQ3cYe85okKwh4qF+Bji3dH97QKgrtILK4N8vMz8TpXSxLTjUy
 oVT7CxCYU0lt2X4hFEHMr57DL8iwzWg=
X-Proofpoint-GUID: Z6GJNazxZhfBvN1tM1GkMLUz3-Q0trbQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

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

