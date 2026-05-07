Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B147799D
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167514; cv=none; b=JQnCsLJAP+q+aVG5CP4tR9w/Z66DmdvO6RcKG2SIXIui77fqVKGz+cjosQnmVv+2e9GL/pVihV8ZNwglSRfvMsCR6Z1vrkTX6OugMFu4tpERmsf1O5fMroDaBFcMUOvuCXjAaWJ5tcyaqepd99Y5IgGMzcx5BcFu5zPU/ryDHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167514; c=relaxed/simple;
	bh=ih3AqtvxdrSPtCldRnisYtzCgyzMAnQ+QYbLGIbAp9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ugZ+F5bjboaIq2+hD5TSYrC3z7XOczCTz1KpGc7qRL2f3UZ610Vhr4Bcn2QBPHopADN1S/PcAdaxcio+snqE0m4k2JgEjLqr93s1wc0OkX/86MaWVWWoFPpP0yHCMyJHXNreJZT661TVbn3UYF1gxzlClNZkwlx6eXlvcwAJyUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LWAYSYES; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vl1cFvsn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWAYSYES";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vl1cFvsn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BhGfq3924278
	for <linux-block@vger.kernel.org>; Thu, 7 May 2026 15:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+sodB+04y/mdW/cdeZL+z+1VhhOZL3GKbJATgOyNhgQ=; b=LWAYSYESvvmgzGOx
	ZuGeDCIveSsdJxzhtGMmkhkB9d0hLh5zvSPgCuKllGO2/gjLQ7GoxOvZ+8pdHGUB
	KJtzP7511f9HHpgyexvDoSArItpj6N9yEWa8EvVoxY+mbm/YNwESbiRdgy6LC9Bu
	+ZKS3MxdMSncrx3AMJ3gagwV2V0tmpcM8jt5Zk+NelsffYsdqP9zMmfhzZ7Js9tU
	aHD3bxnBnPoGFwU4MHfaHc2CYKmfFxw0rOQZ/PyVSiNrPwLHBiCKHp/F3GPqaEiI
	vAsBWgQdVxpPZ4UpZ6kQ2xLOivxSe/Hr3AOqBRjm1//4obbgK3FORcxnClIxjE+S
	JUKQew==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0c88bs5a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 07 May 2026 15:25:07 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56ae34d6738so2127258e0c.3
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167507; x=1778772307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sodB+04y/mdW/cdeZL+z+1VhhOZL3GKbJATgOyNhgQ=;
        b=Vl1cFvsnCItSz7UK2NzulzV7Dme9ELNPmQsrCcOyUMv3N6hONRJyCEzoahw354mlmb
         tizquJBDh0DHodC/L0zP61qBo/EKl9+ZVAJg4qjSeNMk8gkKVcbFPZpNMx0bQhdBpQXK
         Liwb8Eg4hFTkUo1t4CBk9okcW7m21h9SwP9zjloq2+k0t9avpdbn7O89e47iWZ4wboZW
         tniAPuivwYUwdJGptN2hpxknjpxm4PS2fuyKWtZbO/2WTdsac+PbLeX1jvua8uFFoiuL
         oX0xe0vXG+B6YRLDk72KSeXN3nSc6Fs8aYlJH1++ilEAfxIH8iNEfy4ApPUXjuuzHnbD
         KgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167507; x=1778772307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+sodB+04y/mdW/cdeZL+z+1VhhOZL3GKbJATgOyNhgQ=;
        b=BohfqGrw4/DFWGnbhmCHw2qM0+51A53TMP58KcJvT0b3EKBrPpralzkeJpYe/eYzWJ
         8aCf5/tpUH6crryM5BTtH3ChnAP/FM7uPx2fXQx15IGEPRnZUwktA5/TwVRrcPDqzPTR
         zI0+/eXpV7HybSgV1M4Pa0NvV9ncNDmJ9gnFV+EOcom4RnLs/jIlg2gOKN/mLXx7Y8X8
         m5WHL4+rAcPDOQtME/YwGXKr/owbgv4OzyWew1zyT7awngbIvtjtEVMvUL/8DaABScYv
         hQMQp30YraEl+dOFV7MQtGZmEH5jX2aE0woRVo/RltSbSQ2CLSnaYFuoi7I3r0+4wpdS
         IEHg==
