Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986B483819
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027159; cv=none; b=QRqNGj83Vpz6DnBNkmPczW3A/j8dcGdtSIh4i5+kzQP7B31FKgCQLUdMG9QXuKkHE0yNvP41iHetpaIlU1IddldcH4D6nKKMh56KLn1Gvgkf324v/rFZyZF+HHVPz3cQhbkiLsdUHWYVXtHnziOHx0k1gh5jS9VFXc+71XE3iFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027159; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gs8wYVNRLoEI6z+nZIU/DW9kG6N9Qs7OmGHYibeardNIf2g8iJy4i3POROlcOBCcy7ZET7bTjsqC0+AYf9wEKaX/Z8UVPmg7SiD0C6ANe+aNvW6gkPdeGvGZAlqnrSWNomVeGTB1P+5MY+D1vUyU1edJP2DVPRrMi5m7uYvjFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dMUkAwfR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tnr+iYDY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dMUkAwfR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tnr+iYDY"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nhlA2104907
	for <linux-block@vger.kernel.org>; Thu, 6 Aug 2026 14:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=dMUkAwfRDd94ITcJ
	ThymBVvr/uAsEmhYltnLdBgOLtGCsM13SpU7I1R+KHqilUROU9paqQKO7XtDhetg
	PVBuBjYCGdqam8jYXxy5T/qiV040YQCsxhS8V8vB3mRVIEMRFD1a7zWxDwFDd5m+
	sK9D1RK+Tyo5YQvG5VFtoS6aqFxRUjKyQhEIRIt9fVHW/zuCOoXKxpJmtDhgBncg
	ePMBEnGgV1mGvbRdQysHF6yLqNCKv6W3k/MIW5i/HPTF0aoWIZzQvwUrhJ9K5FnQ
	+qqM8x4p5DhndF1jJL0mKHQ+9Nw7DYmRDAS7S1GVjh2lH9CSBrg2cKAH4yoL/jNy
	CLLUpw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvq731kq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 14:39:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c20762d21so26070351cf.0
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027154; x=1786631954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=Tnr+iYDYkzUXcH3Gg/w4Yw928wlkOdJHjzUauMzjBEsa6NSoewCsOfDzQiGnNNQdA+
         /78cPEVZafgfuaAh+Rb89r3gxmO6Ftr6Or/mrHHC951Z3H4646+yxiLg5BgDnNRB6f9i
         D7GOhSehre+ReyV5/gWEnjxm3/I5pRuAUkwGHsn1+AG2YzWT2LBB/1yZaZFDYcaqS4xs
         K1k1qHFRMxNFUNRN/FEZiTno5t3BZXQRnM5f6PCIqa7xkCV/k8w13wsY5mPqI5a/qW+9
         1iFhIpge+ucLbh2pdhV0oDU7WdHUrpPTttWE+Oilhb62uzM6L8XCxYtZ7zU9hVGTcihw
         Ix0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027154; x=1786631954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=bzzadYsHV59m6kvVkSOl3eO03yp3Jy82rHIiHdB53raTBJ95qIE1J9uL4hN1JxWvyN
         /P6p+O3igI5fdh7f20kzd/NeXhrBHc5UA8pjutRbiSu5abHYepHvAr1g4fXa/q8hUxKv
         gt99QkihKZWZJtRKK32ZzvH+eaIMb4UYjaK/RYa+J+0pWtJqbVyoydUOfoEWcgkXo5hk
         SuzTSTR4G7c0MFp1kGmkdzeDcnjygCxBkaMNMOWerYOSQsg6sEWKi/8JIbag581kjHER
         rc2QzMGCtw+SpRSsMySAzzC5ZC1w9yHqSFd65SQs+ynkWKrbMZEUGqr5nDLN3wngHy1X
         M+iw==
