Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608440;
	b=RYUkL/TeCxFzVhAf12sD6RgadbCzbIUzI9V8SVeEbUm9yr0f3RC/wqw4gpjdfqMv4f4l
	 e52cBhdTZ0RD7CUYwEGSDfg250rDRb1fDYtNa8du9kLc9V533hSF5RyNtbmco2kWbS8XN
	 I+gM8gBC5geUWdsygq4eSe45cl8RS7M1U/CZytGtFyvDwjnqhUu1YKcwQ3HICasH8lSyU
	 5zWjkHnwqyBat3DZ4BSgPcD9xWrNRHuBR2TLvStrAQ/wJUZPpAX0rgSyF6UkUaqh2ELeT
	 9D0CWUGWgYwqhe0W+iguc+BFuX6qrxOZSZHeCNPc9LqDqQtumCLKKE/LT9uFraSJInQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608440;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-FB-Internal:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version;
	bh=3xBrDcZFd80Ul5kXzUkyKrsSjyIhpaV6/CILIoL496g=;
	b=P18WtxXuTUvywh9QX4s5ORNOrEoPBJiPsDMkB1/udqT18gh6aBNKfDW+kwO8vy4F/PcV
	 94tEY+M7SLXGIPcVVdGoRZDhx99hM40mnN0tbbQ6Rshc06tla/xiNXkEK3zgvT46KcJYm
	 fYNfvvzsyhL/p1HxtpJtaDaZeLVUUdT+l14B7DoxjjbZpKzr06sc0lmDfxhvYYRhEIFUS
	 jduYrejXVXqubINYJxSbqTtno8+OGHhZjPjRsHA/Ee9pbaUb/r27oCiQGnH525is68Qwf
	 YWCse+5aGq2yEOVJtViAMfCxfPy2Z6iI850vch7YQ2OpNzv2Tu5RuJdrIKDy8AVd0Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gqrcj7cL;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E9A606A320
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 18:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E9A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gqrcj7cL
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LHrvQr2288347
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 11:47:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=3xBrDcZFd80Ul5kXzUkyKrsSjyIhpaV6/CILI
	oL496g=; b=gqrcj7cL3fIFUR5L5PuBYwrN2ZXXVOcA/3XAjPIatsD7GboMTeonR
	ZxAgI2VrRgymi0o7NA4d19ceaklLrfFcxkOpQVGeOaA+Aw/uEU2G/oyJBkQSXGqg
	w/P9/n5f4bHNs4969EkzPrODrmBvzJo9TtEd5NPG6vNLxGwwQ1YVL6vABU/ZfcjA
	XccTX2Vu/tv5i2QirR36vmxPDmk6shYZc7Wa6lofo/q+yU+Kcj4foLgKZB5hn48X
	QFT1dOJGRaFp+qSYkAQ0HqrbmPvAub7gynCpXeOXXT/p0auoCY7TSwT8Ray47heB
	obVhrnbgDhfJhf36P68DrMjYSAJ8reTcA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hdw50euc1-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 11:47:17 -0700 (PDT)
Received: from twshared31846.02.snb1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 21 Oct 2026 18:47:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9B4FF2DBB477D; Wed, 21 Oct 2026 11:46:59 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <asml.silence@gmail.com>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] block: reject dma-bufs larger than 4GiB
Date: Wed, 21 Oct 2026 11:46:57 -0700
Message-ID: <20261021184658.644645-2-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=DMgacCNb c=1 sm=1 tr=0 ts=6ad908b5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=kMFwTpXalVGouGIobfMA:9
X-Proofpoint-ORIG-GUID: 5-7ZOSyUZdi4QzTWZ4-uC4DSxlw_TGEg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX3nQm4bknivOF
 yB88w3mlSUkdvRcgzjXUKEQXmXwq02qfK6ij95S1vncea4lScHWC5oZJlxLznvIOGoXvxfW17HQ
 jyD5EOshDYRAbrxuzf3pUKVau9lMtQaDcqeM03bI1AZEZU+5Lr0ccmY9wOoi9DzjoxelLGvjHTi
 u71YAbPOhIDp3QQKicsR2IAqGShQe4358zRdaXuygWHhAeLkkvtvGjA6JGQ2oG5Xpnceu2bBV5i
 1h4BMe73PXGanWrRzDsIjRDJWhObLh5ZuhSLsRDazQ3aYSBOg2T7ENcRvnR4nFj05BSvWPIeDpT
 UhmpZdeYSouqV5ldeD712PhrtfZ7woHdNM/5SsXL2LZaWuWsrCJFA8T/JzNBlqzjcXNjfe8Rg/q
 mhNh2WhijlDnLxCKrfQ3VAxIp/L2lcWh8Cx0OQhcvHewJXOHT2p3Enm5A0G+RxIPTHpfKxTGr5v
 vu7Os17QJT5VZgzt6jw==
X-Proofpoint-GUID: 5-7ZOSyUZdi4QzTWZ4-uC4DSxlw_TGEg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfXxphHqSUMMVSw
 aFMdi7p4t1rmIjnIeQ7StCTIBQNJOBtqr1Kz6rVdlVF2VeCr9iMj22KLCADs5HkPFb1UU6Bl1nG
 phT3NfCY67q1EA9Ws3tfl6I/HvBXdSc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The dma-buf offset is set in the 32-bit bvec_iter bi_offset. Reject
buffers that can carry an offset that would wrap.

Fixes: 839231d19393 ("block: add dma-buf support for raw bdev")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 3 ++++
 1 file changed, 3 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 46cb86dd36d23..a974b423869eb 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -19,6 +19,7 @@
 #include <linux/iomap.h>
 #include <linux/module.h>
 #include <linux/io_uring/cmd.h>
+#include <linux/dma-buf-io.h>
 #include "blk.h"
=20
 static inline struct inode *bdev_file_inode(struct file *file)
@@ -1009,6 +1010,9 @@ static int blkdev_init_dma_buf_io_ctx(struct file *=
file,
=20
 	if (!(file->f_flags & O_DIRECT))
 		return -EINVAL;
+	if (ctx->dmabuf->size > UINT_MAX)
+		return -EINVAL;
 	if (!disk->fops->init_dma_buf_io_ctx)
 		return -EOPNOTSUPP;
 	if (bdev_has_integrity_csum(bdev))
--=20
2.52.0

