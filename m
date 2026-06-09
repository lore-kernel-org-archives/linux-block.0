Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350D3F44EF
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991619; cv=none; b=hFbInAn4WyqZGwJyf8G/2D3wB04FZ3Mqul+kul9tuy1+1e+VsY53ibSxAlhNMRsuW4TQzXWiTyLxrfwcXYhm1K09z+e6H+aV5KfTPLWp+NqJEd3LXNN5eXbJM3a8PUMZryiTu60AfPD6RiIr13bqAJakZWTIsCxC3qt2GMR7oaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991619; c=relaxed/simple;
	bh=45LaNgBPxbRtyHZ0FmSbWF4XyTOkfAE6p0u9C1oK9dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rs71gCUv2cpjVzzZCxOky7f7Zif0WX4I7W/7WkRKNX0+nd/rVe62xtbaEGH31LN2GN2R+OH/EFscnfUTa4ONjBopJuo92icK6sC961cdwa5gDixh5A1bLF0dJbfqy1gySPxG65t2sPvHIEixVAUxArVqcMfNZFzSvifEU3PSZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e5bwKaDP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cq6vcQdk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e5bwKaDP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cq6vcQdk"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rbYo1923228
	for <linux-block@vger.kernel.org>; Tue, 9 Jun 2026 07:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=; b=e5bwKaDPTzMnR0Ul
	MMl9KzjZPAO3D4cvHAhIzVz5+f4NuKCH3NhSokxJwdcgSWREJa/zXZS5EPkGnu/v
	2upG/2b6d4I4pjpXyUWeoPuNUMw5ILcpskCSIhx0HctiPPzjwKXY77Avs1KS3VYY
	fwvSS2wn4zQTvD2/dYODCRHpHEf7Q7VyyraHdWxMiMrmOzdZIby9H6hSBumpiZr3
	e+2kNnMcK7x3Wh1ZK+RKbxXDtLVxBkmhO228D+HagLcgN7zUKFCf/KHFHx0DS2f4
	iEJ713MhrnSeyuh2tPSmwvibmfErZu0q87CTcDk2VP5UXNLz7UVWcNQpnAlpRkoq
	KH2lSQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4g3kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 07:53:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51776d4355cso149440601cf.0
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 00:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991617; x=1781596417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=cq6vcQdkavbKfLWnJIEooJjNFcIdfFqokkGpJTGGpXVRdwqhHKz7REBg4BDbZeIh9Z
         1lXcCCWh8sL0wD35Fx4e9mkCLNqdhZ94Pq+TRXZRCW5ej/GrWgx8C0hZzFGfgMi+aJYu
         ftZVW0foB/P7QXd3vhZAG/svVg9PCHwXfuPvFGVJeAtUHQauS56TQEWrG0a8SzuBBfj9
         vwcIidWIfZcnhZ1MyvYuVIBzEIWFB2YBmeYpOAIz7FjVQJP8Q7CHVnL+MhmjGaFmGZzW
         +h58YItGZ5camg2SIOeq0zFpupM5KENiG+utAuqXHbIPT9ZZd+YwanPS+pOmzzUvPzm3
         72oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991617; x=1781596417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=Sw29tsZdSm8efnY/qP0vfhyP93LaQjyEGZLI1iNdKBpl/WEjAJd3GMA8A0uwcX18OG
         LDR+REVh+T5eo3EyJZLQUD8dwTVGav7tKryvOZcy7ZtOaR7K7HwpKrLY0p+AGPGQx2uU
         oCtU+HJlEgFbek7hAWxhMd5nkl8ChbQDmfusSnja7cEIk38Zofcf8wyzgeKgeyYihVnx
         EMQlW6xYEzex0yWAs+TtPpyZJk3+AuAQb/P+TcHFs2lRe6LNvUJqzrg3Yx/qE9lDVzPr
         x2p4+IMjhDUGELEuWMfMaEcIA0katiEXK1cusupjHFvreLkrvdM5cK6+0tk6AUvn2p47
         DsZA==
