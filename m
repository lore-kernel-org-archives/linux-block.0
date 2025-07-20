Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69370182B4
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753011383; cv=none; b=cTSKBnW/ihggiAwDNyrC26v5GQVsDdaRboXt4fQmztLhOKnsHVBeaovGL2frOaT9SsRzOfeZp/yOR4xPxuGdmQqEOMphnSZIk+HOt7TCgqbN9lKVDX7A39HKMOyxEH5V66klvUVVshhfToaupMnpI8+cnd+Ckj7gVwF9B9wo2S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753011383; c=relaxed/simple;
	bh=R5SWcV3AFiUqvrCvlhMDISCizwAJza8FyUxpQqKshj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdjytqqtTrU6zLnWi5SJUaaejB5KL/mW6cQD6yqnltI5zgNn8MtYZL3+Ejgz6Jre2hSTR99FQaCRqurAGhbBmVa/47LzebLO4vPk589ofSYxy3EKwUp+7YJI0vNocjuBIcWLNzSdGWeuqkzx2sD6d8FKGvpZY+Q1f29LyZheRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dUcZorqN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dUcZorqN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K9YQ5U005843;
	Sun, 20 Jul 2025 11:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4rRiY19RHjaOQ5GB9
	OH4IeUu6IepkwEeBRqb5k5xV3Y=; b=dUcZorqNGo2G8d5qgxGydnll5gfqq78DC
	se+EWAmUxzLIfDvbov+e4JjCY3dR/k+ruE6qtW6HYc446eEm6dT+JzrCkgffelNw
	abj2WxaTsvkXseMkJIXl4Z5tmoQm6bZRtjHMgJj2Yf1tpQpYmsiTAl9XHraq3KOa
	1tJQhXvCqNuEZquMx+nrczl3fiznn6MKrQhkxBbI2yTT4D79yRY5vukcwxYvHQSf
	z0Skl15bFbhpElGNTOeCUlgo1fGKFyuZ+k5/+7ZBHJOJ3fikm1qThrT7pS+Y8WsA
	1Ig5NzJmIszGYAE5cBkThvuopK4QN6v1CG9zGqRBo+PaNbEQTCW0g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v4845-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 11:36:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56K6QfhB014301;
	Sun, 20 Jul 2025 11:36:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480ppnsp6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 11:36:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KBa1ng25821648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 11:36:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEEA020043;
	Sun, 20 Jul 2025 11:36:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB87C20040;
	Sun, 20 Jul 2025 11:35:58 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.22.10])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 11:35:58 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
        dlemoal@kernel.org, johannes.thumshirn@wdc.com, gjoyce@ibm.com
Subject: [PATCH 1/2] lib/sbitmap: fix kernel crash observed when sbitmap depth is zero
Date: Sun, 20 Jul 2025 17:05:41 +0530
Message-ID: <20250720113553.913034-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720113553.913034-1-nilay@linux.ibm.com>
References: <20250720113553.913034-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QLdoRhLL c=1 sm=1 tr=0 ts=687cd4a5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=ROuT8l1ZTOG_tuEbkxEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDEwNyBTYWx0ZWRfX0M1+vdYAqLT8
 ofDnQc4y/iyrtRDULDAL+DcEm6JhLWykIOF42PTs2hIlA7pJXtcsA6vyVpOPXbDo8/OiukLTIz6
 ou007E4aQGgNUttFBXINJEgghtERXto6tcuHBP7fzWOJsD1ot+QDkaMqlOKhLgrSfbmhk0/mT+B
 Ode+ak1nFJjXdy+grU2v9OB+fTqwzPlcDNZdsR9iAHP8g8+jC6l5Z1LASUsFdFyyiSlssXhnsTF
 tCejFDvFWpCn5nG2NTEpT+2B7eTCxxKqeBppgLhIYhz7DW2KkCg/juSJnid8UIAYk370Lh3pDW3
 IlJ2ayM9QmoIxveryFMiYTt+lurHhfgBcaKhXuk2dr/4jlWvhxnmrMz7yLn3m0fNl/TGuQ8WZBo
 FuSqlSvVEhE0ANEpd18UGNSjiBwBa4+FaIdqwa6MyBjvcOzv3RKLH6F2rWENMvEzHX0paxUh
X-Proofpoint-ORIG-GUID: Cp6ZW11AZjUEjRu2e8E_-g0oM4X5F6vq
X-Proofpoint-GUID: Cp6ZW11AZjUEjRu2e8E_-g0oM4X5F6vq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=627 clxscore=1015
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200107

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

