Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD12DAFDE
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175624; cv=none; b=d0wTePIzke+4KvIuIDfpqmAnW8I4DHo038QRtoNw0x7YlaYcz7iURe+v5K2qM8H6hnRQXVClYgXi6RvRy8SYZnS9P49Yn05W/KMlQQLMqIHhryiB9NneVfLcxBY2XMgfSmdCk1/yN1E7ndxUbFnqYC4v6l/RcEjTllM3k08iTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175624; c=relaxed/simple;
	bh=JBLt41ByuMfVAH2/S7XKWKhhFcAaVJRhQPFjXgTlB6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=hDoPBGwRSKjTP+omNrtamyPYlR0njXQ9c9EJY1IsI3dAwXniEUAjumaXzXajLX8Es9I4Es0aoK49Xu3RknvRr4lvs3oUKqoqrxiEVxKVkROh9k9h+8yhoOzbOE+qfDAH3sTsVo7f+piswPzXJSZ4xS82ptnAf1RSQWhQPKl0yW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MFdMbaHT; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MFdMbaHT"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250722091339epoutp04c81cbc6592e1744de08f123d4daa4221~Uh_-u6wsA1376313763epoutp04Q
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 09:13:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250722091339epoutp04c81cbc6592e1744de08f123d4daa4221~Uh_-u6wsA1376313763epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753175619;
	bh=qEG6cq0xSvhzffmE0VWMcoqbvEFd/OIJKYCe+B9eKvU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MFdMbaHTugGjmBsWVh3hYhWD1i8yxJ9ZEmA75/CAQlUWbLMpvzkOX7JQvPnXgbb9I
	 azKCsdFpfcEwn0ucB+U0ohKJQgx72urWo+WXq5Th6KbDhdd4YZEJfEgQdHPdW7EN0q
	 zOnr0h8tRPtAQzD/jvQ7AVBrfNIdRGb26173uyGU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250722091339epcas5p34663f3a10c3ae80e4fb8723eb4c15de0~Uh_-gnOKr1257412574epcas5p3S;
	Tue, 22 Jul 2025 09:13:39 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bmWlk2Gvpz2SSKn; Tue, 22 Jul
	2025 09:13:38 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250722091328epcas5p4c8707b75d657da9e0590ba634977d71e~Uh_1FERq53139631396epcas5p4j;
	Tue, 22 Jul 2025 09:13:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250722091326epsmtip162d3290ae7b727c9ad6d4415ea2ddf57~Uh_0AYjHs2565525655epsmtip1D;
	Tue, 22 Jul 2025 09:13:26 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
	hch@infradead.org, martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH v2] block: fix lbmd_guard_tag_type assignment in
 FS_IOC_GETLBMD_CAP
Date: Tue, 22 Jul 2025 14:43:03 +0530
Message-Id: <20250722091303.80564-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250722091328epcas5p4c8707b75d657da9e0590ba634977d71e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250722091328epcas5p4c8707b75d657da9e0590ba634977d71e
References: <CGME20250722091328epcas5p4c8707b75d657da9e0590ba634977d71e@epcas5p4.samsung.com>

The blk_get_meta_cap() implementation directly assigns bi->csum_type to
the UAPI field lbmd_guard_tag_type. This is not right as the kernel enum
blk_integrity_checksum values are not guaranteed to match the UAPI
defined values.

Fix this by explicitly mapping internal checksum types to UAPI-defined
constants to ensure compatibility and correctness, especially for the
devices using CRC64 PI.

Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")
Reported-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-integrity.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 61a79e19c78f..056b8948369d 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -83,7 +83,21 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
 	if (meta_cap.lbmd_opaque_size && !bi->pi_offset)
 		meta_cap.lbmd_opaque_offset = bi->pi_tuple_size;
 
-	meta_cap.lbmd_guard_tag_type = bi->csum_type;
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_NONE:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_NONE;
+		break;
+	case BLK_INTEGRITY_CSUM_IP:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_IP;
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_CRC16_T10DIF;
+		break;
+	case BLK_INTEGRITY_CSUM_CRC64:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_CRC64_NVME;
+		break;
+	}
+
 	if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE)
 		meta_cap.lbmd_app_tag_size = 2;
 
-- 
2.25.1

