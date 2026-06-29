Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2143FC5A2
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723357; cv=none; b=M5hqzyRqRc0OKbaNjKZGCFDA0yvVDOoBUH/F5l9ed4dYkLmHdJIfhsq6f3FfxJqwgtWfCZ0/yScIhLuFsXHoROi0rMO4tMNK8WjIHF51nLyOl26jOqG7WYrZws3KjfKNrGgfODz6Ivc9ijveOI3HnD1Fri51kD1wKCtvkmRNg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723357; c=relaxed/simple;
	bh=45LaNgBPxbRtyHZ0FmSbWF4XyTOkfAE6p0u9C1oK9dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yv1c9i3RXRG7djZxaCAII+aU4LvUIRkJPiVOtaQxR1LpdDG9lJlI/ppRlNjiTQ8uWA86q0jPgWA2JMNYKICAnqOOxU0yE5lQ0vwHExdb3kT78GCfPmnRRUsXd7eVqHbniKgvHvABflJYuheBYIwybybGLsmay97Cci48hbrD3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iq4VWTls; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JhFJ5Pfp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iq4VWTls";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JhFJ5Pfp"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6qwQa2076275
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=; b=iq4VWTlsEF72+xeR
	4ttGhDzRIivrHn8pUV919TlnjWQskne00TWo/B6pv4C/c5TDY81vqnrJHR4XE7oY
	THxmHiVL61ti1m5iInP+4M1nadSovvZzm3ha+MdheyY+dqx8/d7EBfICmYJVcoeo
	XejDAXu55tkdsr8/EuMbTaqJIgRHXEeNv6EZeFcqTpVxoSLZ4jSI8FM5Us8aE6TZ
	MLm1hyqbfAdaBawkp+nFNEd4bFdPq+n/ah3AdtCjKbEXPdBIYP680DXc+odHnxMe
	+dHBQEZHsdIMBUf1IMMKwqN8o1yg8hGLhkmmlwh23gvMdLBw30CLGe9zBhgrN32C
	zXF7ow==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7gh29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:53 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bd7ea84c73so4174277e0c.1
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 01:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723353; x=1783328153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=JhFJ5PfpGSdedGHhIMIkd96xfNqyb5vnQy0iYqaOarZZL7UFNsP0/vyIyEdcWrSSTd
         qWDNcqvwkQqN1DzovU7n1ipla9428RK6aAsFkqIe6BOuZoYhkXHUKQ+fLFlPOo9A7T25
         pqd2gwkKu44jjv0UAnsadhDrCZ4L0J/FGZDLfIGhBzz8paeXuRHNU3BS1qD4AjtqEPzi
         lP1FkZ6Vhv063JrQ6I1maFM9Uv/Gcm2TMQY/BCgK6hD7bMHjobyDT64ELKM83KDqQO8r
         AJXcUSbxRFFTMpmUImm9j9wz9Cw22KU71cFmHJmXatLfGhKGfCjNYmrvefMrmwn/RNQH
         NwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723353; x=1783328153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=lsmGCJ1BZgxy2OaSR82jCwNaaTWx2cP6aHcj6zTbDS4z/kqh9pfIEj1FCPLwBSx8F7
         YTL6ADkzUWut3dWn1IALjw3cbvqTkMwEmSuIjJW1jm4NpWQZDJH/rxrKHOWmZeEPU7ND
         fiPySFWt/pcnnuiDxysZ4ZfeIRV4fmWQvbY5Xyc6p3DOn8GbTTADeSDVSGFLf8yRxJYc
         EkZhOv050aPM5HPtyKQ5W5zirhvCsyjWfb5OHln/zGbt8n5ylX9iq6eP9Frtlj6I1dT2
         NVJC6S55GRFJZoQJBAWFkTPI3DjDSwEtRan/uZFcPLsJMxIza/u9nB3IIuL+XwkH7wXq
         oNAw==
