Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F9D265CB3;
	Wed, 13 Aug 2025 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755114774; cv=none; b=ieN7lkYXmjdE6+XiMK7D2lMYoU78tahcU24PHbrKFeol7R3mXVgFOPDShR6bYxomPw8I+F9cCLZKXqF2EU0e0LMXeGqxWsr9brsMN/N8tqB/igEfSZBDJA7daN2eIBl5ztwfLF++xd2Wy9j3TWDxrzYpmY9d6V+TnOgHgr8AJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755114774; c=relaxed/simple;
	bh=KWoFY6hKsBugkcDcgRdJIXTH0AoFPAeDBMu20QBlw9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSGGpbMxdEbN+GXZHtcn9lNILLJmDCDUuayUKd8CQ7lGRHdMaTdoIXSfAuvSVuAQ5su+I4Yr4JVtXZR6dVtiLSKBY+RfKgs52dFuN8zU2HBiyeBTseEv46H28bGiotCux8DybH8F5kuVgdEnyr8m8GTj4/wzcGRhOQeq91GPGtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Ufmt6c8I; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Ufmt6c8I"
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DHkLYu026928;
	Wed, 13 Aug 2025 19:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=CFGm6yD2o11Im
	kGZsL2WnWsgd3JghffpkrjurmFusrk=; b=Ufmt6c8IlAH024q9TBqUk8Xr/X4Yu
	64ANAcVOYQ4BS97+eUJVmndgOMDUKMb8ssuuY9u9ngRHaIGpFLK5a2RnqdBMTUDK
	Y29vpjgEeHkG7WTK//+Te0Zdjq/Er/FM5IAql2dL5a1efvPyFjIZu9AjYDhHDklg
	2Fr4fuY5EoGsYE2Qh0jefCtA/7C/WqmVOUfgeXu4qrpdsLsky/pWeIdeJ0D5c02j
	3wfjSXShUVfz3i7rc0XxjVIq7VMzmyM9Qt+Zcm8essefXf4cIT3LIVJwUeMxAn5q
	TGEBq6mjokHbq3hDHpN8wwm0qBHoOb4VId/n7FtiDlTCDiMN1hoMqXVIg==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48g985vqss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 19:52:40 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 8C7C7805E7F;
	Wed, 13 Aug 2025 19:52:39 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id 691CC89CCED7; Wed, 13 Aug 2025 19:52:36 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajeev Mishra <rajeevm@hpe.com>
Subject: [PATCH v4 2/2] loop: use vfs_getattr_nosec for accurate file size
Date: Wed, 13 Aug 2025 19:52:27 +0000
Message-ID: <20250813195228.12021-3-rajeevm@hpe.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20250813195228.12021-1-rajeevm@hpe.com>
References: <20250813195228.12021-1-rajeevm@hpe.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RJoo7DabdOTxvgMRW9RH14PWcOTwbIqY
X-Proofpoint-ORIG-GUID: RJoo7DabdOTxvgMRW9RH14PWcOTwbIqY
X-Authority-Analysis: v=2.4 cv=C87pyRP+ c=1 sm=1 tr=0 ts=689ced08 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=xJvGO-ZEL5em5uvXGr0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE4MyBTYWx0ZWRfX2z7qXYRCFi9L
 JrI9k0q0gVszvReUe/xEkpY+zSpsjpL6Eerepia3bAjX0cJ6YpdeOAbHgFEP1vYcqZTkXiRRFEa
 P4wTEeudfVQOLUMK/BQuGDtodobb9I7IwNSZiUfg1gZpVeBDZ0YT6oh1l7NfZiaYIEuRwg3B/GN
 +IqgDBlWeQeoeXp8CXks/0AlvHn3VAJA3Qad1vmjfYPHGeePwMuR8OZK0mxN8mRYY0ycL7eEo/1
 l1GUQZzoPzSKNKS0oPGhADKnnpZzG+D2XLxtREBsTGPPsY7LVjDXRbeMNPvswPheIGAovp3wfrx
 p8nKhOppV8NeHFbVtptzaax1iDRBO7uUUyEf4z6rwkThc38zX/EqDe7LsFjRre5HNny8b9vJ0+n
 M5UN9TSQCscon2Hdmq9Nsex346fREbjOKM5WKz0hqycA9sUwMS9DPi048hUDuRZVN/sF4gqv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=971 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508130183

- Use vfs_getattr_nosec() instead of i_size_read() in lo_calculate_size.
- Improves accuracy for network/distributed filesystems.

Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
---
 drivers/block/loop.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5faf8607dfb2..0a2703eda2c2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -139,9 +139,20 @@ static int part_shift;
 
 static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
 {
+       struct kstat stat;
        loff_t loopsize;
-       /* Compute loopsize in bytes */
-       loopsize = i_size_read(file->f_mapping->host);
+       int ret;
+
+       /*
+	* Get the accurate file size. This provides better results than
+	* cached inode data, particularly for network filesystems where
+	* metadata may be stale.
+	*/
+       ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
+       if (ret)
+	       return 0;
+
+       loopsize = stat.size;
        if (lo->lo_offset > 0)
 	       loopsize -= lo->lo_offset;
        /* offset is beyond i_size, weird but possible */
-- 
2.43.7

