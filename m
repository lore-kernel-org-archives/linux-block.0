Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B93E5ECF
	for <linux-block@vger.kernel.org>; Fri,  3 Jul 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086351; cv=none; b=AAq89Y/D6OHP0V8PhVgR5og2msLCBTekom4MxaCbVsC911jAF1bllv9Yfn1zssUu77FG/6rKeIBelzG0bO9pHQhtXeoBNey1q2rGFvWvJtx6oRxCmJQlAlPOpR/e6XCcaEpd9GYndRlToWwebQd2M9hIVjc9ItTWbQoSBxYh5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086351; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGzUEaAhYHlDprgmdZWMxgGOUEW4NymgPDQeBIY5mAQHDBsAS27osKOtOcRalII30F3a7AT+xUSWTvB0abZgSU+OvM67UvoFP3rz3/QXaRBvj6ataWrs+ytibDdWL+46LgLF4gOD36fgVpfxoFY+IYLCSn74S3lFFOHVA999P8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m3ZeXph0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MfzaYzDX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m3ZeXph0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MfzaYzDX"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BITRX3108960
	for <linux-block@vger.kernel.org>; Fri, 3 Jul 2026 13:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=m3ZeXph0qWHngde4
	cyKZge+jjCK5fC4rR9gZXCNMwv//46MvW0g5T3GTreKkoX81ZKjiGv2oAyBuI3J8
	AWDZ7yFrfxrLeyTltJ6MAyeFz1owlPAK3WMFy1/csjR+M6n+ZtfDY620VL38nM2h
	dJzUsWvGIC8BIEz8vc5uDQBGjV449EYxd1mORNaVVPAgD7kyEmii7WOT6T9SJhFF
	Iqhv18Qe4JGzwPqYT5En9tvzwEm++OlruahreWLUcXWodo6IduWS6YXkoMYvuwbf
	uX59OIdL1VpqYEIRfNysL+zWXfKlJDhp6F4c49B1EP5NfVFsPBai7e+vDDgF4gD9
	qOUvdw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eybabh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 13:45:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-915c364ae3bso54075085a.0
        for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086346; x=1783691146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=MfzaYzDXh/mKrdEJnjOkXdyXxAVCSWQr34fv6GSTJAx3m1PEV+q9LDmM3roX9QEO+r
         Wr21a4BGCMajbUdW2UCj6gSvDlyh+T5vkoAsIOtIZ1sGLmT1PsYIlPt5WYZIZwj/e11D
         DdxSxo2J4PMotXmvXEDSV8O6XESSsHyTnX5oLNOsTHe0bx4UrUTjShLNwyHwPa78a3++
         pXOWRxdXtYawCHYswASLApm7Km39Onblk9K60wKcGRj5Ft1FWKis7UDQfZWbGYaMs7/X
         rSGuv/0pwWvia8dn1Q/MRwQcfAg+Xg79Z3acLyzdd2FlYzmZyXwSgjYAwQoQM0iQK63H
         dhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086346; x=1783691146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=Je0lsiooua1dUMYD12QQR7LejvCDqQdzvZc90Yi9darKoB6Dl3uUHs/X1iRwqrwnQy
         pBtiDfMEd4Eph2wmnyphq9y5RHnXEkmW8waIG6ST6i9TfvcoJ9ksK4+znaIXnmZunKiu
         YtTn45Evc16tiVr63X8gsDOUQdD8Yvp9Yq5tZy1wL2xHMFsnVTyu6Cf+YYKRsYomPUe9
         eo+9Jt6ra9WqxTYnWzyoD4qIv8tirszu3OBUf0s3y5NZJ2t6I+o7VT3T56mSJd0FfoXa
         g5fADlwM4Ynx1zYvu5i0U2F+k3ZJs+ncGUL7wsVYB1pFgmkQMb1FpInE+UMS2FTdlhOK
         2apg==
