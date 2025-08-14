Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7023D286;
	Thu, 14 Aug 2025 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198645; cv=none; b=f6J0mCeJyzGsYwjs//RJEEl4Z2Ljblf81Wn58LrvRjCyT1QVZfDDufMRRMBB5/B3f0aYZgufqkVUEwNV5loUWSh96vpi9PDvvpJo0jnGr1A0LYRi+PHE3nNUqQM8vzrb95dHBEdn6nU8eMHKi8Sa0pyfTm5Mw/LS7H9P3i1alp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198645; c=relaxed/simple;
	bh=m0gj7lI47xqI3mIBNHInQrer1vdeRAiZF8YexIJV+MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0ua76FC/5b5BE4BLssqm+5ORipki4l6iWrRHVRB1JclvdZQth5NhLRvLl1rlsZsiVhA+xa/sF8fVHI21L5nMQ3LpSJ5jq6QTUUJ30ZQqRt8FJUpNTz/ZLSc2ARWMB7jCH2M0P0bu6X83LF1SZYb+UjdO9g7ocnbMZ28frwPYnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=B8P5zCQW; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="B8P5zCQW"
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECrFeW026140;
	Thu, 14 Aug 2025 19:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=mL6bbm1p8qiLm
	EV6j/yJy6LLjSit8pTbrUGWYBvd4Tk=; b=B8P5zCQWoLwRcwOjVhs+UyXLidacL
	0n6sySHwzkBMLina22hsU60aAC3vgS+p/+Um3fZI3BZZZLNyj3IALPa4+Z3liD4w
	P/fz6mYxLE+vYx8RWZKdlAVzV8OS8s0XDcURX10kC6tB4wcGPzcO9kzc102FK8Mn
	4DYQ7vQTIk5s0JYg7Cr02SQiVhTGj+XTKvmujXNKZKlMcBdV4aCck+qSNrNK9oIK
	zfLZNVOU3+2hP3gPB5TfhBGoR1qCYdm6CVutBfOdg86odoMN173fqv7XThCZmkEw
	kCVdc6RXDsoOZAKzD6PTEwc5YYmR5i5qX2l8ax6FGZ8ME6RYyWk4c6YgA==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48h8p6qauw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 19:10:27 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id AB86D805E13;
	Thu, 14 Aug 2025 19:10:26 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id 1E5478800123; Thu, 14 Aug 2025 19:10:14 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajeev Mishra <rajeevm@hpe.com>
Subject: [PATCH v4 2/2] loop: use vfs_getattr_nosec for accurate file size
Date: Thu, 14 Aug 2025 19:10:04 +0000
Message-ID: <20250814191004.60340-2-rajeevm@hpe.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20250814191004.60340-1-rajeevm@hpe.com>
References: <20250814191004.60340-1-rajeevm@hpe.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE2MyBTYWx0ZWRfX7ampvVH6ErFC
 7NAsZf0AzuY35plwuAJ1KqEwkJwWHAI8+Hm3YzRY6yeaI2n3iYTwtyer3KXzwHSYKUyVypY4+tg
 jKST5ZkQl+gb8Kb0zVNkZW84e6yfK6bihY8/v8dhsfXLO6QMCwG71PErxotPKf4jSJVzgT1iWX3
 tkoGW6CCUkMNDd7n4/xJCRv0b0hGD8Dy6EilrKuIu8T3x7KPAcbhB12p+oQ/ImjVO2sktwf1OU0
 zU3QHe0++i4tUObNRLQwpouB5Qj2LZ5U4q12MjSWFGCCCOjCCSkPlQfB7fNfThYKafGqpu/mhk+
 mvAlIoHYZ1gvCq39/rQIKGKdPSItR5JwjJwVvuhn3lTLV6WxDF1xHrOdCpsSDjshUDrkNsd0nkg
 IhRT6errpYmCCyUZc27etPylNq/h7O3W0L/bYQvS+gEe/MsowZ8+p5ivSnzsrzAZxJ42ulV4
X-Authority-Analysis: v=2.4 cv=Q/XS452a c=1 sm=1 tr=0 ts=689e34a3 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=xJvGO-ZEL5em5uvXGr0A:9
X-Proofpoint-ORIG-GUID: 28s-6SyB_xIW9UMxxhBnV6BZSXmwEBej
X-Proofpoint-GUID: 28s-6SyB_xIW9UMxxhBnV6BZSXmwEBej
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 adultscore=0 mlxlogscore=971 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508140163

- Use vfs_getattr_nosec() instead of i_size_read() in lo_calculate_size.
- Improves accuracy for network/distributed filesystems.

Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
---
 drivers/block/loop.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0e1b9eb9db10..57263c273f0f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -139,9 +139,20 @@ static int part_shift;
 
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
+	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
+	if (ret)
+		return 0;
+
+	loopsize = stat.size;
 	if (lo->lo_offset > 0)
 		loopsize -= lo->lo_offset;
 	/* offset is beyond i_size, weird but possible */
-- 
2.43.7

