Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321E34D3A9
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915862; cv=none; b=q13YAnfFMmdz/eQ0KO/Kh3rXsAENL3HV7UP7hFYN7AiTP44nzlGr1qKgurmXmqVHQQwrtTHTUcfIwvi0UWTpzr/U3njK7eNC1WPPixq9zjcntlk3oC0jh18LSOifGDG4jc3Exoddl2DYWF/dnN0iS+Frk4tCLUzytO8NQTRJUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915862; c=relaxed/simple;
	bh=bf+fGbp3y5sGKr3yiqtRUsXOaqQPcivjwUqgTaaStbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cI5+6M0wKY8rKBkqzba+DsGjkDk6d8HLw6satN6E/YEzfmRtRcz0uoeX/lT9OCVMCogWHCPOD/ZmOsOPZLdAO9r5ZWGVzOydgaiibpCmy1KtDU/xzL39ZWM+DxDxzwrp0Zj8FnUegcBziq8o9En+nJycEyZjIP5T50VKGpllm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oSQbd58T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cd3eMqiS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oSQbd58T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cd3eMqiS"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658A32L02882855
	for <linux-block@vger.kernel.org>; Mon, 8 Jun 2026 10:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qrd8MOMRQbi5cop8RgeayKocEI5pMrJ+hTvcAwk0fUw=; b=oSQbd58TS3J4fPkh
	D8NBgfSqRE4G0ju5YPyk+rMa9ZL50PhSoGPPrFDDTcZhYBJDZEHkCnYuwgTMaYL4
	pjyrt9NcmgY7izp4qSZiL96gHSu/39EgZVUcTY/mQ7dtlF994wYMaBgULVGyyINL
	cST6PqqkX56lHDjQ29ZOstQ64nLHTtjSDmkf0UUjxxcK00WQaVUKDXf3StdVFNM7
	lqfpuRjiaPZ111Q1iRkcG8e0jN/7YtRnHTTmVU6M3l7EEEzzUzYBChpcrjshQPMX
	xA/Lop3FruBRkStXGV4C35JvHQ8SjJFhR2ncI8PEpNUVvo1dhNXaToiaV+CDYVpT
	UGb2kQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun406k0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 10:51:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517ac42d958so31447591cf.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915860; x=1781520660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrd8MOMRQbi5cop8RgeayKocEI5pMrJ+hTvcAwk0fUw=;
        b=Cd3eMqiSdB+j+xd0Nxj5EnZKXfL1RuP11PxjMymYdCo6qtcgPXV4P7x12Kq2lo8KY0
         1IVA+IW7jlw1NwvzwwzFASm7HsUzcTAe1oDxxB6wBha9GV2uxyXebNZo3oAPwbzXMPhT
         esKw3ayrDKf958vGUbNEyT+ZmvUHR5FpE20kH/bS5hnmcd+C23eQauHyc/+ZcCJ98e02
         EYpcseaE8zeWVJhDFJDEG6S+Hv06GiiquAxEgh37z84SLLVr88yg/a0lyfQmImpK2YMP
         qT5mOJAsuN3UULKbVnzMvXszTqHyn2j+CM+NqkSknT8Bt1AQvhbiPnpNLPGSEdSmQFLs
         N++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915860; x=1781520660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qrd8MOMRQbi5cop8RgeayKocEI5pMrJ+hTvcAwk0fUw=;
        b=bGUx90tolfaGz+hJqALmFPxG4RdEDWLzll7qutB9bc2/7V0lZG+AgiEuuNEVnaN9lx
         ZMTHqEKJWQ2Q61TE14dShoh2GTlC9b8Fq/mp4OmuoVtKv2A0zRj6iAcfPXxUf0W/kmFo
         LRWj6iV7ocgKyepD/nymxTjouHLiB57VRyI/B7vxspVYrzlgUKlMfTdq65NwF1dMQCL+
         s2gEAdthBxkMoDhqrdbhU/Wnaz5afjOipzmUSU2T4S6jd4x7EXIgakFRoXXsxxZ3Ba4v
         AL9umZmQbiApr2mmpTjSM6BSCu4JH9If6Mb9B3UETzDLKWEfUm5pfIfQeU0q0eaJo4le
         7GGg==
