Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE463D953F
	for <linux-block@vger.kernel.org>; Fri,  3 Jul 2026 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086333; cv=none; b=RUD8a5I762o/PvmkbiUmdmhinmABFcXP8Vhe+XOC43i2/rfFz+OjEAXdfTuIC70cEFcuz8mqFiru7fhChcn5+GRb+VXDWuGBXpnDnRwuhgfb//b5Qo0VNhVOg0CTscLNJ2l+lSyH8NwsPwUav7zwRiRWyrzvFULfAKos+QlD+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086333; c=relaxed/simple;
	bh=zkO7UGTBhc0abSbmAA7xbPJx3KQa3FMC3+fWJRmAgxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0tv+Eqcw7r+2nRfA2cSNS76FlZdteTOSAOJt/bfRRktYFYNCfnRrfUEFA2BJ7XBZbP1Rvog46jpO0Vzh70Jm6SkFxaWv9yQekTOiBQBqBlY6/RLQNpofXvdED2BG1FemYqd6gkG+99E7qpLECvooqwSG/1jAOKLFmn+ql7NFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3c7nV1P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bu7T+vPd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3c7nV1P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bu7T+vPd"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BrNHH4091822
	for <linux-block@vger.kernel.org>; Fri, 3 Jul 2026 13:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=; b=Z3c7nV1PTRoHjP9Y
	N8NDqCV0gtQJFr0W6O1wUDef4OW1eTa7rUWJcI+L3YuZPAYrKIcWudhVKzTJqrJZ
	eb8HX8BJlDfPhqHG2jSC/hXQilE0PXXKmZ/EXQukwgOqzO7ShYU5tnZ9sGpb5/lD
	7nQTCQR4TcNLAguTL9DWCbTEh0LP/73+RhvONYTPVoYavquvmBeDzrHwrI6hcJqC
	GmOV22R4aAteWaxzLt8ZOebOd031WA5/81BkzbBNFt/yQnXsvV37lXp+vd7Dc9me
	M/Bixtazx6p0hww+H1DWI4pq7M76d95uIY0eGBfVH2w/mfeJPD8nzdIBx4LRNVld
	RJCFBQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj0ckp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 13:45:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e695a3b28so178345485a.1
        for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086330; x=1783691130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=Bu7T+vPdt0W5/qE7eb59YhefA22Hvl/P0YMJCgnxH0q+gWbiW5yV+BQ5BGWlID4B1y
         /ejcaKK/GQjEgABa4huwcOtTGMMZ0nwr3BoybZKD81TCItclI2XxOccMAtAEUghdaibu
         uEKRZLqsl4gkBD+oLscnE6RQdPeXY0xztUgsCb6C8uaDB3ijGUWKZLLQj3yg4K8FLA2d
         zy3k+26RFVZRS0x0qtvv1uWxlyhXV8GHNanO+xg6T3RPLos3Ow+05tKAuwugYhzbkPVg
         UjoRB8SdGRWuKD6FM8x6n8B79kdEYkF1ibqWBk7vCDWIwRSfR9PWA+b54o0sqPmFcP1m
         d4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086330; x=1783691130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=KZ54gF+Uku5hNZ/aZnR75ygWG7VQehTEXaEDsPUGggNNwnQuTkhXOq6+xh8KmwIhmZ
         lwH9hCX/uv+i5Nxm8O5kuwuZcs0Wpr6OaNmCoNIOhdBQ/lmm9ryhX5ukevrmDyUuL62P
         5yedZKXM3Z2/RO3u8KZjIyFD0Nb27i5CM99+Tm4sjfkKfE+7whiGlj4Mz9xyCdaFBfez
         x09iifami/C8dpnf3ubBUeEVz6Qhve23YgJLVM53K7OEdD4vzwkhJcu2ZGNzQ6RoUACi
         g49ubEfccYG19kCF3XfXgs5ODfi8sfjoSJRO1NT2PkvnZiHuafMIBFNumw65dX6ktFqD
         PMjw==
X-Forwarded-Encrypted: i=1; AFNElJ8o5va+HD0Sn9Gr1B0bQpZFFfWzumJHLUEA+lJv6BnTItrbqnnxnUDrXTpLXEzM03vZsWeiUqIHP1V3dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLGpBpvDdrNGVEDryrBne5o7SkiNCVvRDG1MXb2J/TRv5Apm9
	JUuxi7aUI7i1BUHLcn35NcuXoQ+rfz7B8R2LZHoR/emGFZyhMWkMXkmtrLXaWv6xzWd/2Cjwgbe
	UAZeMDNcduo3m+l7c9Q5H6BZ9ARzeF1FnvsKfXq4JgUQoQCQHRzYlONVi7q8azeAUSQ==
