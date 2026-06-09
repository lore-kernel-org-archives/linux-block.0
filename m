Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260243F54D8
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991624; cv=none; b=qwKqjw1+iWON0utGiULCmjndTjEp9+BqRbFqpc+BsWyjfmobZ6R3f6oWTjPmSV9pCESXPLrrV5gJ9mOtxtu9ffkQyaTHevWDlYvDTi3yvPpCqAVMHDUo9vIdEpkVNXvhzgK1aQVClJHD7IDp35EJ+cM5THkl6orf0iVV/AKhKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991624; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNQCthmJlZmzv4cF4TJadupq+BMefqC8NLS9zSeuXZmWHz6SCZ4stZihAwwRFxurRmghlWPsipKbVi9tRxS8mgveXdfPUNXyq6TdKpgsv5DUrtov26OFYCrubfEX43M7F3jD1F3DshBZsRCE3bfTZLi9uqvVDrHz2VGL7RJPIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDnRdHs5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LCwN+FzF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDnRdHs5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LCwN+FzF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rgKr1568441
	for <linux-block@vger.kernel.org>; Tue, 9 Jun 2026 07:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=pDnRdHs5lvUfpYdk
	Ud7E9GB+W2dPNMQO/F37Vuj4hfqhj/dnsPgXUigUgbsOozzEAotANNaANu2+epFV
	RZXk+ZcPNYW2muCs5isIcfRMowSvT8ovPCDdjGvQLfJ1fAlU2vDmP0d815XesRRc
	cEqYZgd4Ojg6gjoN18HGi0nTRx9ok2UBrBSV6TRnoovNF+dxD+9f9Rk8tWqeHaxS
	rxToI+W8CGDXDn5OOU9hNQ3hOkLV6VQC97yivM6z0UcRKs55eEXVJlQ7TmsDrkdb
	M4JeYKR0v0lrmSdYdrTrZTFD8zllT2t3jeSt57u4g8FDAM3mV34VZCPfafE/RJln
	/zyrtQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxx45ga6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 07:53:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51771d41426so99175751cf.2
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 00:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991614; x=1781596414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=LCwN+FzF1NDTmCN4MqqtO4+rM54cxcZasLV11jjMbK/7/kRTr3l8UQMclObpboCkw1
         ucCeNbVgNHpmPozxgT0zbSHD8dxxMXOWi09bAujOxlin73Mh8wYMeaGVE50DLvRKxa9F
         jsmn6gY5MdCl9tSucm+y4ex/yPHbat1XVdZCC56wqP5SuclL5wf3u91gquzflMtpfh09
         Sb2tTSgfQduJL6nr8VajlAku3GnxzuF7MlgiycrIS7KP3lUbapTWz6IdASN/trPNzmc0
         /bvAkn0LSgDWVaq4psl6qugBjxFhgxFCVZLfa8+ol+RN0dtxHffLHBg7FbxvzaCWFCB3
         IP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991614; x=1781596414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=DZ9Glet4iYqo6cBr1rboOVncieKaF/MgdLoNtdhBtPUELBrLnxOUFr0tVKfdoTYqCn
         PoyY3mnuVrOxwK/bf7JKirnLXNfX5EbemKS5cCeSJXP2Xci6k2mj3ExxbwtrbmcY9NIt
         QxIspWId3GMd2Z9o+ROYUOuLVL+RRAy7/uidbODl7rP7amHdiUYlhdlBYsZmP4J1RHL1
         aAK4G0LICbeT1D/6rCiKLVI2HA8QYBHEQ8TPTAgTA4YL3yA+cwY0Qh29j2IT0FMm3kSh
         29yOORkghMk75FGmnfGNhkdAirirN1Hh/NBfaO7E38cEM+t7paFpYRaOR6EDYOKWXf/+
         SVNw==