X-Forwarded-Encrypted: i=1; AFNElJ/UIyTLKlxDdSFa7hfkPd6SFvYow7ybUWytQYBrQ+vEg1+x5iITEoY4cYZp4fLFZlRB9z+7kyVbm+xgOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8YHOeFexC9m/aG9c01qBfVnqtwTWDYBBEEiDI9cAnKNuZaEr
	Z85MePx3ApPktLKVbKDDeS8lWKmS4O2Bev2zDchKntGSoV2IFSTxpQZgTxIiD0UoECP+z6lWxtk
	tk+Oe2I7UnQnm6e2G/uS3f6XqidC8XLf7WSXP1C0l7StiXefftbZRkT9KUh4BnWVeqQ==
X-Gm-Gg: Acq92OHp5e5ybYXpfjBA1+17sqI/S4MEczcenGl9UWrIL2JeVVX8Jws7Kk6FyroFH7X
	X24J8Z94dMoSpgurtOsw+iHjrwniH3z/P4uyT7DH/mzRICQB3/cMl2ExdMMxPN2U26VFeW3S3g/
	Q3aUh7roTs6HUNhJx9Xv3MwDMjGfao9ZTg99lTPh6K1B7GZWnsFpg7zbsk/UW1D81ZnHD8nhO31
	N5xat+1J7rBBSC3UDTYX8Xw5hejmFA9G9dAZUw6w25OQcWLEWUA1GdvgrDbHsBoVmiotFvrDtEm
	o5J+uLtMbebUzhZGc1kp9mQ7du2dk0MB40YLFidU17D72gvpp5EC29LsivAUqpl/FwMROxglTtF
	JlZqSWd6hOPB3gzu69yBe8L8mNIqBhk/ajHXvP+EKZ9mAJJCJERkQudyh3kuVfAvt5I1SkmpRHO
	+T4HO6U9GIx0klyRcDoQ43eShPYmun4GiX5HFIjcCtMhg0lEYOx+T/LcCpNA+GZHWsFfShxlGS2
	y0Auh8DM433
X-Received: by 2002:a05:622a:514:b0:50f:6415:1eb4 with SMTP id d75a77b69052e-51795bbf29bmr200722541cf.49.1780915859584;
        Mon, 08 Jun 2026 03:50:59 -0700 (PDT)
X-Received: by 2002:a05:622a:514:b0:50f:6415:1eb4 with SMTP id d75a77b69052e-51795bbf29bmr200721871cf.49.1780915859023;
        Mon, 08 Jun 2026 03:50:59 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:58 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:44 +0200
Subject: [PATCH v3 7/7] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-7-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX1xxKSnYGTMvN
 lCdr50VRuv3/Nx+AnLOy7AF2SM7Qejyohh8yKLf3Op567msLs3QIL8nGk2VD8w/93oYvi7r0k4b
 yCdph0BcMYuEG7RyHVo1651azpbP2iIHVS8VQeIoZkqFV94SHL+sokHj8Rt4D6CpPqKUQ9YOWbD
 6S9MOxBxHuDcZL0M1s/rVQkPAUkqhqess7HUbkvGee7IUZcqQkKBfRHhEzEibLY3Rj6TehBCfcy
 ErjfZhH8s3wOXSWekEbVoCOu9Y28KRugudqizjSZtqpasffwyxhsIu/VcfDxAQTAldNKoWcYrmo
 x3v7cAX4ffo5eZNETYq5fRCCWEgCYIfGYkXfTI8zJqdNkoncGXqhVsHL9xnhF2OH2VmmXwjqo6i
 y5YrP8FtkUMUQXBQlJi8j4k8hrveURBaBy7+Z6kaDIVGttszhXvd8vZvOZZbx/Vur6TsfQahIzf
 V8th3HdEKbv9GTXKP6w==
X-Proofpoint-ORIG-GUID: 4xdB10z35GqI5BqNBmWRm5xEOPt0xKzb
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a269e94 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=lrwsl_vcuUQb-XtIoRIA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 4xdB10z35GqI5BqNBmWRm5xEOPt0xKzb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++++++++++
 drivers/bluetooth/btqca.c                          |  5 ++-
 2 files changed, 43 insertions(+), 1 deletion(-)

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
 
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1

