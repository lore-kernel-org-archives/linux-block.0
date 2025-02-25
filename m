Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B2A267AF3
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490293; cv=none; b=juetkNDoq+uHRYaP9ZKAeEVuZxDdI6nSIYZ4e86jMgz2TZ0CxWNTIeXBVVM5Y0iRC2U1j+fqCM92BIzC04T43Q+ANvSLyNXS53RXCj5TT06SsLniuumI7DMAxCVDpVC+jW9XSrvqFCPGLXmTyulgZwWp7Nyw4Pr8yPenGuUvtk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490293; c=relaxed/simple;
	bh=Xy2pKPMVcH8Bs+K5wgp4QKezBlaIHVO8fLG7kOzvevA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3i6ePaJWUixVOFAEwP7wpIQ/uDG5NjT/0k8m4OTCZMqSXsnS1D32RNqEPMMiXWGDEBhqI8aORI66n6i6fy6Iqc0SnqmuXKroXzxF42h/W8N1WBmh1V4mSLxy9PYXLFjLUld4rBqfy0ldsgFZqAAghdcm9OGEhRMYrxWLyVJVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J/wZVDVo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J/wZVDVo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P5OLmw005424;
	Tue, 25 Feb 2025 13:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QJ8TbjPScTNvpg5KNaTP2OUoi+n3nbJ5HIZd9VJjd
	d8=; b=J/wZVDVoZdemn+lWt8lNjxNwvd7HWyd8DZGjUn+MvCC4KMvfonN1ufjMM
	eHm7v55USmyDyeS1UksgcPQa+QG4PBzOXWGX2KOraquQybU2tgGU322ZUOpOUC9l
	3+h4kfjXhXYDzjfR/oLqFr9dhnVSDcwk+BQCM/PbgcrIZn3TlUU/tHXLmXVpNLJY
	iG4YPzP4gqI+HA/B9MqlNHmpR9EKZq/AKEFQhXGzO6LBqpv2WxORvJxxjhmW+IHE
	agtRvT/RUQTdwDK1e7KPSNusc1iH0U4VXabYEoHQ+FrDE0BG0uCR0vZGfBAqTbsb
	/IewKwXlxrjaX7WFqe2yQeWVk03wg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4517p8j8kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PBNDkn002595;
	Tue, 25 Feb 2025 13:31:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jmsxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PDVHif52363548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:31:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A8FC2004B;
	Tue, 25 Feb 2025 13:31:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1A1C20043;
	Tue, 25 Feb 2025 13:31:13 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.156.112])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 13:31:13 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv4 0/7] block: fix lock order and remove redundant locking
Date: Tue, 25 Feb 2025 19:00:35 +0530
Message-ID: <20250225133110.1441035-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rtXRMDsLwQ7bKHUQfN6sAr8UPLRdJGYT
X-Proofpoint-ORIG-GUID: rtXRMDsLwQ7bKHUQfN6sAr8UPLRdJGYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=835 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250092

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
Changes from v3:

  - Make code comment a proper senteence. Also mention the 
    fields protected by q->elevator_lock (hch)

  - Add a comment describing lock ordering followed for 
    newly introduced ->elevator_lock (Hannes Reinecke)  

Link to v3: https://lore.kernel.org/all/20250224133102.1240146-1-nilay@linux.ibm.com/

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
 include/linux/blkdev.h |   8 ++
 9 files changed, 254 insertions(+), 137 deletions(-)

-- 
2.47.1

