Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13854C6F16
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921675; cv=none; b=YwKCkIn2bD9mWwXEUYIhukGPTRAlcmdCIX+uzayjzRXsjH5NqEoXzUn/fjpl2Scqzq0s93YoHGE4soI7bkTfqS1kZRHcHp3WH0yT8ceQLzbWB69z91z3SNGXExHMBvh+JzapPmlmv2q53AKalzK/HkuaPWTY3N7TIlsaFvxORjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921675; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eR4wzcm/Rex7eEOlwkcxTjeYR1s8A6QAwV9kXYhhAdyaS69Ok3pxKcuaLL0E9pWpGwnPDL0SIk7leJMZo9z6dOi4ZBCOEbrcliAiKBwJ6Cm9FebieO7pX4tb91oiQgmrW0LC6s+OxhCsplTN+LGRAZ5KqRPVvYNFUOk9ZrNTdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pq5NS/nq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NWqf3BAv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pq5NS/nq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NWqf3BAv"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoDmt1513384
	for <linux-block@vger.kernel.org>; Wed, 1 Jul 2026 16:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=Pq5NS/nqw8AXlglr
	RFqPdkUwA1KGVsv7K+LRZtwF9K3E1Wcxk47eHkwTdnaldY7gZWQ6ibH3fP9dqRJi
	pbpa0Qh1kylkdNRlU2sHby03bKMc9gW7pcNAAmkJH48C+M/Ba4cjddY6cJ0FheyI
	pukFFt6cPC+ejY5Em3EZrEzYJJdnGgLy86amxW0eQyglo/R93w/eir4Ttv5Ov7+Y
	yhKQsOPbFm8P4KFGopv9y5LXIN9IvvMNq/SSvDowpVFLYJnc8VbvOA01OWsX/Xsg
	ntzgGP680b8EXEOjhjOtVLulFLNmnvCv5G829Z5Isn7bEB+naQI+CzXe5Y1Hhl7D
	7scrIQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvwcxu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 16:01:07 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-737bcdb48d2so247910137.2
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921667; x=1783526467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=NWqf3BAv9qRIWzZf8h/mF6PFN0IHK/ncjXBxW8NgbMyYw+f0eBh2Mg2gXdz5oza65F
         BlcInuMu6y1BBBMY8w32ode/GwVbWEOx2SmcIql3QNmQixjIOxWA4B2hN86Gk9sFXAqn
         foSXOqlcD6+oiClwlxds03ii2JL79CZ72LiHBboeDEkY5D14D1ypIJjhbZi35U80V7fd
         sMd5aOGb4zNVEKV1Rh31uKmKrHaHJOTYj+EQNoD8rnygQdH1ABk+zxdfjVS75R8NGxXc
         BKzAwWEU17ioMtOP6lfYVaPoW3gxX9lLom2gL4xJIU9ibrXvd+I/o0XFYP/rMWuHA2np
         y3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921667; x=1783526467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=IZsiUpNMkGEeu2dy8dTKVpZt0trSbHuKAar/vg88AFL547QdA8bdxlOb216T0ZkM0c
         4+hEmcZc2mvntuRTUFUuxyRCRKOpG7SuctzU0cTIflDC7yEx/uxTM5ZGhZ47jXVgXIfI
         Ouvg57oW/plXbci9T8qzfYAqDOEu7iJVSiYSlbcSAfqUJqGALH16ac/AA3ld24muqHT9
         uGpQ99DiIDwPlFaYzw1HOJReFbO7O8Hx3z0Nq9VC0nWe1p+WLRJ9X1CwFmx6AA2v9esb
         NNsqEh8GL4xod8N8JFHJYs3xeiU1YgsXjEY+sa9FTe1xu6gS3mFwE1XYpfzhUE4az9x1
         ENfA==
