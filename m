Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B5189528
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766722; cv=none; b=WMgCp/l6Fh+MkAqJN1j1AuzHaJwqewC9C2B4pBaTqVEAfY/Yq9NwgciR9zcaYFpxO8/kcB5McTicSKLqISPUUupGavFFE7Wdvd4dQsn29S95ukDGicmTzBclH2NUoliJp0kG/p1K2/bsaQXj+iNXrgVjDpzAybkWTURA03jqMCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766722; c=relaxed/simple;
	bh=lpqu3MLJfZ1NPuVbFjQ37lxKnxYrcDuQLwoXAhWf+qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tZ6I49GA6HXxMq/OW7MKMSuNtLPcttN9BcMh6LeRpEV31S2S6WbJGgNITTGATTc4Tju5BgRXsgQOaaEhYUuzc+zCK7+77kIRtLQRLCSa0uJquCJ9GfA6cK7z7tG8Fnllgrrp2gM79gGe0tJy7QRHUV7i5q9YF/MPU82ozj5pH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QLpe6SAW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QLpe6SAW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515CLmsj009854;
	Wed, 5 Feb 2025 14:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sraadOpGxyi3DACaw80fLnXRzdsti5u4NO9sYzSoc
	fM=; b=QLpe6SAWDi2QBPzkRBIRZo/A8/hDBrCO4h2f0att7/WiLq/D0cxA1xrqP
	jwxEsnjO1FtwVdluv+wG3pbb5zALbTIPkyN+ZlwyKQX079UlJPQglGYveqP0WA8Q
	8D5WOsqdorBiKgd8W1C/Ef3W7qMy6RFSO7+rnu85jAdgCqJ3w/rq0jBYYGncUjki
	cy9JQAPx/JihDSHB99oV8dpF2taIBgGkGfokWjK/Lmdcub01ZEQfm1lLI3t3B+0D
	PdI0AHRXYiKoC+s8p0ly5hdd7ckSBYpA/rUUKohdD/NFaPfrDglFmwr16A2OTpAj
	n+G26trMkEDYrBRd7SBTzy+K3wEWA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kxtyk56c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 14:45:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515E3Gbf021474;
	Wed, 5 Feb 2025 14:45:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n1gw3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 14:45:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515Ej9jR30474518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 14:45:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C665820043;
	Wed,  5 Feb 2025 14:45:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F4A420040;
	Wed,  5 Feb 2025 14:45:08 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.80.122])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 14:45:07 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
Subject: [PATCH 0/2] block: fix lock order and remove redundant locking
Date: Wed,  5 Feb 2025 20:14:46 +0530
Message-ID: <20250205144506.663819-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tWsxK8Y8oxsMF6XhoP315FezFUfYjT9C
X-Proofpoint-ORIG-GUID: tWsxK8Y8oxsMF6XhoP315FezFUfYjT9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050114

Hi,

This patchset contains two patches in the series. The fist patch fixes
the incorrect lock ordering between queue ->sysfs_lock and freeze-lock.
And the second patch avoids using q->sysfs_lock while accessing sysfs
attribute files.

After we modeled the freeze & enter queue as lock for supporting lockdep
under commit f1be1788a32e ("block: model freeze & enter queue as lock
for supporting lockdep"), we received numerous lockdep splats. And one
of those splats[1] reported the potential deadlock due to incorrect lock
ordering issue between q->sysfs-lock and q->q_usage_counter. So the
first patch in the series addresses this lockdep splat.

The second patch in the series removes unnecessary holding of q->sysfs_lock
while we access the sysfs block layer attribute files. Ideally, we don't
need to hold any lock while accessing sysfs attribute files as attribute 
file is already protected with internal sysfs/kernfs locking. For instance,
accessing a sysfs attribute file for reading, follows the following
code path:
    vfs_read
      kernfs_fop_read_iter
        seq_read_iter
          kernfs_seq_start  ==> acquires kernfs internal mutex
            kernfs_seq_show
              sysfs_kf_seq_show
                queue_attr_show

Similarly, accessing a sysfs attribute file for writing, follows the
the following code path:
    vfs_write
      kernfs_fop_write_iter  ==> acquires kernfs internal mutex
        sysfs_kf_write
          queue_attr_store

As shown in the above code path, kernfs internal mutex already protects
sysfs store/show operations, and so we could safely get rid off holding
q->sysfs_lock while accessing sysfs attribute files.

Please note that above changes were unit tested against blktests and
quick xfstests with lockdep enabled.

Nilay Shroff (2):
  block: fix lock ordering between the queue ->sysfs_lock and
    freeze-lock
  block: avoid acquiring q->sysfs_lock while accessing sysfs attributes

 block/blk-mq-sysfs.c |  6 +-----
 block/blk-mq.c       | 49 +++++++++++++++++++++++++++++---------------
 block/blk-sysfs.c    | 10 +++------
 block/elevator.c     |  9 ++++++++
 4 files changed, 46 insertions(+), 28 deletions(-)

-- 
2.47.1

