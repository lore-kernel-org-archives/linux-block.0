Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066D3F8EA6
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723347; cv=none; b=r+2FCkQmvcY4nbfBbo1j02DnSmKsmB8PvLFS4KL2yBd37go5k45hArPyLCTPzVaZN8+fRNRKmN3dcjw/c+eQnnKqPV0Afi3ExObRVNUHA6mVrMA5jVmH+Mqb+847w5ohchF19e2HFspmby/q9UDuPIfIt2Y9TBdfl3rZcKSLFQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723347; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfP6IxswrkGwaDc93Z7yRtt/YgiVKN+rBJk/YZeo9hf777yJdNhfBEsdUdml4L7wfzHQp8xkb1Q0vXgx0s9LP1xt8A/FXgporLHO/j3jCvxic/6J3zHEa6k6TKMymxmSiI0w18mPQiAw0hLaV+OzUMPYFYR1CMT1km/49bMiZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1Fcs9z1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gdZ5+cJJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1Fcs9z1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gdZ5+cJJ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rPB52097376
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=F1Fcs9z1Aw6XRZTs
	Um7fEWGgX5KMk8DW9SYSLWVtVnGWMJoda5P8TBu5fBZ3dVMgwzv6NR9VP+2jTMO9
	F9h+ZjaDO9PlssYceWEKHXRrKeR2KStUYV7d4vpowsopRKjKBUAzdLPtVtLtWLbY
	fDxJri626kkWHDHjJmKmv+ksfmW5/EqibfVeuYrF/4mLCNM4Ot4/R1kY5GmT0knZ
	E8//UYQO8q/RRHP/sc38FkSY62FIrSbjWcgouKPze7dsixwql/LsXLDVr0HdN0Fd
	qeQ/zpD0gUl6oTpQwEdeGYE4Ew8MW6Hsq1+kAIhSwnMR5g7MaLJRA0WXT+K+2U/K
	0tmChg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7wfc1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 08:55:37 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5bd80b3e9d5so860459e0c.2
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723337; x=1783328137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=gdZ5+cJJB3KO9Q9g9NpXZcgFJSs1UcHLG0MemMvXOBzMtBGpV/13C0OfedZvd+Gk6Z
         f2gfs5ybMxUGDVeN0kI+hnQKTDsgAvBGKLHVv62Ude/jzlmush4fTgKLJ229ojI8oEYc
         UDWE6F5AMfp/w6sFddyjcFsAQRiCu36t7BO9V/8CShLdfJwOHrqh5kX5PezvEmK4flKx
         /5PJ/uw7IKggMwh79TmW2rpkILPsvsLzgFz2w6w0RocikBnilWctaWnzmVDqfqC1Ztrk
         jDHNLjxmZoH7x7izVp94W6qsDVpjwcgjriwpV9C2ek0M9F4RfOOVHLFV3S0xkNVkp+7r
         KWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723337; x=1783328137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=OfMfuB4Pjp8tQqIUu7EBNVp5s2w8Ee3plE7nOntQTYIZu8Z8ww5NSQRqGkrSXMR/oQ
         8XdI7St0rDHsGefsZSSRvoDu9c557OI5p9wCh8G9fgyUGteCQ/mXXIJG/SCUAM7dFIN7
         X9p8osq2mohD8KvPGCzOqQSbdUCKnuTzcC2Ur7Sj7gJYpNnu7k13yDZlfg0oD/ebKBFD
         WMHfQ6PISo9zqBVTYUAVOmV89emLboxRBvkPcVmwetlJMKovoO8pZc++myr5T1/BSf4w
         XbolZAPLHQXC+71s6Ycw/p26u75K9wQf4FpGFxYRvLhr2VSJtdEn9GGCF0zK9NwRrE2u
         dlKg==
