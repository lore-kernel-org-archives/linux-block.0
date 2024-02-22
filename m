Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843CA14B825
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629651; cv=none; b=tAL4WqRLXjf7iCKtiOzElNxblUfAn87SJXaCuwGexXy46wlUHrIxC9Q9n9Pqnt90zExxElbFTP6CUo7ZSt+cFuCVPS1LixsztqE5Ljg1uvhAQVVY8w1Lw5FLTuM032vkeRUae+4Kqm1pXf/Lmzc19clskkllNRqXMSIvQLJ+hCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629651; c=relaxed/simple;
	bh=OBEz9ZCdXnqiKWBEbbFB06mYggcVCCD07bdDbxEOMmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwWOXSkjtgoxnbI9pgLO7AptSPSfkIFJJmtzOztw3HXGR+XST0wzQY5wBPqJFwodzvJwVo/Y0/nwql4T7+5GmO7awxivf2ss6tI6lTmc1FUiMNX8MoDEqd23AH112YuGgtGa1OQid6P/aBEPvahc62YeCu/Nw+oDJN/36GjIUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NBLcXbK5; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NBLcXbK5"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MItjC8005907
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 11:20:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=c86xmeQIxFBsbABJ3jGy9pjfHBbSNBBoE4yc3CKkrIc=;
 b=NBLcXbK5SRiq+mFtTmnD+B6q3GYW7B2iSawuIjPB0yff5cJuQrCZAsTOpB/MqcCnaXKA
 PsQNhqyEyBJe+uQ4GAFngeNk4UNB77HioMNCCzdr3eVvTvpwRKaZIEpgovu9e942wr+y
 T7Es9zbDqd/zm2Sv0LpAHbieVn4UkXXbrXNkD+HKWWgEvCr0TKdrLICrBcFdNL7H/9AO
 Mz6PYXOxkhhBxPJfgfB4qMDvZgr7lbERSJpDEwvBkVUCL72u6khVMtn42FrOfj1/qUmi
 85peZ+uIv464qCTXF/uumFQq9AoenepMyOeh5vc/U54C0BXU8taTn035J0GA0yGsYeT0 Gw== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3webyk86sm-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 11:20:47 -0800
Received: from twshared53729.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 11:20:47 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 1BF4E256D981E; Thu, 22 Feb 2024 11:20:41 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.org>, <ming.lei@redhat.com>, <nilay@linux.ibm.com>,
        <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>,
        Conrad Meyer
	<conradmeyer@meta.com>
Subject: [PATCHv3 4/4] blk-lib: check for kill signal
Date: Thu, 22 Feb 2024 11:19:22 -0800
Message-ID: <20240222191922.2130580-5-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: IN06ZaXl27ybLfXoXo6DupIcMEXCp2kK
X-Proofpoint-GUID: IN06ZaXl27ybLfXoXo6DupIcMEXCp2kK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

Some of these block operations can access a significant capacity and
take longer than the user expected. A user may change their mind about
wanting to run that command and attempt to kill the process and do
something else with their device. But since the task is uninterruptable,
they have to wait for it to finish, which could be many hours.

Check for a fatal signal at each iteration so the user doesn't have to
wait for their regretted operation to complete naturally.

Reported-by: Conrad Meyer <conradmeyer@meta.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-lib.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index d4c476cf3784a..9e594f641ce72 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -35,6 +35,23 @@ static sector_t bio_discard_limit(struct block_device =
*bdev, sector_t sector)
 	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
 }
=20
+static void abort_bio_endio(struct bio *bio)
+{
+	complete(bio->bi_private);
+	bio_put(bio);
+}
+
+static void abort_bio(struct bio *bio)
+{
+	DECLARE_COMPLETION_ONSTACK_MAP(done,
+			bio->bi_bdev->bd_disk->lockdep_map);
+
+	bio->bi_private =3D &done;
+	bio->bi_end_io =3D abort_bio_endio;
+	bio_endio(bio);
+	blk_wait_io(&done);
+}
+
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
 {
@@ -77,6 +94,10 @@ int __blkdev_issue_discard(struct block_device *bdev, =
sector_t sector,
 		 * is disabled.
 		 */
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			abort_bio(bio);
+			return -EINTR;
+		}
 	}
=20
 	*biop =3D bio;
@@ -143,6 +164,10 @@ static int __blkdev_issue_write_zeroes(struct block_=
device *bdev,
 		nr_sects -=3D len;
 		sector +=3D len;
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			abort_bio(bio);
+			return -EINTR;
+		}
 	}
=20
 	*biop =3D bio;
@@ -187,6 +212,10 @@ static int __blkdev_issue_zero_pages(struct block_de=
vice *bdev,
 				break;
 		}
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			abort_bio(bio);
+			return -EINTR;
+		}
 	}
=20
 	*biop =3D bio;
@@ -329,6 +358,12 @@ int blkdev_issue_secure_erase(struct block_device *b=
dev, sector_t sector,
 		sector +=3D len;
 		nr_sects -=3D len;
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			abort_bio(bio);
+			ret =3D -EINTR;
+			bio =3D NULL;
+			break;
+		}
 	}
 	if (bio) {
 		ret =3D submit_bio_wait(bio);
--=20
2.34.1

