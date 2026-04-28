Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4A43C071
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386210; cv=none; b=o0p6O+kELSzJ6/CZet4NRjW8LrWA0NHgRtoBFDpaFVJn6czyQKLAF55eLf3qwrHjUfTmVRnCSHPMFNwIlNDUEYNEpp1FI5P8Ukhb37LwInqEusxcx1oM1JuNyyUFL9eExEgziM0svSGsx8g10pFzKHojAEkiV67zIhmVg1eCGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386210; c=relaxed/simple;
	bh=iY/VfJm1uaSOqwTnG+ysQb3Ah4zUvNYZa5ApjLpBAeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggYViD2A7YdTDsnG4CGq7IGw+wUPUbTKZeD9xvUHYWgethyjkJ/0vxmrG6wBd9wpLlcIVZJCjdtd0dgyADqklsuRL4hI1F/gAZzE58QLb5M0MOdZFx7yAnXAV8Dtm6D8Ge0BxSUT31MCUfylizzuDcXM4WNBdYuvRgUAZyDBhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBY9ODjK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RBAMh3nr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBY9ODjK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RBAMh3nr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S9ha0r2045271
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S6j1qnAdZyoQGgOKRaS8VSM6ZBf82wgE0IlMn6k4pLM=; b=pBY9ODjKd57VJ7fQ
	8wU/+JYQXlY52h6b7nn6uMPFeERqAXOixtsF5OYvZ74ld3CJoOYU2kPGd7y7VQ+M
	jJNjX9Trr3O9rvHejYSwkFdrhuAIVUTI3/HKqJE6irsxU/2muTFYon2sJLuQufuB
	xzXXwihPXe4EqPnW/R940HTBX97jdm8/0Gz0up51kSOncR3Lk1BOOq/iR5mY0/PG
	4GWrSof4ZxgaFXS0UGC3ZBKpMKz0NW+ARMW51icCCqtzdqdPJzB1Wn9iRtqzh9mU
	8Flb8meUeZH6O2LQWgvl5uJJ0OXiPrjj4tNzmwJHJlT5Rx8CVCsXv7c8/vTQD3LK
	p+pGsA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttgys3u7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:25 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56f6c90b142so18108544e0c.0
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386205; x=1777991005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6j1qnAdZyoQGgOKRaS8VSM6ZBf82wgE0IlMn6k4pLM=;
        b=RBAMh3nrSai8dP3NQGVkoo04mZ+mDslcKH3eOkfwqzA8RPTMDQMagmrZRDjvhVpTGN
         GNA+rm1h5X/f8K9opiTJL5WgtaqejGW+/3143OsmAUk5s6F0GsP2N5QcaLSobQgTD05o
         JOW49CauDMCgSli8trsnXu5GIyEUunFWWpzFWIqB3Uz6pISDFigohzX6nTDlaJvTGkrS
         A6BGT5S3AyX4OeuofqsifhmXd/cqru2PNqovo9m42G1OkkFOkKD4irTURcDzs6u1wX54
         kFXsjiD+/McG1+4hGf/7AdCHN1Hz4+F+jF28Le6qPMEgfVBgBWaxZ7u67d40GbPjgfmv
         eEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386205; x=1777991005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S6j1qnAdZyoQGgOKRaS8VSM6ZBf82wgE0IlMn6k4pLM=;
        b=R/Hav6wCs7hOL11qhEPV93Oo0rLwCzFMREqAk++vgqjzZjDGMTU5boMry9lFZUCUNP
         L3mCwlTZ4/36Tu3rIr5TN8yZmwRg1MOhbkBQB23PHAmHor4r+22bP9bRVg93EPQzGYBV
         13qVkVDyoKUiYhXZKR8v7XbpxTtgV0y2AKqlvcqeDBoaE/n4wcHRgL/JoYu7TMHUMbTA
         UeOuXK0oAS4TYsygBvE5kV4pms133bgrN/gzOp7DVn4tFfP8kpIgI9/agbSG+1nYpDXa
         yZdwy8yWIxEuW1ooX5idGVsEBWR+ZFRX2hW36bRlNYCuBfVsy8zCxHDf1fTYEBueZVJ7
         dWQA==
