Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4423BCF3
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403879; cv=none; b=iTMPjfyFl01WGt2/zKTY8KqqJZDDZqwQaoOlul2fSpXK9jTuzrzsSREO5ycYq/NPYvl5RNiKslxXiM6y6Rem/EdsDC6DDvaFMOHk0JVsrYNqFf1lFcu9Kk/9PinnqyVyNn2SZ6xqfRDCtvN9XkK/Y+2WBlUrN+YRgbVDKq6PZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403879; c=relaxed/simple;
	bh=j96H9dYHJCKGCVQTdhQfmCUtcVQCMs++T3m5W+djFFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cRK8jg/MCrIExWY0YatHFO7inHCJGqkAqTrwhZrj4HkSyLDyG1GSpJtsV76Vz90Z8cFT5gwS5fGaEBrcUtWaZrh3dxRoR/puojR0owXvtvjie40A4jm6A7krPjmnKtkIp5ux0JGw9Xy1e9n5pBPaj7F71hLWofMkx1G/TsJkHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=atj8vMIq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="atj8vMIq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O6Pn2t019979;
	Mon, 24 Feb 2025 13:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=lcChetu8Ysx+QssbaWBTXYjcEIbP77dge+4cmnrH4
	pM=; b=atj8vMIq1VuITrBSB1ME6mWMMhc9KE3/rZ2VAHt5rWc0eQ6RR8rNSAalm
	SZQHUZV7RMXHkxg+fggEUN7UO8YHnWoF5pPsQCCOyU73wRi75RLHfMM8KQZeiwK7
	kAxbaNbUVDAGIVJV/9SUAvf0KdpGgwHMfUerZsV1Q07Hccv3VDU7mmJj5T/pEUe0
	s+zdCl2GNSgfJ68O9HUAa5GtK9oE1fwtLP9PlN2FZlrLVOF/AkOSOFRhw8K5zhyH
	j4OAjKHEbPiftYLfioQGGBc1z9VOBQGqax4uitk8dodVrlD5rIQ265OragjpArW0
	+YHGJcTGN6WWs02nq0v1gpphyZ0Tg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450kg69rue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:31:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCToXl026304;
	Mon, 24 Feb 2025 13:31:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswn7a6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 13:31:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ODV55n42008952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 13:31:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21BD420043;
	Mon, 24 Feb 2025 13:31:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C34B20040;
	Mon, 24 Feb 2025 13:31:03 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Feb 2025 13:31:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv3 0/7] block: fix lock order and remove redundant locking
Date: Mon, 24 Feb 2025 19:00:51 +0530
Message-ID: <20250224133102.1240146-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lw8_bI-BHDYMM0Z-UxqX2fQG-iI3M1HF
X-Proofpoint-GUID: Lw8_bI-BHDYMM0Z-UxqX2fQG-iI3M1HF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=831 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240098

Hi,

After we modeled the freeze & enter queue as lock for supporting lockdep
under commit f1be1788a32e ("block: model freeze & enter queue as lock
for supporting lockdep"), we received numerous lockdep splats. And one
of those splats[1] reported the potential deadlock due to incorrect lock
ordering issue between q->sysfs-lock and q->q_usage_counter. So some of
the patches in this series are aimed to cut the dependency between q->
sysfs-lock and q->q_usage_counter.

This patchset contains seven patches in the series.

The 1st patch helps acquire q->limits_lock instead of q->sysfs_lock while
reading a set of attributes whose write method is protected with atomic
limit update APIs or updates to these attributes could occur under atomic
limit update APIs such as queue_limit_start_update() and queue_limits_
commit_update(). So all such attributes have been now grouped in queue_
attr_show under ->show_limit() method.

The 2nd patch is preparation to further simplify and group sysfs attributes
in subsequent patches. So in this patch we move acquire/release of q->sysfs
_lock as well as queue freeze/unfreeze under each attributes' respective
->show()/->store() method.

The 3rd patch removes the q->sysfs_lock for all sysfs attributes which
don't need it. We identified all sysfs attributes which don't need any
locking and removed use of q->sysfs_lock for these attributes.

Subsequent patches address remaining attributes individually which require
some form of locking other than q->limits_lock or q->sysfs_lock.

The 4th patch introduce a new dedicated lock for elevator switch/update
and thus eliminates the dependency of sched update on q->sysfs_lock.

The 5th patch protects sysfs attribute nr_requests using q->elevator_lock
instead of q->sysfs_lock as the update to q->nr_requests now happen under
q->elevator_lock.

Similarly, the 6th patch protects sysfs attribute wbt_lat_usec using
q->elevator_lock instead of q->sysfs_lock as the update to wbt state and
latency now happen under q->elevator_lock.

The 7th patch protects read_ahead_kb using q->limits_lock instead of
q->sysfs_lock as update to ->ra_pages is protected by ->limits_lock.
The ->ra_pages is usually calculated from the queue limits by queue_
limits_commit_update.

Please note that above changes were unit tested against blktests and
quick xfstests with lockdep enabled.

[1] https://lore.kernel.org/all/67637e70.050a0220.3157ee.000c.GAE@google.com/

---
Changes from v2:
  - Add a prep patch (second patch in the series) to first move q->sysfs_
    lock and queue freeze from queue_attr_show/queue_attr_store to show/
    store method of the respective attribute; then in subsequent patches
    we remove q->sysfs_lock from attributes that don't require any from of
    locking or replace q->sysfs_lock with appropriate lock for attributes
    that require some form of locking; this way we can get away with using
    ->show_nolock()/->store_nolock() methods (hch)

  - Few other misc updates to commit message and code comments (hch)

  - Rearrange the patchset to improve organization and clarity. Start with 
    a patch that groups all attributes requiring protection under ->limits_
    lock. Follow this with a preparatory patch, then introduce a patch that 
    consolidates attributes that do not require any form of locking. 
    Finally, address the remaining attributes individually in subsequent 
    patches, which require some form of locking other than q->limits_lock 
    or q->sysfs_lock.

Link to v2: https://lore.kernel.org/all/20250218082908.265283-1-nilay@linux.ibm.com/

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
Nilay Shroff (7):
  block: acquire q->limits_lock while reading sysfs attributes
  block: move q->sysfs_lock and queue-freeze under show/store method
  block: remove q->sysfs_lock for attributes which don't need it
  block: Introduce a dedicated lock for protecting queue elevator
    updates
  block: protect nr_requests update using q->elevator_lock
  block: protect wbt_lat_usec using q->elevator_lock
  block: protect read_ahead_kb using q->limits_lock

 block/blk-core.c       |   1 +
 block/blk-iocost.c     |   2 +
 block/blk-mq.c         |  15 +-
 block/blk-settings.c   |   2 +-
 block/blk-sysfs.c      | 309 +++++++++++++++++++++++++++--------------
 block/elevator.c       |  43 ++++--
 block/elevator.h       |   2 -
 block/genhd.c          |   9 +-
 include/linux/blkdev.h |   5 +
 9 files changed, 251 insertions(+), 137 deletions(-)

-- 
2.47.1

