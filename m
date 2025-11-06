Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CB7223DE7
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394112; cv=none; b=osKTJ1AQtKlt8x8h6ev/QrUIgUOlFGqdzsck36AWywumILH5fVbEBYytba3DJOGXQb0j5rMK/Cas30UxdZ6bnZQrOqzUm/uq2uRn7HG1rfooB8K377hnBs0i8EdkRACQPurGfcEq9/tf7hRQwJGyP65sX6yx2cK8A3sZ2MsEvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394112; c=relaxed/simple;
	bh=olItVMhdg0KNcXU7ZtKH3abgDaOlkWdzO0kdx0piR0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Urmy1Odie4CQt7em1CweMhBA4ocKzPFIiRK2AMWVnViuRA3aXMNKVOftWatAGGRo3YrBdLInD+oxRrvrulDfff8G55pRLR9BXNEwtUl/ZTuWQGzumMvXQdSqG+11g4M+KGN2l7sYJEyrDs0h4dH5FOlllDsO+ir0GwueVn6L3Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CYikT6uN; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CYikT6uN"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5NNaar1709617
	for <linux-block@vger.kernel.org>; Wed, 5 Nov 2025 17:55:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=taQThH4j48oUS30efI408gM/CoZUbGqdk8a8gmOmwFA=; b=CYikT6uNBY0d
	ND3Xkqt78rMqH0BivsHy1UZhIEs9SpykFyrFZCvXwlzYOw0iLpCwvZkxFZpRLbQM
	Mcef9hEG90jzAed2wZkp4mCOPz9JIqJAmn4KxbP8ruzLGtBaytT3zjOGRdOpjVkH
	b4n/HvfcIJEQjuakFqXekRNwFYmcHvyrBgx64mXECnYF7GgXEOQNujcoqXFt/EH1
	t/+4Q6U1nI64KCHDCv3OVJFQyfzuM1sKImpw4jcdkQtU41P/0eSn7WyWoblDBbdW
	/B2FhKsYY1ZWpK8Xf0/0vuBoYrJeHhUg+nWoDnBJdLB59wKXAB4uoeoB+AYuq3nA
	E1sRzksbqg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a8g7dgv3s-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 17:55:07 -0800 (PST)
Received: from twshared41649.32.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 6 Nov 2025 01:55:02 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A87A03789B20; Wed,  5 Nov 2025 17:54:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <hch@lst.de>, <axboe@kernel.dk>,
        <dlemoal@kernel.org>, <hans.holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/4] null_blk: consistently use blk_status_t
Date: Wed, 5 Nov 2025 17:54:45 -0800
Message-ID: <20251106015447.1372926-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106015447.1372926-1-kbusch@meta.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: y5biT7yRr3gSwDO-NtQImohHqvJpmgZP
X-Authority-Analysis: v=2.4 cv=FeI6BZ+6 c=1 sm=1 tr=0 ts=690bfffb cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=ZRft5-St5gG_Py4rEikA:9
X-Proofpoint-GUID: y5biT7yRr3gSwDO-NtQImohHqvJpmgZP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAxNCBTYWx0ZWRfX721AagIBVBqJ
 yIldyqKWr9hUdp2e2iiVs1NxtrRP2CuzR/Fr0xBGulNVyZpN4+HtvYQWPxgAya5/dBsUNJ699dH
 m2YpbBQR1U6ICxh2O6UezCDRt7MxoJ8qeKerG47XWzRNHqO94ZMWO8bi9SYqUM/HenDCPgHCy7R
 EeUu+mjwSEzrKFOWfM9lEkQLphy8jXGh6m1yGhzCU5QXKxK5lhqLTqzWTcHlapOJlODQFcdWrSW
 3Za2/nCr+xoGcjdgeuS2uTJo0QKQKlPKDda+VkBFcv76+3CqQexBFnisqcpOEreEhJCfL2vh6kj
 1BoEsu7R42R+bb9U3G7T7Hi1eGXfIPGNvpGpaZcT4t7yOo8pKfAfEk+1bwvESJmb0RMNmmK7TxN
 jCV8IaogfnhTIqRXb/nyNjtcuhW8Hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

No need to mix errno and blk_status_t error types. Just use the standard
block layer type.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/null_blk/main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index a8bbbd132534a..ff53c8bd5d832 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1129,7 +1129,7 @@ static int null_make_cache_space(struct nullb *null=
b, unsigned long n)
 	return 0;
 }
=20
-static int copy_to_nullb(struct nullb *nullb, struct page *source,
+static blk_status_t copy_to_nullb(struct nullb *nullb, struct page *sour=
ce,
 	unsigned int off, sector_t sector, size_t n, bool is_fua)
 {
 	size_t temp, count =3D 0;
@@ -1146,7 +1146,7 @@ static int copy_to_nullb(struct nullb *nullb, struc=
t page *source,
 		t_page =3D null_insert_page(nullb, sector,
 			!null_cache_active(nullb) || is_fua);
 		if (!t_page)
-			return -ENOSPC;
+			return BLK_STS_NOSPC;
=20
 		memcpy_page(t_page->page, offset, source, off + count, temp);
=20
@@ -1158,7 +1158,7 @@ static int copy_to_nullb(struct nullb *nullb, struc=
t page *source,
 		count +=3D temp;
 		sector +=3D temp >> SECTOR_SHIFT;
 	}
-	return 0;
+	return BLK_STS_OK;
 }
=20
 static void copy_from_nullb(struct nullb *nullb, struct page *dest,
@@ -1233,13 +1233,13 @@ static blk_status_t null_handle_flush(struct null=
b *nullb)
 	return errno_to_blk_status(err);
 }
=20
-static int null_transfer(struct nullb *nullb, struct page *page,
+static blk_status_t null_transfer(struct nullb *nullb, struct page *page=
,
 	unsigned int len, unsigned int off, bool is_write, sector_t sector,
 	bool is_fua)
 {
 	struct nullb_device *dev =3D nullb->dev;
+	blk_status_t err =3D BLK_STS_OK;
 	unsigned int valid_len =3D len;
-	int err =3D 0;
=20
 	if (!is_write) {
 		if (dev->zoned)
@@ -1273,7 +1273,7 @@ static blk_status_t null_handle_data_transfer(struc=
t nullb_cmd *cmd,
 {
 	struct request *rq =3D blk_mq_rq_from_pdu(cmd);
 	struct nullb *nullb =3D cmd->nq->dev->nullb;
-	int err =3D 0;
+	blk_status_t err =3D BLK_STS_OK;
 	unsigned int len;
 	sector_t sector =3D blk_rq_pos(rq);
 	unsigned int max_bytes =3D nr_sectors << SECTOR_SHIFT;
@@ -1298,7 +1298,7 @@ static blk_status_t null_handle_data_transfer(struc=
t nullb_cmd *cmd,
 	}
 	spin_unlock_irq(&nullb->lock);
=20
-	return errno_to_blk_status(err);
+	return err;
 }
=20
 static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
--=20
2.47.3

