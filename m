Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C453286D64
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106721; cv=none; b=EY2m0IIjgH5+VWJUR8NL4kVNtxC5BBX/lcl8tpq+IUfndhd41M3dXjoyYG5dFgzuvfY5ZqsrgS3g3NSNRQLi4Bv9f2B03r/uU9vJwQWoSqbNUcnh44a4p5TK71hVbldKbayUqk4iIscU56P/17Rbuf2xkq0kFyRoPFat4kwDpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106721; c=relaxed/simple;
	bh=8G/jbtxc/a+hCWlL52xrZaXySVIHMvuhnLKUb0RWsS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmHeKXLmfOgCePX1jPIkcmBqPIaV4hTQLX2VNrC6x1au6VMp7xF4X71KftDIjlZG80yEIs/prIcvjdWC+PvchLTUOsj4NcBpYmGqZViGXF2uPhdWJ7ym3AL4WI32etMmzY44oP8B3pf2f8rAl2DoW5Yw9fX/4w3YGQldLzsFB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AZdSFuJg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AZdSFuJg"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LCotlN004384;
	Mon, 21 Jul 2025 14:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4wg8/rVLaHOcbggAD
	7sISYXz+84PDhrHy0F7yQ+IZ2E=; b=AZdSFuJgMarczbyxFQ27tqfK9ssr4XZcJ
	BHaXfZnQf76sAqOS+bc08r6uEgtoTCnHs21uceAZBsSmYV3wr/ppRXcu9n+SnotE
	BoJPTKk0ycinUWza2Hl/WL6GVAH023rOdv0QN8ZEEMN5nrt966/cum6TfI5Bs4P/
	6xyraqqFijIHKVWtrbO6tK8bOLcFXTEosn97SZI41jK8Bc0jc6HD/xg0q14tlmpL
	1jRvFOvL3sdi2lJOoxMOonZR50D/WehdJozbLfw8BXUBlwwKu5/p3/jRWIdTm3R3
	U9vbyH8xwvDge1xrPLDAP64/Kz45A/4r2r6hjRGoe/L0oSM6oGf6A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfs0a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 14:05:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LDZbor024697;
	Mon, 21 Jul 2025 14:05:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 480rd2670k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 14:05:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56LE58Cg50528560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 14:05:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6540020043;
	Mon, 21 Jul 2025 14:05:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72BD920040;
	Mon, 21 Jul 2025 14:05:05 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.127.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Jul 2025 14:05:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, dlemoal@kernel.org, hare@suse.de, ming.lei@redhat.com,
        axboe@kernel.dk, johannes.thumshirn@wdc.com, gjoyce@ibm.com
Subject: [PATCHv2 1/2] lib/sbitmap: fix kernel crash observed when sbitmap depth is zero
Date: Mon, 21 Jul 2025 19:34:41 +0530
Message-ID: <20250721140450.1030511-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721140450.1030511-1-nilay@linux.ibm.com>
References: <20250721140450.1030511-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEyMSBTYWx0ZWRfXz+wyKaibNT7y
 8Xh70UZZuHR7I41PolZdfLcJ1oGNLcMpXdj6/aWQfBzTv3eoS9oduTzqQ+yZ2fHZyOFTxY2qc5K
 HHjxiT7qVtT1BrUWMMLKYUnfuEUkyMGR++onbEofB4ttMMPcKjyywM8wjpkGVNY0KPzCLeMawOs
 VcnsKho5rbXUmun3U8Rxs/7QQbXFDwLtqRm4luXkDIbGOugrmksW4px/wzFMrcPF544o6pRvxmn
 cXTyzhMg4HqyH0eTQzey3WUyYibJZVDOr796iquvnevbjaD+RnRbE+8x1ZPFmonKry771Kv1wev
 PF7JufOW7O/D8ekw7qj9Z3fpLZmmQQpKSOuzdrgHXLai4Y8DNSE9Mkrcq9SEJEb2dur6Tn5jR5l
 uDSKwwyjj7dN26+/ymrlPZAgvds9L3TUmk+0ndLBYVgNSCWDyuYcjQWXIaFl14OiwJ7yIcvg
X-Proofpoint-GUID: IIqscvgSmUko4EqO37xadg_jC6c3ti7p
X-Proofpoint-ORIG-GUID: IIqscvgSmUko4EqO37xadg_jC6c3ti7p
X-Authority-Analysis: v=2.4 cv=X9RSKHTe c=1 sm=1 tr=0 ts=687e4917 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ROuT8l1ZTOG_tuEbkxEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=530 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210121

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

