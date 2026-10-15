Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E653F68C
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074407; cv=none; b=mnxJ8wmeQnQlTTC130yj4OR8kkl1TxKpYXsY+NUdRtc5KmY74ceAFrbWxArcnit7sP8w10SkHRC77qJyyNlJWxCalluOEE+LgyTQG/OVEhNncbxBQU3jHDXE6y5yOWyU7MRhKQftga3rc/8IXTtI3DELbrqE5+86Cwotr90cYoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074407; c=relaxed/simple;
	bh=7oRRkiyidCwIvpqmvaABEOiBgTKSng/ezBEoQKDR8V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbZ57fEXgbaSB/fldIDgVSxWF33HSYFznUSbdz2iWt1ekyoF+7BpU5ISpzi3uF6HwoIe+i6w1sbRts4tjFapZlOstQfjw59QWBGEl+iC32bf4zm89FGGtFdldjiFsE5WQepBSQZfaI8R9++f9znW5yB8BjVFDOcnbXnwjLpyIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sogn1RWg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eb4uebjz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sogn1RWg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eb4uebjz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAQLpD1596905
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 14:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nX8NHCdH1mIPZ8Y18DIA0kViNrTV399Gnyrkc+b8WE8=; b=Sogn1RWgHxcxg1pp
	Z5d3c+Qq0Badn10+/9vMC4yk8oGB1T2GgMV+HVF/RGEaiARDbqSQc6+IZ8kU/Srg
	GLK2I2DEsUTqoMlfy8P7/T4NklP6q/Kcq6EKKBeGDQYceqVm1t/V7j0ZaoHQ9632
	EKWx7E5wIt+32amyoGkpGOfKAUzIF1rNnBk20DsiTLyMZLh1YsYACbJlpVBkYG9l
	/7gNO5sshWnNACTslxvYFPwdhK45MjbXkElGzxMJ8FWt/MNrVYb7ecyYi64Sih9B
	W2JkRBskDaJY7IEMIVOBBAVtEYtxllEZ8oUAVcFZQFc3GVN/Emp60S/9+XOS7T2M
	RT1nJA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2v8x9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 14:26:36 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7cb6dd9d07eso411049137.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792074395; x=1792679195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nX8NHCdH1mIPZ8Y18DIA0kViNrTV399Gnyrkc+b8WE8=;
        b=Eb4uebjznzcbjSOlmxymYPJ7vcXVF2DGDUljfX3M7VK4FnL6J0HHMGvl1xRRfFoLnK
         KvjWJhU1DnfOIdiIKvnRkG8MO4v//kFWlqUOmRY4bn7pxbh36XhoOZfHYqy3XWfA8sHj
         T1KDO2mVi+64XMa9LbHMOGj2C4J4sCPjhoxxojem3dt888Se9LaOPJppoZFk0Xhs6KEg
         Fp2wN//7bhr6FTWlMFFn/+1aLPYfAexEfyFuBpfKmu5ZqMhZH0roAhZXb4hnBzuJjMHL
         QIg2x/GGTFga62MKRfIobhD5ntZGAL2ZQ7L2gME0OcJyKtCO4C/MufTwOHRg1XuafFPH
         aghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074395; x=1792679195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nX8NHCdH1mIPZ8Y18DIA0kViNrTV399Gnyrkc+b8WE8=;
        b=h/ObyHdHqYYK4upgdaRTos676fpw0lYjP2t6MDp5izyN/FtHmmy++4eN3rKGI/vYKd
         gKBKzNpQn5frvEnt7dsGAgGf4XqEL+AuqkS6VIW0FyNxRO1xHXX5kxxvD9LhFaYSseO5
         4C5h7hreI7onmojHRIxmaHOqZEgCTNvDtuflqq8xws6KbaGtfXi+bSX7H0DrCGJitYh5
         32dePBYXogkEdoE4ORUFWiot63tbQMOHt/9tldZzwJPpWtAlheDItwO3XDD2b7U7IR1i
         UzvleZPM2ZRUNsKM0YVzieJk+p4XZon9QSWNlQruk6DDLivqYdc1MROwo4ZaFs9hy9jP
         Uraw==
X-Forwarded-Encrypted: i=1; AKwUvByzlouz7Dk73pAJucViqXUtWSHCfnrkF4+2EifXFry0G3PmOtG6U1dZOHzvzoFo4kbrokJAEF4nttKOYA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIUmwjYd6wiTggFSyWAquXDVlV8C78Ha7h0Wq6qEMNt/CEiZpRY
	Ylsh2c8A66sDudIAe8ec5HKuI+dmaVHemQ1VrzWJc/JeBm7Nh8gdaUZrophECzXfZR5IGp/d4TN
	p54TMzYPxf+sBZHwBAvNZvotSCAP886yuxlDjlgnz7cWf5rk7BjxPPBtoOkThKg9vqQ==
