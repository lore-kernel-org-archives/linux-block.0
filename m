Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70F3E5EFF
	for <linux-block@vger.kernel.org>; Fri,  3 Jul 2026 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086347; cv=none; b=c9EDf4QeLVY4XjufZ31ZtgamLewWNKEY/c9PD/2sajdlGaWfx6T1rZj6QF97IxSR3SIXsZCl4TK3Wl3d4TQllhlER6Eo3Je4YzMdIjJnyY0VbLQaEjLQ2d1wzwVWRb/uYspQYdeQJELWdHIkLVizOlcnEPrOTxkSjd9viWQGOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086347; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cA/ZmFD2uMxFhHWB/hWXxjwEAk4XQ7q5DRPwbeVtKWU0jGRu93YKRy5iLAyzqTPT8zL8EqhhYqqvHSrKl/DaQYhMKNgpAy5oqgGWrMu6Kl2kJfQ84unMIniz88UhaDLdWxyn4YGW2OSl1VLJ2gHI9N7tfEiqOiuTU7UU90CiHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KRPhwA/o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rj70q6qs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KRPhwA/o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rj70q6qs"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BTcph2994887
	for <linux-block@vger.kernel.org>; Fri, 3 Jul 2026 13:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=KRPhwA/oh9GV+uNe
	1MwR120BO+YSIq3ukMGeVBkcNZ5Kq3I5QOL0MKh6GD0UGJx4JioKC0KrZhqHprCX
	/upucVc46jPkUtqpoIH6svQnEQiN1ucR7xoGqS+6VUkQk/x4I6LXRFd2C7rngb35
	bdHPBxAI78RtRL+1+im0WisB2E+fI9770b9Gh+5O7PM4nIxpjTDS9eleXZVGc9kE
	cvk64B0goHWTRwLh9h+RBZZRpzoJHGAvT5zlKLBHvOqgJLfDQdAxd10A/CUMDXUl
	cEl2S5PfetXf8QNlHbKCosSTnlVM6DKsZaOdZZrKZk6CzVLKZHDpox4ONUWWS+Em
	cPOfJg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n2mwb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 13:45:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e61b38eddso111170485a.2
        for <linux-block@vger.kernel.org>; Fri, 03 Jul 2026 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086343; x=1783691143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=Rj70q6qsx+bZ6l+AswC7+k9Ht7zn215LQIncwfzfjFTWyP1tQIIp4L1fu6Ldrsb5ZC
         du6QjPOsYSn/inr0AcnrvxRaN3/udaRVic4j9APkre0fFQ7yaLnSCS74kO4LrUevlwqY
         pfwg0Tmkhix1kdF2dfBCZ49+oWOQf7qzW2utDUPPMLkaGev71LV+E+Ctsb7jmkjHHaCY
         FCcXqU4lTE1bLAKV/RN2SNRDcNYXajfdNf/KoR0VO5wJOI47Oeu636aZrlwOzVPQwRzk
         2e4Gf655Qx5PpAEUvB6MVhtpfp02qyXtTDGATWtd7fyC6bS9FVnnUZtzIE4nI4R+ayiG
         XLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086343; x=1783691143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=kPFnzIdIJv0PwY7aXaBJrzHTBlKvR6fbuqvHMokmRQKxQHNjMCsyjeNgr4WWkxEYS3
         gTLwLTA5M3JbG3SzZh7Qfa+mWUw12CYFzro+36r4QRAZfQdtb77T6g2/5o8u4OTK6ou0
         19G0FKxTiTer54TtIFARyvh/hvCMNwMGbiScyJEKOUnIEWrWaLgbvYoaEAIO1Ic5GHXQ
         Ven5RFystJ+9OiKC91bgs854IWuAcaNT3cFHUrqi6NwmYcLW5AOsk50BKXt4WU8ClqbC
         fMPE8Z36uZVr3Ku018p1e648E9Lhd4lvTWWeeu5MyysDIhnXIBi7/ezXwsjW8j50btzZ
         Yibg==
