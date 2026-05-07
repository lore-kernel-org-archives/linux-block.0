Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA1466B79
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167512; cv=none; b=fMU4FuRJWDL4QsE+iG1AzyIkleMkBd5BbaQshHZJHVusmm4JC1v6MlVeVJ4eN2Cv67lkc/cgT1eG8/VReGUs389JrADNrudV0Dl5qnQVWN5HsBxlOz2qydYU2T4c6iBUECSWyy7kk9cH57E2kWU0bT47NwWA+QVYwkm7oVeQ0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167512; c=relaxed/simple;
	bh=cLdgwybwmVheaxNq3A4ptASzy5fGo7sa3nM19lVmCQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfpTt/vgSPwUXCvfpF5U4mhCkA4RQkOZq+YBzf3F7JrfmP8+SU/wjU8cGotMAT5oKCpoaM8YSowy7Sw57C6ihPB2y91dJdmf/4AN8kuPV5A3HGen7oJPdXzYzp9QyK259ZN+1amD2CPOwBkIEwd4Qw4mB2wHB4ABQUlf2Zrr9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JNRuu/6t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FAlW2kYb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JNRuu/6t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FAlW2kYb"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647Bxca22734234
	for <linux-block@vger.kernel.org>; Thu, 7 May 2026 15:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=; b=JNRuu/6tQg8Iq2yd
	efyuW8NpXjne8LakeYYrmxE2IXd0811URgteAZuuZe7hSFzFIjLDs4geR7VhamFG
	n83UxzHDzPwQY0bf2pDm74l1Dbpi+19LuNU2e8Iozs8RmX3DhPdqyCEXe9F58AMu
	8VrFY4AoYHnLwTjLpcLSAYm7/UY4JMH+8frEp7SibnG5+D/O78QB0nBkVdm1mpO8
	TYSdd5vt7KWPhF+nOUX3+HPbeX0X8iooViDwgbzYKKlaHtpQU+ybcnyGr9XHY6wG
	ikXlCr+7RoRcCJ5Tl11QBu+mpsMILrxsHNJNLdBXZoQUHPyBKpG/LJw4k/Phl2WZ
	rI3n2Q==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tbqrt52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 07 May 2026 15:25:04 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94d6c5433a0so1189043241.1
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167503; x=1778772303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=FAlW2kYbEFbSRezWYKrHriJT1nLtx00Hme0Ybkk+Wq/NiOaZ/Y/JcLJn+mnHNNS9cA
         Qz3fZOVCJc0CZn/RhXTbWqKaXvK66YfCSDnKZdOBLVUzhqJ9WpjyebFW07P4HucUe7q9
         iC9p8DZiM09iujRtRkcp2hE2RZdIX1KXEgJ+LzjYmH5gpOcWq3tVtOsjLp/GLb3Dd/Z+
         hSK+wAZyvLkBXBSEKJciEKr/Af4kcl2AEyxgR0BLIjMo6rDNUCdGQoMXyCV8XpNRD26q
         Zm3AWKTJjwBp7cyoNjDtgKs5TZhgY5EX2t/yqgZOJJD3fqT7cdrfWN7wjugMNFK3Eq+P
         083A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167503; x=1778772303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=H+2SfJk/3YzwybXxJUQMoXBXCbVK0DTDI7XmMjccJSZ26V8vGOWCjje11CgKGHQcDy
         VSURbEALfrSXl34Chw1TDvCKudYcfeKg8rvzc6lM24wKpU9QBwwcPzo3akC4cZ6z5Vju
         cG5Pv4QXu30fzArTbIgvFYPXaGvDTcf8CuRex2BWr4pmlsFtvrFSawTDTHtosoxDI7Lo
         AvtguoFRI9SL85hthLCGXWNkoFkR6rtrFbp4iU5gHzYwttwwDU1Upogcf2bGSSfYKf2G
         4cNfsHGGXd+O4hqnFpUCL/laMr71cvQlbNPKLA+30dCB7ZTcy/+ihucIYlMfN84f+cx9
         qi0w==
