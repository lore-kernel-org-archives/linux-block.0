Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E223DA7DC
	for <linux-block@vger.kernel.org>; Fri,  3 Jul 2026 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086342; cv=none; b=gw1qF8K8idg95RH5LBfCQPSGTnmxM9z/EZt6JWErpROLFjomxjUnFbsHJPK/Wlud2AA4qQm9Qd6P02BO52Rk/R3cWwCTXSNPnRvflKHM8PiQPmJy1kw/51/SfJKIbjRuToVT19lYSQK6ShaHSvlmp+DogLcaP7WNwNrGugkZEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086342; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dmNUzNO0p5PSzvURgDUQSLGd/obRbkz9sgVmVc/+QcwTMaAvE3cZvMCfFDNTh01fSzHp0T2Dwtz6aD1yE/uGSfeQlqs6oG2FS3ybbHEf4jdSdG0S6ZOR5MGKSfPq4kdEZPn2ntmSYafWKokNwz/S3f/zMOwwYqbssvUPeY0GmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BjEwQ7KX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iawHCJJe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BjEwQ7KX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iawHCJJe"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BZFd93135222
	for <linux-block@vger.kernel.org>; Fri, 3 Jul 2026 13:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=BjEwQ7KXV91y6w5K
	VaQIfEuSxIf16eWd1haiwUtC/PYzRYiVxl1j5dXjqMoCiigcwbu0X+8vL/TExdy4
	ZgaYvX3s/VjRfFmnLJ2HAxVpoT2At/uvdsGENm8WOfnOSljYzXiflbVP57mea2FX
	KnQYVBSaRc+RTVmHc1S5LvgQFioMJfP0+CNEuyaeFSePaW2SyzXcOQyNvMVcGtyj
	FwwWkbyB25zHbrgMA13dzHUKe6tPQz9z0YNucycudgyRDEQ2qG4QyzaE1Utrt5uS
	gNyLrQaSn/7xmzjyveth3rLNCkQC+OEimnMLDr3jt7aY1uQdm/4UCnx8933DfJ1O
	dXR6hw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjb49-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 13:45:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e8004d60eso92922885a.1
        for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086338; x=1783691138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=iawHCJJeg2BCbpl80by+FrpM24LgUYVTu/dLt/Yodeog6tmbVLcmjYRVGpngaIgvbE
         48sJ46C5TKWE7yMPKmR9goCyaoakbc9KqB9F5I20yhyLfygCJDnU9mAV1YcAasG0PGHD
         wxNVb16EFlvkuldW8e+qW24SZ35922SzVVtGRNfQufmWcxQ+mTU41jBKVVO0gXKX01IG
         URelzTn8RWg6GSYuQbza5czMN6oKX3DkV27B4QXixyokvrhj3+70OZ5EADGOVAkpO2ZN
         YQaO6SsFyqEUiOJkaPyQxpYda1XK4emBLFGt7hvDY3r9yvN+qlMhhaSSZA1XwSYCrMu+
         cA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086338; x=1783691138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=M1PwReMa9pLD/7h60xvmhljZtVgg+EuIEaGMbbYN58O/2ODbN1vzpmADRr/mYbKF19
         CTOV1xF7C/34LwIGJtNV+8Ualblgjoel+ZsmgMsoB1eKGa39zgiB4DbeSzqNwcELRkvX
         5nFda39NnfgGrTjumeL4XjUnKNUoF/Xfuki6np99p5TsSVjQoQ5izuJfInfmAAqgSj8d
         q6mIfYnsWGwD7kIrQIxf2UYItjgIiGEfk11Xk+l1BTP/mpQ/qK24kss/d3sK46/Edvs0
         jl7W2AaLdNiVqkXcMqJhhv+rX6qxCIuv5BP/Vgw+9qUvo2m6jS9KSwdSqB0OHqJi1n85
         N+Ig==
