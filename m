Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07161AF0B0
	for <linux-block@vger.kernel.org>; Mon, 20 Jan 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378269; cv=none; b=Jxd61x+7KuoN1f8IT8pYg//QSsgcxyIgt6dTc8rRH002yLh3FwmHqnmHOI/ngkenGz5D9uSerFog+lW4/u/gLxNcOqOkJ2/Hjhb2ME3fyACuvbo4IExKNU1GbLWYz0nEb8c0QzmMCroY5Q8he2ngRTBAFUveo6YpOqrlpaC87yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378269; c=relaxed/simple;
	bh=fpFGEnnS7iA5mirffAsAiJpH11evZEq2Upaa9sV+Opc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eU3e9kNoTVUnFSW03YXpNOzWmQ0pGPrcBCmJGdvdC6v5iDLGROV67Frwo2kHNdD4EUfjreAtOr5GpctkStT7t1AZeT/oUXD/sCIRgmlX6rzkMQcUAahKTF9B+ECUf7bz2y6MKOWiO8X13Yfk+Zx+pJzSo0G42jDTbSqmNWIT8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NMw8XsO4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NMw8XsO4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7WxZb010748;
	Mon, 20 Jan 2025 13:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1t4+394KrUNR5ukAnAo0MnBq0mfQAjAb+SVpGOqSb
	q4=; b=NMw8XsO4ctabc/Mq0DBEmwjx8pIj3bgZkif6b4VmafITWKglHzJVq61hn
	S+y3C5cwFpsXSBD4fagWq4vM8vwMDS7Y/ydr9HHYgWbce69Cl5h2eGf2v74K+q5q
	rdX075WTW+yhDcWru7DBb2vuotuIwU0ROjN2NcqVNlOHwilhkPVIs0hWw77c4uS/
	E+vbo7u7rvtZ2mLTE7DPPWphdskr80LqRmvYrAtn5gWVOkWzjYMwu0A4dRnSQWYY
	J+fUyi84BUgTNIdOuhhMrB4WugWEy5ua0Djs3Tr8mtI8CEkJRBi3dDnJM6B/nuRJ
	1vBrFYDb5Po2yooKjYk84i6mj5HkQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449j6n9du4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 13:04:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50K9CI5S021074;
	Mon, 20 Jan 2025 13:04:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb162f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 13:04:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50KD4Fnj50135340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 13:04:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9DA620040;
	Mon, 20 Jan 2025 13:04:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2951C20049;
	Mon, 20 Jan 2025 13:04:14 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.54.147])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 13:04:13 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [RFC PATCH 0/1] remove redundant  q->sysfs_dir_lock
Date: Mon, 20 Jan 2025 18:34:10 +0530
Message-ID: <20250120130413.789737-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hxTlo8G2Kdvp0800-KH4ORKxRVd9-UBK
X-Proofpoint-ORIG-GUID: hxTlo8G2Kdvp0800-KH4ORKxRVd9-UBK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=313 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200108

Hi,

In the current implementation we use q->sysfs_dir_lock for protecting
kobject addition/deletion while we register/unregister blk-mq with
sysfs. However the sysfs/kernfs internal implementation already protects
against the simultaneous addtion/deletion of kobjects. So in that sense
use of q->sysfs_dir_lock appears redundant.

Furthermore, there're few other callsites in the current code where we
use q->sysfs_dir_lock along with q->sysfs_lock while addition/deletion of
independent access ranges for a disk under sysfs. Please refer, disk_
register_independent_access_ranges() and disk_unregister_independent_
access_ranges(). Here as well we could easily remove use of q->sysfs_dir_
lock.

The only thing which q->syfs_dir_lock appears to protect is the use of
variable q->mq_sysfs_init_done. However this could be solved by converting
q->mq_sysfs_init_done to an atomic variable.

In past few days, we have seen many lockdep splat in block layer and
getting rid of this one might help reduce some contention as well we
need to worry less about lock ordering wrt to this lock.

Nilay Shroff (1):
  block: get rid of request queue ->sysfs_dir_lock

 block/blk-core.c       |  1 -
 block/blk-ia-ranges.c  |  4 ----
 block/blk-mq-sysfs.c   | 25 +++++++------------------
 block/blk-sysfs.c      |  5 -----
 include/linux/blkdev.h |  3 +--
 5 files changed, 8 insertions(+), 30 deletions(-)

-- 
2.47.1
