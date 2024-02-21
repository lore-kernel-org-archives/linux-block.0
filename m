Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08704A1D
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554028; cv=none; b=RlO/MWph/RUd7sroV2QG+e1/68DVJB7HYsAYBQqWZEqv2wtvUIGEIzaFeZqwB9Ar0IBJNnYlrBjFM8r33um24aox9f/GGqeoz0Hj/+DvSw1m083b5VKjCj3JE9sukPqkY2nhXpH6AYIH9VvItm/9mB3e0kn3+C5wT/+d6H3S/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554028; c=relaxed/simple;
	bh=GTNLFmm3zSrAiw+/8ruvkmFgBJz9PDfJHEvYMLBWM1I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PatSvAtCa5Uc32ZMnSfCj/nF0FknGjv92nB6Ivhq/i6hKbkUAPJnwgxqT+QiEYiJklyln/snj4qUoZMz9SbOeJOW/3TEtH78EEhuiSt8Rsimt1PYyHqXvYRrW0HkwXxG7a16H8l7HhyHWgcvM98ZYp2nQY3ewoloxGE+XFAjTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=l0PwfNWW; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="l0PwfNWW"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LMBusV023488
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 14:20:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=FYPP14wOGwImFdVv0bGM8zHLAcXFJe+OiZVFfSMfO9g=;
 b=l0PwfNWWAqMl8sS+QtLo5SQABnmNkJVIwb41s0ZxmA1uB+mFom7juNYz1AUTinXQ1Ztp
 dRGeNNG/dx9XUFuYQ3UPUfB94VlgLnCrLel1a+ThnLu4bREwukpcT+ZRfYRMabLfz+0c
 iY33LwRKOwKuYlRP6wgOrdpF+X0e3WWpEmBcH0rZdL86nfImnCnBNk+VoJSnqFEkAtGK
 YRqti5tKKASbnEpozscTlZ/BQnxvb+xZ6/EHMSlBM34ix67XoF5uuZFw/J5fpQIPLqau
 fXfdOhbyprZL8K0CgL8c6XzTAttaMsyiwCBxinjtTqag15+azu9EZdlRlSkSDEp1XR2x Pw== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3wdsrqg1dy-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 14:20:25 -0800
Received: from twshared28280.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 14:20:22 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 22FD425662F82; Wed, 21 Feb 2024 14:20:15 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Ming Lei
	<ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
        Chaitanya Kulkarni
	<chaitanyak@nvidia.com>,
        Conrad Meyer <conradmeyer@meta.com>
Subject: [PATCHv2] blk-lib: check for kill signal
Date: Wed, 21 Feb 2024 14:20:13 -0800
Message-ID: <20240221222013.582613-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5JmQubVpTG0oQ-anRxvdbkJItcSAtXr_
X-Proofpoint-GUID: 5JmQubVpTG0oQ-anRxvdbkJItcSAtXr_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

Some of these block operations can access the entire device capacity,
and can take a lot longer than the user expected. The user may change
their mind about wanting to run that command and attempt to kill the
process, but we're running uninterruptable, so they have to wait for it
to finish, which could be hours.

Check for a fatal signal at each iteration so the user doesn't have to
wait for their regretted operation to complete.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Reported-by: Conrad Meyer <conradmeyer@meta.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Changes from v1:

  Check the kill signal on all the long operations, not just the
  zero-out fallback.

  Be sure to return -EINTR on the condition.

  After the kill signal is observered, instead of submitting and waiting
  for the current parent bio in the chain, abort it by ending it
  immediately and do the final bio_put() after every previously submitted
  chained bio completes.

 block/blk-lib.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e8351..88f6a4aebe75e 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -35,6 +35,17 @@ static sector_t bio_discard_limit(struct block_device =
*bdev, sector_t sector)
 	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
 }
=20
+static void abort_bio_endio(struct bio *bio)
+{
+	bio_put(bio);
+}
+
+static void abort_bio(struct bio *bio)
+{
+	bio->bi_end_io =3D abort_bio_endio;
+	bio_endio(bio);
+}
+
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
 {
@@ -77,6 +88,10 @@ int __blkdev_issue_discard(struct block_device *bdev, =
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
@@ -146,6 +161,10 @@ static int __blkdev_issue_write_zeroes(struct block_=
device *bdev,
 			nr_sects =3D 0;
 		}
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			abort_bio(bio);
+			return -EINTR;
+		}
 	}
=20
 	*biop =3D bio;
@@ -190,6 +209,10 @@ static int __blkdev_issue_zero_pages(struct block_de=
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
@@ -337,6 +360,11 @@ int blkdev_issue_secure_erase(struct block_device *b=
dev, sector_t sector,
 			break;
 		}
 		cond_resched();
+		if (fatal_signal_pending(current)) {
+			abort_bio(bio);
+			ret =3D -EINTR;
+			bio =3D NULL;
+		}
 	}
 	blk_finish_plug(&plug);
=20
--=20
2.34.1