X-Forwarded-Encrypted: i=1; AFNElJ/j7br1unGSuU5muMSBSxgQ1uOaQ9EbqiPByWnfS/4MnVMzO6EOU6jJjeQCsULTa1/45j6vPF/dCoUR4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9hPpbZodBSwhD8iYmFkN25B+X4C54yvB31Y3pPxC6JLzPh5b
	Vwuuvo7ZdZS8EAv4G1JSWYipWoeALebwlU/Rw2ugS1VmFbGTvFoaN1E+0y26xGpXB0k0X3QohTn
	yr0Q+wt2deXgl+OqGPlTrV9W/kll4i6icT0eFPzg0/ToQMqjG5/D9uVJHrN41mbLDJQ==
X-Gm-Gg: AfdE7cmMUIoR0dzi7gpboLU5VDR/+FdecTTKfSuDyWsgZ+qinlQ6p0F3OEZnEwNzz08
	th0171UvmZePddnU0aemMSOyQBErTsYwokKfDvez+96U5jnqlR7z4qei3ZaWPDSxatT9B8uWj78
	58UqAl8vSwzcHr+7rsNxD+xn7/GNcvSql3np9EGc+V1Z3Kjr7FnD38Oj6oh5j/qkJ7kMsANA3Wg
	u32PCdIXZ4rgEdyPgAyu0jMTlWjf7vGypKg3rBNuK5pC3Uwu8VGq9KiiUgAo5b788/DWxMVBWfd
	VQzC+voYeIp97cTcBi04ahFa6bZiR2snqdOYSRCnp40Urj+2cQ7huH5XfqllyS0Wyi+QdEXIeqr
	IJUJI7/NirxYGLeDGitRTiT3nntkGB5HEF89HvS5+3AXOZDaqy1Jrg9p6SY9jv8PYYAuylcJG9L
	1uBwnmfHmeg0enpbtNEEKqnQDiO6RCNL32Vk6SjRqgGacXBDtIfpxvQynotWg0tww=
X-Received: by 2002:a05:620a:2725:b0:92e:6a8d:38ba with SMTP id af79cd13be357-92e7b3dec02mr1223921285a.56.1783086332797;
        Fri, 03 Jul 2026 06:45:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2725:b0:92e:6a8d:38ba with SMTP id af79cd13be357-92e7b3dec02mr1223818485a.56.1783086327285;
        Fri, 03 Jul 2026 06:45:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:16 +0200
Subject: [PATCH v8 3/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-3-98ae32bfc49a@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: pw5dhwjTX1Jcy_GcaZPzQK_5G_vvmnQG
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47bd03 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: pw5dhwjTX1Jcy_GcaZPzQK_5G_vvmnQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX7OEii05JTreK
 Yx9YK2mWUzJe5NNJKi1OzT/+RZHW0wTmq6Q+j0MTOSmI3iJ4B35yWhqWgrfMy7P2RLy+WdKdEMn
 bzRRcsmFov7UTxx5Zvo5Tu412hP4TT+V/v4/EaEos7cczEaZv2I5T7F5l2a9MZRyBFf6ffhvy2n
 G/fb1XJrtifYPFNLagPchrpgzTjBJ12UlLFQvaaKVVfjj/NbmUVBipnUVVoSnFxa6IkBkZ+9v32
 DmGh4NvnLq3sfEHJ7txoHqtX9xyWKNaZI/dlTUQCkka10RbVSn2vIwafnsfahOmaAMGcvZ8aPOE
 u/NEutWD67DVeHgXIaM/TZUfbyltqhNM47IvwkOMBzEiaeBxGzgyiIqV3So2LlXStcvjS1q7/cF
 2cRQFedO9VSeZDEeFAOgrrKz4Nwl91nLFn6pAYKUmUoRsxdsvkrHAcMbFZcWojzTpQjoFFE4Ge/
 kdGE+7P0GznKkysMydQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX9sKceOWF5LsF
 l1EwqtR8dH4gvNVp1oBWgHHwCslZaBH6Nmf5aO5TNQOWeWricvcwrUDhg470kqHqy4jePZ8nt/4
 iSR7Hf+uvLAQVX9ufpv30vYk1YKgDAA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

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

