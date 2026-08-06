Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A5472796
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027139; cv=none; b=HkSUglh9d0DFoGOtFMgKq1IT3IFmaRq4KY4Z9YHBlPi7gd3j04p5dEnwTHP55WDl9w0aJTCETMXusgia2IV+tT6XFepzCDht7n5GFx1q6gNT44gbcTry3PVwRjSHTI9JsqjVHXEyJokMcsPyCW+0MC1sqmwG3supBDvReq1FZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027139; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKcdn+OIRbQT2XioqAZb/mLLQ+uBJNVho9QARp8F161YFqHE2M02q0mNY4ylDq/AI8loHHa1Z05nJ5CF9VPUipOQQxEe+6F7rMydOISzm8gnutD+lu2k9anusj8QhpCZUj3wPaq0MH/49OHoVfZOstbhxC5t5OS4Qdj/p9d0ERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d6ElbH6P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fx2dpWx6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d6ElbH6P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fx2dpWx6"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EYfcg1519342
	for <linux-block@vger.kernel.org>; Thu, 6 Aug 2026 14:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=d6ElbH6PPCz9QX/b
	BLbUMMJyIPdBUt6nC/OUVYRJu70FjQUJAa7LpLyG7zhEwsScwo1NGcXiHmzKgeSg
	DYU8w0xqtmCJIWKYgCXBfDx/xfUTJCdzL1u29j6IC+sObGK/yHh50oe8eSIAOlvk
	976M3BEoKD5MoE4SNLDq7BNxKXvDUfxcaK1YJAd6nzdZwvKiZFSXQ9vzebS9sYel
	KFkMqqoT9+O0OtQNIpNFVm1w692AacBXnc1bZO2Net0oojLqeyRhN74XIV1ZKHFG
	Axe12rUOHhUNYN1nxi/bgL7bUO6lLRce7AcRCt7F/rgvB/jLDwlU3Zyh+00QU14W
	HuUzJg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvv5b018c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 14:38:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1a97644aso24832161cf.2
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027134; x=1786631934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=fx2dpWx6Ffu/uTDPCgJSqlfPHnGG1eN3KFQd6nA+4fyZFOsBVdAgkw83aFZeif3AJ0
         MuJ2oWCTWEQMeofGa9C7v2WQr5wtDON21MiruUOqmoHyx/ITIhiW/XztE3eGtRASRuSZ
         M/FcQyIIYXT1hNuvTbIM3irO+h3CLPqmU6xSbC++9Z8J9yx2Nws8p8k98W+zthfU2WQ+
         BQbFyxY8pOflaKkqn8Pb9Zw9t0+gjsymdO4nslE34xgInuFchglxWMLmxyDe94GxNmB8
         0S16i0SvnEKUfzU2JkEabDIKa/B7eKore6sL3dTQbT261cA3hKCRRSZQlpeEDPoz9yc5
         ge+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027134; x=1786631934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=dUNPxcKr5H7WpPkT3QL979XpqZ7HsG67Ti8GxlikV8+dynypBjOs/sezkKb+XJSMS5
         YBen/yCXJdhbukswDONZ4PcXKX5KnXxPLsKIjdcbfJ5Q9qDB8+sjNJ1/qkgVLY4UrDSq
         ZsHZ0Z8nG1BZmT0v2JHDEyGRQesbu7yecIs9mtXZ73TCRHGo+q4nsMviTaowmdF5XEMQ
         RVI/S71ho7cZmUZx7mHU2XovrIK1iE3ANsh5ElVLbjpTSh9VOTDjwsM0UvV9VZFsBGt1
         uOKchtTi7F4oA9gPc03rYoceuHKwIi6F/b6ir8+H/xJoHxjXwxhouc7BSygQ6prlBO5Z
         +8Dg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6cTPeb9burXEF0iqabXhMDAdK5n5go3Ko7jb3pcxUOCWaigzOnVI6Vmyb2FFJYQXghqftfEEu8AJZ/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHL/Hvd5IyGwQf4j0HfikYsyr43g/19GAI5viKGr+ajX+aLXj
	TzyumFwXhJdI3L1tsyDrqbPk/r36ksOL+uBkzNrQva0AxNpHcpHXXAZFaNXkg87cDtS//aJhFcc
	HqH6aqp7RWmlv+lehpVW+1DegSZscWqRYjDbu9om6M2dx5vj+gHfbV8DvQUiENE2l/g==
