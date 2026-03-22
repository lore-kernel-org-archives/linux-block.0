Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FC347C6;
	Sun, 22 Mar 2026 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774146934; cv=none; b=qAEi9yVlK/i//2Tf5wnOl0P+ieYiUSQ1kcmnkRrlEqbOWQte0bUQhJzLfhvbs+hZU0LNCaaZgXzqDleoUGlaTvVbKOqlajq01mFyTP1cOkFru/p2dZWeaIpTT24uWGDAw+SN2mGtSap4t16ZAaN9aHwTIHNeUvPn4qhxgssMar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774146934; c=relaxed/simple;
	bh=m8LEOZtTNGHOf4Ytw3nY/I6MLCSuvHOG3YVTV1WgK5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpRUSWWDOY7/fbDK8pHup8uzwYcoE4xmEnTJdBZGoH3AJTJWsAKCLKGLzOjdTpNxq40v15Vaup7H3ggLSqCu3dHFjcwJF7nOSSZ7vys0tfC2WzoaRr16Vv/4pYQPRz3J3l08VofZxrWD4xHQ5Wsg3D1OadPiNIWkXrVRIZ9bzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=alj/0rEQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="alj/0rEQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62M0n6WZ2315466;
	Sun, 22 Mar 2026 02:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=g4RCGx7mlIwe9Gw6VTxVmzgRBWzwwQ
	gbqbWmYUDOA/o=; b=alj/0rEQSkBRA6YfBqnT8WkKZzmz0v89VpT1qfdYmsHCMe
	cvaa/579rfxLr+GFgCeIPCe2c3asoWoaNFb12Fr5Kk061/zRSnSRfIqkAVVqZnVI
	LXCam6fu4afz7TOKkr8X7EGgctnT0gPD33IPqKBDypI7LSriQeGQ+QEU3qv96ZnU
	/tVmx3Cm44o7nCZVBx7ItjoD4Uu8IRl+ajPyRJfZQSeVlW38bFs8AYEa6snE1DD8
	2DJodyOP0fPVe/YK4cfv2VvsEkchDEQR666aqoPZHPY36kVVr/0s2NH7f8guLcp2
	a/RhfKm+aW4Z2ZCB82w3ImW6acUZQMYXdq7ywBtg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxjg4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 02:35:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62M0bROG005996;
	Sun, 22 Mar 2026 02:35:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261y8865-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 02:35:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62M2ZC1o22086136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Mar 2026 02:35:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5549F2004B;
	Sun, 22 Mar 2026 02:35:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D509A20043;
	Sun, 22 Mar 2026 02:35:11 +0000 (GMT)
Received: from localhost (unknown [9.111.74.1])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 22 Mar 2026 02:35:11 +0000 (GMT)
Date: Sun, 22 Mar 2026 03:35:10 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com>
Subject: [PATCH] block: fix bio_alloc_bioset slowpath GFP handling
Message-ID: <p01.gc6e9ad5845ad.ttca29g@ub.hpns>
References: <69bdcdcd.050a0220.3bf4de.002f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69bdcdcd.050a0220.3bf4de.002f.GAE@google.com>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69bf5563 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=hSkVLCK3AAAA:8
 a=VnNF1IyMAAAA:8 a=fjtygTPo_clx9LAhsc8A:9 a=QEXdDO2ut3YA:10
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIyMDAxNyBTYWx0ZWRfX4MlEPbrMF20y
 XHqJzlpwnnYjRmwH2K6Xp1ikSQdwPsKOCmHXZEzeldHAZoARZAg84lUzumkFVlv39SX8d6hZZCD
 nDDSdDJdxh5fevcSaeQILHk9CjWz4d84Jyiglu1I9brmoND/wEc6rsNo+xuLylhjbNTZ65V3tG9
 +Ep7Ig+s0/Y/aRB5XFtOg0J4oo03LMAj7KL7S2tEhsrYF8VRDA+Ct7VcEd9VmrR7NXkwxUaJtsT
 xXLr+7dXbRLbzH1HDRW4juw4KoZZKZrjKAUKkzJdEJ3bUhctBHrh8IddSsEg/EobVz42Yj+4bIq
 uNofuPUAVXrBrxG0jdRUmqclBU7iQvLFylJXolX/7tbzFd3qSdWDawjkghiH9yRUOn+IbRpPvOF
 m+uQn8Ip63dM8DWV92QIli9guEiebkko0Yp2Ya9M6F0rgFJaEJgSeojapTmQ0q8iBmUmwaUuVaA
 AtoKoLELLvVFe5zZzpA==
X-Proofpoint-GUID: rv8Q2xgQJmIF_RQ0W_6l6qkBv327QCjh
X-Proofpoint-ORIG-GUID: rv8Q2xgQJmIF_RQ0W_6l6qkBv327QCjh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_08,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603220017

bio_alloc_bioset() first strips __GFP_DIRECT_RECLAIM from the optimistic
fast allocation attempt with try_alloc_gfp(). If that fast path fails,
the slowpath checks saved_gfp to decide whether blocking allocation is
allowed, but then still calls mempool_alloc() with the stripped gfp mask.
That can lead to a NULL bio pointer being passed into bio_init().

Fix the slowpath by using saved_gfp for the bio and bvec mempool
allocations.

Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
Reported-by: syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
If this looks fine, feel free to squash it into the offending commit or
pick it up separately.

 block/bio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5057047194c4..77067fa346d3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -581,11 +581,11 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 		 */
 		opf &= ~REQ_ALLOC_CACHE;
 
-		p = mempool_alloc(&bs->bio_pool, gfp);
+		p = mempool_alloc(&bs->bio_pool, saved_gfp);
 		bio = p + bs->front_pad;
 		if (nr_vecs > BIO_INLINE_VECS) {
 			nr_vecs = BIO_MAX_VECS;
-			bvecs = mempool_alloc(&bs->bvec_pool, gfp);
+			bvecs = mempool_alloc(&bs->bvec_pool, saved_gfp);
 		}
 	}
 
-- 
2.53.0
