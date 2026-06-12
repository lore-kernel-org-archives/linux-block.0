Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4858A3EEAC3
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270466; cv=none; b=BpCXL65HjGuIg1TWK67qS+G4dKd4cDXdzVydY81zJBdQrokwmKGr1H9EghNf/M5CPK6WtcehwG+GBAJeBd3rNiT/n3XivmjZac5PSMlPYLdZSqSaqfx5qdGRovHkT4qCFxdfNRTVJ5wCtVVwxNqNUYFuQEIAsNv3wc+tTssvjaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270466; c=relaxed/simple;
	bh=ND8QCWihnx/5SzmAjMX21FeKkkTEai7fgVEY9yu2Gdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K000bOOHhphgjQSvYxFKycBtCuduwEJoPzwfbMyHE5zYy2kZaA84ZJ/pI5z7Pl1uzhwkh6U/4sLivHFvUq7Wi4byh9GmHuZ+cLQv/WeUvUHZxRPTEUcMtgeIqSaXlN0VNkE8w6Nr5WKiteJBX9iZqPWYS2LCwuH+jp2n0qjoEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ih25a15f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D+y7On5S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ih25a15f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D+y7On5S"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCj0H33661583
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=; b=Ih25a15f7iXbpzty
	m5yjqdwpdGC0IJlGeKlWrAQFy2yLuxPcCWLUN8imPBgtPjAN2FeWU+7FvlYmF7Aw
	WDhZ/Fh5xxkRuZ2G47GesuXjMjrqPzEO5eLNJlUJ+6d4EQRonYXjTUutDr23Ilkx
	knHZSte48LpRQMBNP8oukwa0eyryq3WWcYPVFsJwTXnnLFOljrMZ/kLSuSDH7Jfy
	Ap3/z4CFWrtBu6m+1szEDiF81RrHgu8D+65N+qeR9NQ3LtBmF0876KMYSU9+7elW
	ET9ZNqVwygbI9ivhL5dBV63/0R2CpY6zAWMJcecJ2+Mjwd3wLtxpZN6ZoqtoT+/C
	BpPZ9g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xck6vd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 13:21:02 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963e6319d22so188885241.2
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270461; x=1781875261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=;
        b=D+y7On5S4Nd3LyiHl3/maoqli1GLJc9ThwAccgTjV/KmliIy3NLBAmI053ixl7qKH/
         2nGKAz1+r48Ry5zKlf/jrqpIo70G8IqvapLgzjM+m38BzVV50QDjAdtX9Shv25AbWfrg
         LerPPdQk88gCezMxOgAk4ULfEh4OLVZzDZE0isjnAmZXQSW9EqKbaMOBN0O+HMY532Gj
         WYLpo3XisfkThqqj55k17mc7q+yqPQWLhwLoWT+FrwplbTn83Vsf21RE5DVEZk5xMch6
         aXLBFVeCRY63wosn2GZ1Ex3mIk+EXTihRgS/TU7VO5l76EKdz0kQU1E2E4SeqYrzrdmz
         5QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270461; x=1781875261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=;
        b=Vdcx2R/1E+DCwXZERNf1+OK/AVZoGcRpJy9dygOfiwzt3uxJQDb8AxJGfSye4W7LwU
         JjsLmtobLG/O7r+3qTPB/XCaf683oxVmKQS3LR6kccj7sckoNI+6VQqrXwK234Ag4lJl
         349ksVt5B/wtAoro5F100hFMRSjnJtQht9A8Yc/OieqqEPSMczKi52XuVEjN2b84zxvt
         C40N7elnV7AgJhAr+NuX54uPQe65XYmSNk9JDt68ounHZF0AiSO7J96EDvt+JQIhXSoh
         A1G/ZhCyQPttrWC7VcoFrakSxqDk1CUM1tn4EN09hu4nWfJaY95gLBZ3WBd6iIt2kALR
         iWMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8knior0roEDglvFsme9oRDnm/JsSoSIidxrP8SjTZ1/wSiO9EcVJeL9OECn1lZdyCltMPRk+38f7pFyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSmDlcja9Aj81O/eCkc6KZQkJLMa/AKOnBaAX4p/II3POOOAoc
	Xp9awXWkJtyk9pdpPNrXBks6dowPNJvYS4ND2qQ6FirZ3hI8RQmcxxm5kpgV757Di5TFrElZj6Z
	3uPtQ5fmcIS3c2MiS8vG8rpg3TbGPykOL4c763g3XWQaxhPn8NF2xKznk2XnO0jEotw==