X-Gm-Gg: AR+sD13cz3i8DPwUEuYG+J1ZHihGKmXOP8Q6W0tiHA9+yEdIGQpQUIM7FUYV0WR0T29
	qQB2yh7TEP7NY6e7nUyVjtl5w3qS3SGQK2jxepFyFI4MR4xGhca22XzwOxmdwVhd6OWa7yz5JmI
	lDYX8VbRndKjLjhMjhcBimi0KTa5jgGh2uVkPnRX0NzMp+e4oueU1rSmO+SssNueDoj6WlVEg5u
	YB3Gm7sb3WSq+R++2gnVItBD8AvQh5pgKnvYnXXNmeWZ+6AIJv2T5Fszq+UpQj0M+A7G8yX+N0p
	niRcAZdUvpXH9tHa+mOX3VUFdGaNvv4UQyGb+N4g5UWXxezYPzgYcwxEN7wzLAPNy1Ki3Y+PkYi
	r7AMJ42+JzIIHlOAQoJVxsMPGsBcCav8e/Bov08Kq/zQACx7RF7Mtoy7AYtHCoGVI4qaleawEkj
	0b1HChDQLVxmVUcn9PA891lw7pyXjBbFUyz5viU4lm/RV9GCOfRg==
X-Received: by 2002:ac8:5cc3:0:b0:51c:1532:ae93 with SMTP id d75a77b69052e-52ce6146122mr164305401cf.26.1786027134281;
        Thu, 06 Aug 2026 07:38:54 -0700 (PDT)
X-Received: by 2002:ac8:5cc3:0:b0:51c:1532:ae93 with SMTP id d75a77b69052e-52ce6146122mr164304391cf.26.1786027133693;
        Thu, 06 Aug 2026 07:38:53 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:38:52 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:36 +0200
Subject: [PATCH v10 03/10] dt-bindings: bluetooth: qcom: Add NVMEM BD
 address cell
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-3-be598b2a5606@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExMyBTYWx0ZWRfX3Dmw/ZQzf1/6
 BFO/jG4b0Zi4SJTtuhXt8NsF/s8pGaDfmd1lpizXf8BSiQTEfSkhoi6FpyJ9CnK8cGCcMp2sMM+
 LaGsSbc0jYD3XWu1FHV4heUOO7+ROOyZic+9Mz0rJMQUIMsBkhIRl+17Qdp4FDezbTy3xu7uosz
 0KuzdNPYRroozHV0bQpyRR8EzJPk0Jq6fKEXKCKjwQ1NW3xCFtFXUBiN1hWUbfH2umO5rXW7JrP
 GD4ALCyqbgY6cQvSPmxxf19HZB49VOXQNj4oDSY8Yj11qY7uxaOFXKbB3RtynfrVblfNIsSOrby
 CbkiNRENhWyXl/iW1FnxIUkNdOITOP1FZt8yumx9UL6aMkFGZDgsqqAGeveg+L8KrseDyrknThd
 +hMcsMdNNvFiXEmCCVPWHvWNJjMgK4ZzIjRUwqlsJv72TNiVjh7y9w6Ysnx7QlhgNRhlF7sXRLN
 q/8l9BHImofRteLa/pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExMyBTYWx0ZWRfX+D+ycfdo3HpH
 Jwz0oVmjTsmDuUpyMcFS8cGbThMJkYxNa98NI2jdbbd/q7gStA5Rrd2P6sz2XFxSbLZg0PF7e4n
 4gJJVkA/IU+ML6P5XvluROh0l9lrcus=
X-Proofpoint-GUID: meirIoMYA0giSuIssQ1xZmef54vcriQx
X-Authority-Analysis: v=2.4 cv=W4gIkxWk c=1 sm=1 tr=0 ts=6a749c7f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: meirIoMYA0giSuIssQ1xZmef54vcriQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060113

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

