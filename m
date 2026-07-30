Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B85138A70B
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427253; cv=none; b=K+ID4zfM5GZjI8Q+Z+oBIRCYaZfQqr2ctE6LI7o/Fn+qmLnB+lmYzcZulWe+HlQ4ADB9jcsJd5iQI4nHHe7ZTmvztRmd1YyzUhbnsTxWX+mqdiyxxfknmfKsJ4+FklKiViCaAYOQd6cZIeHK+NVZyetbA3x2xJ5ksWX70g6MSMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427253; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQ7HcNrNrFF7Q/27UzwqaFLDsYGaU10smKxld2OntB6blcMQvs16FllTXuVxTY7mmEz9ZFjrciKo0J4+hBypTuuoQLr1ktCFmif0SpYkHTopITxL6EP6V7KxZ1HCaLQxWMQAsJaC3sydqyYSQ6oXxS6YW5b6iVAZTfKsAVr4Fto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mdc2lZTP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f995O6V6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mdc2lZTP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f995O6V6"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQxEM1023460
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=Mdc2lZTPtt0S03NT
	RZN2LLYKd+6xXhFCtur9/pn9KUxEL/qAs2gSangnk3Eojs3/CX2/U8oIu1o6fKhC
	XroQfXn6jyxAvPOItfTXBxB6a8IEK4aVhaevupkro8jYPxWKsqEiumETD82FoNCv
	zojIrPoVqqom+od2/ljgKcP6kfMDX5SNaauAqJvwDWm2OmxejTT88jaqRV8dhhuA
	+pBxJQKtP7NAOOE4f5RoZyu1f2FUpYzK3pNhCbkmi4s+mx5iJ+i1z3qg4IrYqyDX
	v4V16C0fVnXQTebHonIJ1OlzTzv7K4oWtrb1v6u6WZahOxMwVdixSMnVEx8rgQet
	SXIImQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8n80e78-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:00:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-520a00c7a03so42155851cf.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427250; x=1786032050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=f995O6V6+l0ZkTnatqochmwWKk2TqvvIo25KbncSpPzX6vAL/qZLk39A3xv2u8la/i
         Zt4REh5JjVxWhTeNByDVVqZ76ylrsJVeXnjeCS4j4PIchyKUCmJ+IZqvQiaVki9tA5vs
         HulSow84e7BYuovTKejSUnOYW0HCDhYGrJaU11gKEX25pLeJWIVweKHTJSg5gYY7WCno
         EyAJsMM2Osl7b8ThXJn93hOjn+p0mCtzphUju/vHYE7MtINnLm9P4bAhMP0UeL2pk85b
         MbkLiE/HGRX2C5cJg6HrtjH8txlroZh/wFvMIMilqiHs/ZFy74Il+6YvwFW7nmSvNAS0
         SuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427250; x=1786032050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=R7ShSFiN0zqWjIocrr3aos3uxZGdr1v0fcQKinyNmwtNnvyrVIa2uMIoSk1k/DREuZ
         mtW206UaEcd+dDWwuqTFdxW6B4kc6aQUqcMGtZ9IpQ1bmKNu+1842wS5AFRNlb7/R+7D
         Y29dm4x9Pla4Zp2mPrdDDDVTiErVa/dCBmmA6CuFdAf31j1bkOXawERR5c+z1XTNRKXZ
         v7T7pcYjtB9dPPSd3nP9DIHxklfzGTc4BeylQVKd1/2V5NevlzfGxAKnlqfajLWEq9qg
         Z6un1KuFMOti6KgKyOdgplQzythR9I1pyS6oL7QkjK2pUBpH7pT6kfSOI7LypO9Um3sT
         asrQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/PUNH3FyKOE7H6uBvCPH6JHfqYxCeniLtAJwaj6IzaN0UhSMsdRLdzjYd9MaY0gCPAIVIFms1oSv2uA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZbSHRGD1jo64GqahmDr5MoNwzbX+OvXf3AuxIG2PXvsx5foT
	fsSpkfqWW7EuAscVxL79Bk8BvFS6RjH4sLOvVjtOu9zZ1tXvDKiq5C0TR1pqKkpt4AV7N2+hPrK
	QRcERvNIt+2nIbpZolkQLDTLLh1EcqeCsmic8nFVeLxRNjOlDACd/DzsVVgqisl5hag==
