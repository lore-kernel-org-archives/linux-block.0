Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918A466B66
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386222; cv=none; b=ANni+RhDVvPA9kbOXd+74donqCAwYGPhfng69GY4uIvWVwMinLa9PoyYLWwnDiTNLAsXdgnc67xfkKYVjAr6iUiDTkxjqvf6UZm65eSQtc07T4CVfpELWycZPL/VzLM9MLTcAhwmNd0rou4N6rft07nefPIK9BpI3qTxpbf9ETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386222; c=relaxed/simple;
	bh=n11bfCJoefHvmThlP8x1PiTVeFVsEIhjZBpXIg5IZ38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q2mdny+YqyyB93asXwHg0DqT6mr/LkKzPVdl8/Tqax3qOg85GkQ0+vYAtbK5oz1NX1HKu29NZsYx8LU/1s4cmdDtQiusPJPUnr5Tf9BwW2zGyrX1w+m+MqWwZxJglcENR4+hezMddA8eql1yr00wSMRb72W16ExwWFRjoAWSmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPGoa7ID; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W+YOnSvu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPGoa7ID";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+YOnSvu"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA30j0985224
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w+OP4W0xAiPDjd5bYE2eMNSeXnhE/RBCJAZjyE4cLE8=; b=iPGoa7IDfNVUwgax
	iQmx3Hn13dlYxiKhW6NWQgJkVCcfVhWY3w1NXgiUS/AO4kbXtAzsbJqfdPE5LbOD
	aMaZdelub8/Unp8pb+HXCzEQBsR8xginxDxZ9BlF6F2PJ0wLwDzUrqo+sdtDjJgg
	8FcBPFGCgBaJlXLIhj9Wis1DcxlQZz6GYLY/WXYtai2KxqkaTJ3x+/fi70R8b0wg
	68KmHm/howOh5nqx9HVMUGO44qYYBxUDt6ASdrC9UxNoI8W+c8giWCAV02VWXESm
	vxIU4fZTShIm+pLIAwBfOkXCqylEyi+86em422/0qZen+6+ECfncdGkpPZGVtiQ0
	f5FCwA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttt2s2b2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 14:23:35 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56eeff9a2e3so19652518e0c.3
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386214; x=1777991014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+OP4W0xAiPDjd5bYE2eMNSeXnhE/RBCJAZjyE4cLE8=;
        b=W+YOnSvuSQQpqtDg7DbjYnpyTX1XJVYJf6A1bb+Ip4Lzf5TlttRBrXCT4cBfSlMzOh
         cqG8G2vRw7pI0cO5nxGwVAugaz7WvHhgx34NffLiauzyhVyyuq0Gs3/wFAWMFbNyeCvJ
         EwK+CAaAVer0/gZIm/mIR+MkRTmANRol8euvzcHeH+6GIGkuoKGVNqu/ULHxraIbgilW
         R+z4KLmgQM+9MrC7tnYGQ8P7txKvDzpsBg0m2gK7114Nc3Jf/qxwsbAZV2+tFICOmop3
         Y130KMSTgBPrv4LAPeWeO74xW8AEcgiOTieW+bcmucWcNvxwWmtY7hZ3hfAfJf1wbGjc
         ZsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386214; x=1777991014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w+OP4W0xAiPDjd5bYE2eMNSeXnhE/RBCJAZjyE4cLE8=;
        b=GUnTegS+BRlAUW+TYre7ES8YknP1RRzXrVzI+2GI/AtyqbiYzJx+QjqD3G2js8xRrp
         BpezbNbdLiv1qeFSTTd0MV0qo+QiCcZ34gOJtRpO1q8VB6uTJfNFBt4RMKbiYoRbpcu+
         Oc347+MFymh+xu65SAt4P+g3ZEIthKfFBXiIKBK/7HSqKl9QiAQZexewiALQbbZC+GSf
         inRsRVgyIvzJA5vvgOVe/xo1r3OEGqDspltzga7gJKMatjqm4XPKDwKOtTq/s+N3xw1W
         bDa3sVg+AQ6MAQe2b8FI+3DFw4Rzr5Y5E9k0Bs8whdL6t1Ctyx0w6NkK8q9Rh/7aZbU7
         KzVg==