X-Gm-Gg: Acq92OFddOrFsjQ+nr7yFymLQzo/7y62zFhIlyn4DdwK320DyHiiusYTjCXBK4iUXDd
	NAQQTrug2dCfoQCOxg04Sf4A+Js1w9nYPEClBL9dLr/cUtFRdKqpaAdbw7bAc6QbJ+4LjU/9O5l
	1XZzPzuf+cK/jTlIfmRlcL4igvBoIGMnB9j65OxllHjmLcrxOgqLlQRf5zlg+WX/0kajl4hj4jm
	GFEltkbtbpJBvsZoXWDFGZ6HqRe0b0iYF/u3xRfvI6avgj4p3vXIMCbFCfbvd3H0wPbB5VMLf9J
	NtGfs0fRxkdneZLV+gvJfRzEb8IDRG/jcY4YnR27bFQKVPoT7u+mNlW6On+lGqODSSPIFDobNha
	ows2fGAR62QnArwRle8Az5kKUUFyd5D0mTJFmTT44pVh7Cc+B/ZX2qa1dZEH4hQuNA5VSvQL/2p
	KG+NCsYAFYnkwXdVieX2W3pHW0IXYG70fzsl/pcTDeSMMc67WgLLuMfntRtZ+HVzlrKaf1Ze34
X-Received: by 2002:a05:6102:2b89:b0:611:61d3:819c with SMTP id ada2fe7eead31-71e88b2a46bmr1202672137.10.1781270461453;
        Fri, 12 Jun 2026 06:21:01 -0700 (PDT)
X-Received: by 2002:a05:6102:2b89:b0:611:61d3:819c with SMTP id ada2fe7eead31-71e88b2a46bmr1202596137.10.1781270460929;
        Fri, 12 Jun 2026 06:21:00 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:00 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:53 +0200
Subject: [PATCH v5 1/9] block: partitions: of: Skip child nodes without reg
 property
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-1-95e0b30fff90@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX72DixNXyE6P8
 HVZkvtpwLFcT3xFU++KyTGJaaXtBIGZXL13frdYQnMqbWmMcm60etvCwSUqA6R4qp0yNLgDj312
 Ayk03tbkTRF7mBRes7Vb8pPfWAewXoF7vREzA4wa9qNoU0LmHSFeS0u+9AZOBvt/bwjrg8y+Gts
 a4b38qtJvnlVZ6FN/zZQawFehnXzlDGqtKX2EJYnrwRxM1qMNyoEBZwV06sNzGvkCXnGVj7EHNO
 fTaQKsFZN1MiiYBnHzQUO1VC3q0kymquODoS+iqED8N0c6QLdZmfZIkD9I8wzU7rvZYxEDtQIj4
 Uj9bGjeDf3zHLIz6p64LDqaQdqU4vEl0br1Zge9fPBF8jgidoiD2f7I0sBKWNx3vFaM46K6WJFN
 uz5caE1MuyVoYdFytT2oPMRJHVwqt9TEZBEsGNa+8YJyB1znaeweevip++xwUh6mRxwI8d5sY2p
 FXOyD9kseD7v/8GjxBQ==
X-Proofpoint-GUID: Yst7hXw-4gqFrNaCqhxKJ76vEqV0B2GB
X-Proofpoint-ORIG-GUID: Yst7hXw-4gqFrNaCqhxKJ76vEqV0B2GB
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2c07be cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=e4y8cmn4OwqddjlM7QMA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX0iW2l3/+7i83
 9P0dyOgKRZ1Pz+bITpRFxyBwJiQ2rXdc7sd56qXRvtmmocxaxIV7k+1mwaeiSrXJC5zzk5L435f
 cp7wONjg2M5xk5IiRBr3NtDohxhIjDs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122

Child nodes of a fixed-partitions node are not necessarily partition
entries, for example an nvmem-layout node has no reg property. The
current code passes a NULL reg pointer and uninitialized len to the
length check, which can result in a kernel panic or silent failure to
register any partitions.

Fix validate_of_partition() to return a skip indicator when no reg
property is present. Guard add_of_partition() with a reg property
check for the same reason.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/of.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index c22b6066109819c71568f73e8db8833d196b1cf6..534e02a9d85f62611d880af9b302d9fd49aa4d46 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -15,6 +15,10 @@ static int validate_of_partition(struct device_node *np, int slot)
 	int a_cells = of_n_addr_cells(np);
 	int s_cells = of_n_size_cells(np);
 
+	/* Skip nodes without a reg property (e.g. nvmem-layout) */
+	if (!reg)
+		return 1;
+
 	/* Make sure reg len match the expected addr and size cells */
 	if (len / sizeof(*reg) != a_cells + s_cells)
 		return -EINVAL;
@@ -80,14 +84,15 @@ int of_partition(struct parsed_partitions *state)
 	slot = 1;
 	/* Validate parition offset and size */
 	for_each_child_of_node(partitions_np, np) {
-		if (validate_of_partition(np, slot)) {
+		int err = validate_of_partition(np, slot);
+
+		if (err < 0) {
 			of_node_put(np);
 			of_node_put(partitions_np);
-
 			return -1;
 		}
-
-		slot++;
+		if (!err)
+			slot++;
 	}
 
 	slot = 1;
@@ -97,9 +102,10 @@ int of_partition(struct parsed_partitions *state)
 			break;
 		}
 
-		add_of_partition(state, slot, np);
-
-		slot++;
+		if (of_property_present(np, "reg")) {
+			add_of_partition(state, slot, np);
+			slot++;
+		}
 	}
 
 	seq_buf_puts(&state->pp_buf, "\n");

-- 
2.34.1