X-Gm-Gg: AR+sD11sGnyp9b7n+Uf+7cZoik7QbGWWzXtsWEOpQqAHcrbCREFf1YXS+eokmoPPcy2
	FUtgDiRvBb4sPfVWIDSznp+E1oFTYzDTGWI8jSGYubn7Z/3WNmfkGOCmQBbOkwIWLbtlpnnoNn9
	jNGAul1E64D1kCOo5VqbRmGVh2/ReLR02In9Qc4xMRdg2HgwaNvWIzRs65zqS9/AykOU06KpAJ5
	g2D1rQx47UO3NLEwyUYmutktzeaIVuvZqV+ngLW+XkItUHCjDqds6uLtN4tjHu9K19w3eD5oOgL
	Ihe/I4gdWhn4b1tY0v8iKEM3uGLdm9o3cgV+GQdzXOssj+JRZueLENG4zhOJwdxOF7A9QCQcmos
	TP2pCjVjmqxDxd292X1CB4PT9Up33KFVMdTcS0mqi972IsKC8ZK0pqh5D80bqYc6CrWJP0YrLl6
	RnTNNyZJ8mMUVlnv9+oP1c7odbpnxNisW8mAFctikTKvkEdVqLgFtz
X-Received: by 2002:a05:622a:1e12:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b384c7d14mr37918411cf.27.1785427249446;
        Thu, 30 Jul 2026 09:00:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1e12:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b384c7d14mr37914671cf.27.1785427247300;
        Thu, 30 Jul 2026 09:00:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:33 +0200
Subject: [PATCH v9 03/10] dt-bindings: bluetooth: qcom: Add NVMEM BD
 address cell
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-3-f72935817dbf@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX7TgJGs8jmhJ7
 jkmkinAUaSmfsoq99b+2PlVJ8Ps6EkmenNYHbtX+HCgoq7XrSnnhSpIrxjPeawXqfNLtl83GD1Z
 5qqmZX4OSNQQMPvgaVBWnGRjhqLhHsb1YqT/fvEgQdY3SOAfd2U2z71NeJ/4Qv6lh4HOU/IudEk
 07VyPPvFKbJtXJbgCpvLs5RTwHjDtkf9LamkE306mImkZujBCeYFT9PRJrdZ5GZxEppewnbSPkx
 /P+TsA3tpATUR8W3BCWHCIZCQO24FVZdjQDP/J1pXWGfenDHLjwOI7UUhad1b1H7BvGtC9xDqjg
 kJ1mLFIqhXzMFDSxmMwBHZRnPFET/gfoiBmwBfpJgvTFX8pm4dy+ktluV27bk/TRgs2YcOdC+sW
 HQbvk+9k7RHhZ87AhWm7S7EBU/dSkT9ltUVHL+M2YtPJGRwymre6KziB8Ft7Mo2SUCe27uH9yHU
 iHlJsshNpVECubSMozg==
X-Authority-Analysis: v=2.4 cv=DNq/JSNb c=1 sm=1 tr=0 ts=6a6b7532 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: tgVb_4P37TnqcPVY4jbpvABW0arW3VYA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXy1w8x982VqIA
 hejAjW7MtfuGxuvibC6Bsd3kgx4SnpPI+cYEaA5PR7aQeY+cqi3TNoVBKcmvB6Ad9LakpW0/LTO
 BRtGp04N6lFTMJA1AblUxyeleOWvX4E=
X-Proofpoint-GUID: tgVb_4P37TnqcPVY4jbpvABW0arW3VYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1

