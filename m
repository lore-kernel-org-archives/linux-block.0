Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608442;
	b=UBU67t6N40LIXC/Ql/KZFL38QEjTB8gV340kz3P34H/zod46BPzvXV2j7INWmmi6T5O/
	 J6gzjK3Qo4u72DyzEdelQHq0Vhjfqog+9lxxur2HOC6xnxSBxsQBAud7qhmqT+wX+/jXP
	 qmEBEummbGE9EVBTWwCqx5jTDNZvuqbFV1bRMCasWosV25XyRVbEgwKddVmcJb4pWlHEO
	 vXbQy+fPLQ39Gc9GsnV7gdZWAqQfpClS/lqUkV/gRtcUoPrxzZXcq94LAXxDqSPcy7XPk
	 KY4VbWKgUiPSHUBAvnLG/Ix6jJlOs/3LF2urPt3BjYokH90/bbvs8f6fful5blECUpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608442;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-FB-Internal:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version;
	bh=vIH9Q4srWAzZV4ros0rpTOQQCBVci/zaS1xLRE132NA=;
	b=fLKPvn+/l1ZazcJXu9S4cjkw623vWjRm6v2LTAYiGyvproXsCRTZ9ODNWvjfT8WQI+/R
	 UD3egrsXlqjK3raG7KXZlUnB1/Nb+ZY2l239C7f2IjTRX5bfBqOQOMq+uR+coHqQmbcVD
	 ZQ8i4oTacKEoEfePwfgwFBFH8+8iRvc/5WNdGPCVwroA+wS1k7DdOPTO/0y3PUUeM3ELl
	 wx7vZmCX8ImWQTHp2Sd2heDHI3oARdQx86kR2obOEYYaZyMni3T0DNcPtJlBRtuOEa5TV
	 dzJ/rdS4hRIWv75+XYMU8sCtFsLFvFTg8233bJWNoXLt9it2Xd6K2/BZV70nWFLIuXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=edhhW5LG;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884B606A319
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 18:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6884B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=edhhW5LG
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LHrvQv2288347
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 11:47:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=vIH9Q4srWAzZV4ros0rpTOQQCBVci/zaS1xLR
	E132NA=; b=edhhW5LGlSgI6dAuDw2hblOVCAgXCNATv+qbb+7D2YuWRd2TpWxkh
	IjM45kIxn+hCmMhJWzrNsH2p3m8jhlNtzhvzn0wU8ZRDHsMSH0CiKtRZJ6J/n4j+
	mtVS2uVuKQ7GyQguCYffRGq2eTHub/iXvsG48S/Z2UbCzHTxW/OGY4I+JbBhOgTy
	doaIXoqGXNQj9a2wpp8VPpYmiiiCy1wFF11fOp9q87jLDt5j6uIRMxttUmS+tSVE
	1MkzHLbML8MWPfIG4XSXEhQtWiqusjeoH/TEJPkjLvoXOjccdF0NSr2nbeMYVEpD
	RiCbE98V7JYNbIRVS9N72Smn2Wq86XkHA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hdw50euc1-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 11:47:19 -0700 (PDT)
Received: from twshared17659.01.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 21 Oct 2026 18:47:16 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A0CE42DBB477E; Wed, 21 Oct 2026 11:46:59 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <asml.silence@gmail.com>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme-pci: detach dma-bufs only on removal
Date: Wed, 21 Oct 2026 11:46:58 -0700
Message-ID: <20261021184658.644645-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261021184658.644645-1-kbusch@meta.com>
References: <20261021184658.644645-1-kbusch@meta.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DMgacCNb c=1 sm=1 tr=0 ts=6ad908b7 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=VX5OWN6_KMkPTkhSNNQA:9
X-Proofpoint-ORIG-GUID: CoCupOvbuWiKWln5oAYILnAqMORX9LW5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX4mwuxjvlhff+
 lutVXojQIjdPmqcsBCky6dwXzyywY67/5rUT4Necrc6xCOaYn/dV2sAH1k7PSz0eE9VJr/fXClq
 /mPsUC8npyDX/bBUBNtXZIFbOtZFZDO03p2e8H2wA2A5dVTnxT7JepREls92oDJHuP78I996kSJ
 EBg6aiTIuLP1lt1I/lxLFj78SeqoJr9GPxzM8OcpDVHZUsBfXyYLfH5C361cuu7SOoureWTsuO6
 TFYjkAlcnqg03FH1r8wbo34p9wQlTb6AkQz+CDW1rms5Oi+MydyfTMOeZnOkN9VJk3k8QpO37Ln
 FseMGuR/0R9YDlyB7X480mi5OHmLzcLDpzVzpbbpPR9mEQZT/iN7i65T9rMBZbL5IkdmbsmZJlT
 MME7za48eDg7r338q/0bZfyJZU8RrHXOCH54zp3CGvzQWdefRIx/lsMsDrrCkv1apwn/e4/ckoa
 CZOuuwKWa+6YXG3IErw==
X-Proofpoint-GUID: CoCupOvbuWiKWln5oAYILnAqMORX9LW5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX0FZc9aSLUxTA
 APGKRtTCsdBWNP1NIdg+iTLXO1HPcX9AMoL63o7fnGagZ8b/yV2zPwFyPtYYYOGZnsosr0pqHpl
 Jl4tHn1b6J1Sjyj3zjLcbKAtvDpR3Ug=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Detaching the dma-bufs on every shutdown permanently prevents dma-buf
I/O after resuming from a suspend. The mappings remain valid across
suspend, so detach these only when the device is being removed.

Fixes: ce5e386c1108 ("nvme-pci: implement dma-buf backed requests")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9610e1ff98a2d..a29de6e520b29 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3578,9 +3578,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, =
bool shutdown)
 			nvme_unquiesce_admin_queue(&dev->ctrl);
 	}
 	mutex_unlock(&dev->shutdown_lock);
-
-	if (shutdown)
-		nvme_pci_remove_dmabuf(&dev->dmabufs);
 }
=20
 static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdow=
n)
@@ -4150,6 +4147,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
+	nvme_pci_remove_dmabuf(&dev->dmabufs);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
--=20
2.52.0

