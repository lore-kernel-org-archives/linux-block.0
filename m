Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8C3FFAC0
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270491; cv=none; b=rYwn6IS1PDkjwGBvtULJKnUt5gqZtZkWVTXfZ/gGB/25Oow5ljSkrruWsn3DiHOODATygxi3U9wU/l96JDnGesSBIQCHvDfdBuW7TGEOMSS6oHeEtxkb8RNfOcRFNWmdEOcqLcQ+bmF+LSJ5J+eIriFtl+DqXs4d00vuhqzNkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270491; c=relaxed/simple;
	bh=45LaNgBPxbRtyHZ0FmSbWF4XyTOkfAE6p0u9C1oK9dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tSVzgzsG0nj0V/QBW05VP3sFtr1FjUYQ+3k5MPK/PwPmCo2R4zEizwYSRgMQXh+mhGurlPXul1HeexmUknDu7JRKP9+T0xw26omO6AYBi0XskSzAfYMRdJkEz9MDzpKZMdGtbrV1JjZWsvQREqYefIyeAkaq+6jOheUinv7tGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9bbuHJn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aDDfRKsV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G9bbuHJn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aDDfRKsV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCipHa3661225
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=; b=G9bbuHJns2jGAuQl
	c0OmC1/0RgFcZ7pu2qqlJpfgj0uKXnddJ3xd6ERtg9Mapdhviz2VhO57OIKzGvkI
	4EEsAKnu+WeJ6SpHHFNf0w6wB7C0OtHHfqPPxm6hMdJHVRmWUl/UlfzSYO2Zi3tt
	YpqODGm5tWyaKKsCqpRTKDrvuRPSHVTdRnrdIyipaf27n7w+OVs6YoTdLT0TH0ci
	WRKo8AfPax9s6U9HtnxoAtmH/2saLwqAZFP7nULUVgKyfS/ERJBRE/3KAtQrHd2z
	Zbu5Xr+GlfJ/PedbDDCY6Hfnma/rCEm7wdbusenoP0BmtcCsiRQ1Vl8mx2LxuMVe
	jixX+Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xck6xm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:28 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6c7b5cf8bceso371012137.0
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270488; x=1781875288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=aDDfRKsVLX+OoYZcn3QTr0Ix7AHpiG9z4IXLX5laFH8XkPVJoMGoL/z+ykTy99h+6i
         edDCgjMKntvmJWvFR84k9WzNWtQdEOVYWbToCVQcd73pppMJYgKq/nVJYcHHuJvvRX+q
         Z/kkMWENIB3VAYJicYkhkyzlRh7MfZLrZZzhbsUXZBT5/rGUOdpM9W1pTE/XwkWTTVdc
         GsvCsMq5e6Sk63a7ZyRcR2mbulGltznIa9BTWibG3+Zvgs1Lig4dSWszSIhgzQEhXrb3
         NUydsx2VSE6/01kVOAJzRJe+9eC6NmDMSl7x/tt9k05auxmzZYk20ZO25GmKNgeGpfJy
         0aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270488; x=1781875288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=UdCgxSmPTBVdfRPYRF8OkHAkZ6vOv5kAEDze8CPzT0GVtVXTyS2Cf+TMmcSnNFyqEy
         vLMER6mwZ1nnoPPhnCg5GwGRDp03v8bXrXGEerOwGsXML0YrAsdh/J1nGQ3lqjBZZmVJ
         ldpgt+7M9BomBPc+JxsCI6RTNSde5Jo5008MfJTsioHPO01hLRXbSsqN1/z7zqED1fdZ
         GM7SUh6ZkFMyct3uX1fWnsLHloKsN27Iv/jsSYP6dCUWm5DWKkDzN/WOqyF1VPXL+LN+
         heJguedfwle+rvQ70vp8SPRlS2r0CyU2+vCejfNiHDySdUnHTQ0Q8n75CrfvTgYq8jgZ
         D9Hg==
X-Forwarded-Encrypted: i=1; AFNElJ9WeYxcPxrgqz9le5lm09zJb/vghIhPEkyFdIVe2uvb4WsiCjKDFvA1IRqPK/1Vkucp9Hu4LOm7PB3i2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbN4MKvvJmakk6asQzezjv0qiLD1wS09PyESOZXWJOqAFPDJqv
	s+v1VEerMwebD/pAukvfmb5iXfxd03q2LAWmTsJJ5+LX9OKejWll4McThWovC7o82eLZHqZawdI
	pM4UPbeY9RAzOKFGASmLfAThj1luL8TizAxlL/BPim3PQhkz/QqvTaf2Sc4AFOALNxA==
