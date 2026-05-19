Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFF27281E
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211451; cv=none; b=CdQfMcL2ZRtvilDPOMl/6PJsKEaMobi92ykg1Tx7mlGouJbyqBpLMixRvbLzmRZ1MrTVWi5Ppb7/IzMeugBfI0kSHbLO80TGCgiVM9KC+TuNwVBHFNnlrN9w+s9TcXL1gvgqn8i10Q4DPR5o0i4FkTm6TT2clPtEqIVuf7cAQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211451; c=relaxed/simple;
	bh=xHs0yFkztIznLwb33EEnA0Kjl3n1+393w46rYwPRLvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfSTVKbL0WmE0z4NGr05c1+E3uqKbMWiILeMLzsd14qKYdhM6i/zklecgI4JDYTWKeZqrFzdlwncWu9c+blDqnwTeB0kZn8b3h2n1emjgw9igLTv9cRvLWSc77koueZX/d05z/w4TsrXF974yYXUt+MHwa9Zhmuo6Owdhbk0gR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=de+0quj5; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="de+0quj5"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J4VXVX182059
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:24:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zy1ofmOP6PSRwOaZNgivE8Y4y6QkgY6sla0k7S7E7Cg=; b=de+0quj5V62B
	kOO1nbP2jsBQY055/rN1A9xHIDKh4RxevoK+crjDDdK/rw0QjVr14bH7YehoNaMX
	V/FrCs1p1PkxADqJLBLzGFworXaJH5ZbCm4yllzxoZ53xuyrGYjoUF5DOfVRvPJ3
	My6o0W0U4MnyE2hvkRlQ1PZ5FWusyx5SUZQgtKeu2todQk3I2epgRTUmrsbqP+tg
	w7hN5wj2jvJXJtDvF6bL4HguMQPBoEIQYu5EEo2SUB0fQu6lnTGNcmSdxabo2i4j
	jki8AR37KivD8pRRfTc9b14kIU2+1DSXOSIX4UtEvwYxRci6cUK03j9eN3xJRsOT
	hb+uSs0uOQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e6p3bskgw-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:24:06 -0700 (PDT)
Received: from twshared23877.03.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 17:23:56 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 637E31A75978D; Tue, 19 May 2026 10:23:32 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <tom.leiming@gmail.com>,
        <coshi036@gmail.com>, <Igor.Achkinazi@dell.com>, <dlemoal@kernel.org>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH RFC 2/5] block: fix invalid zone append status
Date: Tue, 19 May 2026 10:23:23 -0700
Message-ID: <20260519172326.3462354-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519172326.3462354-1-kbusch@meta.com>
References: <20260519172326.3462354-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3NCBTYWx0ZWRfX3pdhfRypMWEb
 V8EOYtCNsg1BntvnRyjCTvNkLeecud/HtTHcXZ9GrqXLQLpJVv5Ma3IyKews14VGKMvr1mwUlpf
 hhEW0If0u+iZC7cIZOVlsrNoOFnPwayBnYmPsqcj7J1lUBEqO5bFjWsMf4macsIvQpwrDJpAQha
 kKiOjjviR8spx7/E0NG3DdVceYo4WlIGQ72VozMOKVFmqtPmZ3RGHF2+9wB+61/yVeGs/VwJcAP
 z3577oewFl/kyRmZSFTB/qtXhD5t1/40cKn6d3FvMV50t5XjleJDAjTtuKDL5jAAkw1ZcbfDext
 iiqRKPJNB8Kg/0ZSPSeq/rJQiLORcVIEZWvQwpY/XOZSUIhGJ5hDVuTmoXYaA1cm5y6SUiY36WG
 gxrTewR9WdE/SlE3mBRMbH3NpQAXFblvBWPozmb5HSpqyvERX0rU4qbKp1P1KS5bf9IJosGNAwi
 mxIPC57L12FnC9kKWMw==
X-Proofpoint-GUID: IoWKTUCIuQgqP9AfB-tKkmIxoR-sL5Cr
X-Authority-Analysis: v=2.4 cv=K6cS2SWI c=1 sm=1 tr=0 ts=6a0c9cb6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=xkUBQ34vpCiLUNs1zEsA:9
X-Proofpoint-ORIG-GUID: IoWKTUCIuQgqP9AfB-tKkmIxoR-sL5Cr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A bio submitted to a zone block device that breaks the limits is invalid
rather than an IO error. Fix up the return code to report it that way,
as the previously used IOERR is considered a path failure.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 22af5dec112b5..92a802dc8042c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -604,7 +604,7 @@ static inline blk_status_t blk_check_zone_append(stru=
ct request_queue *q,
=20
 	/* The bio sector must point to the start of a sequential zone */
 	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector))
-		return BLK_STS_IOERR;
+		return BLK_STS_INVAL;
=20
 	/*
 	 * Not allowed to cross zone boundaries. Otherwise, the BIO will be
@@ -612,11 +612,11 @@ static inline blk_status_t blk_check_zone_append(st=
ruct request_queue *q,
 	 * different zones.
 	 */
 	if (nr_sectors > q->limits.chunk_sectors)
-		return BLK_STS_IOERR;
+		return BLK_STS_INVAL;
=20
 	/* Make sure the BIO is small enough and will not get split */
 	if (nr_sectors > q->limits.max_zone_append_sectors)
-		return BLK_STS_IOERR;
+		return BLK_STS_INVAL;
=20
 	bio->bi_opf |=3D REQ_NOMERGE;
=20
--=20
2.53.0-Meta