X-Forwarded-Encrypted: i=1; AHgh+RpwN+qeCgu3o6hwPKXORE/NhBS9Tgamc4f2juo0HCHW9LtK8pFPFf4ndMu8iLKWoyDujcyf6bj6gdkchg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cpQgNGkZZ+i5pQA0n1f7ZEeMXqbeDwNWS48AwFxxOHcD354R
	pdAxyzx6qvp87q16qgZx/M0ct4ycHNuCOVwhMIsEy/2C4cLJNhFYkluzDjUBznvDonrCkJN0uBn
	UtzJuqGPRXZJMlaOsPBmjCEA1Lqc7yfkFGAvOV7yjIufstZaHOj8790C3giGmcJpJhw==
X-Gm-Gg: AfdE7clfNUap0NbUAePlslsOehUo9tzsgjTJrP9iLSBfqDJZAR+bhfppe9/vKvICMIU
	/llsfuMOnCDe4097ZYW5e0nGF+T+CKn/HMRpAmPF97dctI2sSqJDNn4aKFp3ZObOZLdoqJGC38h
	fjctkjjWevJioG3a3XK/LszQaP9ApwYqic0rKNj3JhElfonQQ77AXBq6vsW9eDQEXJilsBBAiBk
	P2tXp5LJM+WUlDwFFImRoF0fxP6wP17wnXW6icn9KwM0hmkgItcnIWZmrzAeGiRGEPFmSz+gJyv
	xQGN4kSzhSgLecxz1k9rw/Qs7o3/AZY/4XnjK01/uqma7/2GPQLusfWPaTntPJagPkJiIEgEfRQ
	nhxBvS43DyFarZJEZ3K3J7nzzIMyT0jHp89ba/IpkKxwy9AXaubJqm+k20IzIYVb2ydKpoM5SfK
	PBzFfzMd+PasDmEagCzK8wC3E0xYAIADQwi3Bd7HVetAsG3a8zo8/MSPP2dMYjPJUDQrzzFIA2L
	S9CQ+ySGmBf6FeTl05p
X-Received: by 2002:a05:6122:3123:b0:5a4:6680:64f0 with SMTP id 71dfb90a1353d-5bd69cc1bf6mr6342993e0c.4.1782723336527;
        Mon, 29 Jun 2026 01:55:36 -0700 (PDT)
X-Received: by 2002:a05:6122:3123:b0:5a4:6680:64f0 with SMTP id 71dfb90a1353d-5bd69cc1bf6mr6342973e0c.4.1782723336048;
        Mon, 29 Jun 2026 01:55:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:35 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:23 +0200
Subject: [PATCH v6 4/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-4-f02513dcd46d@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX+DUkbxpKH3mt
 YxjyhyichHxMMi4JCDG+RaejR06zaKuZo4XkTuw/ifAEynSpdq/nrfO5a7MXhqMeIbR8bD5Q2DI
 /7r6xNQDT2+jyMwVbxd4e9pNcvJ1kVeBJSR5NhI6H09t8Kk2nqr2wm+uteIT4I3RKBKwkQdlmJJ
 PjmQ7ubXyomA3se0d6UNjVNp6bAuMGRfNqJtO8TsuQEc5ru0Un0CJufqA5hdd3l1YDoEYI/Euq9
 8O1KAXHAO4gCE7biQo2rSfHik9xhXDNw13F1bpCbXgbHHaxS89n7dkoWr9CxYeGrA4cTMSNRT8Z
 iWBoKyniawWbFgmthax8wNfIcmPliC6CY0q5F/pB24fUclaX/8IW1zJyH9ZgNGpJDMqbSyyLfF1
 9M5jogbKJ+2FUGwbmKYV6GdMIAabZiMH3h9FLhTvmSomjHr7qwpzHue6apO62+VohdZUFzNchF9
 mYUpw56kXo0QJgjOrPA==
X-Proofpoint-GUID: YsZR6zSNchAtRb4HfuXiDD8g7KrOsJ1m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX++ZZ/yVwVYnW
 y3iBKDkAc1K/D44HYOD1KwEK0yofM7tok6WbjYUkc9cBnx4hNi4z1ezvi9R0sTgPWpn9p2T2u6x
 4GCSF9YNnvii0OSjw2w6PFMh8zBX0Hk=
X-Proofpoint-ORIG-GUID: YsZR6zSNchAtRb4HfuXiDD8g7KrOsJ1m
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a423309 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

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