X-Forwarded-Encrypted: i=1; AFNElJ/CEF+vimP8RwsOOsd0vM3HGXOvQRgV8WxVDD8AbLylR3xhU6JdlISOoSZKsDoH5jsSHLISoulsTpQyig==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6ihSxhhfVMZNMBlTndScyLVddQ9Wx+kEm7MGZ14r5y43Fd9D
	LJP28iaORnkDdn3NDuBd+dhKdCZLPjUeJOT8sx7mLhuZ5ITvIF8zVL7f4/dZB4sHWyoE5mgPblU
	5DKtXcINFd6ordEFJreV/Q3bt/6L9vTnCdVAL+mZ01N5+Kq+R6Fv5A4llQC3FkxWoDQ==
X-Gm-Gg: AfdE7cmadwXXdY7z7xkcdYoXE8ann1KQj6HtPUsre91HfhKaYHSR+EJl3QD+Hg5+NnP
	4XnEP5J95X0JFGulfZgZ4F3w6+MeNZRKKikkwbp07cn/yTZUB4fXZ9Fyk6chfumQ++AD+mbEL8b
	VoAvor+1XhYxvWOD87Stkd56B6IDNdbk37vzIojQVIzVqGBCEFFe9ya4cDwMTTev8BebOOwxGHh
	DXKUdAVTXQCbbdSRIfrU/BFsMl9l3VMhG5OVroJWMEzVkIjRumPQ9ryqkV7HpvdiriEAr7iN5nw
	k2oZnOUA4QTPz4PIY+Tel9scUG9WIZYLgGp8cswZSXP0H1PyQ2oz0cB/KrPCaYjGmgL1BBnQJry
	jGCzjt49VaT1plQpB+28VWwBbin7lWjWkUmzLf7iOGp0KZLmVM6pNGQjqXmbaLWZNEXB48axcIf
	w4NtDHQkZf8aexiFEPI9CsKU4ndCFHm1EOhLpB4YMYU4CXyw4fzl90QNmQ34P3owg=
X-Received: by 2002:a05:620a:2847:b0:92e:64a8:2305 with SMTP id af79cd13be357-92e7850c4e8mr1401572285a.57.1783086343105;
        Fri, 03 Jul 2026 06:45:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2847:b0:92e:64a8:2305 with SMTP id af79cd13be357-92e7850c4e8mr1401564185a.57.1783086342473;
        Fri, 03 Jul 2026 06:45:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:21 +0200
Subject: [PATCH v8 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-8-98ae32bfc49a@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX4bMOONTGaClQ
 FB6+1AJjhggojSWzI361s5Ox/4bQ0bzsMfcw9k1ynLZblLzyKLXs0HjUiSAJ5UhDC14TE5TIuB8
 FrwvOgurRtw+zfWjbSjo/bIdEHNzgT0=
X-Proofpoint-ORIG-GUID: mKnmEEtdZWSx7jnjfyg2GoxhOu4buKUO
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47bd07 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: mKnmEEtdZWSx7jnjfyg2GoxhOu4buKUO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXwth6mqVaPTtW
 MYDOIzIp1QgcVnmNLH43Fs2Vh2XEnHFPpzUJDnAGt1XugEeX1DCzDEpY8mU0qk7FlAuZd063j5d
 +WovvNZxw/VKXJPhbtYpl3zLNHLYjcC1nA6pZWm6YABk2D4Ck9wxmaZP5AP6NjslHjcU5CVNlBB
 6QF6bx11jMaHbbUbkP1jFNxEBnjKFuL/56Agf+kXSjc0yrZrC5aQszagX3K983sIzfDzC0Id8sz
 pgvQ2ZP+kEvkshvzKyZLjuRh61EiZxtVwJLvnQikkYeMLfpdy/Oz1lSAN66bTI3uIztA8XsRbtQ
 ksHsFTfHL5AuZXTy+tF7274Wfx/0JFk4fyC6zhNJuCYHm1M8P7c2Vyn2I8+RCTjNOJiuvR3SmLi
 5HpeNHU6u3CCULLMUajG+71VlaL3dOAhVxLJWdSKoWiGVcKcTDhC+H+u9ZuDnn0CjXj6NW+O7Gx
 sfKS267MKhCF2d02tpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

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

