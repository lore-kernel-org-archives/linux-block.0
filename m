Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D91B4250
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867364; cv=none; b=Yq8YdSJ5FEB9u95/gl02gun/7T5BN8Bnj7TvImQCaca0TArvbCbjn4QSd+51stAoyl4tpZCt4JPe6fMQs88yBqGpHjuN/hjcsEIF7EAI15KoeAl2oI8uJwYDTU9Nb+Axk3AC8dxmQgNNTM1Oc2G3Nw1Lm2ic5QfX3hys+FzOPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867364; c=relaxed/simple;
	bh=7yYWbKODNL5fksG8BpnYYogvW3D56GSKxU7JI63uHgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvOvgq4jvt3A1orCr9ysKQZoBBd5iB7InA25nvWRJOKJcm3UfhZoGHYr3ZrWP6iwrtbS7gel1NCRJkAJRYl3o2pat18J8ZSvy9M02EJi9lIEaKPryWphv0wano6G/vDa74fzHAOFDwM4rfoLtjk63FBP+KpTztRSZzFsJ+phkN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XYhlXYvA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XYhlXYvA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I5ONR4010417;
	Tue, 18 Feb 2025 08:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8kUcSlByD1cmh4199xjgE9tjn6QCNnSuRErvVRqSw
	gg=; b=XYhlXYvAD9IYFCWV5DocZ9OS2RHXqaQV4c8M5p7VhPcjIITcWPSm0byU7
	y4slOrONqmXecDpNvR0AYyWTSOcWsyR1Y+0R+3K4NBM76PoQye17DLxpd8RyP3bk
	291uI3CLWZejs872hI2K31QtYRipzDSfJFCpeFQuQrWoDs+wJltO4EPeg6NJBBmh
	eh7Y1FIWnsuW8BlS/NOI6UJNub+B6jAbBUFGwDDiY9/HQuEW4/QNAoTJQpJQXcV2
	6+aYubgju35Ds+oURNTL9crwsdaN1EXszRDbUv9csILKWJWihPDKITb2vfUGgu5B
	rhVQhVLQpLYfrWod4Ubh8GuLQmZZg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vm18rrhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51I62Z4n001613;
	Tue, 18 Feb 2025 08:29:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44u5myt5xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 08:29:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51I8TBpf35652236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 08:29:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B90D20043;
	Tue, 18 Feb 2025 08:29:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5C3B20040;
	Tue, 18 Feb 2025 08:29:09 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.198])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 08:29:09 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCHv2 0/6] block: fix lock order and remove redundant locking
Date: Tue, 18 Feb 2025 13:58:53 +0530
Message-ID: <20250218082908.265283-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HMjzhKdpr1m0Dvf1Jx_2IgB83EelYSS3
X-Proofpoint-ORIG-GUID: HMjzhKdpr1m0Dvf1Jx_2IgB83EelYSS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=581 malwarescore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180065

Hi,

After we modeled the freeze & enter queue as lock for supporting lockdep
under commit f1be1788a32e ("block: model freeze & enter queue as lock
for supporting lockdep"), we received numerous lockdep splats. And one
of those splats[1] reported the potential deadlock due to incorrect lock
ordering issue between q->sysfs-lock and q->q_usage_counter. So some of 
the patches in this series are aimed to cut the dependency between q->
sysfs-lock and q->q_usage_counter.

This patchset contains six patches in the series.

The 1st patch removes the q->sysfs_lock for all sysfs attributes which
don't need it. We identified all sysfs attributes which don't need any 
locking and all such attributes have been now grouped in queue_attr_show
/queue_attr_store under entry->show_nolock/entry->store_nolock methods.

The 2nd patch helps acquire q->limits_lock instead of q->sysfs_lock while
reading a set of attributes whose write method is protected with atomic
limit update APIs or updates to these attributes could occur under atomic 
limit update APIs such as queue_limit_start_update() and queue_limits_
commit_update(). So all such attributes have been now grouped in queue_
attr_show under entry->show_limit method.

Subsequent patches address remaining attributes individually and group
them in queue_attr_show/queue_attr_store under entry->show/entry->store 
method which require some form of locking other than q->limits_lock or 
q->sysfs_lock.

The 3rd patch introduce a new dedicated lock for elevator switch/update
and thus eliminates the dependecy of sched update on q->sysfs_lock.

The 4th patch protects sysfs attribute nr_requests using q->elevator_lock
instead of q->sysfs_lock as the update to q->nr_requests now happen under
q->elevator_lock.

Similarly, the 5th patch protects sysfs attribute wbt_lat_usec using
q->elevator_lock instead of q->sysfs_lock as the update to wbt state and
latency now happen under q->elevator_lock.

The 6th patch protects read_ahead_kb using q->limits_lock instead of
q->sysfs_lock as update to bdi->ra_pages could happen using atomic limit
update APIs. Ideally we should have grouped this attribute in queue_attr_
show/queue_attr_store under entry->show_limit/entry->store_limit method. 
However we don't use atomic update helper APIs queue_limits_start_update() 
and queue_limits_commit_update() here bacause blk_apply_bdi_limits() which 
is invoked from queue_limits_commit_update() can overwrite the bdi->ra_
pages value which user actaully wants to store using this attribute. The 
blk_apply_bdi_limits() sets value of bdi->ra_pages based on the optimal 
I/O size(io_opt). So we choose instead to update this attribute value 
outside of using atomic limit update APIs.

Please note that above changes were unit tested against blktests and
quick xfstests with lockdep enabled.

[1] https://lore.kernel.org/all/67637e70.050a0220.3157ee.000c.GAE@google.com/

Nilay Shroff (6):
  blk-sysfs: remove q->sysfs_lock for attributes which don't need it
  blk-sysfs: acquire q->limits_lock while reading attributes
  block: Introduce a dedicated lock for protecting queue elevator
    updates
  blk-sysfs: protect nr_requests update using q->elevator_lock
  blk-sysfs: protect wbt_lat_usec using q->elevator_lock
  blk-sysfs: protect read_ahead_kb using q->limits_lock

---
Changes from v1:
  - Audit all sysfs attributes in block layer and find attributes which
    don't need any locking as well as attributes which needs some form of
    locking; then remove locking from queue_attr_store/queue_attr_show and
    move it into the attributes that still need it in some form, followed
    by replacing it with the more suitable locks (hch)

  - Use dedicated lock for elevator switch/update (Ming Lei)

  - Re-arrange patchset to first segregate and group together all
    attributes which don't need locking followed by grouping attributes
    which need some form of locking.

Link to v1: https://lore.kernel.org/all/20250205144506.663819-1-nilay@linux.ibm.com/
---

 block/blk-core.c       |   1 +
 block/blk-mq.c         |  12 +-
 block/blk-settings.c   |   2 +-
 block/blk-sysfs.c      | 324 ++++++++++++++++++++++++++++-------------
 block/elevator.c       |  18 ++-
 block/genhd.c          |   9 +-
 include/linux/blkdev.h |   1 +
 7 files changed, 254 insertions(+), 113 deletions(-)

--
2.47.1