X-Forwarded-Encrypted: i=1; AFNElJ9I1i7I6q5cvHFiFoOLGKJkk1KAZGgdoFOn6kK5z+ewtcZFjHErx9oW0uFKfj9oEPgTvytfiMzOhBAWTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXmv6ZuZ739nj3k3gDd54jj85SpdMC8T31vIyMgtU3F2ch/aZ
	EnufNZcOwDzp5YAP/Fi/STt5+KYwF+jVDTeB+0iLKjAaZetx9qSix9EsL44CrE6E6sYwQDVZjvu
	KHSdZaLSIPv7J/cWowPkns03IWY12E15pkypnVMStxNVokz9AprGYkvJ5/Z0RAPjEjg==
X-Gm-Gg: AeBDieup4SimeiUHpfU4SpPj4jCBximfvatI7pNPBjc+hOZwVv1Kk0oZGu4TUuWnjHl
	LgGdVqv00CgikrGZW2UnODybpNVA+7riYyrALewhrLBwTpHu6C1jyF9H2tX04zIrDoy5MJbR8EG
	7CDlKtrgVkKzh7DiGInjMbqLEl8fL0Jx+yqg82eEaJLoGZwXSnviWjzZvNPfk7LMeTVjJ1Ce8aQ
	2UY6p2pRZ9fZagHtrS91ygUeH/3xjhCONDthCUYPCLiHx+JuDLvv2r68hz+tKVOjVqn/hXCDSpW
	BIIX96PF4iLpblmCIqfVGykHfK2Sg732eJvaiIe4eQD8vsMy5+gojRpxCLnYA75Usx9RVtTzlMU
	Yvc5Qyj/JIGiDmw5p6jiMGX1GH+dQZUPrpfD+zu6Ii2Ko4mfcbZsyqpT2loupyWHBqTJtzeVcYz
	GvwrkVH28JtiQoZ4iORj7pOipnr5AtZwXGGBX21g==
X-Received: by 2002:a05:6122:2a13:b0:575:2166:74c3 with SMTP id 71dfb90a1353d-5755960bb57mr5381621e0c.9.1778167506651;
        Thu, 07 May 2026 08:25:06 -0700 (PDT)
X-Received: by 2002:a05:6122:2a13:b0:575:2166:74c3 with SMTP id 71dfb90a1353d-5755960bb57mr5381466e0c.9.1778167505322;
        Thu, 07 May 2026 08:25:05 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:25:04 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:43 +0200
Subject: [PATCH v2 8/8] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-8-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Gt_LqDSry2YIP7NhKQaTNjhiXrlgqCSA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX/cYb6g4c59JJ
 rQXRQRdec3PzWl2F36aNmOBy0FRCM+AfFCzKXrfKBFhKlOjZaPaLjIDU5XuHO22ZvDz1rH9U0HX
 A+m4drfs/HVoxW4+7ORW8l0wm11LzrQxab2cK1xMaHQdc842UHXo2cKN8QDVSFL45RjB2+f+/KT
 N/EZ83ilq9zqcm68WwsVcNp2hSgeEiVJstySZfqwjWwb/nFlY32LWY1V7hIH3pbQ0i4qNbNSzdQ
 zEo/+aaUmMCuTvVghN4PH1qHvjbyevyBLCyDtuZnw9Wjweq9/5+xIYRnfWhaXBhCVI2h5tEfjlQ
 S6UrtaJYWOVIphNw1Ht0uMwA0WeMbJV+ftp4EWoVpFO9c3k5LinodrTp9v9vZAmfkBNMqlXeoNN
 kgft41Pc0svV4U9RYt/3oDtaUMbAFUIM2RQJ5dtDlXx1NbGqVd4W5fV5enrdaNP2bHQCg9oGRjQ
 ygfh5Ehpo1y9eOHIzNQ==
X-Proofpoint-GUID: Gt_LqDSry2YIP7NhKQaTNjhiXrlgqCSA
X-Authority-Analysis: v=2.4 cv=X8Zi7mTe c=1 sm=1 tr=0 ts=69fcaed3 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=7004nz7suiqLHAzt4fYA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154

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

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..6ed91cccae2fbf0723629a4db12d2724312d50b2 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,35 @@ &sdhc_1 {
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
@@ -512,6 +540,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +588,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1

