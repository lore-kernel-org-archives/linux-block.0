Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C0226CF5
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950099; cv=none; b=OQ/t7UDIJnTVJa7y0Y00gV7yPwvOB2pIyUOn/L7XoH62XKpqBRllcxGx725yJhl5RXV1L9eXLSnDlyGcOyqkHOHGNR4kMmMhtAENxVOcZHQ9QNYmj+Dzce88OVHZiPTf4qBHUT2a1QL//RiAht1vhFwqkzVk17/WwA3jppbl+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950099; c=relaxed/simple;
	bh=iMt3MLvK1CfaVkCeBIBVoLcn3Nap609Rv57TuzRYqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbcwzJ1opRKPOORPYlhAwwSoM5NreuK2nCUuwNtZUwkCwefiGN063yG9erBGJsHPP/4Y4geYS0JSRVC5lPfNzRoTvHA6q2b3J4LOBYi4zs/hgmoHyhVyWHOOwBtq3RVm2VLr8CxpdWLX+ppIlsM04DuCJ1fEYHLAMi4xlp/R4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SbzH4LjE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SbzH4LjE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5536doqj013847;
	Tue, 3 Jun 2025 11:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=iYR1fTjp8DSyOzl9GxsibHWgW/slQNDiXqiFfyx4l
	bs=; b=SbzH4LjEt3Py4gHXFfNFTins029sNLGrEhDiSC9jWuhjIdpAr+bP3k56U
	YceZAnf6aTP5f3xLvrzOQcPn5SyxfKEjtohMUTMF5zxKpkV3YemLv19QvC3u6ZXm
	8Mx9t+XsMqGiyG2Tyd+O8r6BGetPVCiJezxG6riJ9VbwZAqM78KtJK9PHDQM39cE
	OVy+vW35PjGTLP4yY/YLZMLYwSukttZK5YNS2hk+EkFUTvCQX7KIKPVaNHJNcEKr
	Bx+agH96uWcvxfpCZ0tH6X3CbztBWBjfaG7COs7qkEppf+zDxocTToM+FBxDPONA
	Te53tLqQ2gtFKWp110Gq6azc07P7g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geym0h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 11:28:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 553A2BZt019937;
	Tue, 3 Jun 2025 11:28:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470d3ntkvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 11:28:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 553BS6u146006654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Jun 2025 11:28:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD50820043;
	Tue,  3 Jun 2025 11:28:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27B9D20040;
	Tue,  3 Jun 2025 11:28:05 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.229])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Jun 2025 11:28:04 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: john.g.garry@oracle.com, hch@lst.de, martin.petersen@oracle.com,
        axboe@kernel.dk, ojaswin@linux.ibm.com, gjoyce@ibm.com
Subject: [PATCH] block: fix atomic write limits for stacked devices
Date: Tue,  3 Jun 2025 16:57:55 +0530
Message-ID: <20250603112804.1917861-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kKwV0Il6tILdTwrpRMiri11yfeSaBTwW
X-Proofpoint-ORIG-GUID: kKwV0Il6tILdTwrpRMiri11yfeSaBTwW
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=683edc49 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=AAN4juC_3fix_dPwL54A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA5NyBTYWx0ZWRfX+tFk1MlxEXAj HMJqwso90ZF5JITeFwQAM+fqYSWdzNjWUUt0gA5huGR1e0ptN25aSt2zwbraFP2ANcD2P3PNRsv wpBq59rAITx8PzWGLAE71Atv/9lAtxjV3DMyuhP/lp6aqQVmqKD89VYipFV+OTK9w7jtsNkIQ3G
 UJ1eR86QSXcqJbFVMeaXTr0qLAvp4rClgP2feTa/NTg3ZL7947F/K5dnRk6yKX49d4ETmXwkAlD 6o8fDdSoKZNRKBfnyc0JKJvnNyYoYs++jMDVd3YC2WuM4QK59pW03Iag2S9Sp60LHpB3qhxjdHK QwqzD8NMCFhk3h6kki6T0XX5O7s9vlyZpG1YWLfFhTumB3ZrIsj2tRI51kXvdSqOiHvLwKe2EJd
 OIavozLWrI+h6JtpPbIgdzhTu8UmRsBaJzDl/wDLbDFP7cXFJBLnpvD9qEWoPV5eWAZAXZjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030097

The current logic applies the bottom device's atomic write limits to
the stacked (top) device only if the top device does not support chunk
sectors. However, this approach is too restrictive.

We should also propagate the bottom device's atomic write limits to the
stacked device if atomic_write_hw_unit_{min,max} of the bottom device
are aligned with the top device's chunk size (io_min). Failing to do so
may unnecessarily reduce the stacked device's atomic write limits to
values much smaller than what the hardware can actually support.

For example, on an NVMe disk with the following controller capability:
$ nvme id-ctrl /dev/nvme1  | grep awupf
awupf     : 63

Without the patch applied,

The bottom device (nvme1c1n1) atomic queue limits:
$ /sys/block/nvme1c1n1/queue/atomic_write_boundary_bytes:0
$ /sys/block/nvme1c1n1/queue/atomic_write_max_bytes:262144
$ /sys/block/nvme1c1n1/queue/atomic_write_unit_max_bytes:262144
$ /sys/block/nvme1c1n1/queue/atomic_write_unit_min_bytes:4096

The top device (nvme1n1) atomic queue limits:
$ /sys/block/nvme1n1/queue/atomic_write_boundary_bytes:0
$ /sys/block/nvme1n1/queue/atomic_write_max_bytes:4096
$ /sys/block/nvme1n1/queue/atomic_write_unit_max_bytes:4096
$ /sys/block/nvme1n1/queue/atomic_write_unit_min_bytes:4096

With this patch applied,

The top device (nvme1n1) atomic queue limits:
/sys/block/nvme1n1/queue/atomic_write_boundary_bytes:0
/sys/block/nvme1n1/queue/atomic_write_max_bytes:262144
/sys/block/nvme1n1/queue/atomic_write_unit_max_bytes:262144
/sys/block/nvme1n1/queue/atomic_write_unit_min_bytes:4096

This change ensures that the stacked device retains optimal atomic write
capability when alignment permits, improving overall performance and
correctness.

Reported-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Fixes: d7f36dc446e8 ("block: Support atomic writes limits for stacked devices")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-settings.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a000daafbfb4..35c1354dd5ae 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -598,8 +598,14 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
 	    !blk_stack_atomic_writes_boundary_head(t, b))
 		return false;
 
-	if (t->io_min <= SECTOR_SIZE) {
-		/* No chunk sectors, so use bottom device values directly */
+	if (t->io_min <= SECTOR_SIZE ||
+	    (!(t->atomic_write_hw_unit_max % t->io_min) &&
+	     !(t->atomic_write_hw_unit_min % t->io_min))) {
+		/*
+		 * If there are no chunk sectors, or if b->atomic_write_hw_unit
+		 * _{min, max} are aligned to the chunk size (t->io_min), then
+		 * use the bottom device's values directly.
+		 */
 		t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
 		t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
 		t->atomic_write_hw_max = b->atomic_write_hw_max;
-- 
2.49.0

