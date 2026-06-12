Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1793EDAD5
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270477; cv=none; b=dx5TgpjjSwfjJmqUilpw5OL23PjXKEOTtBFGLyRl8Bz4I2LkOciKDHU/14ACGf9mb4e9ByRP5phiPxSCvhB90h/I+BfQCf69/Jr2gjNNmk3JFUdv2CdmMwKtl3qxTczWMWZclDdf5zYQ4CPzynlkDNqDGApwZHg00Cf1kve+xxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270477; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OkdDw4ROO+TjBwGR/cxeISpJPjECeMTfH0q8tACelIswaDKWxEi/aLEpC1lFtB6GUGgiQY10gQvVXHC4//GzA43VI+LuIbY2/NpRFpxnlQzzXa9yMZYDx8WgWbJl4wj5la1fdgQQqNnBX6ABHVZ90ds3gK4y0cmt8fhqxaAH588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V0ajMPkg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MXmJpS4M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V0ajMPkg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MXmJpS4M"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCitwS3692782
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=V0ajMPkgVJ7WbuHW
	I9TlAHw7olRDXvBREzCOJY+47G2/2sELBRvv3TzcVzlAfc9MOM4WhBUsBa7V52Ae
	TMU1y+/PAqFWntHUT453BmMdQLJQvUe5A23KHWzxScFUiGlfrzKA7bXBVVQDuLx7
	S0w0mfTBqJ2kMs0gN1NPXUtmsdVIVpUlUGvSwwaif2IlmU/y6Yym+nX+XKkq2J1Q
	CicRK2ovRrFlTN82spPVbkzbYMIIzr345jYykfUgHUHxfwrKkVvewsj3wb8tzzlA
	r/oHgyqUuGgRHHoOvIj6ATBEAMLtp2ry5rTpj7P0I4Y3ozHQkn0VvHEzqaHTDF1a
	TdbIkA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r5txh1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:13 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9639d763d99so357601241.1
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270472; x=1781875272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=MXmJpS4MDZ8yW2C1lySmFn4os85x0KqJs+F0EHHPa52WDcHdLSy0aLfZN/KUUJCRUr
         T0LWPlfynV4RybWXU7QtZr2eMqIMi7OIxB+FC2oqZ82gJcuiiY8Rk9jw8c8IrRYyWvGk
         Mt94tHmsIAMh5VpeQfLZzWTvZlqzHQGXY28vI7PTkF6mtEfZwBZNtmyFhQMup84ETDHS
         GzoF/XUuKem1Io10arjV7yEIDA953xOpbwbeMsA4GwsU7kWYqRI5vw7pfLzGrZjm9tJf
         xp5iWeK0DIsYeCgf4ebEZucDrDmxRPML5LGziwtv40FBGCEaSVLvsKTabKEeMGDp2D46
         zy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270472; x=1781875272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=J6X+51V83oQ99US7KJpDiVxaKchN2UxeGiPXlFbtWlaMvqdxojR5IqwZM9pVi9wkVE
         l2uFqla60dLFi3+kQeGs0AaUK3Oc3PhI+Ld6iP5PiIashlEke+AtO5B0jsD+1A8nqXJ9
         fzFxk651QQCGiQnyAu5ructMPsk8tGJWi5mUFt2OEg5a1TRp295wnnY+NjWdK51rnD1h
         qcoOqOEHcpXtMocKoqLGD/bEly0QEw4K+UVfCJvrIt0eLrRX/KAUEOp3mK5vU1u/QcYE
         aDzLin4gxKj3rS9ZBWb3tnung9LpdeJmW6EvX9bDWeBoYI9e5eGjyTg5CCWHHm6whDCc
         NsHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hv2j8d5t8BPusMQWrCKUiY2VMKJk4u4UjYXdWkO4iRKkKJxoFYQ/XUVg73hRbvLrPjIE79Q9gaSicDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDlnsBB9zwqfmnXAccsaLI+FNqMen0oc8XctooPnRQ8Hw/JWxz
	tKYYlTRrnJwDsppYAtxfopj1G4TSe9mInLVxI6gAv5ZeZXrKwbnKvwMVYWLJ+6X9aL/5hoqQ5Vs
	MlP9jiF1GVveiaYo/uvc0q64j+RbvdmpdJud564xA3l6CLhBYqcxvHgFxt66dw+UYeA==