X-Forwarded-Encrypted: i=1; AHgh+Roe2XgVhcLKFKxyD2k3HucpLwc0IDFSkp8a7RwNiMoOWrD/807emAk+5wjQcJq2a/lVHNkCsYJt4tb8iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzadOOmJUc9dgrGC8QnSZmrxkSbnbifjhevPImFHakEDvc0s/KO
	jn2BYzi7QCtc4fVWI6TMA/gZ5oDM2PmptuDOVU+/usdjo5+r6rrBnug9x3R+6aDDRERGTwlhWiA
	iEzIEJ+c++grJcri6cBDDh7SxbQdlJRfG2DD1/m/3ekt8WNiKzJGrEcdNJauyoSU7wA==
X-Gm-Gg: AfdE7cl9bmM6Om8+RK8cZ3sOZTSPhP2vTRHtEKbqP5cuD55CkgZxgRDFiMIo3miqL8S
	E3NKsu/HepnGBI78pY2RBHoQAQfCKqjE+bbYGf2Pf3NtirRNkBuu6hMOOCsCfC+aexdGf7/a4eG
	ZXJRvQF4I1DhoguDpFQlo8lXdfGu1kAYMKWmmVRw1wgQvlKDDIhQmJqP4j/S5NNLF6LkTFYywG2
	0AJM1F3a99fyKtQTFgZjZb/tH9XohIZY8qIYdFk9k7xIMB2fuC1G9N0McZNsmCmV/Lu92js79mh
	LHRCXGW5P3DbA3Yl3v4aBbmpHIzmWD4T54o+0XQwn1nq5JF8w2qFO3qke3IF/Y1s5BvQEKnTlAX
	msZxjrWSRnDiferGUv42s2i2gcG2sAV010ADablJFOjg0mmfNyJflRsR5DQz1uv7wUWLSpswUGf
	ZOswwvQhNt+/U634VHxx+LAMKJiSb3gmvxJvYtEN+RlvQ/Cj+ZV6JO8E5H5Njan1UnUL0BYVqr3
	gKs4hCugg5Upc5kFkEH
X-Received: by 2002:a05:6122:616e:b0:59b:9264:b06d with SMTP id 71dfb90a1353d-5bc2ae3c4f0mr10167329e0c.7.1782723352628;
        Mon, 29 Jun 2026 01:55:52 -0700 (PDT)
X-Received: by 2002:a05:6122:616e:b0:59b:9264:b06d with SMTP id 71dfb90a1353d-5bc2ae3c4f0mr10167320e0c.7.1782723352206;
        Mon, 29 Jun 2026 01:55:52 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:51 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:28 +0200
Subject: [PATCH v6 9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-9-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXx0TVdpVBfZRf
 mndKwGp/TFHoXLEE1VBgftryDYghJs6zmBvt8v1L2yXBo5niUdHg0cJTN3yTQZN8gpbGPx+GkxR
 JDCaw6CeMppmE2Lf6H0T4t3Uq2jXClk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX556MqTwQUi+A
 ChtoQB6QyYlTh7dYntBjoizHC+F+4BPGob6zfPyRXGW+L2vGQK2Fv042DxbH7FfJg6fP8GBMScE
 YuV+EYXRyA46c7C4JnVKzlGAqi3oMQPtItBg8GZN7PcnzzPiCB34N7dXlWdgDbLh7KurCj3FHlt
 1kPNRPuYuzyFbuaI45OQJzuTKMZuZ21cjUJgUGlNMsDfoh6Y3wXtsbp0ZuDKB29Ym5uy0vYkz5u
 fQDOP8DgKtxdbFs4hlJP+orKXZopdDpKu6SfgjSVrquRih9Kd9COCi5DrhwPID/bR5/7MLjuKoR
 QSq3Oq5LyVquwp5FvJRP1p83ko7RlMvZvpQcZ3HZhChm46b3392hPAQNHa7BuGV3T029JjvsF27
 90j1TsUjOxqPY/u0481dpROm7mTYjI+OYckb6TBTOeEoU2CADlivvijh256D1ZlWUJl8ryWFNu7
 RYGwEeqlyhZgxOiDC2w==
X-Proofpoint-ORIG-GUID: jOLdX7bDBNFdLWKOePt0NTJ0NKHuhAmF
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a423319 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: jOLdX7bDBNFdLWKOePt0NTJ0NKHuhAmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

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