X-Gm-Gg: Acq92OGLJxYXUOnbU7Y1lSQak9ylGbJRCMFXggMSFxyzvht0UtywLxeEqm5cZeug1mv
	BueDxGN5zmb1bOBiIhSIdp7WcIaC7rJW1DRxA60blMNTzIqaQNDP6OEZZjlhY3ck56Z8UAPKx3O
	WaLQVnNBX0ACBAbc+NybkKcFVmCvD18E6lqy8us0QeavcM+xnOzeYBy+Jo10zUvFvZfB5CUVBZS
	FYedrQybN7aQTh77Bb4EKlktBcpZrnTskKQZSqy0EiE3r9a1LKUKPD4u1/MeMJhnZWxvDBFnwnD
	aEcIUAie9YrFFdzijAdKLfvO+B3+rRg5k/V4ZptmHDpllikPltMuqfn1ER1bXMjsADS3wLJDubW
	+P/VyCBkZTs6wPHU5sLwVcobOQmwrOeIllfIJEXezDnK3myEh3MrhZKCsv+tTYFp9hlghGqCK7J
	rku1HeRe6WXJh67IGx6MFqASyzt2ur60FuxoHGm9AIgcDQEp91jznukjFvulY+lipFI2qRDXOz
X-Received: by 2002:a05:6102:a54:b0:650:a5d1:ee1d with SMTP id ada2fe7eead31-71e88b229famr1135199137.10.1781270487939;
        Fri, 12 Jun 2026 06:21:27 -0700 (PDT)
X-Received: by 2002:a05:6102:a54:b0:650:a5d1:ee1d with SMTP id ada2fe7eead31-71e88b229famr1135110137.10.1781270487392;
        Fri, 12 Jun 2026 06:21:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:21:01 +0200
Subject: [PATCH v5 9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-9-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfXyNdxwwvEY+l1
 vfcP5olPU3o/bK567Xs1tYFfM+2ie1WynPkUMFEAj6fB+mvMazBvzc68jjY1IudgKHw+CVQ1x6+
 cQsWfFpvrjRQ8nFs8BZz2M0S/u+d2E2iP2kbW87Lspn0UJJRfkZt+Or3M4Qa5dmS/fEj6uW4bZF
 mJEpgDCzUmLu1LCWkw0eSCioi30ZHswKNH0btdpdHmAJFZW5tkGvfmCNixIa9s0ZoXjdMr9y9WK
 EdnaVRKPvVH57uEt2cKANGdMbiav2JJ/t5Rq0t4ZfeKxeRS68TdvXhn9mvX4oIGIbh3KwG8gsye
 Ms4sKmLdbRhT9SX/M7g4L1BS5zfYbQe1JYx1rciynsDBU7fhhUPkxKgkPmJXAmtOyQcnV7tOSDn
 8BCvhfyp6FtApAGGa7KF9/TZDiFbl7SCc4yzhVRG+yiSvMAE02aP20V8kUubES/44NFq0XSW0BU
 C20zoo23vTLqTho96kg==
X-Proofpoint-GUID: njN_n1JokheApSyyiFzPx-2CiyYYsMAb
X-Proofpoint-ORIG-GUID: njN_n1JokheApSyyiFzPx-2CiyYYsMAb
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2c07d8 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX+mUMJ8GfNZ2u
 1jPB8FufDzj6kVJAvl1Ze5onsZM7lnzcLZ4oylwJL8jGKCzJAgwUwJb6OhQV0UMw1VrXSves4IX
 3Qd4hRycxIE8apkbPZtQGEIh0K++z1s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are relatively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and Bluetooth
addresses, and point the WiFi and Bluetooth nodes to the appropriate
NVMEM cells to retrieve them.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..128c7a7e76b5b089044745f5d6407d6391055fc2 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,40 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			compatible = "fixed-partitions";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				wifi_mac_addr: mac-addr@4400 {
+					compatible = "mac-base";
+					reg = <0x4400 0x6>;
+					#nvmem-cell-cells = <1>;
+				};
+
+				bd_addr: bd-addr@5400 {
+					compatible = "mac-base";
+					reg = <0x5400 0x6>;
+					#nvmem-cell-cells = <1>;
+				};
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +545,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +593,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1

