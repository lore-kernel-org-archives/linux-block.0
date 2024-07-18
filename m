Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7B6F2E5
	for <linux-block@vger.kernel.org>; Thu, 18 Jul 2024 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287336; cv=none; b=SSop9i8rj56pzXVKDjPku8CMyJ4o2UEF9IzKRSgCkeYbQFqvW0RTUKChS1EqSdeMeREAuOBkw6x5/4P8WrtHti/1WvKRxBN2b3LHohRz+TYcgBR6kzge9SS+K4VZWUN5NEtIjty+4IbGhTvT8i88maJuGNXL/2Kx3APMgGgrEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287336; c=relaxed/simple;
	bh=wPyOAmR53ULPE6Dq7KdjQV3wp/zEs9oj/w5PUnWP+bM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=cD/Ttdjk/UDkkWHyuaWx9/QqwFhmrzpbt5EX6UAnt3S/gVpQ70xUX0U1VaMLWjPJaVtQLhqThCjMCfVVo6O0X9aREp3dpGjybY6wXuqRa9voyQlEAripPHIiF1m/+MusF9quOwL9GN8LE1dyCyBpWmu/RRC02d2eCBFZG1jdDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ibjI173y; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ibjI173y"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240718072204epoutp0277bcd21010bdd291d8e145b12a5c6e38~jPbOqEXcT2235322353epoutp02Q
	for <linux-block@vger.kernel.org>; Thu, 18 Jul 2024 07:22:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240718072204epoutp0277bcd21010bdd291d8e145b12a5c6e38~jPbOqEXcT2235322353epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721287324;
	bh=13FCV97nEtgiaVZ11kx9ddZIZe6T/jO3F12+cKIMIxE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ibjI173yXQH+Abe+Yft8W2qVNPNx6RHDZqdq0QaDXqonzo2tWzhqMf/EQnp21enMn
	 NNp2p0TEfmOATBspPVaGhkf8cMyCDb3orxt+rqC1M579jlTPPPzg0E21CWytITEtfQ
	 s2Sqqqm6WqM3A3hpfd+gCI+wFs3A3hN7Gr7oSltQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240718072204epcas5p2f3a0b245274dd89b955e1f6be285d6b8~jPbOR_v1g0558505585epcas5p2v;
	Thu, 18 Jul 2024 07:22:04 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WPklG2WF0z4x9Q7; Thu, 18 Jul
	2024 07:22:02 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	57.75.06857.A92C8966; Thu, 18 Jul 2024 16:22:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240718070823epcas5p14445a1ab8f8bf8a496405a1424ea067f~jPPSSZ5Y52735427354epcas5p1C;
	Thu, 18 Jul 2024 07:08:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240718070823epsmtrp148f9ae4bc5ac408493f174ea3e637c2a~jPPSRswvg0526105261epsmtrp1f;
	Thu, 18 Jul 2024 07:08:23 +0000 (GMT)
