Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2C2222DA
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931535; cv=none; b=mDxIi/GCQyKBB4oPz/XcDg/qFMB+Hs7WnR/I4VV4FZKcQmmOf0erp/q8VmxIJaJ6ScdphxKuKkJO3Q1Jeq5YZDKP97TxlthAKI9+e2Pm3oK0HVgZzg2MabLn3rHV/myRLR+e2Yy+3LxjkUekMetEPOl/PZFDnFWu/6vrtwsl4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931535; c=relaxed/simple;
	bh=ld/3hcnvvYQ0Ng2OM3uroYo+GvYT/YMBxU88yrbfmZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRL/0ZR476IQm730TqS2qptdnhu0N9D0wXtD2+DHD/EYzbT4q9v0iu6+OGYpvteZq7PBfNZQp8hFhcQ52Xwvd7j/LC53aAiFpoT1SRoN/ePO3XU407mosTSKVgOwqxNtYGUysuqosjQ2a8bhMqEz88xUgL18ZP7k2Hgre1tMTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SeyGH1fP; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SeyGH1fP"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HJsZsu023313;
	Thu, 17 Apr 2025 23:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=0+i41d5r1eer1v/4tjyz2bGyLMHBX
	YGX+Ik9WC3rm3I=; b=SeyGH1fP7bbzTksLCeP/YkNtfdIljGr/j8kf7uDQWQg9A
	X1N/ipxqV4ho4V3b2NXicKjok/UbU50aHjyhcnZ+BZBozXnJYAy62M0QMz3t/2ZC
	8puieTmDDIIv86XUNtEXBSsasL/M5FeoVrsIKr4ZlhqXSzxASMzqOZY9wnljAen9
	PMLw8yF8EzIBpzo7fSYkZp9VQ0XqGWGBNOH/JnCk92jbI1tUhs8/V0+RzKyepEgB
	7iz1ii20f8XKG7MBaJLq7n2cgNb87ogSuqjFSxA19UkhvolS7PAeCZhZeHY510lI
	uJ6HHlta0mFhqRSpBVw7Tz2caFG6Qzrn6IeIazX+A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4616uf7n9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 23:12:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HL2i4S009230;
	Thu, 17 Apr 2025 23:12:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d3nwmr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 23:12:06 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53HN7iRP015372;
	Thu, 17 Apr 2025 23:12:05 GMT
Received: from ca-ldom148.us.oracle.com.com (ca-ldom148.us.oracle.com [10.129.68.133])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 460d3nwmqs-1;
	Thu, 17 Apr 2025 23:12:05 +0000
From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk
Cc: prasad.singamsetty@oracle.com, arnd@arndb.de, ojeda@kernel.org,
        nathan@kernel.org, martin.petersen@oracle.com
Subject: [PATCH v2 1/1] block: prevent calls to should_fail_bio() optimized by gcc
Date: Thu, 17 Apr 2025 16:15:23 -0700
Message-ID: <20250417231523.1371083-1-prasad.singamsetty@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504170171
X-Proofpoint-GUID: l6uU4551qAEB2RthpfzSoSEi79X9-62F
X-Proofpoint-ORIG-GUID: l6uU4551qAEB2RthpfzSoSEi79X9-62F

When CONFIG_FAIL_MAKE_REQUEST is not enabled, gcc may optimize out
calls to should_fail_bio() because the content of should_fail_bio()
is empty returning always 0. The gcc compiler then detects
the function call to should_fail_bio() being empty and optimizes
out the call to it. This prevents block I/O error injection programs
attached to it from working. The compiler is not aware of the side
effect of calling this probe function.

This issue is seen with gcc compiler version 14. Previous versions
of gcc compiler (checked 9, 11, 12, 13) don't have this optimization.

Clang compiler (seen with version 18.1.18) has the same issue of
optimizing out calls to should_fail_bio().

Adding asm("") statement to should_fail_bio() function as suggested
in the GCC documentation for "noinline" attribute fixes the problem.
This works for both gcc and clang kernel builds.

Cc: stable@vger.kernel.org
Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
---
v2: Instead of adding noipa attribute, use the preferred method of
    adding asm("") statement to should_fail_bio() to create the
    side effect.

 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index e8cc270a453f..d777f0a30c5e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -543,6 +543,7 @@ static noinline int should_fail_bio(struct bio *bio)
 {
 	if (should_fail_request(bdev_whole(bio->bi_bdev), bio->bi_iter.bi_size))
 		return -EIO;
+	asm(""); /* prevent calls to the function optimized out */
 	return 0;
 }
 ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);

base-commit: 1a1d569a75f3ab2923cb62daf356d102e4df2b86
-- 
2.43.5

