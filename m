Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48EC184F
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539168; cv=none; b=nfJa13uj8wUaCMnSGNe0Ov99DGUeentJMSPGUI/oK/cdgJ0vJYYIIL+SAIgILoYhhVrPNzhx+TJQa/4djv2bIogc3sN9j+vFx1RT30FZ4vSsMUUJjqGVwX2/URCz2K2r25K9jEGsPS59xI60f+JnNhHu6LeV1x3P9Ob+ad04Ajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539168; c=relaxed/simple;
	bh=o5MXIRlp6OpH0K+G5zh1oXrmnt2V1s4XeZyoJZgk5xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uD6ntV9XsWkhrYdA1VzQP/GBG7Anpjn8CQyNcHufAkUsbJT/NvsvoZKOuNNA6adUD+v7owVTqTn4+X5Go+won84VMs5hz0zcpD0ArJWsaQA6k8Md6gCYpG69QIz7fb7iL5riHMx6KRNat0zDPQfrOb1IRtUCih7FGCKyLRw7ipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pL39pvNW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pL39pvNW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L6O1dc022139;
	Fri, 21 Mar 2025 06:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zsgNrHpXvgxwSStGVtsg/51L0UUdDqJ2W5hnKd0dk
	MY=; b=pL39pvNWqW1pwmI4S9wF80txjfWMoRZlfNdgOi34NYVPy4DKKsNFzOdMi
	pGEG8d/kNgPC3PCFBR7uTXArI/CRZq8kKwauuL7/lLeVN5fUPQu3bkQfg6Z+n8pp
	9DNeygn6JGJDZ8DW7jYXoYKjwrY3yZnDxpuB3sCE4G5T7smY/oz5mwkOFyblxeyC
	5x9al1bxoD4CXnpoQSxBx02ggI0GCDsYTGHXhN5qvHzXgSkfIjNH2WcuEUyD8DX5
	4dXjA01Fbh2qtUsAjIBD+3jftHFQAnICJwmkjO+HN1cOGcgcm36b98tXu8+mCNyo
	KfqG+vocwzWZ4iPwd0D/HblFi7HcQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gq6w30xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 06:39:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52L6MeEV019199;
	Fri, 21 Mar 2025 06:39:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvpc3b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 06:39:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52L6d6Fd34538226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 06:39:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8513C20049;
	Fri, 21 Mar 2025 06:39:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C95020040;
	Fri, 21 Mar 2025 06:39:03 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.80.43])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Mar 2025 06:39:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCH 0/2] improve NVMe multipath handling
Date: Fri, 21 Mar 2025 12:07:21 +0530
Message-ID: <20250321063901.747605-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9IXGCRWYHCh6brL4YgCD24DSwB2HWKRB
X-Proofpoint-ORIG-GUID: 9IXGCRWYHCh6brL4YgCD24DSwB2HWKRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_02,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503210045

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

A new sysfs attribute, delayed_shutdown_sec, allows users to configure
this timeout. By default, it is set to 0 seconds, preserving the
existing behavior unless explicitly changed.

Additionally, please note that this change now always creates head disk
node for all types of NVMe disks (single-ported or multi-ported) as well
as shared/private namespaces, unless the multipath nvme-core module
parameter is explicitly set to false or CONFIG_NVME_MULTIPATH is disabled.

The second patch removes the multipath module parameter parameter from
nvme-core, making native NVMe multipath support explicit. Now with first
patch changes, the multipath head node is always created, even for single-
port NVMe disks when CONFIG_NVME_MULTIPATH is configured. Since this
behavior is now default, the multipath module parameter may no longer be
needed. IMO, the CONFIG_NVME_MULTIPATH (native-multipath) should be the
default and non-native multipath should ideally be deprecated by now,
however I didn't remove CONFIG_NVME_MULTIPATH in this series. So users 
who still prefers non-native multipath can disable CONFIG_NVME_MULTIPATH 
at compile time. Having said that, if everyone agress we may depreacte 
non-native multipath support for NVMe.

These changes should help improve NVMe multipath reliability and simplify
configuration. Feedback and testing are welcome!

PS: Yes I know this RFC is late, but the intention is to get feedback/
suggestion in the upcoming LSF/MM/BPF summit. This might be used as a
reference implementation for discussion. I also saw that we've already
got a timeslot where John is going to talk about removing NVMe multipath
config option. Maybe we could include it in that discussion, if everyone
agress.

Thanks!
--Nilay

Nilay Shroff (2):
  nvme-multipath: introduce delayed removal of the multipath head node
  nvme-multipath: remove multipath module param

 drivers/nvme/host/core.c      |  36 ++++------
 drivers/nvme/host/multipath.c | 127 ++++++++++++++++++++++++++--------
 drivers/nvme/host/nvme.h      |   5 +-
 drivers/nvme/host/sysfs.c     |  13 ++++
 4 files changed, 132 insertions(+), 49 deletions(-)

-- 
2.47.1