X-Forwarded-Encrypted: i=1; AFNElJ97tk4NWvqW8rQJmFlTB33QeJQki6lp72+SiFOyqPgqs/ub4813+QrOfAb2Ot7ZV0eXq9czmOC0CHLUNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjymHYI94eVsGUH9EpnGcicF9eGkrRgWDfpwqiSTdTPpBWgxd
	b0cpAOeDkvqQXg+GudUn0zckiV/RqeqV9MKuHVoRJbgMEnEo8qbSytf4uMz5J+kXKDhiv4Lb4op
	9vWiHkoLCwA1nZoru908FOXwAK6EhXrpi9DvV+m0KxXtp7RXlTgEn1d4s3QicXqrJww==
X-Gm-Gg: AeBDietfg2BXWTOaYnb9Tyve7CQ+hqi1Z87lwRdDDvaBiaD5h5R07ViABqOF4cG5sds
	0xX/ZjQtzSPH3eUeo6N1LYmZOL7M51OaWNMTezrnjll9fTrNKHMLHO0Zar2GX/0VpMqUty5qJuJ
	Zlh6adpN1XhPVU0a4yqbxB024pZpKh+AVfxALJzjfCYq7I4A7NQk3364i1Y2UYHF+Ub9YJ59fey
	qO2Ys1oaxAu1uoob1SvflZ1dG4Mhgw1FjW++oZQsHrQKZukFcDzKp7/GDn56DEP13QlmuQXGMz8
	B1hH62dISl1mcYWNVbEqTv0cjWeRoqSu4NdI8SpDlIct+/rELtnz2GuNe8aOews0lQWT3OiStHU
	6Ikyp0b6gs9CW/Bwq536pb9Qy0IR4aYDwWGKCGzUoNy2+zFDM9nUSF/4YY+BLFYJi45ry+9730L
	M02eBX746UWBVAfqWmB82mpesqB+8=
X-Received: by 2002:a05:6122:4201:b0:56c:860b:c34e with SMTP id 71dfb90a1353d-573a55b83fcmr1687297e0c.8.1777386214583;
        Tue, 28 Apr 2026 07:23:34 -0700 (PDT)
X-Received: by 2002:a05:6122:4201:b0:56c:860b:c34e with SMTP id 71dfb90a1353d-573a55b83fcmr1687200e0c.8.1777386213784;
        Tue, 28 Apr 2026 07:23:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:33 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:14 +0200
Subject: [PATCH 9/9] arm64: dts: qcom: arduino-imola: Get Bluetooth BD
 address from NVMEM
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-9-6ad23e75190a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=HbIkiCE8 c=1 sm=1 tr=0 ts=69f0c2e7 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=w5cLSrw8bnM9wMX07V0A:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: LvuRdFyNkFdJ95BWZDpHrnURfT79IAyV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfXw7h1xWNYHXSZ
 F5Z9yk1zO0QnT2HPzB9+uAbWBM4Gtc/HguAZruimFdOZ2FHPrrq2jSebTdmChWUiD+LWcGL7SVJ
 BDkQRuuGV2XiAjxIMWx9LbGLs24pBglsUM0Sf5UWo0a2JaXlUWFj1d8BJErxDb2o6+RL8VftBJI
 ljf9Svj6wgWkeTrslZ8yecDQWF46MLUIkeqAKwJKww+dtNR8tJZknPZEk+Ai5b5dIxVTIQQsgfg
 G3Nv5QiZjKI2uICIjQ11CxB9vyyZNKyi7rMrcbYu5kXJMTGHtUtndeoMO365oArc8r1HNTwTZth
 UoIgvfJ1EutdZChZRhoheszmiDDlbhojfhuT4rnEsRhP8qgDf8Lpv8gVXsxIOKllTpXqzLajxPZ
 4k0nxDDIjLQeMJojye7BejTjVHWrAZQN96dgvBTpx0mquV2ouTkWUMOkqInP9ym9d111hB+Po5m
 CLJsAQe2Lw6Ao7B/6yw==
X-Proofpoint-GUID: LvuRdFyNkFdJ95BWZDpHrnURfT79IAyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136

On Arduino Uno-Q, the Bluetooth Device address is stored in the eMMC
boot1 partition. Point to the appropriate NVMEM cell to retrieve it.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index 35a30cd6f47d6d2e018f6841a05fe929fec15738..109fa76e05625461935e321e15dbfe6c7d452e78 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -536,6 +536,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 

-- 
2.34.1