X-Gm-Gg: AfdE7cmCYauIhm56S44d6/2iRsVYK/RzPpQ51pDuNZ0NoYyBjMiiedO1VwvtS8AML5K
	4GaaEfNQegeqH+KsV51zzZtMaDfWh26OEbmPbzJcCBBwJV/O1vkz9t0PV1p4rs3zeBunUwRsuAx
	po9s8mo7wRHDQ3z1TguSarEbc7OAgBmWI9sHtbW//C5Kee5fKJ44NJQE2+e2DdY6JdXXTuD+eDB
	1If6Yc1XkEh2Olux19J9f9D8qvP1n6NUfI4QEg9aKnNMBM39Fa3+oISkQn/k0Wb+8fcH7ukkmOo
	pEYPMLwqjUGh2PD3J3tr7rq7X5F76Wt1s0q57WUDmpYu9izO0qD3/aMQ3YPVZE2T/Kvz5b06MZQ
	FA7dFWmn5QaKLlNQXW66GgdZYkMTwzu9nrVJPz1J/EjeeI5l5oY8ch1MzJwBQGR7RaWk+2b3fHt
	aAyY5LiJNnaaNVH8aiEJs9LnE3y3U/A2wdkrLSPcLqsvMRygMlcdPCRYeDJLqDiXw=
X-Received: by 2002:a05:620a:7007:b0:916:5f5:de22 with SMTP id af79cd13be357-92e8b29ea54mr485345085a.12.1783086330455;
        Fri, 03 Jul 2026 06:45:30 -0700 (PDT)
X-Received: by 2002:a05:620a:7007:b0:916:5f5:de22 with SMTP id af79cd13be357-92e8b29ea54mr485340685a.12.1783086329977;
        Fri, 03 Jul 2026 06:45:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:17 +0200
Subject: [PATCH v8 4/9] nvmem: layouts: Support fixed-layout as the nvmem
 device node itself
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-4-98ae32bfc49a@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX71orIxL+2PoN
 B7D80JlGhytDvYpkIN1FsyPyIylJb32ri7vlHHztfag9p5yA4gQzas+M4MN2ePEmmo8OZMrObVQ
 9gERMLFgwNIBldJOI/Vj5tAf3gO8uts=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47bcfb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: a9Ui7WOiHvQscxyzXtg7YCThlge9you6
X-Proofpoint-GUID: a9Ui7WOiHvQscxyzXtg7YCThlge9you6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX6PkvD7tcyN2b
 C1rDX22as24+/mRlNNVumvqqUZLYrX7IxT+4wef5XyCnY02gROxgTIDj1TGgmN95bS9TRkq3/LJ
 d3NF1yHm9d/GsT4Z+VRTM0jou34jGqgOtxRjQKgGlUY+E394CUQ4t+od9eyOBYKdY0fYUixnndj
 +8Uvtoib78Mufarzji7Me57G5RRbiIqnfMHAInBITavt3ZKOF2mZhdD7Gs9bu44nnYOn2oteBhv
 1aH/jlVPpD+Dd+qsp0CMXWUJeSFEbP+vuFdy9l+1DpdceKRg5AdTSLeeeR2VqudsBadcbCkDZIi
 vTcPVfFu+09dLQLBnaGw2Bqplotz4zS/xplmvwQffRkgggyspHZK+uS8HfxGteQL/yGZkEzfPOa
 p1SDRk0iy3169N0t+SIeMj6zYP+Urc/GqCge/bkcIQvcyh9MJnWrghER28xDL0GAbLYYAlX0Rei
 klObcxazk7RENwsOFFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/nvmem/layouts.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99eab4217cbe7ec48373e18a7caf0dc..efa631ce7283bdd6c8ecda75915911b5e3a33c99 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -167,7 +167,18 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	struct device_node *np;
+
+	/* Search for nvmem-layout child */
+	np = of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	if (np)
+		return np;
+
+	/* The nvmem of_node is itself a fixed-layout node */
+	if (of_device_is_compatible(nvmem->dev.of_node, "fixed-layout"))
+		return of_node_get(nvmem->dev.of_node);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 

-- 
2.34.1

