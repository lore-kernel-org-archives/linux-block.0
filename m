Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608438;
	b=DaXpH3CLSAlx55QLuJy25c2cRcwuhcrkPHSPCVcYRmGNjoOQ2O3SXHBGvAjP0Ve9mAyx
	 91jOujNU0LAygqR9TWGlPUdDp7AmrdLd7+0tJvOyI44C6C8A/J+AluYTBpw+lGOn/XFDP
	 b/cgoIcg9ZiHntmBzAmKlfdMcqWu6CNQ30rAyQkgOpNtKW1ZF4h3zf2bNX1Hhf27zOUz+
	 FhvdV0weNtfFhHw11znVRrCZaSM7B5IV/cTMakIyTypPp1E7FXwHa7SjcO4iKevEvPuN2
	 sN0NHbQEhZaGHeXkgJN2Q0LLPohGO0CfzmBY2VuFbbnbGBHdN46xaTv8RLTJuR617TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608438;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-FB-Internal:Content-Type:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=YaoPxe+/5/SGWGLLv6ukiV9xF08hHeAvEmpAkUT9KdI=;
	b=BP7SNrzmDJEXrb46rZO28jEyRXgKLBnXCd0P/KLwTJCPShu2APQl9QHxaiy1uYsJH0yS
	 e/c0Bs5ZXj4V4P5rXogKg02TzSWSrN6nx//p6+juN8R8B8g2sb7RVLQ8Rk993woFozhVa
	 Cbk42xx3FtDY7DuPpV3eds3U1k0QMoyGOSX1QN8LinWH4ZaZxnWZZRcfEAz1byeFaCV3h
	 0T2fytS2pa5yx8E7NkwDwfjlxQ78n6YTkbtut4hBR5sSzzwD3D7CS7fG+7+rFTD2BzXUM
	 vKZTd2XxI/E/eB0qgOY7gB3eavLHFvdQmeDBgHr5PD73LAXHOVpL5usPckpQOSVemgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Xs2Qsy3b;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B63606A319
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 18:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B63606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Xs2Qsy3b
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69LHrwUu1477582
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 11:47:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=YaoPxe+/5
	/SGWGLLv6ukiV9xF08hHeAvEmpAkUT9KdI=; b=Xs2Qsy3bhLKnq75xF3PRwEb5S
	W3yVyX/q7z+xCKJZyKUa2yBHRhbWbnm49xFyk1hFNY/O5lDKEamYx9h0HfMyL+Ma
	pv8YyJjkyT3ylgzVBFFmVE4fAjN3I+rwC+64WgwMsBQ4ceTT+leAxDd/Axw3vZZV
	dwKIe/YKzrT0hDdkvABXMdjCg5kX6VWzNdJicT7CKbUomkFNcnJlYK7YqR8rtt6v
	NWkd0L9i54MRDO8cYAMKKOrdmsxd/yCzKtUtQathUqlR9w7+kxf2RaBtvwqHX52c
	OCThjH1K7Pl0E4VWJdmqfEdaGXXQfWZy9k2tzmXVJnE0fd13B6H/hwsNpgGvw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hdw56xu11-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 11:47:16 -0700 (PDT)
Received: from twshared31846.02.snb1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 21 Oct 2026 18:47:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 972612DBB477C; Wed, 21 Oct 2026 11:46:59 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <asml.silence@gmail.com>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/2] block, nvme: minor fixes to dma-buf support
Date: Wed, 21 Oct 2026 11:46:56 -0700
Message-ID: <20261021184658.644645-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
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
X-Proofpoint-GUID: 8KM09D_OXrWypPauYzz45CjG2hc3kP6E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX7S0Vh8NhBufo
 SC+pkshj5cVKxw+LAFSnNU+gQnl2nso/CUMbnA5sQeh6rSqBVgwdvY0MaAo5oZ+oe78zGmHHYdl
 BXTGv0fH594YqkHOjx10oqNYhQY8Vb6qktsM1tKYBDYkjO6qPOldu3conO9qGx5KyBPloYFCIWS
 GaJvaTVCfCQVrrr+JvHW6aIGORcM/wy1dICLmEP830QqnyIxiSO0INYuI2qVhusl8+0MRZDZXRT
 zIvpi4lnEHzrM2w6+EttCskJua15JoLBR5KgXXGEtukbfB3ibb/bouVpOw07PqgUgv6JmLQPXfo
 2lLyBGzA45LTqXqr7tYoOQGXn7Fyw5eAy2btZzyQIvk5lcSbuQCyJWXxoSbqS0XYoMNADGsFzBq
 yIR9biUxT7DqLEsRE8wgZWtf8D6DFSBH9Hxch6d5TwxGFvh2lE1bq0r5NgqF95lomlhhDibqpbl
 zi+eY4tXG6C9EzFqJXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX1DIYtnRxiw29
 io1uznDC24YwdgOhkedWfXcq00Lo06ZvpZJzYfM6gWmL8TNBMbo/qUddey2jetY6ut9NeHX1vBo
 yxR7/0nkSZsB/mnE+XgCxj+nehrd/ZI=
X-Authority-Analysis: v=2.4 cv=J+Q/fwnS c=1 sm=1 tr=0 ts=6ad908b4 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8 a=feg3AUGto1_ON38LRJ0A:9
X-Proofpoint-ORIG-GUID: 8KM09D_OXrWypPauYzz45CjG2hc3kP6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Just a couple minor fixes. I wish I could say I caught the first one
myself, but no, I prompted an LLM to look at it.

I am assuming changing the bi_offset type to accomodate large offsets
isn't acceptable as the bvec_iter's size appears to be packed to be
small. I think there's a path to accepting larger offsets through
bi_idx, but the patch proposed here is a safer quick fix.

Keith Busch (2):
  block: reject dma-bufs larger than 4GiB
  nvme-pci: detach dma-bufs only on removal

 block/fops.c            | 4 ++++
 drivers/nvme/host/pci.c | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

--=20
2.52.0

