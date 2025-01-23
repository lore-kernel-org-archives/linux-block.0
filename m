Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8614883C
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654107; cv=none; b=gzEBr7kXTvn9Dj7nvFZYLAqsAsL14HngkathzAwBK/rnnNKyAv3fvPK3jW3WDzy+MAS6tluCSAu1AC3byElRUWyafeF8pvQSEaTlklqlM0FN6KOunn5GxaYSN7gnAMAK/DTZ7Xlav5fmyonOlbjRFFs1Q5XABlk7q4SyI6fjPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654107; c=relaxed/simple;
	bh=+B8wvVyQcTeP+qEzuLSGXOMCi38utX3cIf9T9+Ds3Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kI/LzKBNx1WipvyeO/7QECcSEkyv0S//xEsRRwbp0/AIswir8UD0DN2xYQtGqVbJDLWKcHGk5EVG++uPNCkapzHs7dH83sjnTsjDXDoZt6ZxmOf/TCU68zMEvqgfpWsg+1s8q25vDmCRAhF133OY2k7qQ04OIkfXA4HNFgLU+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=okD0ihgA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="okD0ihgA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NF23Ye006853;
	Thu, 23 Jan 2025 17:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9WyOW/qjWknSe0Q3lOBRzGgKuX2qfL5LNSqeBzQ0m
	2g=; b=okD0ihgAH7tkAWKXKE8oGYV4o8jJBhYbTKHoqK0tYGyugfPpL+WBKtAt4
	c6+iduEqwNW0gQVYwxASZpR9GIS0PVpGD0yMMbCnzCWvL5OMog8h7FbLoMja+Xu3
	KlUINvgP+1yUZrLZc+GekShdunIUHZtoi425bhtIxQLaOdbO5zOQbsytxj3OJiCO
	LWJiZzRzoOL1Tp/AVGC83z232g36wiEz6IKBOXU7q12oAuOx934NMCtpzGTxaayx
	aaGurxd861ERcZyQpLvqdM88KVOjCUXzXStAJj3g7H3bEss0SmjaSixuFrq1yjC2
	DDqtrkjDIEC+UkPpkXl4FDHJnu1RA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44br1ygtra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:41:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NGWAlL032420;
	Thu, 23 Jan 2025 17:41:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448rujx9r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:41:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NHfRR338076806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:41:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50F6120043;
	Thu, 23 Jan 2025 17:41:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B31F20040;
	Thu, 23 Jan 2025 17:41:26 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.46.6])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 17:41:25 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [RFC PATCHv2 0/2] block: remove q->sysfs_dir_lock and fix race updating nr_hw_queue
Date: Thu, 23 Jan 2025 23:10:22 +0530
Message-ID: <20250123174124.24554-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m1YhubQSCgmvnpbo7XA_R3FTDz6OjdvR
X-Proofpoint-ORIG-GUID: m1YhubQSCgmvnpbo7XA_R3FTDz6OjdvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=896
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230125

Hi,

There're two patches in this patchest.
The first patch removes redundant q->sysfs_dir_lock. 
The second patch fixes nr_hw_queue update racing with disk addition/
removal.

In the current implementation we use q->sysfs_dir_lock for protecting
kobject addition/deletion while we register/unregister blk-mq with
sysfs. However the sysfs/kernfs internal implementation already protects
against the simultaneous addtion/deletion of kobjects. So in that sense
use of q->sysfs_dir_lock appears redundant.

Furthermore, there're few other callsites in the current code where we
use q->sysfs_dir_lock along with q->sysfs_lock while addition/deletion 
of independent access ranges for a disk under sysfs. Please refer, disk_
register_independent_access_ranges() and disk_unregister_independent_
access_ranges(). Here as well we could easily remove use of q->sysfs_dir_
lock.

The only thing which q->syfs_dir_lock appears to protect is the use of
variable q->mq_sysfs_init_done. However this could be solved by 
converting q->mq_sysfs_init_done to an atomic variable.

In past few days, we have seen many lockdep splat in block layer and
getting rid of this one might help reduce some contention as well we 
need to worry less about lock ordering wrt to q->sysfs_dir_lock. The 
first patch helps fix this.

The second patch addresses a potential race between nr_hw_queue update 
and disk addition/removal. The __blk_mq_update_nr_hw_queues function
removes and then adds hctx sysfs files. Similarly the disk addition/ 
removal code also adds or remove the hctx sysfs files. So it's quite 
possible that disk addition/removal code could race with __blk_mq_update_
nr_hw_queues() while it adds/deletes hctx sysfs files. Apparently, 
__blk_mq_update_nr_hw_queues() holds q->tag_list_lock while it runs, 
and so to avoid race between __blk_mq_update_nr_hw_queues() and disk 
addition/removal code, we should hold the same q->tag_list_lock while 
we add/delete hctx sysfs files while registering/uregistering disk queue. 
So the second patch in the series helps fix this race condition which may
manifests while we add/remove hctx sysfs files.

Nilay Shroff (2):
  block: get rid of request queue ->sysfs_dir_lock
  block: fix nr_hw_queue update racing with disk addition/removal

Changes from v1:
  - remove q->sysfs_init_done and replace it with registered queue
    flag (hch)
  - fix nr_hw_queue update racing with disk addition/removal (hch)
  - Link to v1: https://lore.kernel.org/all/20250120130413.789737-1-nilay@linux.ibm.com/

 block/blk-core.c       |  1 -
 block/blk-ia-ranges.c  |  4 ----
 block/blk-mq-sysfs.c   | 37 ++++++++++++++++++-------------------
 block/blk-sysfs.c      |  5 -----
 include/linux/blkdev.h |  3 ---
 5 files changed, 18 insertions(+), 32 deletions(-)

-- 
2.47.1