X-Gm-Gg: Acq92OEzHHP4WZRKZ25A7R5LaSu4lPKQyRmxxPfJEEZAvGRXnBtS35OJwjeertOTxZf
	WFC6QcA5AoP1p3Ug87wguOie+NnfjDVdQ0TSdVeQsjLSc9UxJOSbvLPQGc18qMkxS3zaL7oju8B
	b0Y/WqhIrTYSbjO0QBn0mwtQ43aqg9J594CzGqhD0wp8C7t4KteFIPt1rKxGDCPit0300OiVX3s
	taFQdqP1xrLtFCxey+sgOSS/CCiu708nZLWgqN+WacG+FZdCYLGLhv6Kd04CYrYXVCdkMHI/Rdc
	TsRZXw94lV20p0jBew4YAYcLHIF+ZfUxQZbkTRCbFP/JZs0nb9UqPdof0HRmba0euSB7bMMvXhh
	ONyAL2yb+fq/SQLxedZQQmDPNBtE9lBGjfrnIDA3lk6qpYRN7lKn6P4dLtDRMVNEXexEKB8I+2w
	QhcUNqpMKz8CQTjcxBw02PQE+l/VPNUfNSYSZMxIyTc0SwatgBj9IuAMRbNtHhPf5OIer4SIf0
X-Received: by 2002:a05:6102:dc6:b0:632:88f6:d6ae with SMTP id ada2fe7eead31-71e88dc1bffmr1060557137.22.1781270471663;
        Fri, 12 Jun 2026 06:21:11 -0700 (PDT)
X-Received: by 2002:a05:6102:dc6:b0:632:88f6:d6ae with SMTP id ada2fe7eead31-71e88dc1bffmr1060437137.22.1781270470888;
        Fri, 12 Jun 2026 06:21:10 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:10 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:56 +0200
Subject: [PATCH v5 4/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-4-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: tLeO-nXi3ZjkK6WQkd078KQ76OkGRyaX
X-Proofpoint-GUID: tLeO-nXi3ZjkK6WQkd078KQ76OkGRyaX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX+9p3wzibOgi2
 kAGzgoKj68EM+0ebf7sAhL4zzrHncIeCD1e+mscZVVvLZUpih//wvgDIH+kDH/XHbjrTBY9THpe
 AqnrisFowXPQaFm7aJrJK4E857zLYzc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX9gbmAiBQlh9b
 ramT90ZUHFwI5HadVIYxXxEKk8U0YnE34TP4aWKwMzaDZUqkwv5T9n8eEAt2zmImFNR/mdIBT7v
 ayW2ZPWSYgYcLI5dCgJ9Yb8eoAc1NNIwBzslwD2bVhfPPLgDaZwSz0JCATPEQFXfG4BXge1lFT3
 3asgHHhYInQ3KdnrljGtm3bJqZ4H5+xrR3EM/AAOPLGbxXQPFOlYss4fwgR9JTNlTSVxK/LIYwJ
 Ef/NILmzKtSD1R1A/1TVjlJEXZ01ll9pdYLA7KEz23pKObBHqvEXS4MS8Q4VvkDnsrnLKfJJeyU
 NaAZ/VMtcR98hlokY9+eFHBtE/4SvQC1ILjXtQ9w6gAnBOKZXtGyYw2+A8lWewYkjJNOzNRUUju
 +RdK95iKHk1LNGZCVL9PsW60gVXruKo6YFAIkRgC9eYHCkWgDzE/+A51jCun0tREXCWCJuK40RM
 YRwnuvIwIuFqqqo2CmQ==
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a2c07c9 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122

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

