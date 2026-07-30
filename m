Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519B4519AE
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427272; cv=none; b=Wdn0l+Mk0HN3mW3TYs6bcTz+C0zflGJARlGTWs4oAHvm4P4ZjfIKIG+Vcn3cJdQ9Zfy8WFNs5zHPE5XFQccA8UbhKDVYvcAVgJq6Xy6SD4DW6nUgN4A5BYJ3mz/DNvn+u6HCcM3TtW2U3bDdSJRcvm92l3j1gtuSO6E7P03aSVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427272; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbTAIQwD1ZUmLxO2zLzeRhTAIl3/ckgX+hhARxpEdZOKqWD2e7DNC+FEmAUoBJDJALQ9x7xBma24no3Kho5Ui1WPBfAjnD8qLKlU2kXtF3g278BmMmwUWNmNknWx+Pxs3jL7xCa6K82UNKIx47w6+hCfH2khVbTcVQP8mcdtuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=otwBB6sT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XIlShTwK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="otwBB6sT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XIlShTwK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQrO51145129
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=otwBB6sTYEC5Pwgk
	p/a56NEtduZLgnFOT+mUbwZmBYWofu/93DrVNEGesvn2u1NO1kpmMFM7Y/EP7vAQ
	AO13YWtHuG0oz/mSLBXD6mnMuDZhFC/5pqiqRnorHsmA68wDO/+wRCcq4UppCqev
	eT2yaes1u/23RpAQDNO1tmdcq1oYCaPSMEpD+D91MJQ+xu4fenU/TzQh73qK61Uq
	/TMmMHfwvxlyPIhE55OFFtX+GSYHkNr1kolzgGL3vrQdxzMPiTOEwTy9YG6N8coe
	3oW3PLoWqs2jRYri8450gqjUbt6X3pksaQFP7MsW5DgGcw87aHzTbVjCx0BCZt0R
	EdMuZA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8k60f7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:01:08 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-73760a7cd83so1243137.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427267; x=1786032067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=XIlShTwKkzIdXOFPe4qBOVxOT70qKjLoLWam7/CFqhqSajQQC/2ziVqrEo4e8+YtdX
         R01D6MOKpV0ENW7GOFnOIMLJXcWn7kwO6Su1VLxgvpFKrbNOUS95xuBODdy/jJt7RJiY
         8zF9TISp37I+Ob7kmTkIwkdxYmmfQvX3dqMT5+DyUZjwo/dtlcYRYuO25uoNk52csb0h
         iTW+28YL3U0/U3eYspmDAtbZEFdkA6KpkrnxbZoQgl5+BNQne2AvnFQzGdtKIyVMHfeM
         s3Ma9eXf+JDkO5UPAHT0TsNp0c4wUnnQ7DaY7kXVY7X3V4FuldjGxah8FvlAA65sB+qp
         aojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427267; x=1786032067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=h8N2lpfx9QdvTn+w4lPlKk4mn+r7Fw/6Yci917FgpHRQ1j6izGGq+7H94UnrXfJHNx
         WyhgRX7+WNicT9BTC9c3nrPQ0HUg13rJ9c2RENQSp2AgJFZ/QysYXr9Q1uGoS4zrjcPK
         lyzPTY012ZrZOJ84NVmeIDB1TgytyfgohgT5OrcVBmuf6HahMGpE8VVRZK0XwGXm0C7N
         G9KnpsqmOELjR0x4Fi+0up3cqzWB4+gtMTebOED2YuiClLhrptv4TMkmm/wkM5E5u1kl
         u4OR+YD6ldNYUMPu66XTpo1YZBq2X1G3JAPZEkIJLvLYFf4Vv87TKF26iq15Nh12grJ6
         F+fw==