X-Forwarded-Encrypted: i=1; AFNElJ8k8RAkO8AYuK/f4FkRQOxE+nsnvagpFZPh85iQdUiyZRWYT8DR3Uedsi80HI09uuHiGky3YdKOP0g33Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hsMInSWWLauU9Eqjv3htEyTB6RHCthLkkBfxM0UqrLt+nMMq
	CaJR8tBd8jGxuzEPlfq9+wqOKhmb2926xaVBDxDkf+ANyVR7bF2ceB6XCeHDkslaBF/rO8iUDtw
	0DYHYCy7/CKIkIVsE7cxDf8mmdljkWGUcO9gJB05LkB7BLB6PKIiPxuX3FenFvNu9YA==
X-Gm-Gg: AfdE7ckIMmAV/Xl/ev9lfz0x3szBJr/Jt6VB3Fg06sAJFTwQap9Ss5kcRAt73HVuGvX
	MWP3PzH3urwxbFI3aKxUgXUUZx80sM7LeCUTkB+ldr3oRuvUo7lG80gWwIHavFWw2h7XBfO7RiI
	GTS5Vea/TQg8v4CVZFUF1ZluUeQSbanreZ+8QscwCgBsG+Nv8wzhJfZ6NvijjUj2UwAxhB3lKYd
	/PsYP03LDYhlJSa7tUsQYyOjRS9DIATTgKQnm7FvS/xzFfi0Qoo5SB7KWxJrkaibhq0wxekAVg4
	PMZHeZZ9WVMgiH9BppefxnhevvC54Oj54cpG8WXhSvAgpzs+7mB+TAsJnhiVjqXDtOZOaYH3w54
	YfmLa8z+nEvGwP9CaAxfzIB/JjjAMWeVYmXvjoWpYIAbhphKmhVeWJYaN7ruRz3tpjTNJ8Q9HU5
	UgbkZo/N3p7lnR1DU6sHV1cGHjJfRiQfToP2y2bR7UciaILnU8QWmOyfPlWso0Buo=
X-Received: by 2002:a05:620a:3186:b0:914:d093:abbe with SMTP id af79cd13be357-92e781d3eb5mr1407959885a.12.1783086345687;
        Fri, 03 Jul 2026 06:45:45 -0700 (PDT)
X-Received: by 2002:a05:620a:3186:b0:914:d093:abbe with SMTP id af79cd13be357-92e781d3eb5mr1407952085a.12.1783086345170;
        Fri, 03 Jul 2026 06:45:45 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:44 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:22 +0200
Subject: [PATCH v8 9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-9-98ae32bfc49a@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX/sfFP9+Qw49u
 VCa1ZfY+Xt+rpAAnzbA3QN0O7S6G/Dy5g+1rhus26iJ7WAAfJ+9pnlc8izbq6fE68i125ZAI8VR
 R9XhMjlyozlHvhOTnOG2L999cv+pigsZqKzf19UjUX89fhLzDOTqmcQREi55ZbONbr/i0DBJsBA
 YDVnAAV/cqn/191hQHyqzJDs6eCivfCmkiLSszbiO51fQnSr5vESQ/8db8AGS+l0o9VsJWNd0U4
 i82XWQlf4BX73s3SE6ub/X+b6ZC/yc/1FB1Z0XL7lpNxK+pMXoGhfmLaCGm+PWrCcm4XgDZ13Iq
 +JkgzMFuLJq5xS15zPCcjRD9Tni/p4f7MbEsE8BjMahZQhf5zaOW4SXKrs6GPOoeIFdWKFt56J3
 Ong93nnzpn1fcpnzZ5kQT9rvsK2TKCAkfjA/lYr7Flq9m+m2Pu79B9tFxa9EMb7CF/f2lgPhppW
 7hXCPMXnxCE3qRotTmg==
X-Proofpoint-GUID: ZNyPKai4iJRQhcRd4WVDuZqF7VC_VjCM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX8SAx0gsCW8EP
 1IjUrXRL9WO3yoPBJ/WJIy3XRRGN2Ivz8TG8ww1Plppx4/+OVSSOhjrPpGWXOr1Qa/Wdgek1QlO
 gF0j7r6rlVDfxrxtOEP7Dsg/o2AMQu4=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47bd0b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: ZNyPKai4iJRQhcRd4WVDuZqF7VC_VjCM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

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
index bf088fa9807f040f0c8f405f9111b01790b09377..38839b8a361e76f6c1989924b16095b9d8815f66 100644
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