X-Forwarded-Encrypted: i=1; AFNElJ/0ea4w8yZsYWLLpbSWRb5j1dVkOVx8wATt7Gp38WeghlSWCUZ5/mlXqbP1rl7urML9A93c+XXoNmkYZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfL02w3CzsRCLeS7/T6dcwOMRJShwb06UfrvnNcSj6vgBV39GH
	c4poTjz6WltpE+QSq0nsVQWZqALT47Ou83VySO4h1hWR2oUAF6FzYG30cjrNKzz+QZ1684e7Zp/
	pkuj0CuA0qztnpb7nbN/x42AwNTDdZ7vjBY4i8zBroOvtjrYEqPrhF2A7JaEEykGpMw==
X-Gm-Gg: Acq92OFqoNF4BaNLFBf8HnopMo7rj62Jeo/gbTCqRKHEy27aQVAeyLOnOIL7AMrAoYw
	u/kR1RcAyrk/W2/WeMs+/d0auhQMDsUC/dp5wqCt0q84IxUmrbs9NjF2cNIo5AFNn/6/m8N5bFh
	3n3Xcqblx8Kfm2ckgF1pbUKFbdKycmlLh3pHiG7RGrxIPmw59qJ00h+xPNfyUxHkRvA0hyTnY43
	hRY5qKSG2hAWQxJfxw7bmceQpjZz+Kf1dfVijyVkuk2a+wzu7lTPwR4+R3sTM+8ib6pJoUJ/Hkh
	eWzVwVimIK1eKwCUd6s3hlF738ZM2SsHxYag1GsCW7okh7lA8pu6M8rNXwD9bx26TtX9ZFb1OBN
	9cCr6js4WhJ0qIkSArdbUNxk91Wcg1MGcOZB9bx3ge7RGV9abwYxkHq3DXWVSn7m4LenSXXjVz6
	mXKWt9v5qL8nQSbMw6nKZai1xMlwcIjM+tbImlL0m/GOSDg8CYcsno/ZPDqOTPdH7EGKJbQikZ2
	jut6EFP+UvT
X-Received: by 2002:ac8:5814:0:b0:50f:bb77:a084 with SMTP id d75a77b69052e-51795afed1bmr263903601cf.25.1780991614428;
        Tue, 09 Jun 2026 00:53:34 -0700 (PDT)
X-Received: by 2002:ac8:5814:0:b0:50f:bb77:a084 with SMTP id d75a77b69052e-51795afed1bmr263903141cf.25.1780991614000;
        Tue, 09 Jun 2026 00:53:34 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:32 +0200
Subject: [PATCH v4 7/8] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-7-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=cverVV4i c=1 sm=1 tr=0 ts=6a27c685 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: dtmnAkmsVgMl5EbAK7-t41ZBpAU7oiY2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfXyKs4xIHNx2AB
 xom47vMMFVgXmcVJBl4AMNBFHkIQUzmNh5VgasH6jR/a5+gnwhxASU3L0GLu4rR2kTEni4Py0c5
 jLmNxRmok8RzoCDrM23RBW//x/m6mfhlWALoNVrji4P1sXehDFK6cJsrlgGD8RHbwsyGl7KPbDR
 Ucaw11L1GsZHlw11t7UhLVmJ5NuxMPlzBePqZXaIQAQV4IQnHvldNEFxZODjPGeY2Y8MOIWVaJs
 8tQeCvV4o3VF6ftbScJtjcgwwqtSTZtM62OCs2aDGI4wZXLMQAsvzxIo+RicJzaUutlHnWTicn/
 0qnN2Ed869GCU+Mze/AmU2zPE+cdlERcT5eVxsTBwbyCROSo0YlNV9Q6ezCik/QanY9zHVD7S23
 Fpq3a0iR32vglCVbb4GeRlYxz/e9Hg==
X-Proofpoint-GUID: dtmnAkmsVgMl5EbAK7-t41ZBpAU7oiY2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606090074

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