X-Forwarded-Encrypted: i=1; AHgh+RpSDbgPEfYGialgJg8nUgNcXznx7aVQBDhQvYqy5fBgd3WLnk8KyIqBk2G2xG4h4+WMUbOZpJqIWDaZYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/SuW8Ac47+pkfl8y2Hl1cvDgviuhy9lA5S6a1MOfIepx79hD
	86JAeX70amVGRJhytxZwkDZmXFESxNtaZV18oqfBCFviMGTjZ01D6buHqJrdHda8RyNCyNpoTy5
	u/LOiGhI6iXFW/CHZzHFu4hB7Vofjn+LQrOdtYiRSEKmqls3DD6IxrIHVSf4FWc4sZw==
X-Gm-Gg: AR+sD10KjDHQ4kXwBJMAvwoi9ADEuMOA2ipV20t/egFoXU2U0RP14S6TMR+LuL8fd9Q
	ZgJBUN8fkiXyEvFputajd5UnX6AICZz6FhkNZHpvEGX/POH59XJssEo+wt7jE0N3Oxhx8j89Rnl
	kwB5spcwe682s5sCVNSyASa09YyikDmgeWVi69YJyWPBdvSt9yiP4Lfh1XscfQ105M9WwV8Lt0a
	cvfeeQJErArPa5dJ4qpIQ12ltpxi+qg1CShep5AlOjWTvl9tlroUjVe0vi6ILqVJEyXNzXqbahZ
	2A5WT2cYAxDlJ4hZFD6PUx5gxzWG5gemw1fsFKU52jzLNBM9X1jZFvQX/X9oHyizjgKHNXJ/MtY
	98o3EO0URIstLLiKJd6GAQ3KI/b0bMyD1eHqDQBGytacXVMDbV9c3DWxm2NAkQv7VNIT/RRh+bE
	wW9URTCZqmWNr7J7KoZbgdumDq2LaEJHr0m9PknaVomSi82Uf+2muz
X-Received: by 2002:a05:6102:c09:b0:74a:84ea:4f6c with SMTP id ada2fe7eead31-7574ff6c30amr1313371137.15.1785427267064;
        Thu, 30 Jul 2026 09:01:07 -0700 (PDT)
X-Received: by 2002:a05:6102:c09:b0:74a:84ea:4f6c with SMTP id ada2fe7eead31-7574ff6c30amr1313267137.15.1785427266454;
        Thu, 30 Jul 2026 09:01:06 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:01:05 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:40 +0200
Subject: [PATCH v9 10/10] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-10-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
X-Proofpoint-GUID: 5l-2499dpzl0DgsZAWeu4h02WFDUzfan
X-Proofpoint-ORIG-GUID: 5l-2499dpzl0DgsZAWeu4h02WFDUzfan
X-Authority-Analysis: v=2.4 cv=Wqgb99fv c=1 sm=1 tr=0 ts=6a6b7544 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXwR4yBNRCvsgK
 p0kRgpCKr8CGmv+Yo/nftytfYMi38uWqP2XIrMUiNEdF/2Oo9d2PfISOAYdFOAV4mFTz3OHdVgm
 jbeEuA/qbI03mngSZJcHGGqyk0NWM/wDU7veV7msXhoGpS4UU4xG641gWWhuLwSs9iCFQF5zKE4
 RAAPQ5Y9PeSfecVSyVKP+T83gByuE10eNMtHG7rT+clzYjWLXDW29Em/SYuN9EK3BikuktnNVyH
 YNKuFifMAlKSoOUHNjA6Oa4oT9eyhova8veaDASaMbx3ikUrU0vEYTiVSqU/EKHyPKk/AvN7Ryd
 fxwjaKVRvq2sR7sTpdktDZfHKRxVi+aXZtBbyNc4QgWeO3YnaeeGRAdEoyBhlh+wI8ZVplAiY1A
 sFI4za/fNjgBV2H2TV+d9wUXezS1Lu0cM78Io4Flr/N8VLrK+advKONSq7K3fn60k5Npl/Vkllw
 iVW/A4Be938eW5/95og==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX6kXvdU895+Uj
 fig9BHw1J9kkbGxmAHGV9jH9ZHiMkYZP3VvAq00vztcEtRwzM0jdLwFZ1UtVvuw7RDlkkdMI9E/
 k5VfhY/meeD7Iv4eEp4r0nIzFFluqho=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

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

