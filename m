Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21DB1DDA15;
	Mon, 25 Aug 2025 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160309; cv=none; b=oMeKgp/FOqN5hJ5a3skATQLYFIhCQtF+f3ahhmUBNcv1nQDJeVb1x35rKpLtCWxO08EeHRe4VJC5hw6henQjr3Kexv/U5uKVGsskGuHUMdmdDK2ZU/QrDbWYLkQRD/rdw0MFGt98kecMS1CUuxLc7bXHAS9PtaIVp99LMAnoPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160309; c=relaxed/simple;
	bh=EijahdO70KEyAq0xGZl9P+6VganfEHwa0T0/jpYnE8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsSHWXg2zw7lT9MchbaEU1341+cmk9Xom1ms7ZgBzcuXAvX1TfYwXQHaV28WJoq7SgrhdRJIyKZuPYKxZXbGqYsL1QLemC00tGvWMRbkOmqLYY1tcVbgyYaJ1zNM6Y+V2CCjqRyik+RQEKx8l1/2TwgUjF8eAW+OItq7KrXmAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Oprwqg0s; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Oprwqg0s"
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PELZIM011214;
	Mon, 25 Aug 2025 22:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=LGDHslfVA9ZQp
	kxDB71ob8wLSgfYFQ9Bt1xRFZ+XqVU=; b=Oprwqg0sMmSZ7no4q15WmmvmoAe+d
	GQ07fxFVtccG58aIDe2RLwsXz9CbUTeFntuJKYNFD2m46n5+9TdkyNoX0B8tdupF
	tcpmTwPqtFUHJ5YPaV03nABPrvaTUoxt5xwpUa93O4OsPqPVOYhF3muAUWBVdKUh
	FrqsLzOuoUc0DvVYTN547XMFwkncc7k0AAsXjpYXNYpjGqQHVF/cAXjMf6e2txNx
	R4s2Ll0I5VckGdf/7w/vBdwH/qqWxQKAQjoxLCR2UAsJ07fXkJELloiIChRmXF60
	3U748f6Bj+G+Io/67IsUl5ortNdUouHtFhPBya6K5tm6kCZJwnkBfRg+A==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48q6afh9h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 22:17:57 +0000 (GMT)
Received: from mlperfr9.3-rocky.novalocal (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id AC17E805E16;
	Mon, 25 Aug 2025 22:17:55 +0000 (UTC)
Received: from mlperfr9.3-rocky.novalocal (localhost [127.0.0.1])
	by mlperfr9.3-rocky.novalocal (Postfix) with ESMTPS id 66EA8A0A40A4;
	Mon, 25 Aug 2025 22:17:51 +0000 (UTC)
Received: (from rocky@localhost)
	by mlperfr9.3-rocky.novalocal (8.16.1/8.16.1/Submit) id 57PMHpaO3714509;
	Mon, 25 Aug 2025 22:17:51 GMT
From: Cloud User <rajeevm@hpe.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, hch@infradead.org,
        yukuai3@huawei.com, rajeevm@hpe.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: [PATCH 2/2] loop: use vfs_getattr_nosec for accurate file size
Date: Mon, 25 Aug 2025 22:17:41 +0000
Message-ID: <20250825221741.3714488-3-rajeevm@hpe.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825221741.3714488-1-rajeevm@hpe.com>
References: <20250825221741.3714488-1-rajeevm@hpe.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rCeUDlGs_pOpvPyyC3VS-UDJtfw8MBw_
X-Proofpoint-ORIG-GUID: rCeUDlGs_pOpvPyyC3VS-UDJtfw8MBw_
X-Authority-Analysis: v=2.4 cv=S8vZwJsP c=1 sm=1 tr=0 ts=68ace115 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=ky6m8zXAD6jKsvyDoWcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDIwMCBTYWx0ZWRfX9HdBCjfc5FGJ
 0Te7N5JJm8c/S2+/gQd3RnK1Ezl+H8hbEkhicU2esgdxB4coM7BiAdM0X7WjFYn7P75quLhaMIO
 vdqYHV1gC3pE7OBTF3pdO4oVejRdtVCnZiNytsXS3QXyJ+gUSy0nr3iBq6tPg4pnpb0M31lgbnj
 gQLxCiyi8OgNxDYLicifAKZ1GeHCzN1hIk76HLxkn7X8nUIgmTUdMiLP2pysNiXrG/IUf/Rk8ms
 VlX5g/1rNZgxjBIFaJ/2zEMe3Q3saeX/qm5/vX+7iZCn9KxywC4aNU6JkG20bNTBbP1n48wluoG
 ooL161Nb46gSwOlPMb4pc3+N+6DC/PjLfgkwGujf0bWtkFtsTMJlkQ9rq2OZ+OK1GJzGgZGMUIX
 qHz07VnBKcvsZrfxcNuAl+YaE5fo0iDoUr9Gu6hAgrAc6eLidY/ry7NyEzZldYsaujoGyPvc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250200

From: Rajeev Mishra <rajeevm@hpe.com>

In lo_calculate_size(), use vfs_getattr_nosec() for non-block files.
For block files, continue using i_size_read(). This improves size
accuracy on network and distributed filesystems.

Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
---
 drivers/block/loop.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0e1b9eb9db10..a6214ae40ef0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -139,9 +139,24 @@ static int part_shift;
 
 static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
 {
+	struct kstat stat;
 	loff_t loopsize;
-	/* Compute loopsize in bytes */
-	loopsize = i_size_read(file->f_mapping->host);
+	int ret;
+
+	/*
+	 * Get the accurate file size. This provides better results than
+	 * cached inode data, particularly for network filesystems where
+	 * metadata may be stale.
+	 */
+	if (S_ISBLK(file->f_inode->i_mode)) {
+		loopsize = i_size_read(file->f_mapping->host);
+	} else {
+		ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
+		if (ret)
+			return 0;
+		loopsize = stat.size;
+	}
+
 	if (lo->lo_offset > 0)
 		loopsize -= lo->lo_offset;
 	/* offset is beyond i_size, weird but possible */
-- 
2.47.3

