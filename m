Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C027452
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074893; cv=none; b=AECvrjepobNToOMfVgUzES9cuPDudLG+SBXbj6NnbkM55sWsWARBu1Pt9p2x7G7lof437r8+jV9NTUVgEVq7dY/b65/VCrMfkIuSWTGFPGXaFxiJpvt7ti5GAux6hWCOc1Xj7n30zxhUWzj8rllCkB1Zb2esAtbHxcNR+yIC/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074893; c=relaxed/simple;
	bh=2mbPP7P7rUxciRd9iWJzlW0LPFv5r8jzKfH9HydxtRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgry8y+0vrJ4RUESEmDNGmfVLQ7pvaEuUYOH+Q/vkt96FZSW5EoJp4sGaDClZD11WSIZmUIkDx1dGdDPSzmXSY5vyKOIHl3yRZCerXeQcA08+TamXiavxOoKjoey3jp6/doa30hICOAnwHi07ZmdENx5vFMrtDLEy4Z7j41BHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L5WNFtug; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L5WNFtug"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S8vvQ3012993;
	Tue, 28 Jan 2025 14:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fDXy2D8ZIZebUPogYlZ4IWlk69ahc+gMaHZ/KoaBn
	hE=; b=L5WNFtugJZ82ppRQGChPEkXiqExKS44WFdC2cltb80i0G24qTdzamMuF9
	UGcJqk0hIkU9yTP5pItka9+LMfn7XQ6B3d63UgaONh9XGJ0da1ARBVP6NH4/5pgO
	pLyfDd0UmUYF12NBAF/hOLRCT1J0FgP810fB1hfkzpD30W3D4jywawsRwBcZ4yrA
	XzlUp6PbAg/dzfllXLIMUclGGR+myYUPKpKCIzauhzfckg24wVq1ekM7EFPuh52g
	F5WcXK4QLBQrMT8AIQXAucGwsC0lb3FzcnjKYm1BQxcLDbr4wZ2Ln7NQZd028KYD
	p8EoHUhG8lLswGKJws0WVQB9ieSRA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecdydvh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 14:34:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SDYGdI028060;
	Tue, 28 Jan 2025 14:34:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbskbkvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 14:34:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SEYdxZ44237124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 14:34:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA103200AA;
	Tue, 28 Jan 2025 14:34:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A15B200A9;
	Tue, 28 Jan 2025 14:34:38 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.95.231])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 14:34:38 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [RFC PATCHv3 0/2] block: remove q->sysfs_dir_lock and fix race updating nr_hw_queue
Date: Tue, 28 Jan 2025 20:04:12 +0530
Message-ID: <20250128143436.874357-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uuzFyyJNPQ3QWphNf7vEW9OK316uRH5D
X-Proofpoint-ORIG-GUID: uuzFyyJNPQ3QWphNf7vEW9OK316uRH5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=986 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280108

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

I ran blktests and xfstests with lockdep configured to ensure that above 
changes don't generate lockdep spalt.

Nilay Shroff (2):
  block: get rid of request queue ->sysfs_dir_lock
  block: fix nr_hw_queue update racing with disk addition/removal

Changes from v2:
  - few nitpicking fixes in the second patch (hch)
  - Link to v2: https://lore.kernel.org/all/20250123174124.24554-1-nilay@linux.ibm.com/

Changes from v1:
  - remove q->sysfs_init_done and replace it with registered queue
    flag (hch)
  - fix nr_hw_queue update racing with disk addition/removal (hch)
  - Link to v1: https://lore.kernel.org/all/20250120130413.789737-1-nilay@linux.ibm.com/

Nilay Shroff (2):
  block: get rid of request queue ->sysfs_dir_lock
  block: fix nr_hw_queue update racing with disk addition/removal

 block/blk-core.c       |  1 -
 block/blk-ia-ranges.c  |  4 ----
 block/blk-mq-sysfs.c   | 40 ++++++++++++++--------------------------
 block/blk-sysfs.c      |  5 -----
 include/linux/blkdev.h |  3 ---
 5 files changed, 14 insertions(+), 39 deletions(-)

-- 
2.47.1

