Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79382DFA36
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907481; cv=none; b=rzyLW++1QYx8VZnjyJVR7GssvM4kZz5j6NfN7TzGNtqxtRb+WjlAmOMEHfQrlyOGimqNfqqUUiP2mi1+B4ijZc7k+vd/mHQtb0+X6YsJXZiVR8UBOSpDs7dANM/i6pSxcK3KxHh7l+1V6Er7gusoJ6VlMRkivrZKi52fTQfSwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907481; c=relaxed/simple;
	bh=7HGsYQoek00cZK6/1MDP9yCaqwyEWuxfX6aNwc7rew0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MiWwTHdsjnZPu8q6Pbm+g9CtqDNdpd6JbdzupXwEHCXtrFcqfKnAY/6OtJwp+2xZvlOIgDpV8KNNk8qrFhyllqRUrpdTs9NfYTQ7z913Af0BvqVs4cXka1GChJkOTxx1vy+r9VK0wwWcuIv8N5K75luRKrur1x+aP1jx1Jhk8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I4TFnj/d; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I4TFnj/d"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMvI8009922;
	Thu, 17 Apr 2025 16:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=zKgoN7hFRFIDJS/nrfAR2mC0ZzUWh
	P97gqYicaCFAzg=; b=I4TFnj/doQeuOUgY/RAoRkMvJ1nDvrhURjPAr8G47PsWd
	NfUJXCjSbnQsWhKvEjteRZojGlTZ/ct1cZtNHbMfwquW0jvuRsOAn5WUYilL/Dwn
	vrK755Z8USn9lJXmFyQe/RSq4hfhLzof3KhH69+FEnDYZouMyBRu+3mvoffqKV7r
	BBucg0HsmHVSox8LkMN6MrzOjAMJHo4c5E4hyQCUM8dDYZ92xBRj02Rmyzzx4jDg
	+pQbwPN2fjJQhsxUYC+t11KqvGdbOHT6N8y6AOxM80/j/iZ/43DAeWR91394f4HD
	N1IAti+fELk1Me2gIRekO6SbJE8IW9q68wRbaKsyQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46187xxu56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 16:31:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HG8nli008496;
	Thu, 17 Apr 2025 16:31:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d2th0w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 16:31:13 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53HGVCin021221;
	Thu, 17 Apr 2025 16:31:12 GMT
Received: from ca-ldom148.us.oracle.com.com (ca-ldom148.us.oracle.com [10.129.68.133])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 460d2th0uw-1;
	Thu, 17 Apr 2025 16:31:12 +0000
From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk
Cc: prasad.singamsetty@oracle.com, arnd@arndb.de, ojeda@kernel.org,
        nathan@kernel.org, martin.petersen@oracle.com
Subject: [PATCH 1/1] block: prevent calls to should_fail_bio() optimized by gcc
Date: Thu, 17 Apr 2025 09:34:32 -0700
Message-ID: <20250417163432.1336124-1-prasad.singamsetty@oracle.com>
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
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=986
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170121
X-Proofpoint-GUID: yjbzJsz_BIluWsJp_D89MBmRHbLxz_TE
X-Proofpoint-ORIG-GUID: yjbzJsz_BIluWsJp_D89MBmRHbLxz_TE

When CONFIG_FAIL_MAKE_REQUEST is not enabled, gcc may optimize out
calls to should_fail_bio() because the content of should_fail_bio()
is empty returning always 'false'. The gcc compiler then detects
the function call to should_fail_bio() being empty and optimizes
out the call to it. This prevents block I/O error injection programs
attached to it from working. The compiler is not aware of the side
effect of calling this probe function.

This issue is seen with gcc compiler version 14. Previous versions
of gcc compiler (checked 9, 11, 12, 13) don't have this optimization.

Clang compiler (seen with version 18.1.18) has the same issue of
optimizing out calls to should_fail_bio().

Adding the compiler attribute __attribute__((noipa)) to should_fail_bio()
function avoids this optimization. This attribute is available starting
from gcc compiler version 8.1. Adding this attribute avoids the issue
and only side effect is the slight increase in the code size of the
binary blk-core.o (e.g. 16 bytes with gcc version 11 and 48 bytes
with gcc version 14) as expected.

For Clang case, 'noipa' attribute is not available but it has a similar
attribute, 'optnone', with the same effect and fixes the issue. So, the
patch adds either 'noipa' attribute for gcc case or 'optnone' for
Clang case.

Cc: stable@vger.kernel.org
Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
---
 block/blk-core.c                    |  2 +-
 include/linux/compiler_attributes.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e8cc270a453f..fb1da9ea92bb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -539,7 +539,7 @@ static inline void bio_check_ro(struct bio *bio)
 	}
 }
 
-static noinline int should_fail_bio(struct bio *bio)
+static noipa noinline int should_fail_bio(struct bio *bio)
 {
 	if (should_fail_request(bdev_whole(bio->bi_bdev), bio->bi_iter.bi_size))
 		return -EIO;
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index c16d4199bf92..9d4726c3426e 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -230,6 +230,21 @@
  */
 #define   noinline                      __attribute__((__noinline__))
 
+/*
+ * Optional: only supported since gcc >= 8
+ * Optional: Not supported by clang. "optnone" is used to
+ *	     disable all otipmizations
+ *
+ * gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noipa-function-attribute
+ */
+#if __has_attribute(__noipa__)
+#define   noipa                      __attribute__((__noipa__))
+#elif __has_attribute(__optnone__)
+#define   noipa                      __attribute__((__optnone__))
+#else
+#define   noipa
+#endif
+
 /*
  * Optional: only supported since gcc >= 8
  * Optional: not supported by clang

base-commit: 1a1d569a75f3ab2923cb62daf356d102e4df2b86
-- 
2.43.5

