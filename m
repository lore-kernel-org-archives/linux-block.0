Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A352E228A
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623457; cv=none; b=NIotqlEvScUJw5wSeVQVQ797xYAGtf2alkZdNUZlthFFIeO7aLRAg5heOqYgyGuVcO4DMfHR1YxCRCKdHkf04mrhzhpdbOIShCGMT29oOy21Ahu/1MFrNK3iL7q9AsbB1HDxmSxqeugEVXIo86+5g5NVt+nMYwLsBNRkLp0Hqp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623457; c=relaxed/simple;
	bh=S4vQX7nEjyr+gyq3Etz01avtlyUujeeIa9MCb69MHzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhwhjbkiBSOfH/YVQTRCN4i4RIUvdUIciIs3K3A8UMppvWuo2HzmjkGY6xeoJctigu8Yq70aSNONfPGn6bL+8rtM4TpT81ezrA2p/eOpksYRn/9h5A9Zn9Udmh1FZeHA5chqQMTDrnEKmhFUf/O57xwVkv7CaWwdjRPnUuZEIts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Z8Ai8BrU; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Z8Ai8BrU"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JF9hRU1378473
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:10:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=YO0nQZjnXIP++9cJOqBf7rWHiXHgArifu5XawG4IlPY=; b=Z8Ai8BrUUt8z
	Ni29+/2I7MqwIp3XHtmtEF2dXny5IzLI3e5RK/Dec8v5rxlH2WLHnbA1Jo3tjNgW
	c3Ewaoh8IVSfTGS/hjNULiYeSYX8K4tGAkkiI9/eJjnBM5FNjaqMZ70SCs4bbw2R
	OqShsTcNusVMDs+OU7yNwm0WgRuiu96AOZH8L0x3xtciqtkouRqit1F2rTNytu3X
	UHBXX0nhltTMzfmCQ2QxSPoj0yeAeFjKuc5DQ+46sQYXXQ9KlXRmDF6LSag52JcS
	rFELH64+G3YLEYK2JecvGgOa9kRj5r6bNSQyNdG0KJzzjd6WR1Yh5dSO4QDzTe6y
	WynDN4Lb8A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48munps719-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:10:54 -0700 (PDT)
Received: from twshared17671.07.ash8.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 19 Aug 2025 17:10:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A1186C89F2D; Tue, 19 Aug 2025 09:49:48 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 6/8] block: remove bdev_iter_is_aligned
Date: Tue, 19 Aug 2025 09:49:20 -0700
Message-ID: <20250819164922.640964-7-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250819164922.640964-1-kbusch@meta.com>
References: <20250819164922.640964-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE2MCBTYWx0ZWRfX6J+QGACdx/wl
 x9CbxfSsPWuBsachxPc0+v+5ooQ9HHPoqTeXRSDwSyNNRi3Bk9d6TvW5MlN/yKKMZMDEG5PPlb1
 3cNrfug/PW0xTefGHCXXC2+PQ6eiko1TzwwZJFYQrR60kpjwJDv3DoTEiqMrqBUjBOQUZLYSx6L
 6qJIkhhiQX+u7YiM/d9zNDljqLOG4uTf7bcHbl+K0nWZgtxHEYaeuh4vbVZyREZydi/BDW3n45P
 lfPy3UTlSaXktj2ieUHgzpy5CedTunrObW9iiGBJloCNDP6b1GC5s1DE+QSaaXfwnd5koHUrOWI
 DDftx2e+leCnUqum/GLtoYluFgjvGpyNB3P9cUP5nlNUsqRza/1O3638397AAo3S3x2uWy4maHD
 5o3gjlHcfX6tPi91L9sfmqb8mTla6g6hkRxLFzCViIJcvUuDZcaqWWkmWyCLLGTpIJQYaGrF
X-Proofpoint-GUID: Bnflc-ZTtKZwGeI2rEOyr2Fqv209LsTr
X-Proofpoint-ORIG-GUID: Bnflc-ZTtKZwGeI2rEOyr2Fqv209LsTr
X-Authority-Analysis: v=2.4 cv=O/85vA9W c=1 sm=1 tr=0 ts=68a4b01f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=x-sBDG6hxYFL5DTe09MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

No more callers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/blkdev.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7f83ad2df5425..a2128af3f08cf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1589,13 +1589,6 @@ static inline unsigned int bdev_dma_alignment(stru=
ct block_device *bdev)
 	return queue_dma_alignment(bdev_get_queue(bdev));
 }
=20
-static inline bool bdev_iter_is_aligned(struct block_device *bdev,
-					struct iov_iter *iter)
-{
-	return iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
-				   bdev_logical_block_size(bdev) - 1);
-}
-
 static inline unsigned int
 blk_lim_dma_alignment_and_pad(struct queue_limits *lim)
 {
--=20
2.47.3