X-Forwarded-Encrypted: i=1; AFNElJ9ye9WdzoUJ6a0hPxHIX13gH9ShIjf2tAegM7P8ZEpt5/ZljVl4hqKbTYiSZuvnD5037yn79EHpYFIaQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztB6e1QFWsFVByZgHy62y8SVrzyaqX2bT03qDilavXCpLmct7m
	4R5N0pG+vu6AT/Lpm8Hjp/+062Sr8qL/eOSldrujhcF3RvLg2Lgki7ytyxej9MpKGECpTtDeznQ
	63Jx8nDkKrQ+dV/Py6jbGgcJvmXLsmpkCRqjRYfJD3+FeCSgzAP+tooSunWMVw7yp3A==
X-Gm-Gg: AeBDietEUkWw4mPbkRez1tbtb3jvUKjTRs9Jj0wvXA0/8bdIBsYpkZV1GPIza48Np/h
	x/vFV7XA5ig2GJLlCEfvxrQyh82VFkp8FHm1RhTXXM8RX1Tq+YGVIiPnXOYLwlHjEZ1M6s5a5At
	M+CQNe9kxdvdoR3sBliGxnvFN/wq4quL9uGCPF7v8OCY3L0e4NcTB08+qfuqULjZ0VUJWDoastQ
	p6D05napUcm74Nu7+C+a6EFE3ffqYO6R1qDaQ2h+usihOj6cLtG8yuCtRPKbsjQGdmMtQBx3DNh
	Z8Oly7EOVnUAT19/CwW0ZvAVY+/qE2edmon/pn6rnjySTrwb7GhGKGgJamVwiYW3oGUcsu3fuIE
	Q3MXR3QoORnyiZKMADg/peuF2m42BPh5RiWobMdBWABgb3tSzrKbOAWFyJp1zgCTafj/XH0yqM3
	nibTgrd1s62OfQNldC5mZZax/5T4E/RmihubO8zw==
X-Received: by 2002:a05:6122:e14b:b0:575:37ed:f787 with SMTP id 71dfb90a1353d-5755968ada9mr5305796e0c.13.1778167503429;
        Thu, 07 May 2026 08:25:03 -0700 (PDT)
X-Received: by 2002:a05:6122:e14b:b0:575:37ed:f787 with SMTP id 71dfb90a1353d-5755968ada9mr5305758e0c.13.1778167503042;
        Thu, 07 May 2026 08:25:03 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:25:02 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:42 +0200
Subject: [PATCH v2 7/8] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-7-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: LavzncU2eSB6plTC-_R7swdkUCqjkixu
X-Authority-Analysis: v=2.4 cv=SJVykuvH c=1 sm=1 tr=0 ts=69fcaed0 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: LavzncU2eSB6plTC-_R7swdkUCqjkixu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfXxLqMQ75Jh44b
 aXoIB9cwYoDPqxLKbx5urbsWQdxyVVFyYJDBhZ5tbCLmbjP+JKWJPNYKewtoJ0fCoWgeZZKaXxm
 5KH520bIgPRYETIPiZDkiR3xQ70KIa1hz3otjmgW/bV3ch/4yattL7ZGEjeFji157tQ9tN52TNH
 3cND65nSdCOn9ju4ROYHF/i6ZhZLqOoSPWesVgP3GY9juxJZFNdkvQJ+J4aE7XqQ1XKOzOlI7Ex
 Kx6RS5hSgP4PxNU0G87YOwRYzU1NBv1JrrdJWWyxMhJw6zhgJwMmS/H4mi4SyJ1SrVaCxT1rmG3
 GWAkgsPmunb3v59QQwuLmDWk0RQtjqd8uAv91CIhRZzh6mXgXEF3IQuunlAriRXzYe+t5IPa7zX
 EBHKlx2sSk+NV0ncTcZgCK48R/hK0c2k6TKcJ/fGadLTtZt2GrezABBDtgE74nLV4K/HLOP1d0o
 66heekFyn2zlJNLFaqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070154

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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

