Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E881AD3
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703964; cv=none; b=PyYZVbqjEKdL3oiFZHbIMR4NvAE3TYF05OJqIC3cn8m9YpRGMTqwqq6+SPxpuWUJzYK0m58rCGSceCx+PqiGmxJIMrmDWWifElTBFBQjk1MxkYpihrpmLkALVKzAiBSEf4rlLQggRVe6upVe+Ozzhv0CbBQ6qve2lYrvyOlalp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703964; c=relaxed/simple;
	bh=xLidHQGevw3+hdgp5Aw1xJdduckx5iJ5szsvVyNZdCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsZ4bB9JH/YE2wHcQNaRBNe56lcIHBm4iawTma+rXQPxiUC/FZzRQLZqny47nsICxLSe8sgallXBIXXjpt0Ex1Z4sqv4bikPr/wi/i0OBwnfxhOA0Givh+oSlk32fjeKxsGlAZkKZjhrbBqUAixF6VOf1hPYETyldhC6oeHgW78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=n0m5KK4C; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="n0m5KK4C"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 41N36YH0008854
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:59:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=X7lDYXI0dpywXrFiieUIh3nLJG0yEH5eUraiJMVUVo8=;
 b=n0m5KK4Cr/5ntgTr9Es/r00sSstkODj2ewAGkvMdx70ctsLuAZ/xVKlz1E3m3Zor/Hl8
 jR2E/F1g5t/AB/zzNJcrpPEPwdTQsQU6m87WZiUeI+idGKVUGOEek90QvqqElUUyfhU6
 Le7CMpMUY2ZVvNrbuP9zGa2qDwpU9yV73fyptu6XM37h3pI4VnKipNV2a1birtTxpDli
 K4RVRvD8ZZXE54odIgxFVwXNtrxSxz3696CCi/fK3pQCWc3xmgAwjwyn9LUazjwxiQ13
 zhaReK5vzJcTOnX2Z4f5wkSYe6zZ2Xd1wUnniCrBuuJavdGxxe6vLvdI5t9DZHmxi2Ud 0Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3wek5m3a08-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:59:21 -0800
Received: from twshared1676.08.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 07:59:19 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E54D72574FA4C; Fri, 23 Feb 2024 07:59:13 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.org>, <ming.lei@redhat.com>, <nilay@linux.ibm.com>,
        <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>,
        Conrad Meyer
	<conradmeyer@meta.com>
Subject: [PATCHv4 4/4] blk-lib: check for kill signal
Date: Fri, 23 Feb 2024 07:59:10 -0800
Message-ID: <20240223155910.3622666-5-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223155910.3622666-1-kbusch@meta.com>
References: <20240223155910.3622666-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qKIKOUFUtHE8N2ixCi6SbLTEQKLKiecL
X-Proofpoint-GUID: qKIKOUFUtHE8N2ixCi6SbLTEQKLKiecL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

Some of these block operations can access a significant capacity and
take longer than the user expected. A user may change their mind about
wanting to run that command and attempt to kill the process and do
something else with their device. But since the task is uninterruptable,
they have to wait for it to finish, which could be many hours.

Check for a fatal signal at each iteration so the user doesn't have to
wait for their regretted operation to complete naturally.

Reported-by: Conrad Meyer <conradmeyer@meta.com>
Tested-by: Nilay Shroff<nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-lib.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index a6954eafb8c8a..dc8e35d0a51d6 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -35,6 +35,26 @@ static sector_t bio_discard_limit(struct block_device =
*bdev, sector_t sector)
 	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
 }
=20
+static void await_bio_endio(struct bio *bio)
+{
+	complete(bio->bi_private);
+	bio_put(bio);
+}
+
+/*
+ * await_bio_chain - ends @bio and waits for every chained bio to comple=
te
+ */
+static void await_bio_chain(struct bio *bio)
+{
+	DECLARE_COMPLETION_ONSTACK_MAP(done,
+			bio->bi_bdev->bd_disk->lockdep_map);
+
+	bio->bi_private =3D &done;
+	bio->bi_end_io =3D await_bio_endio;
+	bio_endio(bio);
+	blk_wait_io(&done);
+}
+
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
 {
@@ -77,6 +97,10 @@ int __blkdev_issue_discard(struct block_device *bdev, =
sector_t sector,
 		 * is disabled.
 		 */
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			await_bio_chain(bio);
+			return -EINTR;
+		}
 	}
=20
 	*biop =3D bio;
@@ -143,6 +167,10 @@ static int __blkdev_issue_write_zeroes(struct block_=
device *bdev,
 		nr_sects -=3D len;
 		sector +=3D len;
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			await_bio_chain(bio);
+			return -EINTR;
+		}
 	}
=20
 	*biop =3D bio;
@@ -187,6 +215,10 @@ static int __blkdev_issue_zero_pages(struct block_de=
vice *bdev,
 				break;
 		}
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			await_bio_chain(bio);
+			return -EINTR;
+		}
 	}
=20
 	*biop =3D bio;
@@ -277,7 +309,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, s=
ector_t sector,
 		bio_put(bio);
 	}
 	blk_finish_plug(&plug);
-	if (ret && try_write_zeroes) {
+	if (ret && ret !=3D -EINTR && try_write_zeroes) {
 		if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
 			try_write_zeroes =3D false;
 			goto retry;
@@ -329,6 +361,12 @@ int blkdev_issue_secure_erase(struct block_device *b=
dev, sector_t sector,
 		sector +=3D len;
 		nr_sects -=3D len;
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			await_bio_chain(bio);
+			ret =3D -EINTR;
+			bio =3D NULL;
+			break;
+		}
 	}
 	if (bio) {
 		ret =3D submit_bio_wait(bio);
--=20
2.34.1