X-Forwarded-Encrypted: i=1; AHgh+RoTVBVUpWfmJR/dPUgJTo0DbZ7b8FgMvbZbgC73B57qFjNzS3QUwIy+tYGKoXfFXT85tVT2MJDw5KCm0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIMVxTxoiR/5UqrWKTyw0ZqKX4IUCbNzjnFuNl/PHjdFoJF4aE
	Tn3/4baysP/RAIDiakQBJs6YJo23cK+1y+Q9iIwZjWtyFD3zi40or72Jm+n82dYU0Ble2q0+rec
	U4QI4kYpstBW3eRgi+w7BDZIJImNmfbT9K2bvsJ0hKOlaO/pr3iPI8IAuQau1wfySAQ==
X-Gm-Gg: AfdE7cl5II1LI6PYSiuWeq2g6hWqXlF1PxR0HG3NA5/uPC1puUyC8haC7/olidbSzed
	o4RpTVnpazknm2azAys/o45ig9vIS0qUB2d/H1AEe9lzIeBTEdqfpRc+MGKj+PYT8XzcQGcrX5Y
	u2ZIU1xqOVxqc4VLdyKhGQZCaC8oBDvt6LDDWgiy86MWnfUOKus1LZZHN2wnXF+VpF3BZ4km8PT
	+4Ua5emS3w0rK1dF/aQy/sCxXHj1Ng/2q6jNwOAJ0SxRT2tkl8jzC9OA0pbWzwIPvTOrNwZVplH
	GLOjVenAHJrLeXVEXWSpCXQe41/uEOi3mppxOZoNJ3uLI9fbzdiuFolVSvcZIaWSF/oo7zNyRrh
	lu+Khxtub+8pxCf63HjDit795jqKGwIcmkgtwo/U330Q01eB+QL0YQ1Elfl1NgU3ZXDDs8Mf/sZ
	ZJNm1qa6XsnUwD/bHiH9jOwARxGSbEk7+kw1JR6q9iLb9ilmEGgjhx1tkq6Iialr8=
X-Received: by 2002:a05:6102:38cf:b0:739:d787:be9 with SMTP id ada2fe7eead31-73daa349057mr1034977137.17.1782921666896;
        Wed, 01 Jul 2026 09:01:06 -0700 (PDT)
X-Received: by 2002:a05:6102:38cf:b0:739:d787:be9 with SMTP id ada2fe7eead31-73daa349057mr1034801137.17.1782921665861;
        Wed, 01 Jul 2026 09:01:05 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:01:05 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:32 +0200
Subject: [PATCH v7 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-8-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: CzY5EC1YtMN3_mhOFQ3lSUgZsE8Ov1FB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX5iI0nhsM49ew
 1Ld/+ukkjvuJKHGHQsWgCNAxPIowPC41x3Jv1zl63fI6kzr4vbyaJSoYwu4XxfKHbY3hDA3p8Hu
 nYg2ISrUrz+HCqFAbZmLC0Nu2ahaAWI=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a4539c3 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: CzY5EC1YtMN3_mhOFQ3lSUgZsE8Ov1FB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX6FWRCFPXHQyS
 EOAarmoUNYXDWb7R5tH5s7FiPZAOnSFx3hXQGBQhTWcHzwxobczIC7NsDau6zn37lmSIv4a/BQY
 iYKc9F4u2g+r0/Uv65RY+NyR/Df2e3sdV1cNtcHRpUte6nJumytna8H87UxXG/gyShHw/BjCVVf
 LajV6UXoTBKh+d5vPXbGA1HCOj8Q2PYuif5M+HXrYD4yV2MRPWB3TDBj5MwvJIH9gz2M/5eO/+h
 qLwy6JOBzA0s3eDK4fBZRkq1v/cZdv/CvnadNepdWzNxz/7yDX2ye0PT7+OwA1hK2hSmBW8cYNx
 /dI6PfzMGrWJsr/Zl0Saq1aNPCdw+EDxdGxBs1XgmgRwrogVHqeq+FxPE8wHgtCXPkyqcBg698B
 w+SjB0S9cVIsYUBFMMFIDo+Tzy3PSL8mki18TtC5kLJBXSGVtaXu/dNL/kQea3twdBN91x7YOyG
 yk8GWxmOscWGyC5lKOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010169

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