X-Forwarded-Encrypted: i=1; AHgh+RrDWBJLeW9KYH/HHRyphaBNuh68qVuovAH8iMaoG8xtg4pAYe7pdEiJGdkJXBqSrK87gE+s1gn6WCTY3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6GkwLie2LmecbhUd87IeHHyd4krWEMVqklxWqPD7povHFz1CO
	s35mbE4WB0VRtwH216pY0yAX4xDNq2PuTyx27z9zjipeZ9FXTqc9kX+e1SBTAolGa3QWUPpHKnL
	5mEvjbNLYlvbEIztc0ZaHcataMtWoNoSNgm2HURdv1NnivMWX6IRwZX7XFQ3wF77efA==
X-Gm-Gg: AR+sD111cwg2UhQAY8yZBk2lwt48nC75aIjyOM5f2dm/uCwzXtK9Ttct902BqZK3NEQ
	dOevWI33nEtlI8C9uuJn/kpb8OrL32VOMHdtmxOE0XQrxi6dWq2WneyB8x74tJieFO4M8sjVdxZ
	Lj4v15KvyjRTgZdO3wPQkTqNiCuQpdqBL+m1QCXIFU7eHFOIxTMdqcS1XhGhTf+opf/hby8gJ2M
	BbXnJ30wACR7mNEqWjAGvbzrHyMEy5F1hm2nkSVl8q4mml/FYZW9xtxJME6wKkjH2CLQdyyiGn+
	gjG5gUMUASq0jY/SA/riLk2PqWknq55XErqWqXBk4xcPgBfxeEFhG0PbhXsA727VfqhgUjF0Hz6
	CBvpTkbYJlcn7Bg/wRPPksat7XoST9G2Od6sYpDLw772ASoOH+Mr8+e8ivLqvw2iXdFwS65Y14b
	W4NwkNGSb0bu9dhNHjyYwsULudrH7RHwMtfOtOKYqA6STWPTducw==
X-Received: by 2002:a05:622a:1448:b0:517:8f2e:5d97 with SMTP id d75a77b69052e-52ce60c07dcmr146321841cf.22.1786027153961;
        Thu, 06 Aug 2026 07:39:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1448:b0:517:8f2e:5d97 with SMTP id d75a77b69052e-52ce60c07dcmr146320971cf.22.1786027153456;
        Thu, 06 Aug 2026 07:39:13 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:39:12 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:43 +0200
Subject: [PATCH v10 10/10] arm64: dts: qcom: arduino-imola: Add NVMEM
 layout for WiFi/BT
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-10-be598b2a5606@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX4SOme5d7vAUQ
 0tuh5bJ/FiXEdvSgnoSBs+U/IEA7dmGYUGpLabUybx+4Aw8kBiqoVXXfiIBRUp0SMvQr/O6HmTa
 tDFqeHHOfAf0P9mkheTAKBfFqhS/lprwagCtSPWJSZwO8y6HtzCwab0xPSbbjhQM+bo/cfrIHZm
 wMJh4QkzXT0lwk9roiihTrqxSbQwlrHcxB7/EIs5+0lx8gjUMPOedqpbVCaL/WzTxS9EJPRp8Xn
 QktXcdZWVmCbZFcPP+U5ftaikpAJJXcYF3EpEIOcDJo/GQv8nOaJzBkzn46ZJOLczIjgqP1P5C3
 iquhB5G8FSv4hPtXxSnigrksh9vd+bow2jkvfA3iF8v/YLoZU6JpzgmvWZ59sYjC1MfEM7OLPY6
 yPQw0BI9h/ma0uDd6CBdEaSFaWwjhcwmucotfR1IsbAsY0vLFzbuC2SldGTTyfQg+isuRvj7d1Q
 nDoTO+i6eO33wJNXcvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX+BCHh5lP+pRa
 x39BkZqGL6IkBEMix3Nnld5SiNLNNsC8pD53SjskhvU7JTwYEBEfsdHZQ8Iums7FW20FjCfRZdp
 kgAP2edXGRPKvRtAfR7VI5g8LzqTTB0=
X-Authority-Analysis: v=2.4 cv=EeH4hvmC c=1 sm=1 tr=0 ts=6a749c95 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: s0ApyuOAUnJf8bjFiqzGYRMTNOPcCuRR
X-Proofpoint-GUID: s0ApyuOAUnJf8bjFiqzGYRMTNOPcCuRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060114

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