X-Forwarded-Encrypted: i=1; AFNElJ/kl9dx+q1papESTBxhBXp1zdjoAzASaypoiBlt7IrCJ1A2Ivq38GFbEYTYyAVWpZ4kU03wQ2sWfCN7dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSanZUPZRCwtA/4GImJcaTe/G6KYpmCdcNpPdkgPnHBL3IZHTC
	P97wNMVgrV31x6BUisGMy2Izyx+qbZqOlz4/5uANsxBdT4wxcMbvCD7KFG5Bu6c5Yo1oCxhP01+
	cdIuwof7+gl83K16CRO3mVPhwMmwT0gcKoB94KfepFK+4m3JGMjPXQdYtmdzMBLgpuQ==
X-Gm-Gg: AeBDietuxDq4Yxqkm42wpkFbD1/b3jVgr373nD6RZiIG31xwAVvfNN2Ro40hFl6Gnuz
	V7TQGqOCY1cR/k4KW14Cd/x3yer4NrdWLrIuWp2JY1Bwo3gkogTYgJnQjTa5r6KpHZVEcz5Kg6F
	1skVSDn6FjYfvnAToyHCZvxa4ZPexHvGDdx5yONZORcR2c8MHpXLIQBc1tgrkkOVTkmLXMnvTBj
	qpKziLgUiH4B4L3YwDFTaabDFM1I8Tbn6xUDo765MgvHoiKkAFwllSBGag4SJZNdxa2PDrAqsHu
	Vqg/yeAhqam8LIQXssrKVPZBUpkLhP/geLDIeGB4CvDVO8lvApaS57SLVImu9Q10gQddvnTxAJT
	cnS+ztqej4apJgUVhCFxAriUuHLMYbzzdX0raPpD9vOda7pHvdXALKjH243FoyIB6QguA4Eau0Q
	rCL+IIRVoPi1mZDdTB5xk/yIehOzY=
X-Received: by 2002:a05:6122:1d4c:b0:56f:8f5:b135 with SMTP id 71dfb90a1353d-573a56fd202mr1557353e0c.14.1777386204949;
        Tue, 28 Apr 2026 07:23:24 -0700 (PDT)
X-Received: by 2002:a05:6122:1d4c:b0:56f:8f5:b135 with SMTP id 71dfb90a1353d-573a56fd202mr1557313e0c.14.1777386204513;
        Tue, 28 Apr 2026 07:23:24 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:23 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:10 +0200
Subject: [PATCH 5/9] arm64: dts: qcom: arduino-imola: Get WiFi MAC from
 NVMEM
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: zb51C55BH6SsoJkzxTzC41xQnI_qvGia
X-Proofpoint-GUID: zb51C55BH6SsoJkzxTzC41xQnI_qvGia
X-Authority-Analysis: v=2.4 cv=cb7iaHDM c=1 sm=1 tr=0 ts=69f0c2dd cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=w5cLSrw8bnM9wMX07V0A:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX2+bniqA33IQ0
 udsz4g4KhcTcxwAoozcWQO/Ret0b9dbnpC5fLsZIs1bE8M/wxP6tmSRh4JJp0o1n6mRbyRwk2O1
 PA6z4SKWUF495wLR9GeKwiesmHhaqF0hKZX5xsOQP8ZnA2sWik4IMwO5Ci8NFmlA4o5I/hfGVVc
 MI+yOcNolxGzDcGJRQebDlgGtPfamdtJGDfejwTnyJd5TcvToIGX/JHRBWEFQSVj4m/u0OLddhB
 gvc8yRDxKslsJquYHYYkwXDQpLjzQRamX2LLpXV5aFNJHQGXpQRbLVxSJr2+vDXzF4pxVk1ohCn
 q3w9LFf8uEdAD2p8aW2B1lye54Y0xGWKIBXW2oTqg0mTmJyzUZaY+9fk5jptjgZJCTv9iFiSqSS
 mE/4dMbHqIuhjZbq7TMfFXPFGmXt+H8SpCx3T08zdCcADYQVkx6qJ9zehjaSv/v2xVUetud7ky2
 jGrwcOTo+e8pyaLHiLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136

On Arduino Uno-Q, the WiFi MAC address is stored in the eMMC
boot1 partition. Point to the appropriate NVMEM cell to
retrieve it.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index dc85cf94f71cac8666cab30ccf37cc2d2f8fd941..35a30cd6f47d6d2e018f6841a05fe929fec15738 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -581,6 +581,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1

