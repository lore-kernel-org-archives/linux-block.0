Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FA20102B
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577239; cv=none; b=DmUNeySG2RrztZ4415BEO6NBvSfqfO1exGeoz2zvPeaRKdT8ma3frdhb223MPeJqB0XjGHQy0SZPCLlklcqQCM+MDY8uRVDMvhxs/ViCMceKu1hQ1I2nPbpnezI21m8uMznhxlcTAjko2XkMJWY3ajMOQB/Iy2wiZRAzyxSptSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577239; c=relaxed/simple;
	bh=igcYz/L6Ab150PMarOKiRTEJ4k+OD0mC6k3Ha2eImnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTcwySsiTHiAueMwrmdpjClkXJjQ5FfupGAMsKtCj5ST4FcoODpD3rR21CLuacJjzeM+oQDV91zdbloX6ygFrTB0W0oShY4dSnZDy0uCaunjOFpEw2tD6tc/Nji9GNXyEykw5UbLo/k8To/8+KId14str2efaQqv29tpNC1CIGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hmu2loh5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hmu2loh5"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9jsI9025843;
	Fri, 25 Apr 2025 10:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1Jm8Wwm8ypDbV+3LHaBooGsLA7z5orOub9/v/ehTS
	yo=; b=hmu2loh5bDjk3YRSjcQ+koX7wU4Xdny5O1tPsyxMgD0/kF0YwN4UVevXJ
	xW5zMn8dIUY9ll3NjtLXbRWqKC+nlwSu3R6LugJ9eM32Uhqu51fG7uJmGUZKdvAb
	lc1eKcM8wyP+x+cu0nq5PDhMG9zD4aSY8bvaJlOdMjjKkaE5KVL4w4PG1EiKGVdR
	PnL1DOxXUcn3eBTzuxcx3d7U2s/gAWaaflBmQr6UmkOT4JMUrbYuo+BsLVpU/04Z
	MoVFwYLToJMD2gXsuDxl41M9AF62Dt3jy444SVzIBwzrr4KXh3bHJ8ERK1G9BqzH
	Qcjh2ICuOuR4sxEhSKN0VL8ZavZzQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467y90t9dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:33:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8UWvc028447;
	Fri, 25 Apr 2025 10:33:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvvrkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:33:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PAXO2440304990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:33:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86D6120043;
	Fri, 25 Apr 2025 10:33:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D4D520040;
	Fri, 25 Apr 2025 10:33:21 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.102.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 10:33:21 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv2 0/3] improve NVMe multipath handling
Date: Fri, 25 Apr 2025 16:03:07 +0530
Message-ID: <20250425103319.1185884-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aZRhnQot c=1 sm=1 tr=0 ts=680b64f7 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=9r6QK0OtAAAA:8 a=VnNF1IyMAAAA:8 a=j6BUnaCqT4P7MYeGl-oA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=TxIH8fH_K59pr5-VUUuU:22
X-Proofpoint-GUID: NhMmGBaqEXdsqtqKqQ7s7fI2tcpUK8w8
X-Proofpoint-ORIG-GUID: NhMmGBaqEXdsqtqKqQ7s7fI2tcpUK8w8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MyBTYWx0ZWRfX7heYKteHaZ8U PMYJ4d0EYxihQRuce7Gr9XwGggZyHepxYM/ZRFq4dtQQnf/FfI1ADHChZorucIg2CUCR+RjdUUS TdrZyaysDZQGGYV1eztH/+0rlUrExJ6rAPnqDg43dLdeW2ehEh2tjbEAFp/myJZ3ipyO63lzHkD
 wK3jSl6MlIqZfBY5jBCd+uPaR0FBApGmWM/vHSObMgi0gbqxtviaWa7aMBLBZydGDbx8p4EuTKA WJodlkq5jvMK2HCcn/ALxw5HtbDIwCTT0a3I9ualyIUfzq3+N95ub1mxJ7KVy24XXjyujWNZXhR muQgzhWt0eSDqPDMk/n1V4nU4C27aOlJzPxZNKWXiJJR89dQH0SbVpUrN39+gQc+SatpZd6FNOF
 aPoIYckgPaM7v0f3kTLY9Fu96CKUH5pdnKtXBU5PjpE2UORzs3rTV15t/ZWxX6TYbwcDyuGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250073

Hi,

This patch series introduces improvements to NVMe multipath handling by
refining the removal behavior of the multipath head node and simplifying
configuration options. The idea/POC for this change was originally
proposed by Christoph[1] and Keith[2]. I worked upon their original
idea/POC and implemented this series.

The first patch in the series addresses an issue where the multipath
head node of a PCIe NVMe disk is removed immediately when all disk paths
are lost. This can cause problems in scenarios such as:
- Hot removal and re-addition of a disk.
- Transient PCIe link failures that trigger re-enumeration,
  briefly removing and restoring the disk.

In such cases, premature removal of the head node may result in a device
node name change, requiring applications to reopen device handles if
they were performing I/O during the failure. To mitigate this, we
introduce a delayed removal mechanism. Instead of removing the head node
immediately, the system waits for a configurable timeout, allowing the
disk to recover. If the disk comes back online within this window, the
head node remains unchanged, ensuring uninterrupted workloads.

A new sysfs attribute, delayed_removal_secs, allows users to configure
this timeout. By default, it is set to 0 seconds, preserving the
existing behavior unless explicitly changed.

The second patch in the series introduced multipath_head_always module
param. When this option is set, it force creating multipath head disk
node even for single ported NVMe disks or private namespaces and thus
allows delayed head node removal. This would help handle transient PCIe
link failures transparently even in case of single ported NVMe disk or a
private namespace

The third patch in the series doesn't make any functional changes but
just renames few of the function name which improves code readability
and it better aligns function names with their actual roles.

These changes should help improve NVMe multipath reliability and simplify
configuration. Feedback and testing are welcome!

[1] https://lore.kernel.org/linux-nvme/Y9oGTKCFlOscbPc2@infradead.org/
[2] https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/

Changes from v1:
    - Renamed delayed_shutdown_sec to delayed_removal_secs as "shutdown"
      has a special meaning when used with NVMe device (Martin Petersen)
    - Instead of adding mpath head disk node always by default, added new
      module option nvme_core.multipath_head_always which when set creates
      mpath head disk node (even for a private namespace or a namespace
      backed by single ported nvme disk). This way we can preserve the
      default old behavior.(hch)
    - Renamed nvme_mpath_shutdown_disk function as shutdown as in the NVMe
      context, the term "shutdown" has a specific technical meaning. (hch)
    - Undo changes which removed multipath module param as this param is
      still useful and used for many different things.

Link to v1: https://lore.kernel.org/all/20250321063901.747605-1-nilay@linux.ibm.com/

Nilay Shroff (3):
  nvme-multipath: introduce delayed removal of the multipath head node
  nvme: introduce multipath_head_always module param
  nvme: rename nvme_mpath_shutdown_disk to nvme_mpath_remove_disk

 drivers/nvme/host/core.c      |  18 ++--
 drivers/nvme/host/multipath.c | 193 ++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h      |  20 +++-
 drivers/nvme/host/sysfs.c     |  13 +++
 4 files changed, 211 insertions(+), 33 deletions(-)

-- 
2.49.0