X-AuditID: b6c32a4b-88bff70000021ac9-fa-6698c29a4e02
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AF.49.29940.76FB8966; Thu, 18 Jul 2024 16:08:23 +0900 (KST)
Received: from testpc11818.samsungds.net (unknown [109.105.118.18]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240718070822epsmtip2dde660fe4aa025631f465b5efe342a35~jPPRRKnAF2748427484epsmtip2i;
	Thu, 18 Jul 2024 07:08:22 +0000 (GMT)
From: hexue <xue01.he@samsung.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hexue
	<xue01.he@samsung.com>
Subject: [PATCH v3] block: Avoid polling configuration errors
Date: Thu, 18 Jul 2024 15:08:17 +0800
Message-Id: <20240718070817.1031494-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmpu6sQzPSDH6v4bNYfbefzeJX911G
	i723tC0u75rDZnF2wgdWi64Lp9gc2Dwuny316NuyitHj8ya5AOaobJuM1MSU1CKF1Lzk/JTM
	vHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoK1KCmWJOaVAoYDE4mIlfTubovzS
	klSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMpc0CBd+5KlpON7M3MLZy
	djFyckgImEjsevGKCcQWEtjNKNFxn7+LkQvI/sQoce1TLwuE841R4nHPFqAqDrCOn+1Q8b2M
	ElOOLmSDcH4wSqxsnccIMopNQEli/5YPYLaIgLDE/o5WFhCbWSBW4uiyB2BxYQFbia2n74PF
	WQRUJb4smcMOYvMKWEscmTKDGeI8eYmbXfuZIeKCEidnPoGaIy/RvHU2M8hiCYFN7BIzJ/VD
	NbhIzF/4mhHCFpZ4dXwLO4QtJfGyvw3KzpeY/H09VE2NxLrN71ggbGuJf1f2sIB8ySygKbF+
	lz5EWFZi6ql1TBB7+SR6fz9hgojzSuyYB2MrSSw5sgJqpITE7wmLWCFsD4mTOy8zQ4I3VqJv
	5wmWCYzys5C8MwvJO7MQNi9gZF7FKJlaUJybnlpsWmCcl1oOj9bk/NxNjOCkp+W9g/HRgw96
	hxiZOBgPMUpwMCuJ8E5gnJYmxJuSWFmVWpQfX1Sak1p8iNEUGMYTmaVEk/OBaTevJN7QxNLA
	xMzMzMTS2MxQSZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQamivk3zndXTJwS9tXA9ay8efj+
	QjvTVfvLdl55n9p8aJ7QivXldaFeGbPv5tTXNIfdjXV4E9J96J+ruLlT/1mXI4Gsj/s21/Ou
	1Z/6cO1jBbmw1s+M544ednDT8Z38kOfowat23/b1y0++KKCnKe97tKfYyknFMux2ezaHksRU
	gZ9BVpfuKX7eU12dZTv/wntONsH59Q/uzGotZi1LfaZV7casnVVT8ZTn+OLFysteL1ISLPxw
	tLn8nmZi0PwLgjbuQU9KrodVirM82qW+texs/6a3+kt9xXRfMx66fj3vZJRbT+ml6E9X/i7v
	WJy+WLV2bfN04axD19l3aXiKJWhcExQ+bZX2PLyt4YfQ9ONKLMUZiYZazEXFiQBmufTpAwQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSvG76/hlpBvcvK1msvtvPZvGr+y6j
	xd5b2haXd81hszg74QOrRdeFU2wObB6Xz5Z69G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV8bS
	ZoGC71wVLaeb2RsYWzm7GDk4JARMJH62s3QxcnEICexmlPg9YydjFyMnUFxCYsejP6wQtrDE
	yn/P2UFsIYFvjBLvH0SA2GwCShL7t3wAqxcBqtnf0coCYjMLxEtcmnqeGcQWFrCV2Hr6Plic
	RUBV4suSOWBzeAWsJY5MmcEMMV9e4mbXfmaIuKDEyZlPoObISzRvnc08gZFvFpLULCSpBYxM
	qxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgsNPS3MH4/ZVH/QOMTJxMB5ilOBgVhLh
	ncA4LU2INyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QDU9Ap
	O45bi26X2Zt1HDu5qOSSev781k/XPpVX3eC4VNFeW5r5nSNRvvvbl9CS74ssN4d0rcgRTT/z
	e073J1uF3kf+NxVmSFyYo6Jne+aBfZeU38rlbdfNMpn23NBnzVF7HfLIZf2ZK3fzM88wsi/Y
	79MrrJTF0L2Mw8t/kaTZEcGDt17Pt2K2usHGuOnryyelKladVqKmJkm+X8PipZLfV5oePJMj
	ueV6y8LzOevecHGqdz1udZ/wYGFb3dmTChtkM0V3rHhwo/mccU7HtoXf61hKih5vf/L/YOwv
	y8n+B079P+P9p8dA2+VR+dYOpkQ9r+SKufMYF+YxXZr1Iz8pYl9rmV/irrKFRv+72n5nKbEU
	ZyQaajEXFScCAA37s7quAgAA
X-CMS-MailID: 20240718070823epcas5p14445a1ab8f8bf8a496405a1424ea067f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240718070823epcas5p14445a1ab8f8bf8a496405a1424ea067f
References: <CGME20240718070823epcas5p14445a1ab8f8bf8a496405a1424ea067f@epcas5p1.samsung.com>

This patch add a poll queue check, aims to help users to use poll tolls
accurately.

If users do polled IO but device doesn't have poll queues, they will get
wrong perfromance data and waste CPU resources. So here adding a poll queue
check, if users do this misconfiguration, it will return users that device
does not support this operation, to help users adjust their configuration
promptly.
--
changes from v2:
- move check into block layer
- return -EOPNOTSUPP instead of print a warning in io_uring
v2: https://lore.kernel.org/io-uring/20240711082430.609597-1-xue01.he@samsung.com/T/#u

changes from v1:
- without disrupting the original I/O process.
- move judgement from block to io_uring.
v1: https://lore.kernel.org/linux-block/ZlrQCaR6xEaghWdQ@infradead.org/T/#t

Signed-off-by: hexue <xue01.he@samsung.com>
---
 block/blk-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 82c3ae22d76d..9788808bd488 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -791,8 +791,11 @@ void submit_bio_noacct(struct bio *bio)
 		}
 	}
 
-	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags) &&
+			(bio->bi_opf & REQ_POLLED)) {
 		bio_clear_polled(bio);
+		goto not_supported;
+	}
 
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
-- 
2.40.1

