Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098EE548E7
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629655; cv=none; b=BasBQcYuIOx0ohmezFuxveamnKMYplie+7G07mygUshhLTwPxXjG8OLPz8m5pa9QTsQcNDWbeLeJjrK3RNo7tCvFnc6JaZdAK4POelY+WJeSQ059smLHi+lhC8B8U1YQhR5q/8d/SHRhH5kEaEFcmtEvoWCLROM15FEcG8lR0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629655; c=relaxed/simple;
	bh=4KrOyPsGb4c/FVjGG2d8PA8LLv9VDp3C+DZ7talCByU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNyrw6aWI4MSL/As97Of3QNQ8JJmyeCDGy/LbZDF4IMxVE5SCyKhCLaAdfmaEi4lZ/eA2g5jCqr4rQLkrQhZq1hVWlry1iC6A1rIGNSG0F9ujJNxJM+wVjg+y5Rilg9Sb5NDTuV8WLhPHMRiM0eQ8pebWmM23hnxPEyNlU7Nl5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HNdn7z/S; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HNdn7z/S"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIuwOF024346
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 11:20:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=dTantrnFDmtNVGA0OZDoz7KF6WPj9uJiz4rLaxasehc=;
 b=HNdn7z/S2czHOtzo6PrRyfvnNqgUGdl8xXwO6wW5HCrXTp/gpabUpOy6A1+4Ram2Ja9V
 WVwdL9Py+n5IRVdAArOV9t8fQ4YwvoYMF/pxxUnuOSkNNQoIkFmwEiv4KLPhD5fJ1VbY
 YLglGA/WTnpBCRsd1G54GYCWC+IKpafxMjKltmAAf1l/U4FB1J2h09O/k4sJdmdUkDVI
 /ybDawVQqQw1MfOpE+v75uiNuD4xpScJm2srj3RkpXk9uABx2QkTBtcLvFZpIB7yn3Rt
 Kdrq+vKpoI+1zSzImTEcYQUeSnFcCx9HM/6DKhfxCNSsr4yZhdBmAmQNl+TJaBpiHwnl fA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3wec0406ec-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 11:20:53 -0800
Received: from twshared5578.09.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 11:20:49 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id D30DD256D981B; Thu, 22 Feb 2024 11:20:40 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.org>, <ming.lei@redhat.com>, <nilay@linux.ibm.com>,
        <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 3/4] block: introduce io wait hang check helper
Date: Thu, 22 Feb 2024 11:19:21 -0800
Message-ID: <20240222191922.2130580-4-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222191922.2130580-1-kbusch@meta.com>
References: <20240222191922.2130580-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yqJzBNRG0WYWZl9uVsedjp8qLi0xy8jj
X-Proofpoint-ORIG-GUID: yqJzBNRG0WYWZl9uVsedjp8qLi0xy8jj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

This is the same in two places, and another will be added soon.
Create a helper for it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c    | 12 +-----------
 block/blk-mq.c | 19 +++----------------
 block/blk.h    | 13 +++++++++++++
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 00847ff1415c3..496867b51609f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -16,7 +16,6 @@
 #include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <linux/highmem.h>
-#include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
 #include <linux/xarray.h>
=20
@@ -1371,21 +1370,12 @@ int submit_bio_wait(struct bio *bio)
 {
 	DECLARE_COMPLETION_ONSTACK_MAP(done,
 			bio->bi_bdev->bd_disk->lockdep_map);
-	unsigned long hang_check;
=20
 	bio->bi_private =3D &done;
 	bio->bi_end_io =3D submit_bio_wait_endio;
 	bio->bi_opf |=3D REQ_SYNC;
 	submit_bio(bio);
-
-	/* Prevent hang_check timer from firing at us during very long I/O */
-	hang_check =3D sysctl_hung_task_timeout_secs;
-	if (hang_check)
-		while (!wait_for_completion_io_timeout(&done,
-					hang_check * (HZ/2)))
-			;
-	else
-		wait_for_completion_io(&done);
+	blk_wait_io(&done);
=20
 	return blk_status_to_errno(bio->bi_status);
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6abb4ce46baa1..45f994c100446 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -21,7 +21,6 @@
 #include <linux/llist.h>
 #include <linux/cpu.h>
 #include <linux/cache.h>
-#include <linux/sched/sysctl.h>
 #include <linux/sched/topology.h>
 #include <linux/sched/signal.h>
 #include <linux/delay.h>
@@ -1409,22 +1408,10 @@ blk_status_t blk_execute_rq(struct request *rq, b=
ool at_head)
 	blk_mq_insert_request(rq, at_head ? BLK_MQ_INSERT_AT_HEAD : 0);
 	blk_mq_run_hw_queue(hctx, false);
=20
-	if (blk_rq_is_poll(rq)) {
+	if (blk_rq_is_poll(rq))
 		blk_rq_poll_completion(rq, &wait.done);
-	} else {
-		/*
-		 * Prevent hang_check timer from firing at us during very long
-		 * I/O
-		 */
-		unsigned long hang_check =3D sysctl_hung_task_timeout_secs;
-
-		if (hang_check)
-			while (!wait_for_completion_io_timeout(&wait.done,
-					hang_check * (HZ/2)))
-				;
-		else
-			wait_for_completion_io(&wait.done);
-	}
+	else
+		blk_wait_io(&wait.done);
=20
 	return wait.ret;
 }
diff --git a/block/blk.h b/block/blk.h
index 7c30e2ac8ebcd..6c2749d122ab5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -4,6 +4,7 @@
=20
 #include <linux/blk-crypto.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
+#include <linux/sched/sysctl.h>
 #include <linux/timekeeping.h>
 #include <xen/xen.h>
 #include "blk-crypto-internal.h"
@@ -71,6 +72,18 @@ static inline int bio_queue_enter(struct bio *bio)
 	return __bio_queue_enter(q, bio);
 }
=20
+static inline void blk_wait_io(struct completion *done)
+{
+	/* Prevent hang_check timer from firing at us during very long I/O */
+	unsigned long timeout =3D sysctl_hung_task_timeout_secs * HZ / 2;
+
+	if (timeout)
+		while (!wait_for_completion_io_timeout(done, timeout))
+			;
+	else
+		wait_for_completion_io(done);
+}
+
 #define BIO_INLINE_VECS 4
 struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 		gfp_t gfp_mask);
--=20
2.34.1