X-Forwarded-Encrypted: i=1; AFNElJ8rBgaDAJe/Zevj+aIOsyC/YsqMTuH6u5Spqimd+OOWCh84G+KlEdrvsbGrki+4TE/06BxV99e1rz+xSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXXt+e51uoecFICds+YOUeYyyRQ4wmDw1LsmzL3i+OGdBAgKI
	NUfsFVrvPsSBO+uLdt6Q5uSVCj8WrmGrj6d5CUCVuIGQQG4i0H3HolSLank6YD6Es7cv3R9IBu0
	FjMq+hysPAUgm9hsKcStTLaOV267c35/QQcXcFjFZlqKWMHVGPq4f9vSZ3tQsJk+QJg==
X-Gm-Gg: Acq92OF9InSoqxkodjx9nJ52myde0W8RzZUhOpmyYVUxfEwvPSY9F49Sdp3xgfsSrch
	k6/A3ejV/I4dZ/Pj7qc/GsgOGHyMcV4CzHLBeBPcO4hO3pzuDLl7oLJuX0mt4fwgooV87ipapXY
	hZWqZHCfXeu2xwwJusu8+1cAWfSMllqF6AqZNmHnBdLV8W0XX+9wHUo62bjM9MQ6jYanhDnEqeH
	/S88R09m5fFU8k05VlQwLxOjsmK+EcQ/MDd3iGoiLMa2qI6r7JlAVoz3EouPcuy7qZDmQ49NQfs
	cpFkL/sZRTrfFwc89yWKR0Sz2MFXXSQylKapRGViH5YnQETBUGawqthxC27yzWeZh+HxYEEAm/n
	DDd3tRNcL8Ex9zz5i5B6C4meDOAmnP1pOoNuMaMPIoq1OtjKg4/xyxNpdN7185/2fQIcYpyqqdG
	wcFdTLZEvDwzd2/+59auiEbY/zsF6kBwR00FZhQfvAjelLsJjDzeCtVV0tfyQk9cQ7vUSobqKS7
	N6co/PQFm+Z
X-Received: by 2002:a05:622a:1b03:b0:516:d7a5:afdd with SMTP id d75a77b69052e-5179867241dmr191571571cf.3.1780991616857;
        Tue, 09 Jun 2026 00:53:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1b03:b0:516:d7a5:afdd with SMTP id d75a77b69052e-5179867241dmr191571431cf.3.1780991616438;
        Tue, 09 Jun 2026 00:53:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:35 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:33 +0200
Subject: [PATCH v4 8/8] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-8-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a27c681 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: J0FDl5CWRVCNCEj1vifYl1ysbeVt1A5C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfX6Ls6K6EJHTqD
 9hALCdnc44Tkbda/CCgv2rM6Uu6UUgEnoJxe5N0s/QWBt9Ew33sGAlgeJ1MJJykWx8XphMJ2eAH
 Cri/n5zOfTj28d95nSISKCT7C1vl7GgE3jp9frIjyQsh5U+8QiJ4fZB7MaisBluWhUCbAmeCDgU
 2RWzDLuYSnO91awaYD25DXkWYisOajXLSZzo1D72QAbm7eO0+2I1oz59qqzOCF+OHkDrcVPYC5P
 4/VpqSdEyJhSl+AvxaRLFr9WqDju1wpoP2Qed9ZUAjqm/4D54hYVDnnEdfgfzM92JIGkxHSBo4P
 r8UQd8wJfiWu7AjqXitxvfChIeEndG3BxKa137rTxAy6aitOxoADz21xRpZRGtakJHQsEN6oQfK
 BAr8gHU9D1EwB+T/u/WKsqUKazSuhM2Wl5NOIsLo4KSDOR4rr7REisSsy8D/UqekKMOG4GsMsXK
 vxn4hGbDRdqWAYYtd7w==
X-Proofpoint-ORIG-GUID: J0FDl5CWRVCNCEj1vifYl1ysbeVt1A5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090074

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