X-Gm-Gg: AYBFou37G1ztcoh2/KkIaq4zXyK5UlyVyBOzQC6ntBE9cMNzJ+36v/zQ69Rh4lnZBMK
	A5tn/dHvRqkzDDBwH8Xe7rH4qd8qwBkQrRDCH56Z1v7vWZcfqJiPsy+7w6/b0K4XzLlSSTx+nkm
	aSN+atQZMLML2VSXvKM+/CkQm8lvz4xyugeDvv1lAPlxylo3UX59bGCczeHCsxw7wUgbze/GoGK
	6E+Nr3MNqQn1/E2WJeM15W1MlknI20idmEO66/onoRTM+1PpR0Tw42wsoOVcD8dKNEwbyuUV+Z/
	SQk5/SX6kFLLYKhf+keKzf9PLAmszO3aq1POTh3A3YkJTRbz9abYjGG2TdY4tsyppSTtuqNPaBd
	EforhSwictPSBn0DRqWWGnjIBBM6pAD2r2JWnboYPfLFHWxs3Zj/HPTVOraV1pM3yAUYKzlG0tB
	7fwb4wn2rdHgHm6+13IDn+W5gsSy928TSPDN55F6qRnncBYFTw8+8=
X-Received: by 2002:a05:6102:a15a:b0:7cb:bbcc:e52 with SMTP id ada2fe7eead31-7cbbbcc11d8mr1668723137.0.1792074395024;
        Thu, 15 Oct 2026 07:26:35 -0700 (PDT)
X-Received: by 2002:a05:6102:a15a:b0:7cb:bbcc:e52 with SMTP id ada2fe7eead31-7cbbbcc11d8mr1668710137.0.1792074393563;
        Thu, 15 Oct 2026 07:26:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5402:5e0b:9ef0:9b5b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6428b3sm69083145e9.1.2026.10.15.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:26:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:26:06 +0200
Subject: [PATCH v11 7/7] arm64: dts: qcom: arduino-imola: Add NVMEM layout
 for WiFi/BT
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-block-as-nvmem-v11-7-f890ac74f87d@oss.qualcomm.com>
References: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
In-Reply-To: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
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
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfX8jxTaw4QOWTT
 PbGH0Q67Y0GGsQl/BKC1z6dgfWqKjdNyba9agrD5Oh1GGRsB+pDszxZjL1Z7xdiHN3Dkgl/V2Nw
 hkz7yboo9MoYWEc6bLSmegVjEmjWoEb54QVy/dJ0Q+6naD+s8rQnztLwB95JJgwFN0P7wdE6WRW
 0Pt/dKT4iKIwd6T0O4bzPlbM09XNdsT95NRvr1y5RF8Fm7DimmULsLubo/UQSEtOU+WJ3M5ng7k
 wCRo/nR44xADgAzuFhDIK/i797kLX7sP1F3O8HGDiPA+Xov26PjSvYGWYJhU6IAAo2jJhWCLg1A
 8vkSfpzVkPOBkXO7xRJl20HV9ZzjcUf3g84/+Pd0qqV3yEzZAH9F0Qr5zhOhDhg0A9p7DOsw8Gy
 4cMQiwJonHCmH3o44APV2tJ011dCn6Mrelc9vJcTdzigMLA+yIMAVMajQObAClD/qswz6tGTDiC
 qjdpeYDql6ZSntBNgJQ==
X-Proofpoint-ORIG-GUID: WFhBNsc8l4XOiRO02kJIN4RslXYX8mg_
X-Proofpoint-GUID: WFhBNsc8l4XOiRO02kJIN4RslXYX8mg_
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad0e29c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfX9QUdJeaXi+tH
 DOMCFgHEsRGm5HmE2R/wwGdE9iLsnQx5YpnC6Jz+c/ip149/kjNP9ajlU2+lJm19GZE8VS2ziJf
 gDN5KEVWgGjBRA4OEirmghdreBBS6pY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150057

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
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index c472e13fceca4eb882a59af3be9f45022a923ead..582542c16f6c0ddd8e6fef3ef6b301ef33c5abd0 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,33 @@ &sdhc_1 {
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
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wifi_mac_addr: mac-addr@4400 {
+				compatible = "mac-base";
+				reg = <0x4400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			bd_addr: bd-addr@5400 {
+				compatible = "mac-base";
+				reg = <0x5400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +538,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +586,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1

