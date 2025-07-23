Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CB28751F
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278317; cv=none; b=XLSYFrHwV2u2aYVZVMr8atk+eeWJBRvIGmLxeUCpBTsX62Wojvv57cusDjCu4RcliFmRICQy/ymFGi1eU1/d83Ad59Fad9fF7RJWZXpT7jt9pEiHHNPjePdv/Gk70vc/uJTYzgdJTpqWcIiKiP2HAN76OqIgUxbvvbdFjuFB8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278317; c=relaxed/simple;
	bh=8G/jbtxc/a+hCWlL52xrZaXySVIHMvuhnLKUb0RWsS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3oqLYxPe7oyymv9eEXCbHOzMStS7eOMFgXVEDoMssXnQ9gAowE/zOCxCNpf6WaXfLFvqOAjVZP0O5np7qEdjeuBNJy1VsOVJJegjojr/gp+Cq32vgfrpMBe07S0YLy5De7VieeprzR/3v6jwnRMIIEr1UJdoN4LvuRBAsW8QtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HTt1TO48; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HTt1TO48"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N6Ys0G015888;
	Wed, 23 Jul 2025 13:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4wg8/rVLaHOcbggAD
	7sISYXz+84PDhrHy0F7yQ+IZ2E=; b=HTt1TO48T5hXSuSVBlHDABZUkXZPbxkzB
	0fEaBLVjA2saV4oXrhiuMiBVALf09wl6I3fJoT1Mj8XJBD6MgldRm9jH0fzmQdWI
	MWB/YjzwbnMfEQOu9jHUbF/Kgy22I0a46cGPzZ3O3sY5vmqRrH6GkCJuk8GIlwB5
	bSojdK2Obm2YlDCKTyWcCdIe91XEeCYKD2lCcCI0tWU5TZFeFc+v3BJDNJILk5Y+
	JxvLmaQmT8lrpFNjPzCxP80vukr2NFD/3jJo1MS/WWUZx/k5YQj7uE6dFwB+KNny
	VVY67guQX5Z/0woLiXcnUN0gslbwKyMf85dQBzQSNiToFkgntoNjg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff651uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:44:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56NB5vAo024960;
	Wed, 23 Jul 2025 13:44:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptr6uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 13:44:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56NDioPB19530058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 13:44:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F2162005A;
	Wed, 23 Jul 2025 13:44:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DBFE2004F;
	Wed, 23 Jul 2025 13:44:47 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.41.196])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Jul 2025 13:44:47 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, dlemoal@kernel.org, yukuai1@huaweicloud.com, hare@suse.de,
        ming.lei@redhat.com, axboe@kernel.dk, johannes.thumshirn@wdc.com,
        gjoyce@ibm.com
Subject: [PATCHv3 1/2] lib/sbitmap: fix kernel crash observed when sbitmap depth is zero
Date: Wed, 23 Jul 2025 19:13:54 +0530
Message-ID: <20250723134442.1283664-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723134442.1283664-1-nilay@linux.ibm.com>
References: <20250723134442.1283664-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNyBTYWx0ZWRfXw4Cmyts+URbR
 8XrNkxIbMLilc4qBkTwkxxsTZMFD6HgMR/Je9WkpOhxOgl5iIkvkj6M+mJMRXeVpiqDuw5DUkmo
 u4zqgqKReQT2DzTXkm5vOn+g04nd8UNi1Dl9BpTusefPAmNFeGzqtb9O6A297NiJtoRrw67S3yl
 CvToHJGxrwc6IM0rtGWUor91hHRvhsDEOn6QAfm35lD9XkPbdb1MBgKglDhCIJHaoxFJ9UCv3Qd
 oPrkHIYiZsSfHaAa1W/XnSDKE1vTr+A/WPFnTHYHvaaMuimge7hcn2LLN+sU/OvfmLf25UtuSn8
 hx/QcLCu9yIv4KijrTzVUxFj/fbFit/4TOzKKCcepuAu+llZOpGfdh0RW9gfcAPZJQdMgBXm0aO
 SoGOobKtChZhiAtqiXZHA3Mkyv79JejoT2fx0As/oG4tKsxNM/cfXrkg+xX0WHJeiCVGbsIE
X-Proofpoint-ORIG-GUID: tXscNBYCotcz797X2HURRWacBthEPN4A
X-Proofpoint-GUID: tXscNBYCotcz797X2HURRWacBthEPN4A
X-Authority-Analysis: v=2.4 cv=TtbmhCXh c=1 sm=1 tr=0 ts=6880e754 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ROuT8l1ZTOG_tuEbkxEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=529 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230117

We observed a kernel crash when the I/O scheduler allocates an sbitmap
for a hardware queue (hctx) that has no associated software queues (ctx),
and later attempts to free it. When no software queues are mapped to a
hardware queue, the sbitmap is initialized with a depth of zero. In such
cases, the sbitmap_init_node() function should set sb->alloc_hint to NULL.
However, if this is not done, sb->alloc_hint may contain garbage, and
calling sbitmap_free() will pass this invalid pointer to free_percpu(),
resulting in a kernel crash.

Example crash trace:
==================================================================
Kernel attempted to read user page (28) - exploit attempt? (uid: 0)
BUG: Kernel NULL pointer dereference on read at 0x00000028
Faulting instruction address: 0xc000000000708f88
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA pSeries
[...]
CPU: 5 UID: 0 PID: 5491 Comm: mk_nullb_shared Kdump: loaded Tainted: G    B               6.16.0-rc5+ #294 VOLUNTARY
Tainted: [B]=BAD_PAGE
Hardware name: IBM,9043-MRX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_028) hv:phyp pSeries
[...]
NIP [c000000000708f88] free_percpu+0x144/0xba8
LR [c000000000708f84] free_percpu+0x140/0xba8
Call Trace:
    free_percpu+0x140/0xba8 (unreliable)
    kyber_exit_hctx+0x94/0x124
    blk_mq_exit_sched+0xe4/0x214
    elevator_exit+0xa8/0xf4
    elevator_switch+0x3b8/0x5d8
    elv_update_nr_hw_queues+0x14c/0x300
    blk_mq_update_nr_hw_queues+0x5cc/0x670
    nullb_update_nr_hw_queues+0x118/0x1f8 [null_blk]
    nullb_device_submit_queues_store+0xac/0x170 [null_blk]
    configfs_write_iter+0x1dc/0x2d0
    vfs_write+0x5b0/0x77c
    ksys_write+0xa0/0x180
    system_call_exception+0x1b0/0x4f0
    system_call_vectored_common+0x15c/0x2ec

If the sbitmap depth is zero, sb->alloc_hint memory is NOT allocated, but
the pointer is not explicitly set to NULL. Later, during sbitmap_free(),
the kernel attempts to free sb->alloc_hint, which is a per cpu pointer
variable, regardless of whether it was valid, leading to a crash.

This patch ensures that sb->alloc_hint is explicitly set to NULL in
sbitmap_init_node() when the requested depth is zero. This prevents
free_percpu() from freeing sb->alloc_hint and thus avoids the observed
crash.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 lib/sbitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index d3412984170c..aa8b6ca76169 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -119,6 +119,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 
 	if (depth == 0) {
 		sb->map = NULL;
+		sb->alloc_hint = NULL;
 		return 0;
 	}
 
-- 
2.50.1

